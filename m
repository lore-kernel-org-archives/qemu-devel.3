Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A35D1813D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 19:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Qek-0001na-Pc; Mon, 14 Oct 2024 15:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0Qei-0001n0-Sh; Mon, 14 Oct 2024 15:23:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0Qef-0004xx-UK; Mon, 14 Oct 2024 15:23:00 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS6T85J7gz6L7DK;
 Tue, 15 Oct 2024 03:18:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 471E71400D9;
 Tue, 15 Oct 2024 03:22:48 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.149) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 21:22:28 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU Hotplug (on
 Archs like ARM)
Date: Mon, 14 Oct 2024 20:22:01 +0100
Message-ID: <20241014192205.253479-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.146.149]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Certain CPU architecture specifications [1][2][3] prohibit changes to the CPUs
*presence* after the kernel has booted. This is because many system
initializations depend on the exact CPU count at boot time and do not expect it
to change afterward. For example, components like interrupt controllers that are
closely coupled with CPUs, or various per-CPU features, may not support
configuration changes once the kernel has been initialized.

This requirement poses a challenge for virtualization features like vCPU
hotplug. To address this, changes to the ACPI AML are necessary to update the
`_STA.PRES` (presence) and `_STA.ENA` (enabled) bits accordingly during guest
initialization, as well as when vCPUs are hot-plugged or hot-unplugged. The
presence of unplugged vCPUs may need to be deliberately *simulated* at the ACPI
level to maintain a *persistent* view of vCPUs for the guest kernel.

This patch set introduces the following features:

1. ACPI Interface with Explicit PRESENT and ENABLED CPU States: It allows the
   guest kernel to evaluate these states using the `_STA` ACPI method.
   
2. Initialization of ACPI CPU States: These states are initialized during
   `machvirt_init` and when vCPUs are hot-(un)plugged. This enables hotpluggable
   vCPUs to be exposed to the guest kernel via ACPI.

3. Support for Migrating ACPI CPU States: The patch set ensures the migration of
   the newly introduced `is_{present,enabled}` ACPI CPU states to the
   destination VM.

The approach is flexible enough to accommodate ARM-like architectures that
intend to implement vCPU hotplug functionality. It is suitable for architectures
facing similar constraints to ARM or those that plan to implement vCPU
hotplugging independently of hardware support (if available).

This patch set is derived from the ARM-specific vCPU hotplug implementation [4]
and includes migration components adaptable to other architectures, following
suggestions [5] made by Igor Mammedov <imammedo@redhat.com>.

It can be applied independently, ensuring compatibility with existing hotplug
support in other architectures. I have tested this patch set in conjunction with
the ARM-specific vCPU hotplug changes (included in the upcoming RFC V5 [6]), and
everything worked as expected. I kindly request maintainers of other
architectures to provide a "Tested-by" after running their respective regression
tests.

Many thanks!


References:
[1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
    architectures that don’t Support CPU Hotplug (like ARM64)
    a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
    b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
[2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
    SoC Based Systems (like ARM64)
    Link: https://kvmforum2020.sched.com/event/eE4m
[3] Check comment 5 in the bugzilla entry
    Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
[4] [PATCH RFC V4 00/33] Support of Virtual CPU Hotplug for ARMv8 Arch
    Link: https://lore.kernel.org/qemu-devel/20241009031815.250096-1-salil.mehta@huawei.com/T/#mf32be203baa568a871dc625b732f666a4c4f1e68
[5] Architecture agnostic ACPI VMSD state migration (Discussion)
    Link: https://lore.kernel.org/qemu-devel/20240715155436.577d34c5@imammedo.users.ipa.redhat.com/
[6] Upcoming RFC V5, Support of Virtual CPU Hotplug for ARMv8 Arch
    Link: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v5

Salil Mehta (4):
  hw/acpi: Initialize ACPI Hotplug CPU Status with Support for vCPU
    `Persistence`
  hw/acpi: Update ACPI CPU Status `is_{present, enabled}` during vCPU
    hot(un)plug
  hw/acpi: Reflect ACPI vCPU {present,enabled} states in ACPI
    _STA.{PRES,ENA} Bits
  hw/acpi: Populate vCPU Hotplug VMSD to migrate `is_{present,enabled}`
    states

 cpu-target.c         patches.vcpuhp.rfc-v5.arch.agnostic.acpi          |  1 +
 hw/acpi/cpu.c                  | 70 +++++++++++++++++++++++++++++++---
 hw/acpi/generic_event_device.c | 11 ++++++
 include/hw/acpi/cpu.h          | 21 ++++++++++
 include/hw/core/cpu.h          | 21 ++++++++++
 5 files changed, 119 insertions(+), 5 deletions(-)

-- 
2.34.1


