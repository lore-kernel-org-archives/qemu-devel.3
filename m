Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E3DC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLt-0005ts-OU; Wed, 05 Jun 2024 13:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLs-0005tR-Dz
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:08 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLq-0003pP-3o
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:08 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c21fbfb4a3so48291a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608185; x=1718212985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EPXd9sRPp98I5UpQo75MPh6Fgfyp//JLhUBsp5qO/q8=;
 b=I9qFU9CbrCYW04Cp+ijsRRMLCfib+fxQLpypLXGJU86p3zv3vPcWt5Y/ln7qCq5S9E
 4pt0Vqw0j/rTteaB2GDEsL68WR2tE1vaHDSwxnXqze9j2d4rBR8y1DrdxQOdySIkepyd
 qWo+mt9seZLZXSzeRj+bQYYlv1O3/vDcdD7tqhqBsK5f76hAbTGE6rPTCkqB1tsj+WmT
 NG+scFl8R6/YhDHA6+OW6rg837HOl0Zuw1XONZkZSy4LeZPGouo+FndmRzJnepgDJGfo
 hVmmGQPYqsT9Zn4l9JYsZ2CFFH1F4PrFVU6tq5ufWh6481f1oTuX+6X/z9LBRRRTe9uG
 NEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608185; x=1718212985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPXd9sRPp98I5UpQo75MPh6Fgfyp//JLhUBsp5qO/q8=;
 b=w5NWtZMpYoP/MI/cdHCRJxHfWsgT+geksHMH6vAkRLg2840uvLrypeuM/hy+Xk+sdw
 IV4ShHa5K6neQV7mA6SO32r7Lz80m5fwcQfbCMo27wr+pcj+IYKAR+u4aVCif07Gtod1
 1C6A4A7JA52g5X37cf9A9gs5N1jOjQQV78SgpqGqSAfwqvIicnUgGQ/svqMRmjbWES/C
 r5/k4IoC6C/0zqzQhd5eUge2yjRcekdeS7igFxvlrZ9iu1H6sXCYnJ9pGSlnAUTWohcZ
 RJiaUiLn6XafwvYKgWQXoVBsBGe26jAL05FRvzAbHZqThuBJUSyXVkGdB9/DmFlakaBv
 wJsQ==
X-Gm-Message-State: AOJu0Yz8BljVExkIQmSBr5EGNEEIjAJvaX6B/KprdG+uu7jv9ADyIm3Q
 rgf9Ek8EFfIqoKfjXDmKn6kYUQL4YFlRlcMeMiICfo2xEFjhOI/SnlP57lhuvfwq8cixIjtTXdS
 w
X-Google-Smtp-Source: AGHT+IErqvrKoioRWUxJW7HeqOzeYukb5CVuC7EttHvdEdY51NfFXVXsbnq1xrO4X44RIZuIGuc31w==
X-Received: by 2002:a17:90a:df89:b0:2c2:412a:619 with SMTP id
 98e67ed59e1d1-2c27db20c82mr3877530a91.26.1717608184760; 
 Wed, 05 Jun 2024 10:23:04 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/38] target/sparc: Implement FMAf extension
Date: Wed,  5 Jun 2024 10:22:25 -0700
Message-Id: <20240605172253.356302-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Rearrange PDIST so that do_dddd is general purpose and may
be re-used for FMADDd etc.  Add pickNaN and pickNaNMulAdd.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h          |  2 +
 target/sparc/cpu-feature.h.inc |  1 +
 target/sparc/insns.decode      | 23 +++++++++-
 linux-user/elfload.c           |  1 +
 target/sparc/cpu.c             |  3 ++
 target/sparc/fop_helper.c      | 16 +++++++
 target/sparc/translate.c       | 84 ++++++++++++++++++++++++++++++++--
 fpu/softfloat-specialize.c.inc | 31 +++++++++++++
 8 files changed, 155 insertions(+), 6 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 97fbf6f66c..f4d3311ac4 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -56,6 +56,7 @@ DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdivd, TCG_CALL_NO_WG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_5(fmaddd, TCG_CALL_NO_WG, f64, env, f64, f64, f64, i32)
 
 DEF_HELPER_FLAGS_3(faddq, TCG_CALL_NO_WG, i128, env, i128, i128)
 DEF_HELPER_FLAGS_3(fsubq, TCG_CALL_NO_WG, i128, env, i128, i128)
@@ -66,6 +67,7 @@ DEF_HELPER_FLAGS_3(fadds, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fsubs, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_WG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_5(fmadds, TCG_CALL_NO_WG, f32, env, f32, f32, f32, i32)
 
 DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_WG, f64, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_WG, i128, env, f64, f64)
diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index d800f18c4e..a30b9255b2 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -12,3 +12,4 @@ FEATURE(ASR17)
 FEATURE(CACHE_CTRL)
 FEATURE(POWERDOWN)
 FEATURE(CASA)
