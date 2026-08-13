Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75C9C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYEE-0007zJ-Fl; Thu, 13 Aug 2026 12:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYEC-0007xw-Dm; Thu, 13 Aug 2026 12:24:24 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYE7-0000WR-BW; Thu, 13 Aug 2026 12:24:24 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCXLlOw731q_xpvAw--.15742S2; 
 Fri, 14 Aug 2026 00:24:16 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwjnOq731q3SwjAA--.59176S4;
 Fri, 14 Aug 2026 00:24:12 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 02/28] hw/arm/smmuv3: Introduce banked registers for SMMUv3
 state
Date: Fri, 14 Aug 2026 00:24:07 +0800
Message-Id: <20260813162410.2805113-2-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwjnOq731q3SwjAA--.59176S4
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HjgABsY
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWDCryfZFyUZF4ktr15Jw1DKFg_yoWrCrWrJo
 W2yr4qqw4DZw4vka48uFn5JF18tFW8Cw4qva1YqrWa9FsrKw45Kry8trs8CFyakF45XrZ7
 Cw4xu3yrXFWIvFn5n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rework the SMMUv3 state management by introducing a banked register
structure. This is a purely mechanical refactoring with no functional
changes.

To support multiple security states, a new enum, SMMUSecSID, is
introduced to identify each state, sticking to the spec terminology.

A new structure, SMMUv3RegBank, is then defined to hold the state
for a single security context. The main SMMUv3State now contains an
array of these banks, indexed by SMMUSecSID. This avoids the need for
separate fields for non-secure and future secure registers.

All existing code, which handles only the Non-secure state, is updated
to access its state via s->bank[SMMU_SEC_SID_NS]. A local bank helper
pointer is used where it improves readability.

Function signatures and logic remain untouched in this commit to
isolate the structural changes and simplify review. This is the
foundational step for building multi-security-state support.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3-accel.c        |  67 ++++---
 hw/arm/smmuv3-internal.h     |  24 ++-
 hw/arm/smmuv3.c              | 374 +++++++++++++++++++----------------
 hw/arm/tegra241-cmdqv.c      |   6 +-
 include/hw/arm/smmu-common.h |   6 +
 include/hw/arm/smmuv3.h      |  30 ++-
 6 files changed, 295 insertions(+), 212 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 91aca1aa14e..3ff3da66acd 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -41,6 +41,7 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                        struct iommu_hw_info_arm_smmuv3 *info)
 {
     SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
 
     /*
      * Return if 'auto' was not set for any accel SMMUv3 property, or
@@ -55,23 +56,23 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
     }
 
     if (s->ats == ON_OFF_AUTO_AUTO) {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
-                               FIELD_EX32(info->idr[0], IDR0, ATS));
+        bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, ATS,
+                                  FIELD_EX32(info->idr[0], IDR0, ATS));
     }
 
     if (s->ril == ON_OFF_AUTO_AUTO) {
-        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
-                               FIELD_EX32(info->idr[3], IDR3, RIL));
+        bank->idr[3] = FIELD_DP32(bank->idr[3], IDR3, RIL,
+                                  FIELD_EX32(info->idr[3], IDR3, RIL));
     }
 
     if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
-        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
-                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
+        bank->idr[1] = FIELD_DP32(bank->idr[1], IDR1, SSIDSIZE,
+                                  FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
     }
 
     if (s->oas == OAS_MODE_AUTO) {
-        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS,
-                               FIELD_EX32(info->idr[5], IDR5, OAS));
+        bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, OAS,
+                                  FIELD_EX32(info->idr[5], IDR5, OAS));
     }
 
     accel->auto_finalised = true;
@@ -82,21 +83,22 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
                                  Error **errp)
 {
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
     smmuv3_accel_auto_finalise(s, info);
 
     /* QEMU SMMUv3 supports both linear and 2-level stream tables */
     if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
-                FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
+                FIELD_EX32(bank->idr[0], IDR0, STLEVEL)) {
         error_setg(errp, "Host SMMUv3 Stream Table format mismatch "
                    "(host STLEVEL=%u, QEMU STLEVEL=%u)",
                    FIELD_EX32(info->idr[0], IDR0, STLEVEL),
-                   FIELD_EX32(s->idr[0], IDR0, STLEVEL));
+                   FIELD_EX32(bank->idr[0], IDR0, STLEVEL));
         return false;
     }
 
     /* QEMU SMMUv3 supports only little-endian translation table walks */
     if (FIELD_EX32(info->idr[0], IDR0, TTENDIAN) >
-                FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
+                FIELD_EX32(bank->idr[0], IDR0, TTENDIAN)) {
         error_setg(errp, "Host SMMUv3 doesn't support Little-endian "
                    "translation table");
         return false;
@@ -104,7 +106,7 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
 
     /* QEMU SMMUv3 supports only AArch64 translation table format */
     if (FIELD_EX32(info->idr[0], IDR0, TTF) <
-                FIELD_EX32(s->idr[0], IDR0, TTF)) {
+                FIELD_EX32(bank->idr[0], IDR0, TTF)) {
         error_setg(errp, "Host SMMUv3 doesn't support AArch64 translation "
                    "table format");
         return false;
@@ -112,59 +114,59 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
 
     /* QEMU SMMUv3 supports SIDSIZE 16 */
     if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
-                FIELD_EX32(s->idr[1], IDR1, SIDSIZE)) {
+                FIELD_EX32(bank->idr[1], IDR1, SIDSIZE)) {
         error_setg(errp, "Host SMMUv3 SIDSIZE not compatible "
                    "(host=%u, QEMU=%u)",
                    FIELD_EX32(info->idr[1], IDR1, SIDSIZE),
-                   FIELD_EX32(s->idr[1], IDR1, SIDSIZE));
+                   FIELD_EX32(bank->idr[1], IDR1, SIDSIZE));
         return false;
     }
 
     /* Check SSIDSIZE value opted-in is compatible with Host SMMUv3 SSIDSIZE */
     if (FIELD_EX32(info->idr[1], IDR1, SSIDSIZE) <
-                FIELD_EX32(s->idr[1], IDR1, SSIDSIZE)) {
+                FIELD_EX32(bank->idr[1], IDR1, SSIDSIZE)) {
         error_setg(errp, "Host SMMUv3 SSIDSIZE not compatible "
                    "(host=%u, QEMU=%u)",
                    FIELD_EX32(info->idr[1], IDR1, SSIDSIZE),
-                   FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
+                   FIELD_EX32(bank->idr[1], IDR1, SSIDSIZE));
         return false;
     }
 
     /* User can disable QEMU SMMUv3 Range Invalidation support */
     if (FIELD_EX32(info->idr[3], IDR3, RIL) <
-                FIELD_EX32(s->idr[3], IDR3, RIL)) {
+                FIELD_EX32(bank->idr[3], IDR3, RIL)) {
         error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
         return false;
     }
     /* Check OAS value opted is compatible with Host SMMUv3 IPA */
     if (FIELD_EX32(info->idr[5], IDR5, OAS) <
-                FIELD_EX32(s->idr[5], IDR5, OAS)) {
+                FIELD_EX32(bank->idr[5], IDR5, OAS)) {
         error_setg(errp, "Host SMMUv3 supports only %d-bit IPA, but the vSMMU "
                    "OAS implies %d-bit IPA",
                    smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)),
