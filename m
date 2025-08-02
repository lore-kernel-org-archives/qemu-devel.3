Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF17C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjc-0004tr-6P; Sat, 02 Aug 2025 19:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhR-0007qB-Uz
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:38 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhQ-00054A-09
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:37 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-741a6272c8fso140795a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177495; x=1754782295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1C+mCkPpaYdwsiDevSN1ysjcA0iJlDfVBhccuXEqSc=;
 b=i/9/rsmvQ7t91TIBaU+GWB4wmdpnO+iD7cypIEbAYPIWg0oh20cOO1P8kblP8/+48v
 CwD2VvQzkOJMljOv4Stw/pEOjvxFVonl/Sr6jccHGoz5iGsL8iNVfIiPE3ii3eiRbuYo
 xGLPePdXOjFOyxAOEtjFGeF6189KyB0qFrajZ/ui35uIYq1kHAekGbGyAOwmIVgIIFkV
 JiPXJPojF2u1RIqr/x16f1DW3nNEN4lN3NEsO+rChUiEe9tBOnUFW0iFRfNS2UOIfXvK
 mF4ZrJuxqXObSqRmKZZ/3eJthTG7Wq3deZaZPfxtVB5F0z45qbn8YjqLvs3f2t9sPgyo
 qlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177495; x=1754782295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1C+mCkPpaYdwsiDevSN1ysjcA0iJlDfVBhccuXEqSc=;
 b=HV95uzslNlQlW71JDavkL3rpiLhPgzQHP8lLPTD1+bS//0rGA9Lb5SXor/vd9ZBySb
 6Kivr9GI/yQkQ1R0o2YOHZsVbS+H8TBVzQvPxCLQI/42Wnno8VbS4jvWZe+jgoOgUPyU
 uAD/hjYlyBgFI7pgC2WomyrwgEwpdVqa5NaIEDQ7R9Rr0OKQeumRMyJShoWcJBbPD2eU
 dzpzch43YqXndpkFErEpdlZakaPSlKzFQroN5xMHCsD22lEANgbvDOULCFtGBzPlHEMP
 iUL/qdyB6SScWFJSQn3p+zyrno6u5a3Wc0xmbMMZGJxAlcDkHb5JcpNqLXPNd9KiZFmi
 McMA==
X-Gm-Message-State: AOJu0YwnpCMRyfzJSsIMwIPudOw/XBX/pvw773i7Q7ZMXSMSuZ2q1x7x
 V/Mr0thir4P/JTXcomWWaCQ/xMWTCnRSnO8nT4Pm1xQBN0wPlFcd4oGl+u0GUmevTxLDLnf/SPo
 ya0tjlsI=
X-Gm-Gg: ASbGncsYb4a23LLO38vKJqNoP5vsibsVjMUzFOJYfY2p9iN3ZqhkHpze/fO6MyISAzJ
 DY8xWa13eBVbAxwKjrKbuW/p/Dg0jtCmhM9jXbkkAKr1c3jemfMVYbzjloBiDuSl6vmx57txP39
 o7hQq9Wyaxsj4qYaU2Ntvi9sGouiJcnjl14xYpWmeAUiw8L420vKD7USpooyBQwMM9MW3FT1Z9g
 6U6eN5gMy1rCg+02DSqecz2cL+/+sWUUGli5vxK+71r88vIAKkq9hqsExcwxRfAeEPPKKa2m8AB
 lIw6wTiTESOjwSq3RMtJoj2KaCnorWVEo/C7h4OS2jkZqvZoFvKKBQ4u0ZuoTbNCEhaSBleq0tR
 p669V3jF/a7n+RtS/1B8dOfoKt3Njs0vYyUN1SrPpcwkon7tyIhR38r7covhT5xg=
X-Google-Smtp-Source: AGHT+IFOexHCVNovhRM3PazxdiDSodfErg16PWP3QAwfEy+p2sRWGSmDuSDEja6a+7vTUzd4Ynwp3g==
X-Received: by 2002:a05:6870:80c6:b0:2e8:eccb:fe1c with SMTP id
 586e51a60fabf-30b678c0905mr2797919fac.31.1754177494767; 
 Sat, 02 Aug 2025 16:31:34 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:31:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 19/85] target/arm: Implement get_S1prot_indirect
