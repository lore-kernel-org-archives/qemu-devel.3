Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E576ECFA76B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO0k-0005T9-O2; Fri, 21 Nov 2025 05:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzl-0004rh-VT
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:03 -0500
Received: from p-east3-cluster4-host3-snip4-1.eps.apple.com ([57.103.84.24]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzd-0007xd-OD
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:59 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 86D5218010FE; Fri, 21 Nov 2025 10:03:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=eNe/xmqtSm1mP0ijoJkzN2BZx4hfdgPJK0YFfGMFMLA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DF1hQALzoWQl5GfN6cexTr+08LL36siT7f3D1AHlzMic3RkNqeKDk/94vouFBAk5BpnUtmLZTLwn673Z3U/ZJ5BDlaVkDSjT82wuxylYGKzQsGweWyJyrJ3fGmi7QX9TZxpLUy1r3FeuZSziEjum9lmlVgpqbWQe7oLXaJM4ryq+tw1TrdYXMzSI/GlYZFHvPL1Ce/UDSmPcQCikZGTSkszb07MpOMiMY7HWQcO7E4yRdf2+JVA30RGaCxYtkyDoOr02DdaZt93yjUwTSx1MN6Aw0QNr7gOPKnlDJ3DX6pxEWMGyXY423m72cZMfH7jxpnZa74AWIHKSlAMGHrKBiQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 5E9591800143; Fri, 21 Nov 2025 10:03:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v11 17/28] hw: arm: virt: rework MSI-X configuration
Date: Fri, 21 Nov 2025 11:02:29 +0100
Message-ID: <20251121100240.89117-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=N6wk1m9B c=1 sm=1 tr=0 ts=692038e3 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=IPYOmMg1pR9sqvhpA7gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX7/AtHFvPVxUA
 ci8eGalDVYGrBhtDKb03bFq4mXr3efzwa4yHY5WokviusFAciihNXqIHDD6NJg2RBNrnQ/aY5c5
 bMx5Yw07AxboQ483tMgGZ12UNArPeBfh0M6MecTWsRqM6akT3aoBEkMDevZrc2OohQahq5otOH5
 zZw2+tgzCpnqq2fjlwQahyZjRSqb6Neswb/Fb6RDNVZ60p0beIPYS64kBRcH7BY/8Sv5wCt3gfy
 f4NYbfJROSFSHDfvD2p1ksVPBvwjw7AWPDomMh2oSLYkKHc1nymYSHkmRZMSmclSydGUUZGO44h
 IjD1kV5R9natR8wmU9g
X-Proofpoint-GUID: UbdcWihXfV80_F3-8GL-V0cExGidavPJ
X-Proofpoint-ORIG-GUID: UbdcWihXfV80_F3-8GL-V0cExGidavPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=878 clxscore=1030 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABzPVe/yTJuxkHy92uPQkY1r7Wyn9OQvNF9eVxOE0Wu5NvSGf+H4fYoT/8/xXSLYeq7PzEsLHIiIo9/sKdxDBoHpWmmFdy4s3JsGzMK5WH0O6XzhdFJ26kCpkkL+DEbVxwEz60e0DBwB/DONQUz/MMG1P1fZ2y0S2IUIHFaFgt+eU5T3VJtNZjy9vbyY8v2EhxBfXoZrkzRqQWWwzWAvavBUQwmi77oZPj+JqyuR4Fn/otZQrjb7uaoTFxHs5ii18qTv+ILQSCopV2upDXQfyXXH+7tIKK+tI/Zn2Cgf9INl2bE1Pw5wq2kDNsZR15S1hstFYrzxTsLZdfqR8G5uWYdjwNfMZMX5Zsy7h1Pi+6RePMQFTPpkmXngD0j4nNSoyJpEzVfN5li1DVeIfvgytDYQw7k4j0ctk5J4wIHCgvWWaz5atPrn5RDcOTdk0m+goxAoxLn3/Gjx3rN+yiGAtoYFUrHy+T+679lalcObI9Xf7ZiAuOW22OrHI9KruDfqkW1bXFRVzkeMFg3eUG4+hEPdOMIfxOrRbacl1LrVBfgUkAB2CHLzSz7pc8j4IxXkZ+dOduh+s1My7qMNVYUPGgX8HZ8pkOaBnpHS2YTodA/sOfw/1FjUUucbsHH8oT9oLL3fXgYoieZWQN5CpiAssOFhSeSngAfPlFXlKyvKKDv8LZAGzLoaRCHJdlFxDf56q5kkanxvCG+1k+wjDM1odhN9vp2BtGOA==
Received-SPF: pass client-ip=57.103.84.24;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduce a -M msi= argument to be able to control MSI-X support independently
from ITS, as part of supporting GICv3 + GICv2m platforms.

Remove vms->its as it's no longer needed after that change.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c |   3 +-
 hw/arm/virt.c            | 111 +++++++++++++++++++++++++++++++--------
 include/hw/arm/virt.h    |   4 +-
 3 files changed, 94 insertions(+), 24 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c8ac58b64e..15e6239e5f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -962,8 +962,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms))
-     && !vms->no_gicv3_with_gicv2m) {
+    if (virt_is_gicv2m_enabled(vms)) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ddc6d4d3b1..7b776187f8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -967,12 +967,12 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     fdt_add_gic_node(vms);
 
-    if (vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms)) {
+    if (virt_is_its_enabled(vms)) {
         create_its(vms);
-    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
-        create_v2m(vms);
-    } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
+    } else if (virt_is_gicv2m_enabled(vms)) {
         create_v2m(vms);
+    } else {
+        vms->msi_controller = VIRT_MSI_CTRL_NONE;
     }
 }
 
