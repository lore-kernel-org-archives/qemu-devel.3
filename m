Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0C5C27C65
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrdl-0001Km-Em; Sat, 08 Jun 2024 04:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdk-0001KL-Cc
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdg-0001Mu-BH
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FUECajQPWPjmtofPoacZp7afQ8fFlVYlsYwwwxPFylo=;
 b=MGQPsrcITrQgFrvc9Ib/a5QLD/B3SbpHSRkl5r5zT5pWbc8ditv3Q8gaLd6dduATHYR4cY
 ovwxCrGMg8Xl3bK3o8BAmi0fwN5oKtiuR+blvsC6zqM+o8cTYiyktzb0/RhRbXNbUW4f+n
 nraYgXEAna19ThymSs0qC+xpomVX7wM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Bd77afk0NzukvNyBiGYNMg-1; Sat, 08 Jun 2024 04:41:24 -0400
X-MC-Unique: Bd77afk0NzukvNyBiGYNMg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6e8aa42033so64101666b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836082; x=1718440882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUECajQPWPjmtofPoacZp7afQ8fFlVYlsYwwwxPFylo=;
 b=HR2cmmKUglBHI7OxErAxA9vRf7cPg1IK2xIw7qgUQEKhW0Ng10cL+h2zVckzxegYAV
 kFhm2KS2HLbmlC70XjyjG1Ar9XJRX0SY6bZPbFb+S8vtJdeV8SV5ENWyb3dvha/7e1BD
 80BbikzxQF6/if/T/uKyyniJwgatqIjs2z5sSGkKPLqkzcKPXMIv/U7+ATRMjJY5iiQV
 GJ+l4wyGmfv76McGYE+Li4+QeARXTGx1DW1lrTf3ha3vtMFZPtClzreRDNC8LBCeCciO
 hdqsebtUTu7cSN85GjCVDhGQn+rmUTPzt1V8LSVDhlnNoDXBwaSwLNJPnzcgNPwbVJRm
 wJVg==
X-Gm-Message-State: AOJu0YzRMBCo4kDjTCupYuUNPY82heC8LWCo7WhwJ/U//IO8HzcRZC8W
 LBNDHI/YN2Ng80UD/c7Rje4BcIxIM32FD2gI/iDE/9ouMEJXNKPlbJJBAlj8yy/gz5Hj3nABBwg
 EuDeYMxZwVBBVMmIkIlOZotpkVgoZtd/tHe+dkr+rLBwql6bntjeQdn3p29bQ2cXHDh7zXjF7SK
 YGD1Ksm0VpDa0HoT8knVSmdkMfSa4Kd6zisjrE
X-Received: by 2002:a17:906:3ad7:b0:a6e:feae:e1df with SMTP id
 a640c23a62f3a-a6efeaee390mr69237866b.21.1717836081459; 
 Sat, 08 Jun 2024 01:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5U8goNXZW7okamGbHQzfli7AU7hwCmR1CeXmJNbT+GvQ5QTT0ZbSfxDMta3qvvpBbMgVIyg==
X-Received: by 2002:a17:906:3ad7:b0:a6e:feae:e1df with SMTP id
 a640c23a62f3a-a6efeaee390mr69235666b.21.1717836080076; 
 Sat, 08 Jun 2024 01:41:20 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80581870sm355982066b.25.2024.06.08.01.41.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/25] target/i386: remove CPUX86State argument from generator
 functions
Date: Sat,  8 Jun 2024 10:40:49 +0200
Message-ID: <20240608084113.2770363-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

CPUX86State argument would only be used to fetch bytes, but that has to be
done before the generator function is called.  So remove it, and all
temptation together with it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |   2 +-
 target/i386/tcg/decode-new.c.inc |   4 +-
 target/i386/tcg/emit.c.inc       | 572 +++++++++++++++----------------
 3 files changed, 289 insertions(+), 289 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 1f90cf96407..f704698575f 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -245,7 +245,7 @@ typedef struct X86DecodedInsn X86DecodedInsn;
 typedef void (*X86DecodeFunc)(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b);
 
 /* Code generation function.  */
-typedef void (*X86GenFunc)(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode);
+typedef void (*X86GenFunc)(DisasContext *s, X86DecodedInsn *decode);
 
 struct X86OpEntry {
     /* Based on the is_decode flags.  */
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index c2d8da8d14e..e7d88020481 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2590,7 +2590,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     }
     if (s->prefix & PREFIX_LOCK) {
         gen_load(s, &decode, 2, s->T1);
-        decode.e.gen(s, env, &decode);
+        decode.e.gen(s, &decode);
     } else {
         if (decode.op[0].unit == X86_OP_MMX) {
             compute_mmx_offset(&decode.op[0]);
@@ -2599,7 +2599,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         }
         gen_load(s, &decode, 1, s->T0);
         gen_load(s, &decode, 2, s->T1);
-        decode.e.gen(s, env, &decode);
+        decode.e.gen(s, &decode);
         gen_writeback(s, &decode, 0, s->T0);
     }
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 4be3d9a6fba..df7597c7e2f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -60,8 +60,8 @@ typedef void (*SSEFunc_0_eppppii)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
                                   TCGv_ptr reg_c, TCGv_ptr reg_d, TCGv_i32 even,
                                   TCGv_i32 odd);
 
