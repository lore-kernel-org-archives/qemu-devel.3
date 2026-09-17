Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD6CC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78UW-00041P-EZ; Thu, 17 Sep 2026 05:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UV-000419-Ac
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:15 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UT-00017K-7Y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:15 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466ccbd478bso244665fac.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637591; x=1790242391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bREQ5N3IuKbFs2BM1kBFR7qM317JshZNy0TYejea1/c=;
 b=XhWeNIf/2CRFQ93CFOOrZidOxi7w8N2Tt1inc13oiZ1M8H5AhT4e8gDQ50400vmXvR
 BlFegCq07XIxdnR/aEZzOdXCffwcpaQD5+7dgUTPyR+nq/UfHYLc8aoMWUw6U6KjXp1B
 u6bJ3Ga51hjAlcBmm2bXGYi+rnBW8VtFtT5+lD8bWxkkdE8mG0EaKDb55UjKNLjyhQfy
 5l2Fxx4tYbio3/5aIvIw6mL577emLZo5pjrnNgeHHrFfFJgF4HsVxSvY9p9L6weP17k+
 4PSLKaLTVy/ADXskw7fx+OcYsZFS+LdEcx+1SH9q1nqLvdLUWaQBDHmpyuQk2f0N6bWU
 bF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637591; x=1790242391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bREQ5N3IuKbFs2BM1kBFR7qM317JshZNy0TYejea1/c=;
 b=Iyu3Rsq2+C3DmG+C50Z40nPe8EzE6A6b7BAlQtuFFbFCHJVTK5KtaaTnR0lOWoQzMR
 4o4DTybt4NZfj3EsL6OwEWMxhe4WbNi69+D9kEr62/jfSghZuNIbukvER/HdpkHnYQgo
 gVVDQTfRTAUSDDEruZ62P369YnhxQWN9IKHbFLEEt6KaQ+Ze0LE31ef2g4aAlRabEtrb
 2JBJAMe3zEWjuYj3vP9s826nHqgEFuEgYKEIrMswazTw6VVcqE6++RjKmKYMYQDRrUe+
 iffI0CmeMB4YAKhuaLWNWJapaqiJZTRxJ9KxUaFwCmEROa8NrJc5X+sqEgFNe+4BwV/U
 7HLg==
X-Gm-Message-State: AFuF++lSEL54CND2htujUF0qCALY2MNKV9w1eK9jCOC7E3PjMX7w/Av/
 gYthdyjHIYhCG9+GhA0HQ2lGVrH09o0WAl7baZSRi7IOOBRPTwvrUW6RG1zqBl01TU0UtjOim5G
 cB5ZB1Uo=
X-Gm-Gg: AYBFou1hULyVHgDccFw3v1Apvlio+mRVPTKvFJDQ4WuOXOvTp9Dx/+pieJs5mX07gnK
 chR8cqjTJcapgZ4NUsS6v4x9yiMrrWJdZ+ftkyKLhkzvM4ILcn7/r9YFJiH3vM2OY8hhiJL62or
 k926C0ZMgAtR1pJXOeu728gOJF1D52+ex/0bBZjEqcKvbF0Sb7vtqSsf1D+KP6JGreFTauTgSip
 PoXofUXvhYPJYzJ8yKvXrwAikvDC0PgumH5gVLl65wrLYXel1bhRyAFwMe+pzwndBM6fVjN/bAD
 jcQbXjxIgb1TdsXdc8RfzcdzYRCoSSFWEz3J9IqbG72LShpWVM4LUasuUWA4pnR5nZGoi/s1ZdM
 1T6NCFrBmDqaMyZR4EFS7IaHL6G1rWWFLjhOPExpAqcGofpAj1DmuOfmj8fxByeDZHQTV6zbIjg
 lmYmXlX5g2sz2uDv5kpPNoDuF4k+zY+yA7RotIFjCtRH4In7XMTdKR2Zi+pumxxspNiVdb2PqfT
 J6HJ+M=
