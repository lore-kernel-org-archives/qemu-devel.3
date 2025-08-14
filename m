Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35923CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXYV-0002CC-HT; Thu, 14 Aug 2025 08:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXY0-0001cm-LC
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:14 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXu-0004JJ-OT
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:10 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-323267b98a4so864577a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176343; x=1755781143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1C+mCkPpaYdwsiDevSN1ysjcA0iJlDfVBhccuXEqSc=;
 b=GBheAmHT9clc6V5DO2JEdTkv6pLvjtX8hQlct51VZC7TMJGU1CzD3AKGk4INBJzvzn
 bE/NQvAv7YvDziPFM9ra6Wcpvl04W/Fd1WiuLGe/RGDEpxNI0NvgEjxqghwZY4M9n3Ay
 PHAuVxdkMeuGIwDe2zLFwEnrvLGoHcXwQlbLf6QYlXSaMhaq+5lbpccbvuficQAGtm0Z
 jHSzXTFMAAvf0sUAase59j8yU+cVOD2zK7U4dlqd0zIxXLzJVkZ/3dnTi2iU4UkcJ6Fw
 z5Iec96Tujr+1c3IJ5SgNsQeeHnRhrb+Yq6fFFxZJtVv/yEUjBBFqspQG/f1GhiCodkH
 j3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176343; x=1755781143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1C+mCkPpaYdwsiDevSN1ysjcA0iJlDfVBhccuXEqSc=;
 b=VLSYTMnslluKHCB02mxBaGtkgWEEyy1BG8MnnMtKfHgOkkpGxsHQJA9TDSqB2Lgubj
 Y5ZvuOABaAMBvK1maxiX/fOkYbkMq7ntxyYCXcEh7/yd4bHvsYRwbEyUhnZkU0/61/dQ
 YtX0uDIM9fbxLEyuvOQP2WPBIcTgZVaf+wyVsXmksv5BhqYMBlcy91XhiI0NHPCvzc4q
 MlaZHT/RDLnMn0UW/IYM9x0u3JZUju5825uF6nujQakxL9p5KsM/mk5l8nqBsA/TFjjn
 sHzYcT+8/uM8fYBIcXeNW1fKvwp1MI+qoMjLlUCWvctIxRxMlHyTWYbJMaSqO/jxXLOn
 QNyw==
X-Gm-Message-State: AOJu0Yyi5+zzKUh4kvTzdXFjNeErhq3ok3TvjbXrGog8l2/wY/HCNPBu
 Oiid/J35AX54/E+TRkeacf2g8WNwh0AdNL4dFiUqzhzSFvkO/5EayrJ8i6X4sreDahG7eG3S+Kp
 fx7h8f+0=
X-Gm-Gg: ASbGncsxPgGqGnT2+DxNKn3sbKEsrd35EL6bN6ynUhXy1FdTpmUkILn9LF/bBB0dqwd
 0EtpmPJxMBqIGbTFqJj0XCxprWfRoI00BLBCJweUGuQzoaetlsP15xbg6Htxbr7jv4a76wHYnff
 nvRFlR6Bbqm1JZ8OHqa57LEGggLGLe0JvV+cTR0QI37EoJI2R/mwNGlEnGTb1/ZKbf91pCZ/LZf
 CeOOZGgCjoIwTqY5ef2w+AZJjuCOrZxbB0IWBT25f7QztdgnGNcXeU/FbPSh0X1CmQIidcMk4nu
 fgzIsw8c6NqjsTGCNY/pBm2v/eBeqJShq8DDHR+iLvWjT52TlR/nRx4i1ylIdj4YDGPNzGzucaG
 rZXYK4UbRN8EDb1oR7+c6g75b9pzbAkQT0CJitZIz1gDLlpMnSNwTzzibDQ==
X-Google-Smtp-Source: AGHT+IGXAFI7M7KM7N0ERBSSfYGA+hDuJTTvR3xanknyyUSfCc0Y8TqbStSP6ChtYnFujdxKt4itxg==
X-Received: by 2002:a17:90b:38ce:b0:31a:ab75:6e45 with SMTP id
 98e67ed59e1d1-32327ac0f4cmr4479086a91.28.1755176342433; 
 Thu, 14 Aug 2025 05:59:02 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 19/85] target/arm: Implement get_S1prot_indirect
Date: Thu, 14 Aug 2025 22:56:46 +1000
Message-ID: <20250814125752.164107-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