-                   smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
+                   smmuv3_oas_bits(FIELD_EX32(bank->idr[5], IDR5, OAS)));
         return false;
     }
     /* Check ATS value opted is compatible with Host SMMUv3 */
     if (FIELD_EX32(info->idr[0], IDR0, ATS) <
-                FIELD_EX32(s->idr[0], IDR0, ATS)) {
+                FIELD_EX32(bank->idr[0], IDR0, ATS)) {
         error_setg(errp, "Host SMMUv3 doesn't support Address Translation Services");
         return false;
     }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
-                FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
+                FIELD_EX32(bank->idr[5], IDR5, GRAN4K)) {
         error_setg(errp, "Host SMMUv3 doesn't support 4K translation granule");
         return false;
     }
     if (FIELD_EX32(info->idr[5], IDR5, GRAN16K) !=
-                FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
+                FIELD_EX32(bank->idr[5], IDR5, GRAN16K)) {
         error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
         return false;
     }
     if (FIELD_EX32(info->idr[5], IDR5, GRAN64K) !=
-                FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
+                FIELD_EX32(bank->idr[5], IDR5, GRAN64K)) {
         error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
         return false;
     }
@@ -218,7 +220,8 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
 
 static uint32_t smmuv3_accel_gbpa_hwpt(SMMUv3State *s, SMMUv3AccelState *accel)
 {
-    return FIELD_EX32(s->gbpa, GBPA, ABORT) ?
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+    return FIELD_EX32(bank->gbpa, GBPA, ABORT) ?
            accel->abort_hwpt_id : accel->bypass_hwpt_id;
 }
 
@@ -544,6 +547,8 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     uint32_t veventq_id;
     uint32_t veventq_fd;
     int flags;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
 
     if (!accel || !accel->viommu) {
         return true;
@@ -560,7 +565,7 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     if (!iommufd_backend_alloc_veventq(accel->viommu->iommufd,
                                        accel->viommu->viommu_id,
                                        IOMMU_VEVENTQ_TYPE_ARM_SMMUV3,
-                                       1 << s->eventq.log2size, &veventq_id,
+                                       1 << bank->eventq.log2size, &veventq_id,
                                        &veventq_fd, errp)) {
         return false;
     }
@@ -943,9 +948,10 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
 
 static inline bool smmuv3_pasid_supported(SMMUv3State *s)
 {
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
     return s->ssidsize > SSID_SIZE_MODE_0 ||
            (s->ssidsize == SSID_SIZE_MODE_AUTO &&
-            FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
+            FIELD_EX32(bank->idr[1], IDR1, SSIDSIZE));
 }
 
 static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
@@ -997,19 +1003,20 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
         return;
     }
 
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
     /* Only override RIL if user explicitly set OFF */
     if (s->ril == ON_OFF_AUTO_OFF) {
-        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
+        bank->idr[3] = FIELD_DP32(bank->idr[3], IDR3, RIL, 0);
     }
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
     if (s->ats == ON_OFF_AUTO_ON) {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
+        bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, ATS, 1);
     }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
     if (s->oas == OAS_MODE_48) {
-        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
+        bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
 
     /*
@@ -1017,7 +1024,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
      * has enabled it.
      */
     if (s->ssidsize > SSID_SIZE_MODE_0) {
-        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+        bank->idr[1] = FIELD_DP32(bank->idr[1], IDR1, SSIDSIZE,
                                ssidsize_mode_to_value(s->ssidsize));
     }
 }
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 0819a4b2e8d..10154ca161d 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -41,7 +41,9 @@ typedef enum SMMUTranslationClass {
 
 static inline int smmu_enabled(SMMUv3State *s)
 {
-    return FIELD_EX32(s->cr[0], CR0, SMMUEN);
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    return FIELD_EX32(bank->cr[0], CR0, SMMUEN);
 }
 
 /* Command Queue Entry */
@@ -69,12 +71,16 @@ static inline uint32_t smmuv3_idreg(int regoffset)
 
 static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s)
 {
-    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    return FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
 }
 
 static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
 {
-    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    return FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
 }
 
 /* Queue Handling */
