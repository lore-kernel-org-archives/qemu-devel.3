Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1706D3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4d-0004tf-BJ; Wed, 10 Dec 2025 08:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4N-0004rQ-6c
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4K-0003Is-TN
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvtC21VjrchOTPeGgasDp/iHcjTVMSPt2U0j8o6v3dI=;
 b=Frndk6d4lB8M+MrJIHF27fEZaw/pxNfq87HyfpEt7TzHJvMB6VK49xZNjM4sutai1fT365
 8ieQVarF3U2Su2/k5ZQZSASBvDLZmcDbhjmt00LBqOzsFt6B4i/IWO61ZWnyUOIpVoPmea
 7UaiJ9GyB/L4HPgK/V07bcOE1S0Ucsk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-RrZfLHVyNh2bl8h7VsPCLw-1; Wed, 10 Dec 2025 08:17:22 -0500
X-MC-Unique: RrZfLHVyNh2bl8h7VsPCLw-1
X-Mimecast-MFC-AGG-ID: RrZfLHVyNh2bl8h7VsPCLw_1765372641
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47799717212so44551495e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372640; x=1765977440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RvtC21VjrchOTPeGgasDp/iHcjTVMSPt2U0j8o6v3dI=;
 b=WN9TGySWJo51psMgf9CpTQ1VY/oiYYzO7RiQYJWCLBVPQ/EJJJHbe8kn6iQIaQ/Q4D
 aDa0XNQhixqEZ5anoqRRSSbs1OSROdH7gv98wdY3cznfBRd89wcIR4hxdKmKThjIFzUn
 oD/KxtP+qe8WwE/8SKkt/ICHDcQVK5J3Pry94EHWcCh2ul+aRji9R5dcVWDzgiUeidAc
 8iqM2abebPKHvHgBfgTWEq4Ki3aNL8tmU9n7j1ZUWbhCCOorrOf4Q3STjPaxyedCLVz9
 C8QiCiedA0UKvPFCUXdZ3AnQCnQ1rBmlsKkQmyE9BvXSnyH05/0n0h4mhE6WcbQCsKLJ
 sDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372640; x=1765977440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RvtC21VjrchOTPeGgasDp/iHcjTVMSPt2U0j8o6v3dI=;
 b=ltoSm9loBxoInMkIlZ847Y30WuYzDS/pW0mcNaBf3UPEpTzr7FeXX9SsJbpQ11K5Lb
 hCMycgwxP9y3zkYrveAcl6gyS89B3RthyVV1THYKRP8gNgAoDgDYZbDcrBUKNVrlaWND
 KYiXmcmBFY0L7xbiUBouIs9H/OG/kxNr0/xAISnt5BGRljlU5zhv1C2kJBBHfGcLMGZ3
 QDr9tD9/5+fEbbgNWdtBalDRzRYTbYvEYblO3zcDYlXs5+wODJZsC0sPmBSYyr7oQAzJ
 NIj33G6tPZj5gzbfBGu+O6oH30UvBFVD6rZl9Yogvits3rvFZ+hPmwDB0wUzR3zANSTU
 znlQ==
X-Gm-Message-State: AOJu0Yz7eWK2RoLusS0S/aNam0agEBFNop7bvcrLxZGZ//xna6uO4s8O
 E1wiXxXIYhGjHDfzU7NqXFpLMqYfFOpjLntMps6iHHfa8uD8Ig0a69PdgmpbeZ07llh4MiQaKb/
 8eeKl6Gu5ZOc5irUq/RVQrZGcTcaprAAP0ZbYFlgIm0+3vVrOxSU/gP1HKfLTgzxHHRcjcsqezT
 iLZIXXsxuP61oYiI0kGIwm9jMjg1mrCakew9ME/Qmx