+FEATURE(FMAF)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 02fa505b49..056fba98f9 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -29,6 +29,7 @@ CALL    01 i:s30
 %dfp_rd     25:5 !function=extract_dfpreg
 %dfp_rs1    14:5 !function=extract_dfpreg
 %dfp_rs2     0:5 !function=extract_dfpreg
+%dfp_rs3     9:5 !function=extract_dfpreg
 
 %qfp_rd     25:5 !function=extract_qfpreg
 %qfp_rs1    14:5 !function=extract_qfpreg
@@ -80,6 +81,11 @@ CALL    01 i:s30
 @q_d2       .. ..... ...... ..... . ........ .....         \
             &r_r rd=%qfp_rd rs=%dfp_rs2
 
+&r_r_r_r    rd rs1 rs2 rs3
+@r_r_r_r    .. rd:5  ...... rs1:5 rs3:5 .... rs2:5         &r_r_r_r
+@d_d_d_d    .. ..... ...... ..... ..... .... .....         \
+            &r_r_r_r rd=%dfp_rd rs1=%dfp_rs1 rs2=%dfp_rs2 rs3=%dfp_rs3
+
 {
   [
     STBAR           10 00000 101000 01111 0 0000000000000
@@ -394,7 +400,8 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPACK32     10 ..... 110110 ..... 0 0011 1010 .....    @d_d_d
     FPACK16     10 ..... 110110 00000 0 0011 1011 .....    @r_d2
     FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @r_d2
-    PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @d_d_d
+    PDIST       10 ..... 110110 ..... 0 0011 1110 .....    \
+                &r_r_r_r rd=%dfp_rd rs1=%dfp_rd rs2=%dfp_rs1 rs3=%dfp_rs2
 
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @d_d_d
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
@@ -448,7 +455,19 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
 
-NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
+{
+  [
+    FMADDs      10 ..... 110111 ..... ..... 0001 .....     @r_r_r_r
+    FMADDd      10 ..... 110111 ..... ..... 0010 .....     @d_d_d_d
+    FMSUBs      10 ..... 110111 ..... ..... 0101 .....     @r_r_r_r
+    FMSUBd      10 ..... 110111 ..... ..... 0110 .....     @d_d_d_d
+    FNMSUBs     10 ..... 110111 ..... ..... 1001 .....     @r_r_r_r
+    FNMSUBd     10 ..... 110111 ..... ..... 1010 .....     @d_d_d_d
+    FNMADDs     10 ..... 110111 ..... ..... 1101 .....     @r_r_r_r
+    FNMADDd     10 ..... 110111 ..... ..... 1110 .....     @d_d_d_d
+  ]
+  NCP           10 ----- 110111 ----- --------- -----      # v8 CPop2
+}
 
 ##
 ## Major Opcode 11 -- load and store instructions
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1e1511ff2..6a1457346a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1003,6 +1003,7 @@ static uint32_t get_elf_hwcap(void)
     r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
     r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
     r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
+    r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
 #endif
 
     return r;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 5be1592e66..ed9238a69d 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -549,6 +549,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_HYPV] = "hypv",
     [CPU_FEATURE_BIT_VIS1] = "vis1",
     [CPU_FEATURE_BIT_VIS2] = "vis2",
+    [CPU_FEATURE_BIT_FMAF] = "fmaf",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -877,6 +878,8 @@ static Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_VIS1, false),
     DEFINE_PROP_BIT("vis2",     SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_VIS2, false),
+    DEFINE_PROP_BIT("fmaf",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FMAF, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 1205a599ef..1de44d79c1 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -343,6 +343,22 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
     return f128_ret(ret);
 }
 
