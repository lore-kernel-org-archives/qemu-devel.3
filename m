Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C32CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN4L0-00011s-0r; Wed, 13 May 2026 03:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Kx-0000zO-EV
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:48:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Kv-0003dq-Sb
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:48:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso3734940f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778658536; x=1779263336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICzC7UGJjqGK/86IacnrTrurhebXutr2Ptur7vjdEP4=;
 b=sXWgrFSEKdoNz0a0ZCqLbiG8rF7uEzfUhxrnbsLdE4MuIJhuMihuyFPPffwss1NiLr
 Db8bJenmvQdfNDKCd37vCpFjpab2NNKgFLmPZSqxsmk2reeO5WxR98co6iqGsEuNj0mp
 kZQp5Di7+hXzWtMis5tpg6C5iqOjwqq8qvu4dai0S7+jG9m4PS4S512PFWxUTLUHcdxR
 nz26FPtTYibeg1Mvbi3Y6r2EQqfZWHQMwSHc4gLPkVy6qRiSAqAS/fr75gYdqycbjqWr
 /1UCvCsuV7gKL5MU5X6jNs6YaqLzdnbWeNsbxRcVgUkhcrXeVQBjahW7auD/R6ffrSeC
 +QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778658536; x=1779263336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ICzC7UGJjqGK/86IacnrTrurhebXutr2Ptur7vjdEP4=;
 b=pcjOoclZCH1Iw0JCQsdU8TzVbdKHSJ0zlX92dB6qN3/dKO/350y/0mVG89a7fAUdKS
 NxEMHnoPTnUq8Uup9QXDhcRV3v4CARH3auQHXFWgmoVoTV2pDlEAUIp1ieJiDzbvW/N/
 ISFU7g7HNV/QuRmVTY6zFNQV7Czz80+gQj/qk8hGYJP73r5f0fB0kfMLqVAimSk5sJpP
 SY9eC4BP4HDoV2MivKvmvzDjX44SqsOzoCBFFdHLavZYwT/3HnfFt4n9OmySYZekzgCt
 5fzHqQd9/gNn6CZAIGnmwKzl5/2zSDUmrPIvw4glc3JLmfphkxbaGNZTUrTt/EMHRwYG
 Unag==
X-Gm-Message-State: AOJu0YxSWoTA7rr/4Jo41QZVNtVFjjaxvDYsbTshMCIhx1i0KI6IyeP5
 h2xFVP9Sv9jAR78pSgpCPfvakqY4wzwWet2y63QYTmJ4lkL2VAiDiD2v2T9ucFJpThIxhZMUAo3
 Qz/8dDTc=
X-Gm-Gg: Acq92OHsWhKtfFWmEA7k/JfptJXV4Qid9mYWWeRRTBaY9xTx0ENDa/W1ctJJbs3PVO/
 SijW0bsKRcwMJ5urGf4Dw7j7LNKkh3IkZwel8rpFvX10TszJAVOsjA3BBW3YNSJvdAVRsRhdEmQ
 y2JClxMn6n/zWepAO4gk7Jia0zjNZhj8w9vrX1/0mP20HTcgRcsLNtfcoBl1R/O+2XgfsO65I5g
 aC3R8UdtnyTOPj9uiT56H2kSp01lQcZremlpw5jxf8USqT4yaI3GpkiZ2bxXUwLB3cJPfHJpk5l
 THme780BEjVlzjA7D0RvDhT6IWBjlQgxYYFE7WesGUD7w9nRwcPhvgypOfoXtxQaBfG2t0X/jd2
 Dhh4gs5YnfFTabTP28un7EdkgAWfO8OA7lzAVajI41OxL4Y6D4+TW1veBWN5Gn40U1VQaghGFoz
 W51iQrXaWW0EVhE3qfG1NwARmxXyRnu+OXTuT6KmO2V7QhSzvfoRFFCDevkKzT9dbXDvWtwoegg
 l+bVCe0tPg=
X-Received: by 2002:a05:6000:2203:b0:44a:aa3c:5927 with SMTP id
 ffacd0b85a97d-45c5a782750mr3180124f8f.29.1778658536090; 
 Wed, 13 May 2026 00:48:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491f8d4c3sm38470516f8f.34.2026.05.13.00.48.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 May 2026 00:48:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/alpha: Inline UNALIGN() macro
