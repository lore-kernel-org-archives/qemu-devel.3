Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32C1CA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulKJ-0000Pv-M2; Sat, 06 Sep 2025 01:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulK4-0000KB-Gv
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJp-0006og-U3
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45ddddbe31fso1622455e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135907; x=1757740707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkmKqMS8/SMg8ZwOM4TI4jWjmtGLf5UxJGwLaRP/AiM=;
 b=AiBcYzUaek7hnyNgbU3CVuXUk9bZuISIi0pFfjI2otNkibWub9orOHG3Gq5xsD72bz
 jEZ982qk+nG9NzO8v4Eka60Q81aD9XudLuwkLNVUmr+E90twgE5g9EWNaQ5tM8voY0LK
 vVuWshi3zQ8nd4nhPT7YNzxObAx8/isDQVmjkEGwfLAhe0FERJ0IO/e83HrhzfhpQeOB
 9RpGdHmtNnTQ1DFKp18hevuzDjkJyrSYvpV2ZMZELU+YUumD6Okcc85Pu2t0ZYM0OHgR
 X0zOxmQQMBr3wOhjmHCB91vS92LkAyEF4RQ00OCVNuDf5fECQLDWSQg/tYKwaqKf1oZT
 v1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135907; x=1757740707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkmKqMS8/SMg8ZwOM4TI4jWjmtGLf5UxJGwLaRP/AiM=;
 b=cGXmMn+vEWR+fqK6tTz7AItj+P2skuaZUR2xNyU1IVEOfuQQoCFaMr5sLx3NVUP4WX
 D7hg8ZjAYI5JC3d2vwsgw4WEr4YLqoV45u1Ezi4DGneQw86HrwQxm0RnWvcWWQhwGqTC
 WVGVVdhaMTxx1ZOAZF3A1ii1TF1ja/cVBNJY1pmAnXTbxbZjZz9b33lfm9XxdAGXaSVo
 MYvQGIX8Pu3dULJu3d68VwXYTZT2okT5iQ8O1HQ2CzQZBIka0x9fUrmpKStuVNVo6gw7
 3V475zueTHqBFPBEEeXz7wU8aUnjg9qimBhCZziu5G0qIa43LFjkiPXfaudoK0evaCfM
 Zfjg==
X-Gm-Message-State: AOJu0YwjP4kX8k32wMPpuCnAtVJGWrYQY67MkUIF8+cQ08qi83nfbHkL
 I9nUASAR6rQROqMfvul4WnMjNWK7IPtdPWsMTOlIxYAVRkYN/vxK3AgpAKVBSDAC51HAILuyKYj
 qYClUWeg=
X-Gm-Gg: ASbGnctjOXAa7Q49qUq2kaYjHVi5PrM0anJsNzyyMScEOSK5WhXdT14t5T8rYjOheSq
 kuDyU3xASDs6/GMPXUiIfmwz1ukekTdUEs7SODOtpDBtTTazZPBIRhYOeTv9j0bs+Mmvd4YvgrG
 PaBG+bDoKOqohmzN4hHeoxShXo0u2fLRjRZsSzZNTK1NZv/yHRMlP6BOTtWBkaor/PDzDkgZ6h1
 QbEmU3+e8z0jTBybL4afaovu00gaH4YYmgWnDjtX8Jy+eduooe3mjCgOZAuFtE35NXscTNoxSmB
 ZqoNK3NFgYUytedSbwPo9v+jW/3iARVMD/SZiL9ozqJT3LXIqaM+qlkV7YM51gHDyRgtDU/n3zn
 vfEhMiDFELfaXYdPcHh9bX9jjNVpp+wLMwJtgFGM5p7VteFCREd6jPG/RkX2HbG3NnQNRhg+4
X-Google-Smtp-Source: AGHT+IEy7/CM0r5HDO0FepBaIknrHfRnjDQA4LiXCnECMp4tIhvEV5ZDhqLJua0VwrdObRfyNE63vw==
X-Received: by 2002:a05:600c:358a:b0:45b:9322:43fc with SMTP id
 5b1f17b1804b1-45ddded6b98mr6955555e9.29.1757135907357; 
 Fri, 05 Sep 2025 22:18:27 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 06/11] hw/ppc/spapr: Use tb_invalidate_phys_range in
 h_page_init
Date: Sat,  6 Sep 2025 07:18:15 +0200
Message-ID: <20250906051820.160432-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

We only need invalidate tbs from a single page, not flush
all translations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ppc/spapr_hcall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 1e936f35e4..aa2e5e1e84 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -8,7 +8,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
-#include "exec/tb-flush.h"
+#include "exec/translation-block.h"
 #include "exec/target_page.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
@@ -301,7 +301,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
         if (kvm_enabled()) {
             kvmppc_icbi_range(cpu, pdst, len);
         } else if (tcg_enabled()) {
-            tb_flush(CPU(cpu));
+            tb_invalidate_phys_range(CPU(cpu), dst, len);
         } else {
             g_assert_not_reached();
         }
-- 
2.43.0


