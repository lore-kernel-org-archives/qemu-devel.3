Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C46CF0435
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNJC-0003cz-Gb; Tue, 08 Oct 2024 23:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNJB-0003c3-0B; Tue, 08 Oct 2024 23:24:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNJ9-0004hU-3r; Tue, 08 Oct 2024 23:24:16 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdXC1hzLz6K98h;
 Wed,  9 Oct 2024 11:23:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id DA53A140447;
 Wed,  9 Oct 2024 11:24:11 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:23:52 +0200
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
Subject: [PATCH RFC V4 14/33] arm/virt: Release objects for *disabled*
 possible vCPUs after init
Date: Wed, 9 Oct 2024 04:17:56 +0100
Message-ID: <20241009031815.250096-15-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.173.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/arm/virt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 696e0a9f75..d8cae70ab2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2093,6 +2093,36 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
             }
         }
     }
+
+    if (kvm_enabled() || tcg_enabled()) {
+        CPU_FOREACH_POSSIBLE(cpu, possible_cpus) {
+            /*
+             * Now, GIC has been sized with possible CPUs and we dont require
+             * disabled vCPU objects to be represented in the QOM. Release the
+             * disabled ARMCPU objects earlier used during init for pre-sizing.
+             *
+             * We fake to the guest through ACPI about the presence(_STA.PRES=1)
+             * of these non-existent vCPUs at VMM/qemu and present these as
+             * disabled vCPUs(_STA.ENA=0) so that they cant be used. These vCPUs
+             * can be later added to the guest through hotplug exchanges when
+             * ARMCPU objects are created back again using 'device_add' QMP
+             * command.
+             */
+            /*
+             * RFC: Question: Other approach could've been to keep them forever
+             * and release it only once when qemu exits as part of finalize or
+             * when new vCPU is hotplugged. In the later old could be released
+             * for the newly created object for the same vCPU or just reuse the
+             * old QOM vCPU object?
+             */
+            if (!qemu_enabled_cpu(cpu)) {
+                CPUArchId *cpu_slot;
+                cpu_slot = virt_find_cpu_slot(cpu);
+                cpu_slot->cpu = NULL;
+                object_unref(OBJECT(cpu));
+            }
+        }
+    }
 }
 
 static void virt_cpu_set_properties(Object *cpuobj, const CPUArchId *cpu_slot,
-- 
2.34.1


