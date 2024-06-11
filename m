Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C4BC27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2S5-0007pp-N7; Tue, 11 Jun 2024 10:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S4-0007m1-AQ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S2-0006B4-9f
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMXn4xoWtbGxxqnSwTv4pZx73//0h8zKWI4om598UJg=;
 b=FG21cJcVHbzOxfFk0L1IZm67GPknSqc1iHs5+Kpsloc9F53f7zqkfv512K+dZ+Mg0yHiJs
 xap5KSvL6i9etucdhVLkdtzWZJflXvJKHAGyY4Zji4o3+bu1nS5s2witbHlOzILP1SpKXf
 rHny/QxS+XSix/gYU0G+ICG2n8dWktk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-WBaKHQB4NKalU3an7Y2ENQ-1; Tue, 11 Jun 2024 10:26:14 -0400
X-MC-Unique: WBaKHQB4NKalU3an7Y2ENQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6f3f614e58so26582366b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115972; x=1718720772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMXn4xoWtbGxxqnSwTv4pZx73//0h8zKWI4om598UJg=;
 b=VSOZ3UZ13ICCnxRFZua2N8BNeQzIFuxQBJQFFBtfdVP0+5bTckHHlRCmgcScEqne6L
 Dfcq7ds5GcsWyMhXYBY7JiVIMPs/Fyo12Sxki3NeWcHGlgyvhsMJODd6DZSyHHBAlJnj
 p19Ne2T0h85SBuGaorNXPAC2xiwervrSl5PQDp3o/yjQlTultgyvEHASbu1oGOkC9tvY
 ya/l1ZJFGpaXIlorZnVgiZY0NkM1fCNR95QpOZhBGJWPupIrcwaJGIK5GhojiczXVcHn
 HXMwUhoqrI+eTYDqEBsjfRLx47Q7dMDCkxTPrnyD6eP/59FbzTQnGpTLqpPGUVYHzokR
 lLhw==
X-Gm-Message-State: AOJu0YydJ/K1zIRNJ+/zhoR9mUg0yrNMWSapM+7C3Nd2IHeruH9Nuxef
 Jdftty8GdwMRIFWnkpbm3uuP5b9aJ7WmJS49H+SaCD9Furhrspf/7Eq516D8Ymarh2iCibFixb+
 WaLkwI7lvoQ6g7XUHQMHgundcEGA5TQaC7bj40hj/cSKw+b0Y+110CbtzIPwOnhpEcT8QHbkeYm
 NihlA+CnDMzAbshIvSDsYDMhwFkUaAsO5OeyFP
X-Received: by 2002:a17:907:1c05:b0:a6d:de5b:5b1d with SMTP id
 a640c23a62f3a-a6dde5b5d36mr1195733066b.18.1718115972246; 
 Tue, 11 Jun 2024 07:26:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg52ntUCawpabA0Et2bP7SmqQeJYUF9gqiUx7T5tmDWGqDCRiY7tDIXMOXzdHp1r7R+fJT4w==
X-Received: by 2002:a17:907:1c05:b0:a6d:de5b:5b1d with SMTP id
 a640c23a62f3a-a6dde5b5d36mr1195730966b.18.1718115971829; 
 Tue, 11 Jun 2024 07:26:11 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f09154b34sm454236066b.148.2024.06.11.07.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:26:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/25] target/i386: convert SHLD/SHRD to new decoder
Date: Tue, 11 Jun 2024 16:25:19 +0200
Message-ID: <20240611142524.83762-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Use the same flag generation code as SHL and SHR, but use
the existing gen_shiftd_rm_T1 function to compute the result
as well as CC_SRC.

Decoding-wise, SHLD/SHRD by immediate count as a 4 operand
instruction because s->T0 and s->T1 actually occupy three op
slots.  The infrastructure used by opcodes in the 0F 3A table
works fine.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 84 +-------------------------------
 target/i386/tcg/decode-new.c.inc |  8 ++-
 target/i386/tcg/emit.c.inc       | 42 ++++++++++++++++
 3 files changed, 50 insertions(+), 84 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5200b578a0e..33058db4e30 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1434,57 +1434,11 @@ static bool check_cpl0(DisasContext *s)
     return false;
 }
 
