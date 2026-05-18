Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E526CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmSh-0003jq-9L; Sun, 17 May 2026 21:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSJ-0003VO-54
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:39 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSH-0007Ki-Kt
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:38 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36643b96b99so1600954a91.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066456; x=1779671256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b430CcpX8MVCE3nQt/YR8L55hacUxAsUsIp3PqI1PLg=;
 b=Ysg1VOpZX6rcnbg7k2GTGMCJsvhwvPJ9P2HTaQ32nFL1UiHntQEu8ytXZUFiutM91g
 GVXYNBQ5b/o2XFIR8c5wqgyvkPsrWDkXvBY40YbJo3Q4hAR86+XZfCRAS6RUxW3slgHP
 zCw7T/4WQXeS+GS8gARhVLJnGPe8vQE10batNSidiI5JmPLgP9HPD7XUabH9UCRLvFAX
 c9sCoMBaUzgP4OQzX2a8SOb8rZWQSrSFBZ2MA/IIr+zDpsLMtDB+YEmkuWu9wgS1gjXB
 LXEXkuudZQpHr6XvCpZgmzWr8IZHUj9keiWF/vmL3QjFOat+6koM6AxlGar//KLm9oV9
 KQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066456; x=1779671256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b430CcpX8MVCE3nQt/YR8L55hacUxAsUsIp3PqI1PLg=;
 b=hIsXJ7CCbAVdjQzOdjOpG8+btdOrfM+YC77eQeAnJ1zX05QhWnIo1OtaTReXh5iKxW
 W/u7CaqN284WVPUru8v5o8PdcSntBGwQhiIzWVZtSTATH/jwvbxu6YPmPsx1NlVA1AAw
 fFF1pcMY+RXgbirJPg4kRfpcjlDOSNUCO9UStGgAeUhXfmJiMdRpxw02+JrO93BUHSu3
 O01IuZZXXzEmUoQWBvFKTv8nRYNJwOCK/NPZrIAwLlMLeKKMp7vC6HL2KpE7pLI1fiC1
 tJNd95OCCow+4pyeXDBCXgVVHezCPKwX9848P9qpSgDD3f2cWhimbCUPcLtsd3bP5OhN
 58Qg==
X-Gm-Message-State: AOJu0Yz0JMAHVZ1Ti1rVQlBEG847VmcAOM9+xr8/m25fwF7r5PsKeiSH
 c9Owf0ogJtpp85gjJsdntr1om830pd8CkJBZ5S/5qgh1f3IvUQs40ykA4STBRnRK8EUSZf5jM8P
 zw84e
X-Gm-Gg: Acq92OGR0dUI7JpH7e2byIMCjngiNwN7RhIAgO9Yw92y6YQwGMiz3mofnJ0JOsHVwvS
 BQWmaq8Gjn5w2c+4ndJWQuJpuZM0/L5dr+O2HL8RhDXrswshPv+ucRl5Xi9Kg7a62qer7hHPbkj
 8V0afZ2RU123eDQEzFD/z1/3P84KuJROih2bxaM2hjbI1gC/sSrMXz/zmm+qxbvbGM8BsW/S2FB
 VhPmun7JFQlS6mIc7glohb2uJYP6gB18oaH9MkuG70AWPS0o2AdUHwS7uw+6zsjQdpRNbBgLV44
 ySTO63xHBmFdUul31t4whvZD6uWb2qCQf+YC3hYzp0NyhCpGi17HnbKulQVUPfZwnJpvgBarvY3
 jW+6Ba8zXBqlsw0LDl/FQqicAS+fr5rxjbjl/3OJYNwAJUZS45vIipjHLt6E/nKAXqbe61FzANQ
 8SzvxBzQQ6a8pED7aOg9qbXklrWnkXX+MzdPFMr/TtjuMK6WnteA==
X-Received: by 2002:a17:90b:5706:b0:369:a9e8:dbf6 with SMTP id
 98e67ed59e1d1-369a9e8dc5cmr3875902a91.12.1779066456089; 
 Sun, 17 May 2026 18:07:36 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951584654sm9160939a91.7.2026.05.17.18.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 18:07:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: james.hilliard1@gmail.com,
	philmd@linaro.org
Subject: [PATCH v7.5 1/9] tcg: Introduce tcg_gen_addN_i64
Date: Sun, 17 May 2026 18:07:25 -0700
Message-ID: <20260518010733.502237-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010733.502237-1-richard.henderson@linaro.org>
References: <20260518010733.502237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 include/tcg/tcg-op-common.h |  1 +
 tcg/tcg-op.c                | 42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e02f209c09..ee0ad5f6a3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -251,6 +251,7 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
                         TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
+void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d8ae57d604..3dcf5fc125 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2275,6 +2275,48 @@ void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
     }
 }
 
+void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
+{
+    tcg_debug_assert(n > 2);
+
+    /* ??? Don't allow overlap for now. */
+    for (int i = 0; i < n - 1; ++i) {
+        for (int j = i + 1; j < n; ++j) {
+            tcg_debug_assert(r[i] != a[j]);
+            tcg_debug_assert(r[i] != b[j]);
+        }
+    }
+
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_addco, r[0], a[0], b[0]);
+        for (int i = 1; i < n - 1; ++i) {
+            tcg_gen_op3_i64(INDEX_op_addcio, r[i], a[i], b[i]);
+        }
+        tcg_gen_op3_i64(INDEX_op_addci, r[n-1], a[n-1], b[n-1]);
+    } else {
+        TCGv_i64 t = tcg_temp_ebb_new_i64();
+        TCGv_i64 c = tcg_temp_ebb_new_i64();
+
+        tcg_gen_add_i64(t, a[0], b[0]);
+        tcg_gen_setcond_i64(TCG_COND_LTU, c, t, a[0]);
+        tcg_gen_mov_i64(r[0], t);
+
+        for (int i = 1; i < n - 1; ++i) {
+            tcg_gen_add_i64(t, a[i], c);
+            tcg_gen_setcond_i64(TCG_COND_LTU, c, t, c);
+            tcg_gen_add_i64(r[i], b[i], t);
+            tcg_gen_setcond_i64(TCG_COND_LTU, t, r[i], t);
+            tcg_gen_or_i64(c, c, t);
+        }
+
+        tcg_gen_add_i64(r[n-1], a[n-1], b[n-1]);
+        tcg_gen_add_i64(r[n-1], r[n-1], c);
+
+        tcg_temp_free_i64(t);
+        tcg_temp_free_i64(c);
+    }
+}
+
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.43.0


