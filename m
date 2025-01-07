Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E00FE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBau-00037h-QN; Tue, 07 Jan 2025 10:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBas-000371-QK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBar-00053z-BA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736264048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMh2MHEoYzUlPfGL+abayuLPOSHs7NHuPxqf2cRo2cY=;
 b=Tus80WjTbaNkF385S4IJXmY/c6e871iTGVf/uhwBN3DvGyizK4bwxvBkFnLjkmbVd9tsAi
 Tb2dsKdlxY7rcrBug99Zti+rNpm/0eCjo7XcP5XfiZPuw09gGqo9ricZsRA4xsKRcea8CJ
 ZoBuKHbgjJGwjZtn0V1HgHw+6H6Cisg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-Q0XGpCrUPnqr89uRtxplow-1; Tue,
 07 Jan 2025 10:34:04 -0500
X-MC-Unique: Q0XGpCrUPnqr89uRtxplow-1
X-Mimecast-MFC-AGG-ID: Q0XGpCrUPnqr89uRtxplow
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 151F71956069; Tue,  7 Jan 2025 15:34:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.66])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C02F919560A2; Tue,  7 Jan 2025 15:34:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A853B18003A6; Tue, 07 Jan 2025 16:33:53 +0100 (CET)
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
Subject: [PATCH v2 04/21] hw/uefi: add var-service-guid.c
Date: Tue,  7 Jan 2025 16:33:31 +0100
Message-ID: <20250107153353.1144978-5-kraxel@redhat.com>
In-Reply-To: <20250107153353.1144978-1-kraxel@redhat.com>
References: <20250107153353.1144978-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add variables for a bunch of UEFI GUIDs we will need.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-guid.c | 99 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 hw/uefi/var-service-guid.c

diff --git a/hw/uefi/var-service-guid.c b/hw/uefi/var-service-guid.c
new file mode 100644
index 000000000000..eba3655c8d30
--- /dev/null
+++ b/hw/uefi/var-service-guid.c
@@ -0,0 +1,99 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - GUIDs
+ */
+
+#include "qemu/osdep.h"
+#include "system/dma.h"
+
+#include "hw/uefi/var-service.h"
+
+/* variable namespaces */
+
+const QemuUUID EfiGlobalVariable = {
+    .data = UUID_LE(0x8be4df61, 0x93ca, 0x11d2, 0xaa, 0x0d,
+                    0x00, 0xe0, 0x98, 0x03, 0x2b, 0x8c)
+};
+
+const QemuUUID EfiImageSecurityDatabase = {
+    .data = UUID_LE(0xd719b2cb, 0x3d3a, 0x4596, 0xa3, 0xbc,
+                    0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
+};
+
+const QemuUUID EfiCustomModeEnable = {
+    .data = UUID_LE(0xc076ec0c, 0x7028, 0x4399, 0xa0, 0x72,
+                    0x71, 0xee, 0x5c, 0x44, 0x8b, 0x9f)
+};
+
+const QemuUUID EfiSecureBootEnableDisable = {
+    .data = UUID_LE(0xf0a30bc7, 0xaf08, 0x4556, 0x99, 0xc4,
+                    0x0, 0x10, 0x9, 0xc9, 0x3a, 0x44)
+};
+
+/* signatures */
+
+const QemuUUID EfiCertSha256Guid = {
+    .data = UUID_LE(0xc1c41626, 0x504c, 0x4092, 0xac, 0xa9,
+                    0x41, 0xf9, 0x36, 0x93, 0x43, 0x28)
+};
+
+const QemuUUID EfiCertSha384Guid = {
+    .data = UUID_LE(0xff3e5307, 0x9fd0, 0x48c9, 0x85, 0xf1,
+                    0x8a, 0xd5, 0x6c, 0x70, 0x1e, 0x1)
+};
+
+const QemuUUID EfiCertSha512Guid = {
+    .data = UUID_LE(0x93e0fae, 0xa6c4, 0x4f50, 0x9f, 0x1b,
+                    0xd4, 0x1e, 0x2b, 0x89, 0xc1, 0x9a)
+};
+
+const QemuUUID EfiCertRsa2048Guid = {
+    .data = UUID_LE(0x3c5766e8, 0x269c, 0x4e34, 0xaa, 0x14,
+                    0xed, 0x77, 0x6e, 0x85, 0xb3, 0xb6)
+};
+
+const QemuUUID EfiCertX509Guid = {
+    .data = UUID_LE(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5,
+                    0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
+};
+
+const QemuUUID EfiCertTypePkcs7Guid = {
+    .data = UUID_LE(0x4aafd29d, 0x68df, 0x49ee, 0x8a, 0xa9,
+                    0x34, 0x7d, 0x37, 0x56, 0x65, 0xa7)
+};
+
+/*
+ * mm_header.guid values that the guest DXE/BDS phases use for
+ * sending requests to management mode
+ */
+
+const QemuUUID EfiSmmVariableProtocolGuid = {
+    .data = UUID_LE(0xed32d533, 0x99e6, 0x4209, 0x9c, 0xc0,
+                    0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
+};
+
+const QemuUUID VarCheckPolicyLibMmiHandlerGuid = {
+    .data = UUID_LE(0xda1b0d11, 0xd1a7, 0x46c4, 0x9d, 0xc9,
+                    0xf3, 0x71, 0x48, 0x75, 0xc6, 0xeb)
+};
+
+/*
+ * mm_header.guid values that the guest DXE/BDS phases use for
+ * reporting event groups being signaled to management mode
+ */
+
+const QemuUUID EfiEndOfDxeEventGroupGuid = {
+    .data = UUID_LE(0x02ce967a, 0xdd7e, 0x4FFc, 0x9e, 0xe7,
+                    0x81, 0x0c, 0xF0, 0x47, 0x08, 0x80)
+};
+
+const QemuUUID EfiEventReadyToBootGuid = {
+    .data = UUID_LE(0x7ce88Fb3, 0x4bd7, 0x4679, 0x87, 0xa8,
+                    0xa8, 0xd8, 0xde, 0xe5, 0x0d, 0x2b)
+};
+
+const QemuUUID EfiEventExitBootServicesGuid = {
+    .data = UUID_LE(0x27abF055, 0xb1b8, 0x4c26, 0x80, 0x48,
+                    0x74, 0x8F, 0x37, 0xba, 0xa2, 0xdF)
+};
-- 
2.47.1


