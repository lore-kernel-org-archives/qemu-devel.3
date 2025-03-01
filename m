Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECB4C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 14:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toNx6-0001Qz-4S; Sat, 01 Mar 2025 09:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toNwL-00019l-Ch
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 09:35:42 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toNwI-00017s-EN
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 09:35:41 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 486554E6108;
 Sat, 01 Mar 2025 15:35:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id RFM_Qwe8OYCF; Sat,  1 Mar 2025 15:35:34 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 47DEA4E60F6; Sat, 01 Mar 2025 15:35:34 +0100 (CET)
Message-Id: <637b92984795a385b648a84208f093947cc261e4.1740839457.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1740839457.git.balaton@eik.bme.hu>
References: <cover.1740839457.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/4] hw/nvram/eeprom_at24c: Remove ERR macro that calls
 fprintf to stderr
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Date: Sat, 01 Mar 2025 15:35:34 +0100 (CET)
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

In the realize method error_setg can be used like other places there
already do. The other usage can be replaced with error_report which is
the preferred way instead of directly printing to stderr.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/nvram/eeprom_at24c.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 2ae03935d4..9f606842eb 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
 #include "hw/nvram/eeprom_at24c.h"
@@ -26,9 +27,6 @@
 #define DPRINTK(FMT, ...) do {} while (0)
 #endif
 
-#define ERR(FMT, ...) fprintf(stderr, TYPE_AT24C_EE " : " FMT, \
-                            ## __VA_ARGS__)
-
 #define TYPE_AT24C_EE "at24c-eeprom"
 OBJECT_DECLARE_SIMPLE_TYPE(EEPROMState, AT24C_EE)
 
@@ -75,8 +73,7 @@ int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
         if (ee->blk && ee->changed) {
             int ret = blk_pwrite(ee->blk, 0, ee->rsize, ee->mem, 0);
             if (ret < 0) {
-                ERR(TYPE_AT24C_EE
-                        " : failed to write backing file\n");
+                error_report("%s: failed to write backing file", __func__);
             }
             DPRINTK("Wrote to backing file\n");
         }
@@ -203,8 +200,9 @@ static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
         int ret = blk_pread(ee->blk, 0, ee->rsize, ee->mem, 0);
 
         if (ret < 0) {
-            ERR(TYPE_AT24C_EE
-                    " : Failed initial sync with backing file\n");
+            error_setg(errp, "%s: Failed initial sync with backing file",
+                       TYPE_AT24C_EE);
+            return;
         }
         DPRINTK("Reset read backing file\n");
     }
-- 
2.30.9


