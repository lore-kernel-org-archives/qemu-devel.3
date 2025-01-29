Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4327AC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2w-0000r1-A9; Tue, 28 Jan 2025 20:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2t-0000op-Mq
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:11 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2r-0003WR-Rb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:11 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216634dd574so76330335ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114748; x=1738719548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irI8P1SvOCgzRxiQPiYVSipG0XrpLXOcoub7PbBmjSc=;
 b=T3q/dpPN0ZcU8vgZk+73g7lAikQo1DV6lk6e3C0z/dpAej80V0hRKjqvwxUvUbDcDS
 Zv7CL1zL+BkdEp1DjgZuf657Zg0Q0GZk1DOzNl1ob1PfzQpqgc9OkQLO4AD8VUfkHSd/
 Qqjg+kvCbzRsYxYhBraN8cW9McsyWu92J73nK7+SERFl3Hy/wBMoKIRs/D6nkYJ+7hgs
 TXRAD0Jl+YGGU1O/BK+80Gji/7mwqXVV56ZDHUrdDXDsbe2nwvjal2BmiPeRZ0OuV9bk
 J05yDhMnft7qnjEKv2buV/Pd9hR4OXQoJ35rNZztV9Ywk7HQEMLHAHN6Dg83DY6VmDxM
 am1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114748; x=1738719548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irI8P1SvOCgzRxiQPiYVSipG0XrpLXOcoub7PbBmjSc=;
 b=sV/GVRblXTyp3teyKbZOwX+b8lCOCw4+s05nGm96gwVt4bmlQMZLfVoRIiKjjVYhUj
 3YCC6Je4ngawypUJKQ+0LV23UPHWb0KMs0Kx0OC4zouOOcsoHxmvQ63QaG0VVDILpV9U
 UeaqnSTY4Osi3AyXTiNWhJS83y+/WJ7Hj4FIpihZJWI6MttNAZGbnVNEqa+1rbxDbe97
 yeOyp1ysEa4Kpd2UGiKxSQniaPkamzndMe9p2VTSJrqxrI/cd2XZ0u3A5kuVpfzgf7l9
 BbhI75C9l+AQGeOrrbmf5aVZBtW3Opd7ePCttmDHhsQOVlivg8GklL4cnn+cf0V1f2lT
 +Dxw==
X-Gm-Message-State: AOJu0YxwEIrw7Ppg5O5zhUywSR7aTinfz3/sqFSHMJaX/6C4TawFDBOb
 eXsXtB2qC6P/5CxHCQ9Zgo7mZ+V8+67U+KWxvzU0Xz0/WQmjjS+KuO8TUxRlNK/O8S1KxYG94C1
 F
X-Gm-Gg: ASbGnctJXNzKlidhd7QAF+wC/9aplAOKHN+FkrUspj7FYX3BfjrKvk3sZwrZz07kXjX
 bztZUyMbub4BUlOCrbJijsO/L8I9kX0a70fGeTayTlJ+4vmRIu8RU6kv0HGN0Z4TIWK9hTVtqZU
 KvxfwC+GmKask5nm3NaWUNilzIQyUo/kSrUxFDTP20qtnygE1t7ETb+Nh0X4y/sHM9u6s0L93hN
 C7QSr4VatEJJQDYFyf2EE6LbIBNXdkjDmMIgxg65UIrotFqi5PR/KfD50mcJ+9ot/eO7phYGONa
 0ucshHlLLTQg+x73WakWioupZJEIQJX/W7fUzVYbM798RgsErQ==
X-Google-Smtp-Source: AGHT+IHOoLWQc12w2WaPya10vXTnNhoHehkwvpORFzj7wVdXfA+n2GzI+kKLtUmHkokBF1r4Rbba6w==
X-Received: by 2002:a17:902:ecc7:b0:215:9d58:6f35 with SMTP id
 d9443c01a7336-21dd7c55feamr17164805ad.1.1738114748615; 
 Tue, 28 Jan 2025 17:39:08 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 14/34] target/arm: Remove fp_status_a32
Date: Tue, 28 Jan 2025 17:38:37 -0800
Message-ID: <20250129013857.135256-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Replace with fp_status[FPST_A32].  As this was the last of the
old structures, we can remove the anonymous union and struct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h        |  7 +------
 target/arm/cpu.c        |  2 +-
 target/arm/vfp_helper.c | 18 +++++++++---------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 05a58de045..e6513ef1e5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -687,12 +687,7 @@ typedef struct CPUArchState {
         uint32_t scratch[8];
 
         /* There are a number of distinct float control structures. */
-        union {
-            float_status fp_status[FPST_COUNT];
-            struct {
-                float_status fp_status_a32;
-            };
-        };
+        float_status fp_status[FPST_COUNT];
 
         uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
         uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 777e5f5dd8..180e11c5d7 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -550,7 +550,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index e0d0623097..a2775a2e8d 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -117,7 +117,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
     uint32_t a32_flags = 0, a64_flags = 0;
 
-    a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
+    a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_A32]);
     a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_STD]);
     /* FZ16 does not generate an input denormal exception.  */
     a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A32_F16])
@@ -153,7 +153,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      * values. The caller should have arranged for env->vfp.fpsr to
      * be the architecturally up-to-date exception flag information first.
      */
-    set_float_exception_flags(0, &env->vfp.fp_status_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
@@ -196,7 +196,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             i = float_round_to_zero;
             break;
         }
-        set_float_rounding_mode(i, &env->vfp.fp_status_a32);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
@@ -214,10 +214,10 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64]);
         /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
     }
     if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
         /*
@@ -230,7 +230,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
@@ -495,8 +495,8 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
 DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status[FPST_A32_F16])
-DO_VFP_cmp(s, float32, float32, fp_status_a32)
-DO_VFP_cmp(d, float64, float64, fp_status_a32)
+DO_VFP_cmp(s, float32, float32, fp_status[FPST_A32])
+DO_VFP_cmp(d, float64, float64, fp_status[FPST_A32])
 #undef DO_VFP_cmp
 
 /* Integer to float and float to integer conversions */
@@ -1383,7 +1383,7 @@ uint64_t HELPER(fjcvtzs)(float64 value, float_status *status)
 
 uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
 {
-    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status_a32);
+    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status[FPST_A32]);
     uint32_t result = pair;
     uint32_t z = (pair >> 32) == 0;
 
-- 
2.43.0


