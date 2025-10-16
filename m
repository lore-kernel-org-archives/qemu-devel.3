Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8B7CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RwE-0006Rj-NS; Thu, 16 Oct 2025 13:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RwC-0006Qg-E5
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:52 -0400
Received: from p-east2-cluster2-host7-snip4-10.eps.apple.com ([57.103.78.53]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rw1-0007eN-Jj
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:52 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 D9FE9180012A; Thu, 16 Oct 2025 17:38:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=JHEgQXI56zcvBQsz6pNUn1flvTbXYsGowZgT2ZZujDg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=V9mQM6JwJVaUwhz9JtlYax+JRvz3+ayVAUDqFkAPnRFlp2C8F31/fLYGt9Vm0fI/TfffSmZ0sS3+ar+Qdhs+S5shqwkSuWfWX21kEIGv8CYwPVdNMXuB/TXIuNAUmGrywptwwZysI60/PpBEbAj1N86fX2ZMKLcAQvusi2ZER+Xf7wH5UrRg752PqokpfWC9gzCIKvigoI1hF0PqaCveXCvLQUY4HlRRg7yn4P7LUwlZlWZx+p7T8LO/s4b9YWk9tT9IlUSEi+eKidV8GxKJmp/Jv+a1YAGBVgX1IY+JR53LmApUjPvUAbPqql3WUNX/StmKOZAhb/fhUsyClqi1TA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 1E2CA1800123; Thu, 16 Oct 2025 17:38:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 04/24] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Thu, 16 Oct 2025 19:37:43 +0200
Message-ID: <20251016173803.65764-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016173803.65764-1-mohamed@unpredictable.fr>
References: <20251016173803.65764-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyOCBTYWx0ZWRfX+BH7A0xBWr0q
 b/LSx/AiZ0Y2J7Bg7rVDxIdc9nn5md/hReXNjZ8T3BUHXCd+w6gHniGNsq5TrUjdW8IJQ/vsj07
 xQ3kuqzO8cR90eJHNCCCQEK+EqsanKFIgDCAYrpUGnQvga/lA5BuUPIoKibeHO/7yHsSgX+7y+Z
 XXOYxTw6EUdXVar66xHIy/taI5ZYr/svD5JHHUXHeqdKDOId6fcwBGSsdb5H3JBMOyqSIFtp5Ko
 44XDdswY8GVksfOAyLUOoOo3f9us91EDJG4J+qghrn9G/IdZ97pulktwuUP7kx3mUlEIIgIvw=
X-Proofpoint-GUID: YViZzSivYqNXRJJk5bB5gwnzC_E7S2PL
X-Proofpoint-ORIG-GUID: YViZzSivYqNXRJJk5bB5gwnzC_E7S2PL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1030 spamscore=0
 malwarescore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160128
X-JNJ: AAAAAAABkCWw6M/cYeJxyG2UvLWpSQfjv6SZlHZxhFOSCGacZNIRMnkXjJYZkS1gcMQoqN/850NsK07Hk1q4lsaDao+KOsfbubyhssISkI71/r7pjM7VGCzR2jCefke3h4R2kDQkHn8lgQbAkUaPshjCBtye7OMaktRojgDpVdARBifMWe8raTFmS3j4A5aFyYagm27qWytOPf0PQwRlyf2mx8jIdc5gxWxoZ1KZZSA0SvbCSUFE0Lvjksc0RgGmPbAs3W//9RFoxRUeG7ZSAWMGtosoa2sN87xgCE9n+guAqCpuPayQIKvEmtg6Tm7uxY1Jr/ua/AzWnOYUV8rKMKQMyoYWutcCqoow8ecZr2jBEC7P7b1aeKTmou6YNBlQxuhuEznvzhPp/einBlnS+faam9SHSg+4NvZABUYDXRaYdS7nHVb1oCDjAYwjgECUk6uGPxi1ewCjF009AjfAlK/uTHc0lfCGAALMjLMknZjlGYB+8Qw4OBwN7qRBkjlxr3cYXLypcaNjXE1WzRz6XVi3BCClyP8zdJsYsrhVM92mxUvEKffhRu8wgyBivtuNLLD9YIJ0OlF2JgRYsTRpiXggJBRWNvjo8BwKFNGqmuUQdOaxDomNthCUc1UXWNuHgjUNwKN/KG0M+E1YW8VeGFq1cjWxyhsKLoCPcsuQBZOaEEaOfP3HHzrY+TuYIA0Fp+D1/e9XTj+47tXyW+Pif/WrOGOjuZBbLPY4EqgmZnVD/Q0O375eR70MN0aSQbTeok0kV0FQtUMzQ0hGKpwwlNpgXPCf1rlJRhxwGYTcwaGjR6FuggFlGPz4v0NbxlJw4S9GpjFULcnV6rvsaPTi86ZQIaM9vpbWpWZfQV5mdC2HGrZjeq9UoPlm9LEk4lKd9QujU0l9Tqa+iI7Acy6GntXOGs3xoHy8UkOHDTXJCphG3A==
Received-SPF: pass client-ip=57.103.78.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


