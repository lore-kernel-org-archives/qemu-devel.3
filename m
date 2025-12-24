Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25A7E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRLG-0002NC-ET; Wed, 24 Dec 2025 11:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRLC-0001eZ-Mv
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:03:58 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRLB-0006tT-4J
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:03:58 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b79d6a70fc8so1045449966b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592235; x=1767197035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRlP2mHQ3w8/+BW3Ob8kNCSGFQGF8HRvvdxkEfPzYfI=;
 b=PcfLIHZHpIm/icl56RKfL4mMhFempdCDwbZ9BEoHaobVWygmnEL0+YSJRL1ScIxOH1
 fybVM3Ir+TWy7FOm6qMGzgKj/TPP/Ct/TdS6VU+OKChhYmVjLH8S/G72pdNVpZ7tvc9l
 GsI4mqdpr//piKmkZQJ4nBScz/oTzw9nSUxMZraeR79z7/sCjs+lIoZwoFZy2E4zQtUd
 zMS0GlEBWJE0QpKgNdqYXS5zj2jtjwu+nuKH20WawfaJKn2QAAdn/hjdG3pfUOHWDkIa
 SQMq2svqlzGniMHBTJ9YcL3VLlhV0KT5xhdIkDgvypanzDIgCQgWOKoPh0wtGyeepp0L
 upXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592235; x=1767197035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sRlP2mHQ3w8/+BW3Ob8kNCSGFQGF8HRvvdxkEfPzYfI=;
 b=rz4ayxMtXpLQa0HC61OLGU4mdsrluSyYQEMPPYd92EYx9ik9GgG4JwplsT+3FrhRkS
 sOs8CO0xPrODwJ4QhXV4VA5t794WekoqGWNJ23KeLNxRfUqqOD439PfmJQ+jh86z/HFr
 IPz+dOeLehj5LgCigwoGC53MpSLJ612qva2yPyoDdTK+ciYs6aI6qwfRdDpRpPlrlazP
 w4+mu34JFNBnuyKmJdIfU0dTg0n2bGSd9b0rb681VReKDa2mPy7f2h7TpJ2r7sPPgv0O
 1zQyQ0paPjV+oDpq0p45NvrVXXAZqrNFVK05fEYOe1cKB1ZmZaTRPLRyS3ESCySfvxwW
 jHNw==
X-Gm-Message-State: AOJu0YxW0j9/c6wKfalTpDRYJLvwX/0jehArtoPcCN8KabhwzDG5wBCt
 m3RsL7g8Kkl4hIAks9NnWiQaBXVDipP1aMXQ5BPDxHkuzGjSH7gXoWixhwKhghcqVyaILA7Ull/
 MTapvOb8=
X-Gm-Gg: AY/fxX6RZ3zHi9dlacTt/XrwE8DSgtK4A8T2IuDrec1eEySTR1SwBG2lnKoXWPQkwDu
 hVmc8Xtg5JkRZxQc16RtgN0UMoel09Ryr/fMLHksw2AnEhMIxkosVgWzthmpU3fmiMDAj7FDs5W
 5EoiWMxpQ3lJPTA0kmlADtzwxVh+45K7zVXpEVJRAHJqdPqB+1LmijuZg2yq0vLZZRjK+wfBmQh
 E4lD9v0chfyHOpDpupHVYdhcDuEMT9wyM0wcDKFdlhZqPg0fy6ZUPzRDnREvC2RbT1GK5TNryt0
 9rEGj6DY/ZSbRHo/83szLV7DNuo06HSIWL2kIry/aka3WINKNRL9MzfLTn2GBVCfLGMDX6BAXcc
 AZ63zOzbJ2X7V0UMuAo3xXLbcr5JsEmDECkWHFOoHUjSlwy/QFrpWBRsATPN1uOz58WKfCtoHiu
 aQ4QpzpT9GOu2h8yLFLriOmMAhZLr6z3xh6NruEjry7wdVFYr8KoxIRyU=
X-Google-Smtp-Source: AGHT+IEfa23+goOEcoUCbVnLV4NDcvT9M3hqaiiD9JP8ECtV5vpiQLZaw0CJkiZSF3T0vi5ZRaLS/w==
X-Received: by 2002:a17:907:1c0a:b0:b7a:1bdc:aab8 with SMTP id
 a640c23a62f3a-b80372301femr1871557666b.65.1766592235242; 
 Wed, 24 Dec 2025 08:03:55 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ddffd2sm1709808266b.33.2025.12.24.08.03.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:03:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/avr: Inline translator_lduw()
Date: Wed, 24 Dec 2025 17:03:34 +0100
Message-ID: <20251224160335.88861-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160335.88861-1-philmd@linaro.org>
References: <20251224160335.88861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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


