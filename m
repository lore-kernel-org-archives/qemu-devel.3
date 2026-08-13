Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AACDC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuTdk-0001QG-Kj; Thu, 13 Aug 2026 07:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wuTdh-0001Pc-A7
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:30:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wuTdc-0004E2-5H
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:30:23 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxTtO+qn1qv+MAAA--.2643S3;
 Thu, 13 Aug 2026 19:30:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxOs6+qn1q5lQDAA--.4396S2;
 Thu, 13 Aug 2026 19:30:06 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn,
 gaosong <gaosong@loongson.cn>
Subject: [PATCH v4 0/3] LoongArch : Add KVM DINTC support
Date: Thu, 13 Aug 2026 19:09:57 +0800
Message-Id: <20260813111000.446232-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxOs6+qn1q5lQDAA--.4396S2
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

From: gaosong <gaosong@loongson.cn>

Hi

This series adds KVM put/get support for msgint CSRs and introduces
msgint feature checks. It also adds kvm_dintc_realize() when
kvm_irqchip_in_kernel is enabled, which creates and initializes the DINTC
device in kernel mode.

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


V4:
   Rebase,and fix build error.
V3:
   Rebase,add patch4 to disable msgint in KVM model.


Thanks,
Song Gao

Song Gao (3):
  target/loongarch: Add kvm support dintc
  Add dintc kvm_irqchip_in_kernel support
  target/loongarch: KVM disable msgint

 hw/intc/loongarch_dintc.c         | 13 ++++++
 hw/intc/loongarch_dintc_kvm.c     | 48 ++++++++++++++++++++
 hw/intc/meson.build               |  2 +
 include/hw/intc/loongarch_dintc.h | 10 +++++
 target/loongarch/cpu.c            |  8 ++--
 target/loongarch/cpu.h            |  1 +
 target/loongarch/kvm/kvm.c        | 74 +++++++++++++++++++++++++++++++
 7 files changed, 153 insertions(+), 3 deletions(-)
 create mode 100644 hw/intc/loongarch_dintc_kvm.c

-- 
2.47.3


