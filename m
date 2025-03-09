Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10543C2BA1B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKrZ-0001J0-IO; Sun, 09 Mar 2025 13:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrR-0000sP-Ns
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrQ-000571-63
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:49 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-391342fc148so1344290f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542886; x=1742147686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+h0WxWe/CR+AYRisebI04Ld1iS9EZlB98JnRUIatSNE=;
 b=fCP7nFL+iKB7O5bETo7Cq/us3EF81ntFoBhXwZiJ/B+/5+3nT1HT7pH4Wu+d2KUxQc
 SryQBPwDA8jr8zFIWjDNfyHCOAMgLpWqsJ41i5GvR/um58xNDQH6lErr6hQ0Ht/Ovgt6
 Z+TQwCzDO1XoBYE4kfhFBjP/pg1xR26HC2CKE6G5UGrTIdPZECJtRSbnJY8oTeNOY6L2
 oQOPeiL8xLxqE0Fz4B6YZ7w4YqPkLnXm3mhQ/xrooqbVKkcasoNWeKPiIiIOQY0V1v8p
 ldSoteFVw2ppPBI2uJP8sh26Be121USkX1dNir/MAUvQQ3jrEB/0W+xDCWlOGABQ5uGB
 5M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542886; x=1742147686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+h0WxWe/CR+AYRisebI04Ld1iS9EZlB98JnRUIatSNE=;
 b=HDKWULIObIzm2mGp1kIbwDYIQcBQ+qitynqlXrWIo0yUVuEY13IGNAQq83f0zAggDu
 9px4eeuvBSy3ch4tzAEOZc6aBk4OcPpXs02tTxnX1wjXFNCcgrb0SixyQvl7h8HCBZ6J
 dKJOrgl1j/GuKHUa59DhqqB1KxxVbiEuuov6MKjI6YueU2wkl5I0zf0JFvPlsVWnOaQ8
 uLt/E4rNzmlXdoPcZ7TImr0minbUpFkJjm3MGiW4ZvO0Osau/i9sLrbL11v0gHr3xke/
 JChtVHtNas1uCDTpBHjj4PSRPJmFTa9D/7gyIWWfJBDFJMrWf+LH690kXlta+xGGXySg
 mxJA==
X-Gm-Message-State: AOJu0YzsqyntTvmdHbXEzitR21cmh1kFWIKd+pxbB5/wX+UbOdpTt7TG
 tD1rjOYarN5A9+0YPnFBwEAh8ufOsFizJ/0Lqmkii+Lpb8ZL/D+dpysU++k+knXDpF0kXxTHwrw
 1Q44=
X-Gm-Gg: ASbGnctqIY06CwDiSchR70//Ifa1ZDEaWJD9zx02y81QNNjD73m4V4wA9qEc7IGcfyQ
 24KtSn5/r4eC9zsaZNea+GmBuc4Obv7GQdH2eSqVghoupte0elA9iBAXn7QeAgXdp4EbZ+SYaAy
 +Xh+Td8D0rJqCCrovstAjzUKiaE5DfFEb/gFfdPw7ffuvZ9UjWwUJOKw/ZnAYjqZKsWQuK4ziz2
 J05wQfBkN5WO6izeH8/aVy+dR27i/uzemZfJXlUPt4GH097gYIlVlY+AuwMOoWC/c4ygnBcAt7y
 BWWyajAhlwkvjR6rP5VHYhW6yTF6HrkYwHGz87R76q+7WJE3/AtBBVHvXgAgUQkuGlZWVjvV4jl
 KDKQ8cIUGtvWzeemxTGw=
X-Google-Smtp-Source: AGHT+IFwvQawKC4jslJQKRpckp4hVOwhEniaqC9R4heKt8LwVBiaWaxRct2WJPyGXUz4uePtq9OJoA==
X-Received: by 2002:a5d:5846:0:b0:390:efe7:20fa with SMTP id
 ffacd0b85a97d-39132de1bd2mr5483565f8f.47.1741542886144; 
 Sun, 09 Mar 2025 10:54:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c015d2bsm12167134f8f.43.2025.03.09.10.54.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/38] target/sh4: Move has_work() from CPUClass to SysemuCPUOps
Date: Sun,  9 Mar 2025 18:52:02 +0100
Message-ID: <20250309175207.43828-34-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-21-philmd@linaro.org>
---
 target/sh4/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index c2aaa40a037..ce84bdf539a 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -82,12 +82,12 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
     }
     return false;
 }
-#endif
 
 static bool superh_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -254,6 +254,7 @@ static const VMStateDescription vmstate_sh_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sh4_sysemu_ops = {
+    .has_work = superh_cpu_has_work,
     .get_phys_page_debug = superh_cpu_get_phys_page_debug,
 };
 #endif
@@ -290,7 +291,6 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
-    cc->has_work = superh_cpu_has_work;
     cc->mmu_index = sh4_cpu_mmu_index;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
-- 
2.47.1


