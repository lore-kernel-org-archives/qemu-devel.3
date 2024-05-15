Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AEAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Ry-0004c2-32; Wed, 15 May 2024 03:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rv-0004V7-RD
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:19 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rq-0001dn-5B
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:18 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e0a34b2899so97515561fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759588; x=1716364388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abuDTzJtuHQkleQ2JIJcQY+Wz/0ibhtmXe6lLhOCiLw=;
 b=i8fhWAB7/rX0k49UD5yYoZIPvYo+6JF1n74FzxcGOverPqNbrpsSe0ovChgDY93s4l
 FilXeHi/20SKR2F2qBKrXLGGpfGCncqYOv2H8L3vBxBismPpkz/9UCKaMJY1LeK5uP75
 R6byzLwpCFSTJFDjwsjiZ8zoaU24TGL3BFVFQ8K69GLf8bQ8wUCjIAsR8V5sGa52onrk
 FDyquwuKizSCsv64AYAHg1SiqkGVvLzzPPRnUL12jcamoKnEesczytnV4Qrwuidt0n0w
 1nF1YbZorfMcV4dxT4y7nh6/8gydseQq/kkKbA80kqgfZBORttC/drG60yhxFqx9I6TD
 OXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759588; x=1716364388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abuDTzJtuHQkleQ2JIJcQY+Wz/0ibhtmXe6lLhOCiLw=;
 b=mx9lf2a3/oOKfrke6FCouFgKzbLF4RnpVL6EsaI3SlkWrrCRfR5PrnkYLlOLd1YW4z
 l3gMx4ppLZ+kUJZmmH2/gUgkNOp6++EH1dFEmY91nyH+03ByouLs9Jlur34ZlsAbvOBU
 XSqFxGscAiAV7xBVdEVHcuyu/I9AXVbAEZRsFdZN8ydoB8XKZBPqs2FX0Sf0iPpGUajz
 66dN45cXvjK+763PfSEwm1DovoSi3rm68x3bBtaGj9mRaCRva1IDFlpl7dLxFWwK//1e
 5IOAwI5a6ENPcUjUk5dBc6AgGcqEBBbeohC9vF5D9x5ziW9+BgyLGPqDpJoHuIpDBB0h
 e4jQ==
X-Gm-Message-State: AOJu0Yy95NDpALtwdq7mcn+6mI4rq1XZPR8PTftzaYIGA3cBp9K7ysBk
 ur5GLDox/EKZG+/H/S47oR0SmpHEYngLXJHJ0Vs96r5dX77auA3f+trFc6M7LEMeqaV08Fx/Rv5
 aM/c=
X-Google-Smtp-Source: AGHT+IECnMss/1y9Z+0guqvKFeu/hxn8gS4VK1E99y8JSPGaKlkazWaT14GhgFvN9hMw+P33CV5e3A==
X-Received: by 2002:a2e:9e19:0:b0:2e6:f7f7:772b with SMTP id
 38308e7fff4ca-2e6f7f779d3mr10487091fa.37.1715759588492; 
 Wed, 15 May 2024 00:53:08 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/34] target/rx: Use translator_ld*
Date: Wed, 15 May 2024 09:52:43 +0200
Message-Id: <20240515075247.68024-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
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

Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/translate.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 92fb2b43ad..9b81cf20b3 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -22,7 +22,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
-#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
@@ -75,10 +74,10 @@ static TCGv_i64 cpu_acc;
 
 /* decoder helper */
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
-                           int i, int n)
+                                  int i, int n)
 {
     while (++i <= n) {
-        uint8_t b = cpu_ldub_code(ctx->env, ctx->base.pc_next++);
+        uint8_t b = translator_ldub(ctx->env, &ctx->base, ctx->base.pc_next++);
         insn |= b << (32 - i * 8);
     }
     return insn;
@@ -90,22 +89,24 @@ static uint32_t li(DisasContext *ctx, int sz)
     CPURXState *env = ctx->env;
     addr = ctx->base.pc_next;
 
-    tcg_debug_assert(sz < 4);
     switch (sz) {
     case 1:
         ctx->base.pc_next += 1;
-        return cpu_ldsb_code(env, addr);
+        return (int8_t)translator_ldub(env, &ctx->base, addr);
     case 2:
         ctx->base.pc_next += 2;
-        return cpu_ldsw_code(env, addr);
+        return (int16_t)translator_lduw(env, &ctx->base, addr);
     case 3:
         ctx->base.pc_next += 3;
-        tmp = cpu_ldsb_code(env, addr + 2) << 16;
-        tmp |= cpu_lduw_code(env, addr) & 0xffff;
+        tmp = (int8_t)translator_ldub(env, &ctx->base, addr + 2);
+        tmp <<= 16;
+        tmp |= translator_lduw(env, &ctx->base, addr);
         return tmp;
     case 0:
         ctx->base.pc_next += 4;
-        return cpu_ldl_code(env, addr);
+        return translator_ldl(env, &ctx->base, addr);
+    default:
+        g_assert_not_reached();
     }
     return 0;
 }
@@ -190,22 +191,22 @@ static inline TCGv rx_index_addr(DisasContext *ctx, TCGv mem,
 {
     uint32_t dsp;
 
-    tcg_debug_assert(ld < 3);
     switch (ld) {
     case 0:
         return cpu_regs[reg];
     case 1:
-        dsp = cpu_ldub_code(ctx->env, ctx->base.pc_next) << size;
+        dsp = translator_ldub(ctx->env, &ctx->base, ctx->base.pc_next) << size;
         tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
         ctx->base.pc_next += 1;
         return mem;
     case 2:
-        dsp = cpu_lduw_code(ctx->env, ctx->base.pc_next) << size;
+        dsp = translator_lduw(ctx->env, &ctx->base, ctx->base.pc_next) << size;
         tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
         ctx->base.pc_next += 2;
         return mem;
+    default:
+        g_assert_not_reached();
     }
-    return NULL;
 }
 
 static inline MemOp mi_to_mop(unsigned mi)
-- 
2.34.1


