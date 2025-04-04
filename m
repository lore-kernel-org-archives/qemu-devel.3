Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F197C369A3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pdu-0000n4-IU; Fri, 04 Apr 2025 18:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pde-0000hk-R0
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pda-0007yy-BV
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso12392935e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743806144; x=1744410944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zxXxxM0ZRSeCFO7PrYLPbTvn2QmgWNDPLEa5BJ8v9o=;
 b=WdR/0cOd9oSWOMfxPDsgYOS0ltXDlNJjncw7AtbyjbcU4iCP6CzW/pCPBy9rSzhkaP
 nlvf/VgIx9eth+kPZbgZ5Lj9lEELSdPAVI8moR/Btu43KumQiic8SzZqVdR8EorlVHz/
 5bWjLCElV+/YGFFnmp8pJo1qGjpUpuuuNqjvGdzJVajWtKLxpo7wcfhXELD6fDchrqJ3
 x/wgt1FQhRrxZ04AUBKJZ8glTs4kA+sgntYz+5DYoS81oZvtWG9aZswsgoku3C4V2+AH
 NP47ueRpkEfPBmsscaEXFS3M4aJ9e5Dv6YUbwvxejKi/DrOR32ItEjM1SN1ZxcDWV3ks
 B1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806144; x=1744410944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zxXxxM0ZRSeCFO7PrYLPbTvn2QmgWNDPLEa5BJ8v9o=;
 b=XdKHnUnX6QkA5hbkTTodpMCZYyTcd4R6DELHT7eFmwo/lBtcGwNUAeaReqGwPGtEmo
 qzFSlOBygRaTIKbYixmbk4PXzcvYcjebzksWUlZ9hDQnnfRpDd4XiP+mkO6rGf3qsUPY
 U0y4X6dDC3d4fRTVe7x8djziXSm81GaKHveGQfvgLhisaCeZF7f9rnYy6Z8inJnTKYd2
 R0hn59oyuOxvLF+o+XajC8zpzPo8qisOlnIcH0QCefUQmUJWwRCTKhwie+agRcEhYVxm
 eZhobxkF+QmPjFAuPkhIlBweoCT3mhltJ6XRI20kuPkxHB1EZ8Kv5Y7e3fWjo3TrEug3
 jykQ==
X-Gm-Message-State: AOJu0YwPsG4VVtuhHDfNaisWuhVta/4HiKaf43hEQtGgxA3WrhliNPQu
 /DT2P9DDHcI/kyc8C/rTjCOA05Wpqpm1LWY6w5wldrlsCr1ZqzDFmoio0NilHFpSvyIHoTLzAtB
 0
X-Gm-Gg: ASbGncv5W5IhTxilrF1R/PIBHeYUN1iwgyWe+eo7ZPS9ArP7z8kIQaC8ilFBgVKwpK1
 t1QOaOTRNLreHpSKWIprijZ9ELi+QJ3ujeAGIVft5hMVBOTO5++bgJbY6PaSst9Y9bzWSKz9uPq
 PmJSycQ1er8w76JSd2t5zIVZVBsiIZUNWFXvbVsTPZJXmYXeTGv6F+9Lhf9EXG5CRW0xF98y3Q6
 Gp2WNYwPScTyZt9NSTiSKEZlT+66mSUzbWLM+sOXlljVdCVyNFF4pBclEM3IE6GmNrH+pFVdjm9
 FwO3nruLZGgsigZAY9QPIuI8a6pEugLSeGWdjYazh8iE3oka3tCPKeeTYGK88u6jJJ/5uBotobq
 r1EcH03pWyX6qBUP4q7EMJZoo
X-Google-Smtp-Source: AGHT+IGrDPT0TJJGANZ9qgZjJprbaA1E9z/XbJrwznccsZLyeyK16WpBM0YN9mSxjKRNnmRPfnKasw==
X-Received: by 2002:a05:600c:510d:b0:43d:2230:303b with SMTP id
 5b1f17b1804b1-43ecf9c3e5emr36195755e9.20.1743806144161; 
 Fri, 04 Apr 2025 15:35:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7045sm5443114f8f.39.2025.04.04.15.35.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 15:35:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 4/9] target/arm/mte: Include missing headers for
 GETPC()
Date: Sat,  5 Apr 2025 00:35:16 +0200
Message-ID: <20250404223521.38781-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404223521.38781-1-philmd@linaro.org>
References: <20250404223521.38781-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Some headers are indirectly pulled in. Make their inclusion
explicit, otherwise next commit triggers:

  target/arm/tcg/mte_helper.c:188:26: error: call to undeclared function 'GETPC' [-Wimplicit-function-declaration]
    188 |     do_stg(env, ptr, xt, GETPC(), store_tag1);
        |                          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/mte_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 7dc5fb776b3..9dcdc1d91c1 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/exec-all.h"
-#include "exec/page-protection.h"
+#include "exec/target_page.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/cpu_loop.h"
 #include "user/page-protection.h"
@@ -33,6 +33,7 @@
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/getpc.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 #include "mte_helper.h"
-- 
2.47.1


