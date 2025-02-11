Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27A4C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht8F-0004Ue-Ri; Tue, 11 Feb 2025 11:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6I-00074R-Un
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:10 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6E-0003gC-QA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:06 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43934d6b155so19917965e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291221; x=1739896021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m8/4VpF1Ep30x1URgXJM70HMYaComhtAxSfavDofOJ4=;
 b=U2tld1gu8T0/lEtI0ZRrfSFyEOIrR5VouBk0RIPOb5kLfWNzHCaaH5SH6RlPAyzw7q
 tHDqWPZAxk5KYkeRW9nKeogpPmcs6fm/flDF7ZH6XxBx6Vj41MbL2EO6s+kvbqtDXkNL
 Rg4tTzxy17FreM4DOoBL2bucO9BkGpMSD2WfZ7g+Yr1pGvBJStfyULN8ZRyb2BLp//jg
 8Yt+Pas5+CB3lMM2e9h21bnIozPKFz07xXCdyhqfsCCvW2i2OIAhAaKEjnjuDmjo5WaJ
 3nWnPKXnvTojHGzX9Y7g1KVqFndnDkfTmcW+PO+gWOZi5cKj84rar4SzkhkCDWhZ4dII
 Y4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291221; x=1739896021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8/4VpF1Ep30x1URgXJM70HMYaComhtAxSfavDofOJ4=;
 b=BUVM8VE/3WgjUEA8OMXwUD1cJGhyt49/sE+p/YxMW8d1zh9+XELPYvhPiCQJmQ6bId
 Rsqja/XP6egAhhR+VKC0ff0F5uHEoN5wek6DLpOimfVQCwmi9vU4Z9984TbyCgwt8R0d
 T3hnsyTROkNfx/r9dMh1Fm7UuRAY7KC6O26A9cjGcSziZLYiqbXXcBPj2QnEqt9Gf9vw
 TGiBzD8iro6HCc0UX9vyqiPA+0vdB3xeXNmJq2AC/Zu0gjwP2EsN9cnxfae6oNYZqGlV
 YPqxjaFTWWBmrMVrq/BnI6Qr1IbOt3Hi7DMJDI3SmPHd3/BKo0Bpt+FIsDjZLLnLIGMK
 Y59A==
X-Gm-Message-State: AOJu0Yy5ngvk7sNOIxyAtNLSJ+HRw8kLLNa5OdoaeOGcrhbT1hS/q6g7
 KhwPRoyuRM2IShGsOAUYwHMWRn4khx1BqTE3b/6WvZgAE0RfvE44kY9Zv8xLiZkIbBFjbuWEnLx
 c
X-Gm-Gg: ASbGncuiBrVA1FAJQEpvo6FRhLf3DmmEfDtgMrYikYv6kpCtUrxl0zQom/KoqgRL1U7
 c4pYyHmiBzDQu9QrBDQd0rgkuZm/NCZ6Uk+DD2kxPAYl+lVNZfjWwHty1Ns9gqKxqXLA04pdv+J
 4q4OgX45wos6UbyFZf//PgLsu39JB5u0WBJp8xxbtxfGzG5n9GEy3RlwSGUGvo+3iYfvAEyiAtx
 qB18PAaaPnryw5GxOi7qDZ36chafg+ZhbrRti4qHvQ8pCYqDqNvXmXBRS/wnwRTIiGQbBtqTAoK
 0w5PgiQT25AZh/ovbAWm
X-Google-Smtp-Source: AGHT+IGemXFxlVCmmwnNaxW7clMfb+MMYCQKbnNLxssGZC+KE3nvnm5FxJirLxWjDionKMh+DSSf/g==
X-Received: by 2002:a05:600c:2d0c:b0:435:edb0:5d27 with SMTP id
 5b1f17b1804b1-4394cebd10emr40780885e9.9.1739291220687; 
 Tue, 11 Feb 2025 08:27:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:27:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/68] target/arm: Remove fp_status_f16_a32
Date: Tue, 11 Feb 2025 16:25:48 +0000
Message-Id: <20250211162554.4135349-63-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Replace with fp_status[FPST_A32_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/vec_helper.c |  4 ++--
 target/arm/vfp_helper.c     | 14 +++++++-------
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6cf97ba9c93..1593cc1036a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -692,7 +692,6 @@ typedef struct CPUArchState {
             struct {
                 float_status fp_status_a32;
                 float_status fp_status_a64;
-                float_status fp_status_f16_a32;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 18e7debe295..88bff67300c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -553,7 +553,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 48dbd8bdd23..78f14503f49 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2155,7 +2155,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
     do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
+             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
@@ -2236,7 +2236,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
+                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index ea6018864d3..dae46a099a3 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -120,7 +120,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
     a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_STD]);
     /* FZ16 does not generate an input denormal exception.  */
-    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
+    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A32_F16])
           & ~float_flag_input_denormal_flushed);
     a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_STD_F16])
           & ~float_flag_input_denormal_flushed);
@@ -157,7 +157,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      */
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
-    set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
@@ -200,16 +200,16 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         }
         set_float_rounding_mode(i, &env->vfp.fp_status_a32);
         set_float_rounding_mode(i, &env->vfp.fp_status_a64);
-        set_float_rounding_mode(i, &env->vfp.fp_status_f16_a32);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
     }
     if (changed & FPCR_FZ16) {
         bool ftz_enabled = val & FPCR_FZ16;
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
@@ -234,7 +234,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         bool dnan_enabled = val & FPCR_DN;
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
@@ -496,7 +496,7 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
     softfloat_to_vfp_compare(env, \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
-DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16_a32)
+DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status[FPST_A32_F16])
 DO_VFP_cmp(s, float32, float32, fp_status_a32)
 DO_VFP_cmp(d, float64, float64, fp_status_a32)
 #undef DO_VFP_cmp
-- 
2.34.1


