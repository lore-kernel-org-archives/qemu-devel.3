Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5BAC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Gn5-0006fT-Hi; Thu, 03 Apr 2025 05:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gn0-0006dl-Dj
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gmx-0007qL-Kg
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743672186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2DWmpMGxpO/H/L19npId5qnJcLLFJyZ6z+PN8qEiwY=;
 b=NpEEehLzpDxnQ0qOv9dQLpsSf36cFsp2zbi+FXPFvJirvciN7qrcidy9YRSQqteFMiiqCW
 J00W5g2y2+rHIo8vCcFX2k9xRUCKLeRXtkv8VIat3wRSxL57BWgUu5hnUQAy0RymemH6Nz
 qU4skhXNqKnIE9UHStIe7tHKZcVcu0Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-BBAV8r9KOlGDiF8EQIYKZQ-1; Thu, 03 Apr 2025 05:23:04 -0400
X-MC-Unique: BBAV8r9KOlGDiF8EQIYKZQ-1
X-Mimecast-MFC-AGG-ID: BBAV8r9KOlGDiF8EQIYKZQ_1743672183
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac31adc55e4so59501966b.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 02:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743672182; x=1744276982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2DWmpMGxpO/H/L19npId5qnJcLLFJyZ6z+PN8qEiwY=;
 b=EHqcS40bv0EouXSdGcL2K59QrGWgW0/XPInBfonTYdsUeLBbkAyPQJXAx9smiUJeMw
 9Sgw8Q8IKyDUj+HNfERnrE5ngrSXtMgeYOhlynDZkaDGwVzTGCjtsRh1Yq7KtLo6GYhI
 paTFiu3bak21NqBudGhEbLnART+1k1Ff3PW2xsahVLlp2bBc6kbZf5jaOJiY8VHZCLsN
 aRyfzZ+SvkcFdU/jl7vqQ97wAa+BNHwGPS+o4tybYd8xbg3LtbgOoa9OrAAsUPnbJb2u
 chXvf+Vm+njQijOe1Hv+0drjJQ1fdKpq11b9YnT8Nvmhlk8HMgspEZQtXUHw/0FbAq6x
 dAJw==
X-Gm-Message-State: AOJu0YylHrQjlnGaYwQvkD9w09R24s/RgjRjOSj/uNLQLGEcwp9FK8RU
 JbH60n+WdLCao3BKmeK+3eQUkm3I49bakW/ZM3PHawS0wCxdXlfKXYiANVb7BWhcKilU1riSC0k
 xOzDQ5tV2lPEYf99krJUnqomgHqZ6TsfcIExIlUp+f8aOGpXL3/vrXbamAiCudLM2/aamrP3xry
 kXT9/PKDB7zB0bE86NfA1hvU740VEKS9U8lgdO
X-Gm-Gg: ASbGncus8d03nxL39GrBpYqWejnPdt0Nn//dhmEonT3J2nRzXrNV5FsxPKcCh2l/1Li
 cAY7F0ErENd2m3yY6lpC6h6fvtzaK4bM5SUlUXC6Y4xggAc393imigJfm/q1lOKlfdxuecGYyzJ
 ojupsMYwr8BFdtQtIuNTHw157sSU0p3g8E6gXDjiI92rOWV2IVfv41hgXgbZJMC+OGDXRoipR+F
 ZF6WcFQUclrth1a0pAdIG4wbcG8Vpu5NHb7gvb2ABUfceeQqcWju9qEsKjBeB3Q0sBn70NhzD23
 JZp+8Hi4/IBqiSy7kw3i
X-Received: by 2002:a17:907:7d8f:b0:ac7:3911:35e9 with SMTP id
 a640c23a62f3a-ac7c0af78eemr110131266b.61.1743672182104; 
 Thu, 03 Apr 2025 02:23:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnVVdswdR3smfjqR95zVEz0xPUvIJY2nU5CnM60awqlSCrhBn1xCNqSqniDIR4yDorWIdijg==
X-Received: by 2002:a17:907:7d8f:b0:ac7:3911:35e9 with SMTP id
 a640c23a62f3a-ac7c0af78eemr110129366b.61.1743672181516; 
 Thu, 03 Apr 2025 02:23:01 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe5c804sm63503866b.15.2025.04.03.02.23.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 02:23:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/i386: tcg: remove some more uses of temporaries
