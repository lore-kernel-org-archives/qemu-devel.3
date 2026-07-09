Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A513C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmDD-0004WY-MC; Thu, 09 Jul 2026 06:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1whmDB-0004Vb-2i
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1whmD9-0001Y6-Lg
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783593750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hy2YLW/gLMo797VszhQ6PHzzCHyjlqdKcsagTuGlT/4=;
 b=JDlWvavCOYfnqqi0ScUROjfcNpXOVrbd3TJj19RPHDRa8FrVk6mKlzfUEmvPSKmyTG3Egj
 qVJegsjphk6P8i2A/AQu7tkYJZs9TitE3QNaolD+OczrcniusUYGqcd2+BaVRxhLHY4fqU
 5Nj7HJXlIhOhVkVEz81OD7UryWsxMW4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-irbR4CAXMZi5xb80xHBtjg-1; Thu,
 09 Jul 2026 06:42:27 -0400
X-MC-Unique: irbR4CAXMZi5xb80xHBtjg-1
X-Mimecast-MFC-AGG-ID: irbR4CAXMZi5xb80xHBtjg_1783593746
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74C671800609; Thu,  9 Jul 2026 10:42:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.140])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E89A195419E; Thu,  9 Jul 2026 10:42:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 50FF8180101C; Thu, 09 Jul 2026 12:42:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: mcascell@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 peter.maydell@linaro.org
Subject: [PATCH v3 3/5] hw/uefi: check lower limit for signature list size
Date: Thu,  9 Jul 2026 12:42:18 +0200
Message-ID: <20260709104223.143594-4-kraxel@redhat.com>
In-Reply-To: <20260709104223.143594-1-kraxel@redhat.com>
References: <20260709104223.143594-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Specifically disallow zero which can lead to an endless loop.

Fixes: CVE-2026-61406
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3899
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-siglist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/uefi/var-service-siglist.c b/hw/uefi/var-service-siglist.c
index 8948f1b78471..9e03a4dc0c28 100644
--- a/hw/uefi/var-service-siglist.c
+++ b/hw/uefi/var-service-siglist.c
@@ -94,6 +94,9 @@ void uefi_vars_siglist_parse(uefi_vars_siglist *siglist,
             break;
         }
         efilist = data;
+        if (efilist->siglist_size < sizeof(*efilist)) {
+            break;
+        }
         if (size < efilist->siglist_size) {
             break;
         }
-- 
2.55.0


