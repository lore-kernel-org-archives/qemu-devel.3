Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C26C5DF82
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNqH-0002vE-Ks; Tue, 18 Aug 2026 13:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNqE-0002uc-TQ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:15 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNq6-0007xR-9P
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:09 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-836c718715fso2777087b3.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074985; x=1787679785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8MikWi2ZkuQ48w4BbQpRaAViV4sVN9NaKK78tQU/xZ8=;
 b=ZrVkZwidaHvKC2vDo+GiMtwkMDcTcWyEjFXB4voP7D1E61pGnmouikk+WnX8xEefct
 /NR8oVncMXORnSObL4eeSzMGPE3D+ddFCQQC7EjKMBR+d5jwn8e36q/ZlkzT3DhOXqEU
 2Vs6QIRSlSUaSxlox4/w6/V82drUBJxV/XfissD58/1/O2IJn8R7VJE9eEFgaSLKlARQ
 S0Wh8IZgKF73FxZ9kvKP2X6AxuhxDHgn+c2CQggcMe2SSnTu26jDqqaqYstv4xqpsQkv
 5kk/boRscRZLMTotYAKy2pihXX7sCMDWoRdvWsUVLMUo3EizIXEzVuP5uxdmZ3xkmrWx
 BbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074985; x=1787679785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8MikWi2ZkuQ48w4BbQpRaAViV4sVN9NaKK78tQU/xZ8=;
 b=n1lsWw9rN65GTZ6uUWfC3gXYssaesKcR4+mWp4ktqjEP0OJTU3f8ual97sHskWwYgX
 +PrwKJXbFASjDqRvGNLubjeWqrN1k4mn5303JG5CSaF8OvFQcxOJAR55723pR2jOWykN
 3S+/vcbW2Qd+Y4v1lkc0dyJGlMhGCh+KBfxa6AsKzEsLWagrMCCid6pUgH/Fn5MwoXxu
 9v7qunWBWmScNWlkHmo8ViD0rKNa3dRkBmVp4XW19KmtTM+0jxJftQxnboRZjTtH7hkB
 L2XFcU1ghl+zjCnTp5VxDN5/CU7YebLDWmQOl05atBGZnlYC2fQ69YVW3E7IsJ4FAekj
 TH2Q==
X-Gm-Message-State: AOJu0YzXAB2HyOtge7CuL70VZdraGhNYKUFkzBjpq9aMNKp+CJxNJmt2
 jQ/Qmho/4f0Rcv2Mpj5D+FebwN72JVQmYUlS4K8rskyWCCFjZoOyyQbeoxeL4B/yTb4=
X-Gm-Gg: AR+sD10adPuBQxzlvUC7cFE/bPUojUEwOebfiiG4mjjWsTmFvW56jF7dIdy+pNEFCDP
 UbOe1X3459yKAWR1DQ/wttFJuIN5fr+qsKBw/5hpyjZys8tOSUmpGL/nOmlYRpLCnUBM9EVvb34
 P+QGP+1FqE0aXv5gTx1aJthWeKciQEh6TQMsys+p0I7gsxjykdnawu4t4uot7UWaV76xGn1ug9a
 5tonSay361MqMx8Rzhhi3mJridNCEiIZTd2M2CzRT709aNat1TDIrCU0S74rgEDtvF/N4sNRnX0
 DGdjQGiC6FQmSAZQk9/PKERQNkDM4e/MkWVVsWmGwX1nPHhmKfgYP+yL1JGwqOH05d74yvCHj6z
 PxelmlIWOnBAaBOmdwW0840oRwnz++Q2eWCEC29oJzjVNidlHd+YY6wErQAaghO1jX2lHWRgDqL
 Dl2YlzdpHOSAJY7XP8FjM5JqPuYvCZuBfjO0778NPmQW3sRcdF2x5GN1jaX637CIO5YY5KtC7i
X-Received: by 2002:a05:690c:103:b0:81d:bc5:4624 with SMTP id
 00721157ae682-83711e15d36mr125378377b3.25.1787074984961; 
 Tue, 18 Aug 2026 10:43:04 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-84068d1eafasm25220817b3.19.2026.08.18.10.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:43:02 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4/8] RFC: tcg: probe the TB jump cache inline instead of
 calling a helper