Date: Thu,  3 Apr 2025 11:22:51 +0200
Message-ID: <20250403092251.54441-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403092251.54441-1-pbonzini@redhat.com>
References: <20250403092251.54441-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove all uses of 32-bit temporaries in emit.c.inc.  Remove uses
in translate.c outside the large multiplexed generator functions.
tmp3_i32 is not used anymore and can go away.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 43 +++++++++++--------
 target/i386/tcg/emit.c.inc  | 83 +++++++++++++++++++++++--------------
 2 files changed, 77 insertions(+), 49 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5d433f8522e..abe210cc4ef 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -135,7 +135,6 @@ typedef struct DisasContext {
 
     /* TCG local register indexes (only used inside old micro ops) */
     TCGv_i32 tmp2_i32;
-    TCGv_i32 tmp3_i32;
     TCGv_i64 tmp1_i64;
 
     sigjmp_buf jmpbuf;
@@ -1318,30 +1317,35 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
 
 static void gen_ins(DisasContext *s, MemOp ot, TCGv dshift)
 {
+    TCGv_i32 port = tcg_temp_new_i32();
+
     gen_string_movl_A0_EDI(s);
     /* Note: we must do this dummy write first to be restartable in
        case of page fault. */
     tcg_gen_movi_tl(s->T0, 0);
     gen_op_st_v(s, ot, s->T0, s->A0);
-    tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
-    tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
-    gen_helper_in_func(ot, s->T0, s->tmp2_i32);
+    tcg_gen_trunc_tl_i32(port, cpu_regs[R_EDX]);
+    tcg_gen_andi_i32(port, port, 0xffff);
+    gen_helper_in_func(ot, s->T0, port);
     gen_op_st_v(s, ot, s->T0, s->A0);
     gen_op_add_reg(s, s->aflag, R_EDI, dshift);
-    gen_bpt_io(s, s->tmp2_i32, ot);
+    gen_bpt_io(s, port, ot);
 }
 
 static void gen_outs(DisasContext *s, MemOp ot, TCGv dshift)
 {
+    TCGv_i32 port = tcg_temp_new_i32();
+    TCGv_i32 value = tcg_temp_new_i32();
+
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
 
-    tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
-    tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
-    tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T0);
-    gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
+    tcg_gen_trunc_tl_i32(port, cpu_regs[R_EDX]);
+    tcg_gen_andi_i32(port, port, 0xffff);
+    tcg_gen_trunc_tl_i32(value, s->T0);
+    gen_helper_out_func(ot, port, value);
     gen_op_add_reg(s, s->aflag, R_ESI, dshift);
-    gen_bpt_io(s, s->tmp2_i32, ot);
+    gen_bpt_io(s, port, ot);
 }
 
 #define REP_MAX 65535
@@ -1869,14 +1873,16 @@ static void gen_bndck(DisasContext *s, X86DecodedInsn *decode,
                       TCGCond cond, TCGv_i64 bndv)
 {
     TCGv ea = gen_lea_modrm_1(s, decode->mem, false);
+    TCGv_i32 t32 = tcg_temp_new_i32();
+    TCGv_i64 t64 = tcg_temp_new_i64();
 
-    tcg_gen_extu_tl_i64(s->tmp1_i64, ea);
+    tcg_gen_extu_tl_i64(t64, ea);
     if (!CODE64(s)) {
-        tcg_gen_ext32u_i64(s->tmp1_i64, s->tmp1_i64);
+        tcg_gen_ext32u_i64(t64, t64);
     }
-    tcg_gen_setcond_i64(cond, s->tmp1_i64, s->tmp1_i64, bndv);
-    tcg_gen_extrl_i64_i32(s->tmp2_i32, s->tmp1_i64);
-    gen_helper_bndck(tcg_env, s->tmp2_i32);
+    tcg_gen_setcond_i64(cond, t64, t64, bndv);
+    tcg_gen_extrl_i64_i32(t32, t64);
+    gen_helper_bndck(tcg_env, t32);
 }
 
 /* generate modrm load of memory or register. */
