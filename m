Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEDBC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2S9-000813-Of; Tue, 11 Jun 2024 10:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S8-0007zz-G0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S6-0006CD-HT
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=np857ZvQbA8gPRMAp48ZCXdSeI2YxL7satMktKVk9nw=;
 b=FzEP85x3Lx4oEHkYWFo9eqzgO7w02e30aubNqiXslfohQUCMnOPsKTFksPbtgOmBxg7WNw
 gLxjO55zsasQU129AqAcoxJ/IakpiIhvq8093Dx/F60VxmQ1XlJMhOTLQXygS+6pmSGSsX
 NDOaQ3yJJ0tb1Xid6ODKv57JXA0Lvys=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-iogI6DvhOF-wWLo0BE7d5A-1; Tue, 11 Jun 2024 10:26:20 -0400
X-MC-Unique: iogI6DvhOF-wWLo0BE7d5A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6f3f614e58so26589866b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115978; x=1718720778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=np857ZvQbA8gPRMAp48ZCXdSeI2YxL7satMktKVk9nw=;
 b=aU67Nc71BJ8YjQ5lb+ue885eauzM4n8N4EMFcTSdxlrlQ22yXvC8o+jBiY6+1Q7ljY
 X4/8t2+GUhPvb377Ku0wlbnOoV2DL3GFF7FoZHrG99++xbphpsUBKbVEEx/keMR41ceJ
 EiUnN+gT8T02dJBVDW9eBdCXQM8g6D6/EDjhqIeASC0YUJLSptSb0JsagpA3+FOY/9Kv
 boCI53JcXJ5EWxhZQWZwMWSfsABUsCTShFesrUsefvyUvQau7JQD/K5zNYNUoN95ujBn
 p4hpPkYwVHW2LwdQaFnBTn+k0ZqgLi5y33QsJ0xy8XZnx1Z+ZuvA7X2EdHLNojkFqEsr
 r6xQ==
X-Gm-Message-State: AOJu0YzIdbErlfi1+n+ttSyY4OPYYUyfILnVwj7jVrlLAGqZCcJmMxzy
 xrDs6q877PxZZrcHsoFjryu1rC1ysfp8gu4bFkE/kaYRxZ92UJSVH5utd8CX6dLk0maI4y3Tal9
 aT55izap/jcrzQQ1++4BX5Kpenlha2R7EOysalOvogjG5FSXTiUbAZFZrAjzSUiykpi5cIgDZok
 YnocOH+r0VmV2a4z1B62uPoo3QZohvqusZ04Di
X-Received: by 2002:a17:906:d7a4:b0:a6f:1b59:e877 with SMTP id
 a640c23a62f3a-a6f1b59e8bamr527683566b.75.1718115978455; 
 Tue, 11 Jun 2024 07:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFz1ooYXNlwEz9/0aH8YiGpcAqPZBKIxDUPh1uZqrkMrOLzs9KltY3BpDvmPllTIodJgoSmg==
X-Received: by 2002:a17:906:d7a4:b0:a6f:1b59:e877 with SMTP id
 a640c23a62f3a-a6f1b59e8bamr527681266b.75.1718115978116; 
 Tue, 11 Jun 2024 07:26:18 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6ef83ac0c4sm518097766b.74.2024.06.11.07.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:26:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/25] target/i386: convert CMPXCHG to new decoder
Date: Tue, 11 Jun 2024 16:25:22 +0200
Message-ID: <20240611142524.83762-25-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 79 --------------------------------
 target/i386/tcg/decode-new.c.inc |  3 +-
 target/i386/tcg/emit.c.inc       | 51 +++++++++++++++++++++
 3 files changed, 53 insertions(+), 80 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5d9312bb48c..ad1819815ab 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -434,13 +434,6 @@ static inline MemOp mo_stacksize(DisasContext *s)
     return CODE64(s) ? MO_64 : SS32(s) ? MO_32 : MO_16;
 }
 