-static void gen_JMP_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode);
-static void gen_JMP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode);
+static void gen_JMP_m(DisasContext *s, X86DecodedInsn *decode);
+static void gen_JMP(DisasContext *s, X86DecodedInsn *decode);
 
 static inline TCGv_i32 tcg_constant8u_i32(uint8_t val)
 {
@@ -446,7 +446,7 @@ static const SSEFunc_0_epp fns_3dnow[] = {
     [0xbf] = gen_helper_pavgusb,
 };
 
-static void gen_3dnow(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_3dnow(DisasContext *s, X86DecodedInsn *decode)
 {
     uint8_t b = decode->immediate;
     SSEFunc_0_epp fn = b < ARRAY_SIZE(fns_3dnow) ? fns_3dnow[b] : NULL;
@@ -479,7 +479,7 @@ static void gen_3dnow(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
  * f3 = v*ss Vss, Hss, Wps
  * f2 = v*sd Vsd, Hsd, Wps
  */
-static inline void gen_unary_fp_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_unary_fp_sse(DisasContext *s, X86DecodedInsn *decode,
                               SSEFunc_0_epp pd_xmm, SSEFunc_0_epp ps_xmm,
                               SSEFunc_0_epp pd_ymm, SSEFunc_0_epp ps_ymm,
                               SSEFunc_0_eppp sd, SSEFunc_0_eppp ss)
@@ -504,9 +504,9 @@ static inline void gen_unary_fp_sse(DisasContext *s, CPUX86State *env, X86Decode
     }
 }
 #define UNARY_FP_SSE(uname, lname)                                                 \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_unary_fp_sse(s, env, decode,                                               \
+    gen_unary_fp_sse(s, decode,                                                    \
                      gen_helper_##lname##pd_xmm,                                   \
                      gen_helper_##lname##ps_xmm,                                   \
                      gen_helper_##lname##pd_ymm,                                   \
@@ -522,7 +522,7 @@ UNARY_FP_SSE(VSQRT, sqrt)
  * f3 = v*ss Vss, Hss, Wps
  * f2 = v*sd Vsd, Hsd, Wps
  */
-static inline void gen_fp_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_fp_sse(DisasContext *s, X86DecodedInsn *decode,
                               SSEFunc_0_eppp pd_xmm, SSEFunc_0_eppp ps_xmm,
                               SSEFunc_0_eppp pd_ymm, SSEFunc_0_eppp ps_ymm,
                               SSEFunc_0_eppp sd, SSEFunc_0_eppp ss)
@@ -543,9 +543,9 @@ static inline void gen_fp_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn
 }
 
 #define FP_SSE(uname, lname)                                                       \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_fp_sse(s, env, decode,                                                     \
+    gen_fp_sse(s, decode,                                                          \
                gen_helper_##lname##pd_xmm,                                         \
                gen_helper_##lname##ps_xmm,                                         \
                gen_helper_##lname##pd_ymm,                                         \
@@ -561,7 +561,7 @@ FP_SSE(VDIV, div)
 FP_SSE(VMAX, max)
 
 #define FMA_SSE_PACKED(uname, ptr0, ptr1, ptr2, even, odd)                         \
-static void gen_##uname##Px(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname##Px(DisasContext *s, X86DecodedInsn *decode)               \
 {                                                                                  \
     SSEFunc_0_eppppii xmm = s->vex_w ? gen_helper_fma4pd_xmm : gen_helper_fma4ps_xmm; \
     SSEFunc_0_eppppii ymm = s->vex_w ? gen_helper_fma4pd_ymm : gen_helper_fma4ps_ymm; \
@@ -574,7 +574,7 @@ static void gen_##uname##Px(DisasContext *s, CPUX86State *env, X86DecodedInsn *d
 
 #define FMA_SSE(uname, ptr0, ptr1, ptr2, flags)                                    \
 FMA_SSE_PACKED(uname, ptr0, ptr1, ptr2, flags, flags)                              \
-static void gen_##uname##Sx(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname##Sx(DisasContext *s, X86DecodedInsn *decode)               \
 {                                                                                  \
     SSEFunc_0_eppppi fn = s->vex_w ? gen_helper_fma4sd : gen_helper_fma4ss;        \
                                                                                    \
@@ -607,10 +607,10 @@ FMA_SSE_PACKED(VFMSUBADD213, OP_PTR1, OP_PTR0, OP_PTR2, 0, float_muladd_negate_c
 FMA_SSE_PACKED(VFMSUBADD132, OP_PTR0, OP_PTR2, OP_PTR1, 0, float_muladd_negate_c)
 
 #define FP_UNPACK_SSE(uname, lname)                                                \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
     /* PS maps to the DQ integer instruction, PD maps to QDQ.  */                  \
-    gen_fp_sse(s, env, decode,                                                     \
+    gen_fp_sse(s, decode,                                                          \
                gen_helper_##lname##qdq_xmm,                                        \
                gen_helper_##lname##dq_xmm,                                         \
                gen_helper_##lname##qdq_ymm,                                        \
@@ -624,7 +624,7 @@ FP_UNPACK_SSE(VUNPCKHPx, punpckh)
  * 00 = v*ps Vps, Wpd
  * f3 = v*ss Vss, Wps
  */
-static inline void gen_unary_fp32_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_unary_fp32_sse(DisasContext *s, X86DecodedInsn *decode,
                                       SSEFunc_0_epp ps_xmm,
                                       SSEFunc_0_epp ps_ymm,
                                       SSEFunc_0_eppp ss)
@@ -649,9 +649,9 @@ illegal_op:
     gen_illegal_opcode(s);
 }
 #define UNARY_FP32_SSE(uname, lname)                                               \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_unary_fp32_sse(s, env, decode,                                             \
+    gen_unary_fp32_sse(s, decode,                                                  \
                        gen_helper_##lname##ps_xmm,                                 \
                        gen_helper_##lname##ps_ymm,                                 \
                        gen_helper_##lname##ss);                                    \
@@ -663,7 +663,7 @@ UNARY_FP32_SSE(VRCP, rcp)
  * 66 = v*pd Vpd, Hpd, Wpd
  * f2 = v*ps Vps, Hps, Wps
  */
-static inline void gen_horizontal_fp_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_horizontal_fp_sse(DisasContext *s, X86DecodedInsn *decode,
                                          SSEFunc_0_eppp pd_xmm, SSEFunc_0_eppp ps_xmm,
                                          SSEFunc_0_eppp pd_ymm, SSEFunc_0_eppp ps_ymm)
 {
@@ -674,9 +674,9 @@ static inline void gen_horizontal_fp_sse(DisasContext *s, CPUX86State *env, X86D
     fn(tcg_env, OP_PTR0, OP_PTR1, OP_PTR2);
 }
 #define HORIZONTAL_FP_SSE(uname, lname)                                            \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_horizontal_fp_sse(s, env, decode,                                          \
+    gen_horizontal_fp_sse(s, decode,                                               \
                           gen_helper_##lname##pd_xmm, gen_helper_##lname##ps_xmm,  \
                           gen_helper_##lname##pd_ymm, gen_helper_##lname##ps_ymm); \
 }
@@ -684,7 +684,7 @@ HORIZONTAL_FP_SSE(VHADD, hadd)
 HORIZONTAL_FP_SSE(VHSUB, hsub)
 HORIZONTAL_FP_SSE(VADDSUB, addsub)
 
-static inline void gen_ternary_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_ternary_sse(DisasContext *s, X86DecodedInsn *decode,
                                    int op3, SSEFunc_0_epppp xmm, SSEFunc_0_epppp ymm)
 {
     SSEFunc_0_epppp fn = s->vex_l ? ymm : xmm;
@@ -695,21 +695,21 @@ static inline void gen_ternary_sse(DisasContext *s, CPUX86State *env, X86Decoded
     fn(tcg_env, OP_PTR0, OP_PTR1, OP_PTR2, ptr3);
 }
 #define TERNARY_SSE(uname, uvname, lname)                                          \
-static void gen_##uvname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uvname(DisasContext *s, X86DecodedInsn *decode)                  \
 {                                                                                  \
-    gen_ternary_sse(s, env, decode, (uint8_t)decode->immediate >> 4,               \
+    gen_ternary_sse(s, decode, (uint8_t)decode->immediate >> 4,                    \
                     gen_helper_##lname##_xmm, gen_helper_##lname##_ymm);           \
 }                                                                                  \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_ternary_sse(s, env, decode, 0,                                             \
+    gen_ternary_sse(s, decode, 0,                                                  \
                   gen_helper_##lname##_xmm, gen_helper_##lname##_ymm);             \
 }
 TERNARY_SSE(BLENDVPS, VBLENDVPS, blendvps)
 TERNARY_SSE(BLENDVPD, VBLENDVPD, blendvpd)
 TERNARY_SSE(PBLENDVB, VPBLENDVB, pblendvb)
 
-static inline void gen_binary_imm_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_binary_imm_sse(DisasContext *s, X86DecodedInsn *decode,
                                       SSEFunc_0_epppi xmm, SSEFunc_0_epppi ymm)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -721,9 +721,9 @@ static inline void gen_binary_imm_sse(DisasContext *s, CPUX86State *env, X86Deco
 }
 
 #define BINARY_IMM_SSE(uname, lname)                                               \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_binary_imm_sse(s, env, decode,                                             \
+    gen_binary_imm_sse(s, decode,                                                  \
                        gen_helper_##lname##_xmm,                                   \
                        gen_helper_##lname##_ymm);                                  \
 }
@@ -739,7 +739,7 @@ BINARY_IMM_SSE(PCLMULQDQ,  pclmulqdq)
 
 
 #define UNARY_INT_GVEC(uname, func, ...)                                           \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
     int vec_len = vector_len(s, decode);                                          \
                                                                                    \
@@ -757,7 +757,7 @@ UNARY_INT_GVEC(VPBROADCASTQ,   tcg_gen_gvec_dup_mem, MO_64)
 
 
 #define BINARY_INT_GVEC(uname, func, ...)                                          \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
     int vec_len = vector_len(s, decode);                                          \
                                                                                    \
@@ -816,7 +816,7 @@ BINARY_INT_GVEC(PXOR,    tcg_gen_gvec_xor, MO_64)
  * These are really the same encoding, because 1) V is the same as P when VEX.V
  * is not present 2) P and Q are the same as H and W apart from MM/XMM
  */
-static inline void gen_binary_int_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_binary_int_sse(DisasContext *s, X86DecodedInsn *decode,
                                       SSEFunc_0_eppp mmx, SSEFunc_0_eppp xmm, SSEFunc_0_eppp ymm)
 {
     assert(!!mmx == !!(decode->e.special == X86_SPECIAL_MMX));
@@ -837,9 +837,9 @@ static inline void gen_binary_int_sse(DisasContext *s, CPUX86State *env, X86Deco
 
 
 #define BINARY_INT_MMX(uname, lname)                                               \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_binary_int_sse(s, env, decode,                                             \
+    gen_binary_int_sse(s, decode,                                                  \
                           gen_helper_##lname##_mmx,                                \
                           gen_helper_##lname##_xmm,                                \
                           gen_helper_##lname##_ymm);                               \
@@ -886,9 +886,9 @@ BINARY_INT_MMX(PMULHRSW,  pmulhrsw)
 
 /* Instructions with no MMX equivalent.  */
 #define BINARY_INT_SSE(uname, lname)                                               \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_binary_int_sse(s, env, decode,                                             \
+    gen_binary_int_sse(s, decode,                                                  \
                           NULL,                                                    \
                           gen_helper_##lname##_xmm,                                \
                           gen_helper_##lname##_ymm);                               \
@@ -911,7 +911,7 @@ BINARY_INT_SSE(VAESENC, aesenc)
 BINARY_INT_SSE(VAESENCLAST, aesenclast)
 
 #define UNARY_CMP_SSE(uname, lname)                                                \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
     if (!s->vex_l) {                                                               \
         gen_helper_##lname##_xmm(tcg_env, OP_PTR1, OP_PTR2);                       \
@@ -924,7 +924,7 @@ UNARY_CMP_SSE(VPTEST,     ptest)
 UNARY_CMP_SSE(VTESTPS,    vtestps)
 UNARY_CMP_SSE(VTESTPD,    vtestpd)
 
-static inline void gen_unary_int_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_unary_int_sse(DisasContext *s, X86DecodedInsn *decode,
                                      SSEFunc_0_epp xmm, SSEFunc_0_epp ymm)
 {
     if (!s->vex_l) {
@@ -935,9 +935,9 @@ static inline void gen_unary_int_sse(DisasContext *s, CPUX86State *env, X86Decod
 }
 
 #define UNARY_INT_SSE(uname, lname)                                                \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_unary_int_sse(s, env, decode,                                              \
+    gen_unary_int_sse(s, decode,                                                   \
                       gen_helper_##lname##_xmm,                                    \
                       gen_helper_##lname##_ymm);                                   \
 }
@@ -969,7 +969,7 @@ UNARY_INT_SSE(VCVTTPS2DQ, cvttps2dq)
 UNARY_INT_SSE(VCVTPH2PS, cvtph2ps)
 
 
-static inline void gen_unary_imm_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_unary_imm_sse(DisasContext *s, X86DecodedInsn *decode,
                                      SSEFunc_0_ppi xmm, SSEFunc_0_ppi ymm)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -981,9 +981,9 @@ static inline void gen_unary_imm_sse(DisasContext *s, CPUX86State *env, X86Decod
 }
 
 #define UNARY_IMM_SSE(uname, lname)                                                \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_unary_imm_sse(s, env, decode,                                              \
+    gen_unary_imm_sse(s, decode,                                                   \
                       gen_helper_##lname##_xmm,                                    \
                       gen_helper_##lname##_ymm);                                   \
 }
@@ -996,7 +996,7 @@ UNARY_IMM_SSE(VPERMQ,      vpermq)
 UNARY_IMM_SSE(VPERMILPS_i, vpermilps_imm)
 UNARY_IMM_SSE(VPERMILPD_i, vpermilpd_imm)
 
-static inline void gen_unary_imm_fp_sse(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_unary_imm_fp_sse(DisasContext *s, X86DecodedInsn *decode,
                                         SSEFunc_0_eppi xmm, SSEFunc_0_eppi ymm)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -1008,9 +1008,9 @@ static inline void gen_unary_imm_fp_sse(DisasContext *s, CPUX86State *env, X86De
 }
 
 #define UNARY_IMM_FP_SSE(uname, lname)                                             \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_unary_imm_fp_sse(s, env, decode,                                           \
+    gen_unary_imm_fp_sse(s, decode,                                                \
                       gen_helper_##lname##_xmm,                                    \
                       gen_helper_##lname##_ymm);                                   \
 }
@@ -1018,7 +1018,7 @@ static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
 UNARY_IMM_FP_SSE(VROUNDPS,    roundps)
 UNARY_IMM_FP_SSE(VROUNDPD,    roundpd)
 
-static inline void gen_vexw_avx(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_vexw_avx(DisasContext *s, X86DecodedInsn *decode,
                                 SSEFunc_0_eppp d_xmm, SSEFunc_0_eppp q_xmm,
                                 SSEFunc_0_eppp d_ymm, SSEFunc_0_eppp q_ymm)
 {
@@ -1030,9 +1030,9 @@ static inline void gen_vexw_avx(DisasContext *s, CPUX86State *env, X86DecodedIns
 
 /* VEX.W affects whether to operate on 32- or 64-bit elements.  */
 #define VEXW_AVX(uname, lname)                                                     \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_vexw_avx(s, env, decode,                                                   \
+    gen_vexw_avx(s, decode,                                                        \
                  gen_helper_##lname##d_xmm, gen_helper_##lname##q_xmm,             \
                  gen_helper_##lname##d_ymm, gen_helper_##lname##q_ymm);            \
 }
@@ -1042,7 +1042,7 @@ VEXW_AVX(VPSRAV,    vpsrav)
 VEXW_AVX(VPMASKMOV, vpmaskmov)
 
 /* Same as above, but with extra arguments to the helper.  */
-static inline void gen_vsib_avx(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_vsib_avx(DisasContext *s, X86DecodedInsn *decode,
                                 SSEFunc_0_epppti d_xmm, SSEFunc_0_epppti q_xmm,
                                 SSEFunc_0_epppti d_ymm, SSEFunc_0_epppti q_ymm)
 {
@@ -1066,29 +1066,29 @@ static inline void gen_vsib_avx(DisasContext *s, CPUX86State *env, X86DecodedIns
     }
 }
 #define VSIB_AVX(uname, lname)                                                     \
-static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode) \
+static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)                   \
 {                                                                                  \
-    gen_vsib_avx(s, env, decode,                                                   \
+    gen_vsib_avx(s, decode,                                                        \
                  gen_helper_##lname##d_xmm, gen_helper_##lname##q_xmm,             \
                  gen_helper_##lname##d_ymm, gen_helper_##lname##q_ymm);            \
 }
 VSIB_AVX(VPGATHERD, vpgatherd)
 VSIB_AVX(VPGATHERQ, vpgatherq)
 
-static void gen_AAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_AAA(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_helper_aaa(tcg_env);
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
-static void gen_AAD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_AAD(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_aad(s->T0, s->T0, s->T1);
     prepare_update1_cc(decode, s, CC_OP_LOGICB);
 }
 
-static void gen_AAM(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_AAM(DisasContext *s, X86DecodedInsn *decode)
 {
     if (decode->immediate == 0) {
         gen_exception(s, EXCP00_DIVZ);
@@ -1098,14 +1098,14 @@ static void gen_AAM(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_AAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_AAS(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_helper_aas(tcg_env);
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
-static void gen_ADC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_ADC(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
     TCGv c_in = tcg_temp_new();
@@ -1123,7 +1123,7 @@ static void gen_ADC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 }
 
 /* ADCX/ADOX do not have memory operands and can use set_cc_op.  */
-static void gen_ADCOX(DisasContext *s, CPUX86State *env, MemOp ot, int cc_op)
+static void gen_ADCOX(DisasContext *s, MemOp ot, int cc_op)
 {
     int opposite_cc_op;
     TCGv carry_in = NULL;
@@ -1170,12 +1170,12 @@ static void gen_ADCOX(DisasContext *s, CPUX86State *env, MemOp ot, int cc_op)
     }
 }
 
-static void gen_ADCX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_ADCX(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_ADCOX(s, env, decode->op[0].ot, CC_OP_ADCX);
+    gen_ADCOX(s, decode->op[0].ot, CC_OP_ADCX);
 }
 
-static void gen_ADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_ADD(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
 
@@ -1188,12 +1188,12 @@ static void gen_ADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_ADDB + ot);
 }
 
-static void gen_ADOX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_ADOX(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_ADCOX(s, env, decode->op[0].ot, CC_OP_ADOX);
+    gen_ADCOX(s, decode->op[0].ot, CC_OP_ADOX);
 }
 
-static void gen_AND(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_AND(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
 
@@ -1206,7 +1206,7 @@ static void gen_AND(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
-static void gen_ANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_ANDN(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
@@ -1214,7 +1214,7 @@ static void gen_ANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
-static void gen_ARPL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_ARPL(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv zf = tcg_temp_new();
     TCGv flags = tcg_temp_new();
@@ -1235,7 +1235,7 @@ static void gen_ARPL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     decode->cc_op = CC_OP_EFLAGS;
 }
 
-static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_BEXTR(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     TCGv bound = tcg_constant_tl(ot == MO_64 ? 63 : 31);
@@ -1264,7 +1264,7 @@ static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 }
 
 /* BLSI do not have memory operands and can use set_cc_op.  */
-static void gen_BLSI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_BLSI(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
@@ -1276,7 +1276,7 @@ static void gen_BLSI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 }
 
 /* BLSMSK do not have memory operands and can use set_cc_op.  */
-static void gen_BLSMSK(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_BLSMSK(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
@@ -1288,7 +1288,7 @@ static void gen_BLSMSK(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
 }
 
 /* BLSR do not have memory operands and can use set_cc_op.  */
-static void gen_BLSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_BLSR(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
@@ -1299,7 +1299,7 @@ static void gen_BLSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     set_cc_op(s, CC_OP_BMILGB + ot);
 }
 
-static void gen_BOUND(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_BOUND(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 op = tcg_temp_new_i32();
     tcg_gen_trunc_tl_i32(op, s->T0);
@@ -1310,7 +1310,7 @@ static void gen_BOUND(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_BSWAP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_BSWAP(DisasContext *s, X86DecodedInsn *decode)
 {
 #ifdef TARGET_X86_64
     if (s->dflag == MO_64) {
@@ -1321,7 +1321,7 @@ static void gen_BSWAP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_bswap32_tl(s->T0, s->T0, TCG_BSWAP_OZ);
 }
 
-static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_BZHI(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     TCGv bound = tcg_constant_tl(ot == MO_64 ? 63 : 31);
@@ -1341,24 +1341,24 @@ static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
-static void gen_CALL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CALL(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_push_v(s, eip_next_tl(s));
-    gen_JMP(s, env, decode);
+    gen_JMP(s, decode);
 }
 
-static void gen_CALL_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CALL_m(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_push_v(s, eip_next_tl(s));
-    gen_JMP_m(s, env, decode);
+    gen_JMP_m(s, decode);
 }
 
-static void gen_CALLF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CALLF(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_far_call(s);
 }
 
-static void gen_CALLF_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CALLF_m(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
 
@@ -1368,41 +1368,41 @@ static void gen_CALLF_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     gen_far_call(s);
 }
 
-static void gen_CBW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CBW(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp src_ot = decode->op[0].ot - 1;
 
     tcg_gen_ext_tl(s->T0, s->T0, src_ot | MO_SIGN);
 }
 
-static void gen_CLC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CLC(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_compute_eflags(s);
     tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, ~CC_C);
 }
 
-static void gen_CLD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CLD(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_st_i32(tcg_constant_i32(1), tcg_env, offsetof(CPUX86State, df));
 }
 
-static void gen_CLI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CLI(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_reset_eflags(s, IF_MASK);
 }
 
-static void gen_CMC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CMC(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_compute_eflags(s);
     tcg_gen_xori_tl(cpu_cc_src, cpu_cc_src, CC_C);
 }
 
-static void gen_CMOVcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CMOVcc(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_cmovcc1(s, decode->b & 0xf, s->T0, s->T1);
 }
 
-static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGLabel *label_top = gen_new_label();
     TCGLabel *label_bottom = gen_new_label();
@@ -1505,7 +1505,7 @@ static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     decode->cc_op = CC_OP_SUBB + ot;
 }
 
-static void gen_CMPS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CMPS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
@@ -1515,7 +1515,7 @@ static void gen_CMPS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_CRC32(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CRC32(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
 
@@ -1523,7 +1523,7 @@ static void gen_CRC32(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_helper_crc32(s->T0, s->tmp2_i32, s->T1, tcg_constant_i32(8 << ot));
 }
 
-static void gen_CVTPI2Px(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CVTPI2Px(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_enter_mmx(tcg_env);
     if (s->prefix & PREFIX_DATA) {
@@ -1533,7 +1533,7 @@ static void gen_CVTPI2Px(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
     }
 }
 
-static void gen_CVTPx2PI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CVTPx2PI(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_enter_mmx(tcg_env);
     if (s->prefix & PREFIX_DATA) {
@@ -1543,7 +1543,7 @@ static void gen_CVTPx2PI(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
     }
 }
 
-static void gen_CVTTPx2PI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CVTTPx2PI(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_enter_mmx(tcg_env);
     if (s->prefix & PREFIX_DATA) {
@@ -1553,28 +1553,28 @@ static void gen_CVTTPx2PI(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
-static void gen_CWD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_CWD(DisasContext *s, X86DecodedInsn *decode)
 {
     int shift = 8 << decode->op[0].ot;
 
     tcg_gen_sextract_tl(s->T0, s->T0, shift - 1, 1);
 }
 
-static void gen_DAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_DAA(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_helper_daa(tcg_env);
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
-static void gen_DAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_DAS(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_helper_das(tcg_env);
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
-static void gen_DEC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_DEC(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
 
@@ -1588,7 +1588,7 @@ static void gen_DEC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update_cc_incdec(decode, s, CC_OP_DECB + ot);
 }
 
-static void gen_DIV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_DIV(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
 
@@ -1611,17 +1611,17 @@ static void gen_DIV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_EMMS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_EMMS(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_emms(tcg_env);
 }
 
-static void gen_ENTER(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_ENTER(DisasContext *s, X86DecodedInsn *decode)
 {
    gen_enter(s, decode->op[1].imm, decode->op[2].imm);
 }
 
-static void gen_EXTRQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_EXTRQ_i(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 length = tcg_constant_i32(decode->immediate & 63);
     TCGv_i32 index = tcg_constant_i32((decode->immediate >> 8) & 63);
@@ -1629,12 +1629,12 @@ static void gen_EXTRQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     gen_helper_extrq_i(tcg_env, OP_PTR0, index, length);
 }
 
-static void gen_EXTRQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_EXTRQ_r(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_extrq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
-static void gen_HLT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_HLT(DisasContext *s, X86DecodedInsn *decode)
 {
 #ifdef CONFIG_SYSTEM_ONLY
     gen_update_cc_op(s);
@@ -1644,7 +1644,7 @@ static void gen_HLT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 #endif
 }
 
-static void gen_IDIV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_IDIV(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
 
@@ -1667,7 +1667,7 @@ static void gen_IDIV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_IMUL3(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_IMUL3(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     TCGv cc_src_rhs;
@@ -1730,7 +1730,7 @@ static void gen_IMUL3(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_MULB + ot);
 }
 
-static void gen_IMUL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_IMUL(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
     TCGv cc_src_rhs;
@@ -1788,7 +1788,7 @@ static void gen_IMUL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_MULB + ot);
 }
 
-static void gen_IN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_IN(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     TCGv_i32 port = tcg_temp_new_i32();
@@ -1804,7 +1804,7 @@ static void gen_IN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_bpt_io(s, port, ot);
 }
 
-static void gen_INC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_INC(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
 
@@ -1818,7 +1818,7 @@ static void gen_INC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update_cc_incdec(decode, s, CC_OP_INCB + ot);
 }
 
-static void gen_INS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_INS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
     TCGv_i32 port = tcg_temp_new_i32();
@@ -1838,7 +1838,7 @@ static void gen_INS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_INSERTQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_INSERTQ_i(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 length = tcg_constant_i32(decode->immediate & 63);
     TCGv_i32 index = tcg_constant_i32((decode->immediate >> 8) & 63);
@@ -1846,17 +1846,17 @@ static void gen_INSERTQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     gen_helper_insertq_i(tcg_env, OP_PTR0, OP_PTR1, index, length);
 }
 
-static void gen_INSERTQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_INSERTQ_r(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_insertq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
-static void gen_INT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_INT(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_interrupt(s, decode->immediate);
 }
 
-static void gen_INT1(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_INT1(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_update_eip_next(s);
@@ -1864,19 +1864,19 @@ static void gen_INT1(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_INT3(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_INT3(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_interrupt(s, EXCP03_INT3);
 }
 
-static void gen_INTO(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_INTO(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_update_eip_cur(s);
     gen_helper_into(tcg_env, cur_insn_len_i32(s));
 }
 
-static void gen_IRET(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_IRET(DisasContext *s, X86DecodedInsn *decode)
 {
     if (!PE(s) || VM86(s)) {
         gen_helper_iret_real(tcg_env, tcg_constant_i32(s->dflag - 1));
@@ -1888,13 +1888,13 @@ static void gen_IRET(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     s->base.is_jmp = DISAS_EOB_ONLY;
 }
 
-static void gen_Jcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_Jcc(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_bnd_jmp(s);
     gen_jcc(s, decode->b & 0xf, decode->immediate);
 }
 
-static void gen_JCXZ(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_JCXZ(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGLabel *taken = gen_new_label();
 
@@ -1903,25 +1903,25 @@ static void gen_JCXZ(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_conditional_jump_labels(s, decode->immediate, NULL, taken);
 }
 
-static void gen_JMP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_JMP(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_jmp_rel(s, s->dflag, decode->immediate, 0);
 }
 
-static void gen_JMP_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_JMP_m(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_op_jmp_v(s, s->T0);
     gen_bnd_jmp(s);
     s->base.is_jmp = DISAS_JUMP;
 }
 
-static void gen_JMPF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_JMPF(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_far_jmp(s);
 }
 
-static void gen_JMPF_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_JMPF_m(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
 
@@ -1931,7 +1931,7 @@ static void gen_JMPF_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
     gen_far_jmp(s);
 }
 
-static void gen_LAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LAHF(DisasContext *s, X86DecodedInsn *decode)
 {
     if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM)) {
         return gen_illegal_opcode(s);
@@ -1942,13 +1942,13 @@ static void gen_LAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_deposit_tl(cpu_regs[R_EAX], cpu_regs[R_EAX], s->T0, 8, 8);
 }
 
-static void gen_LDMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LDMXCSR(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);
     gen_helper_ldmxcsr(tcg_env, s->tmp2_i32);
 }
 
-static void gen_lxx_seg(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode, int seg)
+static void gen_lxx_seg(DisasContext *s, X86DecodedInsn *decode, int seg)
 {
     MemOp ot = decode->op[0].ot;
 
@@ -1960,37 +1960,37 @@ static void gen_lxx_seg(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     gen_movl_seg(s, seg, s->T1);
 }
 
-static void gen_LDS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LDS(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_lxx_seg(s, env, decode, R_DS);
+    gen_lxx_seg(s, decode, R_DS);
 }
 
-static void gen_LEA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LEA(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_mov_tl(s->T0, s->A0);
 }
 
-static void gen_LEAVE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LEAVE(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_leave(s);
 }
 
-static void gen_LES(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LES(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_lxx_seg(s, env, decode, R_ES);
+    gen_lxx_seg(s, decode, R_ES);
 }
 
-static void gen_LFS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LFS(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_lxx_seg(s, env, decode, R_FS);
+    gen_lxx_seg(s, decode, R_FS);
 }
 
-static void gen_LGS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LGS(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_lxx_seg(s, env, decode, R_GS);
+    gen_lxx_seg(s, decode, R_GS);
 }
 
-static void gen_LODS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LODS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
@@ -2000,7 +2000,7 @@ static void gen_LODS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_LOOP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LOOP(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGLabel *taken = gen_new_label();
 
@@ -2010,7 +2010,7 @@ static void gen_LOOP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_conditional_jump_labels(s, decode->immediate, NULL, taken);
 }
 
-static void gen_LOOPE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LOOPE(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGLabel *taken = gen_new_label();
     TCGLabel *not_taken = gen_new_label();
@@ -2022,7 +2022,7 @@ static void gen_LOOPE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_conditional_jump_labels(s, decode->immediate, not_taken, taken);
 }
 
-static void gen_LOOPNE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LOOPNE(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGLabel *taken = gen_new_label();
     TCGLabel *not_taken = gen_new_label();
@@ -2034,18 +2034,18 @@ static void gen_LOOPNE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
     gen_conditional_jump_labels(s, decode->immediate, not_taken, taken);
 }
 
-static void gen_LSS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_LSS(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_lxx_seg(s, env, decode, R_SS);
+    gen_lxx_seg(s, decode, R_SS);
 }
 
-static void gen_MOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MOV(DisasContext *s, X86DecodedInsn *decode)
 {
     /* nothing to do! */
 }
 #define gen_NOP gen_MOV
 
-static void gen_MASKMOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MASKMOV(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_lea_v_seg(s, cpu_regs[R_EDI], R_DS, s->override);
 
@@ -2056,7 +2056,7 @@ static void gen_MASKMOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     }
 }
 
-static void gen_MOVBE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MOVBE(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
@@ -2068,7 +2068,7 @@ static void gen_MOVBE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_MOVD_from(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MOVD_from(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
 
@@ -2086,7 +2086,7 @@ static void gen_MOVD_from(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
-static void gen_MOVD_to(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MOVD_to(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
     int vec_len = vector_len(s, decode);
@@ -2108,12 +2108,12 @@ static void gen_MOVD_to(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     }
 }
 
-static void gen_MOVDQ(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MOVDQ(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_store_sse(s, decode, decode->op[2].offset);
 }
 
-static void gen_MOVMSK(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MOVMSK(DisasContext *s, X86DecodedInsn *decode)
 {
     typeof(gen_helper_movmskps_ymm) *ps, *pd, *fn;
     ps = s->vex_l ? gen_helper_movmskps_ymm : gen_helper_movmskps_xmm;
@@ -2123,7 +2123,7 @@ static void gen_MOVMSK(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
     tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
 }
 
-static void gen_MOVQ(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MOVQ(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
     int lo_ofs = vector_elem_offset(&decode->op[0], MO_64, 0);
@@ -2145,14 +2145,14 @@ static void gen_MOVQ(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_MOVq_dq(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MOVq_dq(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_enter_mmx(tcg_env);
     /* Otherwise the same as any other movq.  */
-    return gen_MOVQ(s, env, decode);
+    return gen_MOVQ(s, decode);
 }
 
-static void gen_MOVS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MOVS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
@@ -2162,7 +2162,7 @@ static void gen_MOVS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_MUL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MUL(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
 
@@ -2213,7 +2213,7 @@ static void gen_MUL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     decode->cc_op = CC_OP_MULB + ot;
 }
 
-static void gen_MULX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_MULX(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
@@ -2239,7 +2239,7 @@ static void gen_MULX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_NEG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_NEG(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     TCGv oldv = tcg_temp_new();
@@ -2266,7 +2266,7 @@ static void gen_NEG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     decode->cc_op = CC_OP_SUBB + ot;
 }
 
-static void gen_NOT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_NOT(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
@@ -2279,7 +2279,7 @@ static void gen_NOT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_OR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_OR(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
 
@@ -2292,7 +2292,7 @@ static void gen_OR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
-static void gen_OUT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_OUT(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
     TCGv_i32 port = tcg_temp_new_i32();
@@ -2309,7 +2309,7 @@ static void gen_OUT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_bpt_io(s, port, ot);
 }
 
-static void gen_OUTS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_OUTS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
     TCGv_i32 port = tcg_temp_new_i32();
@@ -2328,7 +2328,7 @@ static void gen_OUTS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_PALIGNR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PALIGNR(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     if (!(s->prefix & PREFIX_DATA)) {
@@ -2340,7 +2340,7 @@ static void gen_PALIGNR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     }
 }
 
-static void gen_PANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PANDN(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -2350,7 +2350,7 @@ static void gen_PANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
                       decode->op[1].offset, vec_len, vec_len);
 }
 
-static void gen_PAUSE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PAUSE(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_update_eip_next(s);
@@ -2358,14 +2358,14 @@ static void gen_PAUSE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_PCMPESTRI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PCMPESTRI(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     gen_helper_pcmpestri_xmm(tcg_env, OP_PTR1, OP_PTR2, imm);
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
-static void gen_PCMPESTRM(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PCMPESTRM(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     gen_helper_pcmpestrm_xmm(tcg_env, OP_PTR1, OP_PTR2, imm);
@@ -2376,14 +2376,14 @@ static void gen_PCMPESTRM(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
-static void gen_PCMPISTRI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PCMPISTRI(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     gen_helper_pcmpistri_xmm(tcg_env, OP_PTR1, OP_PTR2, imm);
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
-static void gen_PCMPISTRM(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PCMPISTRM(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     gen_helper_pcmpistrm_xmm(tcg_env, OP_PTR1, OP_PTR2, imm);
@@ -2394,17 +2394,17 @@ static void gen_PCMPISTRM(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
-static void gen_PDEP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PDEP(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_pdep(s->T0, s->T0, s->T1);
 }
 
-static void gen_PEXT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PEXT(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_pext(s->T0, s->T0, s->T1);
 }
 
-static inline void gen_pextr(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode, MemOp ot)
+static inline void gen_pextr(DisasContext *s, X86DecodedInsn *decode, MemOp ot)
 {
     int vec_len = vector_len(s, decode);
     int mask = (vec_len >> ot) - 1;
@@ -2430,23 +2430,23 @@ static inline void gen_pextr(DisasContext *s, CPUX86State *env, X86DecodedInsn *
     }
 }
 
-static void gen_PEXTRB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PEXTRB(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_pextr(s, env, decode, MO_8);
+    gen_pextr(s, decode, MO_8);
 }
 
-static void gen_PEXTRW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PEXTRW(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_pextr(s, env, decode, MO_16);
+    gen_pextr(s, decode, MO_16);
 }
 
-static void gen_PEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PEXTR(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
-    gen_pextr(s, env, decode, ot);
+    gen_pextr(s, decode, ot);
 }
 
-static inline void gen_pinsr(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode, MemOp ot)
+static inline void gen_pinsr(DisasContext *s, X86DecodedInsn *decode, MemOp ot)
 {
     int vec_len = vector_len(s, decode);
     int mask = (vec_len >> ot) - 1;
@@ -2477,19 +2477,19 @@ static inline void gen_pinsr(DisasContext *s, CPUX86State *env, X86DecodedInsn *
     }
 }
 
-static void gen_PINSRB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PINSRB(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_pinsr(s, env, decode, MO_8);
+    gen_pinsr(s, decode, MO_8);
 }
 
-static void gen_PINSRW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PINSRW(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_pinsr(s, env, decode, MO_16);
+    gen_pinsr(s, decode, MO_16);
 }
 
-static void gen_PINSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PINSR(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_pinsr(s, env, decode, decode->op[2].ot);
+    gen_pinsr(s, decode, decode->op[2].ot);
 }
 
 static void gen_pmovmskb_i64(TCGv_i64 d, TCGv_i64 s)
@@ -2529,7 +2529,7 @@ static void gen_pmovmskb_vec(unsigned vece, TCGv_vec d, TCGv_vec s)
     tcg_gen_or_vec(vece, d, d, t);
 }
 
-static void gen_PMOVMSKB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
 {
     static const TCGOpcode vecop_list[] = { INDEX_op_shli_vec, 0 };
     static const GVecGen2 g = {
@@ -2573,7 +2573,7 @@ static void gen_PMOVMSKB(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
     }
 }
 
-static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_POP(DisasContext *s, X86DecodedInsn *decode)
 {
     X86DecodedOp *op = &decode->op[0];
     MemOp ot = gen_pop_T0(s);
@@ -2587,12 +2587,12 @@ static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_pop_update(s, ot);
 }
 
-static void gen_POPA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_POPA(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_popa(s);
 }
 
-static void gen_POPF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_POPF(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot;
     int mask = TF_MASK | AC_MASK | ID_MASK | NT_MASK;
@@ -2614,13 +2614,13 @@ static void gen_POPF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     s->base.is_jmp = DISAS_EOB_NEXT;
 }
 
-static void gen_PSHUFW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSHUFW(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     gen_helper_pshufw_mmx(OP_PTR0, OP_PTR1, imm);
 }
 
-static void gen_PSRLW_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSRLW_i(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -2633,7 +2633,7 @@ static void gen_PSRLW_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     }
 }
 
-static void gen_PSLLW_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSLLW_i(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -2646,7 +2646,7 @@ static void gen_PSLLW_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     }
 }
 
-static void gen_PSRAW_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSRAW_i(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -2658,7 +2658,7 @@ static void gen_PSRAW_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
                       decode->immediate, vec_len, vec_len);
 }
 
-static void gen_PSRLD_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSRLD_i(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -2671,7 +2671,7 @@ static void gen_PSRLD_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     }
 }
 
-static void gen_PSLLD_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSLLD_i(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -2684,7 +2684,7 @@ static void gen_PSLLD_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     }
 }
 
-static void gen_PSRAD_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSRAD_i(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -2696,7 +2696,7 @@ static void gen_PSRAD_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
                       decode->immediate, vec_len, vec_len);
 }
 
-static void gen_PSRLQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSRLQ_i(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -2709,7 +2709,7 @@ static void gen_PSRLQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     }
 }
 
-static void gen_PSLLQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSLLQ_i(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -2736,7 +2736,7 @@ static TCGv_ptr make_imm8u_xmm_vec(uint8_t imm, int vec_len)
     return ptr;
 }
 
-static void gen_PSRLDQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSRLDQ_i(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
     TCGv_ptr imm_vec = make_imm8u_xmm_vec(decode->immediate, vec_len);
@@ -2748,7 +2748,7 @@ static void gen_PSRLDQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
     }
 }
 
-static void gen_PSLLDQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PSLLDQ_i(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
     TCGv_ptr imm_vec = make_imm8u_xmm_vec(decode->immediate, vec_len);
@@ -2760,17 +2760,17 @@ static void gen_PSLLDQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
     }
 }
 
-static void gen_PUSH(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PUSH(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_push_v(s, s->T1);
 }
 
-static void gen_PUSHA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PUSHA(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_pusha(s);
 }
 
-static void gen_PUSHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_helper_read_eflags(s->T0, tcg_env);
@@ -2967,7 +2967,7 @@ static void gen_rotc_mod(MemOp ot, TCGv count)
  * length - count, because (length-1) - (count-1) can be computed with
  * a XOR, and that is commutative unlike subtraction.
  */
-static void gen_RCL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
 {
     bool have_1bit_cin, can_be_zero;
     TCGv count;
@@ -3019,7 +3019,7 @@ static void gen_RCL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_RCR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
 {
     bool have_1bit_cin, can_be_zero;
     TCGv count;
@@ -3072,7 +3072,7 @@ static void gen_RCR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_RET(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 {
     int16_t adjust = decode->e.op2 == X86_TYPE_I ? decode->immediate : 0;
 
@@ -3083,7 +3083,7 @@ static void gen_RET(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     s->base.is_jmp = DISAS_JUMP;
 }
 
-static void gen_RETF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_RETF(DisasContext *s, X86DecodedInsn *decode)
 {
     int16_t adjust = decode->e.op2 == X86_TYPE_I ? decode->immediate : 0;
 
@@ -3154,7 +3154,7 @@ static void gen_rot_carry(X86DecodedInsn *decode, TCGv result,
     }
 }
 
-static void gen_ROL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_ROL(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
@@ -3182,7 +3182,7 @@ static void gen_ROL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_rot_overflow(decode, s->T0, old, can_be_zero, count);
 }
 
-static void gen_ROR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_ROR(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
@@ -3211,7 +3211,7 @@ static void gen_ROR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_rot_overflow(decode, s->T0, old, can_be_zero, count);
 }
 
-static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_RORX(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     int mask = ot == MO_64 ? 63 : 31;
@@ -3235,7 +3235,7 @@ static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_SAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SAHF(DisasContext *s, X86DecodedInsn *decode)
 {
     if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM)) {
         return gen_illegal_opcode(s);
@@ -3247,7 +3247,7 @@ static void gen_SAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
 }
 
-static void gen_SALC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SALC(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_compute_eflags_c(s, s->T0);
     tcg_gen_neg_tl(s->T0, s->T0);
@@ -3283,7 +3283,7 @@ static void gen_shift_dynamic_flags(DisasContext *s, X86DecodedInsn *decode, TCG
                         old_cc_op, tcg_constant_i32(cc_op));
 }
 
-static void gen_SAR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SAR(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
@@ -3305,7 +3305,7 @@ static void gen_SAR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_SARX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SARX(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     int mask;
@@ -3315,7 +3315,7 @@ static void gen_SARX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
 }
 
-static void gen_SBB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     TCGv c_in = tcg_temp_new();
@@ -3337,7 +3337,7 @@ static void gen_SBB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update3_cc(decode, s, CC_OP_SBBB + ot, c_in);
 }
 
-static void gen_SCAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SCAS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
@@ -3347,27 +3347,27 @@ static void gen_SCAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_SETcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SETcc(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_setcc1(s, decode->b & 0xf, s->T0);
 }
 
-static void gen_SHA1NEXTE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHA1NEXTE(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_sha1nexte(OP_PTR0, OP_PTR1, OP_PTR2);
 }
 
-static void gen_SHA1MSG1(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHA1MSG1(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_sha1msg1(OP_PTR0, OP_PTR1, OP_PTR2);
 }
 
-static void gen_SHA1MSG2(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHA1MSG2(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_sha1msg2(OP_PTR0, OP_PTR1, OP_PTR2);
 }
 
-static void gen_SHA1RNDS4(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHA1RNDS4(DisasContext *s, X86DecodedInsn *decode)
 {
     switch(decode->immediate & 3) {
     case 0:
@@ -3385,17 +3385,17 @@ static void gen_SHA1RNDS4(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
-static void gen_SHA256MSG1(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHA256MSG1(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_sha256msg1(OP_PTR0, OP_PTR1, OP_PTR2);
 }
 
-static void gen_SHA256MSG2(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHA256MSG2(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_sha256msg2(OP_PTR0, OP_PTR1, OP_PTR2);
 }
 
-static void gen_SHA256RNDS2(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHA256RNDS2(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 wk0 = tcg_temp_new_i32();
     TCGv_i32 wk1 = tcg_temp_new_i32();
@@ -3406,7 +3406,7 @@ static void gen_SHA256RNDS2(DisasContext *s, CPUX86State *env, X86DecodedInsn *d
     gen_helper_sha256rnds2(OP_PTR0, OP_PTR1, OP_PTR2, wk0, wk1);
 }
 
-static void gen_SHL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHL(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
@@ -3428,7 +3428,7 @@ static void gen_SHL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_SHLX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHLX(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     int mask;
@@ -3438,7 +3438,7 @@ static void gen_SHLX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_shl_tl(s->T0, s->T0, s->T1);
 }
 
-static void gen_SHR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHR(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
@@ -3460,7 +3460,7 @@ static void gen_SHR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_SHRX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SHRX(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     int mask;
@@ -3470,37 +3470,37 @@ static void gen_SHRX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_shr_tl(s->T0, s->T0, s->T1);
 }
 
-static void gen_STC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_STC(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_compute_eflags(s);
     tcg_gen_ori_tl(cpu_cc_src, cpu_cc_src, CC_C);
 }
 
-static void gen_STD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_STD(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_st_i32(tcg_constant_i32(-1), tcg_env, offsetof(CPUX86State, df));
 }
 
-static void gen_STI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_STI(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_set_eflags(s, IF_MASK);
     s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
 }
 
-static void gen_VAESKEYGEN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VAESKEYGEN(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     assert(!s->vex_l);
     gen_helper_aeskeygenassist_xmm(tcg_env, OP_PTR0, OP_PTR1, imm);
 }
 
-static void gen_STMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_STMXCSR(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_update_mxcsr(tcg_env);
     tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, mxcsr));
 }
 
-static void gen_STOS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_STOS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
@@ -3510,7 +3510,7 @@ static void gen_STOS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_SUB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_SUB(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
 
@@ -3526,12 +3526,12 @@ static void gen_SUB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_SUBB + ot);
 }
 
-static void gen_UD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_UD(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_illegal_opcode(s);
 }
 
-static void gen_VAESIMC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VAESIMC(DisasContext *s, X86DecodedInsn *decode)
 {
     assert(!s->vex_l);
     gen_helper_aesimc_xmm(tcg_env, OP_PTR0, OP_PTR2);
@@ -3586,7 +3586,7 @@ static const SSEFunc_0_eppp gen_helper_cmp_funcs[32][6] = {
 };
 #undef SSE_CMP
 
-static void gen_VCMP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCMP(DisasContext *s, X86DecodedInsn *decode)
 {
     int index = decode->immediate & (s->prefix & PREFIX_VEX ? 31 : 7);
     int b =
@@ -3597,7 +3597,7 @@ static void gen_VCMP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_helper_cmp_funcs[index][b](tcg_env, OP_PTR0, OP_PTR1, OP_PTR2);
 }
 
-static void gen_VCOMI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCOMI(DisasContext *s, X86DecodedInsn *decode)
 {
     SSEFunc_0_epp fn;
     fn = s->prefix & PREFIX_DATA ? gen_helper_comisd : gen_helper_comiss;
@@ -3605,7 +3605,7 @@ static void gen_VCOMI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
-static void gen_VCVTPD2PS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCVTPD2PS(DisasContext *s, X86DecodedInsn *decode)
 {
     if (s->vex_l) {
         gen_helper_cvtpd2ps_ymm(tcg_env, OP_PTR0, OP_PTR2);
@@ -3614,7 +3614,7 @@ static void gen_VCVTPD2PS(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
-static void gen_VCVTPS2PD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCVTPS2PD(DisasContext *s, X86DecodedInsn *decode)
 {
     if (s->vex_l) {
         gen_helper_cvtps2pd_ymm(tcg_env, OP_PTR0, OP_PTR2);
@@ -3623,9 +3623,9 @@ static void gen_VCVTPS2PD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
-static void gen_VCVTPS2PH(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCVTPS2PH(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_unary_imm_fp_sse(s, env, decode,
+    gen_unary_imm_fp_sse(s, decode,
                       gen_helper_cvtps2ph_xmm,
                       gen_helper_cvtps2ph_ymm);
     /*
@@ -3637,17 +3637,17 @@ static void gen_VCVTPS2PH(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
-static void gen_VCVTSD2SS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCVTSD2SS(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_cvtsd2ss(tcg_env, OP_PTR0, OP_PTR1, OP_PTR2);
 }
 
-static void gen_VCVTSS2SD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCVTSS2SD(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_cvtss2sd(tcg_env, OP_PTR0, OP_PTR1, OP_PTR2);
 }
 
-static void gen_VCVTSI2Sx(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCVTSI2Sx(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
     TCGv_i32 in;
@@ -3677,7 +3677,7 @@ static void gen_VCVTSI2Sx(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
-static inline void gen_VCVTtSx2SI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_VCVTtSx2SI(DisasContext *s, X86DecodedInsn *decode,
                                   SSEFunc_i_ep ss2si, SSEFunc_l_ep ss2sq,
                                   SSEFunc_i_ep sd2si, SSEFunc_l_ep sd2sq)
 {
@@ -3715,21 +3715,21 @@ static inline void gen_VCVTtSx2SI(DisasContext *s, CPUX86State *env, X86DecodedI
 #define gen_helper_cvttsd2sq NULL
 #endif
 
-static void gen_VCVTSx2SI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCVTSx2SI(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_VCVTtSx2SI(s, env, decode,
+    gen_VCVTtSx2SI(s, decode,
                    gen_helper_cvtss2si, gen_helper_cvtss2sq,
                    gen_helper_cvtsd2si, gen_helper_cvtsd2sq);
 }
 
-static void gen_VCVTTSx2SI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCVTTSx2SI(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_VCVTtSx2SI(s, env, decode,
+    gen_VCVTtSx2SI(s, decode,
                    gen_helper_cvttss2si, gen_helper_cvttss2sq,
                    gen_helper_cvttsd2si, gen_helper_cvttsd2sq);
 }
 
-static void gen_VEXTRACTx128(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VEXTRACTx128(DisasContext *s, X86DecodedInsn *decode)
 {
     int mask = decode->immediate & 1;
     int src_ofs = vector_elem_offset(&decode->op[1], MO_128, mask);
@@ -3741,12 +3741,12 @@ static void gen_VEXTRACTx128(DisasContext *s, CPUX86State *env, X86DecodedInsn *
     }
 }
 
-static void gen_VEXTRACTPS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VEXTRACTPS(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_pextr(s, env, decode, MO_32);
+    gen_pextr(s, decode, MO_32);
 }
 
-static void gen_vinsertps(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_vinsertps(DisasContext *s, X86DecodedInsn *decode)
 {
     int val = decode->immediate;
     int dest_word = (val >> 4) & 3;
@@ -3779,21 +3779,21 @@ static void gen_vinsertps(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
-static void gen_VINSERTPS_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VINSERTPS_r(DisasContext *s, X86DecodedInsn *decode)
 {
     int val = decode->immediate;
     tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
                    vector_elem_offset(&decode->op[2], MO_32, (val >> 6) & 3));
-    gen_vinsertps(s, env, decode);
+    gen_vinsertps(s, decode);
 }
 
-static void gen_VINSERTPS_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VINSERTPS_m(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0, s->mem_index, MO_LEUL);
-    gen_vinsertps(s, env, decode);
+    gen_vinsertps(s, decode);
 }
 
-static void gen_VINSERTx128(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VINSERTx128(DisasContext *s, X86DecodedInsn *decode)
 {
     int mask = decode->immediate & 1;
     tcg_gen_gvec_mov(MO_64,
@@ -3804,7 +3804,7 @@ static void gen_VINSERTx128(DisasContext *s, CPUX86State *env, X86DecodedInsn *d
                      decode->op[1].offset + offsetof(YMMReg, YMM_X(!mask)), 16, 16);
 }
 
-static inline void gen_maskmov(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
+static inline void gen_maskmov(DisasContext *s, X86DecodedInsn *decode,
                                SSEFunc_0_eppt xmm, SSEFunc_0_eppt ymm)
 {
     if (!s->vex_l) {
@@ -3814,17 +3814,17 @@ static inline void gen_maskmov(DisasContext *s, CPUX86State *env, X86DecodedInsn
     }
 }
 
-static void gen_VMASKMOVPD_st(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMASKMOVPD_st(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_maskmov(s, env, decode, gen_helper_vpmaskmovq_st_xmm, gen_helper_vpmaskmovq_st_ymm);
+    gen_maskmov(s, decode, gen_helper_vpmaskmovq_st_xmm, gen_helper_vpmaskmovq_st_ymm);
 }
 
-static void gen_VMASKMOVPS_st(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMASKMOVPS_st(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_maskmov(s, env, decode, gen_helper_vpmaskmovd_st_xmm, gen_helper_vpmaskmovd_st_ymm);
+    gen_maskmov(s, decode, gen_helper_vpmaskmovd_st_xmm, gen_helper_vpmaskmovd_st_ymm);
 }
 
-static void gen_VMOVHPx_ld(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVHPx_ld(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_ldq_env_A0(s, decode->op[0].offset + offsetof(XMMReg, XMM_Q(1)));
     if (decode->op[0].offset != decode->op[1].offset) {
@@ -3833,12 +3833,12 @@ static void gen_VMOVHPx_ld(DisasContext *s, CPUX86State *env, X86DecodedInsn *de
     }
 }
 
-static void gen_VMOVHPx_st(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVHPx_st(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_stq_env_A0(s, decode->op[2].offset + offsetof(XMMReg, XMM_Q(1)));
 }
 
-static void gen_VMOVHPx(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVHPx(DisasContext *s, X86DecodedInsn *decode)
 {
     if (decode->op[0].offset != decode->op[2].offset) {
         tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[2].offset + offsetof(XMMReg, XMM_Q(1)));
@@ -3850,7 +3850,7 @@ static void gen_VMOVHPx(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     }
 }
 
-static void gen_VMOVHLPS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVHLPS(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[2].offset + offsetof(XMMReg, XMM_Q(1)));
     tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
@@ -3860,7 +3860,7 @@ static void gen_VMOVHLPS(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
     }
 }
 
-static void gen_VMOVLHPS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVLHPS(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_ld_i64(s->tmp1_i64, tcg_env, decode->op[2].offset);
     tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(1)));
@@ -3875,7 +3875,7 @@ static void gen_VMOVLHPS(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
  * Use a gvec move to move everything above the bottom 64 bits.
  */
 
-static void gen_VMOVLPx(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVLPx(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -3884,7 +3884,7 @@ static void gen_VMOVLPx(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     tcg_gen_st_i64(s->tmp1_i64, tcg_env, decode->op[0].offset + offsetof(XMMReg, XMM_Q(0)));
 }
 
-static void gen_VMOVLPx_ld(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVLPx_ld(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -3893,13 +3893,13 @@ static void gen_VMOVLPx_ld(DisasContext *s, CPUX86State *env, X86DecodedInsn *de
     tcg_gen_st_i64(s->tmp1_i64, OP_PTR0, offsetof(ZMMReg, ZMM_Q(0)));
 }
 
-static void gen_VMOVLPx_st(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVLPx_st(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_ld_i64(s->tmp1_i64, OP_PTR2, offsetof(ZMMReg, ZMM_Q(0)));
     tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEUQ);
 }
 
-static void gen_VMOVSD_ld(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVSD_ld(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i64 zero = tcg_constant_i64(0);
 
@@ -3908,7 +3908,7 @@ static void gen_VMOVSD_ld(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     tcg_gen_st_i64(s->tmp1_i64, OP_PTR0, offsetof(ZMMReg, ZMM_Q(0)));
 }
 
-static void gen_VMOVSS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVSS(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -3917,7 +3917,7 @@ static void gen_VMOVSS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
     tcg_gen_st_i32(s->tmp2_i32, OP_PTR0, offsetof(ZMMReg, ZMM_L(0)));
 }
 
-static void gen_VMOVSS_ld(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVSS_ld(DisasContext *s, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
 
@@ -3926,55 +3926,55 @@ static void gen_VMOVSS_ld(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     tcg_gen_st_i32(s->tmp2_i32, OP_PTR0, offsetof(ZMMReg, ZMM_L(0)));
 }
 
-static void gen_VMOVSS_st(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VMOVSS_st(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_ld_i32(s->tmp2_i32, OP_PTR2, offsetof(ZMMReg, ZMM_L(0)));
     tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0, s->mem_index, MO_LEUL);
 }
 
-static void gen_VPMASKMOV_st(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VPMASKMOV_st(DisasContext *s, X86DecodedInsn *decode)
 {
     if (s->vex_w) {
-        gen_VMASKMOVPD_st(s, env, decode);
+        gen_VMASKMOVPD_st(s, decode);
     } else {
-        gen_VMASKMOVPS_st(s, env, decode);
+        gen_VMASKMOVPS_st(s, decode);
     }
 }
 
-static void gen_VPERMD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VPERMD(DisasContext *s, X86DecodedInsn *decode)
 {
     assert(s->vex_l);
     gen_helper_vpermd_ymm(OP_PTR0, OP_PTR1, OP_PTR2);
 }
 
-static void gen_VPERM2x128(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VPERM2x128(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     assert(s->vex_l);
     gen_helper_vpermdq_ymm(OP_PTR0, OP_PTR1, OP_PTR2, imm);
 }
 
-static void gen_VPHMINPOSUW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VPHMINPOSUW(DisasContext *s, X86DecodedInsn *decode)
 {
     assert(!s->vex_l);
     gen_helper_phminposuw_xmm(tcg_env, OP_PTR0, OP_PTR2);
 }
 
-static void gen_VROUNDSD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VROUNDSD(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     assert(!s->vex_l);
     gen_helper_roundsd_xmm(tcg_env, OP_PTR0, OP_PTR1, OP_PTR2, imm);
 }
 
-static void gen_VROUNDSS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VROUNDSS(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     assert(!s->vex_l);
     gen_helper_roundss_xmm(tcg_env, OP_PTR0, OP_PTR1, OP_PTR2, imm);
 }
 
-static void gen_VSHUF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VSHUF(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant_i32(decode->immediate);
     SSEFunc_0_pppi ps, pd, fn;
@@ -3984,7 +3984,7 @@ static void gen_VSHUF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     fn(OP_PTR0, OP_PTR1, OP_PTR2, imm);
 }
 
-static void gen_VUCOMI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VUCOMI(DisasContext *s, X86DecodedInsn *decode)
 {
     SSEFunc_0_epp fn;
     fn = s->prefix & PREFIX_DATA ? gen_helper_ucomisd : gen_helper_ucomiss;
@@ -3992,7 +3992,7 @@ static void gen_VUCOMI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
-static void gen_VZEROALL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VZEROALL(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_ptr ptr = tcg_temp_new_ptr();
 
@@ -4001,7 +4001,7 @@ static void gen_VZEROALL(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
                       tcg_constant_ptr(CPU_NB_REGS * sizeof(ZMMReg)));
 }
 
-static void gen_VZEROUPPER(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VZEROUPPER(DisasContext *s, X86DecodedInsn *decode)
 {
     int i;
 
@@ -4011,7 +4011,7 @@ static void gen_VZEROUPPER(DisasContext *s, CPUX86State *env, X86DecodedInsn *de
     }
 }
 
-static void gen_WAIT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_WAIT(DisasContext *s, X86DecodedInsn *decode)
 {
     if ((s->flags & (HF_MP_MASK | HF_TS_MASK)) == (HF_MP_MASK | HF_TS_MASK)) {
         gen_NM_exception(s);
@@ -4022,7 +4022,7 @@ static void gen_WAIT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_XCHG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_XCHG(DisasContext *s, X86DecodedInsn *decode)
 {
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_atomic_xchg_tl(s->T0, s->A0, s->T1,
@@ -4036,7 +4036,7 @@ static void gen_XCHG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
-static void gen_XLAT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_XLAT(DisasContext *s, X86DecodedInsn *decode)
 {
     /* AL is already zero-extended into s->T0.  */
     tcg_gen_add_tl(s->A0, cpu_regs[R_EBX], s->T0);
@@ -4044,7 +4044,7 @@ static void gen_XLAT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_op_ld_v(s, MO_8, s->T0, s->A0);
 }
 
-static void gen_XOR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_XOR(DisasContext *s, X86DecodedInsn *decode)
 {
     /* special case XOR reg, reg */
     if (decode->op[1].unit == X86_OP_INT &&
-- 
2.45.1


