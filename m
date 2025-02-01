Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B8EC02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZC-0000iu-L7; Sat, 01 Feb 2025 11:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYs-0007Vw-6R
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:41 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYq-0001NM-3X
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:37 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso2705356f8f.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428095; x=1739032895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KL1yU7FzWgomIFAJcktx8UQOLZ+TTPy9vMWFLlf6FpA=;
 b=xN61iEnD2RGjm2ORGrTUdPcxTuaFC+roa7J6lkat8N2OSCSqjxubyl3eBJgspHVWvv
 Uc8cddOX0fTtVtXAaxcI0fAiqFtIReqw8xMhD5vDTbWsT4i5IdPK1DpdknjNSbrtpMZL
 54/LfNxQfh2Oyajt3dfK4kdG67iFw2hdn3egj8fPVXVKyuYvfEilypLPbYUjyIwITqDk
 hoQ6SKTINEk9CLWFAmahBZl/PfhQAMDg54Hnt5K8LrswjyWP7U5uqHkb4QKYx91nbfPG
 LYvCux9zrjoi5IUL3aqRrkaorplnBcosiTROh3OIG7ll/Oodf1DF72NWvjnseYROM01o
 h+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428095; x=1739032895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KL1yU7FzWgomIFAJcktx8UQOLZ+TTPy9vMWFLlf6FpA=;
 b=BpjqeGr/uSn6Fti1jXbb55k+sZCGO2iZQdDCFZ8WgGQScQoUFVpsMU7jAUwBusu5JE
 YDdznO7IAVjhy8I4jUYaBOCTV31izXUDZhN7X9s3FTJIyXmnRVKTuYKcKEP1GptAs3q/
 /41lmHRCfiQnYtcC7kPpeanc23lEbiR2mywg5XcJd74eAzIAsHBaigQcqpnbBHnsFLfP
 hYJpJKc4EfRn6h87eXpRdCcZnJWsspOCSNeaLfTdyNdHp7sO+aN1Q6cmubuPb2IvIALB
 7GkA+HPzGywvbdw4xhZE2EenMiUeSVQVLqTo81bJ9YECno+EyrZz3u53EM48FzpcS4RF
 Bfzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtqrgSwiJ1Rx6Ae4aTMAMaxrv7bhaWU/WGh9AXccSdPg1dgJR0gMkUUFlErT8CDYElipRcW2gvlNMI@nongnu.org
X-Gm-Message-State: AOJu0Yw+X78NYGHxW5lA7NfqDx2srLl8VqJNZRHAJ883Qfrt3b50NR7S
 8Bw4E2YFrNcW0tzoqtTLgnlXpwBE/Oc97+UZ/fVPodH/KBQD7bYJjJChRhvUhxU=
X-Gm-Gg: ASbGnctCZITP5lhDJxJ2R91js8pAI8rou9VhBTVP/3SG9wHMRkZhZgfMFbpOZ4S1PN9
 cYCvIowkgmZsUxdgGvgucwrF3RGknIi5jFQMDU6U43S7d+8sF5HpPPtBXf0yAWEb6sPyvSA7aao
 sg5Ff3toZ18xuSvaBwWb4SP9yh1gC5D7+TM5smRwjy4OQQmUsYI9csJ2t5MZ3SJUc0suZ9/VvQ4
 H3b8K8sfyJVsCGogGSaQfjSpazlchZ2RVf+Pmv4yq/7WAUlUTbkoBe8e7bofVMt3DRmnvnqKwz0
 Ph2iqfkjX4T6nwMyOSUw
X-Google-Smtp-Source: AGHT+IHmnciqyMNdwiiNxeVcJ8ITaXy7kXzqKuhreVbVv15HHzzwsaElf8T/M7EMIsWdR8HBcsVoLg==
X-Received: by 2002:a05:6000:154e:b0:385:e9de:d521 with SMTP id
 ffacd0b85a97d-38c519395bamr14473850f8f.8.1738428094688; 
 Sat, 01 Feb 2025 08:41:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 63/69] target/arm: Remove fp_status_f16_a32
Date: Sat,  1 Feb 2025 16:40:06 +0000
Message-Id: <20250201164012.1660228-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
index 9e39c8d0d3a..06dbee57259 100644
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
index 4fc1d00d60f..ceb2dcb3fb9 100644
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
index 6f7ca617936..e6e14bfd646 100644
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