-/* Select size 8 if lsb of B is clear, else OT.  Used for decoding
-   byte vs word opcodes.  */
-static inline MemOp mo_b_d(int b, MemOp ot)
-{
-    return b & 1 ? ot : MO_8;
-}
-
 /* Compute the result of writing t0 to the OT-sized register REG.
  *
  * If DEST is NULL, store the result into the register and return the
@@ -715,11 +708,6 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
     return dst;
 }
 
-static void gen_extu(MemOp ot, TCGv reg)
-{
-    gen_ext_tl(reg, reg, ot, false);
-}
-
 static void gen_exts(MemOp ot, TCGv reg)
 {
     gen_ext_tl(reg, reg, ot, true);
@@ -3003,73 +2991,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
 
     /* now check op code */
     switch (b) {
-        /**************************/
-        /* arith & logic */
-    case 0x1b0:
-    case 0x1b1: /* cmpxchg Ev, Gv */
-        {
-            TCGv oldv, newv, cmpv, dest;
-
-            ot = mo_b_d(b, dflag);
-            modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | REX_R(s);
-            mod = (modrm >> 6) & 3;
-            oldv = tcg_temp_new();
-            newv = tcg_temp_new();
-            cmpv = tcg_temp_new();
-            gen_op_mov_v_reg(s, ot, newv, reg);
-            tcg_gen_mov_tl(cmpv, cpu_regs[R_EAX]);
-            gen_extu(ot, cmpv);
-            if (s->prefix & PREFIX_LOCK) {
-                if (mod == 3) {
-                    goto illegal_op;
-                }
-                gen_lea_modrm(env, s, modrm);
-                tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, cmpv, newv,
-                                          s->mem_index, ot | MO_LE);
-            } else {
-                if (mod == 3) {
-                    rm = (modrm & 7) | REX_B(s);
-                    gen_op_mov_v_reg(s, ot, oldv, rm);
-                    gen_extu(ot, oldv);
-
-                    /*
-                     * Unlike the memory case, where "the destination operand receives
-                     * a write cycle without regard to the result of the comparison",
-                     * rm must not be touched altogether if the write fails, including
-                     * not zero-extending it on 64-bit processors.  So, precompute
-                     * the result of a successful writeback and perform the movcond
-                     * directly on cpu_regs.  Also need to write accumulator first, in
-                     * case rm is part of RAX too.
-                     */
-                    dest = gen_op_deposit_reg_v(s, ot, rm, newv, newv);
-                    tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, newv, dest);
-                } else {
-                    gen_lea_modrm(env, s, modrm);
-                    gen_op_ld_v(s, ot, oldv, s->A0);
-
-                    /*
-                     * Perform an unconditional store cycle like physical cpu;
-                     * must be before changing accumulator to ensure
-                     * idempotency if the store faults and the instruction
-                     * is restarted
-                     */
-                    tcg_gen_movcond_tl(TCG_COND_EQ, newv, oldv, cmpv, newv, oldv);
-                    gen_op_st_v(s, ot, newv, s->A0);
-                }
-            }
-	    /*
-	     * Write EAX only if the cmpxchg fails; reuse newv as the destination,
-	     * since it's dead here.
-	     */
-            dest = gen_op_deposit_reg_v(s, ot, R_EAX, newv, oldv);
-            tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, dest, newv);
-            tcg_gen_mov_tl(cpu_cc_src, oldv);
-            tcg_gen_mov_tl(s->cc_srcT, cmpv);
-            tcg_gen_sub_tl(cpu_cc_dst, cmpv, oldv);
-            set_cc_op(s, CC_OP_SUBB + ot);
-        }
-        break;
     case 0x1c7: /* cmpxchg8b */
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 008a8387bda..d199f2d4b6f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1161,6 +1161,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa4] = X86_OP_ENTRY4(SHLD,  E,v, 2op,v, G,v),
     [0xa5] = X86_OP_ENTRY3(SHLD,  E,v, 2op,v, G,v),
 
+    [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock),
+    [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock),
     [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
     [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
     [0xb5] = X86_OP_ENTRY3(LGS,    G,v, EM,p, None, None),
@@ -2589,7 +2591,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             case 0x1a ... 0x1b: /* MPX */
             case 0xa3:          /* bt */
             case 0xab:          /* bts */
-            case 0xb0 ... 0xb1: /* cmpxchg */
             case 0xb3:          /* btr */
             case 0xba ... 0xbb: /* grp8, btc */
             case 0xc7:          /* grp9 */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 9c8fe14e286..aa026ed1fd9 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1582,6 +1582,57 @@ static void gen_CMPS(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+    TCGv cmpv = tcg_temp_new();
+    TCGv oldv = tcg_temp_new();
+    TCGv newv = tcg_temp_new();
+    TCGv dest;
+
+    tcg_gen_ext_tl(cmpv, cpu_regs[R_EAX], ot);
+    tcg_gen_ext_tl(newv, s->T1, ot);
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, cmpv, newv,
+                                  s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_ext_tl(oldv, s->T0, ot);
+        if (decode->op[0].has_ea) {
+            /*
+             * Perform an unconditional store cycle like physical cpu;
+             * must be before changing accumulator to ensure
+             * idempotency if the store faults and the instruction
+             * is restarted
+             */
+            tcg_gen_movcond_tl(TCG_COND_EQ, newv, oldv, cmpv, newv, oldv);
+            gen_op_st_v(s, ot, newv, s->A0);
+        } else {
+            /*
+             * Unlike the memory case, where "the destination operand receives
+             * a write cycle without regard to the result of the comparison",
+             * rm must not be touched altogether if the write fails, including
+             * not zero-extending it on 64-bit processors.  So, precompute
+             * the result of a successful writeback and perform the movcond
+             * directly on cpu_regs.  In case rm is part of RAX, note that this
+             * movcond and the one below are mutually exclusive is executed.
+             */
+            dest = gen_op_deposit_reg_v(s, ot, decode->op[0].n, newv, newv);
+            tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, newv, dest);
+        }
+        decode->op[0].unit = X86_OP_SKIP;
+    }
+
+    /* Write RAX only if the cmpxchg fails.  */
+    dest = gen_op_deposit_reg_v(s, ot, R_EAX, s->T0, oldv);
+    tcg_gen_movcond_tl(TCG_COND_NE, dest, oldv, cmpv, s->T0, dest);
+
+    tcg_gen_mov_tl(s->cc_srcT, cmpv);
+    tcg_gen_sub_tl(cmpv, cmpv, oldv);
+    decode->cc_dst = cmpv;
+    decode->cc_src = oldv;
+    decode->cc_op = CC_OP_SUBB + ot;
+}
+
 static void gen_CPUID(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
-- 
2.45.1


