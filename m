Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F1CC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYV1-0006aV-RW; Mon, 27 Jan 2025 18:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUm-0006Nr-19
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:21 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUi-0005aJ-My
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:19 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso6693870a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020375; x=1738625175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sflSr/TdauAR3s9EgE90A0mkYRYsheBOwJCWqm7/4c=;
 b=CkcVSP9RWVyWNAF7zNATwMnevemFfkGeZBLIf7Ac/M7/ZJJUNmfKg84MGBCZA8nOaJ
 vOKArdBtF5nx0L6cxDQ40UgOFnDxY42/dOwirLGvbNQnYRb63cPP56Fetl876K6voahm
 r8lof1Vj72Mw7sCOkuoKWX4k7lKMUPbgnz6xkNl2LHCXWNaVCv6xyNCEpy9qmtQU1BkL
 3E1ywfkFrimTDbLD//wrBLbRdXQOAUfVSoBScF8YpWF226gW60V5EjBvdktjqktE9tQ+
 hAdYTl6cc//HHWOs6WgWSVnU9obOD4whf2UVlRai/uZ1mefYF5ub0i38OSUilL9Lzhnd
 URfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020375; x=1738625175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+sflSr/TdauAR3s9EgE90A0mkYRYsheBOwJCWqm7/4c=;
 b=Gx50+AO7QpIylvIdiFRtDiAGTNPWEs8AFXPgcZ5YXLeC2i3wmEKPN04sBXXHJ3fIMf
 5m95HVi0luh6Pq1Zv7Js70lyZ4M+0zbM9urFcP9gwRZ+MIDWlwSZNFpgCCqNemvSDRT/
 Srq+PLzIVO2MVEgknkZOPriQ2WsgkbUnnrz1zBmgBN6i63BhTKKl1FHZxYKmL5VbR9h9
 /7MmwCh0fKxjoQBC4oAVbd2EjZ23wbrHcjptOnTnCgtdBjH8tC4swginIEgAGz500BBb
 EgruH/CsIIgTnnxH/gKYML7bUCTrUjK8AZkrIYCdg4HAtnrdVR3u0dK1I6zNcsW1YavV
 PTow==
X-Gm-Message-State: AOJu0Yz0LNI9xaoq1TkUXCqoIbdpZ9idw1hcUxJ7ecpGNDDKMO+pByqX
 SgkbK1FpDfdfNWIbZKSyQCk/xKv3RBt+lSTLVraFdZvaDJ4JqKUF9O1T6qYyy8Toe5e3Izlx73N
 /
X-Gm-Gg: ASbGncuGvajgrShNsxlsUXoC0teuM6smxcxAnPVr1TOqU/ZkKEtFRff9zqvLTLxE1fY
 UO8B2QJ190c5lJV6GQA9zRHmj8thpSodi+7MZ3coHidDwNyWw1I3LuZCfjCMgo7PiIYlxFAJ1w3
 aXA6yDNgYleEKWZR/4QXjkX73V1AOh10LR0JsGCKj2YgCpOMzTt6TKH6hHF58YNtmaDbxtM0sZ5
 BoxbOZEr2Y2dlsGYFJ8wdgeMSOP7ooMS+Z2KlnQMNkbrN6rRnqQKvor9mM5fuW5F8h+KBkD+viz
 13B6Oe2mUI8fgvjOwI6+n8iKHfG2SlRuONBeFGQ=
X-Google-Smtp-Source: AGHT+IFbp5+EqJKTIs+RV/ntuaPfFg1aJIl1vRfLCZ5LJiQV+Y7lxNCy4TqElwITqSZVrppCzIKgvw==
X-Received: by 2002:a17:90b:2748:b0:2ea:59e3:2d2e with SMTP id
 98e67ed59e1d1-2f782c73b7fmr65245544a91.10.1738020375393; 
 Mon, 27 Jan 2025 15:26:15 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 12/22] target/arm: Remove fp_status_f16_a32
Date: Mon, 27 Jan 2025 15:25:54 -0800
Message-ID: <20250127232604.20386-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace with fp_status[FPST_A32_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/vec_helper.c |  4 ++--
 target/arm/vfp_helper.c     | 14 +++++++-------
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e39c8d0d3..06dbee5725 100644
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
index 4fc1d00d60..ceb2dcb3fb 100644
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
index 927dece4c1..61f268efad 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2178,7 +2178,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
     do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
+             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
@@ -2240,7 +2240,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
+                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index bcb05d7ff9..6a6eb48530 100644
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
@@ -155,7 +155,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      */
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
-    set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
@@ -198,16 +198,16 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
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
@@ -232,7 +232,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         bool dnan_enabled = val & FPCR_DN;
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
@@ -494,7 +494,7 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
     softfloat_to_vfp_compare(env, \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
-DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16_a32)
+DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status[FPST_A32_F16])
 DO_VFP_cmp(s, float32, float32, fp_status_a32)
 DO_VFP_cmp(d, float64, float64, fp_status_a32)
 #undef DO_VFP_cmp
-- 
2.43.0


