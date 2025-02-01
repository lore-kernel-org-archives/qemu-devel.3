Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F79C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZB-0000cI-Np; Sat, 01 Feb 2025 11:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYr-0007Vu-S1
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYp-0001N8-EP
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:37 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso34953825e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428094; x=1739032894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ndFhy3R+PRvTF5+po0fXXM0VFFSL6oPFu21l+oGBHxY=;
 b=D1Dxzkx9kPi5EsE5LB4gqJUiNnBvmEsEiQ8Sn6sJPqJGUJ4+AkdcFCUE2O1BkS9uPu
 VftxipvHqQT+RMFOsUQb8Mxo7Snam76qVBVol7cafY7/Rtjzg62r0+AvShRj8DsxLx35
 NRmN7GJGiRrt1RXi8+lJYl5LfXBpvmxEumjTDgApPu1qBc8mM0KDORdfExFYdHFDyZNI
 ad2veswFL36MIMvnOuQ2uIxzEtNf/OLPMk2JrK5RbwtJRPXZWH2Wez4CJmVktwvkL82D
 58Pu9ZYcgJWIxyiU3FnsQ1OLtQWo7L1EnNN8QtmjK3e9aqwhFAmUuonWX599tgrpj50X
 qL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428094; x=1739032894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndFhy3R+PRvTF5+po0fXXM0VFFSL6oPFu21l+oGBHxY=;
 b=b8G+yzYjv6LbFmrjIf3QC6xLmfL17DOv08c6cvFRbrjlifithOpCaR8CeM7C5C6Jy8
 D7UUnml/vClyjvVdpAvfbsnI3WrXYK/TSKE2MMgrTDe2BQlCk5Nu7r3lXxY38TjlZuGe
 ZP7ePkumaFBtVXSZIgAZ0COu2c2wQSK/DCIKHzPRKHEy1+WI7ylk2cRWNpjEVjupG8OK
 lQkzFa9uAH2qHFqNgnq1D7Zw6IoJe3/a7Sh0HYuOTs3JnK6L7IA6tc3A4nq9XxHdOzLp
 mUWv28YR4XcJxE3Jkgo81NeJc8ZlnGx/NyaFDufQo+SDVR2BqtAXZPaM9UvwhmKBjs2K
 MrYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZe4jPJ4O9F/Qhqh6Qq6jbUn2ZrsvXkh4mv8b2k4L5d6BHBuQRdSsVtxOcM3+bev0txu/psS0/AJMg@nongnu.org
X-Gm-Message-State: AOJu0YwK/2pN2V0VmCz2+BY7kdXI9q2+vDwLpLg2LKgZRQZIHJ6Ggzd/
 rf8VDIS9/GTMnFSOw2Mq/+dIPe01qKN3sljMMVVLF94fkRtcdR7SJRCVfPReOhTJwfpbCL29NKD
 n
X-Gm-Gg: ASbGncsR4I7pWF4lrPTTblr1NZrKbZIadvcLXDm8ILSSWUaKFMBjt/MNytUUW3tXcWQ
 G1SMnP5wHoJd3MG/OQ36bLNe4w5Zegx3Wca3aF1rk9Zi2b16DqzNfA3heMXe7cl3lIUCmddjIke
 Dgs77VTXXeTpt9iUeQP6r0vkR7hVuYJjkv3Zxvett6uWneA9ro8zDye8w39zAXFOqoP+eKgqXL5
 1eML8OgOaTd2E225n6mKCZDnZGbpCykbGMjbr0aNqaBlohg1UPK+Vj53lIDjHp1bbw4FOwmoWtQ
 8/5NWStRTue/eU9gIq0Q
X-Google-Smtp-Source: AGHT+IHAaoiOlhRf0x+QjXnxZsvu271cnngcshE8xutcu/SMvlGnxsPH44U62npVQqLm9z3auPcBBw==
X-Received: by 2002:a5d:5f93:0:b0:386:3213:5b9b with SMTP id
 ffacd0b85a97d-38c51e8e12fmr13617935f8f.43.1738428093731; 
 Sat, 01 Feb 2025 08:41:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 62/69] target/arm: Remove fp_status_f16_a64
Date: Sat,  1 Feb 2025 16:40:05 +0000
Message-Id: <20250201164012.1660228-63-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Replace with fp_status[FPST_A64_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/sme_helper.c |  2 +-
 target/arm/tcg/vec_helper.c |  9 ++++-----
 target/arm/vfp_helper.c     | 16 ++++++++--------
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5e3d952588a..9e39c8d0d3a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -693,7 +693,6 @@ typedef struct CPUArchState {
                 float_status fp_status_a32;
                 float_status fp_status_a64;
                 float_status fp_status_f16_a32;
-                float_status fp_status_f16_a64;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 01a0428c6ed..4fc1d00d60f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -554,7 +554,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 727c085f374..6e336e10c6a 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1043,7 +1043,7 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
      * produces default NaNs. We also need a second copy of fp_status with
      * round-to-odd -- see above.
      */
-    fpst_f16 = env->vfp.fp_status_f16_a64;
+    fpst_f16 = env->vfp.fp_status[FPST_A64_F16];
     fpst_std = env->vfp.fp_status_a64;
     set_default_nan_mode(true, &fpst_std);
     set_default_nan_mode(true, &fpst_f16);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index cffd0222602..48dbd8bdd23 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2173,7 +2173,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
         }
     }
     do_fmlal(vd, vn, vm, &env->vfp.fp_status_a64, negx, negf, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
+             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2183,7 +2183,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
+    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
     int negx = 0, negf = 0;
 
     if (is_s) {
@@ -2254,7 +2254,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
         }
     }
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status_a64, negx, negf, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
+                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2265,7 +2265,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
+    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
     int negx = 0, negf = 0;
 
     if (is_s) {
@@ -2275,7 +2275,6 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
             negx = 0x8000;
         }
     }
-
     for (i = 0; i < oprsz; i += 16) {
         float16 mm_16 = *(float16 *)(vm + i + idx);
         float32 mm = float16_to_float32_by_bits(mm_16, fz16);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 09e707badeb..6f7ca617936 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -126,7 +126,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
           & ~float_flag_input_denormal_flushed);
 
     a64_flags |= get_float_exception_flags(&env->vfp.fp_status_a64);
-    a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
+    a64_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A64_F16])
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
      * We do not merge in flags from FPST_AH or FPST_AH_F16, because
@@ -158,7 +158,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
-    set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH]);
@@ -201,16 +201,16 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_float_rounding_mode(i, &env->vfp.fp_status_a32);
         set_float_rounding_mode(i, &env->vfp.fp_status_a64);
         set_float_rounding_mode(i, &env->vfp.fp_status_f16_a32);
-        set_float_rounding_mode(i, &env->vfp.fp_status_f16_a64);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
     }
     if (changed & FPCR_FZ16) {
         bool ftz_enabled = val & FPCR_FZ16;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
@@ -235,7 +235,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
@@ -245,10 +245,10 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         if (ah_enabled) {
             /* Change behaviours for A64 FP operations */
             arm_set_ah_fp_behaviours(&env->vfp.fp_status_a64);
-            arm_set_ah_fp_behaviours(&env->vfp.fp_status_f16_a64);
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
         } else {
             arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
-            arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
+            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
         }
     }
     /*
-- 
2.34.1


