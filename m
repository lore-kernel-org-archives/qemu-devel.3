Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F255DC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 07:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgPc-0000v7-GP; Tue, 28 Jan 2025 02:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgPZ-0000td-Nl; Tue, 28 Jan 2025 02:53:29 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgPX-0007m0-KA; Tue, 28 Jan 2025 02:53:29 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A341FE1ABC;
 Tue, 28 Jan 2025 10:52:59 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1DFFB1A62AB;
 Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 1282F51FED; Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 03/31] hw/intc/loongarch_extioi: Use set_bit32() and
 clear_bit32() for s->isr
Date: Tue, 28 Jan 2025 00:40:55 +0300
Message-Id: <20250127214124.3730126-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
References: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In extioi_setirq() we try to operate on a bit array stored as an
array of uint32_t using the set_bit() and clear_bit() functions
by casting the pointer to 'unsigned long *'.
This has two problems:
 * the alignment of 'uint32_t' is less than that of 'unsigned long'
   so we pass an insufficiently aligned pointer, which is
   undefined behaviour
 * on big-endian hosts the 64-bit 'unsigned long' will have
   its two halves the wrong way around, and we will produce
   incorrect results

The undefined behaviour is shown by the clang undefined-behaviour
sanitizer when running the loongarch64-virt functional test:

/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitops.h:41:5: runtime error: store to misaligned address 0x555559745d9c for type 'unsigned long', which requires 8 byte alignment
0x555559745d9c: note: pointer points here
  ff ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^
    #0 0x555556fb81c4 in set_bit /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitops.h:41:9
    #1 0x555556fb81c4 in extioi_setirq /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/intc/loongarch_extioi.c:65:9
    #2 0x555556fb6e90 in pch_pic_irq_handler /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/intc/loongarch_pch_pic.c:75:5
    #3 0x555556710265 in serial_ioport_write /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/char/serial.c

Fix these problems by using set_bit32() and clear_bit32(),
which work with bit arrays stored as an array of uint32_t.

Cc: qemu-stable@nongnu.org
Fixes: cbff2db1e92f8759 ("hw/intc: Add LoongArch extioi interrupt controller(EIOINTC)")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-id: 20241108135514.4006953-4-peter.maydell@linaro.org
(cherry picked from commit 335be5bc44aa6800a9e3ba5859ea3833cfe5a7bc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: drop hunk in hw/intc/loongarch_extioi.c:extioi_update_sw_coremap()
 due to missing v8.2.0-548-g428a6ef4396a "hw/intc/loongarch_extioi: Add vmstate post_load support")

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 4b8ec3f28a..fe17c7e0b1 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -56,14 +56,9 @@ static void extioi_setirq(void *opaque, int irq, int level)
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
     trace_loongarch_extioi_setirq(irq, level);
     if (level) {
-        /*
-         * s->isr should be used in vmstate structure,
-         * but it not support 'unsigned long',
-         * so we have to switch it.
-         */
-        set_bit(irq, (unsigned long *)s->isr);
+        set_bit32(irq, s->isr);
     } else {
-        clear_bit(irq, (unsigned long *)s->isr);
+        clear_bit32(irq, s->isr);
     }
     extioi_update_irq(s, irq, level);
 }
-- 
2.39.5


