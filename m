Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A376AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVum-0001SC-A4; Thu, 18 Apr 2024 13:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVuh-0001Jo-NO; Thu, 18 Apr 2024 13:51:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVuf-0007bL-MQ; Thu, 18 Apr 2024 13:51:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 437235FD70;
 Thu, 18 Apr 2024 20:50:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8A276B934A;
 Thu, 18 Apr 2024 20:50:00 +0300 (MSK)
Received: (nullmailer pid 947851 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Qiang Liu <cyruscyliu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 103/116] hw/block/nand: Fix out-of-bound access in NAND
 block buffer
Date: Thu, 18 Apr 2024 20:49:33 +0300
Message-Id: <20240418174955.947730-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

nand_command() and nand_getio() don't check @offset points
into the block, nor the available data length (s->iolen) is
not negative.

In order to fix:

- check the offset is in range in nand_blk_load_NAND_PAGE_SIZE(),
- do not set @iolen if blk_load() failed.

Reproducer:

  $ cat << EOF | qemu-system-arm -machine tosa \
                                 -monitor none -serial none \
                                 -display none -qtest stdio
  write 0x10000111 0x1 0xca
  write 0x10000104 0x1 0x47
  write 0x1000ca04 0x1 0xd7
  write 0x1000ca01 0x1 0xe0
  write 0x1000ca04 0x1 0x71
  write 0x1000ca00 0x1 0x50
  write 0x1000ca04 0x1 0xd7
  read 0x1000ca02 0x1
  write 0x1000ca01 0x1 0x10
  EOF

=================================================================
==15750==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x61f000000de0
 at pc 0x560e61557210 bp 0x7ffcfc4a59f0 sp 0x7ffcfc4a59e8
READ of size 1 at 0x61f000000de0 thread T0
    #0 0x560e6155720f in mem_and hw/block/nand.c:101:20
    #1 0x560e6155ac9c in nand_blk_write_512 hw/block/nand.c:663:9
    #2 0x560e61544200 in nand_command hw/block/nand.c:293:13
    #3 0x560e6153cc83 in nand_setio hw/block/nand.c:520:13
    #4 0x560e61a0a69e in tc6393xb_nand_writeb hw/display/tc6393xb.c:380:13
    #5 0x560e619f9bf7 in tc6393xb_writeb hw/display/tc6393xb.c:524:9
    #6 0x560e647c7d03 in memory_region_write_accessor softmmu/memory.c:492:5
    #7 0x560e647c7641 in access_with_adjusted_size softmmu/memory.c:554:18
    #8 0x560e647c5f66 in memory_region_dispatch_write softmmu/memory.c:1514:16
    #9 0x560e6485409e in flatview_write_continue softmmu/physmem.c:2825:23
    #10 0x560e648421eb in flatview_write softmmu/physmem.c:2867:12
    #11 0x560e64841ca8 in address_space_write softmmu/physmem.c:2963:18
    #12 0x560e61170162 in qemu_writeb tests/qtest/videzzo/videzzo_qemu.c:1080:5
    #13 0x560e6116eef7 in dispatch_mmio_write tests/qtest/videzzo/videzzo_qemu.c:1227:28

0x61f000000de0 is located 0 bytes to the right of 3424-byte region [0x61f000000080,0x61f000000de0)
allocated by thread T0 here:
    #0 0x560e611276cf in malloc /root/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x7f7959a87e98 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x57e98)
    #2 0x560e64b98871 in object_new qom/object.c:749:12
    #3 0x560e64b5d1a1 in qdev_new hw/core/qdev.c:153:19
    #4 0x560e61547ea5 in nand_init hw/block/nand.c:639:11
    #5 0x560e619f8772 in tc6393xb_init hw/display/tc6393xb.c:558:16
    #6 0x560e6390bad2 in tosa_init hw/arm/tosa.c:250:12

SUMMARY: AddressSanitizer: heap-buffer-overflow hw/block/nand.c:101:20 in mem_and
==15750==ABORTING

Broken since introduction in commit 3e3d5815cb ("NAND Flash memory
emulation and ECC calculation helpers for use by NAND controllers").

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1445
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1446
Reported-by: Qiang Liu <cyruscyliu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240409135944.24997-4-philmd@linaro.org>
(cherry picked from commit d39fdfff348fdf00173b7a58e935328a64db7d28)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/nand.c b/hw/block/nand.c
index d945c0b9e3..902cc56a03 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -255,7 +255,9 @@ static unsigned nand_load_block(NANDFlashState *s, unsigned offset)
 {
     unsigned iolen;
 
-    s->blk_load(s, s->addr, offset);
+    if (!s->blk_load(s, s->addr, offset)) {
+        return 0;
+    }
 
     iolen = (1 << s->page_shift);
     if (s->gnd) {
@@ -783,6 +785,10 @@ static bool glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
         return false;
     }
 
+    if (offset > NAND_PAGE_SIZE + OOB_SIZE) {
+        return false;
+    }
+
     if (s->blk) {
         if (s->mem_oob) {
             if (blk_pread(s->blk, SECTOR(addr) << BDRV_SECTOR_BITS,
-- 
2.39.2


