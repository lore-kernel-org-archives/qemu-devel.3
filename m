Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A553C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2Rn-0007Ri-LS; Tue, 11 Jun 2024 10:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rl-0007GO-HC
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rj-00068f-IY
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnpHEtGPkMpNCt3jD5VK98OrnLFxQQ+9zKFTwAU6WF0=;
 b=Imi+5aBkkn1Rsfx4V3wikhDZ3fANBLoFQFWiXYJV0OBlAHHpAewpCqhAjREDb9YS2nJ7OX
 nbA2lGv4Qhp8uBfnEvUnRPKkr2GWrKxTybDI5QSwJmHrcY6nhAtKrOrGEm6E5F4GpQ7XcS
 gBPlgAazSu2CYjpLRLUwA0jUmGv/3Z4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-rk_0XaI8Mj-TFxeuiNVZJw-1; Tue, 11 Jun 2024 10:25:57 -0400
X-MC-Unique: rk_0XaI8Mj-TFxeuiNVZJw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57c6e28b151so780536a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115955; x=1718720755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnpHEtGPkMpNCt3jD5VK98OrnLFxQQ+9zKFTwAU6WF0=;
 b=O1BkO9dwzdYs1MSR1pYhcwLZDc6ZysgesvImBDtmfunuVBOEwYbtn5EXZcNqfRGb3E
 8nmc/wU19XSvQbfKosjUdNCsGg8t2Gg+c5dCWf964OOlp0p3e5Bpgfzq18ADFI3W1cWB
 8SpMJFsb56puGyywwpdLUvRDKG5+FT0ld1NKG4POWvlvHFMV+lbMsfPRrqr+opvkVQr8
 7wRcIvUW87lgY1X3lmoBYDEayESk84sPKa8IvMT4dEric5ZBASee1LLQmAjDQaM+DnVE
 R4UH2Wlbt3poCTzT4JC4GxsWcMBSV9G6ffmqWewVDPxbcM5xC6GzUAv0Oo/kgWNU4Sa6
 xDDg==
X-Gm-Message-State: AOJu0YyVF5Jx9AuWGXP92svV278+BFADkfGguXoQcITYs5cPHqVynbcw
 t7LgWDipm3R99dTEwGuVwJvBQEHxkchC76FvpQJmqSw0HJWlEibybqRF9phGHfpr3LF7Ciz+M9i
 lY/uKM2COptimCYTu7ki7n5tq8gLYF//Dckkt3Opvs+xvUvkxVvZq39tvRxzW+efZTf7tpAiypw
 78AVx8T2XOpRN8h+va8XE3AVt/hvCuElIlLFaK
X-Received: by 2002:a50:8d01:0:b0:57c:61a3:54c with SMTP id
 4fb4d7f45d1cf-57c61a30661mr6253284a12.0.1718115954681; 
 Tue, 11 Jun 2024 07:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo0qpAzsTewbkyUKq17XHQUBHiYeh0bhmA17tqN8fk5Sctc5s6QG3KUiiUtSjfMMz29SbzoQ==
X-Received: by 2002:a50:8d01:0:b0:57c:61a3:54c with SMTP id
 4fb4d7f45d1cf-57c61a30661mr6253261a12.0.1718115954048; 
 Tue, 11 Jun 2024 07:25:54 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c9d5e29e9sm615215a12.2.2024.06.11.07.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/25] target/i386: convert MOV from/to CR and DR to new decoder
Date: Tue, 11 Jun 2024 16:25:11 +0200
Message-ID: <20240611142524.83762-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Complete implementation of C and D operand types, then the operations
are just MOVs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 79 --------------------------------
 target/i386/tcg/decode-new.c.inc | 53 +++++++++++++++++++--
 target/i386/tcg/emit.c.inc       | 20 +++++++-
 3 files changed, 68 insertions(+), 84 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index fcba9c155f9..4958f4c45d5 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -247,9 +247,6 @@ STUB_HELPER(outb, TCGv_env env, TCGv_i32 port, TCGv_i32 val)
 STUB_HELPER(outw, TCGv_env env, TCGv_i32 port, TCGv_i32 val)
 STUB_HELPER(outl, TCGv_env env, TCGv_i32 port, TCGv_i32 val)
 STUB_HELPER(rdmsr, TCGv_env env)
-STUB_HELPER(read_crN, TCGv ret, TCGv_env env, TCGv_i32 reg)
-STUB_HELPER(get_dr, TCGv ret, TCGv_env env, TCGv_i32 reg)
-STUB_HELPER(set_dr, TCGv_env env, TCGv_i32 reg, TCGv val)
 STUB_HELPER(stgi, TCGv_env env)
 STUB_HELPER(svm_check_intercept, TCGv_env env, TCGv_i32 type)
 STUB_HELPER(vmload, TCGv_env env, TCGv_i32 aflag)
