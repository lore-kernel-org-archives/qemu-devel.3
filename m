Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16753D3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw7R-0002ij-0h; Tue, 26 Nov 2024 09:00:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7G-0002hC-GH
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:34 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7C-000589-F9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:33 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so52115735e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629625; x=1733234425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgT7974TBaSnVy5uBFRbu9gIDuhkpzf7gv8ciPR3e+w=;
 b=pYGQChg+B6egG69qNWs5lQso1scGxol9tmIFSRHYWVrTbPkZiXuzd0xChefc4AIt74
 M3uJliH6LaMTzu/qT5fuXyph3+ZEe8cP10jMsB7aAZwdZqoJmFjHP5HJ5Q1yqYgqTpxC
 daom26GnSmySSXU+rW5TClqwAz51h6fXkfBJ5jF+aySwbBrtWPG5ONriTtH2b2YmlkWS
 FjLgU0mWtLonQKZiFi2Jvmlck4YQHiNtE0fI0QbvTMSc/GKj3oX38iRldw6z/qDMRR3I
 qL6AeFKpQ+oLlU1EUCvWGPYcFeNDzdxg3VAtjPXcaKVYe5hTzld2wRBl2/Nay0S52qOo
 UkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629625; x=1733234425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgT7974TBaSnVy5uBFRbu9gIDuhkpzf7gv8ciPR3e+w=;
 b=AortOnc+y0nKpa5rZPZtoO4RNJ+GhAEZl7ZtMimYkDU5FmLsrpA5i6zOX6E2T3Xqhl
 NhlJ2TbDDk9Um5NwL5Tn5XLsLuwoav2ugTfxHxcQpt3yWYzzGODyJoOghTvnPskMQJtt
 TXyXx0HB8eU3OZJu2Me5t4lLWKNGbU0qmjhdNqw7b6iM0UKsNkgypN0VVHgr0bnCa9oz
 PPpk0BbN1BoWwPmuHLa3vv7SrFnZYRlOcchDtV4laHzq09tayPwV86pxdMTFnrRUpo/O
 mC5Gahvv5hlvRHJOv7zdW7MrQKkIWARn4C08K3JlHkmfVmw16h7Q4glnnCvTTJt1kM+R
 fv3Q==
X-Gm-Message-State: AOJu0Yx6BY12KNvMuMrjRb0VsIBc0DK0BrpDTFiGmD4/k5khcS4ESLOR
 4DJtz9+gu5lJ/VMKkdWrDqVoF4YwfaCfXp3920lJdoo9I69QRiOMniydiHEP8zBF/9aSMq80iJ5
 /
X-Gm-Gg: ASbGncsW0LXSfyVgqVw5j9j647iLmb4HkYez+D+cxGuwxuEIRLivfXU+wB5f4wdvwVY
 ulu06ujqPbsLHfnMdYrK/Gq+HB7dDF0ffTk65lkcdZUUWqV65qHJvXGe1t+/zejtOuWolvaLkRh
 9w02KjW2Ot6WFF4HQ178MprjMsJ6VFVK8LH7ZJkf2cKyVwwpXExglUWAfE5RofGrf47h2Vjpe+7
 NRpW2VkDVzAubeoMSTc9Q2oQS6U5cbjCKy8iLAxQpTh1m1IV53c9n3cVzDT8ACXFCQs2NIGnVYc
 tQ==
X-Google-Smtp-Source: AGHT+IHOHgJ0coNubj+24r+96yTdONaN/gsorOmJGolLH+QOccSj4A0bDX5whV8CyWwTTpwfOJy7Qg==
X-Received: by 2002:a05:600c:1c95:b0:434:a802:e99a with SMTP id
 5b1f17b1804b1-434a802eb8fmr14892965e9.4.1732629624605; 
 Tue, 26 Nov 2024 06:00:24 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b46430f1sm229389415e9.43.2024.11.26.06.00.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:00:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v3 03/16] target/mips: Convert Octeon LX instructions to
 decodetree
Date: Tue, 26 Nov 2024 14:59:49 +0100
Message-ID: <20241126140003.74871-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Use Octeon decodetree to call gen_lx() for the LX instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241111222936.59869-4-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  8 ++++++++
 target/mips/tcg/octeon_translate.c | 12 ++++++++++++
 target/mips/tcg/translate.c        |  4 +---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 0c787cb498c..102a05860df 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -1,6 +1,7 @@
 # Octeon Architecture Module instruction set
 #
 # Copyright (C) 2022 Pavel Dovgalyuk
+# Copyright (C) 2024 Philippe Mathieu-Daudé
 #
 # SPDX-License-Identifier: LGPL-2.1-or-later
 #
@@ -39,3 +40,10 @@ CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
 POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
 SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
 SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
+
+&lx          base index rd
+@lx          ...... base:5 index:5 rd:5 ...... ..... &lx
+LWX          011111 ..... ..... ..... 00000 001010 @lx
+LHX          011111 ..... ..... ..... 00100 001010 @lx
+LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e25c4cbaa06..0e0b00303a7 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -174,3 +174,15 @@ static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
     }
     return true;
 }
+
+static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
+{
+    gen_lx(ctx, a->rd, a->base, a->index, mop);
+
+    return true;
+}
+
+TRANS(LBUX, trans_lx, MO_UB);
+TRANS(LHX,  trans_lx, MO_SW);
+TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LDX,  trans_lx, MO_UQ);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index acadd3d8919..6fd5462a24f 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -13583,9 +13583,7 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_LX_DSP:
-        if (!(ctx->insn_flags & INSN_OCTEON)) {
-            check_dsp(ctx);
-        }
+        check_dsp(ctx);
         op2 = MASK_LX(ctx->opcode);
         switch (op2) {
 #if defined(TARGET_MIPS64)
-- 
2.45.2


