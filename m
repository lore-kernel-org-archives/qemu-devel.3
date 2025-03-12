Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BA1C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJPQ-0001GR-Tx; Wed, 12 Mar 2025 06:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJOS-0000o9-5G
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:32:58 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJOQ-00025w-7T
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:32:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390fdaf2897so6095640f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741775572; x=1742380372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hD1gJPuXBQtsnW2GFiw60RNg3iXdnKWxQY6Lv+2jcl8=;
 b=b5qqxSFGqT8NU8GUQFoCiu0R40Uwdq23rBfrnAYEsgg0u7P3FGMo/pC1bT0LRC5HkY
 DGHonGzph4/hbvOwQx5wG6hhLr7mik10axm/DvUeaqlNQtgPbNDJOw5dS7VZ0Zr3qDQS
 CjbmYvJ7Wl1JqxXOBbFx/YOPIUl+ZJrE3VS9lS6H6feBmmTvD0MzVRKyXxE2Eq+cRdyU
 ZlOdFxp84/Ty4mtvm3Qg4LjKA03ZNkV4ke63dW5Nw+l8zhCSDbaLxWLbKwot1H0/37f5
 KJ4ef41ysn2EaYtc/1uJsSbYJVwwVgLCKd2LVGPn9xiL6LsLxF285uNXWw/8dkEh6+js
 +llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741775572; x=1742380372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hD1gJPuXBQtsnW2GFiw60RNg3iXdnKWxQY6Lv+2jcl8=;
 b=NZn7NaTPYsPIcNQot5y0k4BjK4GbWSnNUcgvmggNGGWNSiSu9OeigaRVaqRc/qgvsu
 kcwWEL4+AjF2jiNDCVpbc1+W/BE4PwyWY6Hm3R+5ycj6PY4OlAonC+otqVmbjvClgCZr
 CQfeTFTIj1Bf42q1uYNNn+JP4+rUGoSv8pamS/355vVEcjL23msyuBlR7tIgxyeAC+px
 WJ4A1+lHfeW3P7GhYqa6UQheOJ2AfsljxRIt6bSfNOEFMFBuydU5l6CYD/yCKMjj/JOC
 rTlc86Z99mWqKB1IWYzmdKePOcLVo/PHvL+i20Qwlc7J/MIaVzgH4iXMUkWuyPlwsM3o
 UQFA==
X-Gm-Message-State: AOJu0YzdZx7Z4uKp2VV+u1DiO/QC9aYoWhcgLLVpRuoryLe4TSRV6rGR
 H1/eP81AzBlTGxGXxVN+5s+hQeVaQ7LS//QR4+errorYQ4jL6NhaausjmZ9QxtH+WkcrGxqFOvG
 m
X-Gm-Gg: ASbGncsavxOc0QHFm87QJsEe2uyYSWH2jVIpK60F02fWlobs+EgQKzkYdc590nrK00K
 fk4X5FyepObIufr+PDt8lbWQyBkIec/vDEsNez+M+pKW/DV/SvGv7UMqs+QHzODkM8+UkPwlLfD
 qvhIXbX1UqZmF423ca1C9H104qbhql/Aa6vcJqVPema0SOA0yUkWOvuJMF1A8jWeKsGd1H6ffZj
 2qjh8ykcgqAkFJ3uIQN3e+TtbPaVYlce4Vskc0xwjKg3UhEMAsJul3fC0CdYXa+j1JcgwgjsnR0
 jJhtgdG/0pTsL8+rna8hJjFNSQ5dW7pQkHUAcQWYb3IUkcKFUELTfU5DwDr6QD9VYqbqc/eoo3h
 IrMmnJ0xJHx1IPplTQ5+J17Ul
X-Google-Smtp-Source: AGHT+IH4vmsDvSmYjIkf6fCYUdj6t8hauawTIQni9BCu6H8FycAFK/Flb5Y2yS33PwbCkU5ADAPQFA==
X-Received: by 2002:a5d:64c7:0:b0:390:e2a3:cb7b with SMTP id
 ffacd0b85a97d-39132da28a0mr20530017f8f.34.1741775571858; 
 Wed, 12 Mar 2025 03:32:51 -0700 (PDT)
Received: from localhost.localdomain (99.167.185.81.rev.sfr.net.
 [81.185.167.99]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1030cfsm21066292f8f.90.2025.03.12.03.32.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Mar 2025 03:32:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 2/2] target/hexagon: Replace MO_TE -> MO_LE
Date: Wed, 12 Mar 2025 11:32:38 +0100
Message-ID: <20250312103238.99981-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312103238.99981-1-philmd@linaro.org>
References: <20250312103238.99981-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
index 0e1183836ca..38964791e70 100644
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