@@ -4192,82 +4189,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         gen_nop_modrm(env, s, modrm);
         break;
 
-    case 0x120: /* mov reg, crN */
-    case 0x122: /* mov crN, reg */
-        if (!check_cpl0(s)) {
-            break;
-        }
-        modrm = x86_ldub_code(env, s);
-        /*
-         * Ignore the mod bits (assume (modrm&0xc0)==0xc0).
-         * AMD documentation (24594.pdf) and testing of Intel 386 and 486
-         * processors all show that the mod bits are assumed to be 1's,
-         * regardless of actual values.
-         */
-        rm = (modrm & 7) | REX_B(s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        switch (reg) {
-        case 0:
-            if ((prefixes & PREFIX_LOCK) &&
-                (s->cpuid_ext3_features & CPUID_EXT3_CR8LEG)) {
-                reg = 8;
-            }
-            break;
-        case 2:
-        case 3:
-        case 4:
-        case 8:
-            break;
-        default:
-            goto unknown_op;
-        }
-        ot  = (CODE64(s) ? MO_64 : MO_32);
-
-        translator_io_start(&s->base);
-        if (b & 2) {
-            gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0 + reg);
-            gen_op_mov_v_reg(s, ot, s->T0, rm);
-            gen_helper_write_crN(tcg_env, tcg_constant_i32(reg), s->T0);
-            s->base.is_jmp = DISAS_EOB_NEXT;
-        } else {
-            gen_svm_check_intercept(s, SVM_EXIT_READ_CR0 + reg);
-            gen_helper_read_crN(s->T0, tcg_env, tcg_constant_i32(reg));
-            gen_op_mov_reg_v(s, ot, rm, s->T0);
-        }
-        break;
-
-    case 0x121: /* mov reg, drN */
-    case 0x123: /* mov drN, reg */
-        if (check_cpl0(s)) {
-            modrm = x86_ldub_code(env, s);
-            /* Ignore the mod bits (assume (modrm&0xc0)==0xc0).
-             * AMD documentation (24594.pdf) and testing of
-             * intel 386 and 486 processors all show that the mod bits
-             * are assumed to be 1's, regardless of actual values.
-             */
-            rm = (modrm & 7) | REX_B(s);
-            reg = ((modrm >> 3) & 7) | REX_R(s);
-            if (CODE64(s))
-                ot = MO_64;
-            else
-                ot = MO_32;
-            if (reg >= 8) {
-                goto illegal_op;
-            }
-            if (b & 2) {
-                gen_svm_check_intercept(s, SVM_EXIT_WRITE_DR0 + reg);
-                gen_op_mov_v_reg(s, ot, s->T0, rm);
-                tcg_gen_movi_i32(s->tmp2_i32, reg);
-                gen_helper_set_dr(tcg_env, s->tmp2_i32, s->T0);
-                s->base.is_jmp = DISAS_EOB_NEXT;
-            } else {
-                gen_svm_check_intercept(s, SVM_EXIT_READ_DR0 + reg);
-                tcg_gen_movi_i32(s->tmp2_i32, reg);
-                gen_helper_get_dr(s->T0, tcg_env, s->tmp2_i32);
-                gen_op_mov_reg_v(s, ot, rm, s->T0);
-            }
-        }
-        break;
     case 0x106: /* clts */
         if (check_cpl0(s)) {
             gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0);
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index cd925fe3589..4c567911f41 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -151,6 +151,8 @@
     X86_OP_GROUP3(op, op0, s0, 2op, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_GROUPw(op, op0, s0, ...)                           \
     X86_OP_GROUP3(op, op0, s0, None, None, None, None, ## __VA_ARGS__)
+#define X86_OP_GROUPwr(op, op0, s0, op1, s1, ...)                 \
+    X86_OP_GROUP3(op, op0, s0, op1, s1, None, None, ## __VA_ARGS__)
 #define X86_OP_GROUP0(op, ...)                                    \
     X86_OP_GROUP3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
@@ -985,6 +987,24 @@ static void decode_0FE6(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     *entry = *decode_by_prefix(s, opcodes_0FE6);
 }
 
+/* These are a bit weird, so group all the pre-decode tweaks here.  */
+static void decode_MOV_CR_DR(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    /* No 16-bit mode.  */
+    s->dflag = MO_32;
+
+    /*
+     * Ignore the mod bits (assume (modrm&0xc0)==0xc0).
+     * AMD documentation (24594.pdf) and testing of Intel 386 and 486
+     * processors all show that the mod bits are assumed to be 1's,
+     * regardless of actual values.
+     */
+    get_modrm(s, env);
+    s->modrm |= 0xC0;
+
+    entry->gen = gen_MOV;
+}
+
 static const X86OpEntry opcodes_0F[256] = {
     [0x0E] = X86_OP_ENTRY0(EMMS,                              cpuid(3DNOW)), /* femms */
     /*
@@ -1004,6 +1024,11 @@ static const X86OpEntry opcodes_0F[256] = {
     /* Incorrectly listed as Mq,Vq in the manual */
     [0x17] = X86_OP_ENTRY3(VMOVHPx_st,  M,q, None,None, V,dq, vex5 p_00_66),
 
+    [0x20] = X86_OP_GROUPwr(MOV_CR_DR,   R,y, C,y, chk(cpl0) svm(READ_CR0)),
+    [0x21] = X86_OP_GROUPwr(MOV_CR_DR,   R,y, D,y, chk(cpl0) svm(READ_DR0)),
+    [0x22] = X86_OP_GROUPwr(MOV_CR_DR,   C,y, R,y, zextT0 chk(cpl0) svm(WRITE_CR0)),
+    [0x23] = X86_OP_GROUPwr(MOV_CR_DR,   D,y, R,y, zextT0 chk(cpl0) svm(WRITE_DR0)),
+
     [0x40] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
     [0x41] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
     [0x42] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
@@ -1802,11 +1827,34 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_C:  /* REG in the modrm byte selects a control register */
         op->unit = X86_OP_CR;
-        goto get_reg;
+        op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
+        if (op->n == 0 && (s->prefix & PREFIX_LOCK) &&
+            (s->cpuid_ext3_features & CPUID_EXT3_CR8LEG)) {
+            op->n = 8;
+            s->prefix &= ~PREFIX_LOCK;
+        }
+        if (op->n != 0 && op->n != 2 && op->n != 3 && op->n != 4 && op->n != 8) {
+            return false;
+        }
+        if (decode->e.intercept) {
+            decode->e.intercept += op->n;
+        }
+        break;
 
     case X86_TYPE_D:  /* REG in the modrm byte selects a debug register */
         op->unit = X86_OP_DR;
-        goto get_reg;
+        op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
+        if (op->n >= 8) {
+            /*
+             * illegal opcode.  The DR4 and DR5 case is checked in the generated
+             * code instead, to save on hflags bits.
+             */
+            return false;
+        }
+        if (decode->e.intercept) {
+            decode->e.intercept += op->n;
+        }
+        break;
 
     case X86_TYPE_G:  /* REG in the modrm byte selects a GPR */
         op->unit = X86_OP_INT;
@@ -2431,7 +2479,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             case 0x00 ... 0x03: /* mostly privileged instructions */
             case 0x05 ... 0x09:
             case 0x1a ... 0x1b: /* MPX */
-            case 0x20 ... 0x23: /* mov from/to CR and DR */
             case 0x30 ... 0x35: /* more privileged instructions */
             case 0xa2 ... 0xa5: /* CPUID, BT, SHLD */
             case 0xaa ... 0xae: /* RSM, SHRD, grp15 */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index e6521632edd..bcb6bccbd75 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -242,12 +242,19 @@ static void gen_load(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv v)
         tcg_gen_ld32u_tl(v, tcg_env,
                          offsetof(CPUX86State,segs[op->n].selector));
         break;
+#ifndef CONFIG_USER_ONLY
     case X86_OP_CR:
-        tcg_gen_ld_tl(v, tcg_env, offsetof(CPUX86State, cr[op->n]));
+        if (op->n == 8) {
+            gen_helper_read_crN(v, tcg_env, tcg_constant_i32(op->n));
+        } else {
+            tcg_gen_ld_tl(v, tcg_env, offsetof(CPUX86State, cr[op->n]));
+        }
         break;
     case X86_OP_DR:
-        tcg_gen_ld_tl(v, tcg_env, offsetof(CPUX86State, dr[op->n]));
+        /* CR4.DE tested in the helper.  */
+        gen_helper_get_dr(v, tcg_env, tcg_constant_i32(op->n));
         break;
+#endif
     case X86_OP_INT:
         if (op->has_ea) {
             if (v == s->T0 && decode->e.special == X86_SPECIAL_SExtT0) {
@@ -343,8 +350,17 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
                                  16, 16, 0);
         }
         break;
+#ifndef CONFIG_USER_ONLY
     case X86_OP_CR:
+        gen_helper_write_crN(tcg_env, tcg_constant_i32(op->n), v);
+        s->base.is_jmp = DISAS_EOB_NEXT;
+        break;
     case X86_OP_DR:
+        /* CR4.DE tested in the helper.  */
+        gen_helper_set_dr(tcg_env, tcg_constant_i32(op->n), v);
+        s->base.is_jmp = DISAS_EOB_NEXT;
+        break;
+#endif
     default:
         g_assert_not_reached();
     }
-- 
2.45.1


