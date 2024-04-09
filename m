Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B9FCD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGg-0000cc-K1; Tue, 09 Apr 2024 15:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGf-0000c7-GE
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:29 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGd-0004fM-W4
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e244c7cbf8so50588075ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691387; x=1713296187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFanGzrvK8VkKk4csReRv0GVjABsPRaur2/zSeJo0ZU=;
 b=aZM1ux2UJCV1OgPgSgP9Fy6HBJQbKnCxBVXqiuXG6s4ChKTxmqisZIkltudV5ApwZQ
 rVfKw9NBqiUT8ilZ6dFDSdEKk9ZtlGUHY8dSEnXpaIAF4lc1uXMZqbJO6B57PuGtVnYD
 TpQVYiWa0eO4vj0TnfYWseSQ5X/Sp4SOOJFm9+CAci1UyL4EvonhI0xCGFpYS6ccBnjp
 n/WI1j0I4/58AA4WZ9Us0SjvA6jN6FjqhkVYw7anoH/yXypITqXotKfU/CZzYDX1P8HB
 oAIq4vY1odvmu0RaqlO4RSRimkPMXFDIYmpTgdE+OR4Kn1aBORAY9Uoq0s+4xNX8E69Z
 H6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691387; x=1713296187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFanGzrvK8VkKk4csReRv0GVjABsPRaur2/zSeJo0ZU=;
 b=rxZoLQsHfy7zwbSreO67daRWvQcP2FvBlyMHAwNMLXnqfze3MZw2QAPr8yCvcrhumV
 0RIiHCIai2H7cBv/TLPhaHnd8zIy/R7doQo7jzZhzXbmatgZm82T38xXLPsi3bIycIJ5
 GBML2o5O9TMpspTPCNQuFES8BbU8Bax2q6XRQpQQiKVVjDjXMHNNBAD+F9eECUG6EExz
 mhcvH+DsLwCpBNxrDBkIA/aKvv5jLEL7TTjluNUwrOFrBeIlY/nb/O0wOzZ6u2hmEdyg
 DyVNm285dCpSajr2EGic1W7fo35wfEYe1oL4zGLgWWUhfetPYMh4XZGQlQ99Yiq9d15J
 bHVg==
X-Gm-Message-State: AOJu0YxIS+Asw7RovcWGRwDubRMcQOA/gmS+HKJrj3vRtCDzhJwWq/aG
 Q2Q7dwObqmq+DQDMVH/iPZenQ0HajBQ3hszQJ8OQfhQsRoBC14eDInOegToR/kNn/Vfwk/hdooR
 2
X-Google-Smtp-Source: AGHT+IEm6hqAUc9vq65tDBptyLAFU0dcujShlCQccSDdv7oUL+/nqDzNNWqluGj3MorH0Azdx2+16A==
X-Received: by 2002:a17:902:f392:b0:1e2:23b9:eb24 with SMTP id
 f18-20020a170902f39200b001e223b9eb24mr705753ple.33.1712691386735; 
 Tue, 09 Apr 2024 12:36:26 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 14/20] target/hppa: Use insn_start from DisasContextBase
Date: Tue,  9 Apr 2024 09:35:57 -1000
Message-Id: <20240409193603.1703216-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

To keep the multiple update check, replace insn_start
with insn_start_updated.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8a1a8bc3aa..42fa480950 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -44,7 +44,6 @@ typedef struct DisasCond {
 typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
-    TCGOp *insn_start;
 
     uint64_t iaoq_f;
     uint64_t iaoq_b;
@@ -62,6 +61,7 @@ typedef struct DisasContext {
     int privilege;
     bool psw_n_nonzero;
     bool is_pa20;
+    bool insn_start_updated;
 
 #ifdef CONFIG_USER_ONLY
     MemOp unalign;
@@ -300,9 +300,9 @@ void hppa_translate_init(void)
 
 static void set_insn_breg(DisasContext *ctx, int breg)
 {
-    assert(ctx->insn_start != NULL);
-    tcg_set_insn_start_param(ctx->insn_start, 2, breg);
-    ctx->insn_start = NULL;
+    assert(!ctx->insn_start_updated);
+    ctx->insn_start_updated = true;
+    tcg_set_insn_start_param(ctx->base.insn_start, 2, breg);
 }
 
 static DisasCond cond_make_f(void)
@@ -4694,7 +4694,7 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b, 0);
-    ctx->insn_start = tcg_last_op();
+    ctx->insn_start_updated = false;
 }
 
 static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1


