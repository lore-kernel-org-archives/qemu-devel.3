Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BF0CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQoy-0005fe-VZ; Mon, 12 Jan 2026 17:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQos-000509-UY
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:32 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoo-0004GV-Ly
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:27 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477770019e4so52085565e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258524; x=1768863324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xOYLnzNYXMcyCP81sJAzFROsT9kL+p4pKjejlMAxqHg=;
 b=cobm9znVkGJb9W/rZn+Jo38B2kmKwEhvHyrb7pm/42fat637pX/DZ1GaevNTsL4ynj
 5P4Ebgt8Byarv24/ooSk5Us4e95SuunUfF5w+GWqIIeRrogondubCTa/OEjZ1Yz4frvd
 C9t+jZa7rD9YeqW2H23n+DknhPQFlOADHy/xKFp5suI9gIZPGNe6xTwugSmawLyon0po
 dH3nJRsa5i4dcGfYspf5yp19xkaCbW70baTM9yCspxGFVG82+JfDlM6WPEN3cNWz7VQ0
 RjbPTdSsdp23V9thX7SFtVG8RVrU0KF9cEkxz1cEVmc/wfHiW5zSnp7C1qaDzAOjpQML
 KsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258524; x=1768863324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xOYLnzNYXMcyCP81sJAzFROsT9kL+p4pKjejlMAxqHg=;
 b=f4GZ8GYUvYwr3sHu8IZ8wxbZChUW/kjlLsETN6BX2bJuOaaN3hZGu0c/Pg6epV8jWw
 +9j2PJg5CqjoooC79AbSkH6V3D9a4btiRPgCxsMWEm/3GdX3yGVXsMaGAQJQ30Jlrtg9
 PbpnI/Kg1NK/PX1tqsUPnpRoJDBtWLU6Cv0cKbDCLl4HubjyGW4wOyxyEhQzwDRVxZqN
 xt/hZH3g3eMGDb68ZaIVwjdIHzZLwuFEzHqI+wcw/Io8dRWXGz7fVmbVPL5ZILxz+HAq
 GGcVWFKgPAknXlUHn61K79wpbNfIai+ZcPWAprRkZrxXQlWDsA3NrCiEwq2qshmn0pEb
 LYqQ==
X-Gm-Message-State: AOJu0Yz7CSMZO1XkNnSd6oHV93q9Xy6ukTlOipamy3U3DNqha1RtTfmN
 Lfvo8iTLn6VtGkMXUSM48YgLLlOeNvf4Wsg0VX3D2uWJRr1al9GOnz1pPsJcNNjXpdjuSnztf1G
 J+clcrC4=
X-Gm-Gg: AY/fxX5ZKbQUd9Dc75VKe49Wkxm2IowvVASb0z/QBopgyTdFKD3FSTJxEFCID0/lOMN
 dafrFtdmWghLEiwULtkhSxzwAEf3eTqn90NXf5GdgyodStJK4HTxqqvm3/auR/1BPgyNBf4Qela
 3nJxClI8G7t8Abt+plklICYEH1gCXchd+egUkRo+36+pl6KDGHjnJmrWmGrMZk0+c3sqjvobIyL
 ISOARnfc55ayQDvNI/qyN3IsQhBjP2sd4Pu864MOCagRH9zCUlgSHbXmCgHPmzM9jkOp3HUrWEe
 NMsu7155DmlzdbN3JFPlfZLqqxX0qVPgTz8MPtjMeiT8m4Bb5gO5/6FctCYByKTXxJ1jkDccG8h
 6IFQXuTeYs6nC9qIKmVy800DgwiICeyolpFpIgeWi31yPTl21kK2ESLKn2Be3d1MRWD+aMdpFrs
 Mkrb+WZ1zqiLwHIptX+Pctb+mBL1dTR80PTQ9YUUoP6DGsf3aDf30LW5gIfaf1MFNfWIuuqj0=
X-Google-Smtp-Source: AGHT+IFkY+bSZO8MzlFkyB2pavyC1+O7oxO1MtMiBCaeVdAVknxmvI+eGPB5vQ/d3efaSYg1No2O9Q==
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id
 5b1f17b1804b1-47d84b32788mr221574165e9.21.1768258524171; 
 Mon, 12 Jan 2026 14:55:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f4ddsm383791015e9.2.2026.01.12.14.55.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:55:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/61] target/tricore: Inline translator_lduw()
Date: Mon, 12 Jan 2026 23:48:51 +0100
Message-ID: <20260112224857.42068-57-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
since we only build the TriCore target as little-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224163005.91137-3-philmd@linaro.org>
---
 target/tricore/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index fbe05a93a8a..18d8726af6d 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8422,7 +8422,8 @@ static bool insn_crosses_page(DisasContext *ctx, CPUTriCoreState *env)
      * 4 bytes from the page boundary, so we cross the page if the first
      * 16 bits indicate that this is a 32 bit insn.
      */
-    uint16_t insn = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+    uint16_t insn = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                        MO_LE);
 
     return !tricore_insn_is_16bit(insn);
 }
@@ -8435,15 +8436,15 @@ static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     uint16_t insn_lo;
     bool is_16bit;
 
-    insn_lo = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+    insn_lo = translator_lduw_end(env, &ctx->base, ctx->base.pc_next, MO_LE);
     is_16bit = tricore_insn_is_16bit(insn_lo);
     if (is_16bit) {
         ctx->opcode = insn_lo;
         ctx->pc_succ_insn = ctx->base.pc_next + 2;
         decode_16Bit_opc(ctx);
     } else {
-        uint32_t insn_hi = translator_lduw(env, &ctx->base,
-                                           ctx->base.pc_next + 2);
+        uint32_t insn_hi = translator_lduw_end(env, &ctx->base,
+                                               ctx->base.pc_next + 2, MO_LE);
         ctx->opcode = insn_hi << 16 | insn_lo;
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
         decode_32Bit_opc(ctx);
-- 
2.52.0


