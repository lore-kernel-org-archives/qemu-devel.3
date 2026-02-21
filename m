Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2B5C61DCB
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtjpt-0005pH-OU; Sat, 21 Feb 2026 05:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtjpf-0005mE-CL; Sat, 21 Feb 2026 05:03:28 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtjpZ-00056m-KB; Sat, 21 Feb 2026 05:03:27 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCnr5vjgplpc6BVBw--.3730S2;
 Sat, 21 Feb 2026 18:03:15 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3TevcgplpBk4cAA--.34138S7;
 Sat, 21 Feb 2026 18:03:13 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v4 04/31] hw/arm/smmuv3: Introduce banked registers for SMMUv3
 state
Date: Sat, 21 Feb 2026 18:02:23 +0800
Message-Id: <20260221100250.2976287-5-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3TevcgplpBk4cAA--.34138S7
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUAHgAAsM
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZw1xJr4kWF43CF1kXw1DKFg_yoWrJFy5Go
 W2yF4qqw4DZw4kCa48uFn5JF18tFW8Cw4qqa1YvrWa9FsFgw45Kryxtrs8CF9IkF45XrWk
 Cw4xu3yrXFWIvFn5n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
---
 hw/arm/smmuv3-accel.c        |  42 +++--
 hw/arm/smmuv3-internal.h     |  24 ++-
 hw/arm/smmuv3.c              | 345 +++++++++++++++++++----------------
 include/hw/arm/smmu-common.h |   6 +
 include/hw/arm/smmuv3.h      |  30 ++-
 5 files changed, 257 insertions(+), 190 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f5cd4df336a..30d4b38c0a3 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -40,19 +40,20 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
                                  Error **errp)
 {
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
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
@@ -60,7 +61,7 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
 
     /* QEMU SMMUv3 supports only AArch64 translation table format */
     if (FIELD_EX32(info->idr[0], IDR0, TTF) <
-                FIELD_EX32(s->idr[0], IDR0, TTF)) {
+                FIELD_EX32(bank->idr[0], IDR0, TTF)) {
         error_setg(errp, "Host SMMUv3 doesn't support AArch64 translation "
                    "table format");
         return false;
@@ -68,53 +69,53 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
 
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
@@ -168,7 +169,8 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
 
 static uint32_t smmuv3_accel_gbpa_hwpt(SMMUv3State *s, SMMUv3AccelState *accel)
 {
-    return FIELD_EX32(s->gbpa, GBPA, ABORT) ?
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+    return FIELD_EX32(bank->gbpa, GBPA, ABORT) ?
            accel->abort_hwpt_id : accel->bypass_hwpt_id;
 }
 
@@ -687,22 +689,24 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
         return;
     }
 
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+
     /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+    bank->idr[3] = FIELD_DP32(bank->idr[3], IDR3, RIL, s->ril);
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+    bank->idr[0] = FIELD_DP32(bank->idr[0], IDR0, ATS, s->ats);
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
     if (s->oas == SMMU_OAS_48BIT) {
-        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
+        bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
 
     /*
      * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
      * has enabled it.
      */
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
+    bank->idr[1] = FIELD_DP32(bank->idr[1], IDR1, SSIDSIZE, s->ssidsize);
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index ebdb4ebae67..deb1ef60e87 100644
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
index c08d58c5790..5511585601d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -52,6 +52,8 @@
 static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
                                uint32_t gerror_mask)
 {
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
 
     bool pulse = false;
 
@@ -67,15 +69,15 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
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
@@ -89,8 +91,10 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
 
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
@@ -102,9 +106,9 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
      * We do not raise any error in case guest toggles bits corresponding
      * to not active IRQs (CONSTRAINED UNPREDICTABLE)
      */
-    s->gerrorn = new_gerrorn;
+    bank->gerrorn = new_gerrorn;
 
-    trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
+    trace_smmuv3_write_gerrorn(toggled & pending, bank->gerrorn);
 }
 
 static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
@@ -146,7 +150,9 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
 
 static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
 {
-    SMMUQueue *q = &s->eventq;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    SMMUQueue *q = &bank->eventq;
     MemTxResult r;
 
     if (!smmuv3_eventq_enabled(s)) {
@@ -266,69 +272,75 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
  */
 static void smmuv3_init_id_regs(SMMUv3State *s)
 {
+    SMMUv3RegBank *bk = smmuv3_bank(s, SMMU_SEC_SID_NS);
+
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
+        bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, S2P, 1);
     } else if (s->stage && !strcmp("nested", s->stage)) {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
+        bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, S1P, 1);
+        bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, S2P, 1);
     } else {
-        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
+        bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, S1P, 1);
     }
 
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TTF, 2); /* AArch64 PTW only */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, COHACC, 1); /* IO coherent */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ASID16, 1); /* 16-bit ASID */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, VMID16, 1); /* 16-bit VMID */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TTENDIAN, 2); /* little endian */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STALL_MODEL, 1); /* No stall */
+    bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, TTF, 2); /* AArch64 PTW only */
+    bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, COHACC, 1); /* IO coherent */
+    bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, ASID16, 1); /* 16-bit ASID */
+    bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, VMID16, 1); /* 16-bit VMID */
+    bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, TTENDIAN, 2); /* little endian */
+    bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, STALL_MODEL, 1); /* No stall */
     /* terminated transaction will always be aborted/error returned */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TERM_MODEL, 1);
