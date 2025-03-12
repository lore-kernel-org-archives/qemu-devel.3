Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7CAC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJOu-0000wr-BG; Wed, 12 Mar 2025 06:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJOO-0000nh-Mg
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:32:56 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJOK-00023S-Oz
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:32:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso2151015e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741775566; x=1742380366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkP/pXjo/XxmCPoswMyWGaFDc36zdsHqloQVUCzlEHY=;
 b=uu6Bn7s08L4TpJgQGHubZz5K9Aq5RBjeVbhJBaUYNoZc+zQK6xlNeLdHUt8Am91DD8
 Y0gy64UZI4WBJz3F4psBeAQd8+teVjD0y0MgB6yZjRu7E5aU+wjRXPcTmcoVFucEWvRs
 AZqymYWWYlH40/KyaHMmjjZkHSTXAGUWom44OFg9Dc5gumQP4VhBmrFB7XdHY3xkx6pH
 /99rcRs95A+rBkOBx5rCRqvxi2YKfTRNyN5qqbyzN0t41KJweFy8J25bghJLEQKyrVlP
 IHYE3s+2CanE8Tr2rOELaIpTSN0b1WcGFyQeoO3Le9xuXaAvHkQ1k/NY4cne/+CRki+i
 llBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741775566; x=1742380366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkP/pXjo/XxmCPoswMyWGaFDc36zdsHqloQVUCzlEHY=;
 b=dMUrlf5ZalmBGFkLO3PN4+L7ppPv6JqbhcKhWf3TuJYiIuMFwsE/rS0gf8kNI7Ymo+
 3s4YJO9Ejvy9VtSVnkGmuM34HL3FZspcMq+Mlc0z7T5eyxdTNs9poPq3uE5qMUPK9Tpl
 FUXfMe8FFsJARNK3eFvSuTZAjdXeJorUjPVtIOvBsCncgPKcIsULGG9a7b/ZWtlhOM/x
 9UOblD2WBBzI6XKUXiwrov1+ol6/E1Xu64vG80pn4uGx1MsAXSTPAQw4vdZvtXMM/MBS
 zUKKTLc80DkaoVzhxkwrRIaTgAH0OVmEKsXRfeyBCaBYNJEVHSX+yDBDUmv/ZHDxfxcz
 /yMg==
X-Gm-Message-State: AOJu0Yyl1YEBIKyPLVFqAzKxAk61C2ivFiDPi3Gvs5sdoZHLYfnKBOqX
 gNSk8U3Xywym6sn2ngWTVQUCQLytQgTFhvglsoA6/7VSn0KiheV+8tb9wo+KBEUST84rlKIoKWt
 s
X-Gm-Gg: ASbGncte17VF6X+B2uw5En4E6zMaJEQOIBFjWFn/Z7aVpVGGU02dLipkeljy5fI9AtO
 xGrmpvzU9RICur91E1a4QCe6MThcI6h4yKfuCaDG7pyW0jey0lm3VN7t19NG6gtBfWr1bvbNnuX
 xjDA/ftidTcyfmuaEDR1FTt/4/AUMct4MHFKF9rfoouQT/pSmnTVd8tp1apJ4HngjdS36tHuTcW
 uSv3+vL7/UXfSVQAg9mpSa8JkjHn3XrHdH8VHq2NzSBYPkD1EfDJj4NQ5U2nsa1a0dV839K5a5g
 9tayyqe+P4SDfbH0iwmp6EjCl3nGOf+s8o2hTsmA7ia9nVEkpBGGtSDHJX+Z7p1NpHPkXypJ/nI
 Cjm6NRTWmZJMpJg==
X-Google-Smtp-Source: AGHT+IFsPgRb5nEYaXB+l4djN+e4rsEqGGw+6mILW+ttFeh626D+CEUoex82c5VuEiTOHxQ0mpvi9w==
X-Received: by 2002:a05:600c:45d1:b0:43b:c878:144c with SMTP id
 5b1f17b1804b1-43c5a60186emr163166895e9.12.1741775566363; 
 Wed, 12 Mar 2025 03:32:46 -0700 (PDT)
Received: from localhost.localdomain (99.167.185.81.rev.sfr.net.
 [81.185.167.99]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3947a24449bsm1360927f8f.45.2025.03.12.03.32.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Mar 2025 03:32:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 1/2] target/hexagon: Explode MO_TExx -> MO_TE | MO_xx
