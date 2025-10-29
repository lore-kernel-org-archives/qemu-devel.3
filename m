Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D889CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA6A-00045j-UD; Wed, 29 Oct 2025 13:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5s-0003pZ-2B
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:22 -0400
Received: from p-east2-cluster4-host2-snip4-1.eps.apple.com ([57.103.78.162]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5S-0003QK-8C
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:19 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 E48C5182449C; Wed, 29 Oct 2025 17:35:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=jXPIkvwftnVZHRg4Mjz/B4doNai4bCzAxKe4sYL/QI8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VI5BEDOUZ0wpMa8WLJel5uRrxlFR4XCHGrfQ+4I2z2T5v0rqEra702BRSLbM7e6PHaPtv7Hq2+9Oer238Ud8/SLUhPEuBZEE0g88bFA2EXrb6NAvBBlx7beypI8aSgDWQr7/P4cg4drHWYb/7jIcBOGHDuakSMWs3ErwRHEQ1QK936NZHb/wgr5f5dsc6ik936otAUvTgKwamUtRttnaGy+vuoLQIEAkmqZ2YkTg+1YcbrAfjflGjHuldcEXGj+BVYE7s8Oifi03kffJaBlwy21xYt9fp7eRU0slQuenB2GLy6HQwnWkwXZ9CXz7QpNRa4B5NXy1n1Kls6qJ6y4QDg==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 929AC1859E7F; Wed, 29 Oct 2025 16:55:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 15/28] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Wed, 29 Oct 2025 17:54:57 +0100
Message-ID: <20251029165510.45824-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5FJ96SY-4GqKLTxw1XGc8AYppsT211T7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX25SvIoRy8gr5
 tFhfGXuBm4QCuiQl8Nzur7HAnAT5uX/+fLuk2Elasja1g4Vkff8h6++pSM2q3Fulr1m/rOooPWu
 sKfI6MmSaa6Pu0ifMo28VIZtwvL+scfMyIRdE9LbAshtA6LYBEbP6YMPnqoUE3RcMsmlVGyEdB2
 k0VtCBkn36Xvg9+8HiMKgITqwhQ5wlK0mK6qblAd7tocwwkLo+psuOZPx1tdH4oc7XaA74KxdtX
 ZxCZuL+ISS8J9pXPnrGoPX0JcAqYERNDMY2+YBL5C5zNJimovtVCn8qEFyGLQ5fOdqrpGMb9E=
X-Proofpoint-GUID: 5FJ96SY-4GqKLTxw1XGc8AYppsT211T7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=798 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABBkN3elvJAtNm4Vlco2NM6jhwqtq7ocWb/w/4rIe3doHUnH/i37fCWFkVdZ/jEAC4uh3gC1xDC9otGxRqUIgDAYi/eHbWe+fAcXzq0tAwU0MvlQuGDEdOZP8GyE7KB9nfKee7F8uIeg35hI5RAEIE5iqE1t1xAs1nOSsBqHDEoo5hjk7l6F+dfUAfh+MW4z6RMvRWGjYQo/4mCGcD1406NDF1Y+oTFUWeT6QRyBkOthTYbrILuoWQJPOZZZDuVSunVRosnbLPOXi4xPb45duwgwLu5nhjj+Mxg3Fh+n3N+n1T8HzqI9md3Flg9dq+T0L8nUG9wfguuaA7crWt/SDVc0+sMEHkxfmZpoNf4xB5+jgSzGM08ZRTw825sbZlzLDaADPOqrOzURfXcDhbkYX4FxwLD2gzi0JB36/4/7ODkMdNuvqaVYOmNACOobzD7unXthovLOaH9pJ/v1T/Wb+5QXH+RZl2Sou9FeC2ZyNKiMI9xJkAVKlQpuugErAXBPsrk0xab7H8rqyvmc4/wlwBSx3FxrA+Hc5g53+x3BH4ziVAH0CyQabQW2mwqwBmXKzAA3SKCRhMGplm+cop1enyprQeDAN8/4DqX2b8U9q+89QjRAy3puEhzInny6rCBTZnw/P/lhYMykdOXHhV33wSLk6vDvclKSWh9kXq56s8WbiFsPc0Y7K2fE8T+6fAZEDU7nw++vsNKQ0zJdZWyDTOOpXyWq+o98FHZaNUV3BmVN17zTnIxpsGkY6MIg==
Received-SPF: pass client-ip=57.103.78.162;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 hw/arm/virt-acpi-build.c | 15 +++++++------
 hw/arm/virt.c            | 46 +++++++++++++++++++++++++++++++---------
 include/hw/arm/virt.h    |  4 +++-
 3 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0a6ec74aa0..8e730731ca 100644
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
@@ -961,7 +961,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) && !vms->no_gicv3_with_gicv2m) {
+    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms))
+     && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9121eb37eb..dbf9a28b8d 100644
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
@@ -2705,18 +2714,34 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
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
@@ -3426,8 +3451,9 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -3487,8 +3513,8 @@ static void virt_instance_init(Object *obj)
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


