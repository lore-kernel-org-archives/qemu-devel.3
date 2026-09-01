Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF25C61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FUr-0000h0-TW; Mon, 31 Aug 2026 23:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUj-0000fG-JI
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:49:09 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUf-0004ND-D3
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:49:07 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-836cb2fa1bcso40429687b3.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788234544; x=1788839344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=abTvdvVoaUPAt7wEkDm5qW6FwkZ8iBbbJSMuWBq+oyc=;
 b=h0Zbi1Xhmejw3sfocQlwLAXI2bDUAx30CmvNNJKtBrU2cFwbVpejAjoo9MbTcTIBjL
 W1/eEYCzX0x+7GBHcysFqb9mxBhdif5R4E8RJf6znOCrvEZOmoi+UJjn1ujdjXTgHRau
 +6wBuM5P5joVWYPw85tgxpYg3bZK7WvvhTasTdwwX8GLBaoxeqbHwKj+DL8DaRwUHB3M
 9uWpLp2RCZqL+F43g/CO4yAsryz+92vpAeUrm70AlxRfG0h6Xf7Wfmu0XoIc6Lnj7bKs
 Y6H6eLyyzRuUqqugZ1vvS2ED8TUHF6SbnylPORqNc9M+cik3vWnVVpnmGKxWlN8glciG
 CA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788234544; x=1788839344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=abTvdvVoaUPAt7wEkDm5qW6FwkZ8iBbbJSMuWBq+oyc=;
 b=mh9XqAAavEJl9APo4U1IFrtXPfeRJoz3teS0O4ImpxIx94fjK1pgT25vrQs3xfuBS4
 0BBfLQYB/o4R8MqXd1hJfmf0aCROlwh0pw6vsqPh+WcaSd+aAt1Y38c9AU1B1PRI+VCU
 NPOQNx06hYDy1snGAIENTu0dj2BbPjAE/SYsCHG1qOBaWnvEsiVPF97KWb+xYQfXihl/
 hAR7SVmcgRPKjV9zz+F0rlc/kEq4X0e8B2l7rxLFTdPMaf0JWRHXu9tkSiXhol6j9FH0
 GbaubcKa79zdxDxwGT14lzQQiQu3zXvfBhz+o+T/r7+c1nlXGmAEu/ENS2zTbXw+n6TC
 p9XA==
X-Gm-Message-State: AFuF++ks4Af4TUlSCoSXMquRYHE1YDKgHQn/vCIwMVaNAm78Czxa1aAW
 3rja4/vJ2BKiK8CZUxWdkFLbdFW6UnOeyXdwJcPyZJm49ybnCwrZp1Qgg4hAIw==
X-Gm-Gg: AYBFou0dmlpzwwMVBFN3+tX/mvrnaA4o5GYDwNgYsESuYIUuYOOvk49b1jaNSsOgwkb
 FgVIR+rx89IixyeO/wokV8xyRBdgj2ixT2NMYsPU4OVHMRn+tXU8gPN8NK9PkkuWPJCsC9CrfuJ
 RpgyaoIo2bdIP20u23CppO74YyBltS9Bakub+VSN0YZCoEnS0jiT78Z1oOGl8TbtyD/rgiR38QQ
 uysXqNQ5CD1T2ePgHXVW3GuDJGvB5Qpn83aseGRWSLoDzvgw/pj9hKBZEJtlOcBsD51iNDSAhLg
 PL1lt5TPgn47Ff3l7Fpz22KpxzMt9EIQM/woxURIM+t36ipFiP1zfi4vNxpPEkOyNuR5uSMk4Ag
 mxYSQuMaveJBly0stCCYxBzeLD98ZEU4Z4yBJKITFyb1oMQAg8IcYPP+zVKX4hi5DG5ZIvtKn4T
 OF+bFnvPGFVgGcfcsv32JjlJxrqFYow3izQjpz+lrhMlXLjsAdcLF+/Hrnt9DmmxCYuXck6V9dB
 zHRAEFhQiZE8iH+SrPwmU0Y/jdLQJYn2tYMEXZm
