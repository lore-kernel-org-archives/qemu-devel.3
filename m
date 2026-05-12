Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1226FCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuLv-0005Al-6B; Tue, 12 May 2026 17:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLH-0001wG-Fl; Tue, 12 May 2026 17:08:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLD-0002hf-QW; Tue, 12 May 2026 17:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619301; bh=qZ2QJafS3qF5NdiU6upHl0gqKDTp+PplXA2JdDEzsO4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M1MSjDb0X/YjWZFXxcRFNACNwNBKqCAeGb2kw4wlkNknvOcnbDjSr+W1Jg9uXJ4h8
 iYiii9IPWWlFYM8zJqcq4MRJc7n/ZMByqnvd5kGc/0IwdjH7dgFCrU190Rh+Uao2gD
 c6FW+431hRCTgUBza8XmYsscAeLZLTVXyh4ITpeCHdX2OmwG6njRTcQ2YOUC7CVsjM
 F3iAqla2OHBeVl9Vkf4Oyy3GFc6QCSN6uoskgadk2/vvkYkvhs8cgyjgq/8Q+YsqdX
 e/Y2+7qrLi5HZ4DzQmNagFXIfS0HD6Oiy2K7CSBMrtNnbxl7g/AgyGuYDoH1SuGLxt
 F2yc95walKfkA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7120A1AA357;
 Tue, 12 May 2026 23:55:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7E1E83ABCC7;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tao Ding <dingtao0430@163.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 026/117] hw/dma/pl080: Fix transfer logic in PL080
Date: Tue, 12 May 2026 23:53:28 +0300
Message-ID: <20260512205503.361097-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Tao Ding <dingtao0430@163.com>

The logic in the PL080 for transferring data has multiple bugs:

 * The TransferSize field in the channel control register counts
   in units of the source width; because our loop may do multiple
   source loads if the destination width is greater than the
   source width, we need to decrement it by (xsize / swidth),
   not by 1, each loop

 * It is documented in the TRM that it is a software error to program
   the source and destination width such that SWidth < DWidth and
   TransferSize * SWidth is not a multiple of DWidth. (This would
   mean that there isn't enough data to do a full final destination
   write.) We weren't doing anything sensible with this case.
   The TRM doesn't document what the hardware actually does (though
   it drops some hints that suggest that it probably over-reads
   from the source).

 * In the loop to write to the destination, each loop adds swidth
   to  ch->dest for each loop and also uses (ch->dest + n) as the
   destination address. This moves the destination address on
   further than we should each time round the loop, and also
   is incrementing ch->dest by swidth when it should be dwidth.

This patch fixes these problems:
 * decrement TransferSize by the correct amount
 * log and ignore the transfer size mismatch case
 * correct the loop logic for the destination writes

A repro case which exercises some of this is as follows.  It
configures swidth to 1 byte, dwidth to 4 bytes, and transfer size 4,
for a transfer from 0x00000000 to 0x000010000.  Examining the
destination memory in the QEMU monitor should show that the
source data 0x44332211 has all been copied, but before this
fix it is not:

    ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
    -device loader,addr=0x00000000,data=0x44332211,data-len=4 \
    -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
    -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
    -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
    -device loader,addr=0x1013010C,data=0x9e47f004,data-len=4 \
    -device loader,addr=0x10130110,data=0x0000c001,data-len=4

Without this patch the QEMU monitor shows:
    (qemu) xp /1wx 0x00001000
    00001000: 0x00002211

Correct result:
    (qemu) xp /1wx 0x00001000
    00001000: 0x44332211

Cc: qemu-stable@nongnu.org
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Tao Ding <dingtao0430@163.com>
[PMM: Wrote up what we are fixing in the commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 5a2fa06b0957adad46ba1abe923bca04aad9a4d2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 18f5de3e04..c198e3582b 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -179,23 +179,28 @@ again:
                               c, extract32(ch->ctrl, 21, 3));
                 continue;
             }
-
-            for (n = 0; n < dwidth; n+= swidth) {
+            if ((size * swidth) % dwidth) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                    "pl080: channel %d: transfer size mismatch: size=%d swidth=%d dwidth=%d\n",
+                    c, size, swidth, dwidth);
+                continue;
+            }
+            xsize = MAX(swidth, dwidth);
+            for (n = 0; n < xsize; n += swidth) {
                 address_space_read(&s->downstream_as, ch->src,
                                    MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
                 if (ch->ctrl & PL080_CCTRL_SI)
                     ch->src += swidth;
             }
-            xsize = (dwidth < swidth) ? swidth : dwidth;
             /* ??? This may pad the value incorrectly for dwidth < 32.  */
             for (n = 0; n < xsize; n += dwidth) {
-                address_space_write(&s->downstream_as, ch->dest + n,
+                address_space_write(&s->downstream_as, ch->dest,
                                     MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
                 if (ch->ctrl & PL080_CCTRL_DI)
-                    ch->dest += swidth;
+                    ch->dest += dwidth;
             }
 
-            size--;
+            size -= xsize / swidth;
             ch->ctrl = (ch->ctrl & 0xfffff000) | size;
             if (size == 0) {
                 /* Transfer complete.  */
-- 
2.47.3


