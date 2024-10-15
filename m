Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5719DCFC280
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0eQX-0007y1-OV; Tue, 15 Oct 2024 06:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eQP-0007nD-Al; Tue, 15 Oct 2024 06:05:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eQN-0001Uo-Im; Tue, 15 Oct 2024 06:05:09 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSV380b50z6DB4H;
 Tue, 15 Oct 2024 18:00:36 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 66461140519;
 Tue, 15 Oct 2024 18:05:04 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.149) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 12:04:44 +0200
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
Subject: [PATCH RFC V5 12/30] arm/virt: Release objects for *disabled*
 possible vCPUs after init
Date: Tue, 15 Oct 2024 10:59:54 +0100
Message-ID: <20241015100012.254223-13-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015100012.254223-1-salil.mehta@huawei.com>
References: <20241015100012.254223-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.146.149]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

During `machvirt_init()`, QOM ARMCPU objects are pre-created along with the
corresponding KVM vCPUs in the host for all possible vCPUs. This is necessary
due to the architectural constraint that KVM restricts the deferred creation of
KVM vCPUs and VGIC initialization/sizing after VM initialization. Hence, VGIC is
pre-sized with possible vCPUs.

After the initialization of the machine is complete, the disabled possible KVM
vCPUs are parked in the per-virt-machine list "kvm_parked_vcpus," and we release
the QOM ARMCPU objects for the disabled vCPUs. These will be re-created when the
vCPU is hotplugged again. The QOM ARMCPU object is then re-attached to the
corresponding parked KVM vCPU.

Alternatively, we could have chosen not to release the QOM CPU objects and kept
reusing them. This approach might require some modifications to the
`qdevice_add()` interface to retrieve the old ARMCPU object instead of creating
a new one for the hotplug request.

Each of these approaches has its own pros and cons. This prototype uses the
first approach (suggestions are welcome!).

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6ac2d8826e..7cbc212130 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2037,6 +2037,7 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
 {
     CPUArchIdList *possible_cpus = vms->parent.possible_cpus;
     int max_cpus = MACHINE(vms)->smp.max_cpus;
+    int smp_cpus = MACHINE(vms)->smp.cpus;
     bool aarch64, steal_time;
     CPUState *cpu;
 
@@ -2095,6 +2096,30 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
             }
         }
     }
+
+    if (kvm_enabled() || tcg_enabled()) {
+        int i = 0;
+        CPU_FOREACH_POSSIBLE(cpu, possible_cpus) {
+            /*
+             * Release the disabled ARMCPU objects that were previously used
+             * during initialization for pre-sizing host KVM.
+             *
+             * We simulate the presence of these non-existent vCPUs to the guest
+             * via ACPI by setting `_STA.PRES = 1` (indicating they are present)
+             * and mark them as disabled vCPUs by setting `_STA.ENA = 0`,
+             * ensuring they cannot be used. These vCPUs can be added back to
+             * the guest later through hotplug operations when ARMCPU objects
+             * are recreated using the '-device_add' QMP command.
+             */
+            if (i >= smp_cpus) {
+                CPUArchId *cpu_slot;
+                cpu_slot = virt_find_cpu_slot(cpu);
+                cpu_slot->cpu = NULL;
+                object_unref(OBJECT(cpu));
+            }
+            i++;
+        }
+    }
 }
 
 static void virt_cpu_set_properties(Object *cpuobj, const CPUArchId *cpu_slot,
-- 
2.34.1


