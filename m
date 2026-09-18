Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F474C982D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Mje-0003WW-E8; Thu, 17 Sep 2026 20:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MjH-0002lt-Ua
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:45:31 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MjE-0002Ds-Sf
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:45:27 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso82180a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692323; x=1790297123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NrQIUA3qVWc3UzVqMPKyQYCjhQglonry7BmmQzXtFkQ=;
 b=XfAfbCByKglJQJN6Q+NvY69t3lZ5av7p+63Ihimc6i06XEzC+8qVy2B3OI7LLI8m/U
 frXc8KO/d7YxPZ5U2RwdjzXgXT59VyiQpKzdDlh4AsCgF3WOQ7jKLREJeC0HoKWEAJ/L
 YikgwavEMRJnFEblKP7B+gFgNteuW3j8RXEQN1ev/8Qc1Rj7G+Njp4NFNs56Fr2ZUIfw
 GF2cND4Win2FAWTnD+ufl4kL6dVsqb6AzNXaulvm/L5FXiJ4pkgCN/e00rgHf5L+u4Kq
 NBziu32qchYMpBAF6PkWkrLTCIwDUR2nW11m1ePrHOt2V1VJONEX/mg3G4+Sw6O+6rnK
 3b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692323; x=1790297123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NrQIUA3qVWc3UzVqMPKyQYCjhQglonry7BmmQzXtFkQ=;
 b=mT/xpha3J8sSmfVnxxFegvG3D1LIse6lDpI69pg5WLTRG10VJNKOgSQ41Fpcd0Nt+W
 bOXgjRgiNgINW7GpWjHhlgmiyrSCtiOjxSCKTbTqT6SkItTItnzbGHgXuSur2yr838o1
 A+2aIV4G0vUTQtYMyP4dk4sH35g+s2wfTXChvtyZWMYuRgYGkUazbl+k77Nn5CUT4xT3
 CsDagsyq8f1LAtilE2Nql1AHpTtZvkLvL+VQkYC679amNadGGIhLWXePXeOFnB/4Iqa9
 5zxuyppv1Lm65ZAZ6BuN37rjZMKg9xxZ2AwA/4sTq8rKLrQ/kWq+TTiWJ1t1vn8tU6cd
 aPRw==
X-Gm-Message-State: AFuF++mpjtaKRiO5vvqpVNKP5DALhKnPRim/gU3PdhGMalnoizwODdQF
 ZDr72/sKBbXvdKY4X5FUw3zjtEvAC8v3vntY688hFXI8K4FXO0gY+gK2JiF1N5XdsmU=
X-Gm-Gg: AYBFou1ekcrPnd3fLm8ADybHTIzBsiEULqOFDl6y6Zhewf/MzcDoZy7ZbHQHbHFZrbx
 aafSP1HdgHeCk/yIH67pJWLEeu0r60uzuoNSscN08hZUULdMtW6ukvHtpLxhXxbXj99UKV72scv
 webFIf7a2NGUYIbQb2aC4dfmb024ex7pw5xfzV0O/T17/frJizfvsiWj5mX35vHaM8uChMX/RK3
 ZWG35QKT+AexW12k5aNgPCpnfhuCp87ACMTn5Sp7cUCvDxVt9sJgY8KBiqRq81KfuMMxRfJiJ6H
 wgeyGY40T2IDNEu3esgjvalKxJMenaILxmm/1FmUoEzbeTZyx/ejlmvpThhDOYgUKloeOcErNRB
 iG55aF+GYWCWE1KLk13xkv9j3jYyxHxFrRtnz2DDEQ6PRea5/7Lk4LoOBjIG0N38PMEBN++4oGQ
 6REiel0HnRanXntJCsnFiSJ0Mo9dF9ovSjsQbeoTwoXarfWU/h35sHPSlc//DQ1vGu+NZx1xXHg
 IO67agTFLUmFFp8p0Z0Ov13MVE4voOQ
X-Received: by 2002:a17:90b:5545:b0:39d:e54c:8643 with SMTP id
 98e67ed59e1d1-39e54d13929mr1833242a91.11.1789692323308; 
 Thu, 17 Sep 2026 17:45:23 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:45:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Nicholas Piggin <npiggin@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 19/21] target/mips: convert raise_exception to raise_excp
Date: Fri, 18 Sep 2026 08:42:21 +0800
Message-ID: <20260918004225.827-20-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Store error_code then call raise_excp, with restore 0 for _err and
1 for the 2-arg path. Drop TCG raise_exception, raise_exception_err,
and unused debug DEF. Prefix leftover TCG wait to mips_wait. Keep C
do_raise_exception_err via cpu_loop_exit_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/mips/helper.h         |  6 +-----
 target/mips/tcg/exception.c  | 22 ++--------------------
 target/mips/tcg/fpu_helper.c |  6 +++---
 target/mips/tcg/translate.c  | 13 +++++++++----
 4 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 779b87101db..eed9dee96e5 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -1,7 +1,3 @@
