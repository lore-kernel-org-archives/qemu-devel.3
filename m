Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D5EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawe0-0000FJ-7S; Mon, 05 Aug 2024 08:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sawdq-000079-S0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sawdn-0001QY-Ly
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722860202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeuQ0ics8c/eTrxVuF4ictoz8iprxKsLXbs2qAfHIOw=;
 b=G0i4RUz/lXFtibW9U7p9Yu/pdKghvTJQAY78EpMTatuCUiW79uiswjdbgqcwkBQ4aeaLwi
 nGI8GHjIwb7nRd6g+jAcKQbIqVzj4sT80iI8R5utZSIDUMoWZK1Sr9lnSxnx2TFmOk2Paq
 d6CSJXEzGxoI+5cqRauHR9WIfKZczD4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-gnkDMmM2MvC1sfGEzz2odw-1; Mon, 05 Aug 2024 08:16:41 -0400
X-MC-Unique: gnkDMmM2MvC1sfGEzz2odw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7d63fbf4afso836545066b.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 05:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722860199; x=1723464999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jeuQ0ics8c/eTrxVuF4ictoz8iprxKsLXbs2qAfHIOw=;
 b=XNCv0Rg5Qs6HY0jAuyzL4EqUNsJC68kUmArVINqlLbaK0ZpTg5XCDIJNagXgDFnB0g
 myE0qku2lCB7W6iaM37goNsexzcxrfRQX9LTxYlxQjgylWnQx1a96NIm1+Djas+2VBch
 Ux44q6WES5lE4+VC4UcQo4huDmSrtUTY5X1iLiCVQuuywOiESG4zO+ZH8r9+7gI/+VNw
 Ajf+GRxdxd0cyCgMOgJJa96FMDgpT9Cn9njxusNSU93yr4xoyFZ8DG3WZp6wwPHFgGK+
 dDr3BUUUjXix+qZThzikIUUIXV1L6Jxl6cltbLnCsNjiPqn99uI21Lmqjjq9xmgHP1IE
 T5Xw==
X-Gm-Message-State: AOJu0YyuOjT9qCkRkv48dZq+6nq5AOR5dIXkWD5+j+u3VSKhCnTPnDuI
 3iwsPcF2RlqT6vSuh1D1bMxzJBa8cTVa1euRtNF6tlam4d8rqCEIHtjRY10DI5ZbLoiS6RvNICg
 YEyHKZ75xf6IFsc51ybMJL5dKIjcRkjun1nTf5HHi2xeL4AuRwg+ki5JTq84GVaahVV02QJjD3i
 vEgc5oBXxJ/JhhLTzR3+k4AbFvhWuq74c6+qqY
X-Received: by 2002:a17:906:fe0b:b0:a72:41e7:fef4 with SMTP id
 a640c23a62f3a-a7dc510ccfamr739339466b.68.1722860199243; 
 Mon, 05 Aug 2024 05:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY35hosXg/zamiBXZLp+bRexfmHTODKDx+pV2w9XegeCNz6wo86RlT24O9RF/TdjNkZg+c+w==
X-Received: by 2002:a17:906:fe0b:b0:a72:41e7:fef4 with SMTP id
 a640c23a62f3a-a7dc510ccfamr739337266b.68.1722860198804; 
 Mon, 05 Aug 2024 05:16:38 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d4378fsm444723666b.117.2024.08.05.05.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:16:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 2/2] target/i386: Fix VSIB decode
Date: Mon,  5 Aug 2024 14:16:32 +0200
Message-ID: <20240805121632.482610-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805121632.482610-1-pbonzini@redhat.com>
References: <20240805121632.482610-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

With normal SIB, index == 4 indicates no index.
With VSIB, there is no exception for VR4/VR12.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2474
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240805003130.1421051-3-richard.henderson@linaro.org
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 20 ++++++++++----------
 target/i386/tcg/decode-new.c.inc |  3 ++-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 95bad55bf46..b72864bf014 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1523,7 +1523,7 @@ typedef struct AddressParts {
 } AddressParts;
 
 static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
-                                    int modrm)
+                                    int modrm, bool is_vsib)
 {
     int def_seg, base, index, scale, mod, rm;
     target_long disp;
@@ -1552,7 +1552,7 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
             int code = x86_ldub_code(env, s);
             scale = (code >> 6) & 3;
             index = ((code >> 3) & 7) | REX_X(s);
-            if (index == 4) {
+            if (index == 4 && !is_vsib) {
                 index = -1;  /* no index */
             }
             base = (code & 7) | REX_B(s);
@@ -1682,21 +1682,21 @@ static TCGv gen_lea_modrm_1(DisasContext *s, AddressParts a, bool is_vsib)
 
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
@@ -2417,7 +2417,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
     op = ((b & 7) << 3) | ((modrm >> 3) & 7);
     if (mod != 3) {
         /* memory op */
-        AddressParts a = gen_lea_modrm_0(env, s, modrm);
+        AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
         TCGv ea = gen_lea_modrm_1(s, a, false);
         TCGv last_addr = tcg_temp_new();
         bool update_fdp = true;
@@ -3078,7 +3078,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         rm = (modrm & 7) | REX_B(s);
         gen_op_mov_v_reg(s, MO_32, s->T1, reg);
         if (mod != 3) {
-            AddressParts a = gen_lea_modrm_0(env, s, modrm);
+            AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
             /* specific case: we need to add a displacement */
             gen_exts(ot, s->T1);
             tcg_gen_sari_tl(s->tmp0, s->T1, 3 + ot);
@@ -3635,7 +3635,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 }
             } else if (mod != 3) {
                 /* bndldx */
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
+                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
@@ -3679,7 +3679,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
+                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
                 if (a.base >= 0) {
                     tcg_gen_extu_tl_i64(cpu_bndl[reg], cpu_regs[a.base]);
                     if (!CODE64(s)) {
@@ -3740,7 +3740,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 }
             } else if (mod != 3) {
                 /* bndstx */
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
+                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d2da1d396d5..b22210f45d9 100644
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
2.45.2