X-Received: by 2002:a05:690c:c623:b0:809:9422:8c47 with SMTP id
 00721157ae682-85d6d889183mr99833927b3.22.1788234544140; 
 Mon, 31 Aug 2026 20:49:04 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e5ed18556sm66125667b3.11.2026.08.31.20.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:49:02 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 9/9] RFC: tcg: fold a guest displacement into the host
 addressing mode
Date: Mon, 31 Aug 2026 23:48:08 -0400
Message-ID: <20260901034808.3524945-10-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901034808.3524945-1-mattst88@gmail.com>
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112b.google.com
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

Nothing in the TCG frontend interface can express a based memory access.
tcg_gen_qemu_ld/st take an address and nothing else, so a target with a
displacement in its load and store encodings -- which is most of them --
has to materialize the address first:

    ldq a1,8(a0)  ->  mov 0x80(%rbp),%rbx      reload a0
                      lea 0x8(%rbx),%r12       address
                      mov (%r12),%r12          the load
                      mov %r12,0x88(%rbp)      spill a1

The lea is pure loss on a host whose addressing mode has a displacement
field sitting empty. It also needs a register, at the point in a block
where pressure is highest.

Fold it. After optimization, look for an add of a constant immediately
before a guest access, defining that access's address operand, and move the
constant into a new second constant argument on the op. The add is left for
liveness to remove, so nothing breaks if its result has another use. Only
the immediately preceding op is examined: that is what the frontends emit,
and a window of one op means the pass does not have to reason about what
could have happened in between. The one thing it does check is that the add
did not clobber the base it read, since the access now reads that base
directly.

Targets opt in with TCG_TARGET_HAS_ldst_disp and an out_disp member on
TCGOutOpQemuLdSt. Without it the pass does not run, the displacement stays
zero and the existing out member is called exactly as before, so no other
backend changes behavior or needs touching.

The fold is refused unless the access has no slow path at all, since the
slow path hands addr_reg to the helper and that register no longer holds
the full guest address. That is decided generically: user-only, because
softmmu compares the unadjusted address against the TLB; a 64-bit address
type, because a 32-bit one wraps where a host displacement would not; and
no alignment test on the access. For x86_64 the displacement goes in the
disp32 that prepare_host_addr() already fills in for guest_base, so all the
backend has left to check is that guest_base plus the displacement still
fits there.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling the
SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO build,
on top of the preceding patches, against a control measured in the same
session:

    before: 868,811,832,620 instructions, 79.85s
    after:  819,262,147,022 instructions, 77.30s
                                          -5.70% instructions, -3.20% wall

Emitted code shrinks from 50.55MB to 48.80MB over the run, 167.4 to 161.6
bytes per block. Per Alpha opcode, the host bytes emitted for an access
fall as expected and nothing else moves:

    ldq   18.3 -> 15.4    ldah  20.9 -> 20.9
    ldl   16.6 -> 14.1    lda   12.9 -> 12.9
    stq   12.8 ->  9.7    mov    9.8 ->  9.8

The emulated compiler produces byte-identical output and the alpha tests
still pass, including with a non-zero guest_base forced via -B.

RFC because:

- Only wired up for x86_64, and only for qemu_ld and qemu_st; the i128
  qemu_ld2 and qemu_st2 pairs are left alone.
- Requiring that no slow path exists is stricter than necessary. The fast
  path test can stay on the base register as long as the displacement is
  itself a multiple of the required alignment, which it is for anything a
  frontend emits for a struct or stack access. Recording the displacement
  in TCGLabelQemuLdst and emitting one lea on the slow path would then
  cover alignment-checked accesses too, at no fast path cost.
- Softmmu wants the displacement folded into the TLB comparison as well,
  which is a bigger change than this one.
- A one op window catches everything the frontends emit today but is
  trivially defeated by anything scheduled in between.

v4:
- Hoisted the compilation mode tests -- tcg_use_softmmu and the 64-bit
  address type -- out of the backend hook and into fold_ldst_disp(), next
  to the TCG_TARGET_HAS_ldst_disp test, so the loop is not entered at all
  when the mode rules the fold out.
- Pass MemOp rather than MemOpIdx to the backend hook; nothing about the
  mmu_idx is relevant to it.
