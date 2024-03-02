Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4971C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjb-0002Rj-SO; Sat, 02 Mar 2024 00:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHja-0002RU-2r
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:30 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjX-0007Vi-VK
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:29 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so2315233a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356586; x=1709961386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dr6ncL5iBt4P85Tf/c0iqr6saqm7tCicZhRGl3n5Ps4=;
 b=rCRCG+07vcDI3w2ogE84E0CT7OKOaq/W24COstK56pp7DtqObgj/scbKdNdliduja+
 /T2RdJ4jAWdgKqIJ73IQUgG3uhNZJOo6xCq6ReC+48qElGcme9hpHpg3sTlUAVyk32Kl
 a2Jl3T5W4tAzzbOCvatRARls7v0gLmu4GFu8OHRsf6erzOEsh5epKX24rhoMv3/rC1nW
 kHaXBDvKHYUvtsjoxOMtOQciCb7d6MhpGK6VpJf/tIDaD7p4AGIU9U1qFCFuzoiR7SKV
 QZjjftGhf+lqLfWdhdzuIZ/nW69QwFQ20+kw1LXWkkiUO5EC2V0VV5CyM8roL2ToD8Db
 uTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356586; x=1709961386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dr6ncL5iBt4P85Tf/c0iqr6saqm7tCicZhRGl3n5Ps4=;
 b=bSKia7TEN7SvBKWztIWiuUVx+jFaJRdErw4AnAHlA2wcDULFp3rEqDeoydv4Q1W7PW
 VbFsONRbD3s3alrluuXUeLCRzm4gU87VTAD4pAzz3nK9nV5nM8X0NBN81Fdbiq496MRP
 ObCN2tE5G+modtnJcUgs3VwTG+RNKgffQfqt2EUFDztTFExmH/gHZV6C8VEWXQnBwj7t
 rvaDUGiu1WG/3qsd/wqgTYS1e0epg0UfTS/P4tRQ54p6scy/l3Vn14QI+O9x8TaKk/86
 Wva9jtc6ESTHp/fBS1HTlN4dBsM189P0oMT1baFCcxYl+OEEKtYFN5NKGXK1R9NLodnu
 CZXg==
X-Gm-Message-State: AOJu0YzABDidu0Kt9PFwCpklwXmWcEJ8IENgDR9cQuUR2KjahvssLqK+
 dxWH2bfzrGmtjiqc2LP2vm8K979+b3EuCMMv7YrGeOeldvvSnRms5T6yinCJyA9rFZEr8hUh9tw
 4
X-Google-Smtp-Source: AGHT+IGjVkgRkTeAq2nLQK8v5mjrQd4sL8T2ICAw9Jch2cVvvfwkzxt9TilbBqlnQ4Or7G3ujmgp1g==
X-Received: by 2002:a05:6a21:3989:b0:1a1:4491:7ff6 with SMTP id
 ad9-20020a056a21398900b001a144917ff6mr2332008pzc.41.1709356586294; 
 Fri, 01 Mar 2024 21:16:26 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 12/41] target/sparc: Implement FMAf extension
Date: Fri,  1 Mar 2024 19:15:32 -1000
Message-Id: <20240302051601.53649-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
be re-used for FMADDd etc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h          |  2 +
 linux-user/elfload.c           |  1 +
 target/sparc/cpu.c             |  3 ++
 target/sparc/fop_helper.c      | 16 +++++++
 target/sparc/translate.c       | 84 ++++++++++++++++++++++++++++++++--
 target/sparc/cpu-feature.h.inc |  1 +
 target/sparc/insns.decode      | 23 +++++++++-
 7 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index f0576fb748..63ae398841 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -53,6 +53,7 @@ DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdivd, TCG_CALL_NO_WG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_5(fmaddd, TCG_CALL_NO_WG, f64, env, f64, f64, f64, i32)
 
 DEF_HELPER_FLAGS_3(faddq, TCG_CALL_NO_WG, i128, env, i128, i128)
 DEF_HELPER_FLAGS_3(fsubq, TCG_CALL_NO_WG, i128, env, i128, i128)
@@ -63,6 +64,7 @@ DEF_HELPER_FLAGS_3(fadds, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fsubs, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_WG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_5(fmadds, TCG_CALL_NO_WG, f32, env, f32, f32, f32, i32)
 
 DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_WG, f64, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_WG, i128, env, f64, f64)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6041270f1c..5ebf2bf789 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -997,6 +997,7 @@ static uint32_t get_elf_hwcap(void)
     r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
     r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
     r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
+    r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
 #endif
 
     return r;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 313ebc4c11..491e627899 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -551,6 +551,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_HYPV] = "hypv",
     [CPU_FEATURE_BIT_VIS1] = "vis1",
     [CPU_FEATURE_BIT_VIS2] = "vis2",
+    [CPU_FEATURE_BIT_FMAF] = "fmaf",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -873,6 +874,8 @@ static Property sparc_cpu_properties[] = {
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
index ee3da73551..1178fca9e3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -29,6 +29,7 @@
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
 #include "exec/log.h"
+#include "fpu/softfloat.h"
 #include "asi.h"
 
 #define HELPER_H "helper.h"
@@ -1151,6 +1152,52 @@ static void gen_op_fabsq(TCGv_i128 dst, TCGv_i128 src)
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
@@ -2093,6 +2140,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_MUL(C)     true
 # define avail_POWERDOWN(C) false
 # define avail_64(C)      true
+# define avail_FMAF(C)    ((C)->def->features & CPU_FEATURE_FMAF)
 # define avail_GL(C)      ((C)->def->features & CPU_FEATURE_GL)
 # define avail_HYPV(C)    ((C)->def->features & CPU_FEATURE_HYPV)
 # define avail_VIS1(C)    ((C)->def->features & CPU_FEATURE_VIS1)
@@ -2105,6 +2153,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_MUL(C)     ((C)->def->features & CPU_FEATURE_MUL)
 # define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
 # define avail_64(C)      false
+# define avail_FMAF(C)    false
 # define avail_GL(C)      false
 # define avail_HYPV(C)    false
 # define avail_VIS1(C)    false
@@ -4762,25 +4811,52 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
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
index 2c23868fc3..6d5fa26e90 100644
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
     FPACK16     10 ..... 110110 00000 0 0011 1011 .....    @d_d2
     FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @d_d2
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
-- 
2.34.1