@@ -119,17 +125,23 @@ static inline void queue_cons_incr(SMMUQueue *q)
 
 static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
 {
-    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    return FIELD_EX32(bank->cr[0], CR0, CMDQEN);
 }
 
 static inline bool smmuv3_eventq_enabled(SMMUv3State *s)
 {
-    return FIELD_EX32(s->cr[0], CR0, EVENTQEN);
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    return FIELD_EX32(bank->cr[0], CR0, EVENTQEN);
 }
 
 static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type)
 {
-    s->cmdq.cons = FIELD_DP32(s->cmdq.cons, CMDQ_CONS, ERR, err_type);
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    bank->cmdq.cons = FIELD_DP32(bank->cmdq.cons, CMDQ_CONS, ERR, err_type);
 }
 
 static const char *cmd_stringify[] = {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ed19536a4dc..d3baae8a32a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -53,6 +53,8 @@
 static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
                                uint32_t gerror_mask)
 {
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
 
     bool pulse = false;
 
@@ -68,15 +70,15 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
         break;
     case SMMU_IRQ_GERROR:
     {
-        uint32_t pending = s->gerror ^ s->gerrorn;
+        uint32_t pending = bank->gerror ^ bank->gerrorn;
         uint32_t new_gerrors = ~pending & gerror_mask;
 
         if (!new_gerrors) {
             /* only toggle non pending errors */
             return;
         }
-        s->gerror ^= new_gerrors;
-        trace_smmuv3_write_gerror(new_gerrors, s->gerror);
+        bank->gerror ^= new_gerrors;
+        trace_smmuv3_write_gerror(new_gerrors, bank->gerror);
 
         pulse = smmuv3_gerror_irq_enabled(s);
         break;
@@ -90,8 +92,10 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
 
 static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
 {
-    uint32_t pending = s->gerror ^ s->gerrorn;
-    uint32_t toggled = s->gerrorn ^ new_gerrorn;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    uint32_t pending = bank->gerror ^ bank->gerrorn;
+    uint32_t toggled = bank->gerrorn ^ new_gerrorn;
 
     if (toggled & ~pending) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -103,9 +107,9 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
      * We do not raise any error in case guest toggles bits corresponding
      * to not active IRQs (CONSTRAINED UNPREDICTABLE)
      */
-    s->gerrorn = new_gerrorn;
+    bank->gerrorn = new_gerrorn;
 
-    trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
+    trace_smmuv3_write_gerrorn(toggled & pending, bank->gerrorn);
 }
 
 static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
@@ -147,7 +151,9 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
 
 static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
 {
-    SMMUQueue *q = &s->eventq;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    SMMUQueue *q = &bank->eventq;
     MemTxResult r;
 
     if (!smmuv3_eventq_enabled(s)) {
@@ -275,74 +281,87 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
  */
 static void smmuv3_init_id_regs(SMMUv3State *s)
 {
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
+        bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, S2P, 1);
     } else if (s->stage && !strcmp("nested", s->stage)) {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
+        bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, S1P, 1);
+        bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, S2P, 1);
     } else {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
-    }
-
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TTF, 2); /* AArch64 PTW only */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, COHACC, 1); /* IO coherent */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ASID16, 1); /* 16-bit ASID */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, VMID16, 1); /* 16-bit VMID */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TTENDIAN, 2); /* little endian */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STALL_MODEL, 1); /* No stall */
+        bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, S1P, 1);
+    }
+
+    /* AArch64 PTW only */
+    bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, TTF, 2);
+    /* IO coherent */
+    bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, COHACC, 1);
+    /* 16-bit ASID */
+    bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, ASID16, 1);
+    /* 16-bit VMID */
+    bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, VMID16, 1);
+    /* little endian */
+    bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, TTENDIAN, 2);
+    /* No stall */
+    bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, STALL_MODEL, 1);
     /* terminated transaction will always be aborted/error returned */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TERM_MODEL, 1);
+    bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, TERM_MODEL, 1);
     /* 2-level stream table supported */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, 1);
