Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B353C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjv-0005lp-3a; Sat, 02 Aug 2025 19:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLiA-000121-K9
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:23 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLi8-0005An-UT
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:22 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so2561997fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177540; x=1754782340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkNyZZYFhHeil9ygYrAE1UXkAwT1+GtqIOD2Xj8zAVs=;
 b=x0p+trCfWcYmIO4CP4dG9LkdZbI9U7lpxJBe905Xywe9k7ztAVQBNrutuSme5CQ2tj
 miYMa8N/7PD3S8Ll0Piu0fwQLUxGy1QMF6D/E98MSPQR9mgCiBeFk/i6oeZSJUONQI+5
 1gU/6NxGxVb0kI1krl5P0wimyoONZvMDilR6PGi5rX+PUhr4DkGAzs/rjokv8msBA9vI
 YHMLVRV5rmMQhHAP0XyCzBPP1dH9qR91SEToh0y+nhzP2gTaXrDZummytNmBColzfNBZ
 qCYMw2DykH+hZVWoKW2WLcr8bbuxF7rMpJO4umjJHvtbw4HjpFIEYzxezqhP0UG7TEsA
 ljwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177540; x=1754782340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UkNyZZYFhHeil9ygYrAE1UXkAwT1+GtqIOD2Xj8zAVs=;
 b=gY/uRWrfFlhXrb5LtOMm2HAW7MCKCYgt/oZ6v2ebJpJwzeK3k1oVIK6sisoycfGfLz
 hqPJ2C1t3USGxzec+AbDb8Ig+/cbDIJ/kZpSldfN+nYFEXO8dQsul/VhP7/lGFSheiII
 ggiljgI3ypuQSdfXvd2P2B558G1H4V1Wx2vX1WONcj6WZIu4Ds5a6+8z9/4I7cTYEuu+
 Mbb2EPKiA4RLnGTTNM2G5jRwGrVXyOE7bZZU9epY8OU5/IDFqgMAZHNcoKjoqH2bgsKp
 vKzI0RzsHft+zyGbXI2+mG5InXjdaRZdUkJ9dIpmkC5g9eqMBjKBQLdE9HDMxD7zlnje
 pc1g==
X-Gm-Message-State: AOJu0YwH8v1rJYjk2LhaanzAJvGQVVs7/0NtLQ2KH3wxSJ9tRNQmyJq+
 uoEStgmLuRXFYLG3AtH/eGB7S9s2VDSPMnABeZc3u8JGoMJA2LUQOBNbi8UNAToZv3zWzjCynC5
 b5NAzYRg=
X-Gm-Gg: ASbGncubb5Tfq16+Aog90TwoxxRIiVht7wSTwYZZhqX1nYomnrn0c6xAe9KHGSy+/5i
 UVyyqqEp5VGG7ts+GJ1OQgK0RA7xM+04OOaeRCqX596AKDNUwbPzUO6cwi16bhJol8fsepSf8YY
 dDBXO7nWZC8SdyD29OaubBmyVeFlItDvQjxGtn5LXcHUI43oD253ZjBn0mS/UkoBuqom3Go/6MT
 HUGlVMXAo+RXI0R15rhmYOWUw4AzkM8YdPuQg3OQsxTVr6lghnWSuNJd6UvYGcCprfPDq9r1oGR
 SUHgiOPzuUsWP1slrVAnw5WGeRFQllI/vTo++4Sda5lmCGD6fxzN/z9/ko9uOLsXZtuDsJquR/S
 Z3Qpojr1KThk+QXd0iAtahM+eYWqCAqtds/BFrN4onvRkn/Vv34OH4QjNYrIKVMw=
X-Google-Smtp-Source: AGHT+IFaZzmK5IYUTuJNQzaACtC5hO+K31zKKWlBkqoFSys/khbeKudzmVw91FuYj9atNyCYvwbvbw==
X-Received: by 2002:a05:6871:5889:b0:306:c0b8:49f1 with SMTP id
 586e51a60fabf-30b6796f2b8mr2705043fac.19.1754177539760; 
 Sat, 02 Aug 2025 16:32:19 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:32:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 29/85] target/hppa: Adjust mmu indexes to begin with 0
Date: Sun,  3 Aug 2025 09:28:57 +1000
Message-ID: <20250802232953.413294-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

This is a logical reversion of 2ad04500543, though
there have been additions to the set of mmu indexes
since then.  The impetus to that original patch,
"9-15 will use shorter assembler instructions when
run on a x86-64 host" is now handled generically.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 11d59d11ca..672ab3750c 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -29,21 +29,21 @@
 #include "qemu/interval-tree.h"
 #include "hw/registerfields.h"
 
-#define MMU_ABS_W_IDX     6
-#define MMU_ABS_IDX       7
-#define MMU_KERNEL_IDX    8
-#define MMU_KERNEL_P_IDX  9
-#define MMU_PL1_IDX       10
-#define MMU_PL1_P_IDX     11
-#define MMU_PL2_IDX       12
-#define MMU_PL2_P_IDX     13
-#define MMU_USER_IDX      14
-#define MMU_USER_P_IDX    15
+#define MMU_KERNEL_IDX    0
+#define MMU_KERNEL_P_IDX  1
+#define MMU_PL1_IDX       2
+#define MMU_PL1_P_IDX     3
+#define MMU_PL2_IDX       4
+#define MMU_PL2_P_IDX     5
+#define MMU_USER_IDX      6
+#define MMU_USER_P_IDX    7
+#define MMU_ABS_IDX       8
+#define MMU_ABS_W_IDX     9
 
-#define MMU_IDX_MMU_DISABLED(MIDX)  ((MIDX) < MMU_KERNEL_IDX)
-#define MMU_IDX_TO_PRIV(MIDX)       (((MIDX) - MMU_KERNEL_IDX) / 2)
-#define MMU_IDX_TO_P(MIDX)          (((MIDX) - MMU_KERNEL_IDX) & 1)
-#define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P) + MMU_KERNEL_IDX)
+#define MMU_IDX_MMU_DISABLED(MIDX)  ((MIDX) >= MMU_ABS_IDX)
+#define MMU_IDX_TO_PRIV(MIDX)       ((MIDX) / 2)
+#define MMU_IDX_TO_P(MIDX)          ((MIDX) & 1)
+#define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P))
 
 #define PRIV_KERNEL       0
 #define PRIV_USER         3
-- 
2.43.0


