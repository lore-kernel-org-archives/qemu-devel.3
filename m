Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEEBE6C5E5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 01:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tII5v-0007Ou-VU; Mon, 02 Dec 2024 20:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tII5m-0007MY-34; Mon, 02 Dec 2024 20:52:46 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tII5k-0006Sd-O1; Mon, 02 Dec 2024 20:52:45 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 3 Dec
 2024 09:52:25 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 3 Dec 2024 09:52:25 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 3/5] hw/sd/aspeed_sdhci: Add AST2700 Support
Date: Tue, 3 Dec 2024 09:52:22 +0800
Message-ID: <20241203015224.3985820-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203015224.3985820-1-jamin_lin@aspeedtech.com>
References: <20241203015224.3985820-1-jamin_lin@aspeedtech.com>
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

Introduce a new ast2700 class to support AST2700. Add a new ast2700 SDHCI class
init function and set the value of capability register to "0x0000000719f80080".

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/sd/aspeed_sdhci.c         | 16 ++++++++++++++++
 include/hw/sd/aspeed_sdhci.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 93f5571021..4cba934f53 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -273,12 +273,28 @@ static const TypeInfo aspeed_2600_sdhci_info = {
     .class_init = aspeed_2600_sdhci_class_init,
 };
 
+static void aspeed_2700_sdhci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSDHCIClass *asc = ASPEED_SDHCI_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 SDHCI Controller";
+    asc->capareg = 0x0000000719f80080;
+}
+
+static const TypeInfo aspeed_2700_sdhci_info = {
+    .name = TYPE_ASPEED_2700_SDHCI,
+    .parent = TYPE_ASPEED_SDHCI,
+    .class_init = aspeed_2700_sdhci_class_init,
+};
+
 static void aspeed_sdhci_register_types(void)
 {
     type_register_static(&aspeed_sdhci_info);
     type_register_static(&aspeed_2400_sdhci_info);
     type_register_static(&aspeed_2500_sdhci_info);
     type_register_static(&aspeed_2600_sdhci_info);
+    type_register_static(&aspeed_2700_sdhci_info);
 }
 
 type_init(aspeed_sdhci_register_types);
diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
index 8083797e25..4ef1770471 100644
--- a/include/hw/sd/aspeed_sdhci.h
+++ b/include/hw/sd/aspeed_sdhci.h
@@ -16,6 +16,7 @@
 #define TYPE_ASPEED_2400_SDHCI TYPE_ASPEED_SDHCI "-ast2400"
 #define TYPE_ASPEED_2500_SDHCI TYPE_ASPEED_SDHCI "-ast2500"
 #define TYPE_ASPEED_2600_SDHCI TYPE_ASPEED_SDHCI "-ast2600"
+#define TYPE_ASPEED_2700_SDHCI TYPE_ASPEED_SDHCI "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedSDHCIState, AspeedSDHCIClass, ASPEED_SDHCI)
 
 #define ASPEED_SDHCI_NUM_SLOTS    2
-- 
2.34.1


