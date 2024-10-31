Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716F0D767FC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 20:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6bQl-00075s-Om; Thu, 31 Oct 2024 16:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t6bQh-000751-TN; Thu, 31 Oct 2024 16:06:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t6bQd-0007Ru-Rj; Thu, 31 Oct 2024 16:06:03 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XfZcR0Y1sz6L6yZ;
 Fri,  1 Nov 2024 04:00:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 1801E140B35;
 Fri,  1 Nov 2024 04:05:48 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.152.207) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 21:05:28 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <peterx@redhat.com>, <eric.auger@redhat.com>,
 <will@kernel.org>, <ardb@kernel.org>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>, <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH V2 0/6] Arch agnostic ACPI changes to support vCPU Hotplug (on
 Archs like ARM)
Date: Thu, 31 Oct 2024 20:04:56 +0000
Message-ID: <20241031200502.3869-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.152.207]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Change Log
==========

Patch V1 -> V2:
1. Addressed Igor Mammedov's (Redhat) raised issues:
   - Removed `ACPICPUstatus::is_present` State and its handling in the
     ACPI APUs AML code and now all QOM vCPUs are present.
   - Dropped the concept of `acpi_persistent` because now QOM vCPUs
     states and the ACPI vCPU states are consistent.
   - QOM vCPU objects are always present now (accompanying RFC V6)
   - Added .needed() hook to the GED VMSD toconditionally migrate the
     ACPI CPU hotplug state at the source VM.
2. Addressed Zhao Liu's (Intel) reported x86 DSDT Table bios-acpi-test failure 
3. Incorporated Gustavo Romero's comments and added his Tag to [Patches 1,2,4]
4. Addressed Gavin Shan's comment to reduce the inline code comments
   wherever possible.


Brief Recall
============
With the advent of multi-core SoCs, the concept of CPU-level hotplugging
has become less distinct, often functioning as a power on/off event
rather than a full hotplug operation. However, hotplug support at the
die/NUMA/socket level remains meaningful and is architecture-specific.
Virtual CPU hotplug can be supported regardless of architectural support
for physical CPU hotplug, as it serves resource management needs—such as
dynamically scaling VM compute capacity based on demand or SLAs,
optimizing boot times, or reducing memory footprint. Although, its
desing must be scalable and must co-exist with future die/NUMA/socket
level hotplug features.


Motivation for this patch-set
=============================
In architectures that support vCPU hotplug, firmware or the VMM/QEMU
typically reflects vCPU status changes to the OS via the ACPI
`_STA.Present` bit. However, certain CPU architectures prohibit [1]
modifications to CPU presence after kernel boot. This restriction [2][3]
could be due to closely integrated per-CPU components—like interrupt
controllers or other features— that may not support reconfiguration
post-boot and are often in an `always-on` power domain. Consequently,
specifications for these architectures require all CPUs to remain
present i.e.`_STA.Present=True`, once the system is initialized.

To be able to support vCPU Hotplug feature, as a workaround to the above
limitation,  ACPI method `_STA.Enabled` Bit could be used to reflect the
plugged and unplugged states of the QOM vCPUs.

This patch set introduces the following changes:

1. Explicit `ACPICPUstatus::is_enabled` State: Adds an `is_enabled`
   state, initialized during machine setup and updated during CPU
   hotplug and hot-unplug events.
   
2. Support for Migrating ACPI CPU State: Facilitates the migration of
   the ACPI CPU state. (This needs reconsideration as per Igor. Last
   patch can be dropped if this affects the acceptability of other
   patches of this patch-set)

3. Updates the Qtest bios-acpi-test

This patch set is designed to work independently and is meant to ensures
compatibility with existing hotplug support across different
architectures. This patch-set has been tested alongside ARM-specific
vCPU hotplug changes (included in the upcoming RFC V6 [4]), and
hot(un)plug functionalities performed as expected which concerns this
patch-set. Please have a look.

Thank you!


Repository of this patch-set
============================
(*) Latest Architecture Agnostic ACPI changes patch-set:
    https://github.com/salil-mehta/qemu.git   virt-cpuhp-armv8/rfc-v6.arch.agnostic.acpi.v2
    Link: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v6.arch.agnostic.acpi.v2
(*) Works with upcoming ARM architecture specific patch-set RFC V6 [4]


References
==========
[1] Check comment 5 in the bugzilla entry
    Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
[2] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
    architectures that don’t Support CPU Hotplug (like ARM64)
    a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
    b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
[3] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
    SoC Based Systems (like ARM64)
    Link: https://kvmforum2020.sched.com/event/eE4m
[4] Upcoming RFC V6, Support of Virtual CPU Hotplug for ARMv8 Arch
    Link: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v6-rc4


Salil Mehta (6):
  hw/acpi: Introduce `is_enabled` state in ACPI CPU Hotplug Status
  hw/acpi: Update ACPI CPU Hotplug state during vCPU hot(un)plug
  qtest: allow ACPI DSDT Table changes
  hw/acpi: Update CPUs AML's `is_enabled` state in ACPI _STA method
  tests/qtest/bios-tables-test: Update DSDT golden masters for
    x86/{pc,q35}
  hw/acpi: Update GED with vCPU Hotplug VMSD for migration

 hw/acpi/cpu.c                                 |  22 ++++++++++++++++--
 hw/acpi/generic_event_device.c                |  19 +++++++++++++++
 include/hw/acpi/cpu.h                         |   2 +-
 tests/data/acpi/x86/pc/DSDT                   | Bin 8527 -> 8533 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8438 -> 8444 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9852 -> 9858 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15398 -> 15404 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 8991 -> 8997 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10181 -> 10187 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8478 -> 8484 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5034 -> 5040 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8599 -> 8605 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9886 -> 9892 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8385 -> 8391 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8533 -> 8539 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12320 -> 12326 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8361 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8378 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9686 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8640 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8407 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 11974 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 12919 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33776 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 8825 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13148 -> 13154 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10015 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8436 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8449 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8378 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9720 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9491 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13214 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8241 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8219 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8367 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8462 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 12919 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33776 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 8967 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 8993 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18595 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14615 -> 14621 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35724 bytes
 44 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.34.1


