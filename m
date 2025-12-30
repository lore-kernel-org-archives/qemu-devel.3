Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4326AE94100
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNEV-0006ET-6k; Mon, 29 Dec 2025 19:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEP-0006D3-RC
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:58 -0500
Received: from p-east2-cluster6-host9-snip4-3.eps.apple.com ([57.103.76.194]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEN-0003i1-PC
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:57 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 DBEE01800109; Tue, 30 Dec 2025 00:04:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=y+ZYHRYb+E5pHeYsI0vujjPW/wVtUK8MJtzmsMoCsS4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Xxfy4mxVeBRCH1dtVWd63Q/3y8bW/GkuYrO/eELwuOx9cFQhkPCB9eAAbvpXO4c9jkzFIXEUxMZft1hlzt/4CLzOjR5IlwzBYlxlB86Jsem/w1l5OCHhpg/AqX2YCZwq7Rd/R4ZViTtZhNmmKSwXa7wSIrD1KAjTKUovx6liTKngljtYvwRGx3o0anTnCAWHV5JrELvFD/8xZIBrwjJuFmb804/ZGQ0n8R4L2ic5VzzdeSnVyp4rSBzrSYFLqxDcUGJIcRU0CNH2wOzo2Zgyn0ojKoypj9+hvcAZ34luY00V3+9y3/wzfJiNStO9ZxWdvZjVuW0Bc9z5gh5bTsFz9w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 42F0E1800457; Tue, 30 Dec 2025 00:04:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 07/28] hw: arm: virt: rework MSI-X configuration
Date: Tue, 30 Dec 2025 01:03:39 +0100
Message-ID: <20251230000401.72124-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=ALPFdfBd c=1 sm=1 tr=0 ts=69531725 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=IPYOmMg1pR9sqvhpA7gA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX4AO67qcz6mGA
 XwpREvSPveNiFXBfwJG8tv3lTrLg9GiZwzS0hgwNWPanNn4YvBhkou2GVDjwAcj+nH7+PHmf0Vg
 1g0qHLs0Ds3US4QWK58fzYaa5CUOA6eG/t8TlZ5D2A3QkpEbHGCySS8UxSHy9TWfZYCB8m9FvnX
 xxEfZ3KIy29NiY4tTDAb7l5p0mFwr7GkpxnQcfzX9OVRetUyn949m2qsgT45Xsavc4GkrvYna0V
 fHPcQJSBOqMjNNeD0CD+4+JxGnmAndHz7Imjf9Sd136HqDW+WEllqUwH5Ml8YFz2NUjMFwihWob
 3zgs78BZO9sltVsDB73
X-Proofpoint-ORIG-GUID: 5u0-HJlbQnk08d_IsOgN4H1HpKaTnSzp
X-Proofpoint-GUID: 5u0-HJlbQnk08d_IsOgN4H1HpKaTnSzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0 mlxlogscore=957
 adultscore=0 clxscore=1030
 malwarescore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAAB3gUrW2Op5vW4CSeoQeYbCrAkwBra/V5+B34rlrGAvVFrPnrGdU4KM1e60Lz1dX3riy8ZTLH0owBZ1rUWh7oyoRITHp4uIBrzIWG6qKQdUnrLg4tWQR4hFAeD34OR3boWebz8jDTQr9y3VOS5LDhtfAXdIgE3QP9Yanpby0OkDqKbcpFYz4N590h0bP5yKgbMMgVy+XAqDsKsgNjMhEmhYgPymJP0Uo2ABNvwY6/V38Xb19Sbo0zUPwGPTL5qSMtoiH4jym3KkXPDVV7TVV8qMCWX134mkyED/3CerITjsB9NX3/iVqNojWfwoXCFTT1mCs/ddrq9jbKo1qLFtPbr3N65e1QSqMSFP4AnGvu0Keh2IE+8Z1QmlUzM+BD/XnxvTmbP9hIw4RFnI5wqKGhbKgyUPRsHKmYAjd/5K4iExQtvM01hWOQoe/c0tpTDYdLmYTBi2fMsZa0nBu9SSXEn8meWVG67a1JSLVFENWt+MohH1Lrz41inc5RuQeFcsfPyLapBHxw2/TwzmxhpN9OXtGJ2RwDyJz/qHAzFNzRt4joqlrYS4NAz8iaxslGAsAQXxOxL4xgl5U34fXITFVKg5U1Mg7sN71C4Lh/PgAuFU+QoxTaYHK5I3JwE38xLdEPj/Txd0tNcxqAV+JmifOUMVsC0zKWXsX77Z1DlwbYWFNlIaJdEjS4wvwa5NJJfQWjlV/lbaJURoiDUdo3fKEfiEIdG0kEDd957fpNJuv/Iy35XSA376hmVmv95SJqjfj/Vkv8EbrYtIG18giCpQnJdCJNbP+EzDgfc5GRiZudyf73OZX9G5jLiDb0jF7+61JEq68FEX+6BwydfEKEisRkDW4rdG1zmyANjo4hSv5THKhKy5U3VCjWDwfJy3OwIE/fII2R83f0EcsJBxFM/SIRGq3PbmFuw9QL3RQeIAhoQvJkJql4=
Received-SPF: pass client-ip=57.103.76.194;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Introduce a -M msi= argument to be able to control MSI-X support independently
from ITS, as part of supporting GICv3 + GICv2m platforms.

Remove vms->its as it's no longer needed after that change.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt-acpi-build.c |   3 +-
 hw/arm/virt.c            | 110 ++++++++++++++++++++++++++++++++-------
 include/hw/arm/virt.h    |   4 +-
 3 files changed, 94 insertions(+), 23 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 86024a1a73..f3adb95cfe 100644
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
index dcdb740586..1858190dd1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -966,12 +966,12 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
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
 
@@ -2710,32 +2710,95 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
 
 bool virt_is_its_enabled(VirtMachineState *vms)
 {
-    if (vms->its == ON_OFF_AUTO_OFF) {
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
         return false;
-    }
-    if (vms->its == ON_OFF_AUTO_AUTO) {
-        if (whpx_enabled()) {
+    case VIRT_MSI_CTRL_ITS:
+        return true;
+    case VIRT_MSI_CTRL_GICV2M:
+        return false;
+    case VIRT_MSI_CTRL_AUTO:
+        if (whpx_enabled() && whpx_irqchip_in_kernel()) {
+            return false;
+        }
+        if (vms->gic_version == VIRT_GIC_VERSION_2) {
             return false;
         }
+        return true;
+    default:
+        return false;
     }
-    return true;
 }
 
-static void virt_get_its(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+bool virt_is_gicv2m_enabled(VirtMachineState *vms)
+{
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
+        return false;
+    default:
+        return !virt_is_its_enabled(vms);
+    }
+}
+
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
+{
+    ERRP_GUARD();
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
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
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    visit_type_OnOffAuto(v, name, &vms->its, errp);
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
@@ -3062,6 +3125,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        case VIRT_MSI_CTRL_AUTO:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3452,13 +3517,18 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -3515,7 +3585,7 @@ static void virt_instance_init(Object *obj)
     vms->highmem_redists = true;
 
     /* Default allows ITS instantiation if available */
-    vms->its = ON_OFF_AUTO_AUTO;
+    vms->msi_controller = VIRT_MSI_CTRL_AUTO;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
     vms->no_gicv3_with_gicv2m = false;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 394b70c62e..ff43bcb739 100644
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


