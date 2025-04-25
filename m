Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101AFC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KzA-00004s-Uo; Fri, 25 Apr 2025 11:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kz6-0008Vh-Ce
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kz4-0003VW-5K
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:28:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39ee623fe64so2317847f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594934; x=1746199734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PL/pbGmcKwmMY894OfAIyHx+t+LYIl3S64i+vmGdXH8=;
 b=NFZ3xqdgmKivUZA4pnbOqH2sQYGiOi+mcYjTayhZUPmDHwyue54ulSG2YKx3X6MhoX
 XdgkZn1LhleRT1QyGO12CSvmBzVkuT/gpRSNeJwRoF85XlF+oQ8iwAYUUTb2eD4Lf09H
 vHXUc0KdrAdWChv8IcOtmI8nfpeM8Gq51b02m+rI35Ml9HKDo//rmTs32YEKOakLMZTB
 7ZQN8VcE/2iVnsutFJCASumy5VL/xtIcK4r2nS5aTQQS31iTLEepvL3bwzoVqTR4IAsL
 ZX/4wiKmEwk21aFX+s5frf7Jcri1ZvH/oXBAUcj0iSrzUl+B7hry+owUQ6ZTGXEkFdwF
 IQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594934; x=1746199734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PL/pbGmcKwmMY894OfAIyHx+t+LYIl3S64i+vmGdXH8=;
 b=eO6nR7a4LhLeo5Cl+KBuFlmCW4XR5ZEle6rJLsrFESjRwXA4pLFAxy9TBl6E7A+OcQ
 aopZXKOWXz7eOkxgruBT1ep9y14vP2X3hf9BGIQL2fUYvpM+c80LELODsaaqoxO8mxcY
 EcrnE8FP2ckhjP7L1XcOfMkiRjWrdzaQdWmVuxOatOp31SFKiANI5BcF5mtQoviX+T73
 4Qwi2j/gHUrkJ1wHzZK1u0JaeZniBuTqUln7t6thve2pSUCrn5udxFkDvi7rMd/Z9stR
 xHjRnass+bzCvQIJSD6eXSM29ZeuTXdprOVXf9SvTWt90ZesX6ieaebEghkdSy+A5l2n
 y1Vg==
X-Gm-Message-State: AOJu0YyGYzlUoavCFXeuDla1KPw2LJ9yWrxBQfsQ35l/jt2At83xGIMN
 Ixci2onEbveDzKwTbHhHQq2l5EUOVpnd4cQ0jH4m9vi+zu33rvdXU9lBTUFTMO66aTIZSCMH0Mb
 +
X-Gm-Gg: ASbGncsTTl9ip/liSy+wUvHOQqtsmrYFVYiDla00XXW2YfgGYIfZ/s4nmIt++jDzDE5
 QAQewkRsPEDpNuzatyWJ1hWdEoBPkGOcR8g81Vr3FSTqd/gcEQSK5ndUFh7m5qjjddua4qH70fO
 3pW/kLywAzp0QxbpGi6l4EBoWipf4GTmnRCOpcko4TLRCnUJw+R5xZpKKpKlTd1SiYjWLhUn5eM
 qSNyOJRSDuk+XwmK4zSWI1lTnXV44054oARj817IftsBnKhzZYg7WJiCms/A7Rdl5Qz40XtoduD
 85xqJ7FCTG9gqpTJsyin5ysFx1jt+1PVp7vwXcjw5D5NNYYCTy6KNoYzvyrhsQD+jOoC5ARs8+V
 MycOy7JOvhEmFctc=
X-Google-Smtp-Source: AGHT+IFWpYI4HWRMkfZ/svNt5BuW6MjT5oBIz0p4ALdt7rd80rUQ2XCA0j/rUkB60LMCyQMUd4rQtw==
X-Received: by 2002:a5d:6d8e:0:b0:399:6d53:68d9 with SMTP id
 ffacd0b85a97d-3a074f10912mr2505813f8f.38.1745594934506; 
 Fri, 25 Apr 2025 08:28:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca42cdsm2627729f8f.22.2025.04.25.08.28.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:28:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 02/58] target/hexagon: Replace MO_TE -> MO_LE
Date: Fri, 25 Apr 2025 17:27:46 +0200
Message-ID: <20250425152843.69638-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

We only build the Hexagon target using little endianness order.
The MO_TE definition always expands to MO_LE. Use the latter to
simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20250312103238.99981-3-philmd@linaro.org>
---
 target/hexagon/macros.h                     | 10 +++++-----
 target/hexagon/genptr.c                     |  8 ++++----
 target/hexagon/idef-parser/parser-helpers.c |  2 +-
 target/hexagon/translate.c                  |  6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 57825efa55d..e5eb31e6711 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -115,27 +115,27 @@
 #define MEM_LOAD2s(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 2); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TE | MO_SW); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_SW); \
     } while (0)
 #define MEM_LOAD2u(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 2); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TE | MO_UW); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_UW); \
     } while (0)
 #define MEM_LOAD4s(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 4); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TE | MO_SL); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_SL); \
     } while (0)
 #define MEM_LOAD4u(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 4); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TE | MO_UL); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_UL); \
     } while (0)
 #define MEM_LOAD8u(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 8); \
