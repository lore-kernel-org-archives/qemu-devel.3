Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C18606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NDRDed6M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT568-0004Pn-Nb; Mon, 16 Nov 2026 17:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55f-0003qD-GP
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55d-00060R-TS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794867737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2RTT9OhXWlO06O16waEB/faPkc7oinoT82MHMZ9rNI=;
 b=NDRDed6M7Lo2nuzzNnQ5OBoCVngI5RDnbSqiBsUo2R3kExn2W7IoHDlpOFQah0iW+5/XoC
 RE//lHREiOcs9AUx+jWazyv9eDrpz5zMVY3gKcCURsE7RhYMH/ByHu/C8OXYNwOYI83p6K
 B7154CiK1e0VXBv0sdMCR35yR4tufcU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-46pRv7s1PIOI4brQWbkQAA-1; Mon,
 16 Nov 2026 17:22:15 -0500
X-MC-Unique: 46pRv7s1PIOI4brQWbkQAA-1
X-Mimecast-MFC-AGG-ID: 46pRv7s1PIOI4brQWbkQAA_1794867735
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E171B1800545
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:22:14 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A20113001DA7; Mon, 16 Nov 2026 22:22:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 09/26] hw/watchdog: mark some watchdog devices as secure
Date: Mon, 16 Nov 2026 22:21:41 +0000
Message-ID: <20261116222158.2840471-10-berrange@redhat.com>
In-Reply-To: <20261116222158.2840471-1-berrange@redhat.com>
References: <20261116222158.2840471-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


