Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFFAC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 23:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHu40-0002SR-Lv; Thu, 13 Jun 2024 19:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu3w-0002Ho-8k; Thu, 13 Jun 2024 19:41:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu3u-0003al-AJ; Thu, 13 Jun 2024 19:40:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0f6s05Cnz687SH;
 Fri, 14 Jun 2024 07:40:53 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
 by mail.maildlp.com (Postfix) with ESMTPS id D4665140AE5;
 Fri, 14 Jun 2024 07:40:55 +0800 (CST)
Received: from 00293818-MRGF.china.huawei.com (10.195.245.24) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 00:40:33 +0100
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
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>
Subject: [PATCH RFC V3 08/29] arm/virt: Init PMU at host for all possible vcpus
Date: Fri, 14 Jun 2024 00:36:18 +0100
Message-ID: <20240613233639.202896-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613233639.202896-1-salil.mehta@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.195.245.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PMU for all possible vCPUs must be initialized at the VM initialization time.
Refactor existing code to accomodate possible vCPUs. This also assumes that all
processor being used are identical.

Past discussion for reference:
Link: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html

Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c         | 12 ++++++++----
 include/hw/arm/virt.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ac53bfadca..57ec429022 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2045,12 +2045,14 @@ static void finalize_gic_version(VirtMachineState *vms)
  */
 static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
 {
+    CPUArchIdList *possible_cpus = vms->parent.possible_cpus;
     int max_cpus = MACHINE(vms)->smp.max_cpus;
-    bool aarch64, pmu, steal_time;
+    bool aarch64, steal_time;
     CPUState *cpu;
+    int n;
 
     aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
-    pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
+    vms->pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
     steal_time = object_property_get_bool(OBJECT(first_cpu),
                                           "kvm-steal-time", NULL);
 
@@ -2077,8 +2079,10 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
             memory_region_add_subregion(sysmem, pvtime_reg_base, pvtime);
         }
 
-        CPU_FOREACH(cpu) {
-            if (pmu) {
+        for (n = 0; n < possible_cpus->len; n++) {
+            cpu = qemu_get_possible_cpu(n);
+
+            if (vms->pmu) {
                 assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
                 if (kvm_irqchip_in_kernel()) {
                     kvm_arm_pmu_set_irq(ARM_CPU(cpu), VIRTUAL_PMU_IRQ);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 36ac5ff4a2..d8dcc89a0d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -155,6 +155,7 @@ struct VirtMachineState {
     bool ras;
     bool mte;
     bool dtb_randomness;
+    bool pmu;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
-- 
2.34.1


