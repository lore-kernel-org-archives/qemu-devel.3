Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0653ED3CC8B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB1r-00063A-Gf; Wed, 14 Jan 2026 19:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1p-00062l-Ab
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:57 -0500
Received: from p-west3-cluster5-host4-snip4-10.eps.apple.com ([57.103.72.43]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1n-0001tw-F9
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:57 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 64EED180045A; Thu, 15 Jan 2026 00:15:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=CDXmA90VChDNF+mgLamehM2Ivt5rkq6oevwq5r0nHLE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WQomujiwHnpNDmi+JoZXRNnQ76IvxXNj/rtwWaEtl40fRlDVR2k53E8SBY7ay4KgzwBt5/GKy1b+oUEKN203/1XnUvmozsf9M0SGTc0SlWKNxqgUwnajDgnNmesumv52Iv5zSTNn5bYqpcupZ3S8EUi6dei8w0DeplcjMKYffLtsDaLJ77ZRJcKBLVKSSLcIVER4otYrPjBJqdzXxp+vl6wNX5+tSC0JqP2t2l9DzKb/6iixwl/HrgJRRky6N8xbf6sdylZKQ9+sTDNhrcGuGjWT4gE0Mhx9oxErK3qwCqKQEhhE/FGbPmGq9DUUw4J909v2IHKE+WZUMjiUkIBxGA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 03D0A1800440; Thu, 15 Jan 2026 00:15:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v15 06/26] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Thu, 15 Jan 2026 01:14:45 +0100
Message-ID: <20260115001505.57237-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=ZdMQ98VA c=1 sm=1 tr=0 ts=696831b9
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=065Y4zqepXN3nrMe:21
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=eCCvHKTOcc9AFgEG6kwA:9
X-Proofpoint-GUID: kxA3zGJdCUkjpPVUDEKKQKtRqkyDoyZd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfXy6A3VZ/mPH1L
 iqlLyqFyQbGvGn/a2TB4BHpw6MQ9Zh8pxZEYDhtZQ05sQWa99bBZQxlhcNQ2CNlt+0jgzbCcA/C
 nupYXLjMqZB67IUj7TZ9yyylMjbwGJjbQIq7uWH8xUt6eVoAnAes9CWpIRiEeItxzuxRAfLK/23
 MMSXANTSMdySeRVlnNcNgjiI4/l2DhfpZJaeg9Tb2O9YRUNzacMQCmqSdDRGn0J1ZlN3bl+5Ok5
 Ic1HYMGQO+Pb/VS7Pgg7glEMwTu1kxwRHNkc5YFMJoJ5sNE+okgC6/Tufssjx4RGnNBWTOq3Fi7
 FKEWJnOWzTlIBHNeWG7
X-Proofpoint-ORIG-GUID: kxA3zGJdCUkjpPVUDEKKQKtRqkyDoyZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601150000
X-JNJ: AAAAAAABvh+kXK8CFn8p9aHIuX4xE6gPZfHhIdf9vahydm2lI+RxXBbDxVeLOvvgQP46OuPXFiC6CPXmSvDyH4O5FATu/oKhJLIklBOiPxgkeMQd0ahkLY5PXOgVSzw4t5s40Tw0KoG9mR8Yu8lqZx3fRDsZZbkrKVjeZO+Y7qI6HmOYknH1NXn5jAnfXAJ1L1YcT0w93jc3aMrMb+y/fplycyAw0okQz1/EeUfl7UT2TW+lqj/VphY78XFzXmR6+OHbTifKo1euaCQ6GJkkbAqjVzLcpY4nAlT+liUcdHJSEu7C0aZgFGe5z2/yd+NeLIn4rPsw5P9PRm818mIOi/TWLj7F50eE7KjqvnA92e5SYjpeSjcfVGqL3W8E5hqlF4hL1jM1/HVo5LFOuXc8RaTSH8F9tYXJ72C8e9yrfk1J5Q5rx+X/q5sB+vbVJG72nQgxOaJiHD158yoUYf9nREqra598q2xaeDQNS9/Dqocrz8Ubtt/REKKwQA3cwwQZuQijQrI94+f13ipqE8xDNgEXRuAnLIH6xaBPOgZukfUYqpm1/dpbCr+2z/W7xo8q/odA65rYPp8+FtxDcQMrwTATOVRc2DSbpYEUAR1aUDMHJuJyS+uikq2jH2LKHEJRQbK/pFG7vghu/PJFkH1NjS8WaMR4afcFV8lObxWDGE97vJAxqwJCsObaJ7kTKq9vXatCk+TDkvx2G4aI5aMevyCWN4WLfodMrH6nGVvwTVS/CUGlcW6fq4bahqcWZbNkqWzT2VBs1f5M7OokAmMoDNeD/O7sH3r2Utq4WhSnYNTaVTW/CyEwGxWY+TEpd/b4vDrZUKgGevafv3LeCmFHONTkDRTFKeLzfs+oLq/ngTRTu4jVGjTJk1JRT4+tliPx/Ga89UuBvtfE1UG/JAEzw7Prr8KyJd22cTyRKypTqLpM4bkNy7ddWZhx/j0=
Received-SPF: pass client-ip=57.103.72.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Switch its to a tristate.

