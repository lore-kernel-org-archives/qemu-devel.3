Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C85CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RIS-00014A-Ck; Thu, 16 Oct 2025 12:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIR-00013a-1A
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:47 -0400
Received: from p-east2-cluster1-host11-snip4-10.eps.apple.com ([57.103.76.53]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RI2-0001c5-9B
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:43 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 109A51800332; Thu, 16 Oct 2025 16:57:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=l22ICiGLwj6aXpGxuf8i6PtVOTlAq5b5eC2p9+pf+tY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AqMfNsEmKzxAytJaGwKkikXzZrDPBGbU9bLkc7RYI0LeNipd/Ve4/YlzCRvQynML/I49avjPK2Cq+CAaGnqZoBXD5jpzRir1IWd9QJ4w0tpXJMp+pt0txZeUmjmaw57Ew2qgFT7u9M54aq8F7hXJzyFnxAhQhgC92a2O4jJu1rSVgbmvD635MYZfeHDTu0SIoDBKMZJ2Cl+0NZCmgdQOVEzhsHNVRTIuiKDQiDzAzVYosMZdkmLSm2kvXH/ExRMJzuFpMp8/NhLR4+TMBazhMo2YXou0amos0fQ62Abm17nCka4zyb1epmndTvF+sHy4R16v3SSF5HVOU4Kn4huA+A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 6E0311800322; Thu, 16 Oct 2025 16:56:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v7 15/24] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Thu, 16 Oct 2025 18:55:11 +0200
Message-ID: <20251016165520.62532-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: f0tLGjiMLByt0CRyjAwB_UP6ISX8K_7y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX3j7ynFxbvj4u
 1gsBAA9KBG7QCLGTotpcJZuYjtZNpODS0ngM6wQeaGBVJPehWyFCB/NWX1st5XthuMvZyp/iHOe
 j5hzCBMeA/kyf9L7y1/CDAy7SqWhFppXYzNglBQQi6dLy1euU4MwDdyVqQgDLDnvFxUKkOOFKQn
 l1WO52CiSfayf41mEwZgtD+ZuE7iV6wpJxbwqSVU3zQPfrQXj6Vc+3fhBxwQY7hucLcoqVBGgfJ
 S3naUG4gZDfgOka8FTQN98kOJS8u+bV6AW1pO+U1HnYWDpKplcPH2kSUqUElXFdR8TYTTpunY=
X-Proofpoint-ORIG-GUID: f0tLGjiMLByt0CRyjAwB_UP6ISX8K_7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 clxscore=1030
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABsgs2SEdDWHGDOJEpMvZuESfQeN8HtvUY5nHib09Eh7Q0J4ZxhKePxnvcoSfoHFK0WrmyetLqwiDhX0UqAOvoqbMRCqeqwagL7mqaa/swqaE7I5XHqu1fTf14tMBhkXIdq46PMNpCbYKtsTvq4ItX6q7X4B+oK9JUqZ6yxHnUj353q/ydhkZ8klt2JPto142eC8rUrpNsBGL2S7poCcSTsQS8xPl3EPnBmxI8ebUv6s9rkZT238Ovy8qtBpmFHyO19AJOC6WaCKUmm9mOKxuy7RYA7cGZbzMzofJkHoQkZOsWcIJQ52pxehX+0DDdn03ckwsPM+sN0vSgezMvBrRfdQwfk0cdM1O0Dgu7mfgSza62itXZqwWehhGBD2y7sYVDN9cg3+/UV+kdJPkJjCwrc1ijExgHWmlfr2rMI6DdhC27u8iSXPNcMc5dresfOcHWlSeTZ3oP/qK2EsQTkZMmhtCk/qbJo1Fq/9HcArPjBHdkhpSAguVOvEEoYiuaRA5ehV10JO1ryuQD864XLsJwKSaqUv0Sw4vaa4L5D3HchYTVhDnBiMfR9ZwiuNwHflAfW87TZ3DfM2lkiEAgq+JXKBykVNuNy+NBzym1POz8KXvcATjzEFT1IhpdMU8XSy4VjJhYoczzpirITrMTj6hFoUxvbiL94hIFKEKyVcc6WMuEbHDsSJGj+24t5JRjayL22294X9t2EIInxBgXePbmmkUlLmNODE3AmFdIC2CdLkZEdYej5aPG24EMxvkjDQbCWYR2GtA1X8OCE52QeUO3PWzcSBve0b3Rr/pjs47QAbZ7rTrxy5aQTaUKPIbqDzBTMW2JZiWE1vbNXLFOwkjkFx4AVXYIYa80o8VsCmFZh7NmDExjmZ9Trdyy6/9BFFnZOIaGqYKh/Lr7rQ8ZR48=
Received-SPF: pass client-ip=57.103.76.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Switch its to a tristate.

