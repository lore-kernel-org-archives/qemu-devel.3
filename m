Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3586CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KzB-00004t-5Z; Fri, 25 Apr 2025 11:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kz4-0008Va-IE
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:00 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kyy-0003V2-LU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:28:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso1550846f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594930; x=1746199730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXDlaJ/y5+AB626PahfOyufXZGYE0bZzreOJUWUIl6s=;
 b=qp8w+IbY9RjzyqHX31q4X+Oh3siDOPrEmZwE7x8u5eIR2f2KMlUZbZ5pPo9vkVKUec
 KPnwIxINBpAcW37jQGeE42wdYYUWcKRWZPsYhmQpGYflVse27PKWwcWWxUVLuLyWVFC4
 E0WIYFuGLM+n3dWr/eBCJn+z+VCVabvYzHDRWI/pX45qzWxa0dWN0xGilsfgRpRctHLV
 n4bEuemcmU8ZMmenCloVC/TM76d1ENfWZjhJuu+ZAlunT8eLtO0XBV3iA/0QWDG2+9Ik
 b01+UBpUhA2vtMyOjizFNofwL4Z1qtl4aswZ7sRHECA6qZK8cpTZzLi7D67QDWycChfv
 VLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594930; x=1746199730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXDlaJ/y5+AB626PahfOyufXZGYE0bZzreOJUWUIl6s=;
 b=fadW8ijGu5k/HCsWiwOcD+4sRkPvoIjvgqqB/OSGc+sw43zYX5HCpNdMfzDBRQHlNn
 4Wv3wJgfr0WGfEaCy/ZUmYoENRZ/moF3f+5EDE9MO5WWdGfw54g3BvNUAwpL2hqwMsqD
 5x6nV8GcGDAgPTqVc8B9eCdV8Q44iiQ0pEEvHaEQ1zxVr0ENsyk0T0dzQmEXfDUnuL20
 CjoZh133JXvYyTboc1YBHGovTMejSwGcgF47hnmyJvakcGcnjzzgFdhDGNMJv6NbMale
 MvTaCgA5yMqz86J3dVq3j+Zkb39f9l44KAv9CHBn0BDtM+aEHAz18VxARoP0PKfzS6Ss
 TvNw==
X-Gm-Message-State: AOJu0Yxvq09T4vcRx0MFASU8m/2ujPmk8hZ3aAuN8lkIBT+71xEQHwZn
 WYVT1/OTy4VNIvREz3rsnY26yQLrCVC6STX1bE3a4NNit4DeRQ/sw6gWYN2Ij/Ag9Ui2A7L/Y+2
 m
X-Gm-Gg: ASbGncv90oPhR1GAnsj/t4iYjI+hUPenlmQoIYo2+wNrWlIMSJfMiq0YeZvOKdGAddl
 TgZHbhvzFofLMIDEYmkXoNi4GvtqpKbd7QIhn5aLDx2pHQ+0TM9dwDSqfz63GJjWCa2oMmHcUGb
 hNbZyTsMoYpTi38m32/xjO3wgw9bkoCXTDgTacXXKyedJNx9AIZtHRgur1rNnRftT5eGFZud8kO
 qCckYj7Jhv6wXdGWqYgbzk42Kb1/VKmMgs8OG5X8IOYU8Voe1awTGV0ISu0lAlPVEH5w2FYAbRa
 tNnd+uhaOaep8jSBSIqq9KCwI/lpVxAPXnTov6D5KfZGSXs0uYV1CxFhUxLEPr415P1fys6junL
 uEFHr+/rPqq6R+iQ=
X-Google-Smtp-Source: AGHT+IGuM0knQkVw8XzzGVZpgt8rIu9NYRCmKmWX9YrYibqlEmHNPAc778F70b9jaO3cOFrzAz1J8g==
X-Received: by 2002:a5d:5f45:0:b0:391:b93:c971 with SMTP id
 ffacd0b85a97d-3a06d6ccbf1mr5994837f8f.20.1745594929848; 
 Fri, 25 Apr 2025 08:28:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5cffasm2673833f8f.96.2025.04.25.08.28.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:28:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 01/58] target/hexagon: Explode MO_TExx -> MO_TE | MO_xx
Date: Fri, 25 Apr 2025 17:27:45 +0200
Message-ID: <20250425152843.69638-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20250312103238.99981-2-philmd@linaro.org>
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
index dd26801e647..0109f31e19f 100644
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