X-Received: by 2002:a05:6820:198f:b0:6c0:7620:fccf with SMTP id
 006d021491bc7-6c7d45e15e3mr2588286eaf.57.1789637591253; 
 Thu, 17 Sep 2026 02:33:11 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 01/13] tcg: add tcg_gen_goto_jc{3}_{i32,i64,tl}
Date: Wed, 16 Sep 2026 23:32:55 -1000
Message-ID: <20260917093307.1092084-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x10.google.com
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

From: Matt Turner <mattst88@gmail.com>

At translation time the caller often already has the destination PC
in a temp and knows the flags, cflags and cs_base any destination it
may reach has to match because they are the same as the ones as the
current block being generated.  But the promise that the flags are
known (or unchanged) is subtle.

So add new entry points with new semantics and --enable-debug-tcg
checks against get_tb_cpu_state() at run time.

Signed-off-by: Matt Turner <mattst88@gmail.com>
[rth: Split out target changes; add jc3 variant; expand via tcg-op-def.h.inc]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  4 +++
 include/tcg/tcg-op-common.h  | 29 +++++++++++++++++++
 include/tcg/tcg-op.h         |  4 +++
 include/tcg/tcg-op-def.h.inc |  2 ++
 accel/tcg/cpu-exec.c         | 27 ++++++++++++++++++
 tcg/tcg-op.c                 | 55 ++++++++++++++++++++++++++++++++----
 6 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 0dda2079fd0..098c2235b5f 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -9,6 +9,10 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
 DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
 
+#ifdef CONFIG_DEBUG_TCG
+DEF_HELPER_FLAGS_4(goto_jc_check, TCG_CALL_NO_WG, void, env, i64, i64, i32)
+#endif
+
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
 #ifndef IN_HELPER_PROTO
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2bcf737aa56..5102f9bb4dd 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -85,6 +85,35 @@ void tcg_gen_goto_tb(unsigned idx);
  */
 void tcg_gen_lookup_and_goto_ptr(void);
 
+/**
+ * tcg_gen_goto_jc3_i32() - dispatch to the destination TB via the jump cache
+ * tcg_gen_goto_jc3_i64() - dispatch to the destination TB via the jump cache
+ * @pc: temp holding the destination guest PC
+ * @cs_base: temp holding the destination guest cs_base
+ * @flags: the destination guest flags
+ *
+ * The contract is that the values provided inline are exactly the
+ * cpu state that would be returned by TCGCPUOps::get_tb_cpu_state.
+ * --enable-debug-tcg checks the contract at runtime.
+ *
+ * Using those values, the lookup may be done inline.
+ *
+ * Actually declared and defined via tcg-op-def.h.inc.
+ */
+
+/**
+ * tcg_gen_goto_jc_i32() - dispatch to the destination TB via the jump cache
+ * tcg_gen_goto_jc_i64() - dispatch to the destination TB via the jump cache
+ * @pc: temp holding the destination guest PC
+ *
+ * Similar, but cs_base and flags are taken from the current TB.
+ *
+ * Thus the contract is that no cpu state changes have occured
+ * that affect the translation block flags.
+ *
+ * Actually declared and defined via tcg-op-def.h.inc.
+ */
+
 void tcg_gen_plugin_cb(unsigned from);
 QEMU_ARG_NONNULL void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index a7d001c959c..02732652b8f 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -175,6 +175,8 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i64
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i64_vec
 #define tcg_gen_dup_tl tcg_gen_dup_i64
+#define tcg_gen_goto_jc_tl tcg_gen_goto_jc_i64
+#define tcg_gen_goto_jc3_tl tcg_gen_goto_jc3_i64
 #define dup_const_tl dup_const
 #else
 #define tcg_gen_movi_tl tcg_gen_movi_i32
@@ -299,6 +301,8 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i32
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i32_vec
 #define tcg_gen_dup_tl tcg_gen_dup_i32
+#define tcg_gen_goto_jc_tl tcg_gen_goto_jc_i32
+#define tcg_gen_goto_jc3_tl tcg_gen_goto_jc3_i32
 
 #define dup_const_tl(VECE, C)                                      \
     (__builtin_constant_p(VECE)                                    \
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b60edca6e42..97024fcb222 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -31,6 +31,8 @@ DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
+DEF1(goto_jc, TCGV)
+DEF3(goto_jc3, TCGV, TCGv_i64, unsigned)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5226cfb7650..1493fe0c963 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -407,6 +407,33 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     return tb->tc.ptr;
 }
 
