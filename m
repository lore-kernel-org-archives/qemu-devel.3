Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FB7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5t-000626-RE; Wed, 24 Apr 2024 19:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5m-0005yN-MJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:58 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5l-0003jO-2L
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:58 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so323890a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001516; x=1714606316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ku4i14FBhF0AsxG1wJUIaWCeb9p5uUrtgrDPrlUkN+c=;
 b=MbyRgM6yRb0P7/h670jKAdxRcsrE11V1QKkYS8PWYVWvvdWgArRGoUpoolF610aqhK
 oEvL3fHEyo+cWQskY1YscK2s6WL0L2ZfZpjjiLJCXZ3SQCwwyNi0mvVIQXrRCXx6fuaf
 yPbhYgc3DquhA6dRtw9hFgJ+1SLvMpk+DD0FS4OhLt8OXlUzPpvz4EV3ZJ1eztQAoF32
 xQZyRTrq/+DJetDZcfVETghqXF5CkHUc2rkOJtp560UepwBmEG52Q7c8Mnmx2kmzjlCM
 IGrZYGJzfaruFrDiru1gQ81A0TpZe78niaHL5oqYqA6TJgRqc6IIfzIdY/USLNslASM3
 QD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001516; x=1714606316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ku4i14FBhF0AsxG1wJUIaWCeb9p5uUrtgrDPrlUkN+c=;
 b=h6RCHFKbVn9Q+MCaRwADWEEE5Bs6/jVA8pSsg7W4tGTI3KtYYD0VkvbRAkB2iWab6n
 zZVgcbm69el5n1wDjK12id1JUm2iS5JYI84unykeljTe45cV5e3r7MkR6Ht9Fweq3r9I
 Ie5j+XwwP+xcxbgLJdFcJn88YD3ry00KIj9wu/Uilq9GC7Yp1hBP2ZrUAbThnTuZnCmF
 Dpv6TiW0c+qWK4D/6e98ZaszMxmnRSGaS4nZshcA0dLmGKSed7SXOVgGm2b+OGapJ8fa
 TdxkcrPmtPOOLXXz5095V6jnnGJ7oVHBYBlIfSOe/ecp2rFD18hP9u69rPACD9rkB7sO
 SdDA==
X-Gm-Message-State: AOJu0Yy+4zza1PoqtkGt18mNkaB6N/Fn1OAGashf80u1qgnvQ5EOIPhL
 h4n7sHRNYcKWOoQzi9TgI6HAYiNAGcFqQBbwR8UmHdDU6hSzdSFFLtBa79SVnB7BBCqkr8zRxSH
 l
X-Google-Smtp-Source: AGHT+IEwt7Z2Q1fbq8HZJep2FJTi89loiEaWAneJ7vXO/gMQSueG6rsJV9d49j7gaWStd3Mv9/rrGA==
X-Received: by 2002:a17:90a:4884:b0:2ac:24ed:c930 with SMTP id
 b4-20020a17090a488400b002ac24edc930mr3940866pjh.35.1714001515782; 
 Wed, 24 Apr 2024 16:31:55 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 26/33] target/avr: Use translator_lduw
Date: Wed, 24 Apr 2024 16:31:24 -0700
Message-Id: <20240424233131.988727-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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


