Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326D8F46C6D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oen-0007Vb-Go; Mon, 06 Apr 2026 14:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oel-0007Te-Qy
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:39 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oei-0002QJ-5X
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:39 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c76d797b180so1896357a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499994; x=1776104794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxrRBSz7YKINRDuLnlyIQ5KppjL0ah1Oh+mR6eOnL4k=;
 b=Ss1rUbC6kAMOKx6wdT89CeXr1jYLnFZIX1mTGOMn34YeE5Ui2noARdVCl7Wxzpr3bv
 /C0H7RZyVZ2UxZuIQW7V9CtjwDNqoIhb4rXlBZ4bV4uOgn8nkOwWgaKK2rXk9AGE/i7h
 yeNcEOlKUnSoe7c1z5YupPQ9IvBzLIerVgX4na45ToGxJRTUkD8ko5RWuVADgPJfy/od
 T3b3j5eSBkhN9MnuqtCjf3LPsg0Y9Xb/zJJciC5rb9VDG+gAl/eOxxbWyL6Ekl3OnQCJ
 lX6Mb4UAFPfu3+bzMB1NCZlxnYJkShUc5GFfDZCmJ/fX6N+kDAzC/3jYYYcEhdplx2rb
 5uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499994; x=1776104794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VxrRBSz7YKINRDuLnlyIQ5KppjL0ah1Oh+mR6eOnL4k=;
 b=TePhXQ9kt/phIhR5nPMtoJ66UkAW5PPRu2hUSB0JZB/4SVveDaqqzVUIG+IjKLwUjL
 LlkFFxCknwjlHwGtiRAQClofhDgn0ZABQ5rgZbspMbE2rQ2hckyrWfM1+MyPMSOCDL9U
 Z5SE3j7Xl+U8GimI74SP4sCfjkMT2SCzNYQ27DUqOjHwu2f7lENf09ioNYbmQRl7EYv/
 2GPlw5HYsXMHxNIXnwHFjN0bjkbRFDZ8UAhuZ3HxhXFMBxiwNTQnegQlso2hakyaAsfc
 6PYc7TaUVNqdHcDhgSuNBJQs6d6wHjrV/SvNnZ/nIznSMxaQuoNFzl2ZWGo6i8xa2CsB
 SIcA==
X-Gm-Message-State: AOJu0YxnCQaCqNexEfkv3YPDxgsasXKB6Xh+t+hU2VhPi2SdT1qnD8rz
 ulc0n5bDU8Nc261P3sLVgjJQc4ekfd9UIrBFFJpx4sd7twttJkccT8wXraTw9FN0mH13dah+UyO
 hff1dadCznA==
X-Gm-Gg: AeBDieupqWyAvUjw6DPG3IBZHjboWcVT0dGOoQgh/GZw0VrBRZAwI2TZSX0W9v7zBFG
 EQgZNakRmxIctP3gdnqe7Oh8uNqJOOYoNgSpX6J4oL6tAQMtz9SUauNf8gXKgHs0WVoOPxA8JQD
 1MPgoP4OTIEJ6CPAkO4hv5IpyH5X2/Gd6SA8wk/M0wgY9lLJQAWv6qUTWXRXxwk6Jy+8QvN4Fw8
 bB8cWI3gxfbAD83jtcGVawyg+i+3DR4t9RwOuwdN8kfFKjKNaBOV89TxBK9gNS8Vg7w16+c2VX2
 q7s/CDetYWFeobt4//uR5yWKAPRUg7HrWTAq07N1WXUH6Rx4tlq0f4Wf2FcbeImKswBuhV7XStJ
 /CNZJuVU0ISdOtNl4x6RekZBCtdke7QQ5w+5MkMyUeKW9vXdB7E7D2zIUCHGBJnqfNT3W9zXfiJ
 viFL+G6fvJmmKrpaLjvbdDxobrR3cqzLQyXu12f0vGAyIKTWE5zqwnIqjk2NGTMUHLGgFQkKmPz
 YqH
X-Received: by 2002:a05:6a20:e291:b0:39f:5839:af09 with SMTP id
 adf61e73a8af0-39f5839cf5dmr8969096637.10.1775499994364; 
 Mon, 06 Apr 2026 11:26:34 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 15/20] target/arm/tcg/translate-a64.c: use
 translator_ldl_end instead of arm_ldl_code
Date: Mon,  6 Apr 2026 11:26:04 -0700
Message-ID: <20260406182609.193886-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

Allows to reduce scope of target/arm/tcg/arm_ldst.h to aarch32 only.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate-a64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 35ad7530c4b..ebab9f36f08 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -25,7 +25,6 @@
 #include "translate-a64.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
-#include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 
@@ -10800,7 +10799,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     if (pc & 3) {
         /*
          * PC alignment fault.  This has priority over the instruction abort
-         * that we would receive from a translation fault via arm_ldl_code.
+         * that we would receive from a translation fault via translator_ldl_end.
          * This should only be possible after an indirect branch, at the
          * start of the TB.
          */
@@ -10812,7 +10811,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     s->pc_curr = pc;
-    insn = arm_ldl_code(env, &s->base, pc, s->sctlr_b);
+    insn = translator_ldl_end(env, &s->base, pc, MO_LE);
     s->insn = insn;
     s->base.pc_next = pc + 4;
 
-- 
2.47.3


