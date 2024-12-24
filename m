Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C9AE7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDv-0001F3-Rp; Tue, 24 Dec 2024 15:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDf-0007TQ-Er
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:31 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDd-00030Y-UK
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:31 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so5866840a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070968; x=1735675768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKTTrx8B/icquGiBXqUA5XkQlJqGmYAEi37JaPi9ziQ=;
 b=FBjx8nIWslRurdSEhHxyqL00uZZjCLvPBbPOZ/K1wXFUgH5X3d61Je5wnD8Tx55Pf/
 zD/8lLWJfWKW1iWyNtDBW1tPY5GRs7DKXS28fFzV9NlEhwrhSYDDSd7bsqCV6NkAQiPT
 V0Q2IUcq7KAP5J6uGpuQ6WHTH5p+CTAvVzo7gtWRglMhF3/h3/Hbi92Og6PjKsr2QkX5
 ubV3hSmPHmcQLgm/NfydpDJuWojIgE/QSj2tewTT7qd0fGMUV8a1oceRoCsC4AuwnTip
 CHLL+lhZKgj8LsqN0bMGttZEmGHB0xbMdYCDw1oOzUwN8H0DjA+vMne20ZlwSHOpp4a7
 kICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070968; x=1735675768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKTTrx8B/icquGiBXqUA5XkQlJqGmYAEi37JaPi9ziQ=;
 b=uXv7eQcUNplo7HsSBMZtENa2xdfiz01N/ke3wf1JZvqgqX2B2xOLjIbQXwhW4rmT38
 EDWAJ85YSWFxCYjMDdWV5KG7WbuUEP7mpm99COxhb0MRKJD3izBkqgBLn4R5SZfOIcD7
 GuyS6g0fZbuZBmB8Mt9DxoOIgR75WKx4EU3WRsIBs87mwQp84H+BjhQjJBjjku3kkWrc
 BnKJ6seBttkaJje5LRGkfFoqY6XECTbJl5Vwjzw9hPdh11PRg/ToQnFdReoF0PpS1Cr3
 SIMUJNAcBFJ3hipxHpiyWg6N64gyH5vmy17qteLu3RmPzBAzLOfdaprKM/XHe56pr01v
 Q8rQ==
X-Gm-Message-State: AOJu0YyHWRgHUQGri8Pi5feWYy6wS6RB8zqVnkcGHRTR7FD4ABJBEXKI
 H1WRVPXSkEE3UNoRTzcuxu6UgeCdswAS7CMWXIF6NZazSjbkHC9vSP1D664zATy38dmCpxv9A61
 XVhU=
X-Gm-Gg: ASbGncuCj2vPSVDU8iqbFdXoQTJywUzGV8pCeo10UpUQLZ0L8gXlfc7r4KaRK5jyCpH
 0qBGymPmRe2BrLQA9eVPR3NCDyV3RRZFdJ5sphGK2gkUUyRiaTaYQSygFnCY78xj2Sjr5yoirRw
 5rTJShfaMPeecsuMHvCRp5R5ZfMBKuxDXDvVTQUzFU7GSGUvwz2ZQ2bBOaN3ooaSyVZBVSGqDcN
 s1R7SJKGuqn5LJC5HPYDifIn1d4JJW75R4r6wB3/s1tj+DnNBRg/5A9VMyLiV4h1UaIDZsj/MQl
 QBXc6OlTe8hQfIacDkTwuZnrxw==
X-Google-Smtp-Source: AGHT+IH8sBYGma8KW8VFaxhKiL5C8+1aN2Cn4B0G1vI+xbm+lJt8SEGmeb5MDNMzyJNrybxDsKioXw==
X-Received: by 2002:a05:6a20:8427:b0:1e0:ca95:3cb2 with SMTP id
 adf61e73a8af0-1e5e0458eb9mr32037304637.8.1735070968572; 
 Tue, 24 Dec 2024 12:09:28 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 68/72] target/hexagon: Remove Float
Date: Tue, 24 Dec 2024 12:05:17 -0800
Message-ID: <20241224200521.310066-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

This structure, with bitfields, is incorrect for big-endian.
Use the existing float32_getexp_raw which uses extract32.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 0769de43de..2a8f72fee3 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -53,16 +53,6 @@ typedef union {
     };
 } Double;
 
-typedef union {
-    float f;
-    uint32_t i;
-    struct {
-        uint32_t mant:23;
-        uint32_t exp:8;
-        uint32_t sign:1;
-    };
-} Float;
-
 static uint64_t float64_getmant(float64 f64)
 {
     Double a = { .i = f64 };
@@ -92,12 +82,12 @@ int32_t float64_getexp(float64 f64)
 
 int32_t float32_getexp(float32 f32)
 {
-    Float a = { .i = f32 };
+    int exp = float32_getexp_raw(f32);
     if (float32_is_normal(f32)) {
-        return a.exp;
+        return exp;
     }
     if (float32_is_denormal(f32)) {
-        return a.exp + 1;
+        return exp + 1;
     }
     return -1;
 }
-- 
2.43.0


