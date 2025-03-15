Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF16AC28B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKxJ-00079X-Ne; Sat, 15 Mar 2025 02:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKv7-0003T0-2u; Sat, 15 Mar 2025 02:22:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKv4-0003s0-Mq; Sat, 15 Mar 2025 02:22:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 339BEFF9FC;
 Sat, 15 Mar 2025 09:17:08 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 079D81CAC65;
 Sat, 15 Mar 2025 09:18:02 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9EB7E5590F; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 48/51] hw/net/smc91c111: Don't allow data register
 access to overrun buffer
Date: Sat, 15 Mar 2025 09:17:54 +0300
Message-Id: <20250315061801.622606-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

For accesses to the 91c111 data register, the address within the
packet's data frame is determined by a combination of the pointer
register and the offset used to access the data register, so that you
can access data at effectively wider than byte width.  The pointer
register's pointer field is 11 bits wide, which is exactly the size
to index a 2048-byte data frame.

We weren't quite getting the logic right for ensuring that we end up
with a pointer value to use in the s->data[][] array that isn't out
of bounds:

 * we correctly mask when getting the initial pointer value
 * for the "autoincrement the pointer register" case, we
   correctly mask after adding 1 so that the pointer register
   wraps back around at the 2048 byte mark
 * but for the non-autoincrement case where we have to add the
   low 2 bits of the data register offset, we don't account
   for the possibility that the pointer register is 0x7ff
   and the addition should wrap

Fix this bug by factoring out the "get the p value to use as an array
index" into a function, making it use FIELD macro names rather than
hard-coded constants, and having a utility function that does "add a
value and wrap it" that we can use both for the "autoincrement" and
"add the offset bits" codepaths.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2758
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250228191652.1957208-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 700d3d6dd41de3bd3f1153e3cfe00b93f99b1441)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index aef5477d03..60a252d01a 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -13,6 +13,7 @@
 #include "net/net.h"
 #include "hw/irq.h"
 #include "hw/net/smc91c111.h"
+#include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
@@ -125,6 +126,13 @@ static const VMStateDescription vmstate_smc91c111 = {
 #define RS_TOOSHORT     0x0400
 #define RS_MULTICAST    0x0001
 
+FIELD(PTR, PTR, 0, 11)
+FIELD(PTR, NOT_EMPTY, 11, 1)
+FIELD(PTR, RESERVED, 12, 1)
+FIELD(PTR, READ, 13, 1)
+FIELD(PTR, AUTOINCR, 14, 1)
+FIELD(PTR, RCV, 15, 1)
+
 static inline bool packetnum_valid(int packet_num)
 {
     return packet_num >= 0 && packet_num < NUM_PACKETS;
@@ -371,6 +379,49 @@ static void smc91c111_reset(DeviceState *dev)
 #define SET_LOW(name, val) s->name = (s->name & 0xff00) | val
 #define SET_HIGH(name, val) s->name = (s->name & 0xff) | (val << 8)
 
+/*
+ * The pointer register's pointer is an 11 bit value (so it exactly
+ * indexes a 2048-byte data frame). Add the specified offset to it,
+ * wrapping around at the 2048 byte mark, and return the resulting
+ * wrapped value. There are flag bits in the top part of the register,
+ * but we can ignore them here as the mask will mask them out.
+ */
+static int ptr_reg_add(smc91c111_state *s, int offset)
+{
+    return (s->ptr + offset) & R_PTR_PTR_MASK;
+}
+
+/*
+ * For an access to the Data Register at @offset, return the
+ * required offset into the packet's data frame. This will
+ * perform the pointer register autoincrement if required, and
+ * guarantees to return an in-bounds offset.
+ */
+static int data_reg_ptr(smc91c111_state *s, int offset)
+{
+    int p;
+
+    if (s->ptr & R_PTR_AUTOINCR_MASK) {
+        /*
+         * Autoincrement: use the current pointer value, and
+         * increment the pointer register's pointer field.
+         */
+        p = FIELD_EX32(s->ptr, PTR, PTR);
+        s->ptr = FIELD_DP32(s->ptr, PTR, PTR, ptr_reg_add(s, 1));
+    } else {
+        /*
+         * No autoincrement: register offset determines which
+         * byte we're addressing. Setting the pointer to the top
+         * of the data buffer and then using the pointer wrapping
+         * to read the bottom byte of the buffer is not something
+         * sensible guest software will do, but the datasheet
+         * doesn't say what the behaviour is, so we don't forbid it.
+         */
+        p = ptr_reg_add(s, offset & 3);
+    }
+    return p;
+}
+
 static void smc91c111_writeb(void *opaque, hwaddr offset,
                              uint32_t value)
 {
@@ -517,12 +568,7 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
                                   n);
                     return;
                 }
-                p = s->ptr & 0x07ff;
-                if (s->ptr & 0x4000) {
-                    s->ptr = (s->ptr & 0xf800) | ((s->ptr + 1) & 0x7ff);
-                } else {
-                    p += (offset & 3);
-                }
+                p = data_reg_ptr(s, offset);
                 s->data[n][p] = value;
             }
             return;
@@ -672,12 +718,7 @@ static uint32_t smc91c111_readb(void *opaque, hwaddr offset)
                                   n);
                     return 0;
                 }
-                p = s->ptr & 0x07ff;
-                if (s->ptr & 0x4000) {
-                    s->ptr = (s->ptr & 0xf800) | ((s->ptr + 1) & 0x07ff);
-                } else {
-                    p += (offset & 3);
-                }
+                p = data_reg_ptr(s, offset);
                 return s->data[n][p];
             }
         case 12: /* Interrupt status.  */
-- 
2.39.5


