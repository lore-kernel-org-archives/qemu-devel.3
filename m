Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFB7C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7KE-00029I-GD; Tue, 07 Jul 2026 11:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wh7K8-000231-D5; Tue, 07 Jul 2026 11:03:02 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wh7K1-00057h-LF; Tue, 07 Jul 2026 11:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Oj
 X7rMG/jzjqf5gDOpqhm1rch0krsohxrDKPPQTAXWU=; b=OspjoMScRXmTpnUBC8
 zwsFecc1crzFUuPHRNTBybTyzBqBFgiQooWniZby8ThUD0B/GYxx3YYxeFBydCDY
 hff7UT6QHVp9+ufHwZidTphbWXGSVEfnyUvHeF37sYK5ORh8E++8GTKglb8yuAgw
 N3/t6IVdBzl+Yhe/SAwVOX2h8=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3w8c0FE1qkL+WIQ--.617S3;
 Tue, 07 Jul 2026 22:59:03 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Ding <dingtao0430@163.com>
Subject: [PATCH v4 1/2] hw/sd: sdhci: Fix SDMA boundary bug
Date: Tue,  7 Jul 2026 22:58:58 +0800
Message-ID: <20260707145859.12670-2-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707145859.12670-1-dingtao0430@163.com>
References: <20260707145859.12670-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3w8c0FE1qkL+WIQ--.617S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr13Ar4DZrWrZry7Aw1DKFg_yoWxWryfpF
 Zakr1rKr4kKr1xZa1kG3W5AF1Y9wsruasrKr45KrnYvFZxKF1FqwsFk3WUGry3trn7Zw12
 vrWUtrn093Wjqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pic4S7UUUUU=
X-Originating-IP: [175.152.42.218]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-RcAPmpNFDcZbQAA3k
Received-SPF: pass client-ip=117.135.210.4; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

During SDMA transfers, the controller raises an interrupt at buffer boundaries
to request a system address update. The host driver will rewrite the SDHC_SYSAD register. 
(according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf section 2.2.1)
However, the current code will ignore write operations to SDHC_SYSAD. 

To fix this bug, when SDMA encounters a boundary, a state is set to record it. 
In this state, SDHC_SYSAD can be written. In other cases, it is still protected by TRANSFERRING_DATA.

Suggested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
The reviewer pointed out an issue in patch v3. When s->blkcnt decreases to 1 the logic goes to
sdhci_sdma_transfer_single_block() where s->sdma_boundary_paused should be cleared too.


This bug may be encountered when using uboot with SDMA functionality, and can be reproduced by following the steps below.
Uboot test:
    1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config (MMC_SDHCI_SDMA=y).
        for more detail, can obtained 
        "https://lore.kernel.org/qemu-devel/20260617155857.7451-1-dingtao0430@163.com/T/#mcdf231e6bd762903f8393bf93253cbcb12ececcf"
    2. ./qemu-system-aarch64 -M xilinx-zynq-a9 -machine boot-mode=sd -m 1024 -display none -serial null -serial stdio -monitor none \
        -device loader,file=u-boot-dtb.bin,addr=0x04000000,cpu-num=0  \
        -drive file=zynq-sd.img,format=raw,if=sd -D qemu.log


After applying the fix, success load sd card:
  
U-Boot 2026.07-rc4-g1e80ee41441c (Jun 15 2026 - 19:05:05 +0800)

Model: Xilinx ZC702 board
DRAM:  ECC disabled 1 GiB
Core:  33 devices, 21 uclasses, devicetree: board
Flash: 0 Bytes
NAND:  0 MiB
MMC:   mmc@e0100000: 0
Loading Environment from FAT... *** Error - No Valid Environment Area found
*** Warning - bad env area, using default environment

In:    serial@e0001000
Out:   serial@e0001000
Err:   serial@e0001000
Net:   
ZYNQ GEM: e000b000, mdio bus e000b000, phyaddr 7, interface rgmii-id

