Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB641CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChSH-00061e-0u; Fri, 02 Oct 2026 13:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChQT-0004Ke-7L
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:52:06 -0400
Received: from mail-dl2-x0d.google.com ([2607:f8b0:4864:38::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChQP-0007TD-F2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:52:04 -0400
Received: by mail-dl2-x0d.google.com with SMTP id
 a92af1059eb24-148b5c829e8so6498136c88.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963520; x=1791568320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y/3BzewNHHqU34EleAU1q6MHo4NgKn6+G6D1GFCx46I=;
 b=IBzgNP/n57TiHf1rc7QhfcafTlQlny5MRPMI61AiGOZr9YeOXDif9f65f19rZd6SNj
 i8zk3VsSg8TIRD6ATit3D715/OApLTl8g9uFUnOR4ZVsRxR0pmoX+pizi8MNHjz3FUl8
 XPp2PQ9/k4i/xPFIzD/jGVMw4pJ/OyNWSBe++ucRW/KASv+FUOWDUL0qZ+mryfEcceqP
 C3S2xknrpmwlZ708JFltW2px7bMHFjYuQBfgH6ne07QBGpRnk+J3vwbj2qL+Cj5s8TVA
 pmuJ/5/sVNAWpNAvNVt1Tgma897or3AZnybPldQpruKGqiIYiaGBQDiwBMnoHW9jz5GG
 OydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963520; x=1791568320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y/3BzewNHHqU34EleAU1q6MHo4NgKn6+G6D1GFCx46I=;
 b=z1inCpooBYcjr9uC4eootHoKhrX5LdYT3hnuQ/HorIThbvGL96FQ2p9TxCY/269/U1
 zsKUZ209O2okrfBxiFL0B3mZR8oQNDgIIvW2eslpl4wSlvkXeq7ggLRZEAyp8JM0rzWf
 Wr8yvT2OVaxdozaqeDx/vCmRURf6UBu5bwA65ZCh3vzErRUETvBwAefdAiRMJqcs2m97
 fmhDhVo1niL16g5kvBkoTN7DfsGl9pQ0zMju9W60dKtLitB468dBrgcS+HJCULX3lsn2
 GnPg81XC2vFEyMe7IUiu7UqOK2GBwkLoNNNrMR0pNK4lry+gMZ6Gvpp4f19kxqZXfCTB
 jC2Q==
X-Gm-Message-State: AFuF++nnbsNe9SxS/neow0iWWTxU6HW0aS8RJP24dRN6aKx1+pWkCQ6u
 gWwPFRjJDp2CBsdB1Y+YolNomMzdpaStENtFH8Hcbv0Xcg8iuzju/DcD2zbUXrq6V1U=
X-Gm-Gg: AYBFou2JXoq9cID3pTEfTSlhc417lWwpRB5zyy5FTy5M2fF8ui1hK/XTasEceTs7hPp
 vZYimhQTqMTQXbwHxBovlZCgFyWKbE4hSUtzeutyU4teqO8bwEZJM5WJE7OBFLPUJcw1tqrQ80M
 jkTJAWolQX6zZRnXffYIB8gTEc60tZZzmnXomqDenw7L07NDwSRrd5Gf0SJylBWQddL1+o4GDzI
 ZlJ7jpgM+1wIEse2ddUZFEFwci2+XMKZBrHtmqVR9D4QsQyv8Ad9FXW3Mg5GjWFJLEfqXvk8ait
 7gHohBB7FGTRSsojV2Mr3L2Qgv2ZVbjvojGBtlm7B14d+eXmyaxvhXSrXelhqr2R8Y81SSSk2cQ
 pqAZGCnnh3O4229bRPVHahuVEh2zMtIdm4ZOLhZYWyaz1C90iML3cybfU9kpQll1quKJ9hX/RWH
 i9gwlstQZY+Ef8psnFXdeBsQUWO2PbeBq2B0MqqDRgBBYSoy9VlTPO75wyF4m0tvwzzcAjb/rZK
 kBrobOTFz87vIjkqpDoK4oLP07u2PQ=
X-Received: by 2002:a05:7022:eb47:20b0:14d:baf5:c419 with SMTP id
 a92af1059eb24-14f58de5556mr3709348c88.6.1790963520018; 
 Fri, 02 Oct 2026 10:52:00 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:51:59 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 09/27] target/rx: convert raises to raise_excp
Date: Sat,  3 Oct 2026 01:50:17 +0800
Message-ID: <20261002175037.1747-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Translate privilege and illegal instructions through the shared exception
helpers, and use them for BRK, INT, FPSW, and WAIT paths where applicable.
Remove the redundant RX exception helpers.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/rx/helper.h    |  4 ----
 target/rx/op_helper.c | 39 ++-------------------------------------
 target/rx/translate.c |  9 ++++++---
 3 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index f3897ce7619..c6a85e968d9 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -1,8 +1,4 @@
-DEF_HELPER_1(raise_illegal_instruction, noreturn, env)
-DEF_HELPER_1(raise_access_fault, noreturn, env)
-DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
-DEF_HELPER_2(trap, noreturn, env, i32)
 DEF_HELPER_3(fadd, f32, env, f32, f32)
 DEF_HELPER_3(fsub, f32, env, f32, f32)
 DEF_HELPER_3(fmul, f32, env, f32, f32)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index d4e9ac2f192..ccd20c43a62 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -25,10 +25,6 @@
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
 
-static inline G_NORETURN
-void raise_exception(CPURXState *env, int index,
-                     uintptr_t retaddr);
-
 static void _set_psw(CPURXState *env, uint32_t psw, uint32_t rte)
 {
     uint32_t prev_u;
@@ -115,7 +111,7 @@ static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
         enable = FIELD_EX32(env->fpsw, FPSW, ENABLE);
         enable |= 1 << 5; /* CE always enabled */
         if (cause & enable) {
-            raise_exception(env, RX_EXCP_ACCESS, retaddr);
+            cpu_raise_excp_restore(env_cpu(env), RX_EXCP_ACCESS, retaddr);
         }
     }
 }
