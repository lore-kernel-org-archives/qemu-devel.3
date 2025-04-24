Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47484C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lG9-0003a4-Px; Wed, 23 Apr 2025 21:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFP-0002aU-5t
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:28 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFL-00078a-9o
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:26 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso382555b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457561; x=1746062361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E2Pb/xj5a0DFM5mce1sHnV2dTI3TtHpGhVsfW6YeWgU=;
 b=rH7OeVHUUQSNfZuF6MRjYnSje45rdgpuMNLjAOK6FlasFLdXYjVHjl9WU6AKFh4jBN
 TsgnUsel+t4cwzvKMHaChzGDtVS65gHytX4fXIG3KpC73bS6MvZjhJRXxFBNuDAz046f
 qyf8FLlPi3tYfV1PzATCb/ZnckU+eWNJRQTG8cRysgJbcc+eSyXpgIxaU+zwIt3WgdQR
 yYQiE22Z/w1kgvnzzS3DQSfwlsWls8tv6x2ligAR3V8QUClcwZf4Y2oojtyM6n4vAZPV
 uZhGuP4tAuwbGfTSx7rYvnYrM7dnOAURQnZ4nNx2aEyNbcUKvIuNo92xcM58eSOB3f4Z
 ghiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457561; x=1746062361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2Pb/xj5a0DFM5mce1sHnV2dTI3TtHpGhVsfW6YeWgU=;
 b=JwI0A1AiBQj6PSm90qOCwJAMJ5GaFcEm5gOORGT6fnB2c9UyqN+0iDQBx0yRYpprD4
 Uzkj53G6q+5uDug+yztCFyyOcB7n8l8D4gSks8RUveXs1QqLVPT5cTyeAOf/QnhZpAQA
 y02lOQdOc5m9iz3dj4eTzAz0DVIw4Rk631DWdowdkSnBUdHWnCCaXrkXC0ByCiK5PIcX
 177qAIkRped6uteuMKHnLK4/SGYZEUwvBEE2G9ZODiZCnRIPEegyPErUFQzyEUAgIzu4
 zuOkyRZWbm1Ac21RjxwlbxudYy9iSe7Nmp++AiD/vFoN7Z4fVWQtNLhcYRefbXLdQt6Y
 QQYw==
X-Gm-Message-State: AOJu0YyzY2DXvAT94benW/Mkny6ZWAu86RFpQNMgKqByZo82RtHoIDOQ
 2JTdpt5zZrDmhZg1VVKT5D+g6za0w4E5cYXCLwTvbeOSKfJjzYUO3dkfYpk7d13/jW6atjJpzxl
 X
X-Gm-Gg: ASbGncvzl8+DXzyscVzLtZVXNH4d1rOPRUDchmmSePnUEcQSQZGYT+5P2sYE2T3Iwsf
 yGG/B3QfP75ZZ8I5OOj20Mo5w1uYGOHIcu9b0/SBNdhyQ8Xy6F4E2CqICfrSQFJ5X6m8oG1/g3C
 KmPQWvhR0kcICHVx1Q3UUpfLIv48b0yFUSDNIuHG1Fiqi7GKyddkc313WSbzPbGsah5gmaCXPYa
 KYG4OwL+aehQuaNNPW9FX3UpBFVZUV1pLjWSbbgP64yF0SvmYw6T/gld6CrYmAk/XQIJyUfvuaC
 ThQG37HmATV7UsCDxIGInwp3bTjO2VpnvLo6FrHLO80UKTzpOX1/bqXn28m9fzaUR2F+D1DDvSI
 =
X-Google-Smtp-Source: AGHT+IEyM2VXKXx6X4PEEWSRA4fQkoBF9m52x2cgLi1s1SF2K53NeJOpkD8Iwku1iyTeSiMudDCdxQ==
X-Received: by 2002:a05:6a00:a8a:b0:736:d6da:8f9e with SMTP id
 d2e1a72fcca58-73e23cb1724mr1201065b3a.0.1745457561566; 
 Wed, 23 Apr 2025 18:19:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/15] accel/tcg: Add CPUState arg to
 tb_invalidate_phys_page_range__locked
Date: Wed, 23 Apr 2025 18:19:06 -0700
Message-ID: <20250424011918.599958-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 714dcaedc9..e8a465c9ac 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1100,9 +1100,12 @@ bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
 /*
  * @p must be non-NULL.
  * Call with all @pages locked.
+ * If cpu may be NULL outside of a cpu context.  In which case,
+ * precise_smc need not be detected.
  */
 static void
-tb_invalidate_phys_page_range__locked(struct page_collection *pages,
+tb_invalidate_phys_page_range__locked(CPUState *cpu,
+                                      struct page_collection *pages,
                                       PageDesc *p, tb_page_addr_t start,
                                       tb_page_addr_t last,
                                       uintptr_t retaddr)
@@ -1194,7 +1197,7 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
         page_start = index << TARGET_PAGE_BITS;
         page_last = page_start | ~TARGET_PAGE_MASK;
         page_last = MIN(page_last, last);
-        tb_invalidate_phys_page_range__locked(pages, pd,
+        tb_invalidate_phys_page_range__locked(NULL, pages, pd,
                                               page_start, page_last, 0);
     }
     page_collection_unlock(pages);
@@ -1215,7 +1218,7 @@ static void tb_invalidate_phys_page_fast__locked(struct page_collection *pages,
     }
 
     assert_page_locked(p);
-    tb_invalidate_phys_page_range__locked(pages, p, start, start + len - 1, ra);
+    tb_invalidate_phys_page_range__locked(NULL, pages, p, start, start + len - 1, ra);
 }
 
 /*
-- 
2.43.0


