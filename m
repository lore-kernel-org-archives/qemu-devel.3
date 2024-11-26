Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3392ED3B991
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw98-0005jy-Lu; Tue, 26 Nov 2024 09:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw8A-00048N-NM
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:30 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw88-0005NC-UK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:30 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a752140eso5170135e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629686; x=1733234486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmJIkkEIvmi/80J4VnVDxpxMJ00cktUfgcfyhqXGEpo=;
 b=nOvYQPfBNr6CSSd3bMB+phMYsF0t/pPJi4pUmME2pikbSCQQmq43LuArvZdERghqG9
 UA7PDyTZTSl5S8WC4bNudqjwrZhKdimyfiERO2AdgRLbnWEpJEJg/l3DZRKHJm94zZAe
 d01nbyqc6NE+BPssW2+BKcvwtI14JIxiHXAIuyyYg7rWgxrB4JuIM0ysVFG0ANNFIhmD
 FeouKaVg5yBSIr3Ij0tsar8iJXMfAFCDVVYz8pG+BSrAtEOCK4UXFEpYnkO6X178WPBE
 o1bLlBNWBYkwqvSaUUyqEih5xss1ZnJFHjPQrb7cg+slOGOJW0Asz9o8XrIhI6rAXzQ/
 K8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629686; x=1733234486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmJIkkEIvmi/80J4VnVDxpxMJ00cktUfgcfyhqXGEpo=;
 b=A7942hauqPCJavPQx4HMFFUdfIbYm+LF9cP05vQqJPs42nyH+rhmYhJsvHoq2zxrza
 Na3pYDce7G35U8a54QuAdVqKdILNk8Y3b2VOsINRqlWJHY8ib63O5NkXjou8Kg07t65B
 AZV2JeBcWpD5BJ93JtOaMonDU5oWfYdJq8AA4aKdwNAsD+Tmi5klVvoHDEBbyf3vwGU6
 cmSZTGb/KqRWXOm0m0PnfRJVCJcT2XQ/PqlFTmsLLoiIc1gQNJwh026BhFZLn8GqfvUH
 fXt+/Y8mEO+34FhV3XNivR4uZaz4HoJy+8nEHjx4Qo520oNWSmzcCbyPaHhgUlwuQDNT
 t9Dw==
X-Gm-Message-State: AOJu0YzOSISiBnKaQcbzc5qmpiRaf7/7lYm5Ci1kPTV7rjgs63JuWIN7
 zShkDqIcIGRKDm5WtedcprE6qrxY8RxgId3ztWo0V4VflHjo6ZQo4nRLAJNT4orbGgR0MJ9skj+
 e
X-Gm-Gg: ASbGncsREjHp+8bTHfh649zFcsuTzffQRS7alNDB9FR6RGAaJlzFW3/70I4gUH3gmrb
 Kyk9Jl8UNmWCaqP4uZ22SwBSO77ZpO3X3c0gwQFHDgtq3rZj4PLzkLbusFj1KMG3x2H0SG5VH7M
 AIuBBV7nTIJ+0epusuxkyf4oYEVM7HkNj23NNnOSlRtGxMZqD19woldbGUTDUzael4YbKJRf6ZV
 1wIgyYWt8nKZNoEsdbIRoUSjQnBFwSzpBwOQHRx0ii9k103M+3pyrvo8gHM0ryHbAvYhDQS
X-Google-Smtp-Source: AGHT+IEj1mgAzVefGexJPhmguytu//Kjh1j0/LPXWuRDqFfTXG8JoU9INksPB82Gt/NdyjxjEwPOXw==
X-Received: by 2002:a05:600c:35cf:b0:434:a4fe:cd71 with SMTP id
 5b1f17b1804b1-434a4fecfd2mr33483975e9.12.1732629684096; 
 Tue, 26 Nov 2024 06:01:24 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a4d41fb4sm31646165e9.14.2024.11.26.06.01.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:01:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v3 12/16] target/mips: Convert nanoMIPS LSA opcode to
 decodetree
Date: Tue, 26 Nov 2024 14:59:58 +0100
Message-ID: <20241126140003.74871-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Simply call the generic gen_lsa() helper.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241112172022.88348-7-philmd@linaro.org>
---
 target/mips/tcg/nanomips32.decode        | 6 ++++++
 target/mips/tcg/nanomips_translate.c     | 7 +++++++
 target/mips/tcg/nanomips_translate.c.inc | 4 ----
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/nanomips32.decode b/target/mips/tcg/nanomips32.decode
index 9cecf1e13d3..96d2299bfb0 100644
--- a/target/mips/tcg/nanomips32.decode
+++ b/target/mips/tcg/nanomips32.decode
@@ -6,3 +6,9 @@
 #
 # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
 #            (Document Number: MD01247)
+
+&r                  rs rt rd sa
+
+@lsa                ...... rt:5 rs:5 rd:5 sa:2 --- ... ...  &r
+
+LSA                 001000 ..... ..... ..... .. ... 001 111 @lsa
diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
index 335a32845ed..3e77fcd23d3 100644
--- a/target/mips/tcg/nanomips_translate.c
+++ b/target/mips/tcg/nanomips_translate.c
@@ -13,3 +13,10 @@
 #include "decode-nanomips16.c.inc"
 #include "decode-nanomips32.c.inc"
 #include "decode-nanomips48.c.inc"
+
+static bool trans_LSA(DisasContext *ctx, arg_r *a)
+{
+    gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+
+    return true;
+}
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 5d021f01128..0627f01c19e 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -399,7 +399,6 @@ enum {
 /* POOL32A7 instruction pool */
 enum {
     NM_P_LSX        = 0x00,
-    NM_LSA          = 0x01,
     NM_EXTW         = 0x03,
     NM_POOL32AXF    = 0x07,
 };
@@ -3625,9 +3624,6 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             case NM_P_LSX:
                 gen_p_lsx(ctx, rd, rs, rt);
                 break;
-            case NM_LSA:
-                gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2));
-                break;
             case NM_EXTW:
                 gen_ext(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 6, 5));
                 break;
-- 
2.45.2


