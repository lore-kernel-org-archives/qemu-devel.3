Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E448CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQkO-0006QH-LO; Mon, 12 Jan 2026 17:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkM-00069i-Hz
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:50 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkK-0002ws-Vi
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:50 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432d256c2a9so3414719f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258247; x=1768863047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=katPieJzO6I6lmdXWmF8r5ghs7unIO0OUmZZAqR5nqg=;
 b=R0Uk8qMksBU+tINGl0X6Z9uzF02OXFcxy6Fr2UCbnuGqBIX+wQuFhvh81WgvsRBzcL
 jtNhg+64REajVMnqZc+sGNm+kRiz9yhocZaWkKL835kuNhAWhEyOYtrJJoz7pAR/1new
 bVHs0d91b9YuDrMx4ye7hh5TuoI62mXu886um7qjK1Jbq21AYFaDP8sc2QwCN0N88glT
 kVH3e/YYhn9uoAEprilhBlYM0yjVZ1CXqtF8y7degUchbNyO274JnVvYQU7Tllgo4sEa
 Fv0yWvAKVcJQdlVmnRX4ea+nKBSHIOzf1cCNsv3bmoyapgQicpo5XXIHI4q3VeeBVaiO
 jfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258247; x=1768863047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=katPieJzO6I6lmdXWmF8r5ghs7unIO0OUmZZAqR5nqg=;
 b=FfEhGgWnCh+fKnkdw7Go2mMzVVyoFmiDxL7F10angCF2BPeJ2Y8QUE7w3ourAletWK
 3ZN4TZ0VeCRSe0BcRAf6m1srVF8iE1gQZrCl+3S8lKaiYpvujadMuDUA3b14xatzMEEk
 OsTVbXAA30Jc0wPGylRjf/KrjLwT+ub46+9pGUvrWZNxPTUzK+/2gFs6EVlwsZHaxn/W
 xPFCVvnRhIdTcsdjiuJD+lBdIdt/hBIexTQrkPNHE4qEE8PNkuc2sFXt7N49OB6DFu9d
 Ne1Fm7IqsTniyirfG6iU6s38zU6miINI8he9Dl9f+N70UPUh3qGyFRMAiOAcY0gkkIwK
 4glg==
X-Gm-Message-State: AOJu0YxEBetQZx688g508OFYt4ODRg9/iEwG8yZTt/1GD+RA9+0+rNrq
 fybFP9/ZKYN9k7AuSVqk/JzyJnsQmYzxJO4r0y6DZ0VOlic0LLkqOOEo8f+Ql2RkPJcuH1u4X+r
 72OaHagA=
X-Gm-Gg: AY/fxX5ttCIkEB0bp3P20C9qqGsdoMFYphXEYWk8p38YsIpfPMUoQwzk3+8r16trmSf
 Z3o1nYymjzgGTVBsjPeG5HxNzn9/5D9VjSXEx1mC0jAiBsCSJR3JAetGkh4/YUWQVsBTKg8RCtm
 IZsuNxITfcis3F2NowmnO4wEODF4nBBSXmfQFkq5IyUH/Q6rEwZx1Ibz9KbbYj5vOgfazEuNAj6
 1Dr6k2pgJtn00KDbe6inka1yrRcYhJx4N+0s0DcprM3X+RYfN/IC0ljE7iwek1nSN1P/em6M2J+
 li19nbNU97Y5sHm0P5msBFep06HgubA+ysxvxxSAnKJp6j85zWlVMRWVT6eE8Md3odLAxMbYpqo
 USQPbKM2mWBshjAL6TCnrBR9ZvzcNQjffB0b9OOQwrI8IzcBqrKL2W2RqLF+8aJ6Wlink9e0iE6
 oFl28N3QM1QjDlrmPck/4bmYcBn4mxHCkbTAwf1tohwNn5aL3QHs6KU9m7t2XP
X-Google-Smtp-Source: AGHT+IHj6SKZbeiQtkagnIW3YrTEflibtf3VI40HRAobt7WSf69i2xjFnKw+5Y6xcRnRy2mu6SeLCg==
X-Received: by 2002:a5d:5f90:0:b0:431:104:6dd5 with SMTP id
 ffacd0b85a97d-432c37a3080mr24977784f8f.58.1768258247053; 
 Mon, 12 Jan 2026 14:50:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5e3sm40482222f8f.35.2026.01.12.14.50.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:50:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/61] target/avr: Inline translator_lduw()
Date: Mon, 12 Jan 2026 23:48:11 +0100
Message-ID: <20260112224857.42068-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

translator_lduw() is defined in "exec/translator.h" as:

 192 static inline uint16_t
 193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 194 {
 195     return translator_lduw_end(env, db, pc, MO_TE);
 196 }

Directly use the inlined form, expanding MO_TE -> MO_LE
since AVR only exists in little-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251218213053.61665-3-philmd@linaro.org>
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


