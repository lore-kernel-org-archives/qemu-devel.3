Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E663ACAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v293v-0007GY-RT; Fri, 26 Sep 2025 10:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293o-00077t-0e
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293i-0004w0-B3
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pN5Hq/3s/aeMb+TGMhmoDkcR4DT+9NwqjpCU9eY7lhM=;
 b=E9/g+MLZNdw9N8P1cFa0O73OPOvoKnT6YaBEYMCMOTD/tvJPmRyELc2COwbA7ItBg5NNLB
 6qdTRbySXZSJgbjkx07zJ5CU0++T6MoyXSnpjel8TTpGdgKDsyLtxVftR7YOA1A9uTdsvn
 MRF+MmwNLZ6io6d25znvECMWFEJLsDw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-_4crnoFeP56zFJzCFpURAQ-1; Fri,
 26 Sep 2025 10:04:14 -0400
X-MC-Unique: _4crnoFeP56zFJzCFpURAQ-1
X-Mimecast-MFC-AGG-ID: _4crnoFeP56zFJzCFpURAQ_1758895452
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66386180029B; Fri, 26 Sep 2025 14:04:12 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E738B195419F; Fri, 26 Sep 2025 14:04:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 26/32] hw/watchdog: mark some watchdog devices as secure
Date: Fri, 26 Sep 2025 15:01:37 +0100
Message-ID: <20250926140144.1998694-27-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The ib700, i6300esb and spapr watchdog devices are marked as secure
since they have traditionally been used in virtualization use cases.
Other watchdogs are primarily for emulation.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/watchdog/allwinner-wdt.c      | 3 +++
 hw/watchdog/cmsdk-apb-watchdog.c | 1 +
 hw/watchdog/sbsa_gwdt.c          | 1 +
 hw/watchdog/spapr_watchdog.c     | 1 +
 hw/watchdog/wdt_aspeed.c         | 6 ++++++
 hw/watchdog/wdt_diag288.c        | 1 +
 hw/watchdog/wdt_i6300esb.c       | 1 +
 hw/watchdog/wdt_ib700.c          | 1 +
 hw/watchdog/wdt_imx2.c           | 1 +
 9 files changed, 16 insertions(+)

diff --git a/hw/watchdog/allwinner-wdt.c b/hw/watchdog/allwinner-wdt.c
index 8fcd776675..2e4aa710ca 100644
--- a/hw/watchdog/allwinner-wdt.c
+++ b/hw/watchdog/allwinner-wdt.c
@@ -392,18 +392,21 @@ static const TypeInfo allwinner_wdt_info = {
     .class_init    = allwinner_wdt_class_init,
     .class_size    = sizeof(AwWdtClass),
     .abstract      = true,
+    .secure        = false,
 };
 
 static const TypeInfo allwinner_wdt_sun4i_info = {
     .name          = TYPE_AW_WDT_SUN4I,
     .parent        = TYPE_AW_WDT,
     .class_init    = allwinner_wdt_sun4i_class_init,
+    .secure        = false,
 };
 
 static const TypeInfo allwinner_wdt_sun6i_info = {
     .name          = TYPE_AW_WDT_SUN6I,
     .parent        = TYPE_AW_WDT,
     .class_init    = allwinner_wdt_sun6i_class_init,
+    .secure        = false,
 };
 
 static void allwinner_wdt_register(void)
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 6a8d07ca56..7f993903c2 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -409,6 +409,7 @@ static const TypeInfo cmsdk_apb_watchdog_info = {
     .instance_size = sizeof(CMSDKAPBWatchdog),
     .instance_init = cmsdk_apb_watchdog_init,
     .class_init = cmsdk_apb_watchdog_class_init,
+    .secure = false,
 };
 
 static void luminary_watchdog_init(Object *obj)
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index ce84849df0..1113f93a7b 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -289,6 +289,7 @@ static const TypeInfo wdt_sbsa_gwdt_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .name  = TYPE_WDT_SBSA,
     .instance_size  = sizeof(SBSA_GWDTState),
+    .secure = false,
 };
 
 static void wdt_sbsa_gwdt_register_types(void)
diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
index 5b3f50de3a..2c3fa54c55 100644
--- a/hw/watchdog/spapr_watchdog.c
+++ b/hw/watchdog/spapr_watchdog.c
@@ -263,6 +263,7 @@ static const TypeInfo spapr_wdt_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(SpaprWatchdog),
     .class_init    = spapr_wdt_class_init,
+    .secure        = true,
 };
 
 static void spapr_watchdog_register_types(void)
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 30226435ef..58545e1560 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -327,6 +327,7 @@ static const TypeInfo aspeed_wdt_info = {
     .class_init = aspeed_wdt_class_init,
     .class_size    = sizeof(AspeedWDTClass),
     .abstract      = true,
+    .secure        = false,
 };
 
 static void aspeed_2400_wdt_class_init(ObjectClass *klass, const void *data)
@@ -349,6 +350,7 @@ static const TypeInfo aspeed_2400_wdt_info = {
     .parent = TYPE_ASPEED_WDT,
     .instance_size = sizeof(AspeedWDTState),
     .class_init = aspeed_2400_wdt_class_init,
+    .secure = false,
 };
 
 static void aspeed_2500_wdt_reset_pulse(AspeedWDTState *s, uint32_t property)
@@ -387,6 +389,7 @@ static const TypeInfo aspeed_2500_wdt_info = {
     .parent = TYPE_ASPEED_WDT,
     .instance_size = sizeof(AspeedWDTState),
     .class_init = aspeed_2500_wdt_class_init,
+    .secure = false,
 };
 
 static void aspeed_2600_wdt_class_init(ObjectClass *klass, const void *data)
@@ -410,6 +413,7 @@ static const TypeInfo aspeed_2600_wdt_info = {
     .parent = TYPE_ASPEED_WDT,
     .instance_size = sizeof(AspeedWDTState),
     .class_init = aspeed_2600_wdt_class_init,
+    .secure = false,
 };
 
 static void aspeed_1030_wdt_class_init(ObjectClass *klass, const void *data)
@@ -433,6 +437,7 @@ static const TypeInfo aspeed_1030_wdt_info = {
     .parent = TYPE_ASPEED_WDT,
     .instance_size = sizeof(AspeedWDTState),
     .class_init = aspeed_1030_wdt_class_init,
+    .secure = false,
 };
 
 static void aspeed_2700_wdt_class_init(ObjectClass *klass, const void *data)
@@ -456,6 +461,7 @@ static const TypeInfo aspeed_2700_wdt_info = {
     .parent = TYPE_ASPEED_WDT,
     .instance_size = sizeof(AspeedWDTState),
     .class_init = aspeed_2700_wdt_class_init,
+    .secure = false,
 };
 
 static void wdt_aspeed_register_types(void)
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 1275353e8e..ec41a92337 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -129,6 +129,7 @@ static const TypeInfo wdt_diag288_info = {
     .name  = TYPE_WDT_DIAG288,
     .instance_size  = sizeof(DIAG288State),
     .class_size = sizeof(DIAG288Class),
+    .secure = false,
 };
 
 static void wdt_diag288_register_types(void)
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index bb8a2766b6..363c36a9b5 100644
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
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 10151a15d0..9ecb69f38b 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -303,6 +303,7 @@ static const TypeInfo imx2_wdt_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(IMX2WdtState),
     .class_init    = imx2_wdt_class_init,
+    .secure        = false,
 };
 
 static void imx2_wdt_register_type(void)
-- 
2.50.1


