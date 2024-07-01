Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1683C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 03:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO7se-00055P-GB; Sun, 30 Jun 2024 23:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sO7sc-00054w-7g; Sun, 30 Jun 2024 23:39:02 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sO7sZ-0005HV-DW; Sun, 30 Jun 2024 23:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719805127; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=fv0330CMgYf+cwa0a7U4PQFK68rmk5XY9FRKRR4A34Q=;
 b=id5s4VhhZhH8xIeMdf9OzPm3UOZGJSXkQlSDoKs+klbrqMFP7iBk4DlUnRJ6ahFmleTMQUAa70tbG8nRFo4/0k5jHIuLAKnfNmaTaM8mbXWi9KMe05nKEmShIld+X9RA+s98t3ry3m7jTIwdRfzqSUpcdTnKPfQQ1FpQxMgoTrM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W9YPs85_1719805124; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9YPs85_1719805124) by smtp.aliyun-inc.com;
 Mon, 01 Jul 2024 11:38:45 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH 0/6] target/riscv: Expose RV32 cpu to RV64 QEMU
Date: Mon,  1 Jul 2024 11:37:16 +0800
Message-Id: <20240701033722.954-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
qemu-system-riscv64 can directly boot a RV32 Linux.

This patch set has been tested with 6.9.0 Linux Image.

- Run RV64 QEMU with RV32 CPU
qemu-system-riscv64 -cpu rv32 -M virt -nographic \
    -kernel Image \
    -append "root=/dev/vda ro console=ttyS0" \
    -drive file=rootfs.ext2,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 -netdev user,id=net0 \
    -device virtio-net-device,netdev=net0

OpenSBI v1.4
QEMU emulator version 9.0.50 (v9.0.0-1132-g7799dc2e3b)
[    0.000000] Linux version 6.9.0 (developer@11109ca35736) (riscv32-unknown-linux-gnu-gcc (gc891d8dc23e-dirty) 13.2.0, GNU ld (GNU Binutils) 2.42) #3 SMP Fri May 31 08:42:15 UTC 2024
[    0.000000] random: crng init done
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80400000
[    0.000000] Machine model: riscv-virtio,qemu
[    0.000000] SBI specification v2.0 detected
[    0.000000] SBI implementation ID=0x1 Version=0x10004
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] SBI SRST extension detected
[    0.000000] SBI DBCN extension detected
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x80000000..0x8003ffff (256 KiB) nomap non-reusable mmode_resv1@80000000
[    0.000000] OF: reserved mem: 0x80040000..0x8004ffff (64 KiB) nomap non-reusable mmode_resv0@80040000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000080400000-0x0000000087ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080400000-0x0000000087ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080400000-0x0000000087ffffff]
[    0.000000] On node 0, zone Normal: 1024 pages in unavailable ranges
[    0.000000] SBI HSM extension detected
[    0.000000] riscv: base ISA extensions acdfhim
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: Embedded 17 pages/cpu s37728 r8192 d23712 u69632
[    0.000000] Kernel command line: root=/dev/vda ro console=ttyS0
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 31465
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] Virtual kernel memory layout:
[    0.000000]       fixmap : 0x9c800000 - 0x9d000000   (8192 kB)
[    0.000000]       pci io : 0x9d000000 - 0x9e000000   (  16 MB)
[    0.000000]      vmemmap : 0x9e000000 - 0xa0000000   (  32 MB)
[    0.000000]      vmalloc : 0xa0000000 - 0xc0000000   ( 512 MB)
[    0.000000]       lowmem : 0xc0000000 - 0xc7c00000   ( 124 MB)
[    0.000000] Memory: 95700K/126976K available (9090K kernel code, 8845K rwdata, 4096K rodata, 4231K init, 341K bss, 31276K reserved, 0K cma-reserved)
...
Welcome to Buildroot
buildroot login: root
# cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : rv32imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_sstc
mmu             : sv32

TANG Tiancheng (6):
  target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
  target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
  target/riscv: Correct SXL return value for RV32 in RV64 QEMU
  target/riscv: Detect sxl to set bit width for RV32 in RV64
  target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
  target/riscv: Enable RV32 CPU support in RV64 QEMU

 configs/targets/riscv64-softmmu.mak |  2 +-
 hw/riscv/boot.c                     | 35 +++++++++++++++++++----------
 hw/riscv/sifive_u.c                 |  3 ++-
 include/hw/riscv/boot.h             |  4 +++-
 include/hw/riscv/boot_opensbi.h     | 29 ++++++++++++++++++++++++
 target/riscv/cpu.c                  | 17 ++++++++++----
 target/riscv/cpu.h                  |  5 ++++-
 target/riscv/cpu_helper.c           | 23 ++++++++++++++-----
 target/riscv/pmp.c                  |  2 +-
 9 files changed, 93 insertions(+), 27 deletions(-)

-- 
2.43.0


