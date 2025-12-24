Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA33E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRXN-0002mL-5R; Wed, 24 Dec 2025 11:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWy-0002bs-41
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:16:14 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWw-0001bc-GH
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:16:07 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso53387775e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592964; x=1767197764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9F73aGS8sTRdOKxrAoJd70MsYgS8hrcufSBcw/0jx0=;
 b=xbjkndZholEv8HhxEgSRiIfvY9qrthRD4DMhlkRsckLtk0KOzndnGQm0RHqnOncQZ4
 TXWFFH9sXjbH1qxXim0rhDui8bthdwfFR3cVNGoYgNDmjG5zUSaHdJ2+3NOsgerVkOit
 cz/wzdI3lLLZ00LFVudj9qc7HfRfzlfvmMRgo/0FFb92cgiPk11WDNrqw6gVe60pxZfA
 X7EMwNm4u+mQ9RuJ8kq7pELUdhj1N1rt5r39jTf4wHWZvGuJagQZ3Ou5yBPiqYG27/+2
 ioMSC76aArp5vYKqfpZQYzV1/vNbIdkdgoBkWjKFB0iJuCISooixYYZi4QrZt9a2WgkO
 xL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592964; x=1767197764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M9F73aGS8sTRdOKxrAoJd70MsYgS8hrcufSBcw/0jx0=;
 b=WqQ20ZZsgrdr8+ZKpRkbU2uJz0vqJG0+YD41aQxyFFvqx0EvUZeiHKZg0eq57YBa8n
 yW4zBdWEq2lhQVOV67ICvPOq6RUuHuPd9ZnRiRwinR4ySL6zxY/N1kNFvb+y83VP/Myz
 3w+zadH4mHgypJTCEYuRLIgBR9zeQ8CqTVlcTSHORLpqoAujzlvZP1qcTQ3qagP5pL2K
 4WcwfuST1tL2vKX+ABs5DzVOynWDxKCTEoEySbQuKYdwRb5OHPFJeQM6IY3Iwt1P+GRn
 XTpA+ez7zQsI9dHb3z36mrMqFgO89rdCwh+JQXNAU2JzcdshOY0rLT0fp0quIgeadvbr
 3mjw==
X-Gm-Message-State: AOJu0YxP7qGc/SONMgyTXv1Rpp294aPowVMpKRuTFIBZuj7BRhOuDQiF
 EG3TqQsJ93u8B6f2AGciFXdMGYg2lOvhqkkeDgiK22skqhek1q+n3HyNbTod8Zg+8WQ1D4QIh3M
 MhRNslPY=
X-Gm-Gg: AY/fxX6qqFcdNP7OHyiV0dBqLhOXAya3VNjWiX6ZsqYSkO1YIigzn0+ynsKCIGgNF63
 4DLb3qtZv0STC6Su8OH/TbnbbkccXCsrPGYxHeJwDgJnZyMhiujQS/ZLdxJekNXlm+I25mFXJ96
 A/W+LLSgRRkEKzRaviSJqaXNOL5vF6I7sw38iqaqjVhXPoprz9ztkl3aDJSwrZE4O8x3blJgqN4
 PQDfs+gYpbapc29HyChNu6BMJCojGCB5rd00QF5F8Tqa55zDnMX2dCROFysVpMA7MSn6OWLuYxM
 izXHVavWGMG+K+y4dUscoh+413WoPqfStNbRTewQRIFcaWh8r4cG4UeyoeoD7uH4/eaK9vB/iyX
 z2avuthQkhl9rceIs4Mga9TRMsjpuptmbv374P8/KyRxh4Srti8lkSjXajocXqfYVbdUpbSnJ/H
 KAyEB/JKN5FgoICW83Pj0RCZapikDdO0adfFQcnONEYP7qj8p2P4GSqEc=
X-Google-Smtp-Source: AGHT+IH5NSfs6SD+kqtzRwoAcAGkqMBPhpOzseD1AGeds2HnX88gRi6GwJiPoNaffnP3+S/PQo8rgQ==
X-Received: by 2002:a05:600c:1991:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-47d195aa354mr194077825e9.32.1766592964283; 
 Wed, 24 Dec 2025 08:16:04 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d1936d220sm325504445e9.8.2025.12.24.08.16.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:16:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] target/loongarch: Inline translator_ldl()
Date: Wed, 24 Dec 2025 17:14:55 +0100
Message-ID: <20251224161456.89707-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161456.89707-1-philmd@linaro.org>
References: <20251224161456.89707-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_LE
since LoongArch use little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 055f6fb6046..c23d2a614ae 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -286,7 +286,8 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    ctx->opcode = translator_ldl(cpu_env(cs), &ctx->base, ctx->base.pc_next);
+    ctx->opcode = translator_ldl_end(cpu_env(cs), &ctx->base,
+                                     ctx->base.pc_next, MO_LE);
 
     if (!decode(ctx, ctx->opcode)) {
         qemu_log_mask(LOG_UNIMP, "Error: unknown opcode. "
-- 
2.52.0


