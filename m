Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927E7E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjF-0005GG-5w; Fri, 20 Dec 2024 11:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfif-00034G-7J
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfid-0008Ev-Gk
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361d5dcf5bso22659445e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711554; x=1735316354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WC2nhe/8nK3+EuJg0FTm4kyJ3k3b7kFJ3rcOFSHjWok=;
 b=N1iFCn4apMq0lUSOeOtPss20x5fXw1cluqUsnCw2jMEtNamUlHZ/R6vsh25B79w+z6
 2t0xRzjhEN+gkEU93c8vs5fvK/80Q8Qp5EqNgJjCiRv3nq9SbdEjHvSbDuMsAV/dGSFz
 7XOJfvMBvOxALzyqfjhW3HKaiIjoMyHZ9kbmHjMAMVsZD05myhoX9N+WQOrtFCIF7d+2
 HcvLdJZpYqUC5TSyzam11g9wvRx8YsnMcfoc5D6w7nT06kFsSLYYPjBPpbf61ug0c/7C
 LxG2DRpSwjc+ExByITy44OJ6isiIrEsVNouxxI++zbRyxKzWEcSCHLIdqLDN4fxRUb4+
 S1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711554; x=1735316354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WC2nhe/8nK3+EuJg0FTm4kyJ3k3b7kFJ3rcOFSHjWok=;
 b=AGxLF9903dofF82JAUbe9fRi9V2WM9dWbuqT5hi3aXufZ8cEyMj1FZyNp54t0kb/my
 ax8xuOm3PR7Jcs4adzN81rcHeZvlsYU5P6zyF7lLFrgN2LLOdhsu3bzJJokDLgOqsvPq
 VGq7YYs1x3Y1WxrnN2eOomIg0B98w5CuHN7yS2lQ7PuNJXCN8OSDMf1fpYNtwmotT7/V
 h/aqqDd+6Cf76ibzuJICH79SbiM76hIkeBqfw0TQGPp1HXUIONbYwcsiypXx3PCW6HkO
 IFoDKy/TmCG5yzQQ+IS2lVyHbArr4aqntyC1jxTnSAfPD8MCItKXO8n49n4PcWd0/c/0
 VL5A==
X-Gm-Message-State: AOJu0YzBk7mPmzcrZLZBdWfzOfHhapCmkDBK2Ra2mojm5h9TFKLCjTnd
 IJfThDqp3m7XneZRVsWaYxDc1MSELZCcmRUssagxpSQUPq/Ly13OyGegnkj6mfZZROO5pM8WxXd
 w
X-Gm-Gg: ASbGncvamufrLMrzDngopziaMjX29ozr4GGosUCdsVzVeTnRTENFQCzEt35iInFqnGa
 RxMNZKAQYInaEvPfZuYXBU18t4sOZf17oMJKeKtLwPwvjTAhx4vtjiBTJsmwLwF+4fAfZhYQMzm
 NISKs5Cygm2N1MGboBot9dNx/HH6NXZLrmwHwwHk5bRWMfK2lDn3SYMBhZkgSZ4fsZlNOROBlk3
 fiIkygOW+7e1OMVFVHjnX7+LHhgcbMqzJWBB936jUw+JVREflzzkJRJzqJE7fukKnSOPldBNfY=
X-Google-Smtp-Source: AGHT+IHn/1nHRY3BbeFfS1kunayO+h/eBzOoRbfl0Y5tb/qlH/xHOiY8mYh9OU7UW3YBe9j9h8VMcQ==
X-Received: by 2002:a5d:5f82:0:b0:385:ee59:4510 with SMTP id
 ffacd0b85a97d-38a221e17d0mr3342930f8f.9.1734711553818; 
 Fri, 20 Dec 2024 08:19:13 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e53sm4381237f8f.27.2024.12.20.08.19.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 44/59] exec/cpu-all: Include 'cpu.h' earlier so MMU_USER_IDX is
 always defined
Date: Fri, 20 Dec 2024 17:15:35 +0100
Message-ID: <20241220161551.89317-45-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Include "cpu.h" earlier to get the MMU_USER_IDX definition soon
enough and avoid when refactoring unrelated headers:

  In file included from include/exec/translator.h:271,
                   from ../../accel/tcg/translator.c:13:
  include/exec/cpu-all.h: In function ‘cpu_mmu_index’:
  include/exec/cpu-all.h:274:12: error: ‘MMU_USER_IDX’ undeclared (first use in this function)
    274 |     return MMU_USER_IDX;
        |            ^~~~~~~~~~~~
  include/exec/cpu-all.h:274:12: note: each undeclared identifier is reported only once for each function it appears in
  ninja: build stopped: subcommand failed.

We need to forward-declare cpu_mmu_index() to avoid on user emulation:

  In file included from include/exec/cpu-all.h:263,
                   from include/exec/translator.h:271,
                   from ../../accel/tcg/translator.c:13:
  ../../target/sparc/cpu.h: In function ‘cpu_get_tb_cpu_state’:
  ../../target/sparc/cpu.h:757:13: error: implicit declaration of function ‘cpu_mmu_index’ [-Werror=implicit-function-declaration]
    757 |     flags = cpu_mmu_index(env_cpu(env), false);
        |             ^~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241218155202.71931-5-philmd@linaro.org>
---
 include/exec/cpu-all.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index f7eea33b101..09f537d06fa 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -180,8 +180,12 @@ CPUArchState *cpu_copy(CPUArchState *env);
      | CPU_INTERRUPT_TGT_EXT_3   \
      | CPU_INTERRUPT_TGT_EXT_4)
 
+#include "cpu.h"
+
 #ifdef CONFIG_USER_ONLY
 
+static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
+
 /*
  * Allow some level of source compatibility with softmmu.  We do not
  * support any of the more exotic features, so only invalid pages may
@@ -271,7 +275,6 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
 #endif /* !CONFIG_USER_ONLY */
 
 /* Validate correct placement of CPUArchState. */
-#include "cpu.h"
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
-- 
2.47.1


