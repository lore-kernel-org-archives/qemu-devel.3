Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25468C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Ul-00048v-IT; Thu, 17 Sep 2026 05:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ug-00046d-8w
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:26 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ub-00018g-Uz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:25 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae736c64so397311eaf.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637600; x=1790242400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FF1abLCI8hOgy/bnmlJrvZZgw7N9jJryEB1UClwJUt8=;
 b=CENMBfCifjf/VrCdn3xVOI75bOi//G/2U6FMxp5OVMjf75keXfo1sVizKlF1Gjr8+w
 1UYlWddR0f+cLdzkMckSw0Tuly0/OrP5svnbBD63B5UAVUdSxBl2NNaUhZjYBBD8R2bd
 IPYzNQArxlNKNOWfd0O1ms10TlQQOGAA/qtmTkRAVodOnOUAwJbWbThU8khfHgO0y3W+
 U665PO1W/Fff9wQu6/Nn8o/zQKBqswE13v0ohV8jST2B+X5+5g1tbJCoD6EC7V9yGXLH
 8G1wfAfHJRNPqY7wpisQ6TOa8xolDbIk0HcUPpxI1ULXuIgQTo0a4A0Jm5FQAwkIlcsf
 ubSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637600; x=1790242400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FF1abLCI8hOgy/bnmlJrvZZgw7N9jJryEB1UClwJUt8=;
 b=L3durpgOb1z9tfYx7AHR8mH1WLFT+FftIXtZHqZr79mR41DzlEpVtb8EtUXakqOFRK
 OunoFG/EWoX+YSlQ6mDvaK1i7yLezUyrsGFrh6Shp0wWCEL2xDmR6CVUtIp+RztI3Pim
 zlB0ti7BY00/WSdEz4vYCNAluruogb1/l002PB6sJXEe4muY8D/9YXt9p2IVCtvucR6p
 mczKA9E6KpxB1tPrjTLDTl1a8/Z94LcrkBTjoYl75YysNe8Je7tK8g6qZam71H3wr0DP
 ZWrx6INCGx16P1+HPRaKqLd/SW0o1blBl/IHQzqxcOw5ltFvbMZPSQV+V047MnOj/UKe
 ysgA==
X-Gm-Message-State: AFuF++l6sZqKu39nNlsrS1O4zISt/eg6spr3tFDOdfBZWpvFvuJRN8nk
 mo9dtzlfa1HdE72po6pYGt3MhvmrwW7cnIiXMWKPlJa3QL7OcBT+e4fUh1eeC8vT2QfTSmym/Pn
 Plem9W1Y=
X-Gm-Gg: AYBFou0ZotLhgvinPZan++A4/XH/5aXc9IU0nBSHBMlP5fx8nJbpY3g0ZPgfTmv7Jnl
 BiWMe47OyNDz4q/3EQxbJFzQd/uM1buzGjzVOpYy94v6WKGNnhnw0kGi+W+H5+cB0u20O92Tx+o
 ZusoJtJkUmYwSfnLw81l+LCzS3VYdRivbL/AuOIU4KrzUO1L5UsotJVGdgMzwbgqEXABOwmu+YF
 eH7OfkJwYZItzbfXIUpm1rIozJwYTcgNcxpLrMh7AE2jGSMzu5QkpDJSaBPX9WadjCgx5qYZHEA
 wW77AAoj/kVpMW+R8JlUb0twn9B4DFtjmmoWymSn8hroW3TJ0nEBbNsSwlRateSZmm06UGOB3vz
 uqH6PD8Nqy3vsEBnUU8cYhn9FNI1Z295RD2yp8tuERzwiPKBpgKofFfXW15XYW7WbH617OLQn+H
 c9NWlVAuvzbuGDcwc5j2MIDy4AZMMEHrCnEnyFwPselQApxcT1U+nibC+Fnd7O60HAqUKpupSdy
 8fyQbc=
X-Received: by 2002:a05:6820:1c9d:b0:6bd:850:7634 with SMTP id
 006d021491bc7-6c7d0de78e1mr5330193eaf.26.1789637600213; 
 Thu, 17 Sep 2026 02:33:20 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 09/13] tcg: Probe the TB jump cache inline instead of
 calling a helper
Date: Wed, 16 Sep 2026 23:33:03 -1000
Message-ID: <20260917093307.1092084-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Every indirect branch that cannot use goto_tb ends in a dispatch that calls
helper_lookup_tb_ptr(). For an emulated compiler that is 8.4 billion helper
calls in a single translation unit: 24.6% of all TB exits take this path,
because jsr/ret/jmp have a register destination and because goto_tb is
restricted to same-page targets.

