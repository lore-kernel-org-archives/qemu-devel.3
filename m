Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081CAC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPBP-0005X5-5r; Mon, 12 May 2025 05:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uEPBJ-0005Tl-BE; Mon, 12 May 2025 05:10:41 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uEPBF-00056F-6Y; Mon, 12 May 2025 05:10:39 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 12 May
 2025 17:10:15 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 12 May 2025 17:10:15 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v4 3/3] hw/arm: Integrate ASPEED OTP memory into AST10x0 and
 AST2600 SoCs
Date: Mon, 12 May 2025 17:10:13 +0800
Message-ID: <20250512091014.3454083-4-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512091014.3454083-1-kane_chen@aspeedtech.com>
References: <20250512091014.3454083-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Expose an "otpmem" machine parameter to load an external OTP memory image
and enable OTP functionality in supported SoCs.

- Adds object property and backend connection logic for AST1030 and AST2600
- Allows disabling OTP feature via has_otpmem attribute
- Supports use cases involving preconfigured OTP content for boot-time behavior

To create a default OTP memory image with programmable and unprogrammable
bit patterns, run the following:

```bash
for i in $(seq 1 2048); do
  printf '\x00\x00\x00\x00\xff\xff\xff\xff'
done > otpmem.img
```

Use the otpmem parameter to load this into the guest:
```
./qemu-system-arm \
  -machine ast2600-evb,otpmem=otpmem.img \
  ...
```

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 hw/arm/aspeed.c              | 20 ++++++++++++++++++++
 hw/arm/aspeed_ast10x0.c      |  2 +-
 hw/arm/aspeed_ast2600.c      |  2 +-
 hw/misc/aspeed_sbc.c         | 18 ++++++++++++++++++
 include/hw/misc/aspeed_sbc.h |  1 +
 5 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index d0b333646e..18e512e83b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -47,6 +47,7 @@ struct AspeedMachineState {
     uint32_t uart_chosen;
     char *fmc_model;
     char *spi_model;
+    char *otpmem;
     uint32_t hw_strap1;
 };
 
@@ -1199,6 +1200,21 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
     bmc->uart_chosen = val + ASPEED_DEV_UART0;
 }
 
+static char *aspeed_get_otpmem(Object *obj, Error **errp)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
+
+    return g_strdup(bmc->otpmem);
+}
+
+static void aspeed_set_otpmem(Object *obj, const char *value, Error **errp)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
+
+    g_free(bmc->otpmem);
+    bmc->otpmem = g_strdup(value);
+}
+
 static void aspeed_machine_class_props_init(ObjectClass *oc)
 {
     object_class_property_add_bool(oc, "execute-in-place",
@@ -1220,6 +1236,10 @@ static void aspeed_machine_class_props_init(ObjectClass *oc)
                                    aspeed_set_spi_model);
     object_class_property_set_description(oc, "spi-model",
                                           "Change the SPI Flash model");
+    object_class_property_add_str(oc, "otpmem", aspeed_get_otpmem,
+                                   aspeed_set_otpmem);
+    object_class_property_set_description(oc, "otpmem",
+                                          "Set OTP Memory type");
 }
 
 static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index e6e1ee63c1..c446e70b24 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -154,7 +154,7 @@ static void aspeed_soc_ast1030_init(Object *obj)
 
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 
-    object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_SBC);
+    object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST10X0_SBC);
 
     for (i = 0; i < sc->wdts_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index d12707f0ab..59ffd41a4a 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -261,7 +261,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
 
     object_initialize_child(obj, "i3c", &s->i3c, TYPE_ASPEED_I3C);
 
-    object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_SBC);
+    object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST2600_SBC);
 
     object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "video", &s->video, TYPE_UNIMPLEMENTED_DEVICE);
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 237a8499d9..2ff736bbf5 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -341,8 +341,10 @@ static const TypeInfo aspeed_sbc_info = {
 static void aspeed_ast2600_sbc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSBCClass *sc = ASPEED_SBC_CLASS(klass);
 
     dc->desc = "AST2600 Secure Boot Controller";
+    sc->has_otpmem = true;
 }
 
 static const TypeInfo aspeed_ast2600_sbc_info = {
@@ -351,9 +353,25 @@ static const TypeInfo aspeed_ast2600_sbc_info = {
     .class_init = aspeed_ast2600_sbc_class_init,
 };
 
+static void aspeed_ast10x0_sbc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSBCClass *sc = ASPEED_SBC_CLASS(klass);
+
+    dc->desc = "AST10X0 Secure Boot Controller";
+    sc->has_otpmem = true;
+}
+
+static const TypeInfo aspeed_ast10x0_sbc_info = {
+    .name = TYPE_ASPEED_AST10X0_SBC,
+    .parent = TYPE_ASPEED_SBC,
+    .class_init = aspeed_ast10x0_sbc_class_init,
+};
+
 static void aspeed_sbc_register_types(void)
 {
     type_register_static(&aspeed_ast2600_sbc_info);
+    type_register_static(&aspeed_ast10x0_sbc_info);
     type_register_static(&aspeed_sbc_info);
 }
 
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index 667d6088c0..34881ce3ec 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -14,6 +14,7 @@
 
 #define TYPE_ASPEED_SBC "aspeed.sbc"
 #define TYPE_ASPEED_AST2600_SBC TYPE_ASPEED_SBC "-ast2600"
+#define TYPE_ASPEED_AST10X0_SBC TYPE_ASPEED_SBC "-ast10X0"
 OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)
 
 #define ASPEED_SBC_NR_REGS (0x93c >> 2)
-- 
2.43.0


