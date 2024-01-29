Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C23C47DDF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadR-0005yl-Hz; Mon, 29 Jan 2024 18:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadJ-0005vX-M4
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:42 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadH-0008O3-Rs
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:41 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ddc5faeb7fso2586105b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569297; x=1707174097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8stgI+xO0LshRlV+dbOXjfDk9OWAAP8Iuj6nGWfVSvI=;
 b=iDnS4hClWK/DxvqZ9MMgNP6ExE3IpFdVbNi+JPAXdyK08gWF8TEqlH35qJqYy+nvHZ
 zRWG+xKYzRWrJsKFjKRlpCOOJMpAYEdG9gJ398/Ra1PablQT4A3qDSvjfDw6dQ58C/Zv
 YXfuGsKM2ZyXMJvLZTbsAjzJTqwYE7c7SQRsBZdD/8AMS/Rajlst/HBtr+v6khySf+Aq
 Q2Qr6Iu+DJr67otHW1ET96jZ53Nk3UvyndJk7FYtdpJGDU5M5H5+AyHq+HthPnmmgCBJ
 KJy0pdOfZwWmauc7nIQRqMXIPovuc7bKfMzOt7bWIvfVvpzLNa40CGaNCspPnbl6xCle
 1sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569297; x=1707174097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8stgI+xO0LshRlV+dbOXjfDk9OWAAP8Iuj6nGWfVSvI=;
 b=f/xh5e0INHpwavyztFy9uobO85vx5tjklXGeHxCPwzsVGrmd9kqIuqd2EZGtn3fwU2
 o8kvfL/aDpZyyZ8rGW2A1KxWGS0XLK8iWXZmBrDf5HOMOQfSZTi9aIpU5tO/Bp7EUnEM
 vBD7wMC28fb81vH2HHLtnUPi1WqDYuBp80vx3lwtgyd8GP14vLsDwOR4Wqdp57FXDP+E
 qF67gNzZ8/eNaBFo5CSpycnFnjRY+roruuluIiamFPXPOYa0L5qFvqXnBJXZHVCnnM6L
 Za0/b3oNVmUJy43XHZ9vmgEQtUTL+jIG7A78Y71SvSC2ZqAPFvlL218X82iJMZHDuTZB
 9xiA==
X-Gm-Message-State: AOJu0Yz7kqQ+T8wHOIA9/PUIRuuRQ+JJBmEyNGTp9cgVHUvleO1xLEK7
 MU3DHHbyrF/cxxNL58d0qcV9yRWyLn6IQp6JunsyQ1YY15BlM3pyg0XSObAuP0vyNDQWneAYm60
 BKWE=
X-Google-Smtp-Source: AGHT+IGgMFErPY/vdQjdjE2ZD7eumBf+/6RgbeeCKTCcjWSpd5sC0qlJeMBhOErl3KvnRrYT1BzRYg==
X-Received: by 2002:a05:6a00:4e58:b0:6d9:c201:66f0 with SMTP id
 gu24-20020a056a004e5800b006d9c20166f0mr4561881pfb.27.1706569297431; 
 Mon, 29 Jan 2024 15:01:37 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 05/31] include/exec: Use vaddr in DisasContextBase for virtual
 addresses
Date: Tue, 30 Jan 2024 09:00:55 +1000
Message-Id: <20240129230121.8091-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

Updates target/ QEMU_LOG macros to use VADDR_PRIx for printing updated
DisasContextBase fields.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-10-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h   |  6 +++---
 target/mips/tcg/translate.h |  3 ++-
 target/hexagon/translate.c  |  3 ++-
 target/m68k/translate.c     |  2 +-
 target/mips/tcg/translate.c | 12 ++++++------
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index b0412ea6b6..51624feb10 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -79,8 +79,8 @@ typedef enum DisasJumpType {
  */
 typedef struct DisasContextBase {
     TranslationBlock *tb;
-    target_ulong pc_first;
-    target_ulong pc_next;
+    vaddr pc_first;
+    vaddr pc_next;
     DisasJumpType is_jmp;
     int num_insns;
     int max_insns;
@@ -235,7 +235,7 @@ void translator_fake_ldb(uint8_t insn8, abi_ptr pc);
  * Translators can use this to enforce the rule that only single-insn
  * translation blocks are allowed to cross page boundaries.
  */
-static inline bool is_same_page(const DisasContextBase *db, target_ulong addr)
+static inline bool is_same_page(const DisasContextBase *db, vaddr addr)
 {
     return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) == 0;
 }
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index cffcfeab8c..93a78b8121 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -202,7 +202,8 @@ extern TCGv bcond;
     do {                                                                      \
         if (MIPS_DEBUG_DISAS) {                                               \
             qemu_log_mask(CPU_LOG_TB_IN_ASM,                                  \
-                          TARGET_FMT_lx ": %08x Invalid %s %03x %03x %03x\n", \
+                          "%016" VADDR_PRIx                                   \
+                          ": %08x Invalid %s %03x %03x %03x\n",               \
                           ctx->base.pc_next, ctx->opcode, op,                 \
                           ctx->opcode >> 26, ctx->opcode & 0x3F,              \
                           ((ctx->opcode >> 16) & 0x1F));                      \
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index a14211cf68..f163eefe97 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -234,7 +234,8 @@ static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
         g_assert(ctx->base.num_insns == 1);
     }
 
-    HEX_DEBUG_LOG("decode_packet: pc = 0x%x\n", ctx->base.pc_next);
+    HEX_DEBUG_LOG("decode_packet: pc = 0x%" VADDR_PRIx "\n",
+                  ctx->base.pc_next);
     HEX_DEBUG_LOG("    words = { ");
     for (int i = 0; i < nwords; i++) {
         HEX_DEBUG_LOG("0x%x, ", words[i]);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5ec88c5f0d..f886190f88 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1457,7 +1457,7 @@ DISAS_INSN(undef)
      * for the 680x0 series, as well as those that are implemented
      * but actually illegal for CPU32 or pre-68020.
      */
-    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x\n",
+    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %" VADDR_PRIx "\n",
                   insn, s->base.pc_next);
     gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
 }
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index e10232738c..12094cc1e7 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -4585,8 +4585,8 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc,
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x"
-                  TARGET_FMT_lx "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%016"
+                  VADDR_PRIx "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         goto out;
@@ -9061,8 +9061,8 @@ static void gen_compute_branch1_r6(DisasContext *ctx, uint32_t op,
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
-                  "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%016"
+                  VADDR_PRIx "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         return;
@@ -11274,8 +11274,8 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
-                  "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%016"
+                  VADDR_PRIx "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         return;
-- 
2.34.1


