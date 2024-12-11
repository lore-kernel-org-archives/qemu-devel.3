Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF02E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPe6-00009J-Re; Wed, 11 Dec 2024 11:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdD-0005EL-Hi
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:14 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdB-0001Nc-EE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:11 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4678f681608so6627971cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934728; x=1734539528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNUc6zKhEMvBGcmYF/b5i2PAzW6cXJ3ArMmSMjtWkAc=;
 b=SzqxTPvrdBHDsL+/2eeYqmldmLlhvpFOwJf5wh0wWauyRTDMoTiMOdNw3TVvMjPZ+H
 VaO4CCSKSKF8faJoWpW5VA1XkL+PADqsEibK4qTt6iDMAvzOjFL+NnVUyIELJXVGTnvb
 poPfGm+gDbGUwDrJr7CFetI/n4ll6JRhCVqpYcKCnuzh2hXSnQaQ14vIhBw9trRaiFuz
 FgyRDk2P/6w8kkZzcsqxD+AQDVuIxBGOEvJX2bTK7hlAe9lhBgYCEnHTNXVKnhuhGwfb
 hl1BtiC2zuLvHg8MTf8Ct4UrZVHbeepUCqBFwZV05djlf1NYB5Oupj/LUmQyBDnoSRQx
 MUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934728; x=1734539528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNUc6zKhEMvBGcmYF/b5i2PAzW6cXJ3ArMmSMjtWkAc=;
 b=Vpbf7v9zJYAH+qde7Pr9jW1ZdS7Gb0RQgjfCoEmxlMtHR0g0cXymQ44nJgrLeB/RHZ
 zx9pSa3QsN2gpexrvOIHVuJUBb3X7OQe06BO42/ZmpDwVwA0KJQN4OEYPfC8ULXB/NqA
 dDsQIpkmFKycJIyMAwPZegrI3ltZ0N/nVkOqMC5YqXRTfFgdRh4BrjFwY8Umciq2HvD2
 Jg9oINzKrXp7DV+JbfVcksw06aydRExCci2RTRq2NNYUZBibMefzmyYW6m0zJgMJuI8c
 ycYbA7gHMCAsBnA6D7FH3XPnDT2tT0jU3kiUZ2dvOzC84eumIJf5bUCGQJDXxHPSqa93
 Chtw==
X-Gm-Message-State: AOJu0Yymv3ZueDTa9iCBOhpru7O2jhge9/knLqZMcLlrxxu3+MHcJgkz
 F6+VNYvLb+4x/zF5B3k/csoV318jaw3uIenrKd850lmyVXcbtjuZG8gJeP2hbTD9zlfJUccExiU
 emgl4JyhH
X-Gm-Gg: ASbGnct63we7na4Dlh9nBeYaa/wl5Dw8Q9AHlk0xiJUNbf23whLHjNh8aMttPq5bvC1
 1U6lN8ja3GiC3POM26vQntI9j2jNKCxtUvK3uz9cczUgi3y3hhVdnGClzcsKdxA2i76lKnAGtHC
 LbG9J3+/5I4EKEoM7Cb+Caf3qny4UzKXnVjmsTaJBaUHuuu61y8dcMDt4EJn91lYFcALHNNbUG1
 sfhe0YyWiN8LvwQdE7RKg1bVJuL3G9N574iO3t2b0AUTH9IMg26P6SvmExmDg==
X-Google-Smtp-Source: AGHT+IHLbSJxBlq7bcK5MHr5BOZT/t4KTQBpsL7XMqYgs0hGCB9fhmI8GPZoe/ZDX34B73ONA0EGMw==
X-Received: by 2002:a05:622a:c2:b0:467:5454:57b4 with SMTP id
 d75a77b69052e-46795457574mr5769011cf.49.1733934728315; 
 Wed, 11 Dec 2024 08:32:08 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 24/69] target/arm: Convert FMOV, FABS,
 FNEG (scalar) to decodetree
Date: Wed, 11 Dec 2024 10:29:51 -0600
Message-ID: <20241211163036.2297116-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 105 +++++++++++++++++++++++----------
 target/arm/tcg/a64.decode      |   7 +++
 2 files changed, 81 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3c1784593a..ca2b95510e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8283,6 +8283,67 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     return true;
 }
 
