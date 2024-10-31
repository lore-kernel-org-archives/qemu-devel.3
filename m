Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B58D767FA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 20:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6bQv-00076q-4Y; Thu, 31 Oct 2024 16:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t6bQq-000764-Sb; Thu, 31 Oct 2024 16:06:12 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t6bQo-0007TM-Si; Thu, 31 Oct 2024 16:06:12 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XfZhs6PBpz6JBf6;
 Fri,  1 Nov 2024 04:04:45 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id B2E181400D3;
 Fri,  1 Nov 2024 04:06:07 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.152.207) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 21:05:48 +0100
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
Subject: [PATCH V2 1/6] hw/acpi: Introduce `is_enabled` state in ACPI CPU
 Hotplug Status
Date: Thu, 31 Oct 2024 20:04:57 +0000
Message-ID: <20241031200502.3869-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031200502.3869-1-salil.mehta@huawei.com>
References: <20241031200502.3869-1-salil.mehta@huawei.com>
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

On most architectures, during vCPU hot-plug and hot-unplug actions,
firmware or the VMM/QEMU can convey vCPU status to the OS by
toggling the ACPI method `_STA.Present` Bit. However, certain CPU
architecture specifications prohibit [1] modifications to CPU's
`presence` after the kernel has booted.

This limitation [2][3] arises because many per-CPU components, such as
interrupt controllers that are closely integrated with CPUs, or other
per-CPU features, may not support reconfiguration once the kernel is
initialized. These components often cannot be powered down as they might
belong to an `always-on` power domain. Consequently, specifications
require all CPUs to remain `_STA.Present` after system initialization.

To address this issue from an ACPI perspective, an `is_enabled` state has
been introduced in the `AcpiCpuStatus`. This state reflects whether a vCPU
has been hot-plugged or hot-unplugged in QEMU, thus indicating its
availability to the guest kernel. The guest can evaluate this status by
calling the ACPI `_STA` method and checking the `_STA.Enabled` bit after
QEMU signals the hot-plug event via GED.

References:
[1] Check comment 5 in the bugzilla entry
    Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
[2] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
    architectures that don’t Support CPU Hotplug (like ARM64)
    a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
    b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
[3] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
    SoC Based Systems (like ARM64)
    Link: https://kvmforum2020.sched.com/event/eE4m

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/acpi/cpu.c         | 9 ++++++++-
 include/hw/acpi/cpu.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5cb60ca8bc..238a0edbc1 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -225,7 +225,14 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     state->dev_count = id_list->len;
     state->devs = g_new0(typeof(*state->devs), state->dev_count);
     for (i = 0; i < id_list->len; i++) {
-        state->devs[i].cpu =  CPU(id_list->cpus[i].cpu);
+        struct CPUState *cpu = CPU(id_list->cpus[i].cpu);
+
+        state->devs[i].cpu = cpu;
+        if (cpu && DEVICE(cpu)->realized) {
+            state->devs[i].is_enabled = true;
+        } else {
+            state->devs[i].is_enabled = false;
+        }
         state->devs[i].arch_id = id_list->cpus[i].arch_id;
     }
     memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops, state,
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 32654dc274..ff49caa501 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -26,6 +26,7 @@ typedef struct AcpiCpuStatus {
     uint64_t arch_id;
     bool is_inserting;
     bool is_removing;
+    bool is_enabled;
     bool fw_remove;
     uint32_t ost_event;
     uint32_t ost_status;
@@ -74,5 +75,4 @@ extern const VMStateDescription vmstate_cpu_hotplug;
 #define VMSTATE_CPU_HOTPLUG(cpuhp, state) \
     VMSTATE_STRUCT(cpuhp, state, 1, \
                    vmstate_cpu_hotplug, CPUHotplugState)
-
 #endif
-- 
2.34.1


