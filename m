Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F27CE776C4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRlx-0004MW-Nn; Wed, 24 Dec 2025 11:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRlK-00044r-Pr
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:30:59 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRlJ-0004tM-Bc
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:30:58 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64b4f730a02so9852194a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593855; x=1767198655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZtI/19PH1qxxxO5yV1d3AnO/02CNWIpiyzoNC6Po/U=;
 b=cJArL7Zy5zYonVCWke4M3WDpQvLWWTufi5h9bb1sVZA/S0DPgUeYA5XMLjTa8FYc1C
 n3cxLxhY/mngqqNj7sOVAFeCQVHsR/e6mnYZwerBiyQpZuEeJARx4MxsizVw4dwnsg/a
 ZMpHcVhh3+kC5lSxbSI2y2zvjnKW1wqjufElA06o59YE6/9/547tuAF6qGxhczLJYffI
 ZK/Rc6idmbsDF86htPLCAFVX48gC8mzzBKKq8ZqdGu2Rg02K5wiRRyyox691GQP1FxDE
 Kf8tihaGknkCpoVUfw4X4IlZLnKJcShQDti8geJ9ZRFM9c6DqRY6F8z6Ca8kwnNwe7Rt
 AOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593855; x=1767198655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yZtI/19PH1qxxxO5yV1d3AnO/02CNWIpiyzoNC6Po/U=;
 b=YoIEgl0Fr9MonXiaSVFHViXpIw1noRV0lG3tNyOLkADRDYjb7uTUxkhMALSH33GfGa
 bFoJLPgfIZbhWl2bkyVR72L5GDPOYjr5ZK/PZndwRTE5t65u95c/KRyexEwTTyzRTRBD
 Se63Q+YtaNCSQHir1dXBW7u5TERknQh9TPUT5m11jlSEoX4919GqItCp9nw5S63iZjpb
 zHERSP+PIqRncTQtJDZnMKDLiphsqlW4G85OYM+uex9OT5b55hZw537gXnCd5cYKsyWw
 lWHh1Y25en1qmuhr4RkZ1pawTMeGjVrsrNR0oNQqCcYwm/abDgcNiLChxWtZLxmz34Yn
 Q7yQ==
X-Gm-Message-State: AOJu0YwGneWo48LFIAjxz5/Bm4Uv3pveF85oWSCAMZOZrsSxxn0unwVy
 T0lGXNdxJ2/D0/xHWJcYWIcdHWKLdzOljkuTNL/dd2F5z/M0Ev+1ZJ6McTlIs2Tg3oPQu9ICGt2
 hwUMOLiQ=
X-Gm-Gg: AY/fxX7GGkcFsYKTv4/jRwVZt9SW5OYG+eziLHyNm2rMW7drcMsPzjej74b43ONeLew
 qwNwYkVKFaBcNAtMKKWTddaq/aWfMDJBiBEG29g2Tw++4J4rYh0wYlC3EamEX3C9Zys5DyBNwWu
 FOU7ERRMu85hAF47mu3Y9AINDtuU+9IDD/tl3k/+Oo13Tok1SfNiz3GTy0MKPGfhqJHbz45qGLL
 bQiUX5w0DD/adOt5ku0lVnQMXGlYEQSrFUgw9HdwgJ3VMqv3v9CG2YyGplHocOChY470f9PnOzs
 +QHkkIHF+Bi/kX0bqOBTbCHNRa3kGlk+aTRs2Rf5lSdJ+lmVDMny8pM67rmA14z3L03c8aY0BnJ
 QQfrQk2Y0RS+Uuc6Per8SAW3Az8WLceRvMBjp4YMUeFEFVPN8HiZlGiwuOshbGjE0lUkhZeoK0T
 sCmvT3l1yKHkyUsJf04uBHkQ2nEJmrIMvA8Gq6rLdJU3LB2kh6SRATxGs=
X-Google-Smtp-Source: AGHT+IFgBrMfHY67fIQzgHtsASlPqpbLF2JCTC6EyB1EBGp/Et5g4IE6NS1UydcPWd4BmN33nz4DKA==
X-Received: by 2002:a17:907:3d42:b0:b73:a0b9:181a with SMTP id
 a640c23a62f3a-b80371df391mr1934431266b.54.1766593855182; 
 Wed, 24 Dec 2025 08:30:55 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f0cb27sm1765556166b.51.2025.12.24.08.30.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:30:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/tricore: Inline translator_lduw()
Date: Wed, 24 Dec 2025 17:30:04 +0100
Message-ID: <20251224163005.91137-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224163005.91137-1-philmd@linaro.org>
References: <20251224163005.91137-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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