+float32 helper_fmadds(CPUSPARCState *env, float32 s1,
+                      float32 s2, float32 s3, uint32_t op)
+{
+    float32 ret = float32_muladd(s1, s2, s3, op, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float64 helper_fmaddd(CPUSPARCState *env, float64 s1,
+                      float64 s2, float64 s3, uint32_t op)
+{
+    float64 ret = float64_muladd(s1, s2, s3, op, &env->fp_status);
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
 static uint32_t finish_fcmp(CPUSPARCState *env, FloatRelation r, uintptr_t ra)
 {
     check_ieee_exceptions(env, ra);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7c290293ea..5efd09f4f4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -28,6 +28,7 @@
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
 #include "exec/log.h"
+#include "fpu/softfloat.h"
 #include "asi.h"
 
 #define HELPER_H "helper.h"
@@ -1142,6 +1143,52 @@ static void gen_op_fabsq(TCGv_i128 dst, TCGv_i128 src)
     tcg_gen_concat_i64_i128(dst, l, h);
 }
 
+static void gen_op_fmadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
+{
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(0));
+}
+
+static void gen_op_fmaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
+{
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(0));
+}
+
+static void gen_op_fmsubs(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
+{
+    int op = float_muladd_negate_c;
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+}
+
+static void gen_op_fmsubd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
+{
+    int op = float_muladd_negate_c;
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+}
+
+static void gen_op_fnmsubs(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
+{
+    int op = float_muladd_negate_c | float_muladd_negate_result;
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+}
+
+static void gen_op_fnmsubd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
+{
+    int op = float_muladd_negate_c | float_muladd_negate_result;
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+}
+
+static void gen_op_fnmadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
+{
+    int op = float_muladd_negate_result;
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+}
+
+static void gen_op_fnmaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
+{
+    int op = float_muladd_negate_result;
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+}
+
 static void gen_op_fpexception_im(DisasContext *dc, int ftt)
 {
     /*
@@ -2136,6 +2183,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_MUL(C)     true
 # define avail_POWERDOWN(C) false
 # define avail_64(C)      true
+# define avail_FMAF(C)    ((C)->def->features & CPU_FEATURE_FMAF)
 # define avail_GL(C)      ((C)->def->features & CPU_FEATURE_GL)
 # define avail_HYPV(C)    ((C)->def->features & CPU_FEATURE_HYPV)
 # define avail_VIS1(C)    ((C)->def->features & CPU_FEATURE_VIS1)
@@ -2148,6 +2196,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_MUL(C)     ((C)->def->features & CPU_FEATURE_MUL)
 # define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
 # define avail_64(C)      false
+# define avail_FMAF(C)    false
 # define avail_GL(C)      false
 # define avail_HYPV(C)    false
 # define avail_VIS1(C)    false
@@ -4785,25 +4834,52 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
     return advance_pc(dc);
 }
 
-static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
+static bool do_ffff(DisasContext *dc, arg_r_r_r_r *a,
+                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 dst, src1, src2, src3;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    src3 = gen_load_fpr_F(dc, a->rs3);
+    dst = tcg_temp_new_i32();
+    func(dst, src1, src2, src3);
+    gen_store_fpr_F(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FMADDs, FMAF, do_ffff, a, gen_op_fmadds)
+TRANS(FMSUBs, FMAF, do_ffff, a, gen_op_fmsubs)
+TRANS(FNMSUBs, FMAF, do_ffff, a, gen_op_fnmsubs)
+TRANS(FNMADDs, FMAF, do_ffff, a, gen_op_fnmadds)
+
+static bool do_dddd(DisasContext *dc, arg_r_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
-    TCGv_i64 dst, src0, src1, src2;
+    TCGv_i64 dst, src1, src2, src3;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
 
     dst  = tcg_temp_new_i64();
-    src0 = gen_load_fpr_D(dc, a->rd);
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
-    func(dst, src0, src1, src2);
+    src3 = gen_load_fpr_D(dc, a->rs3);
+    func(dst, src1, src2, src3);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
 }
 
 TRANS(PDIST, VIS1, do_dddd, a, gen_helper_pdist)
+TRANS(FMADDd, FMAF, do_dddd, a, gen_op_fmaddd)
+TRANS(FMSUBd, FMAF, do_dddd, a, gen_op_fmsubd)
+TRANS(FNMSUBd, FMAF, do_dddd, a, gen_op_fnmsubd)
+TRANS(FNMADDd, FMAF, do_dddd, a, gen_op_fnmaddd)
 
 static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i128, TCGv_env, TCGv_i128, TCGv_i128))
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index f573014532..8f3b97d9bf 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -447,6 +447,17 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     } else {
         return 1;
     }
+#elif defined(TARGET_SPARC)
+    /* Prefer SNaN over QNaN, order B then A. */
+    if (is_snan(b_cls)) {
+        return 1;
+    } else if (is_snan(a_cls)) {
+        return 0;
+    } else if (is_qnan(b_cls)) {
+        return 1;
+    } else {
+        return 0;
+    }
 #elif defined(TARGET_XTENSA)
     /*
      * Xtensa has two NaN propagation modes.
@@ -624,6 +635,26 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         float_raise(float_flag_invalid | float_flag_invalid_imz, status);
     }
     return 3; /* default NaN */
+#elif defined(TARGET_SPARC)
+    /* For (inf,0,nan) return c. */
+    if (infzero) {
+        float_raise(float_flag_invalid | float_flag_invalid_imz, status);
+        return 2;
+    }
+    /* Prefer SNaN over QNaN, order C, B, A. */
+    if (is_snan(c_cls)) {
+        return 2;
+    } else if (is_snan(b_cls)) {
+        return 1;
+    } else if (is_snan(a_cls)) {
+        return 0;
+    } else if (is_qnan(c_cls)) {
+        return 2;
+    } else if (is_qnan(b_cls)) {
+        return 1;
+    } else {
+        return 0;
+    }
 #elif defined(TARGET_XTENSA)
     /*
      * For Xtensa, the (inf,zero,nan) case sets InvalidOp and returns
-- 
2.34.1


