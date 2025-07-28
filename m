Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0786FC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugO7L-0007se-BD; Mon, 28 Jul 2025 09:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6n-0004fL-Bl
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:42 -0400
Received: from p-east3-cluster4-host1-snip4-1.eps.apple.com ([57.103.84.4]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6i-0004IU-8k
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:37 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 6662E18001ED; Mon, 28 Jul 2025 13:41:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=q7xD0GY8k1Hk4vFR23J6NN3+mR0YZXy/rA40WkfECXE=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=YtDJ0qx5P7V3XChDAr1gQTyB5ihfeyQC8nSYr58EKyyrIbb2RE8D2NyH3CgdQyoHtZU36+y+M76hhbZgVYTDcQUDmNARwqd36767ZxhAilmsHaRBGm6RTUDvT/xqb+1ogvT06FEyYnKPm2hz5ZR3Vi4KxdHiz9JkEmJXV1Ld0DVF9U3AJzAScmtEMg3ujzOx7T9H/1dCNJlwlmFLE7lHDNryQu7duZ2uWckCcVTONkY2Qa+K7ECJcl60+F//iiD3P01+Xhhl5Xjl84uZd+g6jblTSuptYMJz102GNz7jT3kQkz3zRrXEIlhoC74aRA0iqAPLFrYA4cW5tpVmiz3nxQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 6B9C4180021E; Mon, 28 Jul 2025 13:41:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v5 07/13] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Mon, 28 Jul 2025 15:41:08 +0200
Message-Id: <20250728134114.77545-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728134114.77545-1-mohamed@unpredictable.fr>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C837ey0UgWhrqOKHVNXjJbUR2ew6xm3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMSBTYWx0ZWRfX1L3O3WcCk1dR
 aZY0OWLcozmSz5Ce2OltwwPXaLVNsU3tlQeRFp4kNabOQGp2pvQYv/ljg1ZKOKefrj4uBaPv8AJ
 pIcS0zFkd6yp3KtIRjeHhPrF60I+01MmVyNZiwTcIIiEq7hXCM+zXMTkCimNDNfZ23hwXxdOv/u
 2avrBn6rKItf7yZ1IUlb1Q1F5XY0PTNBqUNvEF+dC3O9MzsrnmkUuusEp0wVwkEBzyRqShcG/QM
 +QrY+Sfa4TTMi3kQLo9UPUPL5TIioOMfWUt/hfLHb0NbF/ZKqM4NmCJwWLI3i+sB1/K+luKDQ=
X-Proofpoint-GUID: C837ey0UgWhrqOKHVNXjJbUR2ew6xm3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1030 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280101
Received-SPF: pass client-ip=57.103.84.4;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/arm/virt.c            | 8 ++++++++
 include/hw/arm/virt.h    | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b01fc4f8ef..969fa3f686 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -848,7 +848,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
             build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
         }
-    } else {
+    }
+
+    if (!vms->its && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7348d55104..91d8cd9363 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -953,6 +953,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
         create_its(vms);
+    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
+        create_v2m(vms);
     } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
         create_v2m(vms);
     }
@@ -2408,6 +2410,8 @@ static void machvirt_init(MachineState *machine)
     vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
         !vmc->no_ns_el2_virt_timer_irq;
 
+    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3419,6 +3423,7 @@ static void virt_instance_init(Object *obj)
     vms->its = true;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
+    vms->no_gicv3_with_gicv2m = false;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
@@ -3471,8 +3476,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
 
 static void virt_machine_10_0_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_10_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
+    vmc->no_gicv3_with_gicv2m = true;
 }
 DEFINE_VIRT_MACHINE(10, 0)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 365a28b082..725ec18fd2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -131,6 +131,7 @@ struct VirtMachineClass {
     bool no_cpu_topology;
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
+    bool no_gicv3_with_gicv2m;
     bool no_nested_smmu;
 };
 
@@ -178,6 +179,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    bool no_gicv3_with_gicv2m;
     CXLState cxl_devices_state;
 };
 
-- 
2.39.5 (Apple Git-154)