- Moved the alignment test into generic code as ldst_disp_needs_align(),
  so a backend does not have to repeat the atom_and_align_for_opc() call.
  The exact answer depends on the host's atomicity capabilities, which the
  generic pass does not know, so it answers for the most restrictive host.
  That is the same answer for everything the frontends actually emit --
  MO_ATOM_IFALIGN is the default -- and conservative for the handful of
  MO_ATOM_WITHIN16 and MO_ATOM_SUBALIGN accesses, which lose the fold on a
  host that could have taken it.
- What is left of the x86_64 hook is the guest_base test, so it now lives
  beside x86_guest_base under the CONFIG_USER_ONLY that declares it.
- Refuse a displacement that does not fit in an int32_t, which is what
  out_disp() takes. Not reachable with any real guest_base, but the pass
  should not offer the backend something the interface cannot carry.
- The numbers above are unchanged from v3: they have not been re-measured
  on the restructured patch, which is not expected to move them since the
  accesses in this workload are all MO_ATOM_IFALIGN.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 include/tcg/tcg-opc.h       |   9 ++-
 tcg/tcg-op-ldst.c           |   3 +-
 tcg/tcg.c                   | 132 +++++++++++++++++++++++++++++++++++-
 tcg/x86_64/tcg-target.c.inc |  41 +++++++++++
 tcg/x86_64/tcg-target.h     |   3 +
 5 files changed, 184 insertions(+), 4 deletions(-)

diff --git ./include/tcg/tcg-opc.h ./include/tcg/tcg-opc.h
index f3a81d5d7f..92fd34d3e3 100644
--- ./include/tcg/tcg-opc.h
+++ ./include/tcg/tcg-opc.h
@@ -125,8 +125,13 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
 
