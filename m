Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C4CCCFA08
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFquM-0004nP-QB; Mon, 03 Nov 2025 04:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqu9-0004cD-0K; Mon, 03 Nov 2025 04:31:13 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vFqu4-0002S6-0z; Mon, 03 Nov 2025 04:31:12 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 17:28:18 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 17:28:18 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 23/30] hw/arm/aspeed: Make
 aspeed_machine_ast2600_class_emmc_init() a common API for eMMC boot setup
Date: Mon, 3 Nov 2025 17:27:34 +0800
Message-ID: <20251103092801.1282602-24-jamin_lin@aspeedtech.com>
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

This commit exposes the function aspeed_machine_ast2600_class_emmc_init() as
a common API so that other AST2600-based machine implementations can reuse it
to enable the "boot-emmc" property.

Previously, this function was defined as a static helper within aspeed.c,
limiting its visibility to that file. By making it global and declaring it in
aspeed.h, other machine definition files (e.g., for specific AST2600 boards)
can now easily call this API to register eMMC boot configuration support.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed.h | 10 ++++++++++
 hw/arm/aspeed.c         |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 5d6a9b42b9..fc8ff9b9ec 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -101,4 +101,14 @@ void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
  */
 I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr);
 
+/*
+ * aspeed_machine_ast2600_class_emmc_init:
+ * @oc: the #ObjectClass to initialize.
+ *
+ * Initialize eMMC-related properties for the AST2600 Aspeed machine class.
+ * This function is typically invoked during class initialization to set up
+ * default configuration or attach eMMC-specific devices for AST2600 platforms.
+ */
+void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc);
+
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 89a4632425..2f385290a4 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -755,7 +755,7 @@ static void aspeed_machine_ast2600_set_boot_from_emmc(Object *obj, bool value,
     }
 }
 
-static void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc)
+void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc)
 {
     object_class_property_add_bool(oc, "boot-emmc",
                                    aspeed_machine_ast2600_get_boot_from_emmc,
-- 
2.43.0


