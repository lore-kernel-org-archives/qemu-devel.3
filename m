Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46A1C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 04:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZk0Y-0002Pd-JO; Fri, 02 Aug 2024 00:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZk0W-0002PA-4L
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 00:35:12 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZk0S-0002nh-Ei
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 00:35:10 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7093c94435bso2977688a34.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 21:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722573307; x=1723178107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2FAvv3yZjIy3oYnoHY2EdlCQMFjiKoZMDRTSrJ4FWdU=;
 b=cKAqAnnd3L9IkuglWXpuCOcsAYfdRBRzSZCfifa5VRjGaoXrSxrOL4jH5X1LAb/Llx
 uC+NeZ1GcQXwbqyj6kwPb8CvneUsZo9ND3gXw4uVwUVKbyOTASOXXcU0jVhb67Wd4gmj
 1RPxt3McbeNJ1jZdwt+s+Q3raV25+4I8sK4QfSiGvGrCBt1+R6/HD80NoA4vn2gKpqc6
 bxwsz2tBQxedEaOCVvf4knB431FyLj5vVInWobnwb0YXULnJsUFLdX9X/Wa7n6oDlg+n
 TUYXjE/hmb/L/tm9EuL+73l7LdV3Ij84PG9b9E5DxUKEROayCIV3Wyi9nBl6eNhDz/lK
 0+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722573307; x=1723178107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2FAvv3yZjIy3oYnoHY2EdlCQMFjiKoZMDRTSrJ4FWdU=;
 b=GqtoVwXHyuLZ0DkkuZDHyBNKOjHEffTf7RhHvF8HajjXBugTLnr//3ab58LNOJ9cuk
 OHeB/Ugsmy9y1RH40k1Oq3VoJnPBcrWEsfB8hgA8nEHm9q5NWQoIqOTW0iBStFG/GhZr
 TvZzAJEzCfi8AlyT7p/QGM/m2FaZuRI+R0fMmo6TR1lOW+GwVm03XnyGugz7NqfkMAkl
 AVOOMUMhYj74vLjNHGgp9YwOG6wbybjznNDg6yCAqjxWlX/ybiHIRncDkQFGFBB2xjsr
 PAGoXbcDcEezrqhXWiK34iMKMJV6U1sesbRqt1X2LAIpoiayJiGLdRhR3V+qKYDlb6Cv
 MiCA==
X-Gm-Message-State: AOJu0YzJQc+2PxHPzaxJXtNmsBeKaVLtaesSzo+PI65MSq5+58RV92BI
 NvMRuLJBv7GUXJwNuT+2/ibnseevsDgrfjdzGoUfE+x0muU1hTy+EG17D7EhxhN/SNwDgZGRvFT
 TTmYNsw==
X-Google-Smtp-Source: AGHT+IEHYecu1vWKjkcEpQqSy4Z7J9PoZRgLPQ5gdm7E8pdgrlEgoSa+SWJkXHJHugkQOodyFflbxg==
X-Received: by 2002:a05:6830:601c:b0:708:fd04:e7a0 with SMTP id
 46e09a7af769-709b995c44emr3235410a34.24.1722573307037; 
 Thu, 01 Aug 2024 21:35:07 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ecdff89sm585889b3a.103.2024.08.01.21.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 21:35:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH for-9.1] target/i386: Fix VSIB decode
Date: Fri,  2 Aug 2024 14:35:01 +1000
Message-ID: <20240802043501.823273-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With normal SIB, index == 4 indicates no index.
With VSIB, there is no exception for VR4/VR12.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2474
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c      | 20 ++++++++++----------
 target/i386/tcg/decode-new.c.inc |  3 ++-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index fb0d01b356..98f5fe61ed 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1534,7 +1534,7 @@ typedef struct AddressParts {
 } AddressParts;
 
 static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
-                                    int modrm)
+                                    int modrm, bool is_vsib)
 {
     int def_seg, base, index, scale, mod, rm;
     target_long disp;
@@ -1563,7 +1563,7 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
             int code = x86_ldub_code(env, s);
             scale = (code >> 6) & 3;
             index = ((code >> 3) & 7) | REX_X(s);
-            if (index == 4) {
+            if (index == 4 && !is_vsib) {
                 index = -1;  /* no index */
             }
             base = (code & 7) | REX_B(s);
@@ -1693,21 +1693,21 @@ static TCGv gen_lea_modrm_1(DisasContext *s, AddressParts a, bool is_vsib)
 
 static void gen_lea_modrm(CPUX86State *env, DisasContext *s, int modrm)
 {
-    AddressParts a = gen_lea_modrm_0(env, s, modrm);
+    AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
     TCGv ea = gen_lea_modrm_1(s, a, false);
     gen_lea_v_seg(s, ea, a.def_seg, s->override);
 }
 
 static void gen_nop_modrm(CPUX86State *env, DisasContext *s, int modrm)
 {
-    (void)gen_lea_modrm_0(env, s, modrm);
+    (void)gen_lea_modrm_0(env, s, modrm, false);
 }
 
 /* Used for BNDCL, BNDCU, BNDCN.  */
 static void gen_bndck(CPUX86State *env, DisasContext *s, int modrm,
                       TCGCond cond, TCGv_i64 bndv)
 {
-    AddressParts a = gen_lea_modrm_0(env, s, modrm);
+    AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
     TCGv ea = gen_lea_modrm_1(s, a, false);
 
     tcg_gen_extu_tl_i64(s->tmp1_i64, ea);
@@ -2428,7 +2428,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
     op = ((b & 7) << 3) | ((modrm >> 3) & 7);
     if (mod != 3) {
         /* memory op */
-        AddressParts a = gen_lea_modrm_0(env, s, modrm);
+        AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
         TCGv ea = gen_lea_modrm_1(s, a, false);
         TCGv last_addr = tcg_temp_new();
         bool update_fdp = true;
@@ -3089,7 +3089,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         rm = (modrm & 7) | REX_B(s);
         gen_op_mov_v_reg(s, MO_32, s->T1, reg);
         if (mod != 3) {
-            AddressParts a = gen_lea_modrm_0(env, s, modrm);
+            AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
             /* specific case: we need to add a displacement */
             gen_exts(ot, s->T1);
             tcg_gen_sari_tl(s->tmp0, s->T1, 3 + ot);
@@ -3646,7 +3646,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 }
             } else if (mod != 3) {
                 /* bndldx */
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
+                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
@@ -3690,7 +3690,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
+                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
                 if (a.base >= 0) {
                     tcg_gen_extu_tl_i64(cpu_bndl[reg], cpu_regs[a.base]);
                     if (!CODE64(s)) {
@@ -3751,7 +3751,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 }
             } else if (mod != 3) {
                 /* bndstx */
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
+                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d2da1d396d..b22210f45d 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1811,7 +1811,8 @@ static int decode_modrm(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     } else {
         op->has_ea = true;
         op->n = -1;
-        decode->mem = gen_lea_modrm_0(env, s, get_modrm(s, env));
+        decode->mem = gen_lea_modrm_0(env, s, modrm,
+                                      decode->e.vex_class == 12);
     }
     return modrm;
 }
-- 
2.43.0


