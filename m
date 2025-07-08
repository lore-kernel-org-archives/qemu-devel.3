Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C304C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAM-0002rL-Tu; Tue, 08 Jul 2025 16:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uZDTZ-0001iQ-Ep; Tue, 08 Jul 2025 14:55:45 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uZDTU-0000Ru-WE; Tue, 08 Jul 2025 14:55:32 -0400
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
Subject: [PATCH v4 4/5] hw/misc/aspeed_otp: Add 'drive' property to support
 block backend
Date: Tue, 8 Jul 2025 13:57:56 +0800
Message-ID: <20250708055810.2868680-5-kane_chen@aspeedtech.com>
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

This patch introduces a 'drive' property to the Aspeed OTP device,
allowing it to be backed by a block device. Users can now preload
OTP data via QEMU CLI using a block backend.

Example usage:
  ./qemu-system-arm \
    -blockdev driver=file,filename=otpmem.img,node-name=otp \
    -global aspeed-otp.drive=otp \
    ...

If the drive is provided, its content will be loaded as the initial OTP state.
Otherwise, an internal memory buffer will be used.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 hw/nvram/aspeed_otp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
index e41481d9bb..f018c58713 100644
--- a/hw/nvram/aspeed_otp.c
+++ b/hw/nvram/aspeed_otp.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
+#include "system/block-backend-global-state.h"
 #include "system/block-backend-io.h"
 #include "hw/qdev-properties.h"
 #include "hw/nvram/aspeed_otp.h"
@@ -35,13 +36,25 @@ static bool aspeed_otp_init_storage(AspeedOTPState *s, Error **errp)
 {
     uint32_t *p;
     int i, num;
+    uint64_t perm;
 
+    if (s->blk) {
+        perm = BLK_PERM_CONSISTENT_READ |
+               (blk_supports_write_perm(s->blk) ? BLK_PERM_WRITE : 0);
+        if (blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp) < 0) {
+            return false;
+        }
+        if (blk_pread(s->blk, 0, s->size, s->storage, 0) < 0) {
+            error_setg(errp, "Failed to read the initial flash content");
+            return false;
+        }
+    } else {
         num = s->size / sizeof(uint32_t);
         p = (uint32_t *)s->storage;
         for (i = 0; i < num; i++) {
             p[i] = (i % 2 == 0) ? 0x00000000 : 0xFFFFFFFF;
         }
-
+    }
     return true;
 }
 
@@ -75,6 +88,7 @@ static void aspeed_otp_realize(DeviceState *dev, Error **errp)
 
 static const Property aspeed_otp_properties[] = {
     DEFINE_PROP_UINT64("size", AspeedOTPState, size, 0),
+    DEFINE_PROP_DRIVE("drive", AspeedOTPState, blk),
 };
 
 static void aspeed_otp_class_init(ObjectClass *klass, const void *data)
-- 
2.43.0