X-Gm-Gg: ASbGnctY9PKeougdGgzD6tlmwbPs3VLA4iHuwyEU0jk4DUuuNPI8lpOdzj69RXOxRwL
 NX2YPTpn+1+IRIjjQ5XjWaYi4ps9iX/yAtrB954+Nqm4UkXuih7kLOOyOMQd6T9yi6RuSOZqLcO
 ytd2V6nTWWXWZXDcsc/1seaaqfKkpwjpjJy0YleGjevFONESNVxD2maq2AeumHZliZHO4R82XMY
 xOGfkNzvXDfVRiEb6Ni1boHpDRsoSP7r/C4fmyhs86Rii71UzZGiZ0tdzaJq9GnuxwmCe06QPAw
 LILR0H+tzJM9X77yjSBbrxOrsPSFBzwL6i64OIW450jMwt+JPpq9F8KYiiJDbirWRe7NGXf86Rx
 w+6DpWHDsUwXh2la6vRMk1mcdaCEG0Jt0qsCGEkGlwtxTwc64BLokg4mMwBDyl+45VoDfcvO0Hx
 sNfYHqUfuFm0mlp0w=
X-Received: by 2002:a05:600c:1389:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-47a8383c89amr20949015e9.20.1765372640030; 
 Wed, 10 Dec 2025 05:17:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnpfO14dz0nm50LEguwmY8vBzq7CAa/MIB0feAPcZHqhZwvS2Zx7d3+0cRBZqyJ3QozzyZfQ==
X-Received: by 2002:a05:600c:1389:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-47a8383c89amr20948635e9.20.1765372639303; 
 Wed, 10 Dec 2025 05:17:19 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d31cbcsm43715665e9.7.2025.12.10.05.17.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/18] target/i386/tcg: kill tmp1_i64
Date: Wed, 10 Dec 2025 14:16:49 +0100
Message-ID: <20251210131653.852163-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 66 ++++++++++++++++++++--------------
 target/i386/tcg/emit.c.inc  | 72 ++++++++++++++++++++++---------------
 2 files changed, 84 insertions(+), 54 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8cd70456a51..108276f4008 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -136,7 +136,6 @@ typedef struct DisasContext {
 
     /* TCG local register indexes (only used inside old micro ops) */
     TCGv_i32 tmp2_i32;
-    TCGv_i64 tmp1_i64;
 
     sigjmp_buf jmpbuf;
     TCGOp *prev_insn_start;
@@ -2365,14 +2364,18 @@ static void gen_jmp_rel_csize(DisasContext *s, int diff, int tb_num)
 
 static inline void gen_ldq_env_A0(DisasContext *s, int offset)
 {
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEUQ);
-    tcg_gen_st_i64(s->tmp1_i64, tcg_env, offset);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_qemu_ld_i64(t, s->A0, s->mem_index, MO_LEUQ);
+    tcg_gen_st_i64(t, tcg_env, offset);
 }
 
 static inline void gen_stq_env_A0(DisasContext *s, int offset)
 {
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, offset);
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEUQ);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(t, tcg_env, offset);
+    tcg_gen_qemu_st_i64(t, s->A0, s->mem_index, MO_LEUQ);
 }
 
 static inline void gen_ldo_env_A0(DisasContext *s, int offset, bool align)
@@ -2452,6 +2455,7 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
         TCGv ea = gen_lea_modrm_1(s, decode->mem, false);
         TCGv last_addr = tcg_temp_new();
         bool update_fdp = true;
+        TCGv_i64 t64;
 
         tcg_gen_mov_tl(last_addr, ea);
         gen_lea_v_seg(s, ea, decode->mem.def_seg, s->override);
@@ -2472,9 +2476,10 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             break;
 
         case 0x20 ... 0x27: /* fxxxl */
-            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
+            t64 = tcg_temp_new_i64();
+            tcg_gen_qemu_ld_i64(t64, s->A0,
                                 s->mem_index, MO_LEUQ);
-            gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
+            gen_helper_fldl_FT0(tcg_env, t64);
             gen_helper_fp_arith_ST0_FT0(op & 7);
             break;
 