Windows Hypervisor Platform's vGIC doesn't support ITS.
Deal with this by reporting to the user and exiting.

Regular configuration: GICv3 + ITS
New default configuration with WHPX: GICv3 with GICv2m
And its=off explicitly for the newest machine version: GICv3 + GICv2m

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c | 14 ++++++------
 hw/arm/virt.c            | 46 +++++++++++++++++++++++++++++++---------
 include/hw/arm/virt.h    |  4 +++-
 3 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 40ea6b6dd5..86024a1a73 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -473,7 +473,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
         rc_mapping_count = rc_smmu_idmaps_len;
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
@@ -484,7 +484,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             rc_mapping_count += rc_its_idmaps->len;
         }
     } else {
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             nb_nodes = 2; /* RC and ITS */
             rc_mapping_count = 1; /* Direct map to ITS */
         } else {
@@ -499,7 +499,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    if (vms->its) {
+    if (virt_is_its_enabled(vms)) {
         /* Table 12 ITS Group Format */
         build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
         node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
@@ -518,7 +518,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             smmu_mapping_count = 1; /* ITS Group node */
             offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
         } else {
@@ -611,7 +611,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             /*
              * Map bypassed (don't go through the SMMU) RIDs (input) to
              * ITS Group node directly: RC -> ITS.
@@ -946,7 +946,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -962,7 +962,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its)
+    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms))
      && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4fad34e108..553c7f62cc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -737,7 +737,7 @@ static void create_its(VirtMachineState *vms)
 {
     DeviceState *dev;
 
-    assert(vms->its);
+    assert(virt_is_its_enabled(vms));
     if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
         /*
          * Do nothing if ITS is neither supported by the host nor emulated by
@@ -746,6 +746,15 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
+    if (whpx_enabled()) {
+        /*
+         * Signal to the user when ITS is neither supported by the host
+         * nor emulated by the machine.
+         */
+        error_report("ITS not supported on WHPX.");
+        exit(1);
+    }
+
     dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
@@ -957,7 +966,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     fdt_add_gic_node(vms);
 
-    if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
+    if (vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms)) {
         create_its(vms);
     } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
         create_v2m(vms);
@@ -2699,18 +2708,34 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
     extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
 }
 
-static bool virt_get_its(Object *obj, Error **errp)
+bool virt_is_its_enabled(VirtMachineState *vms)
+{
+    if (vms->its == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+    if (vms->its == ON_OFF_AUTO_AUTO) {
+        if (whpx_enabled()) {
+            return false;
+        }
+    }
+    return true;
+}
+
+static void virt_get_its(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
+    OnOffAuto its = vms->its;
 
-    return vms->its;
+    visit_type_OnOffAuto(v, name, &its, errp);
 }
 
-static void virt_set_its(Object *obj, bool value, Error **errp)
+static void virt_set_its(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    vms->its = value;
+    visit_type_OnOffAuto(v, name, &vms->its, errp);
 }
 
 static bool virt_get_dtb_randomness(Object *obj, Error **errp)
@@ -3427,8 +3452,9 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "guest CPU which implements the ARM "
                                           "Memory Tagging Extension");
 
-    object_class_property_add_bool(oc, "its", virt_get_its,
-                                   virt_set_its);
+    object_class_property_add(oc, "its", "OnOffAuto",
+        virt_get_its, virt_set_its,
+        NULL, NULL);
     object_class_property_set_description(oc, "its",
                                           "Set on/off to enable/disable "
                                           "ITS instantiation");
@@ -3488,8 +3514,8 @@ static void virt_instance_init(Object *obj)
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
-    /* Default allows ITS instantiation */
-    vms->its = true;
+    /* Default allows ITS instantiation if available */
+    vms->its = ON_OFF_AUTO_AUTO;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
     vms->no_gicv3_with_gicv2m = false;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c5bc47ee88..394b70c62e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -147,7 +147,7 @@ struct VirtMachineState {
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
-    bool its;
+    OnOffAuto its;
     bool tcg_its;
     bool virt;
     bool ras;
@@ -216,4 +216,6 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
             vms->highmem_redists) ? 2 : 1;
 }
 
+bool virt_is_its_enabled(VirtMachineState *vms);
+
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.50.1 (Apple Git-155)


