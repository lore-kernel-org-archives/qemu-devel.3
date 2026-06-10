Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AC0CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXu-0008EY-2K; Wed, 10 Jun 2026 12:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXh-0007yI-10
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXf-0005Xy-2O
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso50937155e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107953; x=1781712753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jrlaG88FPR3tY2VMFw9TJ9vpxsFUwMc4Vdf0h1F2Lrw=;
 b=jvvH3F/etzB2D9Ylp/4Wa8gog69VXPGqrl1u6eAX/lmSOKYN3Fo2tP9jTFlDjpyz0J
 dI9xCtIKJKHhntiZOTHJq9MTK4Bd4sywrNzpqDffPxdOQL/ZKDy3bmPJpe3My+OwVF8w
 cfqCWb+KNh2hVDpKJfAGNpZjWyyHiSYB4iBjyNSv7E/aJdHuxnQG5/6EhWnpDpBX4Kb1
 jLoNGF0b29EjHJRHWs4SfAIMGmDXtnMovajg7Q7qmaCdhQlTLWPxH6HPlW+L9Bo61sew
 85ctTFTaD5VcxvZA/2xInG7CDQMBKX9ulmvHwezl41uI3jPy4a7M36oVfLK7uiz+yhPx
 FT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107953; x=1781712753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jrlaG88FPR3tY2VMFw9TJ9vpxsFUwMc4Vdf0h1F2Lrw=;
 b=PFhwB1jML5w77yL+KnkTskMEvXz/3uje8lI4GOTT0Yal7bhoW2HTGaLUAp5WtBc4bx
 QP0MpORS+b0dwuAzciIU6DpgFmqZyNbsmfjfe2vASxRwM2pKATs/kX3sBEGl8x5WW97F
 /8vdUpxDYuRkU4w3ebfkIx0lHXvL3uoL5xWJLbdfemFlUEGzmgwDJueL0/irgZoUkZvP
 3RvqzddEeNGqITrHd8qEAOX9KX+ooeFld6M9fF7RD4Uw9RhfE9abNEPmRi6oEq4j7H97
 Q0GsyhaInXS9zuAG2LIIzZXcPtGPcgR4YMnY9WkGAactdIaacfqypuvXRG+r/5YJv4xr
 appw==
X-Gm-Message-State: AOJu0YwoypJ8MDNtvOxN79II7U5FEmwisCCK+0KuGK8B2RV7YjyOgn+Y
 Y4LNDaK7nvIMXsovX0D1lSqzl7re5WKqL38fPRNjl6/U+zUck7QNKuPe4qt6WQhXpecRJHNDBco
 qolOk
X-Gm-Gg: Acq92OGHxh/qhXqrkFIPDTP2yNh0CsGaS5EYkmyKR1YqS3smuVeI6O2qHpbYXy5sYql
 yY4CVK6gFhWC1LyOxkIss1og6lsArv5aYDYIm2fuZf+TkunhlCdVYJOaR2UvdxCllZzQjWH8Nww
 OwKlduOOiNaKhNyVGFpobIVktj1NH3WTALM4ff4anvLrBbNYgOAdiJj58pgoQ4w+r/aizLU/0OL
 BU7XhwIfXrqkU3k7EfQJTZXCvXqwQ4N4jeluMtmO3bulxEeAeaHIb1jO+WsMxU1kUZvs/9HRiCh
 5v6XIYOivyzRi9zyTF1MwKbaOglUCk5nLjKaxRfb4exjO1TlBRceReVlniU0rjt6L1ENYtb+5yx
 SNVrEAykHGanZPBJ3K0WmqRVFV47M40ZGwxqPqilR7LvdPtk8FuQiey2875vjBEqhhQYy0OxYlw
 6EKxZUb00qp9dW/1c7iGf7oszpmotZMeyJuJmIPjg+Sak3qfv6Hu5gjDjWMdJSygZuS+ipZN5Td
 OOD/w5mVdJV5uPadH/Qw/FQI3t9oNZvMiSbga1WBXE=
X-Received: by 2002:a05:600c:a088:b0:48e:5fb8:f80f with SMTP id
 5b1f17b1804b1-490c25f9100mr405189375e9.24.1781107953477; 
 Wed, 10 Jun 2026 09:12:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/71] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Wed, 10 Jun 2026 17:11:13 +0100
Message-ID: <20260610161202.2235298-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

This mirrors the logic for DISAS_WFE in 32 bit world. As the WFE/WFI
have similar behaviours shuffle the case statements around a little
and update the commentary to cover both.

Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260529082948.363931-5-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 092a979198..21ec3a5de7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11042,25 +11042,25 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NORETURN:
         case DISAS_SWI:
             break;
-        case DISAS_WFE:
-            gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
-            break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
             gen_helper_yield(tcg_env);
             break;
+        /*
+         * Both WFE/WFI can cause exceptions or exit the loop to
+         * halt so we have to make sure we have rectified the PC.
+         * However they can also return directly if they don't
+         * enter a wait state so we must add an exit block so we exit
+         * the loop and check for interrupts.
+         */
+        case DISAS_WFE:
+            gen_a64_update_pc(dc, 4);
+            gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
+            break;
         case DISAS_WFI:
-            /*
-             * This is a special case because we don't want to just halt
-             * the CPU if trying to debug across a WFI.
-             */
             gen_a64_update_pc(dc, 4);
             gen_helper_wfi(tcg_env, tcg_constant_i32(4));
-            /*
-             * The helper doesn't necessarily throw an exception, but we
-             * must go back to the main loop to check for interrupts anyway.
-             */
             tcg_gen_exit_tb(NULL, 0);
             break;
         }
-- 
2.43.0


