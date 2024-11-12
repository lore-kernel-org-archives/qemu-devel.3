Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0691D42BB5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuZP-0003HO-RI; Tue, 12 Nov 2024 12:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZJ-0003Gx-NX
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:45 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZH-0003in-WF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:45 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d55f0cf85so3969637f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 09:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731432042; x=1732036842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59cNDEmNz5TpVPbqppyEPx5Ct3XXDPh0MWWyNan5nN4=;
 b=TXHTp9JtGd1/6tu3qe9PMnrNPGQa671kmBu2vq7GdrHOjcI6gbKopyoh9qtpE7YWo3
 giHJDZvkrAsym+281pNmDExosBc8+IxgbZV54+m5/Yttp8o69RL+RQZ5dl7ScJrjkX34
 EMCLQ4dnLxS6Pf5gqNmICWFosbVNIoxO0DUijorgqz7ZgljXHtfxzqQaSsZ/R1tOuSgE
 GBgECoQFPZ/gQDQKeC58q8Tg/16AdFioV6rtlmbhDkuLWPhxxktSYr0Mx6/FGgJecnH5
 oinfiELLZBIBB/T0bib2Eb41yQ+Y92crJwoQsRnrRDPaf+AS9i5O/ubaOY4I+87FcMJ1
 caFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731432042; x=1732036842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59cNDEmNz5TpVPbqppyEPx5Ct3XXDPh0MWWyNan5nN4=;
 b=DqAClROuMO9M7O/dvIK1jYJzCp2NilBzdSQQ+oABLcSA5TRYI8/IEuUC42LzHpyIAB
 FArtvc4HQgW0/vwAS4xjoLoOF6DJ3WuIsdeMbF5kUfuJKqaq8+UnL9jApKq+Txj7ITl4
 9YLNBvgg5krJl+P5REDTct9NVhBR/3xno6rxArhWbqLM7AQBXQbThE9P70+AQM0PCXjc
 CPTjIskGNuCWT0qAz5G9plmWMna/LbWyQM/6qq1hXXZeMLJf+NuJzT3Df2ddFBQyV8eL
 WIEyv8xH0JPx2DO3/3zMBF7EoYScWd4DhyHbclxIor57cqE4mtnWy9BUcdknkCSowOiP
 ymNQ==
X-Gm-Message-State: AOJu0YwwXLXxgrXJhByMFIe8ZwcxfeEm8pO41+KhZpeSN+jaiGA7MUQP
 KQDB1JVPMPtqgltQhwvQS4tMl3BerGsJgk3+n9YdcNUr6isADw4sKHxQ/aV8nQbiJhQjl3qSK9B
 J
X-Google-Smtp-Source: AGHT+IF9soyFJMhlp4BgLaDwxiRJ+hRGHBKD6yd6SJePTxbkxSKtwOsHAmqwWTkEB8PHJ+vNecS09w==
X-Received: by 2002:a5d:5f50:0:b0:37d:4d6c:e0ef with SMTP id
 ffacd0b85a97d-381f183f64dmr15849103f8f.43.1731432042095; 
 Tue, 12 Nov 2024 09:20:42 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970f85sm16234038f8f.6.2024.11.12.09.20.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 09:20:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/6] target/mips: Have gen_[d]lsa() callers add 1 to shift
 amount argument
Date: Tue, 12 Nov 2024 18:20:19 +0100
Message-ID: <20241112172022.88348-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172022.88348-1-philmd@linaro.org>
References: <20241112172022.88348-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Having the callee add 1 to shift amount is misleading (see the
NM_LSA case in decode_nanomips_32_48_opc() where we have to
manually substract 1). Rather have the callers pass a modified
$sa.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_translate.c           | 4 ++--
 target/mips/tcg/rel6_translate.c          | 4 ++--
 target/mips/tcg/translate_addr_const.c    | 4 ++--
 target/mips/tcg/micromips_translate.c.inc | 2 +-
 target/mips/tcg/nanomips_translate.c.inc  | 7 +------
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 75cf80a20e..82b149922f 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -780,7 +780,7 @@ TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -788,5 +788,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_translate.c
index 59f237ba3b..363bc86491 100644
--- a/target/mips/tcg/rel6_translate.c
+++ b/target/mips/tcg/rel6_translate.c
@@ -23,7 +23,7 @@ bool trans_REMOVED(DisasContext *ctx, arg_REMOVED *a)
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -31,5 +31,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
diff --git a/target/mips/tcg/translate_addr_const.c b/target/mips/tcg/translate_addr_const.c
index 6f4b39f715..1d140e918d 100644
--- a/target/mips/tcg/translate_addr_const.c
+++ b/target/mips/tcg/translate_addr_const.c
@@ -26,7 +26,7 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa + 1);
+    tcg_gen_shli_tl(t0, t0, sa);
     tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
     tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
     return true;
@@ -47,7 +47,7 @@ bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa + 1);
+    tcg_gen_shli_tl(t0, t0, sa);
     tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
     return true;
 }
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index f504e15fa7..e8ec5a0ff2 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -1795,7 +1795,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             return;
         case LSA:
             check_insn(ctx, ISA_MIPS_R6);
-            gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2));
+            gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) + 1);
             break;
         case ALIGN:
             check_insn(ctx, ISA_MIPS_R6);
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index e401b92bfd..e118013edc 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -3626,12 +3626,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 gen_p_lsx(ctx, rd, rs, rt);
                 break;
             case NM_LSA:
-                /*
-                 * In nanoMIPS, the shift field directly encodes the shift
-                 * amount, meaning that the supported shift values are in
-                 * the range 0 to 3 (instead of 1 to 4 in MIPSR6).
-                 */
-                gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) - 1);
+                gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2));
                 break;
             case NM_EXTW:
                 gen_ext(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 6, 5));
-- 
2.45.2


