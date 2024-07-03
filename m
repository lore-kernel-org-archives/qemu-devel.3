Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC585C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvAi-0003I9-Lb; Wed, 03 Jul 2024 04:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sOvAg-0003HX-Va; Wed, 03 Jul 2024 04:16:59 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sOvAf-00014r-FS; Wed, 03 Jul 2024 04:16:58 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 3 Jul
 2024 16:16:25 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 3 Jul 2024 16:16:25 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:Block layer core"
 <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v2 3/5] aspeed/soc: update to ftgmac100_high model for AST2700
Date: Wed, 3 Jul 2024 16:16:21 +0800
Message-ID: <20240703081623.2740862-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703081623.2740862-1-jamin_lin@aspeedtech.com>
References: <20240703081623.2740862-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

ASPEED AST2700 SOC is a 64 bits quad core CPUs (Cortex-a35)
And the base address of dram is "0x4 00000000" which
is 64bits address.

Update its network model to ftgmac100_high to support
64bits dram address DMA.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 18e6a8b10c..04604a4bef 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -332,7 +332,7 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
     for (i = 0; i < sc->macs_num; i++) {
         object_initialize_child(obj, "ftgmac100[*]", &s->ftgmac100[i],
-                                TYPE_FTGMAC100);
+                                TYPE_FTGMAC100_HIGH);
 
         object_initialize_child(obj, "mii[*]", &s->mii[i], TYPE_ASPEED_MII);
     }
@@ -552,6 +552,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Net */
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed", true,
                                  &error_abort);
-- 
2.34.1