Date: Sun,  3 Aug 2025 09:28:47 +1000
Message-ID: <20250802232953.413294-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This approximately corresponds to AArch64.S1IndirectBasePermissions
and the tail of AArch64.S1ComputePermissions which applies WXN.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 169 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 143 insertions(+), 26 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a5a3c03a4c..7fd1cee98a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1449,6 +1449,106 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     return prot_rw | PAGE_EXEC;
 }
 
+/* Extra page permission bits, during get_S1prot_indirect only. */
+#define PAGE_GCS      (1 << 3)
+#define PAGE_WXN      (1 << 4)
+#define PAGE_OVERLAY  (1 << 5)
+QEMU_BUILD_BUG_ON(PAGE_RWX & (PAGE_GCS | PAGE_WXN | PAGE_OVERLAY));
+
+static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
+                               ARMMMUIdx mmu_idx, int pi_index, int po_index,
+                               ARMSecuritySpace in_pa, ARMSecuritySpace out_pa)
+{
+    static const uint8_t perm_table[16] = {
+        /* 0 */ PAGE_OVERLAY,  /* no access */
+        /* 1 */ PAGE_OVERLAY | PAGE_READ,
+        /* 2 */ PAGE_OVERLAY | PAGE_EXEC,
+        /* 3 */ PAGE_OVERLAY | PAGE_READ | PAGE_EXEC,
+        /* 4 */ PAGE_OVERLAY,  /* reserved */
+        /* 5 */ PAGE_OVERLAY | PAGE_READ | PAGE_WRITE,
+        /* 6 */ PAGE_OVERLAY | PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_WXN,
+        /* 7 */ PAGE_OVERLAY | PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+        /* 8 */ PAGE_READ,
+        /* 9 */ PAGE_READ | PAGE_GCS,
+        /* A */ PAGE_READ | PAGE_EXEC,
+        /* B */ 0,             /* reserved */
+        /* C */ PAGE_READ | PAGE_WRITE,
+        /* D */ 0,             /* reserved */
+        /* E */ PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+        /* F */ 0,             /* reserved */
+    };
+
+    uint32_t el = regime_el(env, mmu_idx);
+    uint64_t pir = env->cp15.pir_el[el];
+    uint64_t pire0 = 0;
+    int perm;
+
+    if (el < 3) {
+        if (arm_feature(env, ARM_FEATURE_EL3)
+            && !(env->cp15.scr_el3 & SCR_PIEN)) {
+            pir = 0;
+        } else if (el == 2) {
+            pire0 = env->cp15.pire0_el2;
+        } else if (!ptw->in_nv1) {
+            pire0 = env->cp15.pir_el[0];
+        }
+    }
+    perm = perm_table[extract64(pir, pi_index * 4, 4)];
+
+    if (regime_has_2_ranges(mmu_idx)) {
+        int p_perm = perm;
+        int u_perm = perm_table[extract64(pire0, pi_index * 4, 4)];
+
+        if ((p_perm & (PAGE_EXEC | PAGE_GCS)) &&
+            (u_perm & (PAGE_WRITE | PAGE_GCS))) {
+            p_perm &= ~(PAGE_RWX | PAGE_GCS);
+            u_perm &= ~(PAGE_RWX | PAGE_GCS);
+        }
+        if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(env, mmu_idx)) {
+            p_perm &= ~(PAGE_READ | PAGE_WRITE);
+        }
+        perm = regime_is_user(env, mmu_idx) ? u_perm : p_perm;
+    }
+
+    if (in_pa != out_pa) {
+        switch (in_pa) {
+        case ARMSS_Root:
+            /*
+             * R_ZWRVD: permission fault for insn fetched from non-Root,
+             * I_WWBFB: SIF has no effect in EL3.
+             */
+            perm &= ~(PAGE_EXEC | PAGE_GCS);
+            break;
+        case ARMSS_Realm:
+            /*
+             * R_PKTDS: permission fault for insn fetched from non-Realm,
+             * for Realm EL2 or EL2&0.  The corresponding fault for EL1&0
+             * happens during any stage2 translation.
+             */
+            if (el == 2) {
+                perm &= ~(PAGE_EXEC | PAGE_GCS);
+            }
+            break;
+        case ARMSS_Secure:
+            if (env->cp15.scr_el3 & SCR_SIF) {
+                perm &= ~(PAGE_EXEC | PAGE_GCS);
+            }
+            break;
+        default:
+            /* Input NonSecure must have output NonSecure. */
+            g_assert_not_reached();
+        }
+    }
+
+    if (perm & PAGE_WXN) {
+        perm &= ~PAGE_EXEC;
+    }
+
+    /* TODO: FEAT_GCS */
+
+    return perm & PAGE_RWX;
+}
+
 static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
                                           ARMMMUIdx mmu_idx)
 {
@@ -1678,7 +1778,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     int32_t stride;
     int addrsize, inputsize, outputsize;
     uint64_t tcr = regime_tcr(env, mmu_idx);
-    int ap, xn, pxn;
+    int ap;
     uint32_t el = regime_el(env, mmu_idx);
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
@@ -2006,7 +2106,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
             out_space = ARMSS_NonSecure;
             result->f.prot = get_S2prot_noexecute(ap);
         } else {
-            xn = extract64(attrs, 53, 2);
+            int xn = extract64(attrs, 53, 2);
             result->f.prot = get_S2prot(env, ap, xn, ptw->in_s1_is_el0);
         }
 
