Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1399E9272A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0cd-0004hS-7Q; Sun, 28 Dec 2025 18:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0cb-0004gp-C2
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:56:25 -0500
Received: from p-west1-cluster1-host4-snip4-4.eps.apple.com ([57.103.64.117]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0cZ-0006jV-9g
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:56:25 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 8625F18000AE; Sun, 28 Dec 2025 23:56:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=djqUEZPSjZdkvi8i+dN9B7VY4WoV8PBYEEOOXDcPQHk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Z2BPXQC8G0IEYabVBvcXu2lDAuzWsCbkQPu0BLGfbnr29RcaZfp+2h/u4jg0wFBptfwjNYcP7xe75BKBniCsaZvkyfwJXuLq2vZx3My7yfAY61ZUThCy6uiZw12N+6pDEHiKpM0bRLmyRf5m+i7Ln7WQTnBS9LxdruLlBZLquUYIvDfOf93VC/5QwxtekDln/l7If17+QLY/sk3Z71AI9s5MgLOqyDf6+QWBHu0/RZXxhgnnJ6Op2DM9Bcy0eirxjtdvCztveJnOfh3CxFQZTdr8bd3p57bE5Usgd5z8woVEPMFJ1+Sob/cUwdhAb+NN5u8714w7uEumwpkVb3GJcA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 9FC7D1800753; Sun, 28 Dec 2025 23:56:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v12 06/28] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Mon, 29 Dec 2025 00:54:00 +0100
Message-ID: <20251228235422.30383-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nVPxbZAZ2vc2VjDHWa5ipICtOFHOSLzM
X-Authority-Info: v=2.4 cv=V51wEOni c=1 sm=1 tr=0 ts=6951c3a5 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=065Y4zqepXN3nrMe:21 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=eCCvHKTOcc9AFgEG6kwA:9
X-Proofpoint-ORIG-GUID: nVPxbZAZ2vc2VjDHWa5ipICtOFHOSLzM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX1rTX1awvGXsh
 bOG8nfIelwbnwipQrdlKBaYTZB2/frH8C1L3FGSBQ8ueGo3gM20Ndb11qeH2oenhVRisDpFFVq0
 m5f9GaHHF5rMFXBq8imhfdFjlogvGZL6JOUvPTr9JEHUFwqhC5l7XSa1b7ry7jG1AS+HE2ZmtC6
 CmFxzerbBoAnuuL1aVkcFkscgybGlMOJjV1auCNrkcwazptWTQUChj0601Ty0uAA0s4fcRIKGVX
 W+YVElafHSmMBY+FlqjV8slekSkxK7smBICTUnB+IPzJ6Hhzbz/x7iZVZDBiIQks/La/f6eLGRj
 Z1qC2K4b55gDo2eWYGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1030 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABUK2f1aE+CtpqEg3DyMwdOB9zxxk17QKCZ+L2U6dfYz5XPZtHqCpcyb+LnFahHvfQXrp5naMO0VTdzLz1TKGcx7J03s+n43UFSaZo7NtWV3Eo0RtfQtTJyQL9Yi5Zfc5jcj9J3DmWZ4d7dSDzI/QLgNBSgoyAfhlKDAfvFKdID47Ryn/fV1EmFAZ+Via7dR4+UFDEX97+rnJusE/UfeVGOXQ1aLpdrWMQGMX2cgDH74YTryElSSUPy0Pi/UPi9wNbmGx78cMD0ftn8fIsQjIK0LvIBxO+YkyweZNBLltWVloLlRalVM+tyRy0vWHDxJWEiyu6O748fELeAYc8Hk+x/Ws77hQzoqvHAwTZndKItkocBvmN8GN1TBgkIV1Ub94OuuI65UMHtsW4VNqIaYCYLPxvAwiJk4Uxvu3xyfEr+2bmVqn7fMeLAAH0gzxWiwACoUhLy2UFleJseQzVnCxq7D11mGon9QobPtkFb3PIuhmmrNf8rukkbD4sq/wkUyM5fjjqF8N3CVxVo46wf7mZNUpG9pCIMJNQGwMMGqi6v9mxOY9A8MXgL6NLxXUBwX5zfgC8cHMG9+phunEjfHz+AbvkmQ6ICoaEd16qCo67eNoB3/S65vhtxwiDIWS10u9FrSjVTS6T09XQtt+OahraWdarOPTdLFWyjIexjaq4wNc5+B7QySxsdaIbsgj/lJEHqQhOPD9nYiszF/XMgfwLKcZhmR+KPe3ic/mNBAUzM+Vujigb5fye6MsNhhlvbtVl8Tv2yK8r8VZLNHbVVvGFgdSryok1/wsnFeLq9IUkdCu3YzPEjbNFIfHZcGTM3X0XBoLwy9+GuR8O3RI/+4SsJGhQudrXuaII1BEmuC9wkrEtMFUuOGZsECZ1tYtvQv8PXgrvkHUuFPgHfwnyfomZNQ68V7J4QcZiQsYS1q2vNxy5bNoISCm55n/rqRCt+HQbZQ==
Received-SPF: pass client-ip=57.103.64.117;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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
index b6f722657a..86024a1a73 100644
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
@@ -962,7 +962,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) && !vms->no_gicv3_with_gicv2m) {
+    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms))
+     && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0fb8dcb07d..dcdb740586 100644
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


