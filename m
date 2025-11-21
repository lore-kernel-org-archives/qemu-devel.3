Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285D4CFA76D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNza-0004jZ-NY; Fri, 21 Nov 2025 05:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNz7-0004aS-JK
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:23 -0500
Received: from p-east3-cluster7-host11-snip4-6.eps.apple.com ([57.103.84.237]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNyw-0007rb-Og
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:19 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 17F9218010C1; Fri, 21 Nov 2025 10:02:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=yK01o8HRlEMgJwN1XFW8wiCifxBApUAIOdAGAAykBMs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cE0SEtHNz7JFFqGJwEaVBUFU/P+qi2xDN1bx+wAw8tT25m+4qVniYVwGZ6yvJsiNWJ1/ftvwMHiZOqyHRUT24y99ptnSxXh+iyUscfBV9Ef3+U4ODDGRuQXVQtK1ygxuLnP1U/9XcwkIBOSGW25SZHY7yiW7pLVeQ4VliX5ICOmBShrztb2aG3+7My10cRQyuQiDnEzlZ2mkwXAISTxHf19jgC1rUqGbVfFfmsSqoB1rDkwxjfl0DbTznnBgQYGAr6l1rnpAlhqsUoo9Tb8shwFHy2DfTAmzBaRz4k1nxhXGB5XubXbwR06Gmd0TXoB7ok22d8RkOnjxPwMxgY9CrA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 CCCCD18006F6; Fri, 21 Nov 2025 10:02:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 04/28] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Fri, 21 Nov 2025 11:02:16 +0100
Message-ID: <20251121100240.89117-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lID6AEQXTmSw2ienvvi-jxL2ilp_4wf3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfXz73u8971axel
 lI6l6NB4xy+v/Y8oqhhTzUpWtQ9i1F7usQYUpXkzo5lQtQv6DAthLP+LW5GQEI2NHvX7734Ivyq
 VNGxn+0h0xKKhJnM8uQxDxJL8lqFnYJ4kf2YBzjeHjym5AGVfEhC/vWV++cvNlatKCZ0N0hprCU
 YagYFrRmEJqsYEs6xOA38VgSGHBL8oUKnOVr/0t1baehnkx1das3jrO1W5XbG94xDw5QAV441Bo
 SYJCM31h6d7rTjONRnVJx1W4u2OUGTrwXsGTnQFSI7XO/udZj8Sqh5N1BFopdZJyS8c07K/05nJ
 dud1s4JHCKk9vFrmL+f
X-Authority-Info: v=2.4 cv=O9E0fR9W c=1 sm=1 tr=0 ts=692038cd cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=8tVNtdTugjW4QW2w:21 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=QSz9yoqgGQbeUTWI9AcA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lID6AEQXTmSw2ienvvi-jxL2ilp_4wf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1030 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABukzAyAbibCn7/XJtQxVRV0BWSmAezANpo8rmOjnOusjSO8kpU/HFhUN+Flx92UtykFDuzFZKnzfqhk6cX1+Ls3n+bWTB5rCnABUnn0v6KdMElNGmqCVd3dtRB5LXhJrO4PDqrCETdxHG7oV4X9ztVW46QCZh1hwzfk6X3zFkkJvO7TOOMxzX3uXO+zlLBzdjoAsPyFtsK1YeaBVURqyub6guawGe9nBV/tMvXh+pObe8UXfQqjgA8TlfPqrzitcnnOW1Wr6hpw8ELPG68LkO+Pic9YdDiV/bsYkzfc3YUl2bGy7Q1KgBbIXfOdznzb6ppbIBrd+NHAsHGPd/Wl634sO06F4dg6zCRNmz+28fevvlWTNoiVaStg2lI8X/IlpYSL1zjxPlTIk7TWuxTAacciR5vd6o3wjDQYgcw6skq2j+JGxLJn1U8Ehum9KMxkRbWhCsW2nyk/K5mp7RAOY5YXqLD5u5nlM79fPG5CQT7cScCdFuKMxPDU3T8fKxQs0Ab9Z9Oh85PwV0Fv5Wy/Nhy53FbL0uSe8B8Vq73kr1LiHVTIX8ZHkrkkoegYNRfPh/s5LNeb91J4C2u9Zq7gtTLVBzoq+8yQAsnux0NGUtjK7Z62I5NNomEY/6hU+C2Yj4UPMb/9KJ9Wx1B1HIYvtIiFjHdyLYxg3wvopH3L55DPYOrd/3RRaeHEKLxxGOg+E3gH/btJvhV6xSZkS1YcxdenAJ8+LuBZRLPgK60cTDfzY+n0e4l7bUv4mEdbtRpPgPp/NmOsQ7o53aM2l0TFQv349s4pa6
Received-SPF: pass client-ip=57.103.84.237;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt-acpi-build.c | 4 +++-
 hw/arm/virt.c            | 8 ++++++++
 include/hw/arm/virt.h    | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 200e2a1da7..e2062f5d21 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -960,7 +960,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
             build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
         }
-    } else {
+    }
+
+    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 25fb2bab56..f2a924ed26 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -959,6 +959,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
         create_its(vms);
+    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
+        create_v2m(vms);
     } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
         create_v2m(vms);
     }
@@ -2444,6 +2446,8 @@ static void machvirt_init(MachineState *machine)
     vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
         !vmc->no_ns_el2_virt_timer_irq;
 
+    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3488,6 +3492,7 @@ static void virt_instance_init(Object *obj)
     vms->its = true;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
+    vms->no_gicv3_with_gicv2m = false;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
@@ -3540,9 +3545,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
 
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_10_2_options(mc);
     mc->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+    vmc->no_gicv3_with_gicv2m = true;
 }
 DEFINE_VIRT_MACHINE(10, 1)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c77a33f6df..3ff83aaabe 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -130,6 +130,7 @@ struct VirtMachineClass {
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
     bool legacy_smmuv3_present;
 };
-- 
2.50.1 (Apple Git-155)


