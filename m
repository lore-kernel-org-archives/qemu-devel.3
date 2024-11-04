Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5DDD111B2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 06:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7qfu-0003qK-Ud; Mon, 04 Nov 2024 01:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t7qfr-0003pR-Oq
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 01:34:51 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t7qfo-0007qE-1N
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 01:34:51 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxG+L9aihnKq0tAA--.26005S3;
 Mon, 04 Nov 2024 14:34:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxjkf8aihn7bY9AA--.50651S2;
 Mon, 04 Nov 2024 14:34:36 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] hw/loongarch/virt: Add cpu hotplug support
Date: Mon,  4 Nov 2024 14:34:30 +0800
Message-Id: <20241104063435.4130262-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxjkf8aihn7bY9AA--.50651S2
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

LoongArch cpu hotplug is based on ACPI GED device, there is a little
change about ipi and extioi device, the value of num-cpu property is
maximum cpu number rather than present cpu number.

It can be verified with qemu command:
  qemu-system-loongarch64 -smp 2,maxcpus=16,sockets=4,cores=4,threads=1
and vcpu can be added or remove with hmp command:
  device_add la464-loongarch-cpu,socket-id=0,core-id=2,thread-id=0,id=cpu-2
  device_del cpu-2

---
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
Bibo Mao (5):
  hw/loongarch/virt: Add CPU topology support
  hw/loongarch/virt: Implement cpu plug interface
  hw/loongarch/virt: Add generic function to init interrupt pin of CPU
  hw/loongarch/virt: Update the ACPI table for hotplug cpu
  hw/loongarch/virt: Enable cpu hotplug feature on virt machine

 docs/system/loongarch/virt.rst |  31 +++
 hw/loongarch/Kconfig           |   1 +
 hw/loongarch/acpi-build.c      |  35 +++-
 hw/loongarch/virt.c            | 349 +++++++++++++++++++++++++++++----
 include/hw/loongarch/virt.h    |   3 +
 target/loongarch/cpu.c         |  25 +++
 target/loongarch/cpu.h         |  17 ++
 7 files changed, 416 insertions(+), 45 deletions(-)


base-commit: 92ec7805190313c9e628f8fc4eb4f932c15247bd
-- 
2.39.3


