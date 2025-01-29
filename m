Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5187AC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx35-0000xj-J8; Tue, 28 Jan 2025 20:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx34-0000wq-2o
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:22 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx32-0003b3-CH
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:21 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2163b0c09afso115533185ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114759; x=1738719559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7uw+sMwgOweu7IdUjkrcCPnAG6lQ4TQTNHnRTQrjfU=;
 b=MKj9Bu3VePhmv/unfirWU51n7Ht4/nLpgGzC+XhXtNYTtN/BACYnNscZlZ1RNyUnZN
 bW35icCJMriHYGhANPWbO0NmUfJ/ekh7XavyWsbYJDoJDIQdiEPQE5UXFGJqD49HIyj1
 84G8PQmDL7QaGYKVDlaTBuu+Jp4o7Rak/PzMRCzMNfMmWozhSiKgrRXKwZgI3Nh9RyMW
 wBsQ7CoMlbYZg72UXDvgphGW1mQumZOvJSKYcwNTk/02ba5sMC80gBwjvt6hn09PffMN
 hd9lANSMcNKlRra2+/wI700tkH5UXjg2PpOm/dLXkxvzU2enKyIdAo7tJhpjIcb915oh
 ewJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114759; x=1738719559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7uw+sMwgOweu7IdUjkrcCPnAG6lQ4TQTNHnRTQrjfU=;
 b=SmWeJZZ75h6tMtHOZqewGJVJUf6cEZq89elIQDBcRZmHxeA0lbMl8yM3MgAjYRFnHL
 KUEZTGAWNHFi9RRuFI0llreYduHKweHQK6hx1HTdscdJDvZDY4Rnmomry5lsZuA5rMIy
 pKnTWQK/BDI7wJtaGt2x0MKqnbQJDng2Ap8rJPfMZXKrDWUBdfKM8JBzr54HZn1N+M4j
 XZmShyIBaNHY4oxXefwnNTjEf41nALiI5L+M6mlcyCrIbF4lbINiZ3nS/REaqdRo74iE
 Hetj2JiluGH7vTh/bekPSbiqyJHzuJcSf2tSQ8yev9k/gH+Z6IzDJBG90eY0TCW+NIxH
 e5xA==
X-Gm-Message-State: AOJu0YwuUBMbQdjh/GlfOUeeX1LBDTRf9nlrNuR/92QKP08g7xd5FbTl
 uYpJqQwAEMYuJLWYbi5r6vpyUj1jK/RxDA7nWficETx8F6bXHGT/P3FP/MK6cQNARDziCRNUAeM
 k
X-Gm-Gg: ASbGncuPNIQjYXtLlde3rmjSzUT+7ffwjCe7axmBb8P0iNqFYGK7Hy86oeuiw2etanp
 OLTZHI+OU41/nziwyKfaCiYhnOvAlHhzNZ21chmsFsuwO+FaK1S5bB5XbXWHDp8Sq6x6peqb54s
 MLTmXhKaN7xoQ22MkITtt5CB+Ygcav5WHOChrUQWY+HJSGAnB2KVrJlfBc3iasVJvqhVLAx/e+3
 qWPHeWAPrK49/aUYkg7AX/P2tC2KNc9AaoN1tqAjMnEaBxpcCRnyDaQeGiTOgp9FNUE0Md8FALe
 +HKnhWEsVCx+c8VUz3HEiM5H3lAeHsGkti84ptZY6s0lUStvrg==
X-Google-Smtp-Source: AGHT+IGjEJPCFaX+9TrKILcbYHg0+Y8uUT9NPCtavvORkMf1zPbxE1ssB8pB44j0f7JS6rkmRDE6og==
X-Received: by 2002:a17:902:ea12:b0:215:9a73:6c45 with SMTP id
 d9443c01a7336-21dd7d6e17bmr19886415ad.22.1738114759055; 
 Tue, 28 Jan 2025 17:39:19 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 30/34] target/arm: Handle FPCR.AH in gvec_fmlal_a64
