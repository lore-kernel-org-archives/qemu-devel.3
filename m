Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD1CCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9UTE-0005b9-Ji; Thu, 16 Oct 2025 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UTC-0005Zg-Ct
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:06 -0400
Received: from npq-east2-cluster1-host6-snip4-9.eps.apple.com ([57.103.77.102]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UT9-0000y1-Hl
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:06 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id
 4B1F218005D5; Thu, 16 Oct 2025 20:21:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=JHEgQXI56zcvBQsz6pNUn1flvTbXYsGowZgT2ZZujDg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=N3G4HnTG6uIfytMO/ColVZ1lF6OCuD6AlhiEALD2++pgPp+cCD0Ts9i+j6GwO4kZulDndsnO9ctvOYRuY+3yVUeCUckcv16Ei7cA30xGmy8ZhPrVFhHOx4/oeI2EfpcJT8auzfgV563Elh8Hdxoh0mBLtUh7/4q/PTowLoYKt1IVnDioqPwUU2ovjjmoJO6O3+jGwkDm3XoILFtrvQ9eaKED4CvVyyBx+zWJSxkhf0uK6hOq5OC/a8YA5Ovu61U1fQmGSegW6LPueWl/dF2ryFM38sSSZWs/zyBBX9uwVY+eBX7yn26QezWWtmbqhFfXi7DVka1RdvDqWsx8+OIF7Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id
 C7A671800996; Thu, 16 Oct 2025 20:20:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 04/24] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Thu, 16 Oct 2025 22:20:24 +0200
Message-ID: <20251016202044.75261-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016202044.75261-1-mohamed@unpredictable.fr>
References: <20251016202044.75261-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE1MSBTYWx0ZWRfX/mHiMZRIR3IM
 6LyG6jgsUlUIEy18P5YFpLj0cnaEq9eByGmtaVHMyS1hpqG0jDFJ1td/LybkBFb2M/b7ULXzQtX
 zd8TKlyK1xqGGbXI/PA4GvK5ioyPYEmDI0qrRusElG0oTsFkkS5fMcrnfAwbYU7UGj0DViUxiZ5
 YRnSR07wal/CnUzwxZZhJV/1ZFHYdw3tpnWERKrE6D0DvYLFyjOUEbpw23cErbFsXMlwBlMthkp
 Vrm0V3yGh9Gt6dVhSwkZyAzbIY43QCrlrFz1aTFbhoTSFOaR33LhJyehXmva4hGqj01jT//u8=
X-Proofpoint-GUID: gJm8xCcNYm8s6NFegFhEnPU7V2k944zE
X-Proofpoint-ORIG-GUID: gJm8xCcNYm8s6NFegFhEnPU7V2k944zE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 clxscore=1030 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510160151
X-JNJ: AAAAAAABbPedS2hZ2U71Qm1JCivwUYItxC+NaFLrEqGAXGwcG+91CyXL4FvFYhODTWwbH32D29EgX1z95+yxTZFm9p8oImyrGFg+SD71LONKSTon5t2YyfZ8Gf9P9OnJInaJfr17kz7lFsU11LaABUwmEf7J6Zj1s0ANa1FSojktZmHr6vb8fMyTplYJr0iyglsz1xIo4iHQx84Lg76TEHen16fUsv1+vggL+G1ZoUUqGT57Ix4CchyodZJydxPNoZo+mU7tbvxAMvazU7L7EAL7yb8NTXi07DWHtEDQjKBzSCisGfgAx76Lb/DqXmsd2CI9Fl/05+NUBKOL/Rwy+Dq5W41Sgk+twwlHqW1MzwLygS/vTlfKFC5rh0nEAvdKSdaaWH8lFHZwuRY90VC9IE7U8hkmqElYcfy97eBJHfowc4Ax1ASABHP8NKcOxWuqeX0V5q+D0WW1b/m/nQ98+8fJNFwcYTK8GB1SpJtKbVivspKGPNTJfuxD4QJ7FM35o2vA+SdoOEnwfmAnatsA69GFE4OV2iGdo7yDfgumTTZAj5Z1CQMMiXnKhFmnZV+g1OsK3Lh39Cg9y4PBghbNDHggYi/auzzifYpVMDZnz6CJ/x88BK/ZYc3toLxLo8rr8QvzWLoqbWboaP1zxWRBwHqjsV4OoVu5vMLblgL/lVT9UVs35VpLKEZ5v3SO9OYI8Y/C8Uco5fjq
Received-SPF: pass client-ip=57.103.77.102;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 8bb6b60515..0a6ec74aa0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -959,7 +959,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
index 175023897a..61d7bab803 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -956,6 +956,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
         create_its(vms);
+    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
+        create_v2m(vms);
     } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
         create_v2m(vms);
     }
@@ -2447,6 +2449,8 @@ static void machvirt_init(MachineState *machine)
     vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
         !vmc->no_ns_el2_virt_timer_irq;
 
+    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3484,6 +3488,7 @@ static void virt_instance_init(Object *obj)
     vms->its = true;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
+    vms->no_gicv3_with_gicv2m = false;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
@@ -3536,9 +3541,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
 
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
index 04a09af354..d31348dd61 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -132,6 +132,7 @@ struct VirtMachineClass {
     bool no_cpu_topology;
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
+    bool no_gicv3_with_gicv2m;
     bool no_nested_smmu;
 };
 
@@ -180,6 +181,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    bool no_gicv3_with_gicv2m;
     CXLState cxl_devices_state;
     bool legacy_smmuv3_present;
 };
-- 
2.50.1 (Apple Git-155)