Warning: ethernet@e000b000 (eth0) using random MAC address - 4a:63:5a:a4:d3:6b
eth0: ethernet@e000b000
Hit any key to stop autoboot: 0
Zynq> fatload mmc 0 ${kernel_addr_r} zImage
10838528 bytes read in 4316 ms (2.4 MiB/s)
Zynq> fatload mmc 0 ${ramdisk_addr_r} rootfs-arm32.cpio.gz
406531 bytes read in 199 ms (1.9 MiB/s)
Zynq> setenv ramdisk_size ${filesize}
Zynq> fatload mmc 0 ${fdt_addr_r} zynq-zc702.dtb
15754 bytes read in 21 ms (732.4 KiB/s)
Zynq> setenv bootargs console=ttyPS0,115200 earlycon ignore_loglevel rdinit=/init
Zynq> bootz ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_addr_r}
Kernel image @ 0x2000000 [ 0x000000 - 0xa56200 ]
## Flattened Device Tree blob at 01f00000
   Booting using the fdt blob at 0x1f00000
Working FDT set to 1f00000
   Loading Ramdisk to 2ff9c000, end 2ffff403 ... OK
   Loading Device Tree to 2ff95000, end 2ff9bd89 ... OK
Working FDT set to 2ff95000

Starting kernel ...

 hw/sd/sdhci.c         | 10 +++++++++-
 include/hw/sd/sdhci.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c86dfa281f..021e054f97 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -307,6 +307,7 @@ static void sdhci_reset(SDHCIState *s)
     s->data_count = 0;
     s->stopped_state = sdhc_not_stopped;
     s->pending_insert_state = false;
+    s->sdma_boundary_paused = false;
     if (object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_BE) ||
             object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_LE)) {
         s->norintstsen = 0x013f;
@@ -620,6 +621,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
     }
 
     s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
+    s->sdma_boundary_paused = false;
     if (s->trnmod & SDHC_TRNS_READ) {
         s->prnsts |= SDHC_DOING_READ;
         while (s->blkcnt) {
@@ -644,6 +646,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 s->data_count = 0;
             }
             if (page_aligned && boundary_count == 0) {
+                s->sdma_boundary_paused = true;
                 break;
             }
         }
@@ -669,6 +672,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 }
             }
             if (page_aligned && boundary_count == 0) {
+                s->sdma_boundary_paused = true;
                 break;
             }
         }
@@ -679,6 +683,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
     }
 
     if (s->blkcnt == 0) {
+        s->sdma_boundary_paused = false;
         sdhci_end_transfer(s);
     } else {
         sdhci_update_irq(s);
@@ -690,6 +695,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
 {
     uint32_t datacnt = s->blksize & BLOCK_SIZE_MASK;
 
+    s->sdma_boundary_paused = false;
     if (s->trnmod & SDHC_TRNS_READ) {
         sdbus_read_data(&s->sdbus, s->fifo_buffer, datacnt);
         dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt,
@@ -1164,6 +1170,7 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
                 SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
         s->blkgap &= ~(SDHC_STOP_AT_GAP_REQ | SDHC_CONTINUE_REQ);
         s->stopped_state = sdhc_not_stopped;
+        s->sdma_boundary_paused = false;
         s->norintsts &= ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
                 SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
         break;
@@ -1185,7 +1192,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
-        if (!TRANSFERRING_DATA(s->prnsts)) {
+        if (!TRANSFERRING_DATA(s->prnsts) || s->sdma_boundary_paused) {
             s->sdmasysad = (s->sdmasysad & mask) | value;
             MASKED_WRITE(s->sdmasysad, mask, value);
             /* Writing to last byte of sdmasysad might trigger transfer */
@@ -1508,6 +1515,7 @@ const VMStateDescription sdhci_vmstate = {
         VMSTATE_VBUFFER_UINT32(fifo_buffer, SDHCIState, 1, NULL, buf_maxsz),
         VMSTATE_TIMER_PTR(insert_timer, SDHCIState),
         VMSTATE_TIMER_PTR(transfer_timer, SDHCIState),
+        VMSTATE_BOOL(sdma_boundary_paused, SDHCIState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index a9da6203fc..c485277744 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -103,6 +103,8 @@ struct SDHCIState {
      * to be protected. Set wp_inverted to invert the signal.
      */
     bool wp_inverted;
+    /* Indicate that SDMA transfer is paused due to hitting the boundary */
+    bool sdma_boundary_paused;
 };
 typedef struct SDHCIState SDHCIState;
 
-- 
2.43.0