+    bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, STLEVEL, 1);
 
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
+    bank->idr[1] = FIELD_DP32(bank->idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
+    bank->idr[1] = FIELD_DP32(bank->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
+    bank->idr[1] = FIELD_DP32(bank->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
 
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
-    if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
+    bank->idr[3] = FIELD_DP32(bank->idr[3], IDR3, HAD, 1);
+    if (FIELD_EX32(bank->idr[0], IDR0, S2P)) {
         /* XNX is a stage-2-specific feature */
-        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
+        bank->idr[3] = FIELD_DP32(bank->idr[3], IDR3, XNX, 1);
     }
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
+    bank->idr[3] = FIELD_DP32(bank->idr[3], IDR3, RIL, 1);
+    bank->idr[3] = FIELD_DP32(bank->idr[3], IDR3, BBML, 2);
 
     /* OAS: 44 bits */
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
+    bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
     /* 4K, 16K and 64K granule support */
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
+    bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN4K, 1);
+    bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN16K, 1);
+    bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN64K, 1);
     s->aidr = 0x1;
     smmuv3_accel_idr_override(s);
 }
 
 bool smmuv3_ats_enabled(SMMUv3State *s)
 {
-    return FIELD_EX32(s->idr[0], IDR0, ATS);
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+    return FIELD_EX32(bank->idr[0], IDR0, ATS);
 }
 
 static void smmuv3_reset(SMMUv3State *s)
 {
-    s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
-    s->cmdq.prod = 0;
-    s->cmdq.cons = 0;
-    s->cmdq.entry_size = sizeof(struct Cmd);
-    s->eventq.base = deposit64(s->eventq.base, 0, 5, SMMU_EVENTQS);
-    s->eventq.prod = 0;
-    s->eventq.cons = 0;
-    s->eventq.entry_size = sizeof(struct Evt);
-
-    s->features = 0;
-    s->sid_split = 0;
-    s->cr[0] = 0;
-    s->cr0ack = 0;
-    s->irq_ctrl = 0;
-    s->gerror = 0;
-    s->gerrorn = 0;
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+
+    bank->cmdq.base = deposit64(bank->cmdq.base, 0, 5, SMMU_CMDQS);
+    bank->cmdq.prod = 0;
+    bank->cmdq.cons = 0;
+    bank->cmdq.entry_size = sizeof(struct Cmd);
+    bank->eventq.base = deposit64(bank->eventq.base, 0, 5, SMMU_EVENTQS);
+    bank->eventq.prod = 0;
+    bank->eventq.cons = 0;
+    bank->eventq.entry_size = sizeof(struct Evt);
+
+    bank->features = 0;
+    bank->sid_split = 0;
+    bank->cr[0] = 0;
+    bank->cr0ack = 0;
+    bank->irq_ctrl = 0;
+    bank->gerror = 0;
+    bank->gerrorn = 0;
+    bank->gbpa = SMMU_GBPA_RESET_VAL;
+
+    s->aidr = 0x1;
     s->statusr = 0;
-    s->gbpa = SMMU_GBPA_RESET_VAL;
 }
 
 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
