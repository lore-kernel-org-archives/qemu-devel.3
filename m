Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B0D3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw92-00056f-Kp; Tue, 26 Nov 2024 09:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw8P-0004LS-QR
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:49 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw8O-0005PV-5i
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-382376fcc4fso3349469f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629702; x=1733234502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJyAj6665biaVaFql3kvNaD085ICHYFrXjshxoAYeg8=;
 b=SXF5GR2pcnVfuhxiil4c0ArauzpsYCRtkUxR281zx9269pym+2KxMQVJuUibGqQwOL
 lofLvHy0rD5zdIiBTJ2dJISg6lHlJtHrxvfWQyQyPIHAEOv653d+Ah2kpXDGt0bU5w8I
 ghYbau5wJSgeU/mBqnKl0t6/U/QomC9jah8B6yIKP0oREuCmhGIeFkpsfhIiUY5NkB4X
 phDLdJpUdlSJV3GVN6yw1PVSV0iQZdAT2QaBxQtT1Hm4+qrULswMNT9jD+hJsuBhf+hQ
 7B2nU650cVGZN5jX9evaDSofA1VlR+MMJ4xj467/xdWVf/xzcnJBJSAg2ufTyChZDNXX
 j6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629702; x=1733234502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJyAj6665biaVaFql3kvNaD085ICHYFrXjshxoAYeg8=;
 b=X1YeZufouUAb4P5SjDyn59LYJifktECsnb2hbNewDENT2Bxo75fsgy56UhWHqjNJZr
 XgzjpYgi3y1YwjBQelbQn41Yq5BoDWTbC/MhwvOv6NBFU/+reYiJNLpjj3jg2E+rE2Vj
 kOQUOcBJr48abtO/WpXiQHYd9wTZrk9Br7pA9unFrtxw2DEGTD5sbiVd5nGjK0niJLfF
 GPBsl3JoEGfF884GeP/ZUFCnhqp7a95VMO50J3je/GseVYa6Juy97fTl28FvsMPLLCb/
 HLcFeIktxc/Xajl4Qoa5NF4banNbYiduJ+IndUeJfp2blO4Ikjq0fp86olK9JEhvKN+4
 rlrg==
X-Gm-Message-State: AOJu0Ywvy+TfBg4OHxpDQFr7NoRJG3m9iNb1K0bo5//NBTKoipDs02iL
 2aumBlMX+bztTmP+fHx0n2aisPXgO4dDmPLRzzwEMeOkcVvPFJCKNhBz2QCVpnzhtKeWNPzQs9X
 q
X-Gm-Gg: ASbGncsft8ehc44/t6JTAfvWcjm6z+e9Ge2t3bVxSJj0SujuU5ptGGk5z/5RV03Jcw+
 5RFldTWrUmjauV1BO/GESuA7Y+xnXAkR8TGX2K8GwcukrbD9oJCPacvTlgpqLVGiXwXZ88qMsqB
 JLJ3ulwLiHyXPsDYebAlKc8WGB7gLZEZCa35+eCHBPXTrzt7NxvrXFO8yRerSuamdIx3Urw4BXx
 52lSu5gq9592opDAh6Diq9/lV/Q0LGiRmZ8CjZJ1Qy1kiPKtdwx05LtS//SWgjwGkvyK0h6
X-Google-Smtp-Source: AGHT+IG9gTXzrDLmB8y5DM4XWydRv7uACSUAzvJv3tDQC+y6SB3PsrepnWJIPB4mQt2Jqbjq/6dFdg==
X-Received: by 2002:a5d:64ec:0:b0:382:5129:9f2a with SMTP id
 ffacd0b85a97d-38260b4d621mr13805896f8f.2.1732629699807; 
 Tue, 26 Nov 2024 06:01:39 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3a3asm13310362f8f.66.2024.11.26.06.01.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:01:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 14/16] target/mips: Convert microMIPS LI opcode to
 decodetree
Date: Tue, 26 Nov 2024 15:00:00 +0100
Message-ID: <20241126140003.74871-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Once the xlat() and simm7() helpers are added,
the decoding is trivial.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/micromips16.decode        |  9 +++++++++
 target/mips/tcg/micromips_translate.c     | 19 +++++++++++++++++++
 target/mips/tcg/micromips_translate.c.inc | 12 +-----------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/target/mips/tcg/micromips16.decode b/target/mips/tcg/micromips16.decode
index d341da16b04..fdc3b131c9c 100644
--- a/target/mips/tcg/micromips16.decode
+++ b/target/mips/tcg/micromips16.decode
@@ -9,3 +9,12 @@
 #            (Document Number: MD00582)
 #            microMIPS64 Instruction Set
 #            (Document Number: MD00594)
+
+&rd_imm         rd imm
+
+%xlat_rd        7:3 !function=xlat
+%simm7          0:7 !function=simm7
+
+@rd_imm7        ...... ... .......          &rd_imm         rd=%xlat_rd imm=%simm7
+
+LI              111011 ... .......          @rd_imm7        # LI16
diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
index f0b5dbf655d..198eb466057 100644
--- a/target/mips/tcg/micromips_translate.c
+++ b/target/mips/tcg/micromips_translate.c
@@ -9,11 +9,23 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static int xlat(DisasContext *ctx, int x)
+{
+    static const int map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
+
+    return map[x];
+}
+
 static inline int plus_1(DisasContext *ctx, int x)
 {
     return x + 1;
 }
 
+static inline int simm7(DisasContext *ctx, int x)
+{
+    return x == 0x7f ? -1 : x;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-micromips16.c.inc"
 #include "decode-micromips32.c.inc"
@@ -22,3 +34,10 @@ static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
     return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
+
+static bool trans_LI(DisasContext *ctx, arg_rd_imm *a)
+{
+    gen_li(ctx, a->rd, a->imm);
+
+    return true;
+}
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 73394554509..cb98d6af7e4 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -113,7 +113,6 @@ enum {
     BLTZALC = 0x38,
     BLTUC = 0x38,
     SW16 = 0x3a,
-    LI16 = 0x3b,
     JALX32 = 0x3c,
     JAL32 = 0x3d,
     BLEZC = 0x3d,
@@ -3004,7 +3003,7 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
         case 2:
         /* LBU16, LHU16, LWSP16, LW16, SB16, SH16, SWSP16, SW16 */
         case 3:
-        /* MOVE16, ANDI16, POOL16D, POOL16E, BEQZ16, BNEZ16, B16, LI16 */
+        /* MOVE16, ANDI16, POOL16D, POOL16E, BEQZ16, BNEZ16, B16 */
             if (ctx->hflags & MIPS_HFLAG_BDS32) {
                 gen_reserved_instruction(ctx);
                 return 2;
@@ -3214,15 +3213,6 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
                            (ctx->insn_flags & ISA_MIPS_R6) ? 0 : 4);
 
         break;
-    case LI16:
-        {
-            int reg = mmreg(uMIPS_RD(ctx->opcode));
-            int imm = ZIMM(ctx->opcode, 0, 7);
-
-            imm = (imm == 0x7f ? -1 : imm);
-            tcg_gen_movi_tl(cpu_gpr[reg], imm);
-        }
-        break;
     case RES_29:
     case RES_31:
     case RES_39:
-- 
2.45.2


