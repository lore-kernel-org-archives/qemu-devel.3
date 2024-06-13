Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF89BC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 23:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHu5n-0005yG-G4; Thu, 13 Jun 2024 19:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu5l-0005o5-2u; Thu, 13 Jun 2024 19:42:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu5j-0003zc-5d; Thu, 13 Jun 2024 19:42:52 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0f921SBRz6K62D;
 Fri, 14 Jun 2024 07:42:46 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
 by mail.maildlp.com (Postfix) with ESMTPS id 10EC3140594;
 Fri, 14 Jun 2024 07:42:49 +0800 (CST)
Received: from 00293818-MRGF.china.huawei.com (10.195.245.24) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 00:42:26 +0100
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
Subject: [PATCH RFC V3 13/29] arm/virt: Make ARM vCPU *present* status ACPI
 *persistent*
Date: Fri, 14 Jun 2024 00:36:23 +0100
Message-ID: <20240613233639.202896-14-salil.mehta@huawei.com>
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

ARM arch does not allow CPUs presence to be changed [1] after kernel has booted.
Hence, firmware/ACPI/Qemu must ensure persistent view of the vCPUs to the Guest
kernel even when they are not present in the QoM i.e. are unplugged or are
yet-to-be-plugged

References:
[1] Check comment 5 in the bugzilla entry
   Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 cpu-common.c          |  6 ++++++
 hw/arm/virt.c         |  7 +++++++
 include/hw/core/cpu.h | 21 +++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/cpu-common.c b/cpu-common.c
index 49d2a50835..e4b4dee99a 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -128,6 +128,12 @@ bool qemu_enabled_cpu(CPUState *cpu)
     return cpu && !cpu->disabled;
 }
 
+bool qemu_persistent_cpu(CPUState *cpu)
+{
+    /* cpu state can be faked to the guest via acpi */
+    return cpu && cpu->acpi_persistent;
+}
+
 uint64_t qemu_get_cpu_archid(int cpu_index)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5f98162587..9d33f30a6a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3016,6 +3016,13 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
     virt_cpu_set_properties(OBJECT(cs), cpu_slot, errp);
+
+    /*
+     * To give persistent presence view of vCPUs to the guest, ACPI might need
+     * to fake the presence of the vCPUs to the guest but keep them disabled.
+     * This shall be used during the init of ACPI Hotplug state and hot-unplug
+     */
+     cs->acpi_persistent = true;
 }
 
 static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 62e68611c0..e13e542177 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -540,6 +540,14 @@ struct CPUState {
      * every CPUState is enabled across all architectures.
      */
     bool disabled;
+    /*
+     * On certain architectures, to provide a persistent view of the 'presence'
+     * of vCPUs to the guest, ACPI might need to fake the 'presence' of the
+     * vCPUs but keep them ACPI-disabled for the guest. This is achieved by
+     * returning `_STA.PRES=True` and `_STA.Ena=False` for the unplugged vCPUs
+     * in QEMU QoM.
+     */
+    bool acpi_persistent;
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
@@ -959,6 +967,19 @@ bool qemu_present_cpu(CPUState *cpu);
  */
 bool qemu_enabled_cpu(CPUState *cpu);
 
+/**
+ * qemu_persistent_cpu:
+ * @cpu: The vCPU to check
+ *
+ * Checks if the vCPU state should always be reflected as *present* via ACPI
+ * to the Guest. By default, this is False on all architectures and has to be
+ * explicity set during initialization.
+ *
+ * Returns: True if it is ACPI 'persistent' CPU
+ *
+ */
+bool qemu_persistent_cpu(CPUState *cpu);
+
 /**
  * qemu_get_cpu_archid:
  * @cpu_index: possible vCPU for which arch-id needs to be retreived
-- 
2.34.1