Date: Tue, 28 Jan 2025 17:38:53 -0800
Message-ID: <20250129013857.135256-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 71 ++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index b3ed6533bb..9b14885ef2 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2126,27 +2126,24 @@ static uint64_t load4_f16(uint64_t *ptr, int is_q, int is_2)
  */
 
 static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
-                     uint32_t desc, bool fz16)
+                     uint64_t negx, int negf, uint32_t desc, bool fz16)
 {
     intptr_t i, oprsz = simd_oprsz(desc);
-    int is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     int is_q = oprsz == 16;
     uint64_t n_4, m_4;
 
-    /* Pre-load all of the f16 data, avoiding overlap issues.  */
-    n_4 = load4_f16(vn, is_q, is_2);
+    /*
+     * Pre-load all of the f16 data, avoiding overlap issues.
+     * Negate all inputs for AH=0 FMLSL at once.
+     */
+    n_4 = load4_f16(vn, is_q, is_2) ^ negx;
     m_4 = load4_f16(vm, is_q, is_2);
 
-    /* Negate all inputs for FMLSL at once.  */
-    if (is_s) {
-        n_4 ^= 0x8000800080008000ull;
-    }
-
     for (i = 0; i < oprsz / 4; i++) {
         float32 n_1 = float16_to_float32_by_bits(n_4 >> (i * 16), fz16);
         float32 m_1 = float16_to_float32_by_bits(m_4 >> (i * 16), fz16);
-        d[H4(i)] = float32_muladd(n_1, m_1, d[H4(i)], 0, fpst);
+        d[H4(i)] = float32_muladd(n_1, m_1, d[H4(i)], negf, fpst);
     }
     clear_tail(d, oprsz, simd_maxsz(desc));
 }
@@ -2154,14 +2151,28 @@ static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
 void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
-    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], desc,
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint64_t negx = is_s ? 0x8000800080008000ull : 0;
+
+    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
-    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_A64], desc,
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint64_t negx = 0;
+    int negf = 0;
+
+    if (is_s) {
+        if (env->vfp.fpcr & FPCR_AH) {
+            negf = float_muladd_negate_product;
+        } else {
+            negx = 0x8000800080008000ull;
+        }
+    }
+    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
@@ -2186,29 +2197,25 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
 }
 
 static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
-                         uint32_t desc, bool fz16)
+                         uint64_t negx, int negf, uint32_t desc, bool fz16)
 {
     intptr_t i, oprsz = simd_oprsz(desc);
-    int is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     int index = extract32(desc, SIMD_DATA_SHIFT + 2, 3);
     int is_q = oprsz == 16;
     uint64_t n_4;
     float32 m_1;
 
-    /* Pre-load all of the f16 data, avoiding overlap issues.  */
-    n_4 = load4_f16(vn, is_q, is_2);
-
-    /* Negate all inputs for FMLSL at once.  */
-    if (is_s) {
-        n_4 ^= 0x8000800080008000ull;
-    }
-
+    /*
+     * Pre-load all of the f16 data, avoiding overlap issues.
+     * Negate all inputs for AH=0 FMLSL at once.
+     */
+    n_4 = load4_f16(vn, is_q, is_2) ^ negx;
     m_1 = float16_to_float32_by_bits(((float16 *)vm)[H2(index)], fz16);
 
     for (i = 0; i < oprsz / 4; i++) {
         float32 n_1 = float16_to_float32_by_bits(n_4 >> (i * 16), fz16);
-        d[H4(i)] = float32_muladd(n_1, m_1, d[H4(i)], 0, fpst);
+        d[H4(i)] = float32_muladd(n_1, m_1, d[H4(i)], negf, fpst);
     }
     clear_tail(d, oprsz, simd_maxsz(desc));
 }
@@ -2216,14 +2223,28 @@ static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
 void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
-    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], desc,
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint64_t negx = is_s ? 0x8000800080008000ull : 0;
+
+    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
-    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_A64], desc,
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint64_t negx = 0;
+    int negf = 0;
+
+    if (is_s) {
+        if (env->vfp.fpcr & FPCR_AH) {
+            negf = float_muladd_negate_product;
+        } else {
+            negx = 0x8000800080008000ull;
+        }
+    }
+    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
-- 
2.43.0


