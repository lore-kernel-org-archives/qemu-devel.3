Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67E7C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cCP-0005K9-BH; Thu, 16 May 2024 10:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7cCD-0004tU-Ne; Thu, 16 May 2024 10:35:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7cC6-0008OU-A6; Thu, 16 May 2024 10:35:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GATgUM029906;
 Thu, 16 May 2024 14:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=no241RHkcyhLATyllSF8NpXhL8pA4FWWRbWtBq5VNzY=; b=JN
 h+wzdhAHtlQhCkj1InHqAbZ/qowWysFBqDEWOIS1OBd+NyNsiYStuDMWPKtGer67
 Aqfrvx1kblIgJpm+IAewyVvkE+yusYn+jk0HSboAIwzsCwovCexlrxzCTpR/J0Uv
 1uyrQkz6h0wFeLcQd2mn9pvE1tUT1tlH/E6+fxzjVJQQH+DaWzouWc0RhpRitxjV
 Ml1eafcti486YG7DzNSILd+zWoTvlMe+WePFResukCfN+P6C9bx7ikJ/JeDMpp0S
 a+Z5eDVfolEZx0Um10Wjnt55MO9nCgOKe+HcSv5YWjxIjsxoX/BTVy8if9GrO+6e
 QBntH6CBDB1PV5IEnoNQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y51tuj643-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:34:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GEYmuk012831
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:34:48 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 16 May 2024 07:34:43 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v2 09/12] gunyah: Customize device-tree
Date: Thu, 16 May 2024 14:33:53 +0000
Message-ID: <20240516143356.1739402-10-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240516143356.1739402-1-quic_svaddagi@quicinc.com>
References: <20240516143356.1739402-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 1KmdDbX_pdjBT2qReCIgibWRVt3lCDZj
X-Proofpoint-GUID: 1KmdDbX_pdjBT2qReCIgibWRVt3lCDZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160103
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Customize device-tree with Gunyah specific properties. Some of these
properties include specification of doorbells that need to be created
and associated with various interrupts.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 include/sysemu/gunyah.h   |  2 +
 accel/stubs/gunyah-stub.c |  5 +++
 hw/arm/virt.c             | 11 ++++++
 target/arm/gunyah.c       | 79 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/include/sysemu/gunyah.h b/include/sysemu/gunyah.h
index ba4862a1a6..58d0379b72 100644
--- a/include/sysemu/gunyah.h
+++ b/include/sysemu/gunyah.h
@@ -30,5 +30,7 @@ DECLARE_INSTANCE_CHECKER(GUNYAHState, GUNYAH_STATE,
                          TYPE_GUNYAH_ACCEL)
 
 int gunyah_arm_set_dtb(uint64_t dtb_start, uint64_t dtb_size);
+void gunyah_arm_fdt_customize(void *fdt, uint64_t mem_base,
+                uint32_t gic_phandle);
 
 #endif  /* QEMU_GUNYAH_H */
diff --git a/accel/stubs/gunyah-stub.c b/accel/stubs/gunyah-stub.c
index 8f6e952938..19649ea40b 100644
--- a/accel/stubs/gunyah-stub.c
+++ b/accel/stubs/gunyah-stub.c
@@ -21,3 +21,8 @@ int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size)
 {
     return -1;
 }
+
+void gunyah_arm_fdt_customize(void *fdt, uint64_t mem_base,
+                uint32_t gic_phandle) {
+    return;
+}
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a485388d3c..b0132beddd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2214,6 +2214,14 @@ static void fdt_add_reserved_memory(VirtMachineState *vms)
     g_free(nodename);
 }
 