@@ -2496,9 +2501,10 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
             break;
         case 0x28: /* fldl */
-            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
+            t64 = tcg_temp_new_i64();
+            tcg_gen_qemu_ld_i64(t64, s->A0,
                                 s->mem_index, MO_LEUQ);
-            gen_helper_fldl_ST0(tcg_env, s->tmp1_i64);
+            gen_helper_fldl_ST0(tcg_env, t64);
             break;
         case 0x38: /* filds */
             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
@@ -2513,8 +2519,9 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             gen_helper_fpop(tcg_env);
             break;
         case 0x29: /* fisttpll */
-            gen_helper_fisttll_ST0(s->tmp1_i64, tcg_env);
-            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
+            t64 = tcg_temp_new_i64();
+            gen_helper_fisttll_ST0(t64, tcg_env);
+            tcg_gen_qemu_st_i64(t64, s->A0,
                                 s->mem_index, MO_LEUQ);
             gen_helper_fpop(tcg_env);
             break;
@@ -2542,8 +2549,9 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             }
             break;
         case 0x2a: case 0x2b: /* fstl, fstpl */
-            gen_helper_fstl_ST0(s->tmp1_i64, tcg_env);
-            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
+            t64 = tcg_temp_new_i64();
+            gen_helper_fstl_ST0(t64, tcg_env);
+            tcg_gen_qemu_st_i64(t64, s->A0,
                                 s->mem_index, MO_LEUQ);
             if ((op & 7) == 3) {
                 gen_helper_fpop(tcg_env);
@@ -2611,13 +2619,15 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             gen_helper_fpop(tcg_env);
             break;
         case 0x3d: /* fildll */
-            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
+            t64 = tcg_temp_new_i64();
+            tcg_gen_qemu_ld_i64(t64, s->A0,
                                 s->mem_index, MO_LEUQ);
-            gen_helper_fildll_ST0(tcg_env, s->tmp1_i64);
+            gen_helper_fildll_ST0(tcg_env, t64);
             break;
         case 0x3f: /* fistpll */
-            gen_helper_fistll_ST0(s->tmp1_i64, tcg_env);
-            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
+            t64 = tcg_temp_new_i64();
+            gen_helper_fistll_ST0(t64, tcg_env);
+            tcg_gen_qemu_st_i64(t64, s->A0,
                                 s->mem_index, MO_LEUQ);
             gen_helper_fpop(tcg_env);
             break;
@@ -2951,6 +2961,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
     int modrm = s->modrm;
     MemOp ot;
     int reg, rm, mod, op;
+    TCGv_i64 t64;
 
     /* now check op code */
     switch (b) {
@@ -3142,9 +3153,10 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 || (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
+            t64 = tcg_temp_new_i64();
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_xgetbv(s->tmp1_i64, tcg_env, s->tmp2_i32);
-            tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
+            gen_helper_xgetbv(t64, tcg_env, s->tmp2_i32);
+            tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], t64);
             break;
 
         case 0xd1: /* xsetbv */
@@ -3156,10 +3168,11 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (!check_cpl0(s)) {
                 break;
             }
-            tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
+            t64 = tcg_temp_new_i64();
+            tcg_gen_concat_tl_i64(t64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_xsetbv(tcg_env, s->tmp2_i32, s->tmp1_i64);
+            gen_helper_xsetbv(tcg_env, s->tmp2_i32, t64);
             /* End TB because translation flags may change.  */
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
@@ -3319,18 +3332,20 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
+            t64 = tcg_temp_new_i64();
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_rdpkru(s->tmp1_i64, tcg_env, s->tmp2_i32);
-            tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
+            gen_helper_rdpkru(t64, tcg_env, s->tmp2_i32);
+            tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], t64);
             break;
         case 0xef: /* wrpkru */
             if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
