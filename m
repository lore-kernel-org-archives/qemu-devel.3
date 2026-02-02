Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27244E7316D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu44-0006mK-Ug; Mon, 02 Feb 2026 08:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu42-0006kw-FA
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu40-0002aL-TY
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so47830195e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039239; x=1770644039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ozYHqfgk0X+sYeYUfUg6SMvjxSTGckHgPzq9y9VW0U0=;
 b=MJYBy1N2HYK9EyQczXG/n2u5s4CkxmSuB5J3ksNgvsI0MERc21CAJrsqM1HAEYh9X1
 w7sNgWyrv+CQWGAlQgnD4/Zuk3SyUAbVUcW1Rv3aURUvIzNYg3/Ta/eA0J6cBLvvs2Nq
 Sw4V5Rt8SxdcvbffOaAOqiL3YHnjsAgI3XkR/H1QNE4SPIlKKuM6UXKkjI6fMi0ZJBvA
 P1z1TXxXJzChJEsJz9Q2Ayez8p90UYKlEu1ExruO7X+qQ78sSWPR/m/JYqHBnYn+JRKH
 q55mP45hsYKZ4zOC8D4tZmsuVBJAyKL+esre0Re2WHhAgrk13+yfFr1bPUrrjS8OfLww
 2LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039239; x=1770644039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ozYHqfgk0X+sYeYUfUg6SMvjxSTGckHgPzq9y9VW0U0=;
 b=w2RrBabW8JnUudQhXhZ0Iw4zR75eWYXWZjzQ7VFyW5DSNICwpT+zOb9FSeJv0jC5kl
 91Fn35U5oNp8zm/IFSxsU25ivVluVSLRQuQI6xr24uf5HIlzDkmEjsmLxLEuounm3UzY
 LdJgXeht88J2tOCQIs6W1I31evqMN1WLAjBkx4maCs0UlGQZgWYTGtT2oMGb7zUJVKVp
 onYww5jbCY9aGHTZn0E1hOzG60iO2QOowhHP7E6w3pzWOnQ+/XQSIOqILBs7CwRn5+Xf
 E0y/vh+cy04H/f/NWKxU1TMTH1Nzk28+XtoeiwPOwAH6zpcgsoK7EBhHgz3sZsD+3vJu
 jkaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl8yf4/VYCJycfH6ThJiA0jdjj2BPun5SowXAwYergUMt16KXnGFMeUSo5alnKQU4ZruKCw++9L26z@nongnu.org
X-Gm-Message-State: AOJu0YxSS3qkxWJE+7+C94x2Qu7pzvYznuWYw7VcCTb5++Obz7ysexKz
 mAVrtWS3seyZz9i06TFZfJ58qnkk/oax/NK0gkFmIimDIlvu9HX2v+AiPGjtskuGlcpe9EW/mM8
 92Cz2
X-Gm-Gg: AZuq6aJ+r5OqljlHuV58rKfbyO/SqByI8wjYYtH5L/VcVNoy5NVmML4rS63ZAUYB6Kt
 JmFr7WPevgxQ3MMc1/fAAyGXWWyJcCkF3c+5/U66jsjg104W6/CyqaAmO28enxkvJZC1o+cW7aq
 iDJKVWR2OQqvOAOsPRyyVan0ggvcLVaTI2MtonKxxc17JeIG4ZG7ODFJelSF1ZpS0bhVkv4EJFC
 m7gpNCJbaPxhN95YwoEEtaNPGZTRPGOY+z1Blk2q5DD9r/Gdhd2BZR0M8L7NMCdcIiIb8r2riHF
 F+RQbiatzf63BKjMw8lnTplUYjvVOp1IoO7pRcyNiPBHH2wYQxze7+gv7d7wcSSSK9YCSyuYnH/
 cFn7HHYLlhAfYp5JzgMBeOfSEuoCRhv5Ux6tferJ5u+OyBoQ8vemp4xRIlLFj3mZzmK2qrVKbDA
 KIdnv7tsxp0cveppwJvH/XGQCYjpUtXg==
X-Received: by 2002:a05:600c:6214:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-482db49d1b7mr151521965e9.27.1770039238819; 
 Mon, 02 Feb 2026 05:33:58 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:33:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 03/15] target/arm: Fix feature check in DO_SVE2_RRX,
 DO_SVE2_RRX_TB
Date: Mon,  2 Feb 2026 13:33:41 +0000
Message-ID: <20260202133353.2231685-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In the macros DO_SVE2_RRX and DO_SVE2_RRX_TB we use the
feature check aa64_sve, thus exposing this set of instructions
in SVE as well as SVE2. Use aa64_sve2 instead, so they UNDEF
on an SVE1-only CPU as they should.

Strictly, the condition here should be "SVE2 or SME"; but we
will correct that in a following commit with all the other
missing "or SME" checks.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 64adb5c1ce..81f487152c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3769,7 +3769,7 @@ TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_2h, a)
 
 #define DO_SVE2_RRX(NAME, FUNC) \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
+    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, a->index)
 
 DO_SVE2_RRX(MUL_zzx_h, gen_helper_gvec_mul_idx_h)
@@ -3787,7 +3787,7 @@ DO_SVE2_RRX(SQRDMULH_zzx_d, gen_helper_sve2_sqrdmulh_idx_d)
 #undef DO_SVE2_RRX
 
 #define DO_SVE2_RRX_TB(NAME, FUNC, TOP) \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
+    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, (a->index << 1) | TOP)
 
 DO_SVE2_RRX_TB(SQDMULLB_zzx_s, gen_helper_sve2_sqdmull_idx_s, false)
-- 
2.43.0