-DEF_HELPER_3(raise_exception_err, noreturn, env, i32, int)
-DEF_HELPER_2(raise_exception, noreturn, env, i32)
-DEF_HELPER_1(raise_exception_debug, noreturn, env)
-
 #ifdef TARGET_MIPS64
 DEF_HELPER_4(sdl, void, env, tl, tl, int)
 DEF_HELPER_4(sdr, void, env, tl, tl, int)
@@ -250,7 +246,7 @@ DEF_HELPER_1(rdhwr_xnp, tl, env)
 DEF_HELPER_1(rdhwr_chord, tl, env)
 DEF_HELPER_1(rdhwr_cvmcount, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
-DEF_HELPER_1(wait, void, env)
+DEF_HELPER_1(mips_wait, void, env)
 
 #ifdef TARGET_MIPS64
 DEF_HELPER_FLAGS_2(lcsr_cpucfg, TCG_CALL_NO_RWG_SE, tl, env, tl)
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 630b8b809fa..788d60a51aa 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -44,28 +44,12 @@ target_ulong exception_resume_pc(CPUMIPSState *env)
     return bad_pc;
 }
 
-void helper_raise_exception_err(CPUMIPSState *env, uint32_t exception,
-                                int error_code)
-{
-    do_raise_exception_err(env, exception, error_code, 0);
-}
-
-void helper_raise_exception(CPUMIPSState *env, uint32_t exception)
-{
-    do_raise_exception(env, exception, GETPC());
-}
-
-void helper_raise_exception_debug(CPUMIPSState *env)
-{
-    do_raise_exception(env, EXCP_DEBUG, 0);
-}
-
 static void raise_exception(CPUMIPSState *env, uint32_t exception)
 {
     do_raise_exception(env, exception, 0);
 }
 
-void helper_wait(CPUMIPSState *env)
+void helper_mips_wait(CPUMIPSState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -145,8 +129,6 @@ void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
     qemu_log_mask(CPU_LOG_INT, "%s: %d (%s) %d\n",
                   __func__, exception, mips_exception_name(exception),
                   error_code);
-    cs->exception_index = exception;
     env->error_code = error_code;
-
-    cpu_loop_exit_restore(cs, pc);
+    cpu_loop_exit_excp(cs, exception, pc);
 }
diff --git a/target/mips/tcg/fpu_helper.c b/target/mips/tcg/fpu_helper.c
index 36af9808025..ce68cda1e43 100644
--- a/target/mips/tcg/fpu_helper.c
+++ b/target/mips/tcg/fpu_helper.c
@@ -61,7 +61,7 @@ target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
             if (env->CP0_Config5 & (1 << CP0C5_UFE)) {
                 arg1 = (env->CP0_Config5 >> CP0C5_FRE) & 1;
             } else {
-                helper_raise_exception(env, EXCP_RI);
+                do_raise_exception(env, EXCP_RI, GETPC());
             }
         }
         break;
@@ -120,7 +120,7 @@ void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
             env->CP0_Config5 &= ~(1 << CP0C5_FRE);
             compute_hflags(env);
         } else {
-            helper_raise_exception(env, EXCP_RI);
+            do_raise_exception(env, EXCP_RI, GETPC());
         }
         break;
     case 6:
@@ -132,7 +132,7 @@ void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
             env->CP0_Config5 |= (1 << CP0C5_FRE);
             compute_hflags(env);
         } else {
-            helper_raise_exception(env, EXCP_RI);
+            do_raise_exception(env, EXCP_RI, GETPC());
         }
         break;
     case 25:
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index e3467d15251..99e56bb1422 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1316,14 +1316,19 @@ static inline void restore_cpu_state(CPUMIPSState *env, DisasContext *ctx)
 void generate_exception_err(DisasContext *ctx, int excp, int err)
 {
     save_cpu_state(ctx, 1);
-    gen_helper_raise_exception_err(tcg_env, tcg_constant_i32(excp),
-                                   tcg_constant_i32(err));
+    tcg_gen_st_i32(tcg_constant_i32(err), tcg_env,
+                   offsetof(CPUMIPSState, error_code));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp),
+                          tcg_constant_i32(0));
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 void generate_exception(DisasContext *ctx, int excp)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
+    tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
+                   offsetof(CPUMIPSState, error_code));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp),
+                          tcg_constant_i32(1));
 }
 
 void generate_exception_end(DisasContext *ctx, int excp)
@@ -8683,7 +8688,7 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
         ctx->base.pc_next += 4;
         save_cpu_state(ctx, 1);
         ctx->base.pc_next -= 4;
-        gen_helper_wait(tcg_env);
+        gen_helper_mips_wait(tcg_env);
         ctx->base.is_jmp = DISAS_NORETURN;
         break;
     default:
-- 
2.52.0.windows.1