-            tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
+            t64 = tcg_temp_new_i64();
+            tcg_gen_concat_tl_i64(t64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_wrpkru(tcg_env, s->tmp2_i32, s->tmp1_i64);
+            gen_helper_wrpkru(tcg_env, s->tmp2_i32, t64);
             break;
 
         CASE_MODRM_OP(6): /* lmsw */
@@ -3722,7 +3737,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->T1 = tcg_temp_new();
     dc->A0 = tcg_temp_new();
 
-    dc->tmp1_i64 = tcg_temp_new_i64();
     dc->tmp2_i32 = tcg_temp_new_i32();
     dc->cc_srcT = tcg_temp_new();
 }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 131aefce53c..8dac4d09da1 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -521,10 +521,12 @@ static void gen_3dnow(DisasContext *s, X86DecodedInsn *decode)
 
     gen_helper_enter_mmx(tcg_env);
     if (fn == FN_3DNOW_MOVE) {
-       tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[1].offset);
-       tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset);
+        TCGv_i64 t = tcg_temp_new_i64();
+
+        tcg_gen_ld_i64(t, tcg_env, decode->op[1].offset);
+        tcg_gen_st_i64(t, tcg_env, decode->op[0].offset);
     } else {
-       fn(tcg_env, OP_PTR0, OP_PTR1);
+        fn(tcg_env, OP_PTR0, OP_PTR1);
     }
 }
 
@@ -2596,10 +2598,11 @@ static void gen_MOVQ(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
     int lo_ofs = vector_elem_offset(&decode->op[0], MO_64, 0);
+    TCGv_i64 t = tcg_temp_new_i64();
 
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[2].offset);
+    tcg_gen_ld_i64(t, tcg_env, decode->op[2].offset);
     if (decode->op[0].has_ea) {
-        tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEUQ);
+        tcg_gen_qemu_st_i64(t, s->A0, s->mem_index, MO_LEUQ);
     } else {
         /*
          * tcg_gen_gvec_dup_i64(MO_64, op0.offset, 8, vec_len, s->tmp1_64) would
@@ -2610,7 +2613,7 @@ static void gen_MOVQ(DisasContext *s, X86DecodedInsn *decode)
          * it disqualifies using oprsz < maxsz to emulate VEX128.
          */
         tcg_gen_gvec_dup_imm(MO_64, decode->op[0].offset, vec_len, vec_len, 0);
-        tcg_gen_st_i64(s->tmp1_i64, tcg_env, lo_ofs);
+        tcg_gen_st_i64(t, tcg_env, lo_ofs);
     }
 }
 
