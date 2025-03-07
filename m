Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7ABC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqczq-00047c-6v; Fri, 07 Mar 2025 14:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqczf-0003xe-FP
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:04:27 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqczc-0003i2-Kx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:04:23 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223594b3c6dso41871865ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374258; x=1741979058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWT0L4EBMx/nGFskBmpx115GbPBpRrubLUlCXG3QWrg=;
 b=Q+YlI7CNkPltkxqzJG5qqgxjLzwX1nvBEHLJqGx6LtHitimJU6W6D4JK4aEdJhby9k
 oOWTwIT0fUxx/QfABqyJQ+22rwr91/eHsH2BkYCQsm6e/Nfz/nSjgiCHYMQR50+1cWIS
 dnUJvA0u59IRMpud4bZUtQQM+PM4dg56vbw3XTZkTP9frPy/ZK+yztAm3JpLK0plAtbv
 uXaapQp7eol4/RoLny72zoMMZ6Jo8bqtVx8lXTxvGn1MMeMLodi3BA0u1ut0iqchKcly
 LYyXObU5XCAaIWQXwmiCxD4X3FC3O9f2ACVCTWT9kvMhngL/f8n2O56FAl/4lHfdPQJI
 FncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374258; x=1741979058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWT0L4EBMx/nGFskBmpx115GbPBpRrubLUlCXG3QWrg=;
 b=jcpbD9NM7bLmLU+/KMk4uLtyJH3e5awb5h5jqB0ZdC1TeftDEdH1vpGOQiICjsGuay
 0oz3HVfWpLY3pnT2H2zjj/wx9kvmk8E3Tkh8TQF6zQeIw8rvpuz90T+77bRAZ+y5tTPO
 dlAGSoL8kMeIiJHBbpTdzRjv9CIDdkoW0QcQrKoie/vXZcx2P6xgSAIhV5FUroqZxRKU
 Sm2Ue3NkICTFRNtrKJ1PrNQ9EDsaE7NTxsFK1LUhOjAR0wwA7pl7BmHiIYTgzwiKSFQO
 hFajyXKQ+DE8VdhideLxJL+aYPT+rF/GVaNoksQxpxcw3Dmy6Py1jxG7IfOmawNOvUrr
 BtHw==
X-Gm-Message-State: AOJu0YxJT3U6gosMWYbuxIPKs5zPP4R+gLa5/q4PGEH4rmx1ZLcumpAD
 iqLFM3xfMgOY4M3PC2s0N6FyXQN3Wf2IvsmRd43E6Yq53qAKxzNZswVwK9WKa2D+DmqhRYC+4+R
 2
X-Gm-Gg: ASbGncvp7Qn0wW1NgNPY3y5jsh1hbD5PXWRBNt9H7jYpoa2lOadAtUdunClbDiU/3P/
 bRtMcIeOJdIALNF28dhqDqCU28VflS1PEmZGYjVxMxqQOHMQOL6KWs8kx6V/1rl/H+BLsniZfgt
 5q5+x1tsTXVjNySKc+yBx2rjvQeU5SJyssQNyRb5qF8e8ST9qOvDuZBZfrBMoxNicnzpqsq/T4K
 /UdU/lejIe4iaLUIgErg4vwydRkki++AK0jj02AruRfgDzpe5ffdRT0i5TLAlFGmpckqzdO2XJY
 yvXZm8BtIQV9PVkEtIe+CzNQ/Nrjrb/fd/jhSnKdQx4PjLhV3t7opKaG5bs7umVWlNxb20qcX21
 W
X-Google-Smtp-Source: AGHT+IGXTnnd+y5ouiJgs5crFNXgaHLLqtbnyiLJ7OuSnOSl9xTtAYqziaWWoEjdiCp4776ck1TpVw==
X-Received: by 2002:a17:903:2282:b0:224:2717:7992 with SMTP id
 d9443c01a7336-22428be5a5amr62909535ad.33.1741374258002; 
 Fri, 07 Mar 2025 11:04:18 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91c5bsm33686335ad.186.2025.03.07.11.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:04:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH 2/2] target/arm: Simplify pstate_sm check in sve_access_check
Date: Fri,  7 Mar 2025 11:04:15 -0800
Message-ID: <20250307190415.982049-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307190415.982049-1-richard.henderson@linaro.org>
References: <20250307190415.982049-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In StreamingMode, fp_access_checked is handled already.
We cannot fall through to fp_access_check lest we fall
foul of the double-check assertion.

Cc: qemu-stable@nongnu.org
Fixes: 285b1d5fcef ("target/arm: Handle SME in sve_access_check")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 48e0ac75b1..723cb3f24a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1457,22 +1457,20 @@ bool sve_access_check(DisasContext *s)
 {
     if (s->pstate_sm || !dc_isar_feature(aa64_sve, s)) {
         assert(dc_isar_feature(aa64_sme, s));
-        if (!sme_sm_enabled_check(s)) {
-            goto fail_exit;
-        }
-    } else if (s->sve_excp_el) {
+        bool ret = sme_sm_enabled_check(s);
+        s->sve_access_checked = (ret ? 1 : -1);
+        return ret;
+    }
+    if (s->sve_excp_el) {
+        /* Assert that we only raise one exception per instruction. */
+        assert(!s->sve_access_checked);
         gen_exception_insn_el(s, 0, EXCP_UDEF,
                               syn_sve_access_trap(), s->sve_excp_el);
-        goto fail_exit;
+        s->sve_access_checked = -1;
+        return false;
     }
     s->sve_access_checked = 1;
     return fp_access_check(s);
-
- fail_exit:
-    /* Assert that we only raise one exception per instruction. */
-    assert(!s->sve_access_checked);
-    s->sve_access_checked = -1;
-    return false;
 }
 
 /*
-- 
2.43.0


