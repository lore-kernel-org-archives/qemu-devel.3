Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493C7ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAN-00038f-CZ; Mon, 09 Sep 2024 12:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAL-00031a-J7
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:01 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAJ-0007lZ-PT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2054e22ce3fso39172245ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898978; x=1726503778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLV5QacygPLKfVWBa93d9ZxgoSwEsczlHxuXIXCNBYM=;
 b=mQyHILvv3J/GafelTC3bTr8uWFs2w1JixFbOU01nJmWXGa1EVDU+521YOLcNeycdn1
 /SKGqsRjRWA3x61lcpKCoFpOWUxS5OJB/0oyb3NX21GVCdqaWsL63/R228YQbTOHfaBM
 e9NBBoY3/93pAU08ITOSkUEKkHLwC7+EBUjSuqwx3pqDL4TAIAgRkXtSLfJPQO6tyUTO
 w00mzOleoNKJ2BSbRCVd4oNYepWOc5SXhUV9+ch6xwgQdSeuB/HS7LeQAtCVKhUyN4np
 d4u4GF0WeUmVHO9X8aaVDgH3THhbMsvcxBQchjNMta14YR8dTnPWtYzGJCXS/ZmaFLTW
 K8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898978; x=1726503778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLV5QacygPLKfVWBa93d9ZxgoSwEsczlHxuXIXCNBYM=;
 b=DyE13YHeGXi81OEUe9DWH85dolL2ZrLw0fsGfw8KFrcbucze6ySboIwbi3HQMBb3AW
 IuWv9gzBXUzUtcth5lxI+bARLGUFT1GhnxlM5vrWbg6uGAltSfewnnK/Hsw4B2HAX/Lu
 tk4XwmSM2fOxu8FyhfKoogZDyWN6S8g2rAAhCCMd+UGJY5etDuKTZzDrT4AbY86P+oyo
 QXwugs6zmuT0nSbYEC9rfnCj2FBsrX/yWrk+8brpvWja4tDMGugy9tcVgCjqdrvPC0BT
 z6vWNg42gPg/Y7xlxQ6dvUc8bquTjftlCnLGNCBzdOIArnwPc1IS91MbDuQzRcB8MWXS
 Vo4g==
X-Gm-Message-State: AOJu0Yzs6mCSepXjUY5f1d2Trp7ql5H2vTub4xKeW1HCjTMPv7YCp9nw
 bVzRQZc6YKGZ4yhDzESlH7Hs2WUlmzKpZMcL+e0vUu584OSwpXTwT6qH5gkfmXPqCKUZNWi+FrS
 P
X-Google-Smtp-Source: AGHT+IExFKJ9eurc1cE4SZLqAwrF0SVGP2JaS/Xx9mxPeUz7XihzOQm2Wjykh90jUUR9oiX/TOiPkA==
X-Received: by 2002:a17:902:c94b:b0:202:330f:1512 with SMTP id
 d9443c01a7336-206f05f6772mr113427935ad.44.1725898978505; 
 Mon, 09 Sep 2024 09:22:58 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 18/29] target/arm: Use {, s}extract in handle_vec_simd_wshli
Date: Mon,  9 Sep 2024 09:22:28 -0700
Message-ID: <20240909162240.647173-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Combine the right shift with the extension via
the tcg extract operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1225aac665..740620074a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10477,8 +10477,11 @@ static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
     read_vec_element(s, tcg_rn, rn, is_q ? 1 : 0, MO_64);
 
     for (i = 0; i < elements; i++) {
-        tcg_gen_shri_i64(tcg_rd, tcg_rn, i * esize);
-        ext_and_shift_reg(tcg_rd, tcg_rd, size | (!is_u << 2), 0);
+        if (is_u) {
+            tcg_gen_extract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        } else {
+            tcg_gen_sextract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        }
         tcg_gen_shli_i64(tcg_rd, tcg_rd, shift);
         write_vec_element(s, tcg_rd, rd, i, size + 1);
     }
-- 
2.43.0


