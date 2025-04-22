Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D87C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPM-00062V-23; Tue, 22 Apr 2025 15:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOu-00056Z-5B
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:29 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOq-00071r-Et
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2240b4de12bso83112275ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350518; x=1745955318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMqpwELVZjRand5YykheI0qauU6tLGMgrXCPuO0m4X0=;
 b=aRyqhouJV8jB92Yz2ok4BJIcT0mIr72I29UmvuSCC1btEYfshy6P52IM+Y/lU34+Mj
 llvwRSd3j/mBKGO8AvHhb0S91QUkM94QHmv6KBweKjnzuhIAxu7b9eHkKkaSnIBm87No
 EBYhplVyA8QZcPgajEutGXh6lCCCsRj51mKc7sXt9dyv5T/a32y+zLvNrWBaylrv5668
 kpMZYSX98N623d71sUi3S6Fvk998s1+guD7n1oNxcMPxaYeAcBOpKoUBUC925d99Gmgu
 H3eEnxHRfQZjbdjEVmV2xwoicu3GIgc9vgAtrEcSRWXAWjXs8M7mpDRsmjw+JjR/bF7t
 pNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350518; x=1745955318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NMqpwELVZjRand5YykheI0qauU6tLGMgrXCPuO0m4X0=;
 b=Ggi8pMjNfUCSwSQXQs/1FrqwsKTuvZqpUTqMrdqt9rtw7jJIRjOhQj7fpP45FJbk0p
 h+tLtqj2CleVs1HUuL71/mdk/vS2vkxlNeSE6HDGjJcULW/ziIfI33A7vkwagOYGcQfr
 VOcQ1F04bJvwINes9b+G1tcjYpPP3O3N6KRTwTRv2ChpTpGm3X+VzBAG771d4sPzi1Pu
 4H6buSmYP/Bk5TOiHN8KGbl/y0W+bK8XI3Ygif236stiTQJiA5c0CtL7L3xoSf34NdgI
 EOefpHWgIBhmrQH57wOOmYjUACKrXuz7fswDG3LzfzxvRP/a7Tj5XVU1VBvkRxWAI465
 l8Hw==
X-Gm-Message-State: AOJu0Yy99IlqIuwNs3Pk+wxYEtNzgJRvXWNwmo2A5m2gmiob5PZUVDuT
 WgC7LkQr+Z5EntFFSVIfp6jw7gHk72sxImijcrV/STKjA7rIdqambfCA6dPgzXPcC+nteQp/PLn
 g
X-Gm-Gg: ASbGncvksVZqdZYMCfGarL0od5FhSo5pF418Sv7IHUndBCYEk7//nQuVXnFuNowxrPG
 kUR246od+OBQCO/idN+PBQI3IREOhKI8RIhpZCEy7UXyNkBYQ7lsoRdvEDkwcMev6txY8EuKvSL
 D0L2OzCe5I8wpB9xiec7seOF92UTgeMOdBTC4TDf/+xCZ9DTAuVkfAsLkGtg+dVHVtS/iGLx1J7
 aOFKV8NtRMw8HkYwm7PCmAiBZh2vUuhwzOvh0sNupmGwd6Kao7Vhk3g6omC+J0rgrCHcZEzqqxp
 2x5pIB/qJuAyT5CQs9fQ8b6RKRt3UD9sp+BGqEHe6UYHojSknklY4Eo/ZJciPmzlAnsjJWBMUoY
 =
X-Google-Smtp-Source: AGHT+IFIwqLdIzaJFm3FiNiEsVVtBnKAAagjFbK4Flnu/oReY6ZrUiujjQ5SEKrBAaiBViFAxp+aLg==
X-Received: by 2002:a17:902:ce86:b0:220:c143:90a0 with SMTP id
 d9443c01a7336-22c535a7254mr244961925ad.24.1745350518438; 
 Tue, 22 Apr 2025 12:35:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 088/147] target/rx: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:17 -0700
Message-ID: <20250422192819.302784-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-18-philmd@linaro.org>
---
 target/rx/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index a240b3b3ce..51743020d4 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -207,6 +207,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .translate_code = rx_translate_code,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
+    .mmu_index = rx_cpu_mmu_index,
     .tlb_fill = rx_cpu_tlb_fill,
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
@@ -227,7 +228,6 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->mmu_index = rx_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
-- 
2.43.0


