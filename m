Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31623CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 03:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxeW6-0005HC-DK; Sun, 06 Oct 2024 23:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxeW4-0005Gs-Eo; Sun, 06 Oct 2024 23:34:36 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxeW0-00061U-5I; Sun, 06 Oct 2024 23:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728272060; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=E+5TpfXMKZDcVpCu/dQJIu+Ys9zql+sHdv0FAFYfOe8=;
 b=PE7/mXiae7PZuOxKBFamxtoCwEe9ACwNNxOBJujiV+vdbzPlk3yZah2VzbrEDLYMxtxIYLr7c0n2KZRIfhCAFFnADIhKcjxUIkmQtBjpGNCicYeWrRDQwtJNH0t7xFtvtqq7B+tF4Or1sPACbNn4N6+07oC2QsWxlxMyVl/2oDU=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGLTlXq_1728272057) by smtp.aliyun-inc.com;
 Mon, 07 Oct 2024 11:34:18 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 0/7] target/riscv: Support SXL32 on RV64 CPU
Date: Mon,  7 Oct 2024 11:33:53 +0800
Message-Id: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We have implemented UXL32 on QEMU already. It enables us to run RV32
applications on RV64 Linux on QEMU. Similarly, RISCV specification
doesn't limit the SXLEN to be the same with MXLEN. In this patch set,
we will go forward to implement SXL32 on RV64 CPU.

SXL is one filed in mstatus. It defines the SXLEN. After CPU reset,
SXL will be same with MXL in misa.

According to the RISC-V privilege specification, Smode CSR with SXLEN
length will usually be read and written in an SXLEN view, no matter
current XLEN is 32bit or 64bit. Thus if MXLEN=64 and SXLEN=32, M mode
register will read or write them in the same way under RV32 layout.

In this patch set, we carefully process the Smode CSR write and read
for SXL32. This includes explicitly CSR write/read, and implicitly
CSR read such as satp read in PTW(page table walk).

Another thing we do in this patch set is that we introduce a property
of CPU, named sxl32. It provides us a way to override the default sxl64
for RV64 cpu after cpu reset. The reason is OpenSBI currently doesn't
dynamically probe or configure SXLEN. When we want to run RV64 OpenSBI
in M mode and RV32 Linux in S mode, OpenSBI will not prepare the SXL32
environment for RV32 Linux. sxl32 property will also forbidden writing SXL
field in mstatus, which means QEMU can ensure an SXL32 environment for Linux.

We've successfully booted 64-bit OpenSBI and 32-bit Linux system on
RV64 CPU, with a minor fix of Linux.

Tested by follow steps:

 - Prepare Linux rv32 Image && rv64 Image
  Please apply the patch of linux before test. You can get the patch in
https://github.com/romanheros/linux/commit/8444fb3c913d64c20b1e5334a29a66061eb3f5fe.

	$ cd linux
	$ make ARCH=riscv CROSS_COMPILE=riscv32-unknown-linux-gnu- O=../linux-rv32 defconfig
	$ make ARCH=riscv CROSS_COMPILE=riscv32-unknown-linux-gnu- O=../build-rv32 32-bit.config
	$ make ARCH=riscv CROSS_COMPILE=riscv32-unknown-linux-gnu- O=../linux-rv32/ -j $(nproc)
	$ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- O=../linux-rv64 defconfig
	$ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- O=../linux-rv64/ -j $(nproc)
	(Get Image in ../linux-rv32/arch/riscv/boot)

 - Prepare QEMU
 	$ git clone https://github.com/romanheros/qemu.git -b riscv-upstream-sxl32-v1
	$ cd qemu
	$ ./configure --target-list="riscv64-softmmu" --enable-slirp
	$ cd build; ninja

- Run 32-bit Linux boot on 64-bit RISC-V with Opensbi 64 :
	$ ./build/qemu-system-riscv64 -cpu rv64,sxl32=on -M virt -nographic \
		-bios opensbi/build/platform/generic/firmware/fw_dynamic.bin \
		-kernel linux-rv32/arch/riscv/boot/Image \
		-append "root=/dev/vda ro console=ttyS0" \
		-drive file=qemu_riscv32_virt_defconfig/images/rootfs.ext2,format=raw,id=hd0 \
		-netdev user,id=net0 -device virtio-net-device,netdev=net0
