Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E2BC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 03:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thgdp-0007CA-IC; Mon, 10 Feb 2025 22:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1thgdm-0007AR-Nv
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 22:08:50 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1thgdi-0000Li-KA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 22:08:49 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Ax3eI0v6pn+dZxAA--.28086S3;
 Tue, 11 Feb 2025 11:08:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxbsUyv6pnL1YLAA--.43924S2;
 Tue, 11 Feb 2025 11:08:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v5 0/7] hw/loongarch/virt: Add cpu hotplug support
Date: Tue, 11 Feb 2025 11:08:27 +0800
Message-Id: <20250211030834.3276732-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxbsUyv6pnL1YLAA--.43924S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

LoongArch cpu hotplug is based on ACPI GED device, it depends on
patchset where TYPE_HOTPLUG_HANDLER interface is added in ipi and extioi
interrupt controller class for cpu hotplug event notification.
  https://lore.kernel.org/qemu-devel/0d920309-c7ba-48d8-b46d-04ac1e38efc7@linaro.org/T/#t

It can be verified with qemu command:
  qemu-system-loongarch64 -smp 2,maxcpus=16,sockets=4,cores=4,threads=1
and vcpu can be added or remove with hmp command:
  device_add la464-loongarch-cpu,socket-id=0,core-id=2,thread-id=0,id=cpu-2
  device_del cpu-2

---
v4 ... v5:
  1. Use new calculation logic about physical cpu id, the max core-id and
     thread-id is aligned up with power of 2.
  2. Remove num-cpu property with ipi and extioi interrupt controller,
     TYPE_HOTPLUG_HANDLER interface is added with the interrupt
     controllers for cpu hotplug event notification.
 
v3 ... v4:
  1. For cold-plug CPUs, move socket-id/core-id/thread-id property
     setting from preplug function to CPU object creating loop, since
     there is topo information calculation already in CPU object creating
     loop.
  2. Init interrupt pin of CPU object in cpu plug interface for both
     cold-plug CPUs and hot-plug CPUs.
  3. Apply the patch based on latest qemu version.

v2 ... v3:
  1. Use qdev_realize_and_unref() with qdev_realize() and object_unref().
  2. Set vcpus_count with 1 since vcpu object is created for every thread.
  3. Remove property hw-id, use internal variable hw_id to differentiate
     cold-plug cpus and hot-plug cpus.
  4. Add generic function virt_init_cpu_irq() to init interrupt pin
     of CPU object, used by both cold-plug and hot-plug CPUs

v1 ... v2:
  1. Add new property hw-id, property hw-id is set for cold-added CPUs,
     and property socket-id/core-id/thread-id is set for hot-added CPUs.
     The two properties can be generated from each other.
  2. Use general hotplug api such as hotplug_handler_pre_plug etc
  3. Reorganize the patch order, split the patch set into 4 small
     patches.
---
Bibo Mao (7):
  hw/loongarch/virt: Add CPU topology support
  hw/loongarch/virt: Add topo properties on CPU object
  hw/loongarch/virt: Add basic cpu plug interface framework
  hw/loongarch/virt: Implement cpu unplug interface
  hw/loongarch/virt: Implement cpu plug interface
  hw/loongarch/virt: Update the ACPI table for hotplug cpu
  hw/loongarch/virt: Enable cpu hotplug feature on virt machine

 hw/loongarch/Kconfig           |   1 +
 hw/loongarch/virt-acpi-build.c |  35 +++-
 hw/loongarch/virt.c            | 284 ++++++++++++++++++++++++++++++---
 include/hw/loongarch/virt.h    |   1 +
 target/loongarch/cpu.c         |  23 +++
 target/loongarch/cpu.h         |  11 ++
 6 files changed, 333 insertions(+), 22 deletions(-)

-- 
2.39.3