-static void gen_shift_flags(DisasContext *s, MemOp ot, TCGv result,
-                            TCGv shm1, TCGv count, bool is_right)
-{
-    TCGv_i32 z32, s32, oldop;
-    TCGv z_tl;
-
-    /* Store the results into the CC variables.  If we know that the
-       variable must be dead, store unconditionally.  Otherwise we'll
-       need to not disrupt the current contents.  */
-    z_tl = tcg_constant_tl(0);
-    if (cc_op_live[s->cc_op] & USES_CC_DST) {
-        tcg_gen_movcond_tl(TCG_COND_NE, cpu_cc_dst, count, z_tl,
-                           result, cpu_cc_dst);
-    } else {
-        tcg_gen_mov_tl(cpu_cc_dst, result);
-    }
-    if (cc_op_live[s->cc_op] & USES_CC_SRC) {
-        tcg_gen_movcond_tl(TCG_COND_NE, cpu_cc_src, count, z_tl,
-                           shm1, cpu_cc_src);
-    } else {
-        tcg_gen_mov_tl(cpu_cc_src, shm1);
-    }
-
-    /* Get the two potential CC_OP values into temporaries.  */
-    tcg_gen_movi_i32(s->tmp2_i32, (is_right ? CC_OP_SARB : CC_OP_SHLB) + ot);
-    if (s->cc_op == CC_OP_DYNAMIC) {
-        oldop = cpu_cc_op;
-    } else {
-        tcg_gen_movi_i32(s->tmp3_i32, s->cc_op);
-        oldop = s->tmp3_i32;
-    }
-
-    /* Conditionally store the CC_OP value.  */
-    z32 = tcg_constant_i32(0);
-    s32 = tcg_temp_new_i32();
-    tcg_gen_trunc_tl_i32(s32, count);
-    tcg_gen_movcond_i32(TCG_COND_NE, cpu_cc_op, s32, z32, s->tmp2_i32, oldop);
-
-    /* The CC_OP value is no longer predictable.  */
-    set_cc_op(s, CC_OP_DYNAMIC);
-}
-
 /* XXX: add faster immediate case */
-static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
-                             bool is_right, TCGv count_in)
+static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
+                             bool is_right, TCGv count)
 {
     target_ulong mask = (ot == MO_64 ? 63 : 31);
-    TCGv count;
-
-    count = tcg_temp_new();
-    tcg_gen_andi_tl(count, count_in, mask);
 
     switch (ot) {
     case MO_16:
@@ -1546,8 +1500,6 @@ static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
         tcg_gen_or_tl(s->T0, s->T0, s->T1);
         break;
     }
-
-    return count;
 }
 
 #define X86_MAX_INSN_LENGTH 15
@@ -3057,7 +3009,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
     CPUX86State *env = cpu_env(cpu);
     int prefixes = s->prefix;
     MemOp dflag = s->dflag;
-    TCGv shift;
     MemOp ot;
     int modrm, reg, rm, mod, op, val;
 
