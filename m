Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E4AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwf0r-0005zJ-Ty; Tue, 16 Apr 2024 05:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rwezY-0003SV-EM; Tue, 16 Apr 2024 05:20:40 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rwezV-0007iy-WE; Tue, 16 Apr 2024 05:20:40 -0400
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 17:19:11 +0800
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Apr
 2024 17:19:13 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 16 Apr 2024 17:19:11 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v3 13/16] aspeed: Add an AST2700 eval board
Date: Tue, 16 Apr 2024 17:19:00 +0800
Message-ID: <20240416091904.935283-14-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jamin_lin@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=localhost.localdomain;
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AST2700 CPU is ARM Cortex-A35 which is 64 bits.
Add TARGET_AARCH64 to build this machine.

According to the design of ast2700, it has a bootmcu(riscv-32) which
is used for executing SPL.
Then, CPUs(cortex-a35) execute u-boot, kernel and rofs.

Currently, qemu not support emulate two CPU architectures
at the same machine. Therefore, qemu will only support
to emulate CPU(cortex-a35) side for ast2700

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 93ca87fda2..40dc0e4c76 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -178,6 +178,12 @@ struct AspeedMachineState {
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
 
+#ifdef TARGET_AARCH64
+/* AST2700 evb hardware value */
+#define AST2700_EVB_HW_STRAP1 0x000000C0
+#define AST2700_EVB_HW_STRAP2 0x00000003
+#endif
+
 /* Tacoma hardware value */
 #define TACOMA_BMC_HW_STRAP1  0x00000000
 #define TACOMA_BMC_HW_STRAP2  0x00000040
@@ -1588,6 +1594,26 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
+#ifdef TARGET_AARCH64
+static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc = "Aspeed AST2700 EVB (Cortex-A35)";
+    amc->soc_name  = "ast2700-a0";
+    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
+    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
+    amc->fmc_model = "w25q01jvq";
+    amc->spi_model = "w25q512jv";
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
+    amc->uart_default = ASPEED_DEV_UART12;
+    mc->default_ram_size = 1 * GiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+#endif
+
 static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
                                                      void *data)
 {
@@ -1711,6 +1737,12 @@ static const TypeInfo aspeed_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
+#ifdef TARGET_AARCH64
+    }, {
+        .name          = MACHINE_TYPE_NAME("ast2700-evb"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_ast2700_evb_class_init,
+#endif
     }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
-- 
2.25.1