@@ -4505,10 +4508,12 @@ static void gen_VMASKMOVPS_st(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_VMOVHPx_ld(DisasContext *s, X86DecodedInsn *decode)
 {
+    TCGv_i64 t = tcg_temp_new_i64();
+
     gen_ldq_env_A0(s, decode->op[0].offset + offsetof(XMMReg, XMM_Q(1)));
     if (decode->op[0].offset != decode->op[1].offset) {
-        tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[1].offset + offsetof(XMMReg, XMM_Q(0)));
-        tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
+        tcg_gen_ld_i64(t, tcg_env, decode->op[1].offset + offsetof(XMMReg, XMM_Q(0)));
+        tcg_gen_st_i64(t, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
     }
 }
 
@@ -4519,33 +4524,39 @@ static void gen_VMOVHPx_st(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_VMOVHPx(DisasContext *s, X86DecodedInsn *decode)
 {
+    TCGv_i64 t = tcg_temp_new_i64();
+
     if (decode->op[0].offset != decode->op[2].offset) {
-        tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[2].offset + offsetof(XMMReg, XMM_Q(1)));
-        tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(1)));
+        tcg_gen_ld_i64(t, tcg_env, decode->op[2].offset + offsetof(XMMReg, XMM_Q(1)));
+        tcg_gen_st_i64(t, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(1)));
     }
     if (decode->op[0].offset != decode->op[1].offset) {
-        tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[1].offset + offsetof(XMMReg, XMM_Q(0)));
-        tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
+        tcg_gen_ld_i64(t, tcg_env, decode->op[1].offset + offsetof(XMMReg, XMM_Q(0)));
+        tcg_gen_st_i64(t, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
     }
 }
 
 static void gen_VMOVHLPS(DisasContext *s, X86DecodedInsn *decode)
 {
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[2].offset + offsetof(XMMReg, XMM_Q(1)));
-    tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(t, tcg_env, decode->op[2].offset + offsetof(XMMReg, XMM_Q(1)));
+    tcg_gen_st_i64(t, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
     if (decode->op[0].offset != decode->op[1].offset) {
-        tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[1].offset + offsetof(XMMReg, XMM_Q(1)));
-        tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(1)));
+        tcg_gen_ld_i64(t, tcg_env, decode->op[1].offset + offsetof(XMMReg, XMM_Q(1)));
+        tcg_gen_st_i64(t, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(1)));
     }
 }
 
 static void gen_VMOVLHPS(DisasContext *s, X86DecodedInsn *decode)
 {
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[2].offset);
-    tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(1)));
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(t, tcg_env, decode->op[2].offset);
+    tcg_gen_st_i64(t, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(1)));
     if (decode->op[0].offset != decode->op[1].offset) {
-        tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[1].offset + offsetof(XMMReg, XMM_Q(0)));
-        tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
+        tcg_gen_ld_i64(t, tcg_env, decode->op[1].offset + offsetof(XMMReg, XMM_Q(0)));
+        tcg_gen_st_i64(t, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
     }
 }
 
@@ -4557,34 +4568,39 @@ static void gen_VMOVLHPS(DisasContext *s, X86DecodedInsn *decode)
 static void gen_VMOVLPx(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
+    TCGv_i64 t = tcg_temp_new_i64();
 
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[2].offset + offsetof(XMMReg, XMM_Q(0)));
+    tcg_gen_ld_i64(t, tcg_env, decode->op[2].offset + offsetof(XMMReg, XMM_Q(0)));
     tcg_gen_gvec_mov(MO_64, decode->op[0].offset, decode->op[1].offset, vec_len, vec_len);
-    tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
+    tcg_gen_st_i64(t, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
 }
 
 static void gen_VMOVLPx_ld(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
+    TCGv_i64 t = tcg_temp_new_i64();
 
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEUQ);
+    tcg_gen_qemu_ld_i64(t, s->A0, s->mem_index, MO_LEUQ);
     tcg_gen_gvec_mov(MO_64, decode->op[0].offset, decode->op[1].offset, vec_len, vec_len);
-    tcg_gen_st_i64(s->tmp1_i64, OP_PTR0, offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_st_i64(t, OP_PTR0, offsetof(ZMMReg, ZMM_Q(0)));
 }
 
 static void gen_VMOVLPx_st(DisasContext *s, X86DecodedInsn *decode)
 {
-    tcg_gen_ld_i64(s->tmp1_i64, OP_PTR2, offsetof(ZMMReg, ZMM_Q(0)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEUQ);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(t, OP_PTR2, offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_qemu_st_i64(t, s->A0, s->mem_index, MO_LEUQ);
 }
 
 static void gen_VMOVSD_ld(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i64 zero = tcg_constant_i64(0);
+    TCGv_i64 t = tcg_temp_new_i64();
 
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEUQ);
+    tcg_gen_qemu_ld_i64(t, s->A0, s->mem_index, MO_LEUQ);
     tcg_gen_st_i64(zero, OP_PTR0, offsetof(ZMMReg, ZMM_Q(1)));
-    tcg_gen_st_i64(s->tmp1_i64, OP_PTR0, offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_st_i64(t, OP_PTR0, offsetof(ZMMReg, ZMM_Q(0)));
 }
 
 static void gen_VMOVSS(DisasContext *s, X86DecodedInsn *decode)
-- 
2.52.0


