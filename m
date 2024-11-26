Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CE4D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw8d-0004Na-Hx; Tue, 26 Nov 2024 09:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw85-00045e-VN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7y-0005LZ-NW
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:22 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a2033562so13724065e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629676; x=1733234476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wepwirTTKAkbkaqkKDm3s9XDxGH9yJr/3hirBKFikkk=;
 b=WbC1tg066i3VfwUg3rls+5301Dw3QE6IiXqxSmZSl2Xt+QBm4TINZIJJrurgmMCQoy
 G6fvMUm98xZATRZazg3GcIJYOgVuvLVdUKlJwKE/BrUI1uBYTqZs+D5GYW502U/kOnLD
 PKHsuzA6LfdxhAsBk+QUYesqK3MJwVhKYasKxy2I2kzgxrvmTcsTTmL+bSCLZN4WSTqh
 LVwKhs/QBqNe90s7gMcI+Os++FNd8PMfRmirWDn85IAFkNO5qhET7hVHPyuBzjctRud4
 x/2bn+m8sfa0QVUX5drQO8Mflf7hPqsqCMlQmcGsATFHZFD/rLM7mUQq3czugR9vrTf4
 X2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629676; x=1733234476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wepwirTTKAkbkaqkKDm3s9XDxGH9yJr/3hirBKFikkk=;
 b=Y/knYNbW7dOhF3A8EFJk6cHFX8Qm5IKo9fBAJ5vo+Hx1TEx3Mv/AkesMgJzJpSoahM
 v4XJL55W1nybPClY4q/W10lM8AftcP7Yc6c+SY32aaLppRHwsgU7hfmkDZKAwZaT6Lu1
 cXNG6yQ2DVae71fG4IQqIMQG5tDjok/TgdQmMrAhFpMaZGKydFycMzp1vQyGDRFRNYFL
 3Xw+nd50yZ0CYL5nJFjAbFde+f4dCdV2a5rTKL5/zgt5zq3w5Sj3/IiFdwgVn2kuXalX
 PTe3UvvDpB/VO8I1eBpDxp9HvETtrtBKx4Sb36Ctkn7elDr6jTgn1om7gabv2KVKjU1E
 6fsQ==
X-Gm-Message-State: AOJu0YxBMFTJ6lg4uGKa4NsUj4oOFHUWGspmeNtLya+ykV85Ni7ci5Wm
 TygXSrW/ncXRo9niP17IR3zeKusCzh5y7wcIaHXSzFOaSTYqc2OekLkd+HY3T4smdKSzejJWH9x
 C
X-Gm-Gg: ASbGncttdPp1myQQ8UStZOi7JwQpVx6MeBLFgHsMjl6gAwhtelKeVLPl+3ID3uEIpbV
 6+9ytbuO7Le+dSNdNVQfokt4Emhxj5qC9oNkDaFA6rk3kUFTHV+LYbk2pJ+6YPigy25Y+z4gXAM
 eDnn/Oc/eo7QvPYA3VZH1Bw3rUDoknfK957w/VcypRcC6ZaZCG8ocNflGLHCpJhu1bPSybZaMqh
 2fCBHDVFosJUL+CuDGJasyiXlqM6UOhONUvtpmXva/iA9NlqdnNRVh2SP77Vl8IDdHxEtKi
X-Google-Smtp-Source: AGHT+IGLio/vnx/9ma2+bHFN9ZvLd0Vk/musqrbwkwV3ZMdk+QwAc+/Xpl4/Uc2GxtvDdpZhIt8Pag==
X-Received: by 2002:a05:600c:1f88:b0:431:60d0:9088 with SMTP id
 5b1f17b1804b1-433ce426feamr161069205e9.13.1732629676552; 
 Tue, 26 Nov 2024 06:01:16 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463abb4sm236443155e9.31.2024.11.26.06.01.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:01:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 11/16] target/mips: Convert microMIPS LSA opcode to
 decodetree
Date: Tue, 26 Nov 2024 14:59:57 +0100
Message-ID: <20241126140003.74871-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Simply call the generic gen_lsa(), using the plus_1()
helper to add 1 to the shift amount.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241112172022.88348-6-philmd@linaro.org>
---
 target/mips/tcg/micromips32.decode        |  8 ++++++++
 target/mips/tcg/micromips_translate.c     | 10 ++++++++++
 target/mips/tcg/micromips_translate.c.inc |  5 -----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/micromips32.decode b/target/mips/tcg/micromips32.decode
index 333ab0969ca..0df9f0c59ff 100644
--- a/target/mips/tcg/micromips32.decode
+++ b/target/mips/tcg/micromips32.decode
@@ -9,3 +9,11 @@
 #            (Document Number: MD00582)
 #            microMIPS64 Instruction Set
 #            (Document Number: MD00594)
+
+&r                  rs rt rd sa
+
+%lsa_sa             9:2  !function=plus_1
+
+@lsa                ...... rt:5  rs:5  rd:5  .. ... ......  &r sa=%lsa_sa
+
+LSA                 000000 ..... ..... ..... .. 000 001111  @lsa
diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
index 49e90e7eca2..f0b5dbf655d 100644
--- a/target/mips/tcg/micromips_translate.c
+++ b/target/mips/tcg/micromips_translate.c
@@ -9,6 +9,16 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static inline int plus_1(DisasContext *ctx, int x)
+{
+    return x + 1;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-micromips16.c.inc"
 #include "decode-micromips32.c.inc"
+
+static bool trans_LSA(DisasContext *ctx, arg_r *a)
+{
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+}
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 7a884222eed..73394554509 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -191,7 +191,6 @@ enum {
     /* The following can be distinguished by their lower 6 bits. */
     BREAK32 = 0x07,
     INS = 0x0c,
-    LSA = 0x0f,
     ALIGN = 0x1f,
     EXT = 0x2c,
     POOL32AXF = 0x3c,
@@ -1793,10 +1792,6 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
         case INS:
             gen_bitops(ctx, OPC_INS, rt, rs, rr, rd);
             return;
-        case LSA:
-            check_insn(ctx, ISA_MIPS_R6);
-            gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) + 1);
-            break;
         case ALIGN:
             check_insn(ctx, ISA_MIPS_R6);
             gen_align(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 9, 2));
-- 
2.45.2


