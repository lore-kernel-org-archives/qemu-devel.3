Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DED3C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6Z-0007zZ-IX; Tue, 11 Feb 2025 11:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht63-0006md-Me
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:55 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht61-0003Tc-87
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-439566c991dso4018855e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291207; x=1739896007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bl3ONI7qAO69oWR+GPfjMThtztDgJTrkN3erh6CzbvE=;
 b=BDF6MF7rTdJffCZjtnpd/wwXqYm6fXauoLyx7JHJGUI75wxmfyYaW+Wg6ItimfZL5g
 JtKj/Xo4hvYJesxxwTfcgq/nA0ktAFM3eeVQclk26gsaZ3wO99QN+CHtK0LVOem/jPni
 ls3fC4tOJLRtQiWSo9ndOapwZL+otykflxy23IWSFLXR1qfBIqinv2Pli7YsEuYbiZak
 5iCVNuFeXEBB5EIEwbzzNHjSwbgHeL/WXBrgt2d7Va17aJkIkJqhoB1S0CSUnI7Hv7mz
 /qONewci7fAq+6Gb8GT1rWLCYTv2gbm9R/Kf3CXntlie9jjVg/jxNBkyzvvS0sb+FkpY
 aVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291207; x=1739896007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bl3ONI7qAO69oWR+GPfjMThtztDgJTrkN3erh6CzbvE=;
 b=uWBj1mK/siSUjtQK/ZD4G71Ut7T9/nnT1WzSZv8Us8UciQl0UhX5MTX7F46MaftH6F
 BHCjfmEDUP6kEtfMHaLixb7OOb5X+28Sn3OUddZdbiZ9YPO1yaglVCJhEtznaH5fz9R/
 0iFhwwG/CHVavV5E9fhf2VY4mvx2/Ihyo3lpGQPWKGH/7/XTAn1xSN217Cx8fmcnK2eK
 qQLuZUn9pE13uYPZZmJ5KTDWW/Q5ooG2ZqSx0+u9JuJITPvrakLCDx6DpiHpON6UdSPR
 34SuULHQnLfEmnHHEUDFgH2Bo3l84PT0KULYBBQRbVjqvoongF2fqKgBMkd5fPgS4IVk
 t0zg==
X-Gm-Message-State: AOJu0YxTz8MG4FvV0o+cgITPocGM0CATzAitkiVlbX+w/ErLXoSGlZqA
 N64iJbum5sQHTASGKzR8ycKjurMsS8YGOoV2UKKmC9InzrAL0fNetfktNuVAspxNn6Zhy4yZqYc
 0
X-Gm-Gg: ASbGncsvxmK9o6IesExgPWxRKai3R2ESKU1I7uFDgfwo9XVDVmeouNlHtRhf4/uwlJk
 8Lx+jlrghY1k4xx1aCGL6KddkWdHjXK3qKTa0u8aDjXzBWT+9OWMNc78c5XR+L5IwSQOEqT135Z
 asZarYzZwUJjZcxE53AurEsMV0D4eg7QoV8SD7oOyAS39I35yd9M5Y+87nqr7B8VBTXWA3/sBvd
 N6ib74CkpDvBQMudNcNYfWScj+4LuuFU6hkvrN6ordaPgSzMynkWk5Ijm8utRjt6WS8Mq6RgOUz
 YJpalmRoF5DbYwhV5s+E
X-Google-Smtp-Source: AGHT+IEA8FL18CUH3DZBsI+tPnpD6orW2fXVTM0mOAx+jO6jHdC2+m2zttuy74dYq6UCraEneoLA/Q==
X-Received: by 2002:a05:600c:3593:b0:439:54f2:70c4 with SMTP id
 5b1f17b1804b1-43954f27235mr25447965e9.9.1739291207490; 
 Tue, 11 Feb 2025 08:26:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/68] target/arm: Handle FPCR.AH in FMLSL (by element and
 vector)
Date: Tue, 11 Feb 2025 16:25:34 +0000
Message-Id: <20250211162554.4135349-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Handle FPCR.AH's requirement to not negate the sign of a NaN
in FMLSL by element and vector, using the usual trick of
negating by XOR when AH=0 and by muladd flags when AH=1.

Since we have the CPUARMState* in the helper anyway, we can
look directly at env->vfp.fpcr and don't need toa pass in the
FPCR.AH value via the SIMD data word.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-31-richard.henderson@linaro.org
[PMM: commit message tweaked]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 71 ++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index c2f98a5c67e..5f0656f34ca 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2124,27 +2124,24 @@ static uint64_t load4_f16(uint64_t *ptr, int is_q, int is_2)
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
@@ -2152,14 +2149,28 @@ static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
 void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
-    do_fmlal(vd, vn, vm, &env->vfp.standard_fp_status, desc,
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint64_t negx = is_s ? 0x8000800080008000ull : 0;
+
+    do_fmlal(vd, vn, vm, &env->vfp.standard_fp_status, negx, 0, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
-    do_fmlal(vd, vn, vm, &env->vfp.fp_status_a64, desc,
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
+    do_fmlal(vd, vn, vm, &env->vfp.fp_status_a64, negx, negf, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
 }
 
@@ -2184,29 +2195,25 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
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
@@ -2214,14 +2221,28 @@ static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
 void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
-    do_fmlal_idx(vd, vn, vm, &env->vfp.standard_fp_status, desc,
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint64_t negx = is_s ? 0x8000800080008000ull : 0;
+
+    do_fmlal_idx(vd, vn, vm, &env->vfp.standard_fp_status, negx, 0, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
-    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status_a64, desc,
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
+    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status_a64, negx, negf, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
 }
 
-- 
2.34.1