The helper itself is already tight, but each call pays for a call frame,
the can_do_io store, the get_tb_cpu_state() indirect call through
TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
jump cache probe that almost always hits (95.8% for this workload).

Emit the probe inline instead, for the callers that have migrated to
tcg_gen_goto_jc_*(). Those supply what it needs: the destination PC is in a
TCG temp, and the flags, cflags and cs_base the destination must match are
constants at translation time. The fast path is therefore a hash, four
guarded loads and a goto_ptr. Only a miss calls the helper, which still owns
filling the cache.

Two details matter for the generated code. The flags and cflags guards are
folded into a single aligned 64-bit load and compare, since the fields are
adjacent. And each path emits its own goto_ptr rather than branching to a
shared one: a temp live across the label is spilled and reloaded on every
dispatch, which cost 6.3% on its own.

The flags and cflags constants are safe against the other things that can
change them. CF_PARALLEL is only ever set by begin_parallel_context(),
which flushes first, so no block predating it survives to dispatch. gdb
single-step is only turned on with the CPU stopped, and a block translated
without CF_SINGLE_STEP can only be re-entered through tb_lookup(), which
from then on demands the new cflags -- so a stale-cflags block is never the
one running. Breakpoints are handled by CF_NO_GOTO_JC, added by the previous
patch: while one is set, blocks are translated with a cflags that both keeps
them off the inline path and keeps them unreachable from blocks already on
it. What is left is one_insn_per_tb and -d nochain; see below.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO
build, on top of the preceding patches:

    before: 1,402,667,803,616 instructions
    after:    916,415,123,244 instructions   -34.67%

    before: 115.56s wall clock
    after:   85.59s wall clock               -25.94%

The gap between the two is the point at which this stops being a
straight-line win: the helper call was highly predictable work that the
host pipelined well, so removing it retires far fewer instructions than it
saves time. IPC falls from 2.48 to 2.17 across this patch for that reason.

Despite emitting more code, this also reduces instruction cache pressure,
because a dispatch no longer jumps into qemu's .text and evicts translated
code:

    before: 11,735,141,703 L1-icache-load-misses
    after:   7,154,863,292 L1-icache-load-misses   -39.0%

The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
falls from 31.01% of samples to 0.35%, and qemu's own .text falls from
38.8% to 5.3%, with the balance moving into generated code.

Combined with the preceding patches, against an unmodified LTO build,
1,646,994,254,249 instructions fall to 916,415,123,244, or -44.36%. The
emulated compiler produces byte-identical output throughout.

A follow-up worth having: the probe is emitted entirely out of generic TCG
ops, and several backends can do much better than the result. x86_64 and
s390x have memory-operand comparisons; aarch64 can form env + off + h * 16
with a shift-add, load (tb, pc) and (cs_base, flags) with two ldp, and halve
the branches with ccmp. That wants a backend expansion of a dedicated
opcode, which is a separate series.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260901034808.3524945-7-mattst88@gmail.com>
---
 tcg/tcg-op.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 09d9a7963ae..cd10a00bf9e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -28,6 +28,8 @@
 #include "tcg/tcg-op-common.h"
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
+#include "hw/core/cpu.h"
+#include "../accel/tcg/tb-hash.h"
 #include "tcg-internal.h"
 #include "tcg-has.h"
 
@@ -1942,12 +1944,17 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
 }
 
+static void gen_goto_ptr(TCGTemp *ptr)
+{
+    tcg_gen_op1(INDEX_op_goto_ptr, TCG_TYPE_PTR, temp_arg(ptr));
+}
+
 static void gen_lookup_tb_ptr_and_goto(void)
 {
     TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
 
     gen_helper_lookup_tb_ptr(ptr, tcg_env);
-    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+    gen_goto_ptr(tcgv_ptr_temp(ptr));
     tcg_temp_free_ptr(ptr);
 }
 
@@ -1962,6 +1969,96 @@ void tcg_gen_lookup_and_goto_ptr(void)
     gen_lookup_tb_ptr_and_goto();
 }
 