@@ -456,7 +475,8 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
 static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
                              STE *ste)
 {
-    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
+    uint8_t oas = FIELD_EX32(smmuv3_bank(s, SMMU_SEC_SID_NS)->idr[5],
+                             IDR5, OAS);
 
     if (STE_S2AA64(ste) == 0x0) {
         qemu_log_mask(LOG_UNIMP,
@@ -574,7 +594,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
                       STE *ste, SMMUEventInfo *event)
 {
     uint32_t config;
-    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
+    /* OAS field only presents on NS-IDR5 so we use hardcoded SMMU_SEC_SID_NS */
+    uint8_t oas = FIELD_EX32(smmuv3_bank(s, SMMU_SEC_SID_NS)->idr[5],
+                             IDR5, OAS);
     int ret;
 
     if (!STE_VALID(ste)) {
@@ -628,7 +650,8 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     /* Multiple context descriptors require SubstreamID support */
     if ((s->ssidsize == SSID_SIZE_MODE_0 ||
          (s->ssidsize == SSID_SIZE_MODE_AUTO &&
-          !FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) &&
+          !FIELD_EX32(smmuv3_bank(s, SMMU_SEC_SID_NS)->idr[1],
+                      IDR1, SSIDSIZE))) &&
         STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
                 "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
@@ -666,9 +689,11 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
     uint32_t log2size;
     int strtab_size;
     int ret;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
 
-    trace_smmuv3_find_ste(sid, s->features, s->sid_split);
-    log2size = FIELD_EX32(s->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
+    trace_smmuv3_find_ste(sid, bank->features, bank->sid_split);
+    log2size = FIELD_EX32(bank->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
     /*
      * Check SID range against both guest-configured and implementation limits
      */
@@ -676,7 +701,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
         event->type = SMMU_EVT_C_BAD_STREAMID;
         return -EINVAL;
     }
-    if (s->features & SMMU_FEATURE_2LVL_STE) {
+    if (bank->features & SMMU_FEATURE_2LVL_STE) {
         int l1_ste_offset, l2_ste_offset, max_l2_ste, span, i;
         dma_addr_t l1ptr, l2ptr;
         STEDesc l1std;
@@ -685,11 +710,11 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
          * Align strtab base address to table size. For this purpose, assume it
          * is not bounded by SMMU_IDR1_SIDSIZE.
          */
-        strtab_size = MAX(6, (int)log2size - s->sid_split + L1STD_SIZE);
-        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+        strtab_size = MAX(6, (int)log2size - bank->sid_split + L1STD_SIZE);
+        strtab_base = bank->strtab_base & SMMU_BASE_ADDR_MASK &
                       ~MAKE_64BIT_MASK(0, strtab_size);
-        l1_ste_offset = sid >> s->sid_split;
-        l2_ste_offset = sid & ((1 << s->sid_split) - 1);
+        l1_ste_offset = sid >> bank->sid_split;
+        l2_ste_offset = sid & ((1 << bank->sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
         /* TODO: guarantee 64-bit single-copy atomicity */
         ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
@@ -717,7 +742,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
             return -EINVAL;
         }
 
-        if (span > s->sid_split + 1) {
+        if (span > bank->sid_split + 1) {
             if (!event->inval_ste_allowed) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "invalid span (0x%x)\n", span);
@@ -728,9 +753,8 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 
         max_l2_ste = (1 << span) - 1;
         l2ptr = l1std_l2ptr(&l1std);
-
         l2ptr &= ~MAKE_64BIT_MASK(0, 6 + (span - 1));
-        trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
+        trace_smmuv3_find_ste_2lvl(bank->strtab_base, l1ptr, l1_ste_offset,
                                    l2ptr, l2_ste_offset, max_l2_ste);
         if (l2_ste_offset > max_l2_ste) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -743,7 +767,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
     } else {
         strtab_size = log2size + STE_SIZE;
         strtab_size = MIN(64, strtab_size);
-        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+        strtab_base = bank->strtab_base & SMMU_BASE_ADDR_MASK &
                       ~MAKE_64BIT_MASK(0, strtab_size);
         addr = strtab_base + sid * sizeof(*ste);
     }
@@ -762,7 +786,8 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
     int i;
     SMMUTranslationStatus status;
     SMMUTLBEntry *entry;
-    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
+    uint8_t oas = FIELD_EX32(smmuv3_bank(s, SMMU_SEC_SID_NS)->idr[5],
+                             IDR5, OAS);
 
     if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
         goto bad_cd;
@@ -1084,6 +1109,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUv3State *s = sdev->smmu;
     uint32_t sid = smmu_get_sid(sdev);
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUEventInfo event = {.type = SMMU_EVT_NONE,
                            .sid = sid,
                            .inval_ste_allowed = false};
@@ -1101,7 +1128,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     qemu_mutex_lock(&s->mutex);
 
     if (!smmu_enabled(s)) {
-        if (FIELD_EX32(s->gbpa, GBPA, ABORT)) {
+        if (FIELD_EX32(bank->gbpa, GBPA, ABORT)) {
             status = SMMU_TRANS_ABORT;
         } else {
             status = SMMU_TRANS_DISABLE;
@@ -1325,7 +1352,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
-    SMMUQueue *q = &s->cmdq;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    SMMUQueue *q = &bank->cmdq;
     SMMUCommandType type = 0;
 
     if (!smmuv3_cmdq_enabled(s)) {
@@ -1339,7 +1368,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
      */
 
     while (!smmuv3_q_empty(q)) {
-        uint32_t pending = s->gerror ^ s->gerrorn;
+        uint32_t pending = bank->gerror ^ bank->gerrorn;
         Cmd cmd;
 
         trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
@@ -1601,29 +1630,32 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
                                uint64_t data, MemTxAttrs attrs)
 {
+    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+
     switch (offset) {
     case A_GERROR_IRQ_CFG0:
-        s->gerror_irq_cfg0 = data;
+        bank->gerror_irq_cfg0 = data;
         return MEMTX_OK;
     case A_STRTAB_BASE:
-        s->strtab_base = data;
+        bank->strtab_base = data;
         return MEMTX_OK;
     case A_CMDQ_BASE:
-        s->cmdq.base = data;
-        s->cmdq.log2size = extract64(s->cmdq.base, 0, 5);
-        if (s->cmdq.log2size > SMMU_CMDQS) {
-            s->cmdq.log2size = SMMU_CMDQS;
+        bank->cmdq.base = data;
+        bank->cmdq.log2size = extract64(bank->cmdq.base, 0, 5);
+        if (bank->cmdq.log2size > SMMU_CMDQS) {
+            bank->cmdq.log2size = SMMU_CMDQS;
         }
         return MEMTX_OK;
     case A_EVENTQ_BASE:
-        s->eventq.base = data;
-        s->eventq.log2size = extract64(s->eventq.base, 0, 5);
-        if (s->eventq.log2size > SMMU_EVENTQS) {
-            s->eventq.log2size = SMMU_EVENTQS;
+        bank->eventq.base = data;
+        bank->eventq.log2size = extract64(bank->eventq.base, 0, 5);
+        if (bank->eventq.log2size > SMMU_EVENTQS) {
+            bank->eventq.log2size = SMMU_EVENTQS;
         }
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0:
-        s->eventq_irq_cfg0 = data;
+        bank->eventq_irq_cfg0 = data;
         return MEMTX_OK;
     default:
         qemu_log_mask(LOG_UNIMP,
@@ -1637,11 +1669,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
                                uint64_t data, MemTxAttrs attrs)
 {
     Error *local_err = NULL;
+    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
 
     switch (offset) {
     case A_CR0:
-        s->cr[0] = data;
-        s->cr0ack = data & ~SMMU_CR0_RESERVED;
+        bank->cr[0] = data;
+        bank->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s, &local_err);
         if (local_err) {
@@ -1652,13 +1686,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         smmuv3_accel_alloc_veventq(s, &local_err);
         break;
     case A_CR1:
-        s->cr[1] = data;
+        bank->cr[1] = data;
         break;
     case A_CR2:
-        s->cr[2] = data;
+        bank->cr[2] = data;
         break;
     case A_IRQ_CTRL:
-        s->irq_ctrl = data;
+        bank->irq_ctrl = data;
         break;
     case A_GERRORN:
         smmuv3_write_gerrorn(s, data);
@@ -1669,16 +1703,16 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         smmuv3_cmdq_consume(s, &local_err);
         break;
     case A_GERROR_IRQ_CFG0: /* 64b */
-        s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 0, 32, data);
+        bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 0, 32, data);
         break;
     case A_GERROR_IRQ_CFG0 + 4:
-        s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 32, 32, data);
+        bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 32, 32, data);
         break;
     case A_GERROR_IRQ_CFG1:
-        s->gerror_irq_cfg1 = data;
+        bank->gerror_irq_cfg1 = data;
         break;
     case A_GERROR_IRQ_CFG2:
-        s->gerror_irq_cfg2 = data;
+        bank->gerror_irq_cfg2 = data;
         break;
     case A_GBPA:
         /*
@@ -1687,74 +1721,75 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
          */
         if (data & R_GBPA_UPDATE_MASK) {
             /* Ignore update bit as write is synchronous. */
-            s->gbpa = data & ~R_GBPA_UPDATE_MASK;
+            bank->gbpa = data & ~R_GBPA_UPDATE_MASK;
             smmuv3_accel_attach_gbpa_hwpt(s, &local_err);
         }
         break;
     case A_STRTAB_BASE: /* 64b */
-        s->strtab_base = deposit64(s->strtab_base, 0, 32, data);
+        bank->strtab_base = deposit64(bank->strtab_base, 0, 32, data);
         break;
     case A_STRTAB_BASE + 4:
-        s->strtab_base = deposit64(s->strtab_base, 32, 32, data);
+        bank->strtab_base = deposit64(bank->strtab_base, 32, 32, data);
         break;
     case A_STRTAB_BASE_CFG:
-        s->strtab_base_cfg = data;
+        bank->strtab_base_cfg = data;
         if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) == 1) {
-            s->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
-            if (s->sid_split != 6 && s->sid_split != 8 && s->sid_split != 10) {
+            bank->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
+            if (bank->sid_split != 6 && bank->sid_split != 8 &&
+                bank->sid_split != 10) {
                 /* Other values are reserved, behave as 6 */
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "Invalid STRTAB_BASE_CFG.SPLIT=%u, use 6 instead\n",
-                              s->sid_split);
-                s->sid_split = 6;
+                              bank->sid_split);
+                bank->sid_split = 6;
             }
-            s->features |= SMMU_FEATURE_2LVL_STE;
+            bank->features |= SMMU_FEATURE_2LVL_STE;
         }
         break;
     case A_CMDQ_BASE: /* 64b */
-        s->cmdq.base = deposit64(s->cmdq.base, 0, 32, data);
-        s->cmdq.log2size = extract64(s->cmdq.base, 0, 5);
-        if (s->cmdq.log2size > SMMU_CMDQS) {
-            s->cmdq.log2size = SMMU_CMDQS;
+        bank->cmdq.base = deposit64(bank->cmdq.base, 0, 32, data);
+        bank->cmdq.log2size = extract64(bank->cmdq.base, 0, 5);
+        if (bank->cmdq.log2size > SMMU_CMDQS) {
+            bank->cmdq.log2size = SMMU_CMDQS;
         }
         break;
     case A_CMDQ_BASE + 4: /* 64b */
-        s->cmdq.base = deposit64(s->cmdq.base, 32, 32, data);
+        bank->cmdq.base = deposit64(bank->cmdq.base, 32, 32, data);
         break;
     case A_CMDQ_PROD:
-        s->cmdq.prod = data;
+        bank->cmdq.prod = data;
         smmuv3_cmdq_consume(s, &local_err);
         break;
     case A_CMDQ_CONS:
-        s->cmdq.cons = data;
+        bank->cmdq.cons = data;
         break;
     case A_EVENTQ_BASE: /* 64b */
-        s->eventq.base = deposit64(s->eventq.base, 0, 32, data);
-        s->eventq.log2size = extract64(s->eventq.base, 0, 5);
-        if (s->eventq.log2size > SMMU_EVENTQS) {
-            s->eventq.log2size = SMMU_EVENTQS;
+        bank->eventq.base = deposit64(bank->eventq.base, 0, 32, data);
+        bank->eventq.log2size = extract64(bank->eventq.base, 0, 5);
+        if (bank->eventq.log2size > SMMU_EVENTQS) {
+            bank->eventq.log2size = SMMU_EVENTQS;
         }
         break;
     case A_EVENTQ_BASE + 4:
-        s->eventq.base = deposit64(s->eventq.base, 32, 32, data);
+        bank->eventq.base = deposit64(bank->eventq.base, 32, 32, data);
         break;
     case A_EVENTQ_PROD:
-        s->eventq.prod = data;
+        bank->eventq.prod = data;
         break;
     case A_EVENTQ_CONS:
-        s->eventq.cons = data;
+        bank->eventq.cons = data;
         break;
     case A_EVENTQ_IRQ_CFG0: /* 64b */
-        s->eventq_irq_cfg0 = deposit64(s->eventq_irq_cfg0, 0, 32, data);
+        bank->eventq_irq_cfg0 = deposit64(bank->eventq_irq_cfg0, 0, 32, data);
         break;
     case A_EVENTQ_IRQ_CFG0 + 4:
-        s->eventq_irq_cfg0 = deposit64(s->eventq_irq_cfg0, 32, 32, data);
+        bank->eventq_irq_cfg0 = deposit64(bank->eventq_irq_cfg0, 32, 32, data);
         break;
     case A_EVENTQ_IRQ_CFG1:
-        s->eventq_irq_cfg1 = data;
+        bank->eventq_irq_cfg1 = data;
         break;
     case A_EVENTQ_IRQ_CFG2:
-        s->eventq_irq_cfg2 = data;
+        bank->eventq_irq_cfg2 = data;
         break;
     default:
         qemu_log_mask(LOG_UNIMP,
@@ -1798,18 +1833,21 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
 static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
                                uint64_t *data, MemTxAttrs attrs)
 {
+    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+
     switch (offset) {
     case A_GERROR_IRQ_CFG0:
-        *data = s->gerror_irq_cfg0;
+        *data = bank->gerror_irq_cfg0;
         return MEMTX_OK;
     case A_STRTAB_BASE:
-        *data = s->strtab_base;
+        *data = bank->strtab_base;
         return MEMTX_OK;
     case A_CMDQ_BASE:
-        *data = s->cmdq.base;
+        *data = bank->cmdq.base;
         return MEMTX_OK;
     case A_EVENTQ_BASE:
-        *data = s->eventq.base;
+        *data = bank->eventq.base;
         return MEMTX_OK;
     default:
         *data = 0;
@@ -1823,12 +1861,15 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
 static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
                               uint64_t *data, MemTxAttrs attrs)
 {
+    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+
     switch (offset) {
     case A_IDREGS ... A_IDREGS + 0x2f:
         *data = smmuv3_idreg(offset - A_IDREGS);
         return MEMTX_OK;
     case A_IDR0 ... A_IDR5:
-        *data = s->idr[(offset - A_IDR0) / 4];
+        *data = bank->idr[(offset - A_IDR0) / 4];
         return MEMTX_OK;
     case A_IIDR:
         *data = s->iidr;
@@ -1837,77 +1878,77 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
         *data = s->aidr;
         return MEMTX_OK;
     case A_CR0:
-        *data = s->cr[0];
+        *data = bank->cr[0];
         return MEMTX_OK;
     case A_CR0ACK:
-        *data = s->cr0ack;
+        *data = bank->cr0ack;
         return MEMTX_OK;
     case A_CR1:
-        *data = s->cr[1];
+        *data = bank->cr[1];
         return MEMTX_OK;
     case A_CR2:
-        *data = s->cr[2];
+        *data = bank->cr[2];
         return MEMTX_OK;
     case A_STATUSR:
         *data = s->statusr;
         return MEMTX_OK;
     case A_GBPA:
-        *data = s->gbpa;
+        *data = bank->gbpa;
         return MEMTX_OK;
     case A_IRQ_CTRL:
     case A_IRQ_CTRL_ACK:
-        *data = s->irq_ctrl;
+        *data = bank->irq_ctrl;
         return MEMTX_OK;
     case A_GERROR:
-        *data = s->gerror;
+        *data = bank->gerror;
         return MEMTX_OK;
     case A_GERRORN:
-        *data = s->gerrorn;
+        *data = bank->gerrorn;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0: /* 64b */
-        *data = extract64(s->gerror_irq_cfg0, 0, 32);
+        *data = extract64(bank->gerror_irq_cfg0, 0, 32);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0 + 4:
-        *data = extract64(s->gerror_irq_cfg0, 32, 32);
+        *data = extract64(bank->gerror_irq_cfg0, 32, 32);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG1:
-        *data = s->gerror_irq_cfg1;
+        *data = bank->gerror_irq_cfg1;
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG2:
-        *data = s->gerror_irq_cfg2;
+        *data = bank->gerror_irq_cfg2;
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
-        *data = extract64(s->strtab_base, 0, 32);
+        *data = extract64(bank->strtab_base, 0, 32);
         return MEMTX_OK;
     case A_STRTAB_BASE + 4: /* 64b */
-        *data = extract64(s->strtab_base, 32, 32);
+        *data = extract64(bank->strtab_base, 32, 32);
         return MEMTX_OK;
     case A_STRTAB_BASE_CFG:
-        *data = s->strtab_base_cfg;
+        *data = bank->strtab_base_cfg;
         return MEMTX_OK;
     case A_CMDQ_BASE: /* 64b */
-        *data = extract64(s->cmdq.base, 0, 32);
+        *data = extract64(bank->cmdq.base, 0, 32);
         return MEMTX_OK;
     case A_CMDQ_BASE + 4:
-        *data = extract64(s->cmdq.base, 32, 32);
+        *data = extract64(bank->cmdq.base, 32, 32);
         return MEMTX_OK;
     case A_CMDQ_PROD:
-        *data = s->cmdq.prod;
+        *data = bank->cmdq.prod;
         return MEMTX_OK;
     case A_CMDQ_CONS:
-        *data = s->cmdq.cons;
+        *data = bank->cmdq.cons;
         return MEMTX_OK;
     case A_EVENTQ_BASE: /* 64b */
-        *data = extract64(s->eventq.base, 0, 32);
+        *data = extract64(bank->eventq.base, 0, 32);
         return MEMTX_OK;
     case A_EVENTQ_BASE + 4: /* 64b */
-        *data = extract64(s->eventq.base, 32, 32);
+        *data = extract64(bank->eventq.base, 32, 32);
         return MEMTX_OK;
     case A_EVENTQ_PROD:
-        *data = s->eventq.prod;
+        *data = bank->eventq.prod;
         return MEMTX_OK;
     case A_EVENTQ_CONS:
-        *data = s->eventq.cons;
+        *data = bank->eventq.cons;
         return MEMTX_OK;
     default:
         *data = 0;
@@ -2089,9 +2130,10 @@ static const VMStateDescription vmstate_smmuv3_queue = {
 static bool smmuv3_gbpa_needed(void *opaque)
 {
     SMMUv3State *s = opaque;
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
 
     /* Only migrate GBPA if it has different reset value. */
-    return s->gbpa != SMMU_GBPA_RESET_VAL;
+    return bank->gbpa != SMMU_GBPA_RESET_VAL;
 }
 
 static const VMStateDescription vmstate_gbpa = {
@@ -2100,7 +2142,7 @@ static const VMStateDescription vmstate_gbpa = {
     .minimum_version_id = 1,
     .needed = smmuv3_gbpa_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(gbpa, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].gbpa, SMMUv3State),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -2111,27 +2153,29 @@ static const VMStateDescription vmstate_smmuv3 = {
     .minimum_version_id = 1,
     .priority = MIG_PRI_IOMMU,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(features, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].features, SMMUv3State),
         VMSTATE_UINT8(sid_size, SMMUv3State),
-        VMSTATE_UINT8(sid_split, SMMUv3State),
+        VMSTATE_UINT8(bank[SMMU_SEC_SID_NS].sid_split, SMMUv3State),
 
-        VMSTATE_UINT32_ARRAY(cr, SMMUv3State, 3),
-        VMSTATE_UINT32(cr0ack, SMMUv3State),
+        VMSTATE_UINT32_ARRAY(bank[SMMU_SEC_SID_NS].cr, SMMUv3State, 3),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].cr0ack, SMMUv3State),
         VMSTATE_UINT32(statusr, SMMUv3State),
-        VMSTATE_UINT32(irq_ctrl, SMMUv3State),
-        VMSTATE_UINT32(gerror, SMMUv3State),
-        VMSTATE_UINT32(gerrorn, SMMUv3State),
-        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3State),
-        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3State),
-        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3State),
-        VMSTATE_UINT64(strtab_base, SMMUv3State),
-        VMSTATE_UINT32(strtab_base_cfg, SMMUv3State),
-        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3State),
-        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3State),
-        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3State),
-
-        VMSTATE_STRUCT(cmdq, SMMUv3State, 0, vmstate_smmuv3_queue, SMMUQueue),
-        VMSTATE_STRUCT(eventq, SMMUv3State, 0, vmstate_smmuv3_queue, SMMUQueue),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].irq_ctrl, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].gerror, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].gerrorn, SMMUv3State),
+        VMSTATE_UINT64(bank[SMMU_SEC_SID_NS].gerror_irq_cfg0, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].gerror_irq_cfg1, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].gerror_irq_cfg2, SMMUv3State),
+        VMSTATE_UINT64(bank[SMMU_SEC_SID_NS].strtab_base, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].strtab_base_cfg, SMMUv3State),
+        VMSTATE_UINT64(bank[SMMU_SEC_SID_NS].eventq_irq_cfg0, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].eventq_irq_cfg1, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].eventq_irq_cfg2, SMMUv3State),
+
+        VMSTATE_STRUCT(bank[SMMU_SEC_SID_NS].cmdq, SMMUv3State, 0,
+                       vmstate_smmuv3_queue, SMMUQueue),
+        VMSTATE_STRUCT(bank[SMMU_SEC_SID_NS].eventq, SMMUv3State, 0,
+                       vmstate_smmuv3_queue, SMMUQueue),
 
         VMSTATE_END_OF_LIST(),
     },
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 273633e6293..c7c63f27bb1 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -974,6 +974,7 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
     int i;
     long pgsize;
     uint32_t val;
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
 
     cmdqv->config = V_CONFIG_RESET;
     cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
