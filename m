Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB646D3ABCF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 22:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAd9o-00066u-T0; Mon, 11 Nov 2024 17:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAd9m-00066Z-DM
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:45:14 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAd9k-0008SL-QC
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:45:14 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d47b38336so3869227f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 14:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731365106; x=1731969906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zn8f/p6DL92t0jLH33Kyf5vwc7bUOJ3AokPYLSOVB2Q=;
 b=jO25ZuAnB26XwL4wB6HdwAI1qYtsYbG6PqNlP2qIN6KxCrbzUdWV8y09UcoBn37djJ
 7E4ZXaCab61ju2I7iOObHMHGXa/Wc2O1mih+zV5Qzx24igm2vXPYaoCBlhRz8c1KAt6R
 qqDz97ukQn5MZ78J3FZTEoSwaULps6LNPWs6AXLIwHHyYCsHwqWBaVgaoZ0YwgZTnm8k
 03JYindaVWt/SlLpuf02ijVeGl19e9RDKOI16BGn+uyYKDamQJRiGhTA330b6rCGZ0aj
 xV186yQe/LgWCEwtcKOYCJSWfZWj/W71moqElwr1l6uYFvLctDdueDGG5CDXu4f+QiD3
 Hm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731365106; x=1731969906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zn8f/p6DL92t0jLH33Kyf5vwc7bUOJ3AokPYLSOVB2Q=;
 b=b2Uuyrc9t8oHWwYK5RLOJWjj6bC74IRrVPgYUF8nEpBkG2O164SMGPszqpTusIDCCZ
 WmRQr6tp/62Lq6mVGROk2wYSOqpcdW7stxeyp+KdWMOEbjZVmSX6QDx7TsoI5lOQmZkh
 uyII81KCpNtNIKNiiSzfv9Mo7/iLyDwNUDaFjoi4gs9XHrRA+j4eyB3OyVbWoN2xbFmD
 OLQj48TXaEEaYQfH320qBJIGGNOM8FX5hXmNGcmr9YBfD1lt00e6aAmJ3oPqx3+wFcnz
 0x9UiPSnt+L9Ac1B0ClJsru2wzeD+IVeBoiwbfFWugL9DThzUR+fjIm6aakopo15XLvD
 cg5Q==
X-Gm-Message-State: AOJu0Yww8AJkUARW4n3dQs9R9X+u+NtWMG/jjlF7JoFmio/8ebOqCnIk
 Jn0Vbz29X+DSvg5KUL+0ZIgEGYvqwxq1SgZwrTErFncMUQ8PbT2S6Hz4uDFIsSRwRM0WjRjmBxc
 n
X-Google-Smtp-Source: AGHT+IGnufGpLnu08DnDRVPEGWej0Z30bJDJugPkzqjLjYqYAPVbW6vJke45qQD1ovd9e0OvPxD+8A==
X-Received: by 2002:a05:6000:2709:b0:381:f443:21d0 with SMTP id
 ffacd0b85a97d-381f443253dmr7670163f8f.59.1731365106061; 
 Mon, 11 Nov 2024 14:45:06 -0800 (PST)
Received: from localhost.localdomain
 (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr. [176.184.43.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381edc1104asm14091743f8f.88.2024.11.11.14.45.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Nov 2024 14:45:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH 2/2] target/mips: Convert nanoMIPS LSA opcode to decodetree
Date: Mon, 11 Nov 2024 23:44:52 +0100
Message-ID: <20241111224452.61276-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111224452.61276-1-philmd@linaro.org>
References: <20241111224452.61276-1-philmd@linaro.org>
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Simply call the generic gen_lsa() helper, taking care
to substract 1 to the shift field.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/nanomips32.decode        |  8 ++++++++
 target/mips/tcg/nanomips_translate.c     | 12 ++++++++++++
 target/mips/tcg/nanomips_translate.c.inc |  9 ---------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/target/mips/tcg/nanomips32.decode b/target/mips/tcg/nanomips32.decode
index 9cecf1e13d..11bf5cd6c4 100644
--- a/target/mips/tcg/nanomips32.decode
+++ b/target/mips/tcg/nanomips32.decode
@@ -6,3 +6,11 @@
 #
 # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
 #            (Document Number: MD01247)
+
+&r                  rs rt rd sa
+
+%lsa_u2             9:2  !function=minus_1
+
+@lsa                ...... rt:5 rs:5 rd:5 .. --- ... ...    &r sa=%lsa_u2
+
+LSA                 001000 ..... ..... ..... .. ... 001 111 @lsa
diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
index c148c13ed9..9a6db4a828 100644
--- a/target/mips/tcg/nanomips_translate.c
+++ b/target/mips/tcg/nanomips_translate.c
@@ -9,6 +9,18 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static inline int minus_1(DisasContext *ctx, int x)
+{
+    return x - 1;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-nanomips16.c.inc"
 #include "decode-nanomips32.c.inc"
+
+static bool trans_LSA(DisasContext *ctx, arg_r *a)
+{
+    gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+
+    return true;
+}
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index e401b92bfd..0e012ab3d0 100644
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
@@ -3625,14 +3624,6 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             case NM_P_LSX:
                 gen_p_lsx(ctx, rd, rs, rt);
                 break;
-            case NM_LSA:
-                /*
-                 * In nanoMIPS, the shift field directly encodes the shift
-                 * amount, meaning that the supported shift values are in
-                 * the range 0 to 3 (instead of 1 to 4 in MIPSR6).
-                 */
-                gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) - 1);
-                break;
             case NM_EXTW:
                 gen_ext(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 6, 5));
                 break;
-- 
2.45.2