Date: Wed, 12 Mar 2025 11:32:37 +0100
Message-ID: <20250312103238.99981-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312103238.99981-1-philmd@linaro.org>
References: <20250312103238.99981-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Extract the implicit MO_TE definition in order to replace
it in the next commit.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/hexagon); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/macros.h    | 10 +++++-----
 target/hexagon/genptr.c    |  8 ++++----
 target/hexagon/translate.c |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index ee3d4c88e7b..57825efa55d 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -115,27 +115,27 @@
 #define MEM_LOAD2s(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 2); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TESW); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TE | MO_SW); \
     } while (0)
 #define MEM_LOAD2u(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 2); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TEUW); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TE | MO_UW); \
     } while (0)
 #define MEM_LOAD4s(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 4); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TESL); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TE | MO_SL); \
     } while (0)
 #define MEM_LOAD4u(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 4); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TEUL); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_TE | MO_UL); \
     } while (0)
 #define MEM_LOAD8u(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 8); \
-        tcg_gen_qemu_ld_i64(DST, VA, ctx->mem_idx, MO_TEUQ); \
+        tcg_gen_qemu_ld_i64(DST, VA, ctx->mem_idx, MO_TE | MO_UQ); \
     } while (0)
 
 #define MEM_STORE1_FUNC(X) \
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 2c5e15cfcf6..561e93c9fd4 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -329,14 +329,14 @@ void gen_set_byte_i64(int N, TCGv_i64 result, TCGv src)
 
 static inline void gen_load_locked4u(TCGv dest, TCGv vaddr, int mem_index)
 {
-    tcg_gen_qemu_ld_tl(dest, vaddr, mem_index, MO_TEUL);
+    tcg_gen_qemu_ld_tl(dest, vaddr, mem_index, MO_TE | MO_UL);
     tcg_gen_mov_tl(hex_llsc_addr, vaddr);
     tcg_gen_mov_tl(hex_llsc_val, dest);
 }
 
 static inline void gen_load_locked8u(TCGv_i64 dest, TCGv vaddr, int mem_index)
 {
-    tcg_gen_qemu_ld_i64(dest, vaddr, mem_index, MO_TEUQ);
+    tcg_gen_qemu_ld_i64(dest, vaddr, mem_index, MO_TE | MO_UQ);
     tcg_gen_mov_tl(hex_llsc_addr, vaddr);
     tcg_gen_mov_i64(hex_llsc_val_i64, dest);
 }
@@ -756,7 +756,7 @@ static void gen_load_frame(DisasContext *ctx, TCGv_i64 frame, TCGv EA)
 {
     Insn *insn = ctx->insn;  /* Needed for CHECK_NOSHUF */
     CHECK_NOSHUF(EA, 8);
-    tcg_gen_qemu_ld_i64(frame, EA, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_ld_i64(frame, EA, ctx->mem_idx, MO_TE | MO_UQ);
 }
 
 #ifndef CONFIG_HEXAGON_IDEF_PARSER
@@ -1230,7 +1230,7 @@ static void gen_vreg_load(DisasContext *ctx, intptr_t dstoff, TCGv src,
         tcg_gen_andi_tl(src, src, ~((int32_t)sizeof(MMVector) - 1));
     }
     for (int i = 0; i < sizeof(MMVector) / 8; i++) {
-        tcg_gen_qemu_ld_i64(tmp, src, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_ld_i64(tmp, src, ctx->mem_idx, MO_TE | MO_UQ);
         tcg_gen_addi_tl(src, src, 8);
         tcg_gen_st_i64(tmp, tcg_env, dstoff + i * 8);
     }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index fe7858703c8..0e1183836ca 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -656,17 +656,17 @@ void process_store(DisasContext *ctx, int slot_num)
         case 2:
             tcg_gen_qemu_st_tl(hex_store_val32[slot_num],
                                hex_store_addr[slot_num],
-                               ctx->mem_idx, MO_TEUW);
+                               ctx->mem_idx, MO_TE | MO_UW);
             break;
         case 4:
             tcg_gen_qemu_st_tl(hex_store_val32[slot_num],
                                hex_store_addr[slot_num],
-                               ctx->mem_idx, MO_TEUL);
+                               ctx->mem_idx, MO_TE | MO_UL);
             break;
         case 8:
             tcg_gen_qemu_st_i64(hex_store_val64[slot_num],
                                 hex_store_addr[slot_num],
-                                ctx->mem_idx, MO_TEUQ);
+                                ctx->mem_idx, MO_TE | MO_UQ);
             break;
         default:
             {
-- 
2.47.1


