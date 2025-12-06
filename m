Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EEDD374BD
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 07:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRmep-00020b-1i; Sat, 06 Dec 2025 02:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vRmel-0001zv-Av
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 02:24:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vRmeh-0008WK-PZ
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 02:24:37 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx6tEf2jNpabUrAA--.29337S3;
 Sat, 06 Dec 2025 15:24:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxM+Qc2jNpoVdGAQ--.54839S2;
 Sat, 06 Dec 2025 15:24:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, lixianglai@loongson.cn
Subject: [RFC PATCH v2 0/2] LoongArch : Add KVM DINTC support
Date: Sat,  6 Dec 2025 14:59:50 +0800
Message-Id: <20251206065952.714540-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+Qc2jNpoVdGAQ--.54839S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Test;
1. add kernel patch:
https://patchew.org/linux/20251206064658.714100-1-gaosong@loongson.cn/

2. run script with '-cpu max,msgint=on' and virt,dmsi=on.
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
3  the vm can work well with with net test, such as netperf or iperf test.

Thanks.
Song Gao.

Song Gao (2):
  target/loongarch: Add kvm support dintc
  add avec irqchip in kernel support

 hw/intc/loongarch_dintc.c         | 14 +++++++
 hw/intc/loongarch_dintc_kvm.c     | 50 ++++++++++++++++++++++
 hw/intc/meson.build               |  2 +
 include/hw/intc/loongarch_dintc.h |  9 ++++
 linux-headers/asm-loongarch/kvm.h |  4 ++
 linux-headers/linux/kvm.h         |  2 +
 target/loongarch/cpu.c            |  4 +-
 target/loongarch/cpu.h            |  1 +
 target/loongarch/kvm/kvm.c        | 69 +++++++++++++++++++++++++++++++
 9 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 hw/intc/loongarch_dintc_kvm.c

-- 
2.51.0


