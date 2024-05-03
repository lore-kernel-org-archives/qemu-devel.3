Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1443BC25B10
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nDe-0000ny-MB; Fri, 03 May 2024 03:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDb-0000nY-Km
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDa-0001Fy-1m
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41b9dff6be8so48346885e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720828; x=1715325628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EARN2QjxHRUGZxuseUERnN42PxuL4o+f6Wcb9HZQWs=;
 b=DkBYiH557yNNBU1cotc8JpNpaREkjGKuyovslqu4gVAOZLLVc4sXZSnA46nPUYBGGF
 4R5FnnwwhR51DjYORFyXOciN43ktEC5dw2DNcxZYSct9tWTar8QJ6vmaInD4mfdxGbqU
 dR13LAykaXvpQd6yhC67bd9XZRYGPiO2jXVZwVkKGERbokV/tbTai+JBIV3cnEeiNid3
 dwE2jmU4fjSXGG0/s+E7aPgDCcUin10hAOz6Q8LBDGYFo5I/9D2S6XRtbb4P88bToJPT
 Lzdwm5/vXvxD/0+vXlv9NOVoZPEmLHjXsBdCAZb6RTXjyrKCSMiIKSuOx70v82cNuGiN
 pE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720828; x=1715325628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EARN2QjxHRUGZxuseUERnN42PxuL4o+f6Wcb9HZQWs=;
 b=dNVo81QxGIXD8I03FObKCmWTUlarLNmU1t1t8mZd0/7D8j2YwEsHpUUfq7gxcdy8L2
 1NTQ8ZZ3cTZc1BgGcz72PEWy5iU5Rb8N8JSPk25JQss1aJY7+wCEMJJX7IqZ3g6to4JV
 ISV/MvpzlAEDnY0HQMXb5GbyJFPc4L+pjv6YNp4c0bG2AqnNTqbrL4WkRzqRfMrhPXLZ
 hn0I3W+88YtEQcO0nbEIE3cENYLYK8zJrY0RuIjjSKFT4LPOVli0Tr743MEewVsptE5O
 qIN4oasGJWNiJdzFftrrXPosCRg8L+/jJT9Ui9m4nJV3yWOH5R1B3CD3P+ydG6cCFkdk
 qhUw==
X-Gm-Message-State: AOJu0YztDfOp74P7dtKLTdzQzgacl8A4RAXjqc66j66/OmZon6m7KA5l
 qlMCFUiepGYIbtmsnVVWzO6BncvGnIFgdLFeDvPLv/2wkGHxq5f1XJGBjDN3WRNuATk1HFpz8s0
 X
X-Google-Smtp-Source: AGHT+IFzLqFgruACRlcbDgcsiCs1HBQ1o2MXbo9y9xLlQcvYxrbyTRVociy5pDtUOjIDzGGeAMGJTw==
X-Received: by 2002:a05:600c:35c8:b0:41e:1bc1:36de with SMTP id
 r8-20020a05600c35c800b0041e1bc136demr764642wmq.26.1714720828030; 
 Fri, 03 May 2024 00:20:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 bd13-20020a05600c1f0d00b0041c012ca327sm4557609wmb.45.2024.05.03.00.20.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 00:20:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/9] target/alpha: Hoist branch shift to initial decode
Date: Fri,  3 May 2024 09:20:06 +0200
Message-ID: <20240503072014.24751-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503072014.24751-1-philmd@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index a97cd54f0c..52c2e6248b 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -432,7 +432,7 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
 
 static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + (disp << 2);
+    uint64_t dest = ctx->base.pc_next + disp;
 
     if (ra != 31) {
         tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
@@ -455,7 +455,7 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
                                         TCGv cmp, uint64_t imm, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + (disp << 2);
+    uint64_t dest = ctx->base.pc_next + disp;
     TCGLabel *lab_true = gen_new_label();
 
     if (use_goto_tb(ctx, dest)) {
@@ -1382,7 +1382,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     real_islit = islit = extract32(insn, 12, 1);
     lit = extract32(insn, 13, 8);
 
-    disp21 = sextract32(insn, 0, 21);
+    disp21 = sextract32(insn, 0, 21) * 4;
     disp16 = sextract32(insn, 0, 16);
     disp12 = sextract32(insn, 0, 12);
 
-- 
2.41.0


