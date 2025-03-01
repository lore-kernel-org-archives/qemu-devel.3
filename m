Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21058C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 14:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toNwb-0001Ap-BB; Sat, 01 Mar 2025 09:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toNwM-00019o-6H
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 09:35:42 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toNwJ-00018N-Vv
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 09:35:41 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4C0404E6128;
 Sat, 01 Mar 2025 15:35:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 5WxFjE4lQfrO; Sat,  1 Mar 2025 15:35:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 606224E6109; Sat, 01 Mar 2025 15:35:36 +0100 (CET)
Message-Id: <fd8e0478febd60d5f48c58bc77c60e043d1c3cdc.1740839457.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1740839457.git.balaton@eik.bme.hu>
References: <cover.1740839457.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 4/4] hw/nvram/eeprom_at24c: Reorganise init to avoid
 overwriting values
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Date: Sat, 01 Mar 2025 15:35:36 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The init_rom can write values to the beginning of the memory but these
are overwritten by values from a backing file that covers the whole
memory. Do the init_rom handling only if it would not be overwritten.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/nvram/eeprom_at24c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 78c81bea77..ff7a21eee7 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -191,10 +191,6 @@ static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
 
     ee->mem = g_malloc0(ee->rsize);
 
-    if (ee->init_rom) {
-        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee->rsize));
-    }
-
     if (ee->blk) {
         int ret = blk_pread(ee->blk, 0, ee->rsize, ee->mem, 0);
 
@@ -204,6 +200,8 @@ static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
             return;
         }
         DPRINTK("Reset read backing file\n");
+    } else if (ee->init_rom) {
+        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee->rsize));
     }
 
     /*
-- 
2.30.9


