Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE9AD711C8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLcB-0005UA-Uk; Thu, 18 Dec 2025 16:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLcA-0005SH-Kv
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:32:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLc9-0000dp-28
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:32:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso7871465e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093567; x=1766698367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZtI/19PH1qxxxO5yV1d3AnO/02CNWIpiyzoNC6Po/U=;
 b=resIcUaTxf0rt+ixuNdtdy/ouxu3foYFo8cJtqKKiOOu1ToXMhsm/vp43kbb0i7LX/
 gWehpZp5FKSA1TkAsp0jC74kiDmL2qrTGVauTtP4mJ/ryWiCH0fJj7IV/nwrU476GEK4
 8daea5peXLQcqxeXkOJYRoyVtH7hVJFX2zv3c8wSPGmaTz/heh3/mG9a+mdYV5mX+KvY
 mCi6heEbATWkeI0Zmgm/VvOtREFtWk0iw8TgAdXxTWalc/ozYuGhG2L0q5nTb7BA519m
 fqdjqroHo+4v1JcMvqAh4TGXuS7aXjF7fale5uhsyNvHdf5DABz5xJ4/TiXMx+iHOqlh
 7ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093567; x=1766698367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yZtI/19PH1qxxxO5yV1d3AnO/02CNWIpiyzoNC6Po/U=;
 b=AMyxe9X09oD/b4xcbnhA2/WqAfYmv+88qxwVQqiFDySYXOq1Y9lcD9kbBHUs4fuuXC
 AS3FESwIlfi5FCq+TgO+1MZAV5JytTuxoEZKbrPfGC0fvGWwx1NZp+2+MtkUP5D0pYMj
 FIZFgAjfdi6d4KS1QVNO8Dyl4yZPiHAzFFYEQFsXrnHoZDa4nyspDArzlI2U7GBQtXFR
 CXoEXO9o8sL6YzgO0AhO0DE7BTYpECoaPA8QZtCS2gm5YX9z2BJQ0gvx5Tsp0/qkEJXe
 YMgDgS+oCNtzmHXxkA/fh7pHIrXkr361/nsLKyWt65NZCxeTmybgVa62vRqJ6DXARkOP
 wcHw==
X-Gm-Message-State: AOJu0YyBO1fCHZtW5jIxiDLBjyPgVSVPvg0h65XD2Mw+TkbXaOlOOOER
 dSu8efsNjnmcO3AzqIW3tDlOvaRoF+2R5tECRwY+gVeJlIY37nEMAG6sfPMSKZZwQWapI87U1c9
 NoeWXuxs=
X-Gm-Gg: AY/fxX6DeM/NmbJjEMeHyi7ZZ07PpAT1UG0I0lmnVLHcR1t60C5yY1jg1nDl9Onuurs
 fTjr51DR8RxLZ+jAOkmjqn53+QG93lOq5bSJ7FgYDYpILF0siafE/V6zWapM5QU5SZCVUukucE/
 t18xyQRzm2T2a9BjvUycddcljVR8J4PRbUagPdxZGnj4Vo1xkjn1utgms9JLBnOgpe6bUfdOH3E
 yt97P+gzNfkBH6sOnqorcmJV4IK7qasKAFgR2YXZCuudleJy4sU+YUR9M+57e2snfGJTb3nV2gM
 Smf96gRPqpdTMvBQCjBsAli9dd8nTj5th17acNqbQWu+tK63jbqaliPTffYF/t6HcNfuM1mFeex
 gpL/Dv5CdNqj6p3DD+AHvDI/0UWMVxwLNsfMppp9zDI1vZDmHcISXzPYmlk9J4L0ntYPOzNNI97
 lm+MnkOZhQpv7H7F3EOvKhdonAOBPURA7ykfCDQZOzgIHVVkPuHIC9JMRbm5cy
X-Google-Smtp-Source: AGHT+IHnjDESJtqOEWwbbMZXdncbfj1/ATxyNOIxWzNyfKUViRT07LQcLPNiWVN6D+/TP3dTVcHBxA==
X-Received: by 2002:a05:600c:154e:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-47d194bbcf0mr5927065e9.0.1766093567113; 
 Thu, 18 Dec 2025 13:32:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b28a7sm62543865e9.12.2025.12.18.13.32.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:32:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/tricore: Inline translator_lduw()
Date: Thu, 18 Dec 2025 22:32:28 +0100
Message-ID: <20251218213229.61854-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218213229.61854-1-philmd@linaro.org>
References: <20251218213229.61854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
since we only build the TriCore target as little-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