@@ -1019,8 +1020,9 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
     if (pgsize == LONG_MAX) {
         pgsize = qemu_real_host_page_size();
     }
-    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(ctz64(pgsize) - 4, val));
+    val = FIELD_EX32(bank->idr[1], IDR1, CMDQS);
+    bank->idr[1] = FIELD_DP32(bank->idr[1], IDR1, CMDQS,
+                              MIN(ctz64(pgsize) - 4, val));
 }
 
 static void tegra241_cmdqv_reset(SMMUv3State *s)
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 7b975abc25a..6ea40f6b074 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -40,6 +40,12 @@
 #define CACHED_ENTRY_TO_ADDR(ent, addr)      ((ent)->entry.translated_addr + \
                                              ((addr) & (ent)->entry.addr_mask))
 
+/* StreamID Security state */
+typedef enum SMMUSecSID {
+    SMMU_SEC_SID_NS = 0,
+    SMMU_SEC_SID_NUM,
+} SMMUSecSID;
+
 /*
  * Page table walk error types
  */
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d39fe8850bc..45033d26a1b 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -34,19 +34,13 @@ typedef struct SMMUQueue {
      uint8_t log2size;
 } SMMUQueue;
 
-struct SMMUv3State {
-    SMMUState     smmu_state;
-
+typedef struct SMMUv3RegBank {
     uint32_t features;
-    uint8_t sid_size;
     uint8_t sid_split;
 
     uint32_t idr[6];
-    uint32_t iidr;
-    uint32_t aidr;
     uint32_t cr[3];
     uint32_t cr0ack;
-    uint32_t statusr;
     uint32_t gbpa;
     uint32_t irq_ctrl;
     uint32_t gerror;
@@ -61,6 +55,17 @@ struct SMMUv3State {
     uint32_t eventq_irq_cfg2;
 
     SMMUQueue eventq, cmdq;
+} SMMUv3RegBank;
+
+struct SMMUv3State {
+    SMMUState     smmu_state;
+
+    uint8_t sid_size;
+    uint32_t iidr;
+    uint32_t aidr;
+    uint32_t statusr;
+
+    SMMUv3RegBank bank[SMMU_SEC_SID_NUM];
 
     qemu_irq     irq[4];
     QemuMutex mutex;
@@ -103,7 +108,14 @@ bool smmuv3_ats_enabled(struct SMMUv3State *s);
 #define TYPE_ARM_SMMUV3   "arm-smmuv3"
 OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 
-#define STAGE1_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S1P)
-#define STAGE2_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S2P)
+#define STAGE1_SUPPORTED(s) \
+    FIELD_EX32((s)->bank[SMMU_SEC_SID_NS].idr[0], IDR0, S1P)
+#define STAGE2_SUPPORTED(s) \
+    FIELD_EX32((s)->bank[SMMU_SEC_SID_NS].idr[0], IDR0, S2P)
+
+static inline SMMUv3RegBank *smmuv3_bank(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return &s->bank[sec_sid];
+}
 
 #endif
-- 
2.34.1


