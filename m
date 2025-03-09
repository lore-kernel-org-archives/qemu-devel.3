Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39691C2BA1B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKqp-0008GE-9B; Sun, 09 Mar 2025 13:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqf-0007XK-Fu
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqd-0004yZ-NC
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso5176225e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542838; x=1742147638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f4Sc7hhTcdoZP5mVK5+fnzgoyi3IuMpFTmnfFiAgyFE=;
 b=UuZuEmcYJ11SNa5z4ItcIRTrp3ra3qDEkNUgpaek7cJsHArIWpws5zqy+oz/J1Lykf
 lfWZ+7MtyLZgkG16jDtNxhru51EP7oiAyNLAKXWeunyEYaM+bbVZ392jo80p0pFHewPh
 nxLyPVXz3aLcgi2egKPlYw/C69ILHrwS/EJKLeFUn5MrqfFFdpKFiPoBz8FW2LUTxX8s
 bYHrQ76/6tH1lDvxAFleN93PUHoiWy9rOgofpJG2Z6tbmSucisSelY/dq9WYsDljCdBJ
 M3sKNZv3uwVwnSkh7xR9hmqL1F8qXf90EE6F+9ka14AempswrIgnT+UEDKuxk2mLAqS/
 MaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542838; x=1742147638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4Sc7hhTcdoZP5mVK5+fnzgoyi3IuMpFTmnfFiAgyFE=;
 b=eWCk/gpYRLZOU/1oDdq24/TYbbp4aF15Yu2uB6d/QY7mbjZQPrq6p4RJQjILSRsdi9
 YDwH1vTjhMdG5YwuBtwwlfeqzzxwUcMU7QUYYrjaLJ/aiiyd8SlKqGUhU9fWcksmDYtr
 mmNKmNouxFkJyODL4VvV3JsDoDseyfz6qwSaFOdUFqQev/JYXgkKEu4eo3g1iyQdpsD6
 kciVlzCrzupgMvLLqFv2MCk1qw9x1dgsPdRzUJIUdaLLfKUylG9zBtxyzqbzXq/sEb8T
 KZnE9npQfFwR8Uh0SlcVweASRfxwx5ke///lwVBIehrYPaghMQtIZtrZgGIZTb6Fru9h
 NZmw==
X-Gm-Message-State: AOJu0Yyt/Jt+ptiHdTQU8BjQNKMDzAi/NEyjZpRbiE3KzC4jj4qB4s/w
 6JCI/23kH1C5Ft39X/+g/GR782hAI3zo3kORbzvcKC9EVV5uIhXEScbfGANXUUpALKtEVp05XdX
 HYaM=
X-Gm-Gg: ASbGncvcUanGDAzE1cR/UiZgDLBUeYm1CVkWfXBkEeDWZHZOE8JGIm7yFiXI9MaQi/F
 sK7Zye8RFd0aDX4Jkd45KUjAe0/VDSkJfAw9P3c350xfoCHdrhYGtu6e4awtI7VwZ8lVvWpTe32
 80xkgDixb/vg3UsiVlQM0VH7QWmiteS+C4/G+YRwBGf4hrTJE1ACOEFG1wRcI4phxaFk3aPVtMD
 WGQrI08G/3uUeWQoMIR92iQTkYh4Kyjio0rsQkKufnD4qWMEiukgCvkkT3UhzYMgQSs4tD5GwM3
 07Q19bqg5dBmCGc8SPP44hPy7+ndLOIQuK4096rpquk+CRwKfEmYpvb3+Zajz9jkqNCjTouQeUo
 yT7rxfww6TiqyMWqJoJQ=
X-Google-Smtp-Source: AGHT+IG8Olbm6viAoPF8ztLNYslyGWlDoIzpn/8K4E8UZ6aI3crlbAzn9i8c3tY0a7Ytv1Nfmn+RWA==
X-Received: by 2002:a05:600c:4f09:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43cfa527f9dmr1992225e9.20.1741542837897; 
 Sun, 09 Mar 2025 10:53:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ced9a4b19sm44139075e9.29.2025.03.09.10.53.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/38] target/loongarch: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:52 +0100
Message-ID: <20250309175207.43828-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
Message-Id: <20250125170125.32855-11-philmd@linaro.org>
---
 target/loongarch/cpu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 49f603149dc..ea1665e2705 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -350,11 +350,9 @@ static void loongarch_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 static bool loongarch_cpu_has_work(CPUState *cs)
 {
-#ifdef CONFIG_USER_ONLY
-    return true;
-#else
     bool has_work = false;
 
     if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
@@ -363,8 +361,8 @@ static bool loongarch_cpu_has_work(CPUState *cs)
     }
 
     return has_work;
-#endif
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -885,6 +883,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
+    .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
 };
@@ -920,7 +919,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
-    cc->has_work = loongarch_cpu_has_work;
     cc->mmu_index = loongarch_cpu_mmu_index;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
-- 
2.47.1


