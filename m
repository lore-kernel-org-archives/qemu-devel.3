Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD249C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFre6-0001d1-MD; Sat, 08 Jun 2024 04:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFre5-0001cp-UQ
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFre4-0001Pw-32
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTQuU78l9PNh3Ee02W3G2foh2NBLKBu2TnRb8Cyqwnk=;
 b=Z7p4Zg1plCmxoUMZHWIpMOtmCcREEJ62amvSHPO1YWELgy670+tU3yOanHUlaspFhXKEHw
 IdBJqO1iELZfDkHTctblNEPU0b42wt/x8WuXup1grn6IRBHI07gb+/f6SoFkg+6EJyJM3T
 xic8eQImixy8faCCwO87CRUR7zBDSz4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-xkQ-7v5oN7St0IoViFaEXQ-1; Sat, 08 Jun 2024 04:41:47 -0400
X-MC-Unique: xkQ-7v5oN7St0IoViFaEXQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6ef7afd90aso38133366b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836105; x=1718440905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTQuU78l9PNh3Ee02W3G2foh2NBLKBu2TnRb8Cyqwnk=;
 b=H2zsqJcaPB9N9sKH8gCh9fcwKw5ZbA+YL6aoEDm5G3WQBlGRONCoq425eC3JIGvAvP
 KtfSU806qB/mo3DmwNar6JhRyg4h7jCXTa4GjqfAhz5IxMvA/gClbNA035l5MmrQKcOA
 QzZLOAkcMfTNtRhPVem7kzq5is8yFjAj93tH586UVRVT8ToiTiDtK4p59xYpQIu8DiL7
 TTJqA/nbGlCLYAFnNKjUAYvrpR0IQ6hVGY1IuUkeYiMVLVgUasU3otiwnWlOLy+fJDXo
 Knp8YJsPT7z4eVxZkEFyW8BXQ9YYpSYroKHF5se5kfDzsuXjYcuij7V6mz/mv76KtOv4
 cLNw==
X-Gm-Message-State: AOJu0Yz3OxDnW+XM8k8a+6W/DXRwTLbVib0jsDWWuR0lDqFh1I7TDs0X
 +bvIPNjHIEXDarQ5rC9owXprTWLtVo4EOTtQu+jGvODPWbRIuCIGHVpenq7PkAwZjGVj9Okkwjs
 yfdR01N+JEx4fpkAaRsfzFyEEkbJUY3KtJn1VeiJJ1aSUMT3BOfLySxGGz7I+DZY/0opA4AHQcA
 JdCxh7ZeeNuHo3KDjhxkaI+NyR/1JIMUHZpTaA
X-Received: by 2002:a17:906:d053:b0:a68:e920:e68b with SMTP id
 a640c23a62f3a-a6cd6665c58mr304132266b.25.1717836105091; 
 Sat, 08 Jun 2024 01:41:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoc0gny/LhebrgdWo31YLPP5nbX06n8/Axz58Jcg44802UOr0hFgM9tRK2zmVnuLFQ8SBuXQ==
X-Received: by 2002:a17:906:d053:b0:a68:e920:e68b with SMTP id
 a640c23a62f3a-a6cd6665c58mr304131466b.25.1717836104625; 
 Sat, 08 Jun 2024 01:41:44 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0f5ee702sm5224666b.52.2024.06.08.01.41.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/25] target/i386: convert MOV from/to CR and DR to new
 decoder
Date: Sat,  8 Jun 2024 10:40:56 +0200
Message-ID: <20240608084113.2770363-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


