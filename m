Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EACFC19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5s-000616-EI; Wed, 24 Apr 2024 19:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5m-0005yP-Qh
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:59 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5k-0003hP-6C
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:58 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2a484f772e2so329197a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001515; x=1714606315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09Km9Y28Pm2ntP55oWjWMOkK8jfRjLsDy4w+uTrJZck=;
 b=Nj3rmjJufk6gFD0JI6eVp1+VQDKetWtK204aqBnC8IhNxjIIYzwFMydjvG4LJq14QR
 4xRtv6kYVHNgOU/zQIz8exQtQGrJTFvri7W70weKQE9o0Ph+46jD7h7J+sbUFrR05oJ6
 Kdf9LaiOMqXd/l1ZN37jQNFRT/QYX5I5XENNjwH9EYF02xJR/oWsNLyXJt8bq8VLvyf4
 7g6myyYopgoLxGosPh8l9MzZGbV5rnq0Wgm/X/JDlmdyoXDYIo9xot8PjIKsGPI2RXIJ
 RrZ+Sl93px6hKRfoJwS3TK4PlbIUgG3K1ia4OX0G0hVpS0l+lU0aK7HodkuHtBC7LUo4
 o9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001515; x=1714606315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09Km9Y28Pm2ntP55oWjWMOkK8jfRjLsDy4w+uTrJZck=;
 b=bsNIuD2iLOof9V1niEttSyyC3k/mUOHm3OjG3A9FTpCwlFlJ8w2Z4K3t4a+/oZbX1Z
 +KI+cJaMHx9an2vWpLD6+ACTiqL4jJr+v4Hrab2eZQm2+ykLDP9OBIpn+791ie7TApPn
 kK8pAeVd8A6cUHWHh9Cpy14ErWVcWAjlO60n0Ehp6ccY6k89z8QfION6EEbagTm1B75Y
 zDnwAH3PskBV5aOKo2OqQ97U9Sj4O/08N/WmuiWgLUwS6/Xt0ngGqnNsX/f2CG48QcyP
 gBrPui70w8MUNf+mVhvStdnXEYj2zf+YIWoE8D2xK62Gf5L6QlarkWLwdLY0Kvs43Zi0
 w6zw==
X-Gm-Message-State: AOJu0Yyc0aetosg9J7vR5aJBTCOoOCAJ39jAjRKi/dVUa98/U2TDycSs
 c4DIGkFjn99ileBbz/G7pq35mFPjBU0tsuWhuL8sEowbFy9uB5oelS5rTZpypNfIJOnNtnJnKU5
 A
X-Google-Smtp-Source: AGHT+IERRg4F3RRIC19qUfHIf5Y0SfaxC/V7IpYFE+KAcQ31LWUP3e+sPDcCjKx+IFwEplnnGCOL1Q==
X-Received: by 2002:a17:90b:3581:b0:2ad:c098:ebca with SMTP id
 mm1-20020a17090b358100b002adc098ebcamr3726782pjb.20.1714001514914; 
 Wed, 24 Apr 2024 16:31:54 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 25/33] target/i386: Use translator_ldub for everything
Date: Wed, 24 Apr 2024 16:31:23 -0700
Message-Id: <20240424233131.988727-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 target/i386/tcg/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 6658adc4bc..6f04a77eed 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -23,7 +23,6 @@
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
-#include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "fpu/softfloat.h"
 
@@ -2138,9 +2137,8 @@ static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
          * This can happen even if the operand is only one byte long!
          */
         if (((s->pc - 1) ^ (pc - 1)) & TARGET_PAGE_MASK) {
-            volatile uint8_t unused =
-                cpu_ldub_code(env, (s->pc - 1) & TARGET_PAGE_MASK);
-            (void) unused;
+            (void)translator_ldub(env, &s->base,
+                                  (s->pc - 1) & TARGET_PAGE_MASK);
         }
         siglongjmp(s->jmpbuf, 1);
     }
@@ -2718,7 +2716,7 @@ static void gen_unknown_opcode(CPUX86State *env, DisasContext *s)
 
             fprintf(logfile, "ILLOPC: " TARGET_FMT_lx ":", pc);
             for (; pc < end; ++pc) {
-                fprintf(logfile, " %02x", cpu_ldub_code(env, pc));
+                fprintf(logfile, " %02x", translator_ldub(env, &s->base, pc));
             }
             fprintf(logfile, "\n");
             qemu_log_unlock(logfile);
-- 
2.34.1


