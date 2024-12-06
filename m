Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78067E77170
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOlq-0006sH-3j; Thu, 05 Dec 2024 22:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOln-0006q3-BV
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:43 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOll-0004Sv-Fq
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:43 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2967af48248so926552fac.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733454760; x=1734059560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62EszHINza2JM6HaVWD1VL/L58D3HMklvqS2u19Wl5w=;
 b=S3flFjo+6J7igjAM8dFhfiXkV3+9Y58KyZrEY06gski+AbBvcUKiw6tPYPtysyuNyT
 50+D0M/QEcILDBuQeE8qCI8FxK13B6Po1MIt+3svg+c+m78uSkuT8y7w3WD5Q5khN1Fo
 CS2gna0Kk5qFECoLStcIXumheAN0AUg1kC+Q+LEGvLtZHlFa5Dzj5+S92m6p4eUTjlrn
 ejXUzkD2W+Y8aUActQ5qbBt0PHj82jVWq3E2pnSpkXLQWerFQYLpfBRI0eZln5tv1IDU
 OBwOKTxmVb6T5j9lTTlrRrM1p8+gxpeIWPxAY62SychNTm10rpzOTWXcX85yT3nenmrh
 VwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733454760; x=1734059560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62EszHINza2JM6HaVWD1VL/L58D3HMklvqS2u19Wl5w=;
 b=B37LqxBh0U0o1b+nDPGawuupKBp0/uxHlhsiKKx4WFPHIrMr7eglhMU2kssLaCQ15a
 wRPHwR1VLF7U4ZjMrWd4DOJLlzdhQf3+QEyTik/1TbGCO0w3K9CsBKz9D/FNU6uLxap/
 np/HbDm9KQSNFDnhABVJiN2s21/YKCgP0m0UmJnPGMQtB1LITRdoPCHtOh6ljqci8u1r
 Zao+6n4aU9hmX1XqmNWuKPt01N1ArN35Hv5s8o+0Y46q4cmvcff2dzGcJFCl8u3rVeew
 s9qChnF2FtM30K0wsRbJiVKHAbYxuEYec6AFWjxAVYHhX3H7xacWW0DIYqu9Re+yrNnP
 6qKQ==
X-Gm-Message-State: AOJu0YxfTbUyqtFOON+lTcQjqymUefsGlBXGNPG5HMYeEtWY9TqW/6zL
 O8nFJjho7d4wsp4Y5Qj5niyBHQR7prXJU6C9OUrvMGRefGaT4yO0LHleyIHPgDxKk8OmpfvK4gq
 ZmnmK4v19
X-Gm-Gg: ASbGncvYL0jc79kxRpvN9Xt35JeM74Of2rCnSp63iuC/SWLYuUxAOx17XGmCpTqz946
 ZdQvXi7k6LU16oUCar+aj7v7VDCnwkrSunIs670lkIG9XSbhCl7tMBQoZAISctGa93GfVkXwRsM
 sDg9WWtXvkTsK3hbj0nSgcrTok4Y9flFKM+knBcaEBhzpA+RS7O5pWjbZG2Nrskns5X+EFoNOdi
 jWOWy5Z/bN+9tFKrCGMWM1gB4WEPAFtOkf+yqxuvEjv6hIInEDOk0MBILWyuIpz61Gv0o+vHj+3
 SdgXkklge8UnqYPItt+CMTdemSW17M+aS34C
X-Google-Smtp-Source: AGHT+IHU9Y9OxNO3Iw+gRMXoQYv1PfisI4HVRB+IRSSluGku+i6l171ZYzYtGNr5pzAKmbPz1fkUWQ==
X-Received: by 2002:a05:6871:9187:b0:296:dee4:771c with SMTP id
 586e51a60fabf-29f738826eemr768935fac.33.1733454760134; 
 Thu, 05 Dec 2024 19:12:40 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc493b2dfsm596442a34.9.2024.12.05.19.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:12:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 8/9] target/arm: Convert vec_helper.c to use env alias
