Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77B1C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 03:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiQ2S-0000Ni-4B; Wed, 12 Feb 2025 22:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tiQ2J-0008N2-Hk; Wed, 12 Feb 2025 22:37:12 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tiQ2I-0000nL-8j; Wed, 12 Feb 2025 22:37:11 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 13 Feb
 2025 11:35:39 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 13 Feb 2025 11:35:39 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v3 20/28] hw/misc/aspeed_hace: Add AST2700 support
Date: Thu, 13 Feb 2025 11:35:23 +0800
Message-ID: <20250213033531.3367697-21-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
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

Introduce a new ast2700 class to support AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 hw/misc/aspeed_hace.c         | 20 ++++++++++++++++++++
 include/hw/misc/aspeed_hace.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 18b85081c7..86422cb3be 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -552,12 +552,32 @@ static const TypeInfo aspeed_ast1030_hace_info = {
     .class_init = aspeed_ast1030_hace_class_init,
 };
 
+static void aspeed_ast2700_hace_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedHACEClass *ahc = ASPEED_HACE_CLASS(klass);
+
+    dc->desc = "AST2700 Hash and Crypto Engine";
+
+    ahc->src_mask = 0x7FFFFFFF;
+    ahc->dest_mask = 0x7FFFFFF8;
+    ahc->key_mask = 0x7FFFFFF8;
+    ahc->hash_mask = 0x00147FFF;
+}
+
+static const TypeInfo aspeed_ast2700_hace_info = {
+    .name = TYPE_ASPEED_AST2700_HACE,
+    .parent = TYPE_ASPEED_HACE,
+    .class_init = aspeed_ast2700_hace_class_init,
+};
+
 static void aspeed_hace_register_types(void)
 {
     type_register_static(&aspeed_ast2400_hace_info);
     type_register_static(&aspeed_ast2500_hace_info);
     type_register_static(&aspeed_ast2600_hace_info);
     type_register_static(&aspeed_ast1030_hace_info);
+    type_register_static(&aspeed_ast2700_hace_info);
     type_register_static(&aspeed_hace_info);
 }
 
diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
index 4af9919195..d13fd3da07 100644
--- a/include/hw/misc/aspeed_hace.h
+++ b/include/hw/misc/aspeed_hace.h
@@ -18,6 +18,7 @@
 #define TYPE_ASPEED_AST2500_HACE TYPE_ASPEED_HACE "-ast2500"
 #define TYPE_ASPEED_AST2600_HACE TYPE_ASPEED_HACE "-ast2600"
 #define TYPE_ASPEED_AST1030_HACE TYPE_ASPEED_HACE "-ast1030"
+#define TYPE_ASPEED_AST2700_HACE TYPE_ASPEED_HACE "-ast2700"
 
 OBJECT_DECLARE_TYPE(AspeedHACEState, AspeedHACEClass, ASPEED_HACE)
 
-- 
2.34.1