@@ -2021,8 +2027,10 @@ static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
 static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src)
 {
     if (PE(s) && !VM86(s)) {
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, src);
-        gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), s->tmp2_i32);
+        TCGv_i32 sel = tcg_temp_new_i32();
+
+        tcg_gen_trunc_tl_i32(sel, src);
+        gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), sel);
         /* abort translation because the addseg value may change or
            because ss32 may change. For R_SS, translation must always
            stop as a special handling must be done to disable hardware
@@ -3777,7 +3785,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 
     dc->tmp1_i64 = tcg_temp_new_i64();
     dc->tmp2_i32 = tcg_temp_new_i32();
-    dc->tmp3_i32 = tcg_temp_new_i32();
     dc->cc_srcT = tcg_temp_new();
 }
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 03b04cadb14..fa0f2977e55 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1916,9 +1916,10 @@ static void gen_CPUID(DisasContext *s, X86DecodedInsn *decode)
 static void gen_CRC32(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-    gen_helper_crc32(s->T0, s->tmp2_i32, s->T1, tcg_constant_i32(8 << ot));
+    tcg_gen_trunc_tl_i32(tmp, s->T0);
+    gen_helper_crc32(s->T0, tmp, s->T1, tcg_constant_i32(8 << ot));
 }
 
 static void gen_CVTPI2Px(DisasContext *s, X86DecodedInsn *decode)
@@ -2376,8 +2377,10 @@ static void gen_LAR(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_LDMXCSR(DisasContext *s, X86DecodedInsn *decode)
 {
-    tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-    gen_helper_ldmxcsr(tcg_env, s->tmp2_i32);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_trunc_tl_i32(tmp, s->T0);
+    gen_helper_ldmxcsr(tcg_env, tmp);
 }
 
 static void gen_lxx_seg(DisasContext *s, X86DecodedInsn *decode, int seg)
@@ -2590,11 +2593,13 @@ static void gen_MOVDQ(DisasContext *s, X86DecodedInsn *decode)
 static void gen_MOVMSK(DisasContext *s, X86DecodedInsn *decode)
 {
     typeof(gen_helper_movmskps_ymm) *ps, *pd, *fn;
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
     ps = s->vex_l ? gen_helper_movmskps_ymm : gen_helper_movmskps_xmm;
     pd = s->vex_l ? gen_helper_movmskpd_ymm : gen_helper_movmskpd_xmm;
     fn = s->prefix & PREFIX_DATA ? pd : ps;
-    fn(s->tmp2_i32, tcg_env, OP_PTR2);
-    tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
+    fn(tmp, tcg_env, OP_PTR2);
+    tcg_gen_extu_i32_tl(s->T0, tmp);
 }
 
 static void gen_MOVQ(DisasContext *s, X86DecodedInsn *decode)
@@ -2691,13 +2696,17 @@ static void gen_MULX(DisasContext *s, X86DecodedInsn *decode)
     switch (ot) {
     case MO_32:
 #ifdef TARGET_X86_64
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
-        tcg_gen_mulu2_i32(s->tmp2_i32, s->tmp3_i32,
-                          s->tmp2_i32, s->tmp3_i32);
-        tcg_gen_extu_i32_tl(cpu_regs[s->vex_v], s->tmp2_i32);
-        tcg_gen_extu_i32_tl(s->T0, s->tmp3_i32);
-        break;
+        {
+            TCGv_i32 t0 = tcg_temp_new_i32();
+            TCGv_i32 t1 = tcg_temp_new_i32();
+
+            tcg_gen_trunc_tl_i32(t0, s->T0);
+            tcg_gen_trunc_tl_i32(t1, s->T1);
+            tcg_gen_mulu2_i32(t0, t1, t0, t1);
+            tcg_gen_extu_i32_tl(cpu_regs[s->vex_v], t0);
+            tcg_gen_extu_i32_tl(s->T0, t1);
+            break;
+        }
 
     case MO_64:
 #endif
@@ -3741,10 +3750,14 @@ static void gen_RORX(DisasContext *s, X86DecodedInsn *decode)
     switch (ot) {
     case MO_32:
 #ifdef TARGET_X86_64
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-        tcg_gen_rotri_i32(s->tmp2_i32, s->tmp2_i32, b);
-        tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
-        break;
+        {
+            TCGv_i32 tmp = tcg_temp_new_i32();
+
+            tcg_gen_trunc_tl_i32(tmp, s->T0);
+            tcg_gen_rotri_i32(tmp, tmp, b);
+            tcg_gen_extu_i32_tl(s->T0, tmp);
+            break;
+        }
 
     case MO_64:
 #endif
@@ -4330,7 +4343,7 @@ static void gen_VCVTSI2Sx(DisasContext *s, X86DecodedInsn *decode)
         }
         return;
     }
-    in = s->tmp2_i32;
+    in = tcg_temp_new_i32();
     tcg_gen_trunc_tl_i32(in, s->T1);
 #else
     in = s->T1;
@@ -4360,7 +4373,7 @@ static inline void gen_VCVTtSx2SI(DisasContext *s, X86DecodedInsn *decode,
         return;
     }
 
-    out = s->tmp2_i32;
+    out = tcg_temp_new_i32();
 #else
     out = s->T0;
 #endif
@@ -4412,7 +4425,7 @@ static void gen_VEXTRACTPS(DisasContext *s, X86DecodedInsn *decode)
     gen_pextr(s, decode, MO_32);
 }
 
-static void gen_vinsertps(DisasContext *s, X86DecodedInsn *decode)
+static void gen_vinsertps(DisasContext *s, X86DecodedInsn *decode, TCGv_i32 tmp)
 {
     int val = decode->immediate;
     int dest_word = (val >> 4) & 3;
@@ -4429,7 +4442,7 @@ static void gen_vinsertps(DisasContext *s, X86DecodedInsn *decode)
     }
 
     if (new_mask != (val & 15)) {
-        tcg_gen_st_i32(s->tmp2_i32, tcg_env,
+        tcg_gen_st_i32(tmp, tcg_env,
                        vector_elem_offset(&decode->op[0], MO_32, dest_word));
     }
 
@@ -4448,15 +4461,19 @@ static void gen_vinsertps(DisasContext *s, X86DecodedInsn *decode)
 static void gen_VINSERTPS_r(DisasContext *s, X86DecodedInsn *decode)
 {
     int val = decode->immediate;
-    tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_ld_i32(tmp, tcg_env,
                    vector_elem_offset(&decode->op[2], MO_32, (val >> 6) & 3));
-    gen_vinsertps(s, decode);
+    gen_vinsertps(s, decode, tmp);
 }
 
 static void gen_VINSERTPS_m(DisasContext *s, X86DecodedInsn *decode)
 {
-    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0, s->mem_index, MO_LEUL);
-    gen_vinsertps(s, decode);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_qemu_ld_i32(tmp, s->A0, s->mem_index, MO_LEUL);
+    gen_vinsertps(s, decode, tmp);
 }
 
 static void gen_VINSERTx128(DisasContext *s, X86DecodedInsn *decode)
@@ -4577,25 +4594,29 @@ static void gen_VMOVSD_ld(DisasContext *s, X86DecodedInsn *decode)
 static void gen_VMOVSS(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_ld_i32(s->tmp2_i32, OP_PTR2, offsetof(ZMMReg, ZMM_L(0)));
+    tcg_gen_ld_i32(tmp, OP_PTR2, offsetof(ZMMReg, ZMM_L(0)));
     tcg_gen_gvec_mov(MO_64, decode->op[0].offset, decode->op[1].offset, vec_len, vec_len);
-    tcg_gen_st_i32(s->tmp2_i32, OP_PTR0, offsetof(ZMMReg, ZMM_L(0)));
+    tcg_gen_st_i32(tmp, OP_PTR0, offsetof(ZMMReg, ZMM_L(0)));
 }
 
 static void gen_VMOVSS_ld(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0, s->mem_index, MO_LEUL);
+    tcg_gen_qemu_ld_i32(tmp, s->A0, s->mem_index, MO_LEUL);
     tcg_gen_gvec_dup_imm(MO_64, decode->op[0].offset, vec_len, vec_len, 0);
-    tcg_gen_st_i32(s->tmp2_i32, OP_PTR0, offsetof(ZMMReg, ZMM_L(0)));
+    tcg_gen_st_i32(tmp, OP_PTR0, offsetof(ZMMReg, ZMM_L(0)));
 }
 
 static void gen_VMOVSS_st(DisasContext *s, X86DecodedInsn *decode)
 {
-    tcg_gen_ld_i32(s->tmp2_i32, OP_PTR2, offsetof(ZMMReg, ZMM_L(0)));
-    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0, s->mem_index, MO_LEUL);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_ld_i32(tmp, OP_PTR2, offsetof(ZMMReg, ZMM_L(0)));
+    tcg_gen_qemu_st_i32(tmp, s->A0, s->mem_index, MO_LEUL);
 }
 
 static void gen_VPMASKMOV_st(DisasContext *s, X86DecodedInsn *decode)
-- 
2.49.0


