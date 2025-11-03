Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C483CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFqrV-0000jb-JK; Mon, 03 Nov 2025 04:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqrT-0000jC-F7; Mon, 03 Nov 2025 04:28:27 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqrQ-0001r9-1x; Mon, 03 Nov 2025 04:28:27 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 17:28:03 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 17:28:03 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 02/30] hw/arm/aspeed: Make
 aspeed_machine_class_init_cpus_defaults() globally accessible
Date: Mon, 3 Nov 2025 17:27:13 +0800
Message-ID: <20251103092801.1282602-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
References: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The function aspeed_machine_class_init_cpus_defaults() is now made
globally visible so that it can be used by other Aspeed machine C files.

Previously, this function was declared as static, restricting its
visibility to aspeed.c. Since future machine split files will also
need to call this helper to initialize default CPU settings, its
declaration has been moved to the common header aspeed.h and the
static keyword has been removed.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed.h | 10 ++++++++++
 hw/arm/aspeed.c         |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 9d34be68b2..712014497e 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -57,5 +57,15 @@ struct AspeedMachineClass {
     bool vbootrom;
 };
 
+/*
+ * aspeed_machine_class_init_cpus_defaults:
+ * @mc: the #MachineClass to be initialized.
+ *
+ * Initialize the default CPU configuration for an Aspeed machine class.
+ * This function sets the default, minimum, and maximum CPU counts
+ * to match the number of CPUs defined in the associated SoC class,
+ * and copies its list of valid CPU types.
+ */
+void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
 
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 4c92f1e1d9..f23af5bf8c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1339,7 +1339,7 @@ static void aspeed_machine_class_props_init(ObjectClass *oc)
                                           "Change the SPI Flash model");
 }
 
-static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
+void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
 {
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(mc);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
-- 
2.43.0


