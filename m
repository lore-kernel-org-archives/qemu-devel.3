Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A811AC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEci-0002NY-75; Tue, 08 Jul 2025 16:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uZDTq-0001oT-6p; Tue, 08 Jul 2025 14:56:13 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uZDTb-0000ci-3g; Tue, 08 Jul 2025 14:55:44 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 8 Jul
 2025 13:58:11 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 8 Jul 2025 13:58:11 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v4 5/5] hw/misc/aspeed_sbc: Add machine parameter to alias OTP
 drive property
Date: Tue, 8 Jul 2025 13:57:57 +0800
Message-ID: <20250708055810.2868680-6-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708055810.2868680-1-kane_chen@aspeedtech.com>
References: <20250708055810.2868680-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patch adds a new machine parameter `otpmem` which creates a QOM
property alias on the aspeed_sbc device for the OTP drive.

Example usage:

  ./qemu-system-arm \
    -machine ast2600-evb,otpmem=otp-drive \
    -blockdev driver=file,filename=otpmem.img,node-name=otp \
    -global aspeed-otp.drive=otp \
    ...

With this change, the specified alias name (e.g. "otp-drive") becomes
available on the QOM path `/machine/soc/sbc/otp-drive`.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 hw/arm/aspeed.c      | 20 ++++++++++++++++++++
 hw/misc/aspeed_sbc.c |  8 ++++++++
 2 files changed, 28 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c31bbe7701..8ec32369a6 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -48,6 +48,7 @@ struct AspeedMachineState {
     uint32_t uart_chosen;
     char *fmc_model;
     char *spi_model;
+    char *otpmem;
     uint32_t hw_strap1;
 };
 
@@ -1424,6 +1425,21 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
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
@@ -1445,6 +1461,10 @@ static void aspeed_machine_class_props_init(ObjectClass *oc)
                                    aspeed_set_spi_model);
     object_class_property_set_description(oc, "spi-model",
                                           "Change the SPI Flash model");
+    object_class_property_add_str(oc, "otpmem", aspeed_get_otpmem,
+                                   aspeed_set_otpmem);
+    object_class_property_set_description(oc, "otpmem",
+                                          "Set OTP Memory type");
 }
 
 static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index b56a8b7678..b82c5e37cc 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -209,10 +209,18 @@ static void aspeed_sbc_instance_init(Object *obj)
 {
     AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(obj);
     AspeedSBCState *s = ASPEED_SBC(obj);
+    char *otpname;
 
     if (sc->has_otp) {
         object_initialize_child(OBJECT(s), "otp", &s->otp,
                                 TYPE_ASPEED_OTP);
+        otpname = object_property_get_str(qdev_get_machine(),
+                                          "otpmem",
+                                          &error_abort);
+        if (strlen(otpname)) {
+            object_property_add_alias(obj, otpname,
+                                      OBJECT(&s->otp), "drive");
+        }
     }
 }
 
-- 
2.43.0


