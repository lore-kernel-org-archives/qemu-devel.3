Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A360CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHH-0001iK-RS; Fri, 03 Oct 2025 13:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHE-0001hJ-Gr
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:04 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGU-0006FN-HC
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:04 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-782bfd0a977so2373682b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511289; x=1760116089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Og9JNUSJhtxcO4q7du8DvVfoQI0JDprhWczIVzB4Jaw=;
 b=hIbxlU0iJT5CrCeanXm/D5LjJIe85H9edC57w1SyqRnXmFjunDsLs3HzXRb1UeC3MI
 iEH4AM1SqGb+tWoCPjL2nUZlOCmwDraejAnUQgFxfJ2bB9Yhtj0LhwdccUV6HRj8aeJT
 dm4hmyxGBJ+jBp9UWM3jnFaxQnpvlGs81VmfhgqKIVz77FSNDIvZklIwPC+y9vbZg5dH
 Sw6LcOI+I6fYOgrspvHg9ik3xgZFH/9Fmr1QsNd+QAhXuoLN9GmGuCGcsNK4O7C6dw6q
 d7ylbZa6SnI4edKtGz7r8ZDqBjpfI4GdM+rP1CMimIKb+r/I09fO/F0kzK4oNDU8zCkg
 pMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511289; x=1760116089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Og9JNUSJhtxcO4q7du8DvVfoQI0JDprhWczIVzB4Jaw=;
 b=w0PYGd+h/Il9Lzw4avSJV8nERUB0Sp9odEvQ3QjDSpSybnK0cfJpdmVelmUOKk8Usp
 SMg4V2rwYFhdHs5moMQBu0/dw3l7HEJOnhqBDDZzKEO5k6Mg8WZxXUwJwZ157ApxO6UE
 s43/pvOlMmd/5SLlZkE+fvOk4os3neOBXrInsvLyV9A6fUZrmLt8xXNgKbW+b+LSbl0q
 pntxLFBTTk3AQsCk5sAAPfd8J7PxWcbcY/98mX/+hrCCauirQKHzdWaewW68QAcl8skx
 sf+Fleq1zp9w5vBJlFIRaMOQg0R786tSKA0qepmsfHvuDgCrUTZE4hpwiAFl3aAvXaoZ
 U5zg==
X-Gm-Message-State: AOJu0Yx+jden23kHgBJ+LnAJsjasKnIBBwAAKbcbHlg1lsU4m1LSoIoN
 QivaYtUEIndm9sZlyjKzMIfouONdOzbNa+/J9eh51MhbcOBCHWzIhXrZd3sdxjZzoudeCCPXZ+n
 ZBLoGAdM=
X-Gm-Gg: ASbGncvJfk/aIK1if8QhIlT+7IxYBp5Egnj35bvYUidOAj603nezgKVGRByeQi/h57e
 nRSXEENRmXtuKrHUeAVq9NdoLFSxgU0nnWpIq5zLraJVvl2VImyC1BHVS+tYae0J64BEGetm+Q3
 bP3hZ0sAbWc2m5jOUNbO2khQ/tmoB4bT7woTF9BqxgH7X/vzJYPLlmuc8T55Iue5idfxjbCpzkL
 w7e4dp5ppDU7w1KJrqgmojcTBwrjKwuZGGI+y95KrcDwpcMFymC98kXh61Ls7I139O0TMqeqvnf
 2E1/Wv9kIWdvygO8CZ8BgVbUWujgrBgu++pmhEIuxaMpTpK58U/zjfhrDuqAsokYxu3BHG8XLvT
 aCcMa2DvB6uzs3yv/95OYSVn/9sp7bs76+NPWdbeVoWUSp5iI5GKT15rA
X-Google-Smtp-Source: AGHT+IGcWZKbxSz1QBDJ8Jt1OynxGFgmxJ/VVlnkp2NjDEFPHXZGsv0e9R5fiNOBhkvefc/cNXI9rQ==
X-Received: by 2002:a17:903:2f10:b0:28c:2db3:b9ab with SMTP id
 d9443c01a7336-28e9a596c3dmr48649575ad.26.1759511288960; 
 Fri, 03 Oct 2025 10:08:08 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 08/73] target/arm: Implement get_S1prot_indirect
Date: Fri,  3 Oct 2025 10:06:55 -0700
Message-ID: <20251003170800.997167-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index d6d704e2a9..4fb4436db1 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1448,6 +1448,106 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
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
@@ -1677,7 +1777,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     int32_t stride;
     int addrsize, inputsize, outputsize;
     uint64_t tcr = regime_tcr(env, mmu_idx);
-    int ap, xn, pxn;
+    int ap;
     uint32_t el = regime_el(env, mmu_idx);
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
@@ -2011,7 +2111,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
             out_space = ARMSS_NonSecure;
             result->f.prot = get_S2prot_noexecute(ap);
         } else {
-            xn = extract64(attrs, 53, 2);
+            int xn = extract64(attrs, 53, 2);
             result->f.prot = get_S2prot(env, ap, xn, ptw->in_s1_is_el0);
         }
 
@@ -2027,7 +2127,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         int nse, ns = extract32(attrs, 5, 1);
         uint8_t attrindx;
         uint64_t mair;
-        int user_rw, prot_rw;
 
         switch (out_space) {
         case ARMSS_Root:
@@ -2076,33 +2175,51 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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


