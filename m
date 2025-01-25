Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8490DC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjaP-0002fq-3A; Sat, 25 Jan 2025 12:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjZ8-0001Kp-6J
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:28 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjZ6-0000d2-IM
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:25 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e06af753so1663991f8f.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824596; x=1738429396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZ8BDmUkV3T9ZQW07wpYEtUOuZG1AGKnmguq5EirG8g=;
 b=daTNnmdrWymOI3a4ufZq3/YE/70jdcWkWpnKOA1oKerB7syhRZlwgJ592ngJ4sGHSd
 EyeJlnXBfkp58wsrqgDa3MmwlwoC6YG1hZnfztCb9xFUZm5l/Win/E2AQB3fdFHJikFD
 Oo5WAPEZaVC4iYTYbNYmIJJDQA3YdAkRH7jyGFZ72msUjsSJ8e5yJXH1gAjchJrbKblW
 QgwznaQ6TQsu9YZOa8PP9DNm+FlaLlIHtqavOSurp24vxLrNyjhfOtyWFHaIgCOSvbh+
 kyItlRIZNn9gi4oQRHYZL1Oi7Z2CTgBr8l07jdYDM/fwl/tN+T1gXIEKNQSJHJETnxUA
 uG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824596; x=1738429396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZ8BDmUkV3T9ZQW07wpYEtUOuZG1AGKnmguq5EirG8g=;
 b=JbBxSsxbAo5ujqC0I7Bq21wB8COnqq8SSL6WxQ5e9ijW7AckVkahGWPydp7gdgUbCx
 35OeBURV4W24SJNsHkNMdnbcKQnusDH5yKQPo+eJxCgw2ImmBF9qHxYFVji/bBTTf70l
 0T/kFvdRzTajfu7GywuXYrMt6eLCDoKZdiAEKL8bJY8siD+wosWYCRJMZXfL3tb+dU8n
 kvNf+WLSUrJfX1H2C4Na+BMdt4gKGN4qs8W10t671mYoPgNi5w78ofmZdYM3sM1v67yf
 VT+RT9wyAfj1rt3RireLKBr/+99Tzr8xtkKWh8euXnXxyUrZ/a0DwZ32mbfPQJGVCE0A
 F8Dg==
X-Gm-Message-State: AOJu0YzH6r3rd0T91ZrcNnm1x2v7L9D/h9fD+ASx5PLquwzBOy0X9evM
 wVFkaHSH/h2XbRHUx0hAc7PSY2v5uVsPXK1niKafxxDgAKOWaXA+E+OwQu83hoHMf46LJMf9yZl
 ZjK4=
X-Gm-Gg: ASbGncuQBp+QJCOYey4sOTaz5xG/R2IRnfXQaJphda9fxovMI8Zi9TsNQOLiHIj8BZr
 p+eMqaTOK4Q7gINOSX/s5YoH1QcKRWKyaXWG2m6PMl2E2SlQ95TkFYywnmWBCerv/QvpTyEGCE0
 9tqZI6oMBukLvAD0DPDhry/BFF+BCrXeBFDLu40Lm03mm36x4bCWYHYUZdVTmLE3sArP6xfDpON
 XFCqM3D1AdTJL32xMYAIVhC7cF4HVYK/wuAdGczYU87R1lPl288O/EF1R6cfqYimMr5NAY04RjU
 wGsM9+OaiVjmXtRmGsUhA9MkzZd4PYzkRddex1/db9o4yeBspHAPepkCG8lwkCCwcw==
X-Google-Smtp-Source: AGHT+IE48i6Bsk0bhd/YTaWz6+JrmmJLB1KFdVbHgndtEAI1v8DNT/fmollC/FqLtkBPLnLnA0oLGw==
X-Received: by 2002:a05:6000:4008:b0:38a:624b:e37b with SMTP id
 ffacd0b85a97d-38bf57b642dmr29881098f8f.53.1737824596562; 
 Sat, 25 Jan 2025 09:03:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17633dsm6057072f8f.15.2025.01.25.09.03.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:03:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 22/24] target/tricore: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:23 +0100
Message-ID: <20250125170125.32855-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 target/tricore/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 95202fadbfd..e4f95876efd 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -165,6 +165,7 @@ static bool tricore_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps tricore_sysemu_ops = {
+    .has_work = tricore_cpu_has_work,
     .get_phys_page_debug = tricore_cpu_get_phys_page_debug,
 };
 
@@ -193,7 +194,6 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     resettable_class_set_parent_phases(rc, NULL, tricore_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
     cc->class_by_name = tricore_cpu_class_by_name;
-    cc->has_work = tricore_cpu_has_work;
     cc->mmu_index = tricore_cpu_mmu_index;
 
     cc->gdb_read_register = tricore_cpu_gdb_read_register;
-- 
2.47.1