+static void gen_jc_hash(TCGTemp *h, TCGTemp *t, TCGTemp *pc)
+{
+#ifdef CONFIG_SOFTMMU
+    /*
+     * tb_jmp_cache_hash_func(), softmmu form.  TARGET_PAGE_BITS is a load
+     * from target_page in this translation unit, but it is decided long
+     * before any translation happens, so it is a constant here.
+     */
+    int shift = TARGET_PAGE_BITS - TB_JMP_PAGE_BITS;
+
+    gen_shri(TCG_TYPE_I64, t, pc, shift);
+    gen_xor(TCG_TYPE_I64, t, t, pc);
+    gen_shri(TCG_TYPE_I64, h, t, shift);
+    gen_andi(TCG_TYPE_I64, h, h, TB_JMP_PAGE_MASK);
+    gen_andi(TCG_TYPE_I64, t, t, TB_JMP_ADDR_MASK);
+    gen_or(TCG_TYPE_I64, h, h, t);
+#else
+    /* tb_jmp_cache_hash_func(), user-only form. */
+    gen_shri(TCG_TYPE_I64, h, pc, TB_JMP_CACHE_BITS);
+    gen_xor(TCG_TYPE_I64, h, h, pc);
+    gen_andi(TCG_TYPE_I64, h, h, TB_JMP_CACHE_SIZE - 1);
+#endif
+}
+
+static void gen_jc_probe(TCGTemp *pc, TCGTemp *cs_base, uint32_t flags)
+{
+    const TranslationBlock *tb = tcg_ctx->gen_tb;
+    TCGLabel *slow = gen_new_label();
+    uint64_t fpair;
+
+    QEMU_BUILD_BUG_ON(sizeof_field(CPUJumpCache, array[0]) != 16);
+    QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) % 8 != 0);
+    /* One 64-bit load has to cover both, so they must be adjacent... */
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, cflags) !=
+                      offsetof(TranslationBlock, flags) + 4);
+    /* ...and aligned, which nothing else currently relies on. */
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, flags) % 8 != 0);
+
+    {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(TCG_TYPE_I64);
+        g_autoptr(TCGTemp) h = tcg_temp_new_ebb(TCG_TYPE_I64);
+        g_autoptr(TCGTemp) p = tcg_temp_new_ebb(TCG_TYPE_PTR);
+
+        /* p = &jc->array[tb_jmp_cache_hash_func(pc)] */
+        gen_jc_hash(h, t, pc);
+        gen_op_tti(INDEX_op_ld, TCG_TYPE_I64, t, tcgv_ptr_temp(tcg_env),
+                   offsetof(CPUState, tb_jmp_cache) - sizeof(CPUState));
+        gen_lea(TCG_TYPE_I64, p, t, h, 4, 0);
+
+        /*
+         * The pc first: on a hash miss it is the field most likely to differ,
+         * and an entry whose tb is NULL has a zero pc that only pc 0 matches.
+         */
+        gen_ld(TCG_TYPE_I64, t, p, offsetof(CPUJumpCache, array[0].pc));
+        gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, pc, slow);
+
+        gen_ld(TCG_TYPE_PTR, p, p, offsetof(CPUJumpCache, array[0].tb));
+        gen_brcond(TCG_TYPE_PTR, TCG_COND_EQ,
+                   p, tcg_constant_internal(TCG_TYPE_PTR, 0), slow);
+
+        /*
+         * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
+         * and compare covers both.
+         */
+        fpair = (HOST_BIG_ENDIAN
+                 ? deposit64(tb->cflags, 32, 32, flags)
+                 : deposit64(flags, 32, 32, tb->cflags));
+        gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, flags));
+        gen_brcond(TCG_TYPE_I64, TCG_COND_NE,
+                   t, tcg_constant_internal(TCG_TYPE_I64, fpair), slow);
+
+        /*
+         * cs_base is a second word of target-specific flags despite the name,
+         * and the pc alone does not imply it on a target that uses it.
+         */
+        gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, cs_base));
+        gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, cs_base, slow);
+
+        gen_ld(TCG_TYPE_PTR, p, p, offsetof(TranslationBlock, tc.ptr));
+        gen_goto_ptr(p);
+    }
+
+    /*
+     * Emit a second goto_ptr rather than branching to a shared one: a temp
+     * live across the label would be spilled and reloaded on every dispatch.
+     */
+    gen_set_label(slow);
+    gen_lookup_tb_ptr_and_goto();
+}
+
 static void gen_goto_jc3(TCGType type, TCGTemp *pc,
                          TCGTemp *cs_base, unsigned flags)
 {
@@ -1988,7 +2085,16 @@ static void gen_goto_jc3(TCGType type, TCGTemp *pc,
                              tcg_constant_i32(flags));
 #endif
 
-    gen_lookup_tb_ptr_and_goto();
+    /*
+     * A breakpoint is the one thing the probe cannot check for itself, so
+     * while one is set the flag is set too and every dispatch takes the
+     * helper, which does check.  See tcg_update_cflags().
+     */
+    if (tcg_ctx->gen_tb->cflags & (CF_NO_GOTO_PTR | CF_NO_GOTO_JC)) {
+        gen_lookup_tb_ptr_and_goto();
+    } else {
+        gen_jc_probe(pc, cs_base, flags);
+    }
 }
 
 static void gen_goto_jc(TCGType type, TCGTemp *pc)
-- 
2.53.0


