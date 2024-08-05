Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E955EC52D71
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 00:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saldZ-0007fY-Rw; Sun, 04 Aug 2024 20:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldY-0007bh-Sm
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldX-0002Iw-1q
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70eae5896bcso8560951b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 17:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722817902; x=1723422702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2FAvv3yZjIy3oYnoHY2EdlCQMFjiKoZMDRTSrJ4FWdU=;
 b=DGw77imu05A8s3Wm9ChBRvPP2bHqXr9CRSXCth994kMQ6p4uuyhnOALg4HgcBTgBe8
 wYf8ej5gjLQ8pfA7js+SDHnkDxaeNVjiNOIFOKmolqbYzIr0N87JVnB/t7PH7hJUFUvh
 7sc+xsQc0w3ssfyVuGqR/ckDcnDZzytnmk/dR+2DAzVDii+stZyLsXFM7xQvaWBc7ZVU
 QHgZ6iCvH7ikhUNrn2ilOyhBKa4O5p7MszRFm0HWuQHPcXhmW76Tc3OIne1A0KyHqp06
 QUbszlhOB+nBeydCW5KBFkY1sfuZoKtrmuIHauVLA3yB6WlV9g89n+ZQEIeNrglL2RNR
 U0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722817902; x=1723422702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2FAvv3yZjIy3oYnoHY2EdlCQMFjiKoZMDRTSrJ4FWdU=;
 b=oioJ6C3VZo6iWLkNEDNMJ625EOnaxpoyAmBElnm4RT7vzoNyMwj9CXHlY98WNxLY+/
 HlAtLKaAZ5IJp6I72kVMUJcM6XGyvkSDnfFPTxGhIr0yltsDRaRowuFDysmElTcxu4pT
 XHN9CuAOB8eeZOIm2ul3YHnl6C74swy/54evTjYYOjfIg2MhmxEBzGeA81W9/dJqPlbt
 bE77cOLIjjcQ8wmPWO9ci2FAiCzDNopsZykf6C9s9Qv0XhIqEsn8Qv1x/ckaAfQvH6gw
 UbwPI9iyl4ZQVcQ0p6M8suX0P2X4E/8PUnJr+Ta6A299lvIhXX2SBqvOgzbR5kzDa6zE
 UoBQ==
X-Gm-Message-State: AOJu0Yz672P3R8TBkR58JIVS+DQaU8cSlMvn6qOhrnP7nLqz/eoER3sZ
 EhOJlcIz39j54m2xR+RrIEzd8RX7E0nAfI4v94EUSBjcppjnGgQ7E0L50aAtJwfr7RViXCH+9Vk
 PKkm+yw==
X-Google-Smtp-Source: AGHT+IFaTP8oCUyXymoIl3zTm62gsDOW4sU49if+syXviCtCfc9ZQ/LZi+pDCHnf+Uw4SQP9eQ7Sgw==
X-Received: by 2002:a05:6a00:1407:b0:70d:3a45:5b44 with SMTP id
 d2e1a72fcca58-7106cfccce4mr13703097b3a.14.1722817901440; 
 Sun, 04 Aug 2024 17:31:41 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed16cb3sm4576038b3a.179.2024.08.04.17.31.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 17:31:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1] target/i386: Fix VSIB decode
Date: Mon,  5 Aug 2024 10:31:24 +1000
Message-ID: <20240805003130.1421051-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805003130.1421051-1-richard.henderson@linaro.org>
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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