@@ -419,32 +415,6 @@ uint32_t helper_divu(CPURXState *env, uint32_t num, uint32_t den)
     return ret;
 }
 
-/* exception */
-static inline G_NORETURN
-void raise_exception(CPURXState *env, int index,
-                     uintptr_t retaddr)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = index;
-    cpu_loop_exit_restore(cs, retaddr);
-}
-
-G_NORETURN void helper_raise_privilege_violation(CPURXState *env)
-{
-    raise_exception(env, RX_EXCP_PRIVILEGE_VIOLATION, GETPC());
-}
-
-G_NORETURN void helper_raise_access_fault(CPURXState *env)
-{
-    raise_exception(env, RX_EXCP_ACCESS, GETPC());
-}
-
-G_NORETURN void helper_raise_illegal_instruction(CPURXState *env)
-{
-    raise_exception(env, RX_EXCP_ILLEGAL_INSTRUCTION, GETPC());
-}
-
 G_NORETURN void helper_wait(CPURXState *env)
 {
     CPUState *cs = env_cpu(env);
@@ -452,10 +422,5 @@ G_NORETURN void helper_wait(CPURXState *env)
     cs->halted = 1;
     env->in_sleep = 1;
     env->psw_i = 1;
-    raise_exception(env, EXCP_HLT, 0);
-}
-
-G_NORETURN void helper_trap(CPURXState *env, uint32_t vec)
-{
-    raise_exception(env, RX_EXCP_TRAP_BASE + vec, 0);
+    cpu_raise_excp(env_cpu(env), EXCP_HLT);
 }
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 1bacc7adf92..e6541ad0ab8 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -245,7 +245,8 @@ static int is_privileged(DisasContext *ctx, int is_exception)
 {
     if (FIELD_EX32(ctx->tb_flags, PSW, PM)) {
         if (is_exception) {
-            gen_helper_raise_privilege_violation(tcg_env);
+            gen_helper_raise_excp_restore(
+                tcg_env, tcg_constant_i32(RX_EXCP_PRIVILEGE_VIOLATION));
         }
         return 0;
     } else {
@@ -2173,7 +2174,8 @@ static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
 static bool do_trap(DisasContext *ctx, uint8_t vec)
 {
     tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_trap(tcg_env, tcg_constant_i32(vec));
+    gen_helper_raise_excp(
+        tcg_env, tcg_constant_i32(RX_EXCP_TRAP_BASE + vec));
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
@@ -2227,7 +2229,8 @@ static void rx_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     ctx->pc = ctx->base.pc_next;
     insn = decode_load(ctx);
     if (!decode(ctx, insn)) {
-        gen_helper_raise_illegal_instruction(tcg_env);
+        gen_helper_raise_excp_restore(
+            tcg_env, tcg_constant_i32(RX_EXCP_ILLEGAL_INSTRUCTION));
     }
 }
 
-- 
2.52.0.windows.1


