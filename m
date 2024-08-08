Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D967C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 02:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbtDf-0007Ds-Eh; Wed, 07 Aug 2024 22:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sbtDd-00075A-Cj; Wed, 07 Aug 2024 22:49:37 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sbtDb-0008AE-RV; Wed, 07 Aug 2024 22:49:37 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 8 Aug
 2024 10:49:17 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 8 Aug 2024 10:49:17 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v2 03/11] hw/i2c/aspeed: support discontinuous poll buffer
 memory region of I2C bus
Date: Thu, 8 Aug 2024 10:49:08 +0800
Message-ID: <20240808024916.1262715-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240808024916.1262715-1-jamin_lin@aspeedtech.com>
References: <20240808024916.1262715-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

It only support continuous pool buffer memory region for all I2C bus.
However, the pool buffer address of all I2c bus are discontinuous
for AST2700.

Ex: the pool buffer address of I2C bus for ast2700 as following.
0x1A0 - 0x1BF: Device 0 buffer
0x2A0 - 0x2BF: Device 1 buffer
0x3A0 - 0x3BF: Device 2 buffer
0x4A0 - 0x4BF: Device 3 buffer
0x5A0 - 0x5BF: Device 4 buffer
0x6A0 - 0x6BF: Device 5 buffer
0x7A0 - 0x7BF: Device 6 buffer
0x8A0 - 0x8BF: Device 7 buffer
0x9A0 - 0x9BF: Device 8 buffer
0xAA0 - 0xABF: Device 9 buffer
0xBA0 - 0xBBF: Device 10 buffer
0xCA0 - 0xCBF: Device 11 buffer
0xDA0 - 0xDBF: Device 12 buffer
0xEA0 - 0xEBF: Device 13 buffer
0xFA0 – 0xFBF: Device 14 buffer
0x10A0 – 0x10BF: Device 15 buffer

Introduce a new class attribute to make user set each I2C bus
pool buffer gap size. Update formula to create all I2C bus
pool buffer memory regions.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/i2c/aspeed_i2c.c         | 3 ++-
 include/hw/i2c/aspeed_i2c.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index d3d49340ea..abcb1d5330 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1098,6 +1098,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
     AspeedI2CState *s = ASPEED_I2C(dev);
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
     uint32_t reg_offset = aic->reg_size + aic->reg_gap_size;
+    uint32_t pool_offset = aic->pool_size + aic->pool_gap_size;
 
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_i2c_ctrl_ops, s,
@@ -1133,7 +1134,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
     } else {
         for (i = 0; i < aic->num_busses; i++) {
             memory_region_add_subregion(&s->iomem,
-                                        aic->pool_base + (aic->pool_size * i),
+                                        aic->pool_base + (pool_offset * i),
                                         &s->busses[i].mr_pool);
         }
     }
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 8e62ec64f8..b42c4dc584 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -284,6 +284,7 @@ struct AspeedI2CClass {
 
     uint64_t pool_size;
     hwaddr pool_base;
+    uint32_t pool_gap_size;
     uint8_t *(*bus_pool_base)(AspeedI2CBus *);
     bool check_sram;
     bool has_dma;
-- 
2.34.1


