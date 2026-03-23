Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE7AF483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iUX-0000Bj-Jv; Mon, 23 Mar 2026 12:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w4iUO-00005s-FY; Mon, 23 Mar 2026 12:50:52 -0400
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w4iUH-0000H3-UE; Mon, 23 Mar 2026 12:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ae
 DjjVRMT/dIuNCZwQoXRf0bQC8+WgxwfQJexXCLxHE=; b=Ya6Ad3GELVId9eMuvW
 +sKJttZUHp0lajCVtZwkhd7EIc/wseI63XLYb+vatrNVjBta0djKaRGlXuN4N08f
 cW6Ob3qqZVpJsFB+kZJZGuVW9Wz/0C93N7X//M0w+mtbzQCPsy9bxMRU9JwCf9dB
 JYataFhx40dPNGExe5E38OKHU=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgAH5qxAb8FpwWGXTQ--.954S3;
 Tue, 24 Mar 2026 00:50:12 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v2 1/1] Fix transfer size register decrement in pl080
Date: Tue, 24 Mar 2026 00:50:07 +0800
Message-ID: <5856c66fd4e495b874815adba9dcfeddc1f47e65.1774282897.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1774282897.git.dingtao0430@163.com>
References: <cover.1774282897.git.dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgAH5qxAb8FpwWGXTQ--.954S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww15XF4kZrWruF4xXF13Jwb_yoW8tw4UpF
 yDKFySkr4Fq34rZ3Z0qr40gr15Xa1Iy3ZxK3y2gr1DCr1kuFy3Gr1rGrWxJFWYvwn7Zr1r
 ta4DWr4Y9r1qqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U75rxUUUUU=
X-Originating-IP: [119.4.67.184]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4QS39WnBb0SKqAAA3G
Received-SPF: pass client-ip=220.197.31.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Configure swidth to 1 byte, width to 4 bytes, and transfer size to 4.

Configuration
    ../configure --target-list=arm-softmmu --enable-debug
Reproducer
    ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
    -device loader,addr=0x00000000,data=0x44332211,data-len=4 \
    -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
    -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
    -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
    -device loader,addr=0x1013010C,data=0x9e47f004,data-len=4 \
    -device loader,addr=0x10130110,data=0x0000c001,data-len=4 

Qemu monitor
    (qemu) xp /1wx 0x00001000
    00001000: 0x00002211

The result correctly after fixed
    (qemu) xp /1wx 0x00001000
    00001000: 0x44332211

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/dma/pl080.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 627ccbbd81..4a90c7bb27 100644
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
2.43.0