+static void virt_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
+{
+    const VirtMachineState *vms = container_of(binfo, VirtMachineState,
+                                                 bootinfo);
+
+    gunyah_arm_fdt_customize(fdt, vms->memmap[VIRT_MEM].base, vms->gic_phandle);
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -2533,6 +2541,9 @@ static void machvirt_init(MachineState *machine)
     vms->bootinfo.skip_dtb_autoload = true;
     vms->bootinfo.firmware_loaded = firmware_loaded;
     vms->bootinfo.psci_conduit = vms->psci_conduit;
+    if (gunyah_enabled()) {
+        vms->bootinfo.modify_dtb = virt_modify_dtb;
+    }
     arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
 
     vms->machine_done.notify = virt_machine_done;
diff --git a/target/arm/gunyah.c b/target/arm/gunyah.c
index d655cd9a79..c33a0c0615 100644
--- a/target/arm/gunyah.c
+++ b/target/arm/gunyah.c
@@ -11,6 +11,9 @@
 #include "sysemu/gunyah.h"
 #include "sysemu/gunyah_int.h"
 #include "linux-headers/linux/gunyah.h"
+#include "exec/memory.h"
+#include "sysemu/device_tree.h"
+#include "hw/arm/fdt.h"
 
 /*
  * Specify location of device-tree in guest address space.
@@ -43,3 +46,79 @@ int gunyah_arm_set_dtb(uint64_t dtb_start, uint64_t dtb_size)
 
     return 0;
 }
+
+void gunyah_arm_fdt_customize(void *fdt, uint64_t mem_base,
+            uint32_t gic_phandle)
+{
+    char *nodename;
+    int i;
+    GUNYAHState *state = get_gunyah_state();
+
+    qemu_fdt_add_subnode(fdt, "/gunyah-vm-config");
+    qemu_fdt_setprop_string(fdt, "/gunyah-vm-config",
+                                "image-name", "qemu-vm");
+    qemu_fdt_setprop_string(fdt, "/gunyah-vm-config", "os-type", "linux");
+
+    nodename = g_strdup_printf("/gunyah-vm-config/memory");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 2);
+    qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 2);
+    qemu_fdt_setprop_u64(fdt, nodename, "base-address", mem_base);
+
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/gunyah-vm-config/interrupts");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "config", gic_phandle);
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/gunyah-vm-config/vcpus");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "affinity", "proxy");
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/gunyah-vm-config/vdevices");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "generate", "/hypervisor");
+    g_free(nodename);
+
+    for (i = 0; i < state->nr_slots; ++i) {
+        if (!state->slots[i].start || state->slots[i].lend ||
+                state->slots[i].start == mem_base) {
+            continue;
+        }
+
+        nodename = g_strdup_printf("/gunyah-vm-config/vdevices/shm-%x", i);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "vdevice-type", "shm");
+        qemu_fdt_setprop_string(fdt, nodename, "push-compatible", "dma");
+        qemu_fdt_setprop(fdt, nodename, "peer-default", NULL, 0);
+        qemu_fdt_setprop_u64(fdt, nodename, "dma_base", 0);
+        g_free(nodename);
+
+        nodename = g_strdup_printf("/gunyah-vm-config/vdevices/shm-%x/memory",
+                                                                        i);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_cell(fdt, nodename, "label", i);
+        qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 2);
+        qemu_fdt_setprop_u64(fdt, nodename, "base", state->slots[i].start);
+        g_free(nodename);
+    }
+
+    for (i = 0; i < state->nr_irqs; ++i) {
+        nodename = g_strdup_printf("/gunyah-vm-config/vdevices/bell-%x", i);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "vdevice-type", "doorbell");
+        char *p = g_strdup_printf("/hypervisor/bell-%x", i);
+        qemu_fdt_setprop_string(fdt, nodename, "generate", p);
+        g_free(p);
+        qemu_fdt_setprop_cell(fdt, nodename, "label", i);
+        qemu_fdt_setprop(fdt, nodename, "peer-default", NULL, 0);
+        qemu_fdt_setprop(fdt, nodename, "source-can-clear", NULL, 0);
+
+        qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
+                GIC_FDT_IRQ_TYPE_SPI, i, GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+
+        g_free(nodename);
+    }
+}
-- 
2.25.1