@@ -2713,32 +2713,94 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
 
 bool virt_is_its_enabled(VirtMachineState *vms)
 {
-    if (vms->its == ON_OFF_AUTO_OFF) {
-        return false;
+    switch (vms->msi_controller) {
+        case VIRT_MSI_CTRL_NONE:
+            return false;
+        case VIRT_MSI_CTRL_ITS:
+            return true;
+        case VIRT_MSI_CTRL_GICV2M:
+            return false;
+        case VIRT_MSI_CTRL_AUTO:
+            if (whpx_enabled() && whpx_irqchip_in_kernel()) {
+                return false;
+            }
+            if (vms->gic_version == VIRT_GIC_VERSION_2) {
+                return false;
+            }
+            return true;
+        default:
+            return false;
     }
-    if (vms->its == ON_OFF_AUTO_AUTO) {
-        if (whpx_enabled()) {
+}
+
+bool virt_is_gicv2m_enabled(VirtMachineState *vms)
+{
+    switch (vms->msi_controller) {
+        case VIRT_MSI_CTRL_NONE:
             return false;
-        }
+        default:
+            return !virt_is_its_enabled(vms);
     }
-    return true;
 }
 
-static void virt_get_its(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static char *virt_get_msi(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
-    OnOffAuto its = vms->its;
+    const char *val;
 
-    visit_type_OnOffAuto(v, name, &its, errp);
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
+        val = "off";
+        break;
+    case VIRT_MSI_CTRL_ITS:
+        val = "its";
+        break;
+    case VIRT_MSI_CTRL_GICV2M:
+        val = "gicv2m";
+        break;
+    default:
+        val = "auto";
+        break;
+    }
+    return g_strdup(val);
 }
 
-static void virt_set_its(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static void virt_set_msi(Object *obj, const char *value, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    visit_type_OnOffAuto(v, name, &vms->its, errp);
+    if (!strcmp(value, "auto")) {
+        vms->msi_controller = VIRT_MSI_CTRL_AUTO; /* Will be overriden later */
+    } else if (!strcmp(value, "its")) {
+        vms->msi_controller = VIRT_MSI_CTRL_ITS;
+    } else if (!strcmp(value, "gicv2m")) {
+        vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+    } else if (!strcmp(value, "none")) {
+        vms->msi_controller = VIRT_MSI_CTRL_NONE;
+    } else {
+        error_setg(errp, "Invalid msi value");
+        error_append_hint(errp, "Valid values are auto, gicv2m, its, off\n");
+    }
+}
+
+static bool virt_get_its(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return virt_is_its_enabled(vms);
+}
+
+static void virt_set_its(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    if (value) {
+        vms->msi_controller = VIRT_MSI_CTRL_ITS;
+    } else if (vms->no_gicv3_with_gicv2m) {
+        vms->msi_controller = VIRT_MSI_CTRL_NONE;
+    } else {
+        vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+    }
 }
 
 static bool virt_get_dtb_randomness(Object *obj, Error **errp)
@@ -3065,6 +3127,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        case VIRT_MSI_CTRL_AUTO:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3455,13 +3519,18 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "guest CPU which implements the ARM "
                                           "Memory Tagging Extension");
 
-    object_class_property_add(oc, "its", "OnOffAuto",
-        virt_get_its, virt_set_its,
-        NULL, NULL);
+    object_class_property_add_bool(oc, "its", virt_get_its,
+                                   virt_set_its);
     object_class_property_set_description(oc, "its",
                                           "Set on/off to enable/disable "
                                           "ITS instantiation");
 
+    object_class_property_add_str(oc, "msi", virt_get_msi,
+                                  virt_set_msi);
+    object_class_property_set_description(oc, "msi",
+                                          "Set MSI settings. "
+                                          "Valid values are auto/gicv2m/its/off");
+
     object_class_property_add_bool(oc, "dtb-randomness",
                                    virt_get_dtb_randomness,
                                    virt_set_dtb_randomness);
@@ -3518,7 +3587,7 @@ static void virt_instance_init(Object *obj)
     vms->highmem_redists = true;
 
     /* Default allows ITS instantiation if available */
-    vms->its = ON_OFF_AUTO_AUTO;
+    vms->msi_controller = VIRT_MSI_CTRL_AUTO;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
     vms->no_gicv3_with_gicv2m = false;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index abacc366bf..8d6493ae7f 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -101,6 +101,8 @@ typedef enum VirtIOMMUType {
 
 typedef enum VirtMSIControllerType {
     VIRT_MSI_CTRL_NONE,
+    /* This value is overriden at runtime.*/
+    VIRT_MSI_CTRL_AUTO,
     VIRT_MSI_CTRL_GICV2M,
     VIRT_MSI_CTRL_ITS,
 } VirtMSIControllerType;
@@ -147,7 +149,6 @@ struct VirtMachineState {
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
-    OnOffAuto its;
     bool tcg_its;
     bool virt;
     bool ras;
@@ -217,5 +218,6 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
 }
 
 bool virt_is_its_enabled(VirtMachineState *vms);
+bool virt_is_gicv2m_enabled(VirtMachineState *vms);
 
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.50.1 (Apple Git-155)


