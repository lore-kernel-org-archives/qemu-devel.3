Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0770D2E01C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3VYj-0004xl-7j; Wed, 23 Oct 2024 03:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t3VYZ-0004tQ-13
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:13:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t3VYW-0005GE-Ii
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:13:22 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxWOEJohhnUGQHAA--.17231S3;
 Wed, 23 Oct 2024 15:13:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxP+EIohhnpeYKAA--.63247S2;
 Wed, 23 Oct 2024 15:13:12 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/loongarch/virt: Add cpu hotplug support
Date: Wed, 23 Oct 2024 15:13:09 +0800
Message-Id: <20241023071312.881866-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxP+EIohhnpeYKAA--.63247S2
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
change about ipi device, the value of num-cpu property is maximum cpu
number rather than present cpu number.

It can be verified with qemu command:
  qemu-system-loongarch64 -smp 2,maxcpus=16,sockets=4,cores=4,threads=1
and vcpu can be added or remove with hmp command:
  device_add la464-loongarch-cpu,socket-id=0,core-id=2,thread-id=0,id=cpu-2
  device_del cpu-2

Bibo Mao (3):
  hw/loongarch/virt: Add CPU topology support
  hw/loongarch/virt: Add basic CPU plug support
  hw/loongarch/virt: Update the ACPI table for hotplug cpu

 docs/system/loongarch/virt.rst |  31 ++++
 hw/loongarch/Kconfig           |   1 +
 hw/loongarch/acpi-build.c      |  35 +++-
 hw/loongarch/virt.c            | 283 +++++++++++++++++++++++++++++++--
 include/hw/loongarch/virt.h    |   3 +
 target/loongarch/cpu.c         |  25 +++
 target/loongarch/cpu.h         |  11 ++
 7 files changed, 371 insertions(+), 18 deletions(-)


base-commit: cc5adbbd50d81555b8eb73602ec16fde40b55be4
-- 
2.39.3


