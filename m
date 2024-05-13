Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE06C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPH-0002pY-QT; Mon, 13 May 2024 03:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP9-0002lS-LD
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:27 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP7-0001KG-4i
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:27 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e1fa824504so53159741fa.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586443; x=1716191243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zJVPddiwqndhAfsv4bxEk5QwYGlyRAHKsQYLRbwnmM=;
 b=OoCip7xlwrYZrjYYUre61Koe9afdh0/69uJcTg0Bfii5PwyjvY9fYjuuoWaPSqDGxR
 m4vd9X1ol1kXBZHasglYVEqJCoZgWB8VgsarQaJ4Pkn7jRXdq6y5rrsVzvrSfh4y6BcH
 Zu7VR+4q0mg2JGmKIqunk7OgiWcGk7gvgQxK1Zzk1AWkKNIoQPXQZqDhgSawv306c/G5
 Ot3MKaVvYOdxyTbpAyFJL53Wwon26+16mcKhyMhOanG0NA3zONnXeLS4ZGulrhWWgwn7
 sRPvbh+BzifB3gh2CJ1VR5BniPnSBYws9z3Ams5lbrovRbNmIIiT3PMPBSrawq1KxVol
 HuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586443; x=1716191243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zJVPddiwqndhAfsv4bxEk5QwYGlyRAHKsQYLRbwnmM=;
 b=tGVRLh2CY74y4zi3OBua5CMHZ8+ruITtXwQhWccMuzKr7Dd6WHVpqaxfsxPsZxgdSn
 lLuJTWDqLxlE4gVKXB0O2u+Y4kXWXDWme74cnATyw+p0hiaYu+DCUjN6SJwhBW9/e6Si
 KwZAS+RhuXvuUhT8QJexJLqvDXxSOyhKtnPOr0M/7GX36bxqCMhlzfu2C2jRszLmkpE/
 KdXGkImNb1xS4tebspR4dIqU/CgydJeywvTjDcicinyEq3135fP+zKYEQPkpYjafwncC
 MTO6OuNoDti7XyMYfA0klRUr0PFPn7/augwTOkZCbf98+VmfVuzcqYIzvY/1pekLd3I3
 KexA==
X-Gm-Message-State: AOJu0YxfG5gRPH/EJB+RkqL4I1yaocRNQGxlYAmRjrLgvjX12Nw/9/CB
 stOcUm3VARq3jSZySxKYGm3fADPlCMjqmpZHpmqsoOx6p6o0gxtRy0QizZ9rVgQCm+XE9P3jiDt
 72dU=
X-Google-Smtp-Source: AGHT+IGxg8xzNZEDiGmSiZyAEAu6vEBI7aixr2Q8ixm0s0IRbtqU1aKbM9cyB4KdJmlhFpuhzyuQdw==
X-Received: by 2002:a05:651c:1a21:b0:2e3:3eaa:ac92 with SMTP id
 38308e7fff4ca-2e5205e6e08mr68402721fa.53.1715586443604; 
 Mon, 13 May 2024 00:47:23 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 06/45] target/hppa: Use CF_BP_PAGE instead of
 cpu_breakpoint_test
Date: Mon, 13 May 2024 09:46:38 +0200
Message-Id: <20240513074717.130949-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22d.google.com
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

The generic tcg driver will have already checked for breakpoints.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 140dfb747a..d272be0e6e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -674,8 +674,9 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t bofs, uint64_t nofs)
    executing a TB that merely branches to the next TB.  */
 static bool use_nullify_skip(DisasContext *ctx)
 {
-    return (((ctx->iaoq_b ^ ctx->iaoq_f) & TARGET_PAGE_MASK) == 0
-            && !cpu_breakpoint_test(ctx->cs, ctx->iaoq_b, BP_ANY));
+    return (!(tb_cflags(ctx->base.tb) & CF_BP_PAGE)
+            && ctx->iaoq_b != -1
+            && is_same_page(&ctx->base, ctx->iaoq_b));
 }
 
 static void gen_goto_tb(DisasContext *ctx, int which,
-- 
2.34.1