-DEF(qemu_ld, 1, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
-DEF(qemu_st, 0, 2, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
+/*
+ * The second constant argument is a displacement to add to the address,
+ * zero unless a target advertises TCG_TARGET_HAS_ldst_disp and the fold in
+ * fold_ldst_disp() applied.
+ */
+DEF(qemu_ld, 1, 1, 2, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
+DEF(qemu_st, 0, 2, 2, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
 DEF(qemu_ld2, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
 DEF(qemu_st2, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
 
diff --git ./tcg/tcg-op-ldst.c ./tcg/tcg-op-ldst.c
index 22211ccb45..ffc5e651a6 100644
--- ./tcg/tcg-op-ldst.c
+++ ./tcg/tcg-op-ldst.c
@@ -92,7 +92,8 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
 static void gen_ldst1(TCGOpcode opc, TCGType type, TCGTemp *v,
                       TCGTemp *addr, MemOpIdx oi)
 {
-    TCGOp *op = tcg_gen_op3(opc, type, temp_arg(v), temp_arg(addr), oi);
+    /* The trailing zero is the address displacement; see fold_ldst_disp(). */
+    TCGOp *op = tcg_gen_op4(opc, type, temp_arg(v), temp_arg(addr), oi, 0);
     TCGOP_FLAGS(op) = get_memop(oi) & MO_SIZE;
 }
 
diff --git ./tcg/tcg.c ./tcg/tcg.c
index 489df0e738..466604eb97 100644
--- ./tcg/tcg.c
+++ ./tcg/tcg.c
@@ -1058,6 +1058,13 @@ typedef struct TCGOutOpQemuLdSt {
     TCGOutOp base;
     void (*out)(TCGContext *s, TCGType type, TCGReg dest,
                 TCGReg addr, MemOpIdx oi);
+    /*
+     * As out(), for an access at addr + disp. Only required of targets that
+     * define TCG_TARGET_HAS_ldst_disp; for everyone else fold_ldst_disp()
+     * never runs and the displacement is always zero.
+     */
+    void (*out_disp)(TCGContext *s, TCGType type, TCGReg dest,
+                     TCGReg addr, MemOpIdx oi, int32_t disp);
 } TCGOutOpQemuLdSt;
 
 typedef struct TCGOutOpQemuLdSt2 {
@@ -3574,6 +3581,123 @@ static void move_label_uses(TCGLabel *to, TCGLabel *from)
     QSIMPLEQ_CONCAT(&to->branches, &from->branches);
 }
 
+#ifndef TCG_TARGET_HAS_ldst_disp
+#define TCG_TARGET_HAS_ldst_disp  0
+#define tcg_target_ldst_disp_ok(s, opc, disp)  false
+#endif
+
+/*
+ * Return true if @opc needs an alignment test in the fast path.
+ *
+ * atom_and_align_for_opc() gives the exact answer, but only once the host's
+ * atomicity capabilities are known, and those belong to the backend. Answer
+ * instead for the most restrictive host, which is valid for all of them.
+ */
+static bool ldst_disp_needs_align(MemOp opc)
+{
+    MemOp size = opc & MO_SIZE;
+
+    if (memop_alignment_bits(opc)) {
+        return true;
+    }
+    switch (opc & MO_ATOM_MASK) {
+    case MO_ATOM_NONE:
+    case MO_ATOM_IFALIGN:
+    case MO_ATOM_IFALIGN_PAIR:
+        return false;
+    case MO_ATOM_WITHIN16:
+        /* Misalignment implies !within16, and therefore no atomicity. */
+        return size != MO_128;
+    case MO_ATOM_WITHIN16_PAIR:
+    case MO_ATOM_SUBALIGN:
+        return size != MO_8;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/*
+ * Fold "add addr, base, $disp" into the guest access that follows it, so
+ * that the displacement becomes part of the host addressing mode instead of
+ * a separate instruction. Frontends have no way to express this: there is
+ * no displacement operand on tcg_gen_qemu_ld/st, so a based access always
+ * costs an extra add, and an extra register to hold its result.
+ *
+ * Only an add in the op immediately before the access is recognized. That
+ * is what the frontends emit, and a window of one op means no analysis is
+ * needed of what might have happened in between. The add is left in place;
+ * liveness removes it if its result has no other use.
+ */
+static void __attribute__((noinline))
+fold_ldst_disp(TCGContext *s)
+{
+    TCGOp *op;
+
+    /*
+     * The fold requires that the access have no slow path, because the slow
+     * path hands the address operand to the helper and that register no
+     * longer holds the complete guest address. That means user-only, since
+     * softmmu compares the unadjusted address against the TLB. It also
+     * requires a 64-bit address type: for a 32-bit one the add wraps and a
+     * host displacement would not.
+     */
+    if (!TCG_TARGET_HAS_ldst_disp || tcg_use_softmmu ||
+        s->addr_type != TCG_TYPE_I64) {
+        return;
+    }
+
+    QTAILQ_FOREACH(op, &s->ops, link) {
+        TCGOp *prev;
+        TCGTemp *cts;
+        int64_t disp;
+        MemOp opc;
+
+        switch (op->opc) {
+        case INDEX_op_qemu_ld:
+        case INDEX_op_qemu_st:
+            break;
+        default:
+            continue;
+        }
+
+        opc = get_memop(op->args[2]);
+        if (ldst_disp_needs_align(opc)) {
+            continue;
+        }
+
+        prev = QTAILQ_PREV(op, link);
+        if (prev == NULL || prev->opc != INDEX_op_add ||
+            TCGOP_TYPE(prev) != s->addr_type) {
+            continue;
+        }
+
+        /*
+         * The add must define the address operand, and must not have
+         * clobbered the base it read: after the fold the access reads the
+         * base directly, so the base has to still hold its original value.
+         */
+        if (prev->args[0] != op->args[1] || prev->args[0] == prev->args[1]) {
+            continue;
+        }
+
+        cts = arg_temp(prev->args[2]);
+        if (cts->kind != TEMP_CONST) {
+            continue;
+        }
+        /* out_disp() takes an int32_t, so anything wider cannot be passed. */
+        disp = cts->val;
+        if (disp != (int32_t)disp) {
+            continue;
+        }
+        if (disp == 0 || !tcg_target_ldst_disp_ok(s, opc, disp)) {
+            continue;
+        }
+
+        op->args[1] = prev->args[1];
+        op->args[3] = disp;
+    }
+}
+
 /* Reachable analysis : remove unreachable code.  */
 static void __attribute__((noinline))
 reachable_code_pass(TCGContext *s)
@@ -5728,7 +5852,12 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             const TCGOutOpQemuLdSt *out =
                 container_of(all_outop[op->opc], TCGOutOpQemuLdSt, base);
 
-            out->out(s, type, new_args[0], new_args[1], new_args[2]);
+            if (new_args[3]) {
+                out->out_disp(s, type, new_args[0], new_args[1],
+                              new_args[2], new_args[3]);
+            } else {
+                out->out(s, type, new_args[0], new_args[1], new_args[2]);
+            }
         }
         break;
 
@@ -6611,6 +6740,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     tcg_temp_ebb_reset_freed(s);
 
     tcg_optimize(s);
+    fold_ldst_disp(s);
 
     reachable_code_pass(s);
     liveness_pass_0(s);
diff --git ./tcg/x86_64/tcg-target.c.inc ./tcg/x86_64/tcg-target.c.inc
index 2c8f1f3e58..9b177d3475 100644
--- ./tcg/x86_64/tcg-target.c.inc
+++ ./tcg/x86_64/tcg-target.c.inc
@@ -1892,6 +1892,18 @@ static HostAddress x86_guest_base = {
     .index = -1
 };
 
+/*
+ * Whether the displacement of a guest access can be folded into the host
+ * addressing mode rather than materialized by a separate lea.  The generic
+ * pass has already established that the access has no slow path, so all
+ * that is left is guest_base, which shares the disp32 field.
+ */
+static bool tcg_target_ldst_disp_ok(TCGContext *s, MemOp opc, int32_t disp)
+{
+    int64_t ofs = (int64_t)x86_guest_base.ofs + disp;
+    return ofs == (int32_t)ofs;
+}
+
 #if defined(__linux__)
 # include <asm/prctl.h>
 # include <sys/prctl.h>
@@ -1917,6 +1929,7 @@ static inline int setup_guest_base_seg(void)
 #endif
 #else
 # define x86_guest_base (*(HostAddress *)({ qemu_build_not_reached(); NULL; }))
+# define tcg_target_ldst_disp_ok(s, opc, disp)  false
 #endif /* CONFIG_USER_ONLY */
 #ifndef setup_guest_base_seg
 # define setup_guest_base_seg()  0
@@ -2183,9 +2196,23 @@ static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
     }
 }
 
+static void tgen_qemu_ld_disp(TCGContext *s, TCGType type, TCGReg data,
+                              TCGReg addr, MemOpIdx oi, int32_t disp)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr(s, &h, addr, oi, true);
+    /* tcg_target_ldst_disp_ok() has ruled out every slow path. */
+    tcg_debug_assert(ldst == NULL);
+    h.ofs += disp;
+    tcg_out_qemu_ld_direct(s, data, -1, h, type, get_memop(oi));
+}
+
 static const TCGOutOpQemuLdSt outop_qemu_ld = {
     .base.static_constraint = C_O1_I1(r, L),
     .out = tgen_qemu_ld,
+    .out_disp = tgen_qemu_ld_disp,
 };
 
 static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
@@ -2321,9 +2348,23 @@ static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
     }
 }
 
+static void tgen_qemu_st_disp(TCGContext *s, TCGType type, TCGReg data,
+                              TCGReg addr, MemOpIdx oi, int32_t disp)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr(s, &h, addr, oi, false);
+    /* tcg_target_ldst_disp_ok() has ruled out every slow path. */
+    tcg_debug_assert(ldst == NULL);
+    h.ofs += disp;
+    tcg_out_qemu_st_direct(s, data, -1, h, get_memop(oi));
+}
+
 static const TCGOutOpQemuLdSt outop_qemu_st = {
     .base.static_constraint = C_O0_I2(L, L),
     .out = tgen_qemu_st,
+    .out_disp = tgen_qemu_st_disp,
 };
 
 static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
diff --git ./tcg/x86_64/tcg-target.h ./tcg/x86_64/tcg-target.h
index 7ebae56a7d..8f2315c15e 100644
--- ./tcg/x86_64/tcg-target.h
+++ ./tcg/x86_64/tcg-target.h
@@ -30,6 +30,9 @@
 #define TCG_TARGET_NB_REGS   32
 #define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 
+/* A guest displacement can go in the disp32 of the addressing mode. */
+#define TCG_TARGET_HAS_ldst_disp  1
+
 typedef enum {
     TCG_REG_EAX = 0,
     TCG_REG_ECX,
-- 
2.54.0


