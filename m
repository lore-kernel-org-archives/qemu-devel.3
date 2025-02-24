Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B82C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWR0-0005lr-K3; Mon, 24 Feb 2025 06:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQw-0005kV-P9
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:34 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQu-00016c-SI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso25741625e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395731; x=1741000531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9DbKOvjmlaa+eK1MxGX4jbLYMxjD78KrF+C7Cfab4aQ=;
 b=bSjtL5+THtnPiuPJAuWhlqnOAIM8bHkhP1gwdFuzmtUXe+PY3QDHestA1qJpIPerCt
 6cmWx7IlsHvFPGCu93zEniU+O3GzuNn7F9f5j2FHrmb/z199ZEduOpHMHRB2A3BrpOX2
 dlWZujhgMNOO0cmVa2wsBpTVKBEoCW7t4HQiaknQd53WNvJ4prDXDfZVz1jrU/oHzGYi
 EAnO7VRLsqnpaFPpxowODycIS6iJNiSyMoP0dhFyY5Pbl4ers7rbOvjJce50iHMsiRS2
 CvvWK9bd8m/n1dF2xX6F48Wkuz2A9XD5Pt2scnUCg5PgxPBMA0v0m/VvEu9Supy5H94l
 GmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395731; x=1741000531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9DbKOvjmlaa+eK1MxGX4jbLYMxjD78KrF+C7Cfab4aQ=;
 b=rmzWRUtozGsF0f/mQiC9psCzUjIBuRfmazYpOjygFDYjtZcgktaq4UPvF1pzzdu7WN
 DQ93k0yVK0kTRsZB1Lw+AxtgaVzVuYh1faJNmG0F6x3UnY25kV6EF7i2B1bpetJMcuyb
 fRjCM+lWYFImAYnqpBGF3RORKDrtpXnNbwEc/8MHnDdZZl8sCpsUpI7LW2fA6GqRdbso
 hOdhqqx2HoyQ2cgHnKrTA/HmduHgTygvxYJbrXXwoeItJy+9tCUut4aEMxnKecuodMGC
 mzn8iw3/OR/yFiAWhdai/MmtejblmCtGHs+6/x+HVoqMPYrKOTqbPbEqKLdXhE1KWUw3
 stYQ==
X-Gm-Message-State: AOJu0YyQEaLI4rGxGfuE9EOqjhfrYOpcuxfAWTrptm28Bc33YtdKt4BZ
 LDJYU9Oas1m7VsoJvxiNzX1s/rqBQdrBj7ETV6YHRqBRBU+psw69YjXGCqd8hKiqRwX9hBScq/F
 s
X-Gm-Gg: ASbGncuTUSbVeClShmaZbOEgNI8qmkyf39aWJYJEDPJ2b2f2Z5Id8pQnwh7qwhIgUQC
 mspgQDLKOnee/P3caloentrP+R2Yw3GzO3b4W9aJk3VYlBIxeAvlBDBaO1GCaykD2BqEhYBhDHN
 M1HyyB2V7PdVG7GwOoNTM5SBsY0WkPfpeCuk5w0+xrG2Y5FPrnIz2e8XjNXrRXlSu/JXv7XSrFA
 cyvwykYtPP+jK6CKMryrfCbCGKkKB3rvz3Uh7I1IsfAYXhVEMu6TVW5+k2DkHUzgdUyR/HDjfmf
 szH8RwwxSmicr5HvJcDv9QYp1lnPMrjd
X-Google-Smtp-Source: AGHT+IFqa9cvjdMXpfNqTskBMd1pB+u7MuX2hjWWcEPLUN/nBD6I098848BdMBYmacPpNIzr9a7MIA==
X-Received: by 2002:a05:600c:1c85:b0:439:8346:505f with SMTP id
 5b1f17b1804b1-439ae212980mr93119685e9.20.1740395731147; 
 Mon, 24 Feb 2025 03:15:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/12] target/i386: Avoid using floatx80_infinity global
 const
Date: Mon, 24 Feb 2025 11:15:15 +0000
Message-ID: <20250224111524.1101196-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The global const floatx80_infinity is (unlike all the other
float*_infinity values) target-specific, because whether the explicit
Integer bit is set or not varies between m68k and i386.  We want to
be able to compile softfloat once for multiple targets, so we can't
continue to use a single global whose value needs to be different
between targets.

Replace the direct uses of floatx80_infinity in target/i386 with
calls to the new floatx80_default_inf() function. Note that because
we can ask the function for either a negative or positive infinity,
we don't need to change the sign of a positive infinity via
floatx80_chs() for the negative-Inf case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250217125055.160887-4-peter.maydell@linaro.org
---
 target/i386/tcg/fpu_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index f112c6c6737..741af09f908 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1832,7 +1832,7 @@ void helper_fxtract(CPUX86State *env)
     } else if (floatx80_is_infinity(ST0)) {
         fpush(env);
         ST0 = ST1;
-        ST1 = floatx80_infinity;
+        ST1 = floatx80_default_inf(0, &env->fp_status);
     } else {
         int expdif;
 
@@ -2358,9 +2358,8 @@ void helper_fscale(CPUX86State *env)
                 float_raise(float_flag_invalid, &env->fp_status);
                 ST0 = floatx80_default_nan(&env->fp_status);
             } else {
-                ST0 = (floatx80_is_neg(ST0) ?
-                       floatx80_chs(floatx80_infinity) :
-                       floatx80_infinity);
+                ST0 = floatx80_default_inf(floatx80_is_neg(ST0),
+                                           &env->fp_status);
             }
         }
     } else {
-- 
2.43.0