+typedef struct FPScalar1Int {
+    void (*gen_h)(TCGv_i32, TCGv_i32);
+    void (*gen_s)(TCGv_i32, TCGv_i32);
+    void (*gen_d)(TCGv_i64, TCGv_i64);
+} FPScalar1Int;
+
+static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
+                              const FPScalar1Int *f)
+{
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 t = read_fp_dreg(s, a->rn);
+            f->gen_d(t, t);
+            write_fp_dreg(s, a->rd, t);
+        }
+        break;
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 t = read_fp_sreg(s, a->rn);
+            f->gen_s(t, t);
+            write_fp_sreg(s, a->rd, t);
+        }
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 t = read_fp_hreg(s, a->rn);
+            f->gen_h(t, t);
+            write_fp_sreg(s, a->rd, t);
+        }
+        break;
+    default:
+        return false;
+    }
+    return true;
+}
+
+static const FPScalar1Int f_scalar_fmov = {
+    tcg_gen_mov_i32,
+    tcg_gen_mov_i32,
+    tcg_gen_mov_i64,
+};
+TRANS(FMOV_s, do_fp1_scalar_int, a, &f_scalar_fmov)
+
+static const FPScalar1Int f_scalar_fabs = {
+    gen_vfp_absh,
+    gen_vfp_abss,
+    gen_vfp_absd,
+};
+TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs)
+
+static const FPScalar1Int f_scalar_fneg = {
+    gen_vfp_negh,
+    gen_vfp_negs,
+    gen_vfp_negd,
+};
+TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg)
+
 /* Floating-point data-processing (1 source) - half precision */
 static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -8291,15 +8352,6 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     TCGv_i32 tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x0: /* FMOV */
-        tcg_gen_mov_i32(tcg_res, tcg_op);
-        break;
-    case 0x1: /* FABS */
-        gen_vfp_absh(tcg_res, tcg_op);
-        break;
-    case 0x2: /* FNEG */
-        gen_vfp_negh(tcg_res, tcg_op);
-        break;
     case 0x3: /* FSQRT */
         fpst = fpstatus_ptr(FPST_FPCR_F16);
         gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
@@ -8327,6 +8379,9 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
         gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
         break;
     default:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         g_assert_not_reached();
     }
 
@@ -8345,15 +8400,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x0: /* FMOV */
-        tcg_gen_mov_i32(tcg_res, tcg_op);
-        goto done;
-    case 0x1: /* FABS */
-        gen_vfp_abss(tcg_res, tcg_op);
-        goto done;
-    case 0x2: /* FNEG */
-        gen_vfp_negs(tcg_res, tcg_op);
-        goto done;
     case 0x3: /* FSQRT */
         gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
         goto done;
@@ -8389,6 +8435,9 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst = gen_helper_frint64_s;
         break;
     default:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         g_assert_not_reached();
     }
 
@@ -8413,22 +8462,10 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     TCGv_ptr fpst;
     int rmode = -1;
 
-    switch (opcode) {
-    case 0x0: /* FMOV */
-        gen_gvec_fn2(s, false, rd, rn, tcg_gen_gvec_mov, 0);
-        return;
-    }
-
     tcg_op = read_fp_dreg(s, rn);
     tcg_res = tcg_temp_new_i64();
 
     switch (opcode) {
-    case 0x1: /* FABS */
-        gen_vfp_absd(tcg_res, tcg_op);
-        goto done;
-    case 0x2: /* FNEG */
-        gen_vfp_negd(tcg_res, tcg_op);
-        goto done;
     case 0x3: /* FSQRT */
         gen_helper_vfp_sqrtd(tcg_res, tcg_op, tcg_env);
         goto done;
@@ -8461,6 +8498,9 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst = gen_helper_frint64_d;
         break;
     default:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         g_assert_not_reached();
     }
 
@@ -8581,7 +8621,7 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
             goto do_unallocated;
         }
         /* fall through */
-    case 0x0 ... 0x3:
+    case 0x3:
     case 0x8 ... 0xc:
     case 0xe ... 0xf:
         /* 32-to-32 and 64-to-64 ops */
@@ -8631,6 +8671,9 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
 
     default:
     do_unallocated:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7868b1cb24..b9cc8963da 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -47,6 +47,7 @@
 @rr_h           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=1
 @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
+@rr_hsd         ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_hsd
 
 @rrr_b          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=0
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
@@ -1321,6 +1322,12 @@ FMAXV_s         0110 1110 00 11000 01111 10 ..... .....     @rr_q1e2
 FMINV_h         0.00 1110 10 11000 01111 10 ..... .....     @qrr_h
 FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 
+# Floating-point data processing (1 source)
+
+FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
+FABS_s          00011110 .. 1 000001 10000 ..... .....      @rr_hsd
+FNEG_s          00011110 .. 1 000010 10000 ..... .....      @rr_hsd
+
 # Floating-point Immediate
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
-- 
2.43.0


