Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70CACF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQnt-0004hW-HD; Mon, 12 Jan 2026 17:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnj-00038Y-TB
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:19 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnh-0003i6-Od
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:19 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so3726780f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258456; x=1768863256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Aj7RQcjQ1JkDG+1Lvc1+6BaBbbgjLD/cowdMYnkzn8s=;
 b=FDd/VyHSViN4YQJpe3gR4suiBXJHM70GkLKyUT8lkIY/KSFp5XaBjQH+WlBRH2Hbp8
 M5h9SISGxIRATEhjr/kRTKUh/V8ZIbm27pmTPdiDKvq6vHFK3MKCYc35jKjjo+BOaeQW
 TcKfFxsmdOirdOgqrwUpiDGMHuvntkFkMAtNl1szgIvZj8G0exAjNqiRbCSX4349i62b
 jG6lpvqD41+oiJFKhjJhVRZoA2Pp4IBfzFBTJF9Uat69k60tw/wBmo16xJemnXZiUL0A
 FpVC2rP5I4Gdtd6dCqs++n/O+1AIym98tpiHNgRPC+0EraYV5ykFmjTHiJYl8HUpPa1A
 T/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258456; x=1768863256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Aj7RQcjQ1JkDG+1Lvc1+6BaBbbgjLD/cowdMYnkzn8s=;
 b=QV8PysMMnBcJylKYUfDaMHb0dk5x0lOK18/vIavHipfEAiZH+Mbqr8BuHOdwBMbvX0
 Cdt/yYjD7Ge4Um4bU0ljfCXxonxRmrx9/DBI8oXWHt/Clpc3EO2qE5zX6nlbXB4xpeaw
 A34+IxURU+JVCh8BkZ9QaR+jquRk4ffrnQquAQEz/NXoGdLqScRKvPKPX2kVVnAxJ+1K
 tsH8G93qAW32WlgiiT44dIe4nYNbgL11D1VZ27sk3zqbKULBLSDN8YAYfOPVlNdnvd0C
 oPkLZ1kJ3dOmPRk4DgepOfkj2R1FcseDAXR5Gnhrpmvqa0RbdIK0ioDSBxyJzLpry5Hn
 /oLA==
X-Gm-Message-State: AOJu0YxpfrvQr84J3lMwqDHMgSYEqT2xfapi0qq8k0+RT2ynbKk4iE7w
 SCCgCkFEF8jEPpIYMlnC/Yk84MVUSjbvChG0R/p3nGBy7cDUYtURvAFaN5I7YvQbegDDgGxOywm
 /RABwuzg=
X-Gm-Gg: AY/fxX49fs+rPUMw78+J4xxMbA/Eox60iQkbJSGqQxM9oFlegppZvVdIrBWkHjht5/l
 V4/4MmoobKbC2thAqtQqHt55DdVBbGl2IRP6HF/3RJ1Xkwg4yRDBBqknEH9Sx/Xndg296A4RKve
 ysFXR1O8iw4iITU9CYVTXmJFVzzxpf/92fTFdDIBXyts8Bit2reY4bpkSRkIx7wmw0voJJk32nf
 eeKqjwU1ht6BCWOVr+HK/j73+8ns70WtKdGjwBKo1O/18eeInMPQgay4fw7wafdUrQj1CQ2hsu2
 eDoRuvom6XJw6ZJRECMLnJsf3oXCA5h03oUkz6/nDtJQiOlYCOhBN1gTz/h1GIMjh8WZjweO2I9
 r2fN/TXV7KXrRQQIaUB6jbYhg2a4mq9tnSTsPpDoWM6dsfEm91II7c46KGHdEEm2pN7CIP1zLsz
 T8Lqn70yCjx7sO9iw1WGIotl7mXWyKtSpORDMi6wG7Xru580k7OXnE9QkjTBK2
X-Google-Smtp-Source: AGHT+IG79zqYKOIT549iO4oYlsifnxNH32rAlaA8BltP2iR3ccZKHSHeCW/6p2j+axaoyMsGsMg67A==
X-Received: by 2002:a05:600c:3152:b0:47d:403c:e5a0 with SMTP id
 5b1f17b1804b1-47d84b184abmr231733145e9.12.1768258456015; 
 Mon, 12 Jan 2026 14:54:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f695956sm384083565e9.6.2026.01.12.14.54.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:54:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/61] target/rx: Inline translator_lduw() and translator_ldl()
Date: Mon, 12 Jan 2026 23:48:41 +0100
Message-ID: <20260112224857.42068-47-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

translator_lduw() and translator_ldl() are defined in
"exec/translator.h" as:

  192 static inline uint16_t
  193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
  194 {
  195     return translator_lduw_end(env, db, pc, MO_TE);
  196 }

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> mo_endian().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224163304.91384-4-philmd@linaro.org>
---
 target/rx/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index ef865f14bf5..26d41548294 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -92,6 +92,7 @@ static uint32_t li(DisasContext *ctx, int sz)
 {
     vaddr addr;
     uint32_t tmp;
+    MemOp endian = mo_endian(ctx);
     CPURXState *env = ctx->env;
     addr = ctx->base.pc_next;
 
@@ -101,16 +102,16 @@ static uint32_t li(DisasContext *ctx, int sz)
         return (int8_t)translator_ldub(env, &ctx->base, addr);
     case 2:
         ctx->base.pc_next += 2;
-        return (int16_t)translator_lduw(env, &ctx->base, addr);
+        return (int16_t) translator_lduw_end(env, &ctx->base, addr, endian);
     case 3:
         ctx->base.pc_next += 3;
         tmp = (int8_t)translator_ldub(env, &ctx->base, addr + 2);
         tmp <<= 16;
-        tmp |= translator_lduw(env, &ctx->base, addr);
+        tmp |= translator_lduw_end(env, &ctx->base, addr, endian);
         return tmp;
     case 0:
         ctx->base.pc_next += 4;
-        return translator_ldl(env, &ctx->base, addr);
+        return translator_ldl_end(env, &ctx->base, addr, endian);
     default:
         g_assert_not_reached();
     }
@@ -206,7 +207,8 @@ static TCGv_i32 rx_index_addr(DisasContext *ctx, TCGv_i32 mem,
         ctx->base.pc_next += 1;
         return mem;
     case 2:
-        dsp = translator_lduw(ctx->env, &ctx->base, ctx->base.pc_next) << size;
+        dsp = translator_lduw_end(ctx->env, &ctx->base, ctx->base.pc_next,
+                                  mo_endian(ctx)) << size;
         tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
         ctx->base.pc_next += 2;
         return mem;
-- 
2.52.0


