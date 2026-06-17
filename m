Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825B2CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsjp-0002r7-7k; Wed, 17 Jun 2026 12:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wZsja-0002os-MI; Wed, 17 Jun 2026 12:03:26 -0400
Received: from m16.mail.163.com ([220.197.31.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wZsjV-0000aZ-PH; Wed, 17 Jun 2026 12:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=P+
 GXD2ZZZ4P+6ukCDik5P2y5MkYdLrS9uYLM9b2o6mA=; b=KXeSiLwppfPQ6k6z4r
 ed9R6pJx08trLsrA7y+yapvaQXS4eXvIj1wy8pSVsIvXxiho6JLS+hDpquS4+w91
 Lzsea+RKIBg9ajbFqFHBLdjKD8V96UqT8V4IUAN2nR6FKUGZXWzbnNbv9P0F4Xe8
 B0TE5xT0hJAU1XkZz4JNmgZJM=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wD339FjxDJqmwGZEA--.19873S3; 
 Wed, 17 Jun 2026 23:59:35 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH 1/1] fixed sdma boundary bug
Date: Wed, 17 Jun 2026 23:58:57 +0800
Message-ID: <20260617155857.7451-2-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617155857.7451-1-dingtao0430@163.com>
References: <20260617155857.7451-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD339FjxDJqmwGZEA--.19873S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1rur43JFW8Xw1xGr4fAFb_yoWrGw13pF
 ZFyr4Sgrs7AFy5Z3WkCa4rCFyUuwsrAa43Jr1FyrnY9a1YkFnYqw13K3WrKrW8XrWxXw13
 ArZxtr1Yva4UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziH7K3UUUUU=
X-Originating-IP: [112.193.82.42]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4ghysGoyxGhpwAAA31
Received-SPF: pass client-ip=220.197.31.4; envelope-from=dingtao0430@163.com;
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
to request a system address update. But the emulation fails to clear the
SDHC_DOING_READ/WRITE flags after DMA completion, so writes to SDHC_SYSAD are
ignored. Clear these flags when the transfer ends. 
(according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf section 2.2.1)

This is a QTest in npcm7xx_sdhci-test that exercises this boundary condition and
validates the fix.

QTest steps:
  1. Replace npcm7xx_sdhci-test.c with the updated version (full code
     available at: https://pastebin.com/AWVp2wFi).
  2. Build with:
       ../configure --target-list="arm-softmmu,aarch64-softmmu" \
                    --disable-slirp --enable-debug --disable-werror
       ninja qemu-system-arm tests/qtest/npcm7xx_sdhci-test
  3. Run the specific test case:
       QTEST_QEMU_BINARY=./qemu-system-arm \
         ./tests/qtest/npcm7xx_sdhci-test \
         -p /arm/npcm7xx_sdhci/read_sd_sdma_boundary_continue

Before the fix, the test fails with a BLKCNT assertion:
  ERROR:...wait_for_block_count: assertion failed (qtest_readw(...) == expected): (1 == 0)

After applying the fix, the test passes:
  ok 1 /arm/npcm7xx_sdhci/read_sd_sdma_boundary_continue

The new test case ensures the SDMA boundary handling works correctly and
prevents future regressions.


Uboot test:
    1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config (MMC_SDHCI_SDMA=y).
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



Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/sd/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c86dfa281f..0d87289ca4 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -644,6 +644,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 s->data_count = 0;
             }
             if (page_aligned && boundary_count == 0) {
+                s->prnsts &= ~SDHC_DOING_READ;
                 break;
             }
         }
@@ -669,6 +670,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 }
             }
             if (page_aligned && boundary_count == 0) {
+                s->prnsts &= ~SDHC_DOING_WRITE;
                 break;
             }
         }
-- 
2.43.0


