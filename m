Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A419AD711C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLao-0003pv-2F; Thu, 18 Dec 2025 16:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLae-0003fn-02
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:31:16 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLac-0000AN-Di
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:31:15 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so9592075e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093472; x=1766698272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRlP2mHQ3w8/+BW3Ob8kNCSGFQGF8HRvvdxkEfPzYfI=;
 b=LGf+o7XJZpBXkMIqAa6Gq7QKJwBzS7X6/Nc4pzELnuTeieI3HH7xS1HpQy1XrWS5x5
 qz6JJbRA3f5pXIcyY6OamxGCuXiDg2awCUVzOkdmyYdpOYxzcbi0jDkKqcMNfZ9jGtcN
 70oD/rLq7JXCoTM9hArbqqRd2Mske4OMp3oSNU7IpzVS2XTn+IODMcW+kX3fcmme4Kwc
 Skn7gGMhb/Ih6drfBNKxab/tEFBZZf9O7VvaoquUYdlUKQRxmqBr7PvOWv4Ie+YS3EI1
 Fut3qqUqQgXEoIdm/yLtRuWTUbdBTCFRmcEplKt+kRrn9Lh8sm+2XhMPhr6z19vuOlPm
 Z39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093472; x=1766698272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sRlP2mHQ3w8/+BW3Ob8kNCSGFQGF8HRvvdxkEfPzYfI=;
 b=QDopA+vCEvA5hdz1c0/GemBJmUJ5OlXw1DLdKTYdc81kZkpEx73c9lbd4tpfcI0fce
 2OWeAl7AQ2pjeDDu7MaFK7CsQEsYQWSUu06CU3SuBAnaTUWumdzf9H9MV9HiaLu8+zx7
 tr1UepC2Hr0WEDIGZ22jpnAAPj7X1n5Yuf/8jvc9YMOKDpIBe+/kcUJ8TaLtbSeYMO27
 QaRt/fPne9IvsdodgrdlHlovvsfivlPNH20uvBOslTbL0JkKUbVFUkEFUPGbRVB2YOZ6
 1mDDDWScRbngs6BiPpedgjTU6fzruwCibbZwPokltJheCqBvrNry/p1iYh2gtkV30npM
 wXsA==
X-Gm-Message-State: AOJu0Ywu1T1eOrm45Jl+EQnWo2QNbA+mXBq5Ww/AU/m21XAtV2US5+xV
 g5GKuB3qILu+ibsXKMbsVXtYxggVOP7Am0xRaYqJOSU9I2JWGXZ5+3MtcTa8JlHe8nF4QfRJ57+
 +v4sNWqw=
X-Gm-Gg: AY/fxX6xK62tWkAWvgpSYR4sQ6NaEd5cMn5+pX+jf4pLFWwG6URLSxz7gFnDr3W3rSM
 WbDULRxSG9iBwXZLgorjjHdlih9pzYNoRgASzIynN3l1DvqQ1EaKstIv2oQa+Uz1p7nMnKX/2ZO
 ih+MS+Xrx8S5BMauxAHWyczR5+zvQSQu1AvfdrY+Q38MCoxmS2m4xY6YpgYR5Ruet/vFUeqZgfz
 xbqY+2yIfe6SWTBHBZwurG3OKJnBeVaQYmwAACeRiDXAqrl+YJP+a96Tba5OfKqiihQIdn3UVAQ
 7Ge7h4dCICsQDlFCpoPtmeawvLSszuBY8gLoJNeOoCaXRd+z9KDmyV0avbb8k3vrullI4FArHfW
 ye3hX6EYK/TudSaJKRS+3ta74NMlnC5S7krQ5PbxBplCqh+tQ3/JOI4SukXckjHgvUZyJdSBY9Y
 JaXXBfNdB13OXj7adNQbVKA2IjYO1WDShvBXkInwN2dPi4I9DYXw0KlOKzyFkt
X-Google-Smtp-Source: AGHT+IEHPWJSgWlcPxGdTh+pG1Br5JRFGWtdy6BaAJRxO6MHfbadACO9oDp1O5Crig4+PYHRPuRVkw==
X-Received: by 2002:a05:600c:19c6:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-47d195c201bmr4710545e9.33.1766093472367; 
 Thu, 18 Dec 2025 13:31:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723b2bsm61748705e9.3.2025.12.18.13.31.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:31:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/avr: Inline translator_lduw()
Date: Thu, 18 Dec 2025 22:30:52 +0100
Message-ID: <20251218213053.61665-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218213053.61665-1-philmd@linaro.org>
References: <20251218213053.61665-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

translator_lduw() is defined in "exec/translator.h" as:

 192 static inline uint16_t
 193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 194 {
 195     return translator_lduw_end(env, db, pc, MO_TE);
 196 }

Directly use the inlined form, expanding MO_TE -> MO_LE
since AVR only exists in little-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/avr/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index ef6f655a458..78ae83df219 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -173,7 +173,7 @@ static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
 
 static uint16_t next_word(DisasContext *ctx)
 {
-    return translator_lduw(ctx->env, &ctx->base, ctx->npc++ * 2);
+    return translator_lduw_end(ctx->env, &ctx->base, ctx->npc++ * 2, MO_LE);
 }
 
 static int append_16(DisasContext *ctx, int x)
-- 
2.52.0