Date: Tue, 18 Aug 2026 13:42:43 -0400
Message-ID: <20260818174247.649526-5-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818174247.649526-1-mattst88@gmail.com>
References: <20260818174247.649526-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Every indirect branch that cannot use goto_tb ends in
tcg_gen_lookup_and_goto_ptr(), which calls helper_lookup_tb_ptr(). For an
emulated compiler that is 8.4 billion helper calls in a single translation
unit: 24.6% of all TB exits take this path, because jsr/ret/jmp have a
register destination and because goto_tb is restricted to same-page
targets.

The helper itself is already tight, but each call pays for a call frame,
the can_do_io store, the get_tb_cpu_state() indirect call through
TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
jump cache probe that almost always hits (95.8% for this workload).

Emit the probe inline instead. The destination PC is already in a TCG
temp, and the flags and cflags the destination must match are constants at
translation time, so the fast path is a hash, three guarded loads and a
goto_ptr. Only a miss calls the helper, which still owns filling the cache.

Two details matter for the generated code. The flags and cflags guards are
folded into a single aligned 64-bit load and compare, since the fields are
adjacent. And each path emits its own goto_ptr rather than branching to a
shared one: a temp live across the label is spilled and reloaded on every
dispatch, which cost 6.3% on its own.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO
build, on top of the preceding three patches:

    before: 1,402,816,253,499 instructions
    after:    890,713,633,237 instructions   -36.51%

    before: 115.75s wall clock
    after:   84.44s wall clock               -27.05%

The gap between the two is the point at which this stops being a
straight-line win: the helper call was highly predictable work that the
host pipelined well, so removing it retires far fewer instructions than it
saves time. IPC falls from 2.48 to 2.15 across this patch for that reason.

Despite emitting more code, this also reduces instruction cache pressure,
because a dispatch no longer jumps into qemu's .text and evicts translated
code:

    before: 11,476,318,964 L1-icache-load-misses
    after:   6,990,186,701 L1-icache-load-misses   -39.1%

The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
falls from 30.97% of samples to 0.42%, and qemu's own .text falls from
38.9% to 5.4%, with the balance moving into generated code.

Combined with the three preceding patches, against an unmodified LTO
build, 1,647,901,588,726 instructions fall to 890,713,633,237, or -45.95%.
The emulated compiler produces byte-identical output throughout.

Open issues, hence RFC:

- The flags/cflags guards use the *current* TB's values as constants. That
  assumes the CPU flags feeding get_tb_cpu_state() cannot change within a
  TB, and that curr_cflags() cannot change under a running TB (gdb
  attaching to enable single-step would). Both need to be established or
  the values need to be loaded at runtime.
- tcg/tcg-op.c has no business including accel/tcg/tb-jmp-cache.h or
  knowing the CPUJumpCache layout. The probe likely belongs in accel/tcg
  with a small emit helper exported from tcg/.
- The jump cache entry is read without qatomic_read(); entries are
  invalidated concurrently by setting tb to NULL.
- Only wired up for alpha so far, and only for 64-bit guest PCs.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 include/tcg/tcg-op-common.h |  2 +
 target/alpha/translate.c    |  4 +-
 tcg/tcg-op.c                | 79 +++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git ./include/tcg/tcg-op-common.h ./include/tcg/tcg-op-common.h
index 1fe342db0d..65084c38b9 100644
--- ./include/tcg/tcg-op-common.h
+++ ./include/tcg/tcg-op-common.h
@@ -84,6 +84,8 @@ void tcg_gen_goto_tb(unsigned idx);
  * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the argument.
  */
 void tcg_gen_lookup_and_goto_ptr(void);
+void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc,
+                                        const TranslationBlock *tb);
 
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
diff --git ./target/alpha/translate.c ./target/alpha/translate.c
index c66e3f9c14..939170a28b 100644
--- ./target/alpha/translate.c
+++ ./target/alpha/translate.c
@@ -449,7 +449,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, int32_t disp)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         gen_pc_disp(ctx, cpu_pc, disp);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr_inline(cpu_pc, ctx->base.tb);
     }
 }
 
