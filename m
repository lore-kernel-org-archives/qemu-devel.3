Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F7BC88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52TQ-0000Oa-OA; Fri, 11 Sep 2026 10:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NM-0002iJ-Io
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NA-0007yX-GE
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkE3LclKvU9GiqQKtRj7Fj+wyH19sYMsxkpF53QZWX4=;
 b=cpxhf7gfgXFn4Efkb16ajdue9XumKN0DeDqBM7z0/IUDEVHiNkIZT4BCHUj5a4w+ozzJv+
 h7Ar42Qi7M8dbK/I2Upf61phujUWvAt63Pt1rzQ9AtEOADc+ItEK+dH03ByUBfGjPbZM+E
 1grfwVLgoRiEA7oqrN4h3CDA57ZIpN4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-wrbZ1KXtOUmB-87brWnyCw-1; Fri,
 11 Sep 2026 10:36:56 -0400
X-MC-Unique: wrbZ1KXtOUmB-87brWnyCw-1
X-Mimecast-MFC-AGG-ID: wrbZ1KXtOUmB-87brWnyCw_1789137415
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FA881955BF8; Fri, 11 Sep 2026 14:36:55 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5989F3000229; Fri, 11 Sep 2026 14:36:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 11/28] hw/watchdog: mark some watchdog devices as secure
Date: Fri, 11 Sep 2026 15:36:10 +0100
Message-ID: <20260911143627.2743803-12-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The ib700, i6300esb, gwdt, spapr and diag288 watchdog devices are marked
as secure since they have traditionally been, or are intended to be,
used in virtualization use cases on x86, arm, ppc and s390x architectures
respectively. Other watchdogs are primarily for emulation.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c      | 1 +
 hw/watchdog/spapr_watchdog.c | 1 +
 hw/watchdog/wdt_diag288.c    | 1 +
 hw/watchdog/wdt_i6300esb.c   | 1 +
 hw/watchdog/wdt_ib700.c      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 330a74798a..8a05b02c4f 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -307,6 +307,7 @@ static const TypeInfo wdt_sbsa_gwdt_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .name  = TYPE_WDT_SBSA,
     .instance_size  = sizeof(SBSA_GWDTState),
+    .secure = true,
 };
 
 static void wdt_sbsa_gwdt_register_types(void)
diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
index 5a72896066..0e45e9b4a6 100644
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
index 1275353e8e..85e4f56e1d 100644
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
index 3aa01b8d68..05aa20fab1 100644
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
index 51a26a4cbb..8bf2b2fbf9 100644
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
2.55.0


