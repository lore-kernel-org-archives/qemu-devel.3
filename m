Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4F8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rw-0004Vy-0W; Wed, 15 May 2024 03:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rq-0004Gj-FA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rk-0001d8-Jl
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42011507a4eso25417035e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759586; x=1716364386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ku4i14FBhF0AsxG1wJUIaWCeb9p5uUrtgrDPrlUkN+c=;
 b=zPnvyqIzRU+0khccIslBlZteWGSRtXlbDfusDw7cBW+AWJn33DAdlGBmcIM9cAD2hP
 rjnQNfY6qMeqShcbYCMa2qiA2kMgahCWmt2tfkLNcET/oJqU+rusBs6LvBGGs/Xy0XhM
 ig46lqb1omcgfxII39ZkLa9sk47H73AR3mLQ6QSxO4HkXU+S9GCPsBM9b5H5nVVeMhxS
 PgBNTgvuhX335eXlh+sa6jZWiMkZ3AnzZoUjNJOzqEJXgp0GjlKwuaKoszbkjfWvRe37
 GooNAkJScv2D0lZygkEY+QOJ/mJlCCp38z4vhSzCxdJXDZcaOMlf8SYRjdztlPXLbRk8
 3geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759586; x=1716364386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ku4i14FBhF0AsxG1wJUIaWCeb9p5uUrtgrDPrlUkN+c=;
 b=qBBqy14AS4wC/5fp5TsZqt2yffnmVIzUbChEp77xEQbX1te6BeikcQa4nQ+gekeMja
 NDnjCZEfASni6drlNYx9qksmRej/fyaP3C6ohQbW1rwPq4gITzDUVBMmEZKtPFf6H6iK
 t+G3bC2mxazr9fIVSC7jAi+EucSEK2KHNh+JlbBSjl2qFIjG3JXlKbrS1lh8Ag49VNa7
 FZbRf+RfCoFdbA51R6lwucFTt3QxRoiiSZTCjAHvILc1VLCsOAnp9bJPmYmWCBWfYpbo
 9Wx1ii1AJuEpidnoRjiikIl8idpLnR4Pk/G2OqcIHLCtfH6ravnJOJrGx29qnFgBTjHc
 Uh/A==
X-Gm-Message-State: AOJu0YyrSjU7dEM2GqdONST+PFw5FOeMrabldTywjO+qWwPAKE1D+1WD
 l4c2CbdkgsDmaSGC8f7tzY1doFQ8A1TfmNsLgO5Ie5Xni7kRxvZPuPh/8Pc34oEHAwFZ3hXTQYH
 aldk=
X-Google-Smtp-Source: AGHT+IE7Bb3zterA9QR8RBkRFovf3Cx3hT8E5GYmlAKrxCjMWHadLQV/V0ovDwt+gavKcmmOZEHilA==
X-Received: by 2002:a05:600c:3baa:b0:418:6138:6777 with SMTP id
 5b1f17b1804b1-41feac5a42emr122834705e9.31.1715759586025; 
 Wed, 15 May 2024 00:53:06 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/34] target/avr: Use translator_lduw
Date: Wed, 15 May 2024 09:52:39 +0200
Message-Id: <20240515075247.68024-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 6df93d4c77..2d51892115 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -24,7 +24,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
-#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/log.h"
@@ -173,7 +172,7 @@ static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
 
 static uint16_t next_word(DisasContext *ctx)
 {
-    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
+    return translator_lduw(ctx->env, &ctx->base, ctx->npc++ * 2);
 }
 
 static int append_16(DisasContext *ctx, int x)
-- 
2.34.1


