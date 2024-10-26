Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BFCD10C01
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4kzH-0008Or-QP; Sat, 26 Oct 2024 13:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzF-0008Ns-Gm
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzD-0003js-O5
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c805a0753so29554265ad.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729965242; x=1730570042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KpfAMGmyWm4pigvyIOxRZMUq0CTvdaeELUk7R48DMKQ=;
 b=VTHV8y87dPbSTG2T6XnXMR9xtzQjgJYLGU51nvj7CY3D8cLKsA7pM0a0iVl99oyO1i
 cJYTFeB0NubPG8wet7QYvH/MzdQjFL/hdy2GEbXZh5plahoDqPNNKBarfdBKGzEoJ/DY
 AKCKx/pbjIMuiEIJCsSDyiaCdPkpUtYMfB0gXCFj6MmQtOfr0s+DVX2uCI2SDrlvRFK3
 OqqwZLaNthOtzkQbbXpBhmSx+QGqf/ikSfzu88bLWsJJNEmDbJ1KiiWQ514KybV3H7hw
 7pBMZ5lwP1JhpzoGBpRSEWl+sNtvReOeWtuZoeaBg2JIsSwBWSlmXS3ZfU8ETS81U/j2
 vQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729965242; x=1730570042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KpfAMGmyWm4pigvyIOxRZMUq0CTvdaeELUk7R48DMKQ=;
 b=kAowXKggxhcosuaj4KJ39OhLQItEbbomulfRT6EDh4zX5u+eNG8gavZDCw5+mdhTaK
 HtwU/HImFO1b0Yz4yx+0dGISxAk8HZmWr3z80rj+3IARlu//Hf3Milft3LZSTI+ouZ4/
 2xR+tti7rCTXEBMXufUth+KfNy1+IXj9nslF1O7ETrJUEHn/tNRjpRvelJuP4wEjvsU/
 XwmP34dHhY45pIt7SaHp2fNz1MYrJjMDFSDBlP7iwUYTx3/N0uWy6QpczJWMDFSzO8Vp
 kCZZ3w6Wa01pFyWAF9uwGNLRITYkdzcB5tErhgp4Owu/juZP4TB9T4tXBa6HDmRVudy8
 g9FQ==
X-Gm-Message-State: AOJu0Yzjmt1/92Bjitvgaim/eVGHW9Q1VehkvGJimAbfl8lMJecsW5d2
 TW7vbM45v7rlKzmpgDJeZgK4QvzxF/NX8njq8LTp1c03JWh6pxpAvA1Hzp+vAdi4q1sC0g/t/W0
 Y
X-Google-Smtp-Source: AGHT+IEKCgv2GcJkl5toeLO9WZV+4NK/JDm0V5bLon8tKImk90vZUGMteiWImRLXG5d+CIJWYCkI8g==
X-Received: by 2002:a17:902:dac9:b0:20e:57c8:6aae with SMTP id
 d9443c01a7336-210c6879841mr50526365ad.3.1729965241944; 
 Sat, 26 Oct 2024 10:54:01 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf84597sm26208485ad.111.2024.10.26.10.54.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Oct 2024 10:54:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v3 1/9] target/mips: Extract decode_64bit_enabled() helper
Date: Sat, 26 Oct 2024 14:53:41 -0300
Message-ID: <20241026175349.84523-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026175349.84523-1-philmd@linaro.org>
References: <20241026175349.84523-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Extract the decode_64bit_enabled() helper which detects
whether CPUs can run 64-bit instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h | 2 ++
 target/mips/tcg/translate.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 5d196e69ac4..ae6c25aa0c4 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -217,6 +217,8 @@ void msa_translate_init(void);
 void mxu_translate_init(void);
 bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
 
+bool decode_64bit_enabled(DisasContext *ctx);
+
 /* decodetree generated */
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index d92fc418edd..6c881af5618 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1645,13 +1645,18 @@ static inline void check_ps(DisasContext *ctx)
     check_cp1_64bitmode(ctx);
 }
 
+bool decode_64bit_enabled(DisasContext *ctx)
+{
+    return ctx->hflags & MIPS_HFLAG_64;
+}
+
 /*
  * This code generates a "reserved instruction" exception if cpu is not
  * 64-bit or 64-bit instructions are not enabled.
  */
 void check_mips_64(DisasContext *ctx)
 {
-    if (unlikely((TARGET_LONG_BITS != 64) || !(ctx->hflags & MIPS_HFLAG_64))) {
+    if (unlikely((TARGET_LONG_BITS != 64) || !decode_64bit_enabled(ctx))) {
         gen_reserved_instruction(ctx);
     }
 }
-- 
2.45.2


