Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC81ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6x7M-0003TW-BR; Thu, 09 Oct 2025 16:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x7L-0003SJ-8C
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:20:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x7J-0007LP-Aq
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:20:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so14154815e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760041199; x=1760645999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQwRiMQlPXUBJScc/1n8fo7QZtEsIzXFcrqxQqdhbYA=;
 b=G/tmeFpb8sOgv1/A9Sjb7tMhR1PYlUQkKqwU3axGQKOalu/XfrdZjdhQZ44BqU+oUG
 /NkX2hiCXyAjfEPBwFC+GeqY4VkCLZPoJljAWjQoeNxFBjl75hh9kQRnP7x7+7tEy5te
 5hpztWd7vjhcZeK59AVPFT3tc/v0S7v93Jilt4xgd5o1eYjoD00F6BQIM4FzQxZZGZaX
 5Je4d55U0GvKXz6qgxnwjp12Z6R3SRZMlsRjTAwXN1TdQc7RSTm4skEGTPTvPgZbsAP6
 V86BjRzYg5F1hJWCPA+fHJJ329QPQDJipu4S/ZY6/vb33VegZvUMGlzRoTSvsEi365s/
 K4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760041199; x=1760645999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQwRiMQlPXUBJScc/1n8fo7QZtEsIzXFcrqxQqdhbYA=;
 b=oZlVakgI+qYS8io/rfDRr4MWj5ddgsMJlaP/hd4Q+yLGbnda8dFLZ4fnN9AR7wk2vG
 i+I0J6zFMHWtrtue1Hr1/DKzd8zX2dLoRVq1FwmX8nvUwDreX9wea3ywtCisYfuEGtMY
 Od32er/YpA+kO25nJ3nlnYuhhaTbVF4V9HeN4FYt2MW2qOJJGMHfo6rVYyfTjH3awqws
 Lat9e7KfckD1sHtoszAHtqsl6QDbG9skCQCVc3GGbss62lnRIyvuDnfYKiE7nX6P677b
 w0DgeHHrgZcG+KsQTKIejlTNCSMImyv59PZvnag+3dOPBzIdxvQ6vnE3x5yits3EAqRO
 rUOw==
X-Gm-Message-State: AOJu0YwZl4pyoILh+RJpip3Y8B52SJdXBxk8Ehd3jCie4SSsG0zwRq/u
 IHbffFPI5CjaEgNMiWP13BjB20aEg8hqt/l0asgNewTkWfdgLWwfsnMwRiZMbfwzckQNnVnpD1r
 2IZou4FMzpqfz
X-Gm-Gg: ASbGnctSgBLvuCxgNmmXgbgQcQrS5ZLop9foPKihsWsFzNCg9RZDh8Epv8SD+07ynbO
 tGXGkuZLkPRSUd3OMkPDmKPTLjzFxY42kHvSZTT7pJqfVZEMB3tfRYKPn7Ib06p+7BhamYeJQBm
 srcHfjANOxpTnK1nvMATrhvZ7Ang1EOTDIas/se2RklWmEjqpAOyQP/IK7XwLBIEBPmoMKlCuxY
 tHkfehomxZ2Vwp7OBU+k6MIExtw/2Bs/NCwm3kOo11tFiH0BsEj4Zau53NksyVZ7OoFmQQx/zuM
 2yxWPXNb8aQp4wXLwyORtUqlU4p/aFb6w1fCbxWxFCTtNrqpfq/3PBajTQFfYBuCs3AObUVclhY
 M36pTCCvxQK7nbVFd6eJQpMRO+GvfItitVCSnjaOuHUXSBvoVL6nS+Xj72f2oyM3L8OZOFe5Y0N
 gZUC5HY3d528v2P5FUAjB40vBw
X-Google-Smtp-Source: AGHT+IFXKsu5pzLfCBmRSubmIm43hu1B7WO54z+puUtt0sRU7uyo3T+H6ASZo6vvngwXsrdskTfi6A==
X-Received: by 2002:a05:600d:41f3:b0:45b:7be1:be1f with SMTP id
 5b1f17b1804b1-46fa9b092ddmr59467665e9.32.1760041199211; 
 Thu, 09 Oct 2025 13:19:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4982b30sm10937515e9.6.2025.10.09.13.19.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 13:19:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] target/loongarch: Remove target_ulong use in gen_goto_tb()
Date: Thu,  9 Oct 2025 22:19:44 +0200
Message-ID: <20251009201947.34643-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009201947.34643-1-philmd@linaro.org>
References: <20251009201947.34643-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 53a0b4c3ce9..e30b64c0e05 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -99,7 +99,7 @@ void generate_exception(DisasContext *ctx, int excp)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
+static inline void gen_goto_tb(DisasContext *ctx, int n, vaddr dest)
 {
     if (ctx->va32) {
         dest = (uint32_t) dest;
-- 
2.51.0


