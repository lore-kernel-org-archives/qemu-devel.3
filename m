Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE893CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 06:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKrtX-0000ka-L6; Thu, 07 May 2026 02:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wKrtV-0000kS-4R
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:07:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wKrtS-0004oV-6b
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:07:32 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxzsAVLPxpg2EHAA--.188S3;
 Thu, 07 May 2026 14:07:18 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDxSMETLPxpzBh8AA--.25537S3;
 Thu, 07 May 2026 14:07:15 +0800 (CST)
Subject: Re: [PATCH 0/4] LoongArch : Add KVM DINTC support
From: gaosong <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn
References: <20260427070029.1059386-1-gaosong@loongson.cn>
Message-ID: <577c1aab-21c6-c9bb-4667-ebf6a60ba82d@loongson.cn>
Date: Thu, 7 May 2026 14:09:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260427070029.1059386-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxSMETLPxpzBh8AA--.25537S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1DCrWDAF15KrWxXrWDGFX_yoWrWFy7pa
 47Ar1UWr98Gr9xAF1qv3Waqr4kXFs7A3ZF9a4UW3s2yrWS9F18Wwn29r1kWr9Fy348CFy8
 XF43JryDuF97urgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqW
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.736, SPF_HELO_NONE=0.001,
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

Ping ~

ÔÚ 2026/4/27 ÏÂÎç3:00, Song Gao Ð´µÀ:
> Hi
>
> This series adds KVM put/get support for msgint CSRs and introduces
> msgint feature checks. It also adds kvm_dintc_realize() when
> kvm_irqchip_in_kernel is enabled, which creates and initializes the DINTC
> device in kernel mode.
>
> Since the kernel now supports DINTC on the KVM model,
> this series of updates will no longer use the 'RFC' header;
>
> In addition, this series updates the Linux header files to version 7.1-rc1,
> and updates the `update-linux-headers.sh` script to include `typelimits.h`.
>
> About Testing:
> 1. run script with '-cpu max,msgint=on' and 'virt,dmsi=on.'
> '
> ./build/qemu-system-loongarch64 -accel kvm \
>       -bios /usr/share/edk2/loongarch64/QEMU_EFI-silent-pflash.raw \
>       -cpu max,msgint=on\
>       -smp 4 \
>       -machine virt,dmsi=on,kernel_irqchip=on\
>       -m 16G \
>       -netdev tap,id=net0,ifname=tap0,script=/root/net.sh,downscript=no,vhost=on,queues=4 \
>      -device virtio-net-pci,netdev=net0,mq=on,vectors=128,mac=52:54:00:12:34:56 \
>       -monitor telnet:localhost:4418,server,nowait \
>      -device virtio-gpu-pci \
>      -drive if=none,id=disk0,file=/home/kvm/lns23.qcow2,format=qcow2 \
>      -device virtio-blk-pci,drive=disk0,id=virtio_disk0 \
>      --nographic
> '
> 2  the vm can work well with with net test, such as netperf or iperf test.
>
> Thanks.
> Song Gao
>
>
> Song Gao (4):
>    update-linux-headers.sh: add typelimits.h to portable header list
>    linux-headers: update to Linux 7.1-rc1
>    target/loongarch: Add kvm support dintc
>    Add dintc kvm_irqchip_in_kernel support
>
>   hw/intc/loongarch_dintc.c                     |  13 +
>   hw/intc/loongarch_dintc_kvm.c                 |  48 ++
>   hw/intc/meson.build                           |   2 +
>   include/hw/intc/loongarch_dintc.h             |  10 +
>   include/standard-headers/drm/drm_fourcc.h     |  28 +-
>   include/standard-headers/linux/const.h        |  18 +
>   include/standard-headers/linux/ethtool.h      |  28 +-
>   .../linux/input-event-codes.h                 |  13 +
>   include/standard-headers/linux/pci_regs.h     |  71 ++-
>   include/standard-headers/linux/typelimits.h   |   8 +
>   include/standard-headers/linux/virtio_ring.h  |   3 +-
>   include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
>   include/standard-headers/linux/vmclock-abi.h  |  20 +
>   linux-headers/asm-arm64/kvm.h                 |   1 +
>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>   linux-headers/asm-generic/unistd.h            |   5 +-
>   linux-headers/asm-loongarch/kvm.h             |   5 +
>   linux-headers/asm-loongarch/kvm_para.h        |   1 +
>   linux-headers/asm-loongarch/unistd_64.h       |   2 +
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/kvm.h                 |  11 +-
>   linux-headers/asm-riscv/ptrace.h              |  37 ++
>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>   linux-headers/asm-s390/unistd_32.h            | 446 ------------------
>   linux-headers/asm-s390/unistd_64.h            |   1 +
>   linux-headers/asm-x86/kvm.h                   |  21 +-
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/const.h                   |  18 +
>   linux-headers/linux/iommufd.h                 |  48 ++
>   linux-headers/linux/kvm.h                     |  46 +-
>   linux-headers/linux/mshv.h                    |   4 +-
>   linux-headers/linux/psp-sev.h                 |   2 +-
>   linux-headers/linux/stddef.h                  |   4 +
>   linux-headers/linux/vduse.h                   |  85 +++-
>   linux-headers/linux/vfio.h                    |  30 +-
>   scripts/update-linux-headers.sh               |   1 +
>   target/loongarch/cpu.c                        |   5 +-
>   target/loongarch/cpu.h                        |   1 +
>   target/loongarch/kvm/kvm.c                    |  69 +++
>   46 files changed, 857 insertions(+), 496 deletions(-)
>   create mode 100644 hw/intc/loongarch_dintc_kvm.c
>   create mode 100644 include/standard-headers/linux/typelimits.h
>   create mode 100644 include/standard-headers/linux/virtio_rtc.h
>   delete mode 100644 linux-headers/asm-s390/unistd_32.h
>


