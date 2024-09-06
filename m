Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B027ECE7AB9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 06:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSsy-00014y-LW; Fri, 06 Sep 2024 02:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSsv-0000aY-Dk; Fri, 06 Sep 2024 02:55:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSst-0003Lt-AZ; Fri, 06 Sep 2024 02:55:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E81168C248;
 Fri,  6 Sep 2024 09:53:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A6424133400;
 Fri,  6 Sep 2024 09:54:30 +0300 (MSK)
Received: (nullmailer pid 43447 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 19/53] hw/misc/bcm2835_property: Fix handling of
 FRAMEBUFFER_SET_PALETTE
Date: Fri,  6 Sep 2024 09:53:49 +0300
Message-Id: <20240906065429.42415-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The documentation of the "Set palette" mailbox property at
https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface#set-palette
says it has the form:

    Length: 24..1032
    Value:
        u32: offset: first palette index to set (0-255)
        u32: length: number of palette entries to set (1-256)
        u32...: RGBA palette values (offset to offset+length-1)

We get this wrong in a couple of ways:
 * we aren't checking the offset and length are in range, so the guest
   can make us spin for a long time by providing a large length
 * the bounds check on our loop is wrong: we should iterate through
   'length' palette entries, not 'length - offset' entries

Fix the loop to implement the bounds checks and get the loop
condition right. In the process, make the variables local to
this switch case, rather than function-global, so it's clearer
what type they are when reading the code.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240723131029.1159908-2-peter.maydell@linaro.org
(cherry picked from commit 0892fffc2abaadfb5d8b79bb0250ae1794862560)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fix due to lack of
 v9.0.0-1812-g5d5f1b60916a "hw/misc: Implement mailbox properties for customer OTP and device specific private keys"
 also remove now-unused local `n' variable which gets removed in the next change in this file,
 v9.0.0-2720-g32f1c201eedf "hw/misc/bcm2835_property: Avoid overflow in OTP access properties")

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index ff55a4e2cd..87876f9a58 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -28,8 +28,6 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tot_len;
     size_t resplen;
     uint32_t tmp;
-    int n;
-    uint32_t offset, length, color;
 
     /*
      * Copy the current state of the framebuffer config; we will update
@@ -264,18 +262,25 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 16;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_PALETTE:
-            offset = ldl_le_phys(&s->dma_as, value + 12);
-            length = ldl_le_phys(&s->dma_as, value + 16);
-            n = 0;
-            while (n < length - offset) {
-                color = ldl_le_phys(&s->dma_as, value + 20 + (n << 2));
-                stl_le_phys(&s->dma_as,
-                            s->fbdev->vcram_base + ((offset + n) << 2), color);
-                n++;
+        {
+            uint32_t offset = ldl_le_phys(&s->dma_as, value + 12);
+            uint32_t length = ldl_le_phys(&s->dma_as, value + 16);
+            int resp;
+
+            if (offset > 255 || length < 1 || length > 256) {
+                resp = 1; /* invalid request */
+            } else {
+                for (uint32_t e = 0; e < length; e++) {
+                    uint32_t color = ldl_le_phys(&s->dma_as, value + 20 + (e << 2));
+                    stl_le_phys(&s->dma_as,
+                                s->fbdev->vcram_base + ((offset + e) << 2), color);
+                }
+                resp = 0;
             }
-            stl_le_phys(&s->dma_as, value + 12, 0);
+            stl_le_phys(&s->dma_as, value + 12, resp);
             resplen = 4;
             break;
+        }
         case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
-- 
2.39.2


