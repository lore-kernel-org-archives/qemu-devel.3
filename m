Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428FECAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyh1j-0006AS-Aq; Tue, 16 Sep 2025 21:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1f-00068g-Ci; Tue, 16 Sep 2025 21:32:03 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1c-0006vf-SU; Tue, 16 Sep 2025 21:32:02 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 17 Sep
 2025 09:31:44 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 17 Sep 2025 09:31:44 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/6] hw/arm/aspeed: Add 'ioexps-num' property for AST27x0
Date: Wed, 17 Sep 2025 09:31:36 +0800
Message-ID: <20250917013143.1600377-2-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
References: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
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

AST27x0 platforms can attach up to two AST1700 IO expander boards.
Introduce the 'ioexps-num' property to let users specify how many
IO expanders to instantiate for a given machine.

This enables modeling board variants that ship with 0-2 expanders.

Note: AST2500 and AST2600 do not support IO expanders; this property
is only available on AST27x0 machines.

Command usage:
```
./qemu-system-aarch64 -M ast2700a1-evb,ioexps-num=2 \
  -drive image-bmc,format=raw,if=mtd \
  ...
```

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  2 ++
 hw/arm/aspeed.c             | 49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 217ef0eafd..77263cc6ec 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -49,6 +49,7 @@
 #define ASPEED_MACS_NUM  4
 #define ASPEED_UARTS_NUM 13
 #define ASPEED_JTAG_NUM  2
+#define ASPEED_IOEXP_NUM 2
 
 struct AspeedSoCState {
     DeviceState parent;
@@ -103,6 +104,7 @@ struct AspeedSoCState {
     UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
+    uint8_t ioexp_num;
 };
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c31bbe7701..593cb87bfe 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -32,6 +32,7 @@
 #include "qemu/units.h"
 #include "hw/qdev-clock.h"
 #include "system/system.h"
+#include "qapi/visitor.h"
 
 static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
@@ -49,6 +50,7 @@ struct AspeedMachineState {
     char *fmc_model;
     char *spi_model;
     uint32_t hw_strap1;
+    uint32_t ioexp_num;
 };
 
 /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
@@ -444,6 +446,9 @@ static void aspeed_machine_init(MachineState *machine)
                              OBJECT(get_system_memory()), &error_abort);
     object_property_set_link(OBJECT(bmc->soc), "dram",
                              OBJECT(machine->ram), &error_abort);
+
+    bmc->soc->ioexp_num = bmc->ioexp_num;
+
     if (amc->sdhci_wp_inverted) {
         for (i = 0; i < bmc->soc->sdhci.num_slots; i++) {
             object_property_set_bool(OBJECT(&bmc->soc->sdhci.slots[i]),
@@ -1486,6 +1491,49 @@ static void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc)
                                           "Set or unset boot from EMMC");
 }
 
+#ifdef TARGET_AARCH64
+static void aspeed_get_ioexps_num(Object *obj,
+                                  Visitor *v,
+                                  const char *name,
+                                  void *opaque,
+                                  Error **errp)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
+
+    visit_type_uint32(v, name, &bmc->ioexp_num, errp);
+}
+
+static void aspeed_set_ioexps_num(Object *obj,
+                                  Visitor *v,
+                                  const char *name,
+                                  void *opaque,
+                                  Error **errp)
+{
+    uint32_t val;
+    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
+
+    if (!visit_type_uint32(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val > ASPEED_IOEXP_NUM) {
+        error_setg(errp, "IOEXP number is exceeded: %d", val);
+        return;
+    }
+
+    bmc->ioexp_num = val;
+}
+
+
+static void aspeed_machine_ast1700_class_init(ObjectClass *oc)
+{
+    object_class_property_add(oc, "ioexps-num", "uint32",
+                              aspeed_get_ioexps_num,
+                              aspeed_set_ioexps_num,
+                              NULL, NULL);
+}
+#endif
+
 static void aspeed_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2032,6 +2080,7 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
     mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
+    aspeed_machine_ast1700_class_init(oc);
 }
 #endif
 
-- 
2.43.0


