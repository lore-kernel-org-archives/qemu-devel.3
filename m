Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8D0D41D45
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 02:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAgTl-0007Ci-I4; Mon, 11 Nov 2024 21:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tAgTd-0007BI-Vt
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:17:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tAgTa-00045o-MH
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:17:57 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxC+LDujJnHbg7AA--.52216S3;
 Tue, 12 Nov 2024 10:17:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx98DCujJniixSAA--.12416S2;
 Tue, 12 Nov 2024 10:17:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] hw/loongarch/virt: Add cpu hotplug support
Date: Tue, 12 Nov 2024 10:17:32 +0800
Message-Id: <20241112021738.1952851-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx98DCujJniixSAA--.12416S2
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

LoongArch cpu hotplug is based on ACPI GED device, there is a little
change about ipi and extioi device, the value of num-cpu property is
maximum cpu number rather than present cpu number.

It can be verified with qemu command:
  qemu-system-loongarch64 -smp 2,maxcpus=16,sockets=4,cores=4,threads=1
and vcpu can be added or remove with hmp command:
  device_add la464-loongarch-cpu,socket-id=0,core-id=2,thread-id=0,id=cpu-2
  device_del cpu-2

---
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
Bibo Mao (6):
  hw/loongarch/virt: Add CPU topology support
  hw/loongarch/virt: Implement cpu plug interface
  hw/loongarch/virt: Add generic function to init interrupt pin of CPU
  hw/loongarch/virt: Init interrupt pin of CPU during plug interface
  hw/loongarch/virt: Update the ACPI table for hotplug cpu
  hw/loongarch/virt: Enable cpu hotplug feature on virt machine

 docs/system/loongarch/virt.rst |  31 +++
 hw/loongarch/Kconfig           |   1 +
 hw/loongarch/acpi-build.c      |  35 ++-
 hw/loongarch/virt.c            | 374 ++++++++++++++++++++++++++++-----
 include/hw/loongarch/virt.h    |   3 +
 target/loongarch/cpu.c         |  25 +++
 target/loongarch/cpu.h         |  17 ++
 7 files changed, 428 insertions(+), 58 deletions(-)


base-commit: 134b443512825bed401b6e141447b8cdc22d2efe
-- 
2.39.3