@@ -3221,37 +3172,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
-        /**************************/
-        /* shifts */
-    case 0x1a4: /* shld imm */
-        op = 0;
-        shift = NULL;
-        goto do_shiftd;
-    case 0x1a5: /* shld cl */
-        op = 0;
-        shift = cpu_regs[R_ECX];
-        goto do_shiftd;
-    case 0x1ac: /* shrd imm */
-        op = 1;
-        shift = NULL;
-        goto do_shiftd;
-    case 0x1ad: /* shrd cl */
-        op = 1;
-        shift = cpu_regs[R_ECX];
-    do_shiftd:
-        ot = dflag;
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        gen_ld_modrm(env, s, modrm, ot);
-        if (!shift) {
-            shift = tcg_constant_tl(x86_ldub_code(env, s));
-        }
-        gen_op_mov_v_reg(s, ot, s->T1, reg);
-        shift = gen_shiftd_rm_T1(s, ot, op, shift);
-        gen_st_modrm(env, s, modrm, ot);
-        gen_shift_flags(s, ot, s->T0, s->tmp0, shift, op);
-        break;
-
         /************************/
         /* bit operations */
     case 0x1ba: /* bt/bts/btr/btc Gv, im */
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1db9d1e2bc3..2d27b07f296 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1114,6 +1114,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa0] = X86_OP_ENTRYr(PUSH, FS, w),
     [0xa1] = X86_OP_ENTRYw(POP, FS, w),
     [0xa2] = X86_OP_ENTRY0(CPUID),
+    [0xa4] = X86_OP_ENTRY4(SHLD,  E,v, 2op,v, G,v),
+    [0xa5] = X86_OP_ENTRY3(SHLD,  E,v, 2op,v, G,v),
 
     [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
     [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
@@ -1240,6 +1242,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa8] = X86_OP_ENTRYr(PUSH,   GS, w),
     [0xa9] = X86_OP_ENTRYw(POP,    GS, w),
     [0xaa] = X86_OP_ENTRY0(RSM,             chk(smm) svm(RSM)),
+    [0xac] = X86_OP_ENTRY4(SHRD,   E,v, 2op,v, G,v),
+    [0xad] = X86_OP_ENTRY3(SHRD,   E,v, 2op,v, G,v),
     [0xae] = X86_OP_GROUP0(group15),
     /*
      * It's slightly more efficient to put Ev operand in T0 and allow gen_IMUL3
@@ -2532,8 +2536,8 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             switch (b) {
             case 0x00 ... 0x01: /* mostly privileged instructions */
             case 0x1a ... 0x1b: /* MPX */
-            case 0xa3 ... 0xa5: /* BT, SHLD */
-            case 0xab ... 0xad: /* BTS, SHRD */
+            case 0xa3:          /* bt */
+            case 0xab:          /* bts */
             case 0xb0 ... 0xb1: /* cmpxchg */
             case 0xb3:          /* btr */
             case 0xb8:          /* integer ops */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 156ea282af4..fc4687a35bd 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3584,6 +3584,27 @@ static void gen_SHL(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+static void gen_SHLD(DisasContext *s, X86DecodedInsn *decode)
+{
+    bool can_be_zero;
+    TCGv count;
+    int unit = decode->e.op3 == X86_TYPE_I ? X86_OP_IMM : X86_OP_INT;
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, unit);
+
+    if (!count) {
+        return;
+    }
+
+    decode->cc_dst = s->T0;
+    decode->cc_src = s->tmp0;
+    gen_shiftd_rm_T1(s, ot, false, count);
+    if (can_be_zero) {
+        gen_shift_dynamic_flags(s, decode, count, CC_OP_SHLB + ot);
+    } else {
+        decode->cc_op = CC_OP_SHLB + ot;
+    }
+}
+
 static void gen_SHLX(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -3616,6 +3637,27 @@ static void gen_SHR(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+static void gen_SHRD(DisasContext *s, X86DecodedInsn *decode)
+{
+    bool can_be_zero;
+    TCGv count;
+    int unit = decode->e.op3 == X86_TYPE_I ? X86_OP_IMM : X86_OP_INT;
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, unit);
+
+    if (!count) {
+        return;
+    }
+
+    decode->cc_dst = s->T0;
+    decode->cc_src = s->tmp0;
+    gen_shiftd_rm_T1(s, ot, true, count);
+    if (can_be_zero) {
+        gen_shift_dynamic_flags(s, decode, count, CC_OP_SARB + ot);
+    } else {
+        decode->cc_op = CC_OP_SARB + ot;
+    }
+}
+
 static void gen_SHRX(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
-- 
2.45.1