@@ -2917,7 +2917,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_pc_disp(ctx, cpu_pc, 0);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr_inline(cpu_pc, ctx->base.tb);
         break;
     case DISAS_PC_UPDATED_NOCHAIN:
         tcg_gen_exit_tb(NULL, 0);
diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
index bbcb510c76..ab8d101871 100644
--- ./tcg/tcg-op.c
+++ ./tcg/tcg-op.c
@@ -28,6 +28,8 @@
 #include "tcg/tcg-op-common.h"
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
+#include "hw/core/cpu.h"
+#include "../accel/tcg/tb-jmp-cache.h"
 #include "tcg-internal.h"
 #include "tcg-has.h"
 
@@ -2620,3 +2622,80 @@ void tcg_gen_lookup_and_goto_ptr(void)
     tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
     tcg_temp_free_ptr(ptr);
 }
+
+/*
+ * As tcg_gen_lookup_and_goto_ptr(), but probe the TB jump cache inline
+ * instead of calling helper_lookup_tb_ptr() unconditionally.  @pc must
+ * hold the destination guest PC; @flags and @cflags are the values the
+ * destination TB must have been translated with.
+ */
+void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc,
+                                        const TranslationBlock *tb)
+{
+    uint32_t flags = tb->flags;
+    uint32_t cflags = tb->cflags;
+    TCGv_ptr jc, ent, tbp, ptr;
+    TCGv_i64 h, tmp;
+    TCGLabel *slow;
+    uint64_t fpair;
+
+    if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
+        tcg_gen_exit_tb(NULL, 0);
+        return;
+    }
+
+    plugin_gen_disable_mem_helpers();
+
+    QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) != 16);
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, cflags) !=
+                      offsetof(TranslationBlock, flags) + 4);
+
+    jc = tcg_temp_ebb_new_ptr();
+    ent = tcg_temp_ebb_new_ptr();
+    tbp = tcg_temp_ebb_new_ptr();
+    ptr = tcg_temp_ebb_new_ptr();
+    h = tcg_temp_ebb_new_i64();
+    tmp = tcg_temp_ebb_new_i64();
+    slow = gen_new_label();
+
+    /* h = tb_jmp_cache_hash_func(pc) * sizeof(array[0]) */
+    tcg_gen_shri_i64(h, pc, TB_JMP_CACHE_BITS);
+    tcg_gen_xor_i64(h, h, pc);
+    tcg_gen_andi_i64(h, h, TB_JMP_CACHE_SIZE - 1);
+    tcg_gen_shli_i64(h, h, 4);
+
+    tcg_gen_ld_ptr(jc, tcg_env,
+                   offsetof(CPUState, tb_jmp_cache) - sizeof(CPUState));
+    tcg_gen_trunc_i64_ptr(ent, h);
+    tcg_gen_add_ptr(ent, jc, ent);
+
+    tcg_gen_ld_ptr(tbp, ent, offsetof(CPUJumpCache, array[0].tb));
+    tcg_gen_brcondi_ptr(TCG_COND_EQ, tbp, 0, slow);
+
+    tcg_gen_ld_i64(tmp, ent, offsetof(CPUJumpCache, array[0].pc));
+    tcg_gen_brcond_i64(TCG_COND_NE, tmp, pc, slow);
+
+    /*
+     * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
+     * and compare covers both.
+     */
+#if HOST_BIG_ENDIAN
+    fpair = ((uint64_t)flags << 32) | cflags;
+#else
+    fpair = ((uint64_t)cflags << 32) | flags;
+#endif
+    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, flags));
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, fpair, slow);
+
+    tcg_gen_ld_ptr(ptr, tbp, offsetof(TranslationBlock, tc.ptr));
+    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+
+    /*
+     * Emit a second goto_ptr rather than branching to a shared one: a temp
+     * live across the label would be spilled and reloaded on every dispatch.
+     */
+    gen_set_label(slow);
+    ptr = tcg_temp_ebb_new_ptr();
+    gen_helper_lookup_tb_ptr(ptr, tcg_env);
+    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+}
-- 
2.54.0