@@ -2022,7 +2122,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         int nse, ns = extract32(attrs, 5, 1);
         uint8_t attrindx;
         uint64_t mair;
-        int user_rw, prot_rw;
 
         switch (out_space) {
         case ARMSS_Root:
@@ -2071,33 +2170,51 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         default:
             g_assert_not_reached();
         }
-        xn = extract64(attrs, 54, 1);
-        pxn = extract64(attrs, 53, 1);
 
-        if (el == 1 && ptw->in_nv1) {
+        if (param.pie) {
+            int pi = extract64(attrs, 6, 1)
+                   | (extract64(attrs, 51, 1) << 1)
+                   | (extract64(attrs, 53, 2) << 2);
+            int po = extract64(attrs, 60, 3);
             /*
-             * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1}, the block/page
-             * descriptor bit 54 holds PXN, 53 is RES0, and the effective value
-             * of UXN is 0. Similarly for bits 59 and 60 in table descriptors
-             * (which we have already folded into bits 53 and 54 of attrs).
-             * AP[1] (descriptor bit 6, our ap bit 0) is treated as 0.
-             * Similarly, APTable[0] from the table descriptor is treated as 0;
-             * we already folded this into AP[1] and squashing that to 0 does
-             * the right thing.
+             * Note that we modified ptw->in_space earlier for NSTable, but
+             * result->f.attrs retains a copy of the original security space.
              */
-            pxn = xn;
-            xn = 0;
-            ap &= ~1;
-        }
+            result->f.prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
+                                                 result->f.attrs.space,
+                                                 out_space);
+        } else {
+            int xn = extract64(attrs, 54, 1);
+            int pxn = extract64(attrs, 53, 1);
+            int user_rw, prot_rw;
 
-        user_rw = simple_ap_to_rw_prot_is_user(ap, true);
-        prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
-        /*
-         * Note that we modified ptw->in_space earlier for NSTable, but
-         * result->f.attrs retains a copy of the original security space.
-         */
-        result->f.prot = get_S1prot(env, mmu_idx, aarch64, user_rw, prot_rw,
-                                    xn, pxn, result->f.attrs.space, out_space);
+            if (el == 1 && ptw->in_nv1) {
+                /*
+                 * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1},
+                 * the block/page descriptor bit 54 holds PXN,
+                 * 53 is RES0, and the effective value of UXN is 0.
+                 * Similarly for bits 59 and 60 in table descriptors
+                 * (which we have already folded into bits 53 and 54 of attrs).
+                 * AP[1] (descriptor bit 6, our ap bit 0) is treated as 0.
+                 * Similarly, APTable[0] from the table descriptor is treated
+                 * as 0; we already folded this into AP[1] and squashing
+                 * that to 0 does the right thing.
+                 */
+                pxn = xn;
+                xn = 0;
+                ap &= ~1;
+            }
+
+            user_rw = simple_ap_to_rw_prot_is_user(ap, true);
+            prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
+            /*
+             * Note that we modified ptw->in_space earlier for NSTable, but
+             * result->f.attrs retains a copy of the original security space.
+             */
+            result->f.prot = get_S1prot(env, mmu_idx, aarch64,
+                                        user_rw, prot_rw, xn, pxn,
+                                        result->f.attrs.space, out_space);
+        }
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
-- 
2.43.0


