Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E1DCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swd-0004Jd-BQ; Mon, 22 Sep 2025 22:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swR-0004GO-S8
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swF-0003h8-P8
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77ee6e252e5so3235892b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595168; x=1759199968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkiiaZ/I0kCUxEv1YuYFr7w89DooS5qqrLfJGIO7KtE=;
 b=LC7Gblweeg0S1xRCKppNhoYn7ozf0sYipigeyoV6Gmv0QnrEPeklJg0q4lHIOzKZ6e
 G0ALfnRwr/b9osVJNiiu9Zuufo04KtHDKml/IRyEW0iFaSuznIvVH3OrYB8xOKF/+i8d
 NR6DouFj+ZKH55fEy85LGEFCtYQms5y4m8MZfks0Px4kpzQXi4dYiN1FuRgNEXGTNhhR
 i3LBtuRwxQcjJGyW+6ZNMZPmAvoDOgXSis9UlmG0jlCbaj2RK3wyftUWljXLMnY0zAyv
 byx4R0Yiok4OeOlCN3Oxsf31UDtSlWJ+WNAJRAPoXHJg467yeEgyviUgizktXEXUjsaL
 OV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595168; x=1759199968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkiiaZ/I0kCUxEv1YuYFr7w89DooS5qqrLfJGIO7KtE=;
 b=kWCBKxq9lqoeq/ceyQ9aBLQTWqkskFY4Bx3kcdo+eXF9lulecfh6ylg9IFwRc/NSUC
 ZVxPLdg0GEULO4h8B7b5+pCKr1VVkFubGkeJbGe1BIcEvakQ44b/8KavjJJOdhd7TWnv
 2U3i5rvkJr1OB6n409JIZNWps2QMJWIuirb8kt2eLd+uRwykQiD9TznFhqSqLaXRXSuk
 khiypcs+CJSr68Qhle+JZKsi5vY2A0s1xNPCLoaWgUFWoiuLIpfCWPqAgio+ZjW1XmKW
 hTECXF0InlT5kBZ9l9icGx9a5S/Gjrpg7MuazKKv+Cjl5rNwYazZj0yHAEivJYY/Ov4A
 4yrw==
X-Gm-Message-State: AOJu0YxnyzsFMy+YZrglrmhNr82aBUMNzUsFTAvGbSZG6uMJjoXfIt8P
 47576t1XJHmSuklqFakDiSDHUmA/4qQyOz9HC0lT1MUZabb96xp9OY1E/ky/Kcy8wtmWzSk+X7h
 YTl3D
X-Gm-Gg: ASbGnctmpyMU5faO+xqVhSJ/BqVDGtl9cun3OIuPe2m8AY6rt4ibFzHv3XVgrzwFFFS
 8BwuV2TNRVKwSm40GarflXAtD6CiNRN1H5h03zU0oyBceYwGQNAdX1tXj3jf+Gj9g5cnMQmLA48
 Nzq6rClLyMGTcpQbPpbtAYCAJ5MO3g8ABc4Mu4yOr4NWf8+osxgfNmg9ng29JQshBFA59htR39O
 VoHtPHXY1uw1y+tQjHI7a38hAdBfvT4bMziVkXw1yQrabEfaS7NccTNwpqogAObSaTwecFA5+jd
 d4DZ3SWwo72HBy0Vwz3Mqm2tJJzutBmLsU45WKY+ATKfaQCNeKfYTdA2+Pm6cDe5Ypn3d2pm8nN
 ooyciLncFucke8U7ekY/k+obMP22m
X-Google-Smtp-Source: AGHT+IHKMVMp3APayk1JjMJxSPmPTqAkEmmzM3hi5fTyha+r0zmvy4EH9e4oNBzdMQjC4nC6Ku6DMw==
X-Received: by 2002:a05:6a00:3904:b0:77f:1ef8:8acb with SMTP id
 d2e1a72fcca58-77f538ffa10mr1444422b3a.13.1758595168286; 
 Mon, 22 Sep 2025 19:39:28 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 06/12] hw/ppc/spapr: Use tb_invalidate_phys_range in
 h_page_init
Date: Mon, 22 Sep 2025 19:39:10 -0700
Message-ID: <20250923023922.3102471-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-ppc@nongnu.org
---
 hw/ppc/spapr_hcall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c594d4b916..feb31d5dd8 100644
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