-        tcg_gen_qemu_ld_i64(DST, VA, ctx->mem_idx, MO_TE | MO_UQ); \
+        tcg_gen_qemu_ld_i64(DST, VA, ctx->mem_idx, MO_LE | MO_UQ); \
     } while (0)
 
 #define MEM_STORE1_FUNC(X) \
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 561e93c9fd4..08fc5413de7 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -329,14 +329,14 @@ void gen_set_byte_i64(int N, TCGv_i64 result, TCGv src)
 
 static inline void gen_load_locked4u(TCGv dest, TCGv vaddr, int mem_index)
 {
-    tcg_gen_qemu_ld_tl(dest, vaddr, mem_index, MO_TE | MO_UL);
+    tcg_gen_qemu_ld_tl(dest, vaddr, mem_index, MO_LE | MO_UL);
     tcg_gen_mov_tl(hex_llsc_addr, vaddr);
     tcg_gen_mov_tl(hex_llsc_val, dest);
 }
 
 static inline void gen_load_locked8u(TCGv_i64 dest, TCGv vaddr, int mem_index)
 {
-    tcg_gen_qemu_ld_i64(dest, vaddr, mem_index, MO_TE | MO_UQ);
+    tcg_gen_qemu_ld_i64(dest, vaddr, mem_index, MO_LE | MO_UQ);
     tcg_gen_mov_tl(hex_llsc_addr, vaddr);
     tcg_gen_mov_i64(hex_llsc_val_i64, dest);
 }
@@ -756,7 +756,7 @@ static void gen_load_frame(DisasContext *ctx, TCGv_i64 frame, TCGv EA)
 {
     Insn *insn = ctx->insn;  /* Needed for CHECK_NOSHUF */
     CHECK_NOSHUF(EA, 8);
-    tcg_gen_qemu_ld_i64(frame, EA, ctx->mem_idx, MO_TE | MO_UQ);
+    tcg_gen_qemu_ld_i64(frame, EA, ctx->mem_idx, MO_LE | MO_UQ);
 }
 
 #ifndef CONFIG_HEXAGON_IDEF_PARSER
@@ -1230,7 +1230,7 @@ static void gen_vreg_load(DisasContext *ctx, intptr_t dstoff, TCGv src,
         tcg_gen_andi_tl(src, src, ~((int32_t)sizeof(MMVector) - 1));
     }
     for (int i = 0; i < sizeof(MMVector) / 8; i++) {
-        tcg_gen_qemu_ld_i64(tmp, src, ctx->mem_idx, MO_TE | MO_UQ);
+        tcg_gen_qemu_ld_i64(tmp, src, ctx->mem_idx, MO_LE | MO_UQ);
         tcg_gen_addi_tl(src, src, 8);
         tcg_gen_st_i64(tmp, tcg_env, dstoff + i * 8);
     }
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index a7dcd85fe43..542af8d0a65 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -1761,7 +1761,7 @@ void gen_load(Context *c, YYLTYPE *locp, HexValue *width,
     if (signedness == SIGNED) {
         OUT(c, locp, " | MO_SIGN");
     }
-    OUT(c, locp, " | MO_TE);\n");
+    OUT(c, locp, " | MO_LE);\n");
 }
 
 void gen_store(Context *c, YYLTYPE *locp, HexValue *width, HexValue *ea,
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 0109f31e19f..02fd40c160f 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -656,17 +656,17 @@ void process_store(DisasContext *ctx, int slot_num)
         case 2:
             tcg_gen_qemu_st_tl(hex_store_val32[slot_num],
                                hex_store_addr[slot_num],
-                               ctx->mem_idx, MO_TE | MO_UW);
+                               ctx->mem_idx, MO_LE | MO_UW);
             break;
         case 4:
             tcg_gen_qemu_st_tl(hex_store_val32[slot_num],
                                hex_store_addr[slot_num],
-                               ctx->mem_idx, MO_TE | MO_UL);
+                               ctx->mem_idx, MO_LE | MO_UL);
             break;
         case 8:
             tcg_gen_qemu_st_i64(hex_store_val64[slot_num],
                                 hex_store_addr[slot_num],
-                                ctx->mem_idx, MO_TE | MO_UQ);
+                                ctx->mem_idx, MO_LE | MO_UQ);
             break;
         default:
             {
-- 
2.47.1