Date: Wed, 13 May 2026 09:48:39 +0200
Message-ID: <20260513074840.11398-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513074840.11398-1-philmd@linaro.org>
References: <20260513074840.11398-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Directly access DisasContext::mo_align in place.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 120ef5f8ab5..d0c18e38765 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -70,12 +70,6 @@ struct DisasContext {
     TCGv_i64 sink;
 };
 
-#ifdef CONFIG_USER_ONLY
-#define UNALIGN(C)  (C)->mo_align
-#else
-#define UNALIGN(C)  (C)->mo_align
-#endif
-
 /* Target-specific return values from translate_one, indicating the
    state of the TB.  Note that DISAS_NEXT indicates that we are not
    exiting the TB.  */
@@ -285,27 +279,27 @@ static inline DisasJumpType gen_invalid(DisasContext *ctx)
 static void gen_ldf(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 addr)
 {
     TCGv_i32 tmp32 = tcg_temp_new_i32();
-    tcg_gen_qemu_ld_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | UNALIGN(ctx));
+    tcg_gen_qemu_ld_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | ctx->mo_align);
     gen_helper_memory_to_f(dest, tmp32);
 }
 
 static void gen_ldg(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 addr)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_LEUQ | UNALIGN(ctx));
+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_LEUQ | ctx->mo_align);
     gen_helper_memory_to_g(dest, tmp);
 }
 
 static void gen_lds(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 addr)
 {
     TCGv_i32 tmp32 = tcg_temp_new_i32();
-    tcg_gen_qemu_ld_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | UNALIGN(ctx));
+    tcg_gen_qemu_ld_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | ctx->mo_align);
     gen_helper_memory_to_s(dest, tmp32);
 }
 
 static void gen_ldt(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 addr)
 {
-    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_LEUQ | UNALIGN(ctx));
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_LEUQ | ctx->mo_align);
 }
 
 static void gen_load_fp(DisasContext *ctx, int ra, int rb, int32_t disp16,
@@ -336,7 +330,7 @@ static void gen_load_int(DisasContext *ctx, int ra, int rb, int32_t disp16,
     if (clear) {
         tcg_gen_andi_i64(addr, addr, ~0x7);
     } else if (!locked) {
-        op |= UNALIGN(ctx);
+        op |= ctx->mo_align;
     }
 
     dest = ctx->ir[ra];
@@ -352,26 +346,26 @@ static void gen_stf(DisasContext *ctx, TCGv_i64 src, TCGv_i64 addr)
 {
     TCGv_i32 tmp32 = tcg_temp_new_i32();
     gen_helper_f_to_memory(tmp32, addr);
-    tcg_gen_qemu_st_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | UNALIGN(ctx));
+    tcg_gen_qemu_st_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | ctx->mo_align);
 }
 
 static void gen_stg(DisasContext *ctx, TCGv_i64 src, TCGv_i64 addr)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
     gen_helper_g_to_memory(tmp, src);
-    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_LEUQ | UNALIGN(ctx));
+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_LEUQ | ctx->mo_align);
 }
 
 static void gen_sts(DisasContext *ctx, TCGv_i64 src, TCGv_i64 addr)
 {
     TCGv_i32 tmp32 = tcg_temp_new_i32();
     gen_helper_s_to_memory(tmp32, src);
-    tcg_gen_qemu_st_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | UNALIGN(ctx));
+    tcg_gen_qemu_st_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | ctx->mo_align);
 }
 
 static void gen_stt(DisasContext *ctx, TCGv_i64 src, TCGv_i64 addr)
 {
-    tcg_gen_qemu_st_i64(src, addr, ctx->mem_idx, MO_LEUQ | UNALIGN(ctx));
+    tcg_gen_qemu_st_i64(src, addr, ctx->mem_idx, MO_LEUQ | ctx->mo_align);
 }
 
 static void gen_store_fp(DisasContext *ctx, int ra, int rb, int32_t disp16,
@@ -392,7 +386,7 @@ static void gen_store_int(DisasContext *ctx, int ra, int rb, int32_t disp16,
     if (clear) {
         tcg_gen_andi_i64(addr, addr, ~0x7);
     } else {
-        op |= UNALIGN(ctx);
+        op |= ctx->mo_align;
     }
 
     src = load_gpr(ctx, ra);
-- 
2.53.0


