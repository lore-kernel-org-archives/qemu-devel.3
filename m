Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC6DCF0435
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNM4-0000zP-GR; Tue, 08 Oct 2024 23:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNM2-0000vK-32; Tue, 08 Oct 2024 23:27:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNM0-00050m-CP; Tue, 08 Oct 2024 23:27:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdbb1H1sz6K9Gj;
 Wed,  9 Oct 2024 11:26:51 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id BF8BB140B3C;
 Wed,  9 Oct 2024 11:27:07 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:26:48 +0200
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
Subject: [PATCH RFC V4 23/33] hw/arm: Changes required for reset and to
 support next boot
Date: Wed, 9 Oct 2024 04:18:05 +0100
Message-ID: <20241009031815.250096-24-salil.mehta@huawei.com>
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

Updates the firmware config with the next boot cpus information and also
registers the reset callback to be called when guest reboots to reset the cpu.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/boot.c         |  2 +-
 hw/arm/virt.c         | 18 +++++++++++++++---
 include/hw/arm/boot.h |  2 ++
 include/hw/arm/virt.h |  1 +
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 5301d8d318..8bf8d003eb 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -682,7 +682,7 @@ fail:
     return -1;
 }
 
-static void do_cpu_reset(void *opaque)
+void do_cpu_reset(void *opaque)
 {
     ARMCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9634011ae7..8cb66c11a1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -45,6 +45,8 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/numa.h"
 #include "sysemu/runstate.h"
+#include "sysemu/reset.h"
+#include "sysemu/sysemu.h"
 #include "sysemu/tpm.h"
 #include "sysemu/tcg.h"
 #include "sysemu/kvm.h"
@@ -1427,7 +1429,7 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     char *nodename;
 
     fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16, as);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, vms->boot_cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -3197,7 +3199,13 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 
     if (vms->acpi_dev) {
-        /* TODO: register cpu for reset & update F/W info for the next boot */
+        qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
+    }
+
+    /* update the firmware information for the next boot. */
+    vms->boot_cpus++;
+    if (vms->fw_cfg) {
+        fw_cfg_modify_i16(vms->fw_cfg, FW_CFG_NB_CPUS, vms->boot_cpus);
     }
 
     /*
@@ -3263,7 +3271,11 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     unwire_gic_cpu_irqs(vms, cs);
     virt_update_gic(vms, cs, false);
 
-    /* TODO: unregister cpu for reset & update F/W info for the next boot */
+    qemu_unregister_reset(do_cpu_reset, ARM_CPU(cs));
+    vms->boot_cpus--;
+    if (vms->fw_cfg) {
+        fw_cfg_modify_i16(vms->fw_cfg, FW_CFG_NB_CPUS, vms->boot_cpus);
+    }
 
     qobject_unref(dev->opts);
     dev->opts = NULL;
diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 80c492d742..f81326a1dc 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -178,6 +178,8 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as, MachineState *ms);
 
+void do_cpu_reset(void *opaque);
+
 /* Write a secure board setup routine with a dummy handler for SMCs */
 void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
                                             const struct arm_boot_info *info,
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 0202f0252c..073d18281e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -172,6 +172,7 @@ struct VirtMachineState {
     MemMapEntry *memmap;
     char *pciehb_nodename;
     const int *irqmap;
+    uint16_t boot_cpus;
     int fdt_size;
     uint32_t clock_phandle;
     uint32_t gic_phandle;
-- 
2.34.1