```
OpenSBI v1.4-112-g7b4bc9d
Build time: 2024-06-17 06:57:42 +0000
Build compiler: gcc version 13.2.0 (gc891d8dc23e-dirty)
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name             : riscv-virtio,qemu
Platform Features         : medeleg
Platform HART Count       : 1
Platform IPI Device       : aclint-mswi
Platform Timer Device     : aclint-mtimer @ 10000000Hz
Platform Console Device   : uart8250
Platform HSM Device       : ---
Platform PMU Device       : ---
Platform Reboot Device    : syscon-reboot
Platform Shutdown Device  : syscon-poweroff
Platform Suspend Device   : ---
Platform CPPC Device      : ---
Firmware Base             : 0x80000000
Firmware Size             : 583 KB
Firmware RW Offset        : 0x80000
Firmware RW Size          : 71 KB
Firmware Heap Offset      : 0x89000
Firmware Heap Size        : 35 KB (total), 2 KB (reserved), 11 KB (used), 21 KB (free)
Firmware Scratch Size     : 4096 B (total), 400 B (used), 3696 B (free)
Runtime SBI Version       : 2.0

Domain0 Name              : root
Domain0 Boot HART         : 0
Domain0 HARTs             : 0*
Domain0 Region00          : 0x0000000000100000-0x0000000000100fff M: (I,R,W) S/U: (R,W)
Domain0 Region01          : 0x0000000010000000-0x0000000010000fff M: (I,R,W) S/U: (R,W)
Domain0 Region02          : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
Domain0 Region03          : 0x0000000080080000-0x000000008009ffff M: (R,W) S/U: ()
Domain0 Region04          : 0x0000000080000000-0x000000008007ffff M: (R,X) S/U: ()
Domain0 Region05          : 0x000000000c400000-0x000000000c5fffff M: (I,R,W) S/U: (R,W)
Domain0 Region06          : 0x000000000c000000-0x000000000c3fffff M: (I,R,W) S/U: (R,W)
Domain0 Region07          : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
Domain0 Next Address      : 0x0000000080200000
Domain0 Next Arg1         : 0x0000000087e00000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes
Domain0 SysSuspend        : yes

Boot HART ID              : 0
Boot HART Domain          : root
Boot HART Priv Version    : v1.12
Boot HART Base ISA        : rv64imafdch
Boot HART ISA Extensions  : sstc,zicntr,zihpm,zicboz,zicbom,sdtrig
Boot HART PMP Count       : 16
Boot HART PMP Granularity : 2 bits
Boot HART PMP Address Bits: 54
Boot HART MHPM Info       : 16 (0x0007fff8)
Boot HART Debug Triggers  : 2 triggers
Boot HART MIDELEG         : 0x0000000000001666
Boot HART MEDELEG         : 0x0000000000f0b509
[    0.000000] Linux version 6.10.0-rc3-00100-gec0abe37042f (developer@95e6e39b54aa) (riscv32-unknown-linux-gnu-gcc (gc891d8dc23e-dirty) 13.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP Sat Jun 15 13:01:52 UTC 2024
[    0.000000] random: crng init done
[    0.000000] Machine model: riscv-virtio,qemu
[    0.000000] SBI specification v2.0 detected
[    0.000000] SBI implementation ID=0x1 Version=0x10004
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] SBI SRST extension detected
[    0.000000] SBI DBCN extension detected
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x0000000080000000..0x000000008007ffff (512 KiB) nomap non-reusable mmode_resv1@80000000
[    0.000000] OF: reserved mem: 0x0000000080080000..0x000000008009ffff (128 KiB) nomap non-reusable mmode_resv0@80080000
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080000000-0x0000000087ffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000008009ffff]
[    0.000000]   node   0: [mem 0x00000000800a0000-0x0000000087ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x0000000087ffffff]
[    0.000000] SBI HSM extension detected
[    0.000000] riscv: base ISA extensions acdfhim
[    0.000000] riscv: ELF capabilities acdfim
......
Starting network: udhcpc: started, v1.36.1
udhcpc: broadcasting discover
udhcpc: broadcasting select for 10.0.2.15, server 10.0.2.2
udhcpc: lease of 10.0.2.15 obtained from 10.0.2.2, lease time 86400
deleting routers
adding dns 10.0.2.3
OK

Welcome to Buildroot
buildroot login: root
# cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_sstc
mmu             : sv57
mvendorid       : 0x0
marchid         : 0x0
mimpid          : 0x0
hart isa        : rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_sstc
```

This doesn't mean we have addressed all the challenges for this problem. The to do list is here:
1. OpenSBI need accept a parameter from firmware the next boot level is SXL32 instead of only S mode.
2. OpenSBI should dynamically configure the SXL32 environment for next boot.
3. OpenSBI should ensure SBI calls for RV32 are right implemented even M mode is RV64.
4. OpenSBI should override details of machine configuration for RV32 Linux, such as rv64i ISA description in DTB.

Having all of them been addressed, we can allow the SXL write in mstatus. But this todo list depends on
a runnable environment, which is provided by this patch set.

This patch set is based on the patch set[1] under review. You can also fetch the branch from my repo[2].

[1]: https://mail.gnu.org/archive/html/qemu-riscv/2024-09/msg00501.html
[2]: https://github.com/romanheros/qemu/tree/riscv-upstream-sxl32-v1

TANG Tiancheng (7):
  target/riscv: Fix sstatus read and write
  target/riscv: Fix satp read and write implicitly or explicitly.
  target/riscv: Read pte and satp based on SXL in PTW
  hw/riscv: Align kernel to 4MB when sxl32 is on.
  target/riscv: Enable 32-bit only registers for RV64 with sxl32
  target/riscv: Reset SXL and UXL according to sxl32
  target/riscv: Expose sxl32 configuration in RISC-V CPU

 hw/riscv/boot.c           |  3 ++-
 target/riscv/cpu.c        | 14 ++++++++++++--
 target/riscv/cpu_cfg.h    |  4 ++++
 target/riscv/cpu_helper.c |  4 ++--
 target/riscv/csr.c        | 38 +++++++++++++++++++++++++-------------
 5 files changed, 45 insertions(+), 18 deletions(-)

-- 
2.43.0


