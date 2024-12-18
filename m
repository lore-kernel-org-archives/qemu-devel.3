Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7735BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwLo-0007bo-KE; Wed, 18 Dec 2024 10:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwLl-0007as-Jk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwLb-0006Ud-Ke
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:37 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso3498497f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537143; x=1735141943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFIbomYs8pZjGfIH2n6+AIUHzra8wuOY72Wp0sIRY2c=;
 b=XzTEzZK3/W5XU1WoGOKuzSEsbOwT/SEpNaKNGxhd1cDz/sGCbpnds8mlzBQ/hFctz4
 uiwkYDEWYAQXN7kI9LAwGf/WYf6BOU5tpgxIjmhoeTV5u8i24IyZNHlt2kBKasZ5pyH1
 MKxx8DXq+lBssbSK5gE7p88Nkj8n3eWJfn0w6O9f3FwUuGx5d1Vkmm0B6Zvx8Q/nbRpQ
 fHKq4FRDgVQNfYWWHZNaGEbsOnfQzQRDXpuG5fR9PVgIrfjtqZIUoktfMFPtI26uT7+w
 CP+XA3XJnfEJd93mcS1KAlz/OKCepNhJj1TLIQIdIzJgCbynr+N3O3X7nH3cG8/NBCh0
 GS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537143; x=1735141943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFIbomYs8pZjGfIH2n6+AIUHzra8wuOY72Wp0sIRY2c=;
 b=LRYLW3V+DuaT78nUjbzS+wTJ1s7ERYCaREfj7yixaY4x72Ool3LAz5/FUk6sfYW70F
 Pp6O5auN2cQ9ijHvYlzVk5Sy+U6VzQCnwFrT+HLnIbNk9h6Ki5GBjVdJmAB+bm9k3USx
 tKW1raGmMwwdK9ujHhgmXqmOatG2Yaxv6xIbjWjs4RA4RuXaNX+NTHlCFWB/bFpMhfuV
 9XOpkzmWqCsQhRHPvXGHQiYk+NOOu0agUSUgcQU3n7HZXUBskr8cOsHpJ5OUHWdHNmh2
 YWO9kyC7aglZJsdVaPqo034ESnc6Vs4cBhv7QphGG+cYKad4u2EG+KZPjqAR8Knjp0Fm
 SSSg==
X-Gm-Message-State: AOJu0YzmnaIntplbFcmjWPulyXOfUTDb6ZUphSFdV9EmZfpZQfQwo56J
 fndzM377uF3gNinaFLXuubBa2BI8X0wzYAfh0MtkDt915LPsYIAB9diXiaEQigSM/Cz5oJLPF3o
 x
X-Gm-Gg: ASbGncut1zk99Kt1i5fCItkSqCVKx66BjL4SYEM3COVFiMLHjqWt9x5A9FrjDpfiYT/
 VqO8F9txjCu1DErDCsptmKYJBPqVyF+fK9+Brbgp4lCWbvfVq9GrPXovASJrE7MnuZRvg7sPZxm
 nIy8n5/9IxlhgOJ3yqra2G9QLrDbqW3UZTFFDTRQss+qJuj4XHeia8l5/UNTjEVjFRvWUDMzbMi
 Oj+RiF/iXiSKGczHfxhfnX5ZyszAlR7SBZETIoAMkcxx7T6ORXWEjp0yFb4f85Gfe/V5rBcWsEO
 wFQK
X-Google-Smtp-Source: AGHT+IGtMb4wa2xjqGOK+va7/0mawPwNlgYg8HEaoZQvjSeIlspyX+BMCqAH1ND/O7XWemzAAZ1jRQ==
X-Received: by 2002:a05:6000:1a8b:b0:386:1ab1:ee34 with SMTP id
 ffacd0b85a97d-38a19afa15fmr95332f8f.9.1734537142759; 
 Wed, 18 Dec 2024 07:52:22 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060566sm14261420f8f.102.2024.12.18.07.52.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 07:52:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] exec/cpu-all: Include 'cpu.h' earlier so MMU_USER_IDX is
 always defined
Date: Wed, 18 Dec 2024 16:52:02 +0100
Message-ID: <20241218155202.71931-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218155202.71931-1-philmd@linaro.org>
References: <20241218155202.71931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
2.45.2


