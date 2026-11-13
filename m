Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C1606CC86
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dw769eL5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFe-0007cY-SQ; Fri, 13 Nov 2026 13:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwF7-0007DJ-1N
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwF4-0005Oj-6Z
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2RTT9OhXWlO06O16waEB/faPkc7oinoT82MHMZ9rNI=;
 b=dw769eL5LLe4pgK+Q0SKPSS+PWf7RWKl+a99AOZSY9VvJOwsnz0gWWu3+iOA9ny7njAZJx
 OTiX5d+rGIOQSLFtcEbBS/q8fMLfnSuxNXOu+6D9NBftbctDFQvCQS/zh4cGxOmhTUBh39
 i0uHUpuvmST9HAdVoUxiJ7dMctu/xEQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-dq-ap2xmMDK7iv1xgRkGzQ-1; Fri,
 13 Nov 2026 13:43:15 -0500
X-MC-Unique: dq-ap2xmMDK7iv1xgRkGzQ-1
X-Mimecast-MFC-AGG-ID: dq-ap2xmMDK7iv1xgRkGzQ_1794595394
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 423A51956089
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:14 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CD2F1955DB9; Fri, 13 Nov 2026 18:43:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 09/26] hw/watchdog: mark some watchdog devices as secure
Date: Fri, 13 Nov 2026 18:42:37 +0000
Message-ID: <20261113184254.2524253-10-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ib700, i6300esb, gwdt, spapr and diag288 watchdog devices are marked
as secure since they have traditionally been, or are intended to be,
used in virtualization use cases on x86, arm, ppc and s390x architectures
respectively. Other watchdogs are primarily for emulation.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com> #diag288
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c      | 1 +
 hw/watchdog/spapr_watchdog.c | 1 +
 hw/watchdog/wdt_diag288.c    | 1 +
 hw/watchdog/wdt_i6300esb.c   | 1 +
 hw/watchdog/wdt_ib700.c      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 1834dc8db83..671eb26365f 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -340,6 +340,7 @@ static const TypeInfo wdt_sbsa_gwdt_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .name  = TYPE_WDT_SBSA,
     .instance_size  = sizeof(SBSA_GWDTState),
+    .secure = true,
 };
 
 static void wdt_sbsa_gwdt_register_types(void)
diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
index 5a72896066e..0e45e9b4a6a 100644
--- a/hw/watchdog/spapr_watchdog.c
+++ b/hw/watchdog/spapr_watchdog.c
@@ -269,6 +269,7 @@ static const TypeInfo spapr_wdt_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(SpaprWatchdog),
     .class_init    = spapr_wdt_class_init,
+    .secure        = true,
 };
 
 static void spapr_watchdog_register_types(void)
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 1275353e8e5..85e4f56e1db 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -129,6 +129,7 @@ static const TypeInfo wdt_diag288_info = {
     .name  = TYPE_WDT_DIAG288,
     .instance_size  = sizeof(DIAG288State),
     .class_size = sizeof(DIAG288Class),
+    .secure = true,
 };
 
 static void wdt_diag288_register_types(void)
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 3aa01b8d68f..05aa20fab13 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -480,6 +480,7 @@ static const TypeInfo i6300esb_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(I6300State),
     .class_init    = i6300esb_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/watchdog/wdt_ib700.c b/hw/watchdog/wdt_ib700.c
index 51a26a4cbbc..8bf2b2fbf90 100644
--- a/hw/watchdog/wdt_ib700.c
+++ b/hw/watchdog/wdt_ib700.c
@@ -144,6 +144,7 @@ static const TypeInfo wdt_ib700_info = {
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(IB700State),
     .class_init    = wdt_ib700_class_init,
+    .secure        = true,
 };
 
 static void wdt_ib700_register_types(void)
-- 
2.56.1