Date: Thu,  5 Dec 2024 21:12:23 -0600
Message-ID: <20241206031224.78525-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206031224.78525-1-richard.henderson@linaro.org>
References: <20241206031224.78525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Allow the helpers to receive CPUARMState* directly
instead of via void*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h         | 12 ++++++------
 target/arm/tcg/helper-a64.h |  2 +-
 target/arm/tcg/vec_helper.c | 21 +++++++--------------
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index db8b8dc748..61b135a707 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -863,13 +863,13 @@ DEF_HELPER_FLAGS_5(gvec_suqadd_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmlal_a32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmlal_a64, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a64, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_2(frint32_s, TCG_CALL_NO_RWG, f32, f32, fpst)
 DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, fpst)
@@ -1040,9 +1040,9 @@ DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_6(sve2_fmlal_zzzw_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sve2_fmlal_zzxw_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(gvec_xar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 4d70493914..26e327af3a 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -29,7 +29,7 @@ DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, fpst)
 DEF_HELPER_3(vfp_cmpes_a64, i64, f32, f32, fpst)
 DEF_HELPER_3(vfp_cmpd_a64, i64, f64, f64, fpst)
 DEF_HELPER_3(vfp_cmped_a64, i64, f64, f64, fpst)
-DEF_HELPER_FLAGS_4(simd_tblx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(simd_tblx, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_3(vfp_mulxs, TCG_CALL_NO_RWG, f32, f32, f32, fpst)
 DEF_HELPER_FLAGS_3(vfp_mulxd, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
 DEF_HELPER_FLAGS_3(neon_ceq_f64, TCG_CALL_NO_RWG, i64, i64, i64, fpst)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index d2d9d5e829..e3083c6e84 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2057,28 +2057,25 @@ static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
 }
 
 void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
-                            void *venv, uint32_t desc)
+                            CPUARMState *env, uint32_t desc)
 {
-    CPUARMState *env = venv;
     do_fmlal(vd, vn, vm, &env->vfp.standard_fp_status, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
-                            void *venv, uint32_t desc)
+                            CPUARMState *env, uint32_t desc)
 {
-    CPUARMState *env = venv;
     do_fmlal(vd, vn, vm, &env->vfp.fp_status, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
-                               void *venv, uint32_t desc)
+                               CPUARMState *env, uint32_t desc)
 {
     intptr_t i, oprsz = simd_oprsz(desc);
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    CPUARMState *env = venv;
     float_status *status = &env->vfp.fp_status;
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16);
 
@@ -2122,29 +2119,26 @@ static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
 }
 
 void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
-                                void *venv, uint32_t desc)
+                                CPUARMState *env, uint32_t desc)
 {
-    CPUARMState *env = venv;
     do_fmlal_idx(vd, vn, vm, &env->vfp.standard_fp_status, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
-                                void *venv, uint32_t desc)
+                                CPUARMState *env, uint32_t desc)
 {
-    CPUARMState *env = venv;
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
-                               void *venv, uint32_t desc)
+                               CPUARMState *env, uint32_t desc)
 {
     intptr_t i, j, oprsz = simd_oprsz(desc);
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
-    CPUARMState *env = venv;
     float_status *status = &env->vfp.fp_status;
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16);
 
@@ -2562,10 +2556,9 @@ DO_VRINT_RMODE(gvec_vrint_rm_s, helper_rints, uint32_t)
 #undef DO_VRINT_RMODE
 
 #ifdef TARGET_AARCH64
-void HELPER(simd_tblx)(void *vd, void *vm, void *venv, uint32_t desc)
+void HELPER(simd_tblx)(void *vd, void *vm, CPUARMState *env, uint32_t desc)
 {
     const uint8_t *indices = vm;
-    CPUARMState *env = venv;
     size_t oprsz = simd_oprsz(desc);
     uint32_t rn = extract32(desc, SIMD_DATA_SHIFT, 5);
     bool is_tbx = extract32(desc, SIMD_DATA_SHIFT + 5, 1);
-- 
2.43.0