+    bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, TERM_MODEL, 1);
     /* 2-level stream table supported */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, 1);
+    bk->idr[0] = FIELD_DP32(bk->idr[0], IDR0, STLEVEL, 1);
 
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
+    bk->idr[1] = FIELD_DP32(bk->idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
+    bk->idr[1] = FIELD_DP32(bk->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
+    bk->idr[1] = FIELD_DP32(bk->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
 
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
-    if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
+    bk->idr[3] = FIELD_DP32(bk->idr[3], IDR3, HAD, 1);
+    if (FIELD_EX32(bk->idr[0], IDR0, S2P)) {
         /* XNX is a stage-2-specific feature */
-        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
+        bk->idr[3] = FIELD_DP32(bk->idr[3], IDR3, XNX, 1);
     }
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
+    bk->idr[3] = FIELD_DP32(bk->idr[3], IDR3, RIL, 1);
+    bk->idr[3] = FIELD_DP32(bk->idr[3], IDR3, BBML, 2);
 
     /* OAS: 44 bits */
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
+    bk->idr[5] = FIELD_DP32(bk->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
     /* 4K, 16K and 64K granule support */
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
+    bk->idr[5] = FIELD_DP32(bk->idr[5], IDR5, GRAN4K, 1);
+    bk->idr[5] = FIELD_DP32(bk->idr[5], IDR5, GRAN16K, 1);
+    bk->idr[5] = FIELD_DP32(bk->idr[5], IDR5, GRAN64K, 1);
     s->aidr = 0x1;
     smmuv3_accel_idr_override(s);
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
+    SMMUv3RegBank *bk = smmuv3_bank(s, SMMU_SEC_SID_NS);
+
+    bk->cmdq.base = deposit64(bk->cmdq.base, 0, 5, SMMU_CMDQS);
+    bk->cmdq.prod = 0;
+    bk->cmdq.cons = 0;
+    bk->cmdq.entry_size = sizeof(struct Cmd);
+    bk->eventq.base = deposit64(bk->eventq.base, 0, 5, SMMU_EVENTQS);
+    bk->eventq.prod = 0;
+    bk->eventq.cons = 0;
+    bk->eventq.entry_size = sizeof(struct Evt);
+
+    bk->features = 0;
+    bk->sid_split = 0;
+    bk->cr[0] = 0;
+    bk->cr0ack = 0;
+    bk->irq_ctrl = 0;
+    bk->gerror = 0;
+    bk->gerrorn = 0;
+    bk->gbpa = SMMU_GBPA_RESET_VAL;
+
+    s->aidr = 0x1;
     s->statusr = 0;
-    s->gbpa = SMMU_GBPA_RESET_VAL;
 }
 
 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
@@ -442,7 +454,7 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
 static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
                              STE *ste)
 {
-    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
+    uint8_t oas = FIELD_EX32(smmuv3_bank(s, SMMU_SEC_SID_NS)->idr[5], IDR5, OAS);
 
     if (STE_S2AA64(ste) == 0x0) {
         qemu_log_mask(LOG_UNIMP,
@@ -560,7 +572,8 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
                       STE *ste, SMMUEventInfo *event)
 {
     uint32_t config;
-    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
+    /* OAS field only presents on NS-IDR5 so we use hardcoded SMMU_SEC_SID_NS */
+    uint8_t oas = FIELD_EX32(smmuv3_bank(s, SMMU_SEC_SID_NS)->idr[5], IDR5, OAS);
     int ret;
 
     if (!STE_VALID(ste)) {
@@ -649,9 +662,11 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
     uint32_t log2size;
     int strtab_size_shift;
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
@@ -659,7 +674,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
         event->type = SMMU_EVT_C_BAD_STREAMID;
         return -EINVAL;
     }
-    if (s->features & SMMU_FEATURE_2LVL_STE) {
+    if (bank->features & SMMU_FEATURE_2LVL_STE) {
         int l1_ste_offset, l2_ste_offset, max_l2_ste, span, i;
         dma_addr_t l1ptr, l2ptr;
         STEDesc l1std;
@@ -668,11 +683,11 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
          * Align strtab base address to table size. For this purpose, assume it
          * is not bounded by SMMU_IDR1_SIDSIZE.
          */
-        strtab_size_shift = MAX(5, (int)log2size - s->sid_split - 1 + 3);
-        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+        strtab_size_shift = MAX(5, (int)log2size - bank->sid_split - 1 + 3);
+        strtab_base = bank->strtab_base & SMMU_BASE_ADDR_MASK &
                       ~MAKE_64BIT_MASK(0, strtab_size_shift);
-        l1_ste_offset = sid >> s->sid_split;
-        l2_ste_offset = sid & ((1 << s->sid_split) - 1);
+        l1_ste_offset = sid >> bank->sid_split;
+        l2_ste_offset = sid & ((1 << bank->sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
         /* TODO: guarantee 64-bit single-copy atomicity */
         ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
@@ -701,7 +716,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
         }
         max_l2_ste = (1 << span) - 1;
         l2ptr = l1std_l2ptr(&l1std);
-        trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
+        trace_smmuv3_find_ste_2lvl(bank->strtab_base, l1ptr, l1_ste_offset,
                                    l2ptr, l2_ste_offset, max_l2_ste);
         if (l2_ste_offset > max_l2_ste) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -713,7 +728,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
         addr = l2ptr + l2_ste_offset * sizeof(*ste);
     } else {
         strtab_size_shift = log2size + 5;
-        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+        strtab_base = bank->strtab_base & SMMU_BASE_ADDR_MASK &
                       ~MAKE_64BIT_MASK(0, strtab_size_shift);
         addr = strtab_base + sid * sizeof(*ste);
     }
@@ -732,7 +747,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
     int i;
     SMMUTranslationStatus status;
     SMMUTLBEntry *entry;
-    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
+    uint8_t oas = FIELD_EX32(smmuv3_bank(s, SMMU_SEC_SID_NS)->idr[5], IDR5, OAS);
 
     if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
         goto bad_cd;
@@ -1054,6 +1069,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUv3State *s = sdev->smmu;
     uint32_t sid = smmu_get_sid(sdev);
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUEventInfo event = {.type = SMMU_EVT_NONE,
                            .sid = sid,
                            .inval_ste_allowed = false};
@@ -1071,7 +1088,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     qemu_mutex_lock(&s->mutex);
 
     if (!smmu_enabled(s)) {
-        if (FIELD_EX32(s->gbpa, GBPA, ABORT)) {
+        if (FIELD_EX32(bank->gbpa, GBPA, ABORT)) {
             status = SMMU_TRANS_ABORT;
         } else {
             status = SMMU_TRANS_DISABLE;
@@ -1295,7 +1312,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
-    SMMUQueue *q = &s->cmdq;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    SMMUQueue *q = &bank->cmdq;
     SMMUCommandType type = 0;
 
     if (!smmuv3_cmdq_enabled(s)) {
@@ -1309,7 +1328,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
      */
 
     while (!smmuv3_q_empty(q)) {
-        uint32_t pending = s->gerror ^ s->gerrorn;
+        uint32_t pending = bank->gerror ^ bank->gerrorn;
         Cmd cmd;
 
         trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
@@ -1562,29 +1581,32 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
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
@@ -1598,22 +1620,24 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
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
@@ -1624,16 +1648,16 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
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
@@ -1642,67 +1666,67 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
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
-            s->features |= SMMU_FEATURE_2LVL_STE;
+            bank->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
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
@@ -1746,18 +1770,21 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
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
@@ -1771,12 +1798,15 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
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
@@ -1785,77 +1815,77 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
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
@@ -2039,9 +2069,10 @@ static const VMStateDescription vmstate_smmuv3_queue = {
 static bool smmuv3_gbpa_needed(void *opaque)
 {
     SMMUv3State *s = opaque;
+    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
 
     /* Only migrate GBPA if it has different reset value. */
-    return s->gbpa != SMMU_GBPA_RESET_VAL;
+    return bank->gbpa != SMMU_GBPA_RESET_VAL;
 }
 
 static const VMStateDescription vmstate_gbpa = {
@@ -2050,7 +2081,7 @@ static const VMStateDescription vmstate_gbpa = {
     .minimum_version_id = 1,
     .needed = smmuv3_gbpa_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(gbpa, SMMUv3State),
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].gbpa, SMMUv3State),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -2061,27 +2092,29 @@ static const VMStateDescription vmstate_smmuv3 = {
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
index 26b2fc42fd9..d07bdfa1f27 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -32,19 +32,13 @@ typedef struct SMMUQueue {
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
@@ -59,6 +53,17 @@ struct SMMUv3State {
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
@@ -94,7 +99,14 @@ struct SMMUv3Class {
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


