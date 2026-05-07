Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5255ACD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKvN0-0000B8-Pm; Thu, 07 May 2026 05:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wKvMx-0000AE-K3
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:50:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wKvMu-0005OG-Hz
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:50:11 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxvelEYPxp8XAHAA--.22439S3;
 Thu, 07 May 2026 17:49:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxD8NCYPxpUTJ8AA--.39812S2;
 Thu, 07 May 2026 17:49:54 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	lixianglai@loongson.cn,
	chenhuacai@loongson.cn
Subject: [PATCH v2 0/4] LoongArch : Add KVM DINTC support
Date: Thu,  7 May 2026 17:23:54 +0800
Message-Id: <20260507092358.2479135-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxD8NCYPxpUTJ8AA--.39812S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi

This series adds KVM put/get support for msgint CSRs and introduces
msgint feature checks. It also adds kvm_dintc_realize() when
kvm_irqchip_in_kernel is enabled, which creates and initializes the DINTC
device in kernel mode.

Since the kernel now supports DINTC on the KVM model,
this series of updates will no longer use the “RFC” header;

In addition, this series updates the Linux header files to version 7.1-rc1,
and updates the `update-linux-headers.sh` script to include `typelimits.h`.

About Testing:
1. run script with '-cpu max,msgint=on' and 'virt,dmsi=on.'
'
./build/qemu-system-loongarch64 -accel kvm \
     -bios /usr/share/edk2/loongarch64/QEMU_EFI-silent-pflash.raw \
     -cpu max,msgint=on\
     -smp 4 \
     -machine virt,dmsi=on,kernel_irqchip=on\
     -m 16G \
     -netdev tap,id=net0,ifname=tap0,script=/root/net.sh,downscript=no,vhost=on,queues=4 \
    -device virtio-net-pci,netdev=net0,mq=on,vectors=128,mac=52:54:00:12:34:56 \
     -monitor telnet:localhost:4418,server,nowait \
    -device virtio-gpu-pci \
    -drive if=none,id=disk0,file=/home/kvm/lns23.qcow2,format=qcow2 \
    -device virtio-blk-pci,drive=disk0,id=virtio_disk0 \
    --nographic
'
2  the vm can work well with with net test, such as netperf or iperf test.

Thanks.
Song Gao


Avihai Horon (2):
  scripts/update-linux-headers: Add typelimits.h
  linux-headers: Update to Linux v7.1-rc1

Song Gao (2):
  target/loongarch: Add kvm support dintc
  Add dintc kvm_irqchip_in_kernel support

 hw/intc/loongarch_dintc.c                     |  13 +
 hw/intc/loongarch_dintc_kvm.c                 |  48 ++
 hw/intc/meson.build                           |   2 +
 include/hw/intc/loongarch_dintc.h             |  10 +
 include/standard-headers/drm/drm_fourcc.h     |  28 +-
 include/standard-headers/linux/const.h        |  18 +
 include/standard-headers/linux/ethtool.h      |  28 +-
 .../linux/input-event-codes.h                 |  13 +
 include/standard-headers/linux/pci_regs.h     |  71 ++-
 include/standard-headers/linux/typelimits.h   |   8 +
 include/standard-headers/linux/virtio_ring.h  |   3 +-
 include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
 include/standard-headers/linux/vmclock-abi.h  |  20 +
 linux-headers/asm-arm64/kvm.h                 |   1 +
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/unistd.h            |   5 +-
 linux-headers/asm-loongarch/kvm.h             |   5 +
 linux-headers/asm-loongarch/kvm_para.h        |   1 +
 linux-headers/asm-loongarch/unistd_64.h       |   2 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |  11 +-
 linux-headers/asm-riscv/ptrace.h              |  37 ++
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/unistd_32.h            | 446 ------------------
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |  21 +-
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/const.h                   |  18 +
 linux-headers/linux/iommufd.h                 |  48 ++
 linux-headers/linux/kvm.h                     |  46 +-
 linux-headers/linux/mshv.h                    |   4 +-
 linux-headers/linux/psp-sev.h                 |   2 +-
 linux-headers/linux/stddef.h                  |   4 +
 linux-headers/linux/vduse.h                   |  85 +++-
 linux-headers/linux/vfio.h                    |  30 +-
 scripts/update-linux-headers.sh               |   2 +
 target/loongarch/cpu.c                        |   5 +-
 target/loongarch/cpu.h                        |   1 +
 target/loongarch/kvm/kvm.c                    |  69 +++
 46 files changed, 858 insertions(+), 496 deletions(-)
 create mode 100644 hw/intc/loongarch_dintc_kvm.c
 create mode 100644 include/standard-headers/linux/typelimits.h
 create mode 100644 include/standard-headers/linux/virtio_rtc.h
 delete mode 100644 linux-headers/asm-s390/unistd_32.h

-- 
2.54.0


