Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE36C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 14:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udrg5-0006uY-FW; Mon, 21 Jul 2025 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udrfU-00066x-C6
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:39:07 -0400
Received: from p-east3-cluster6-host7-snip4-2.eps.apple.com ([57.103.85.193]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udrfI-0005dN-GF
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:38:55 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPS id
 8215618005E2; Mon, 21 Jul 2025 14:38:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=CrTMpDwF13P+y1O9FBI/EPomn6LMUzyv1EcbqvBQ+Ik=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=ctywDCM/1fMfOZJzJCY4zF6seEq/ImxmUR9EWzcAJtA+qXv+Axec6f4I7FpgKOxavj60f+x/v8r+YycZ1tYQsevTzFUQry9jVmtEfG04HN77eE4McJYJkAGdsfkVMHMmpSXYSv5V0mxKuD8TQGVD6AarTY26JVQKEbrVkJ8fvPOzDNP6Qdlk8BU2SjrCC3glIOmKOQTlqgdhrcdOCCCXBUTcPUG8vgkaInqNa2vR80wR4vOFd+/t8qB+KdHzNlMl5stZ3OpDTSPyJXaZdyGck7a7yCZX0TiGKtlZtpESVMk0vwOSWnytL6+4oLhWcnFVHggx1XJEduq7lKsD9DiA0Q==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPSA id
 1CE7C1800094; Mon, 21 Jul 2025 14:38:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/1] hw/arm: virt: add GICv2m for the case when ITS is not
 available
Date: Mon, 21 Jul 2025 16:38:19 +0200
Message-Id: <20250721143819.32334-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250721143819.32334-1-mohamed@unpredictable.fr>
References: <20250721143819.32334-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzMCBTYWx0ZWRfX1jQvHdaPTIPr
 8Fk05yn72nWj5qPO9n4czK41nEe6Ovl20rzz5BYwoY+DQTONamvsHsXyFHpjXuotkrbBEJw5lyP
 OmITyep33ZNOfUW+VBitbdw5DRZi5GZY4dij66qldyk8qpfCwDZIibbmJ8cOHb9RpvqVm7g7aBA
 ahCwdIRKH8HXH9MQjCFtgqwWj6NSouVzYK0ePWhCWwV0JeZFfaiS1LxUuv3ezsguOhesEM2eLHg
 OHe4revr6XeHHYHNPI9AqYuQurK6s0lsUblyx4QZQtrhylPrZuxIQTFq3WhAP1DX6pLMMjckM=
X-Proofpoint-GUID: L-y9xroDxkQEU8FqlbYREI7r58AAdf-l
X-Proofpoint-ORIG-GUID: L-y9xroDxkQEU8FqlbYREI7r58AAdf-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1030
 adultscore=0 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507210130
Received-SPF: pass client-ip=57.103.85.193;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Hypervisor.framework for macOS and WHPX for Windows, the provided environment is a GICv3 without ITS.

As such, support a GICv3 w/ GICv2m for that scenario.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c | 4 +++-
 hw/arm/virt.c            | 8 +++++++-
 include/hw/arm/virt.h    | 2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b01fc4f8ef..7fc8f8e6b8 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -848,7 +848,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
             build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
         }
-    } else {
+    }
+
+    if (!vms->its && !vms->no_gicv2m_when_no_its_available) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef6be3660f..8af0ce95ba 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -854,7 +854,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                             redist_region_count);
 
         if (!kvm_irqchip_in_kernel()) {
-            if (vms->tcg_its) {
+            if (vms->its && vms->tcg_its) {
                 object_property_set_link(OBJECT(vms->gic), "sysmem",
                                          OBJECT(mem), &error_fatal);
                 qdev_prop_set_bit(vms->gic, "has-lpi", true);
@@ -2402,6 +2402,8 @@ static void machvirt_init(MachineState *machine)
     vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
         !vmc->no_ns_el2_virt_timer_irq;
 
+    vms->no_gicv2m_when_no_its_available = vmc->no_gicv2m_when_no_its_available;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3410,6 +3412,7 @@ static void virt_instance_init(Object *obj)
     vms->its = true;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
+    vms->no_gicv2m_when_no_its_available = false;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
@@ -3462,8 +3465,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
 
 static void virt_machine_10_0_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_10_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
+    vmc->no_gicv2m_when_no_its_available = true;
 }
 DEFINE_VIRT_MACHINE(10, 0)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 365a28b082..15b8357394 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -131,6 +131,7 @@ struct VirtMachineClass {
     bool no_cpu_topology;
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
+    bool no_gicv2m_when_no_its_available;
     bool no_nested_smmu;
 };
 
@@ -178,6 +179,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    bool no_gicv2m_when_no_its_available;
     CXLState cxl_devices_state;
 };
 
-- 
2.39.5 (Apple Git-154)


