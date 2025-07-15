Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9EFC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ1H-0002RU-IR; Tue, 15 Jul 2025 02:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ10-0002EJ-Uh
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ0x-000734-Ju
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:46 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a522224582so2543707f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560381; x=1753165181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/zzVpOs+7k/RhkGCFmhDLsEFTRbLNhvwqm9iD4r+MU=;
 b=tqKWL7jVJj0mhLgymvYtQjBUgE/uFnNCruhg/y/KQAIW80G5MyV5mJho9Bf9aUqzwp
 O6shR/zSDgTZkuvTWS+fy9ukdgeDjPbWKAKSB/5d+VKhq8JqgbH1kWs8iugmM5J3Aeh7
 5G1ENf6k/qhJC/dWgTmGwgg4BkA56t32IQiSpwUQ94P/loOUncOYdP9JD/bqs5SZSdR8
 hkgMbz7seOyzLDvVFsu3tJgKL1cNXodGbiywIroC/NpE5vc5ioOj2dB86CCRE+Qv+9MY
 8Z+QbHUtHax2ZUGwNkek89olsNmGiXPOIaIGVun3S1X/Q4A9SoZU8dXqadtyn9eJsMRu
 5ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560381; x=1753165181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/zzVpOs+7k/RhkGCFmhDLsEFTRbLNhvwqm9iD4r+MU=;
 b=tRkj8+64KESPmpx6bb9mByW6F1E0O6jfY0u04Ni29C6XnS7LeDTpv1iuwD5Ypipxgp
 F4AgTz2fS3PDFdOREj87rAJsqf3NHFQNSleK2+byColNgE+I2ciCMLEBOF0doEemIsiI
 vifJeJEy7udYuJb49kov/gTjSePYqC67FDK5prY3xHyYYO1DHSGv+anCo8j4PQmHbuNa
 bslPH/+ZCm0r4yvOeOBmJQ1Hvw/ubuWUw5sWLgzLEr3zdDmQ7wX3OVt8ZGuPaVrVzt4l
 Hw5FokcVM/SdI2Rl2E7OpSOyHYcvFAXfaxk6I6tknNNOUQoEfJv+2gc7doi5GoMKURpx
 YVNA==
X-Gm-Message-State: AOJu0YwagZO1ZtJQi539k/Wo6PqewYxkaDR2hqh9RJybGrqsRTZaWMB0
 L3pEIId2A/Y83AOY6Mt48/J2PblMo42bJf0LCON+fhtAjrdv/Z2SRhpYo/OQki3ZU/gBSzdgP0h
 jaWsG
X-Gm-Gg: ASbGncsSodNed23QMewNbPrV8m7qWCnem3IqPzF3EE5bEmFx2/U1UuKxbfIFm0EUyCd
 pSIel4TUsx2XBsb8aA/UMPluoE+Zt5OTINyHpS+mp/htdHeeCSg0CpXDPQ1e027JZq3UDfmY5JM
 S5fcw5wjhOJXj/jJr9iQTBbO9/5J5yHxBgpkPJwDvUYCU6JG5OlxuU9s0TIUFYVDfHzfW+Eqsbp
 30mOv31+TSh/TpHAG5VeXca7pSrJgJpixDFVqEmQsXAHjqRIJsf28gjxNoXKJyJ48m0if4u+Qqn
 N1UQ7+H0a3ijsexmfT+1fXtxreMFTw1Oy+W86Go6ahzwh160juGrDeb/aHHhVDIt65tzljyBAhG
 yJBJZ/gNquVRIiwvpKkGMj91MMrox7USCmw7dZodAMdWC9jomtIGNJK4uubrdivvQKxfhZLIg
X-Google-Smtp-Source: AGHT+IG97X6QEDT1w5Cy8eMd2dGsWqLXguZE87Wco8bA4iE3D3bjT+UJiYI/C6vdjH9Wm31McPcoGA==
X-Received: by 2002:a05:6000:20c4:b0:3b5:f93a:bcc with SMTP id
 ffacd0b85a97d-3b5f93a0e5emr6643111f8f.35.1752560381318; 
 Mon, 14 Jul 2025 23:19:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d571sm14479576f8f.57.2025.07.14.23.19.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:19:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 04/17] target/mips: Convert Octeon LX instructions to decodetree
Date: Tue, 15 Jul 2025 08:19:04 +0200
Message-ID: <20250715061918.44971-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
index d9eb43716e2..b2eca29e06c 100644
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
index b9b2d8bb7e1..d91d6efe02c 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -13607,9 +13607,7 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
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
2.49.0


