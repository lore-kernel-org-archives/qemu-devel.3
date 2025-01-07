Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDE9E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBb3-0003D7-Gs; Tue, 07 Jan 2025 10:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBb1-0003C9-ID
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBb0-00056Q-4W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736264057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMgawXtrIVlaeM7Nd+w2ae5y0ULXzvEM2qhvmTnjdk4=;
 b=jTxRSHUgmCmpDz5GVav+SIRkmGOrolqXr6hQi+mmBBIocieWuCMuaNUrA/TFZYOlNlWQRo
 ATWG4v/dKtoSeS1oU0o17bsAGfGWzoGnsGqTxHeuQK8G3W98nrw9pTB69W0Rjempn6sQ9E
 f3TmcYmf9AyNzq3MM2XU97OWYGO1orc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-mtrcTVuGOe6ALPwc18U5qw-1; Tue,
 07 Jan 2025 10:34:14 -0500
X-MC-Unique: mtrcTVuGOe6ALPwc18U5qw-1
X-Mimecast-MFC-AGG-ID: mtrcTVuGOe6ALPwc18U5qw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 339C91955DC3; Tue,  7 Jan 2025 15:34:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.66])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D37F11956088; Tue,  7 Jan 2025 15:34:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2825618003B7; Tue, 07 Jan 2025 16:33:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, graf@amazon.com,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 11/21] hw/uefi: add var-service-pkcs7-stub.c
Date: Tue,  7 Jan 2025 16:33:38 +0100
Message-ID: <20250107153353.1144978-12-kraxel@redhat.com>
In-Reply-To: <20250107153353.1144978-1-kraxel@redhat.com>
References: <20250107153353.1144978-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

pkcs7 stub which is used in case gnutls is not available.

It throws EFI_WRITE_PROTECTED errors unconditionally, so all
authenticated variables are readonly for the guest.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-pkcs7-stub.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 hw/uefi/var-service-pkcs7-stub.c

diff --git a/hw/uefi/var-service-pkcs7-stub.c b/hw/uefi/var-service-pkcs7-stub.c
new file mode 100644
index 000000000000..118cba446d4b
--- /dev/null
+++ b/hw/uefi/var-service-pkcs7-stub.c
@@ -0,0 +1,16 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - pkcs7 stubs
+ */
+#include "qemu/osdep.h"
+#include "system/dma.h"
+
+#include "hw/uefi/var-service.h"
+
+efi_status uefi_vars_check_pkcs7_2(uefi_variable *siglist,
+                                   void **digest, uint32_t *digest_size,
+                                   mm_variable_access *va, void *data)
+{
+    return EFI_WRITE_PROTECTED;
+}
-- 
2.47.1


