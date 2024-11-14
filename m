Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AA6D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcHw-0004wN-3X; Thu, 14 Nov 2024 11:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHq-0004u4-CW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:38 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHn-0002Ay-E0
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:38 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ea09a033e2so583112a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600094; x=1732204894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EYQWI5p9vUhtvQFXm2oStjAmXC4f4vQZGym/5HmIo8g=;
 b=s7RNhd0UlvgnjnMgrXc+Tmn4We2rUzhKiYfjM6vrA1hYqOfdOHrnCWQncLYH4/eCk3
 5gJvA5Sn/4ZdYU8AQPWcwW5aBJPEJe/Ze3BAJG0uoaPB8v0Y0GCDU+s35f/HT3nztr8C
 Jz7Nm7oXzT7VO1+j4gYZZNiM3YXJOREV9QuxLeuN1Oi2PLyEOXDA4+JMytlInchE+STE
 q5Svco8xgzMmAEGOF7qG01Pw0R2iV+GdAd7RrEDljilb0Xw1nI7iDkeh53v5pgqm3Spy
 544msGLOlwHHWm4UDsUTHGUkmHB3z+laXdcnaKluVCGYXLjkWIJLvX010soDwMMtGtZv
 5lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600094; x=1732204894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYQWI5p9vUhtvQFXm2oStjAmXC4f4vQZGym/5HmIo8g=;
 b=im3Ro+VjnNIerUYkGPQp9t47Lhg1R31UarTj7xX7K9t5ZB9R6eudyYB622ElNBbc3w
 lXxG/3ZBiuiLZHcKNwY+LtxCKXzCLPAeIu2OgG93zSk3ZcZkxsqJyLJrqPgFa0b9seZU
 yUjr/Mk2D7de4rVLnraQtZ5AVGxmxUnU5yyGLQO4bGy2Xxe78q+Q52b6VxO3RN6x3ARA
 dy65m/TRbjFCKGiFNVALrPZV2dg+sAf51bzVZf+u+6ZspqsE5TZ6+5sreZbwbM5gZgVZ
 QdgykHGohSFAAeWi95Og80O1R9fm+E7y2EP3hgxTvIA8evHz8axl2X6VgSi3AJkA1ZKz
 dddg==
X-Gm-Message-State: AOJu0YwZS9GaP5OQ7D821ItrZrUDtu7j/5u2kulj4WFPGbXfB6NsZeiP
 EipUBY1a61BnL/CmRgKgbvwPllJCBpsMJ74Y0bdVDkCKSfKwbehriNoszVnNJdUNPGM7OhFTVRd
 C
X-Google-Smtp-Source: AGHT+IEqOnDNFY6IiZLjJTkd5LifxiO+3BFrt5gH9BNB8MwjceC5yDdGd+ahC08EIhbp8OS8ApEN3w==
X-Received: by 2002:a17:90b:4e8d:b0:2e1:a81f:5520 with SMTP id
 98e67ed59e1d1-2e9f2c4ef71mr8430900a91.1.1731600093918; 
 Thu, 14 Nov 2024 08:01:33 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/54] accel/tcg: Split out tlbfast_flush_locked
Date: Thu, 14 Nov 2024 08:00:38 -0800
Message-ID: <20241114160131.48616-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

We will have a need to flush only the "fast" portion
of the tlb, allowing re-fill from the "full" portion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b76a4eac4e..c1838412e8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -284,13 +284,18 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
     }
 }
 
-static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
+static void tlbfast_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
 {
     desc->n_used_entries = 0;
+    memset(fast->table, -1, sizeof_tlb(fast));
+}
+
+static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
+{
+    tlbfast_flush_locked(desc, fast);
     desc->large_page_addr = -1;
     desc->large_page_mask = -1;
     desc->vindex = 0;
-    memset(fast->table, -1, sizeof_tlb(fast));
     memset(desc->vtable, -1, sizeof(desc->vtable));
 }
 
-- 
2.43.0