Windows Hypervisor Platform's vGIC doesn't support ITS.
Deal with this by reporting to the user and exiting.

Regular configuration: GICv3 + ITS
New default configuration with WHPX: GICv3 with GICv2m
And its=off explicitly for the newest machine version: GICv3 + GICv2m

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c | 14 +++++------
 hw/arm/virt.c            | 50 ++++++++++++++++++++++++++++++++--------
 include/hw/arm/virt.h    |  4 +++-
 3 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0a6ec74aa0..c716130206 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -472,7 +472,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
         rc_mapping_count = rc_smmu_idmaps_len;
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
@@ -483,7 +483,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             rc_mapping_count += rc_its_idmaps->len;
         }
     } else {
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             nb_nodes = 2; /* RC and ITS */
             rc_mapping_count = 1; /* Direct map to ITS */
         } else {
@@ -498,7 +498,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    if (vms->its) {
+    if (virt_is_its_enabled(vms)) {
         /* Table 12 ITS Group Format */
         build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
         node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
@@ -517,7 +517,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             smmu_mapping_count = 1; /* ITS Group node */
             offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
         } else {
@@ -610,7 +610,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             /*
              * Map bypassed (don't go through the SMMU) RIDs (input) to
              * ITS Group node directly: RC -> ITS.
@@ -945,7 +945,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (vms->its) {
+        if (virt_is_its_enabled(vms)) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -961,7 +961,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) && !vms->no_gicv3_with_gicv2m) {
+    if (virt_is_its_enabled(vms) && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9121eb37eb..1bebbc265d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -735,7 +735,7 @@ static void create_its(VirtMachineState *vms)
 {
     DeviceState *dev;
 
-    assert(vms->its);
+    assert(virt_is_its_enabled(vms));
     if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
         /*
          * Do nothing if ITS is neither supported by the host nor emulated by
@@ -744,6 +744,15 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
+    if (whpx_enabled() && vms->tcg_its) {
+        /*
+         * Signal to the user when ITS is neither supported by the host
+         * nor emulated by the machine.
+         */
+        info_report("ITS not supported on WHPX.");
+        exit(1);
+    }
+
     dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
@@ -955,7 +964,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     fdt_add_gic_node(vms);
 
-    if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
+    if (vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms)) {
         create_its(vms);
     } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
         create_v2m(vms);
@@ -2705,18 +2714,38 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
     extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
 }
 
-static bool virt_get_its(Object *obj, Error **errp)
+bool virt_is_its_enabled(VirtMachineState *vms)
+{
+    if (vms->gic_version == VIRT_GIC_VERSION_2) {
+        return false;
+    }
+
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
@@ -3426,8 +3455,9 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -3487,8 +3517,8 @@ static void virt_instance_init(Object *obj)
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
index d31348dd61..997dd51678 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -149,7 +149,7 @@ struct VirtMachineState {
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
-    bool its;
+    OnOffAuto its;
     bool tcg_its;
     bool virt;
     bool ras;
@@ -218,4 +218,6 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
             vms->highmem_redists) ? 2 : 1;
 }
 
+bool virt_is_its_enabled(VirtMachineState *vms);
+
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.50.1 (Apple Git-155)