+#ifdef CONFIG_DEBUG_TCG
+/**
+ * helper_goto_jc_check: check the contract of tcg_gen_goto_jc_*()
+ * @env: current cpu state
+ * @pc: the destination pc the caller passed at translation time
+ * @cs_base: the cs_base the dispatching block was translated with
+ * @flags: the flags the dispatching block was translated with
+ *
+ * A goto_jc looks the destination up on the caller's @pc with the flags and
+ * cs_base of the block doing the dispatching, so all three have to be what
+ * get_tb_cpu_state() reports by the time the dispatch runs.  That is a
+ * property of the translator, not of the generated code, so check it here
+ * rather than leaving a target that gets it wrong to be debugged as a block
+ * running with someone else's flags.
+ */
+void HELPER(goto_jc_check)(CPUArchState *env, uint64_t pc, uint64_t cs_base,
+                           uint32_t flags)
+{
+    CPUState *cpu = env_cpu(env);
+    TCGTBCPUState s = cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
+
+    assert(s.pc == pc);
+    assert(s.flags == flags);
+    assert(s.cs_base == cs_base);
+}
+#endif
+
 /* Return the current PC from CPU, which may be cached in TB. */
 static vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
 {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d271d83a7d2..09d9a7963ae 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -277,6 +277,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
+#define TCGv_i64  TCGTemp *
 #define TCGv_ptr  TCGTemp *
 #define TCGV      TCGTemp *
 #define TINT      int64_t
@@ -286,6 +287,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef TINT
 #undef TCGV
 #undef TCGv_ptr
+#undef TCGv_i64
 
 #undef DEF1
 #undef DEF2
@@ -1940,20 +1942,61 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
 }
 
+static void gen_lookup_tb_ptr_and_goto(void)
+{
+    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
+
+    gen_helper_lookup_tb_ptr(ptr, tcg_env);
+    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+    tcg_temp_free_ptr(ptr);
+}
+
 void tcg_gen_lookup_and_goto_ptr(void)
 {
-    TCGv_ptr ptr;
-
     if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
         tcg_gen_exit_tb(NULL, 0);
         return;
     }
 
     plugin_gen_disable_mem_helpers();
-    ptr = tcg_temp_ebb_new_ptr();
-    gen_helper_lookup_tb_ptr(ptr, tcg_env);
-    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
-    tcg_temp_free_ptr(ptr);
+    gen_lookup_tb_ptr_and_goto();
+}
+
+static void gen_goto_jc3(TCGType type, TCGTemp *pc,
+                         TCGTemp *cs_base, unsigned flags)
+{
+    plugin_gen_disable_mem_helpers();
+
+    /*
+     * Widen @pc to i64 because the jump cache is keyed on a vaddr;
+     * for a 32-bit guest PC that is its zero extension.
+     * Note that cs_base is target-specific, not a vaddr, and always 64-bit.
+     */
+    if (type == TCG_TYPE_I32) {
+        TCGTemp *pc64 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        gen_extu_i32_i64(pc64, pc);
+        pc = pc64;
+    }
+
+#ifdef CONFIG_DEBUG_TCG
+    /*
+     * The caller has asserted that no flags-affecting cpu state changes
+     * happened between this TB and the destination.  Check it.
+     */
+    gen_helper_goto_jc_check(tcg_env, temp_tcgv_i64(pc),
+                             temp_tcgv_i64(cs_base),
+                             tcg_constant_i32(flags));
+#endif
+
+    gen_lookup_tb_ptr_and_goto();
+}
+
+static void gen_goto_jc(TCGType type, TCGTemp *pc)
+{
+    const TranslationBlock *tb = tcg_ctx->gen_tb;
+    TCGTemp *cs_base = tcg_constant_internal(TCG_TYPE_I64, tb->cs_base);
+
+    gen_goto_jc3(type, pc, cs_base, tb->flags);
 }
 
 /*
-- 
2.53.0


