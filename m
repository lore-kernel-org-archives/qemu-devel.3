Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7E8E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0cn-0004zt-Bk; Sun, 28 Dec 2025 18:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0cl-0004xW-D9
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:56:35 -0500
Received: from p-west1-cluster4-host10-snip4-10.eps.apple.com ([57.103.65.171]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0ci-0006sW-O7
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:56:34 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 CEEC71800177; Sun, 28 Dec 2025 23:56:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=cUGC5/KoEH3CNRCO/7juBPUKzVBNzTiIoOBrn9jacTs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XYTMH/hif22uHqatwmn1ZkW4onBnn8dHws0t+ETuSnTYKl8PloIXGFKmR7u/QfPpz2LeZ8WQuj8/mt/0/iNfy5daUrKiOwu2G9a6ADvXcIan5C/TCrH2GE9ZavgYRvqXI4Wt3v6IyZS5ON9a9PtXcpRTgrh2OWlT6AN3ZafBLTrTnkVxPfBijMrJLxx2+cNYeTskDLcW4AWxVKeeWs0w/bMf/uizh+U6v4h79nDDaqiZ1TjSlHeyrbxHOGyZZxZWP7MZ5W0wfLLaQcx5beHoIIkBE0TQWey+4ww7gTLIbi1QzG6l3YJdBoOPnjHqAxUJZtA0F176lOB61ZuYzE/62Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 C363E1800758; Sun, 28 Dec 2025 23:56:19 +0000 (UTC)
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
Subject: [PATCH v12 07/28] hw: arm: virt: rework MSI-X configuration
Date: Mon, 29 Dec 2025 00:54:01 +0100
Message-ID: <20251228235422.30383-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jjMYuaYJZqi710jWnINboyTR2tPgNPMY
X-Authority-Info: v=2.4 cv=V51wEOni c=1 sm=1 tr=0 ts=6951c3ae cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=IPYOmMg1pR9sqvhpA7gA:9
X-Proofpoint-ORIG-GUID: jjMYuaYJZqi710jWnINboyTR2tPgNPMY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfXw5qjssVfB3G8
 mtIfb9SOBnNGJq8hofbTtC/vRJVqR70Svag768FLoCJHgFhpjqU1rm977Mffi3rnfzZC965OkHc
 /hKCdWy2z8+extAWbpr0hEhKJvDglVl7VrPV8XiTcCIxrRqGuwnIrYeAt2jFSID3eFlUNfl7Rni
 YkMqpQxdfBzhb3Jw/nBgYc4Icb72uDWfGoHUThluC+Q79C/J6adxvKcXYoRr9mqG/Su3JtDkPVe
 E+y5uy+SphqRtU/ed+ctDgXVBJV24f2WWk7WqMevUfccY9AFoAs+kKFYHHuPh5PBpJtLH2KSDbh
 5/8xPja6iukY+rs+Xjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=958
 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1030 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABsXRlicokQU834VK3ZqPRK0eZsntLzxpq2UbqaDY3zmTNDchgFdPU17pGIWxEtBpUVicKNjpNguLJ6zsRFDeb956OE08hwN63sg7nX7GRb9fsTD6jx2nBp1MZhY/5az6rcvu7e5yIoePrJwCdBF8KjrQJDcN+089g+DVsF/DNKKMthS9XnFSMsLdXg5XeepJpnRxJ9MUKsxJbRbNoAqvBDcgFPbbTsEo8QKGzYNSC2XCvCcLw4fcDH5DKgJanKVq2WKZzUYCG+Inet/g5XBxjRW2OzU0FDQwPyzvFMmqaAtd8iSzUrPUD+mKcqAvCYC6ynes3mawByRpNQcZOvAI87J7ZRAxOk/2N5YmHjG63dH91HowbODT+NYW5bmFURiN/hyCGP+N7/KX+dqGxQFibYDS65DWcPgk0ZGMAOaCkrYH3f99vkDNVQ0fOZyCygu24F3njmPt4GklSO/umi2rapsNOW0dwU6IMb2RVAGZ29pnNe4kIHsNLz6Jt28oLbXNRWlmlcETU8LO/4dpU+1M9edpz0sGuJ77IW0LVdhzUAp6ilP53xkyY2VVlVLY19DfJdcHaUHxPOQnKQnWKdO1GBSrruoifpPgm0MjcZT1D+EPrcweT4UF4qYHsUNSuWkHUwvNY1hFeQJXq+xA1TBi63NNz8xJyrhqeinnVbZylwsis7NMXN3Zcl55L2Yy+KS0thUoRiyg7MRaQiTFIJWdGCZHKkhj4of1YgZLHYwtBMRVA9dBkp3zrMo70VqcyVHHhJksECcK+KYPtxu7Z4qTX9G1qfqC7v0KOAIYZ3Y9FISKNXUtZIOk2nhLXvhrwX5AtZ8L5ws2ju2x/u8hSAeKzCvTG5+qjEj75npiR3FgED0dXIHdiOYlsdi/FGdiCAXu5JVZZImTB4Hwtmf0oOEepBpFhmF+LZ1W3yqLwS9aYXqMKf5GRJqxN
Received-SPF: pass client-ip=57.103.65.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Introduce a -M msi= argument to be able to control MSI-X support independently
from ITS, as part of supporting GICv3 + GICv2m platforms.

Remove vms->its as it's no longer needed after that change.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c |   3 +-
 hw/arm/virt.c            | 112 +++++++++++++++++++++++++++++++--------
 include/hw/arm/virt.h    |   4 +-
 3 files changed, 95 insertions(+), 24 deletions(-)

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
index dcdb740586..80c9b2bc76 100644
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
+    ERRP_GUARD();
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


