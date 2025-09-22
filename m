Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA465CAC5AA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0liq-0001P2-3O; Mon, 22 Sep 2025 14:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfz-00054r-6K
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:19 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfP-000513-Iv
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:14 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77ee6e252e5so2909225b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567216; x=1759172016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIGC+NB44/a0H+dR2upS+UgyhxrsXnOzX4fio5wssx8=;
 b=tvu/yDoYF2TBp57oodn+wPY9n15R7OcQxirA4vQnad8ALMzsx83U6+eQvE0NhHZks6
 TNZjcZ7Cpn+IN4xHc1C6zFYLbKm9yVfADyvUAPqy9FUBtlsECE2Cf1H/QK4b0PaU4tz6
 1ZLkdGHoBHtdQjPpKtmWcyi1tM3n8zJt6JIPgqnnhuR8LGuDwo8hkeYYONB9+RRfVr79
 sgN6IVlZ0fJeqrxz0JmoAV7uZq2NDtQJ10l5Ctsgkbv8o7uCDDJfOHu6ZVlO6+WWpYn7
 Dc/ThCunk8TwdCduVIKSAXbL0ujLkllhItV51OGkNPQnlPVS+Sy6gVjhqVIwv10P+6a0
 7AEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567216; x=1759172016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIGC+NB44/a0H+dR2upS+UgyhxrsXnOzX4fio5wssx8=;
 b=WEXzWIgkNCpTDjqSlaY5zwA1G0O7chVjR2BGB0AWTGpCO7anm+agEOtM5Pmy3eRM/z
 IjrTidl9rBfrltTO+KzoDD9+667Gi3Th1mDVq5qMhYAZabXAN1s/IwvhNg1qqiWnNuR+
 Fyg9YjoF9ePNUPATfQhPiE5YCt5ERyD3VJkSWCuhxvcJPBZqvSjjERBoyR1P1ZRxqEL4
 Zc+a9qN4O0Q4K6bnuAVD11i3qrKJBJkiuLVMURN5eG6i3GB+VyvkfLe1szhdqATytH2w
 Hez5WvcsveEjwTu8k0f/V0ZVNGogxiI+IGoXS4UE6IjCBblzNrYWybh6AWjpjXv2ls68
 psEg==
X-Gm-Message-State: AOJu0Ywj2Cw9wn12LeVZ+5f+PliNv4qYWgtnzRdYlhI/3zCjvwj/LGha
 2AgyGpzD6ouQ/BilrCMWqmIJakwTD1ACHUmAMCmFLI//CR3QYUaJdcbRo0BtIITJDvmQugl9loW
 o69z1
X-Gm-Gg: ASbGncuJUj7RrOIN7yzYx//3KgVF8SJ09IXgF0Jz3XLAbFJjgs8DqdKSkfh+dTVAPYj
 p4BpX5yWjYRjLfcXrm22+7TX9EmN3FUHJUzkn5oQavdHAo+cjZdXVWXo2VWxnFv4t8sUhbOunQn
 Hr3z6lhwNeps27H/nDhRSgwjHvb7ySlLKQUiuQDcV2fp2RxHb/GJq2AWf7cD7PK/+5gaIKSsyJ1
 9/8UfWXkkywQ9HpToQPrVz1dLwiqgTXF6E1ah2gs+yBoStQCcQ5dvVPtwWb8GcBgFRuF4C9e/6p
 Yd4cySrZh8a6wuAuRGNQ4lE1apR9LBFmoOuALlrZnF6zBZ7hXvW2+4wGE/hkp2L6wCbQUDN3yV1
 hG4NxSCL6zIOutgmlFqCRILjcJOo/
X-Google-Smtp-Source: AGHT+IHnK9rRG6hvlKVoT4mEeGvvAa24s+BGGifTiad+9GXWsQJCxBuEDHsu6NZlq3fMKFBguLMflw==
X-Received: by 2002:a17:903:b48:b0:24c:9a51:9a33 with SMTP id
 d9443c01a7336-269ba455941mr172864705ad.22.1758567215770; 
 Mon, 22 Sep 2025 11:53:35 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 64/76] target/arm: Implement EXLOCK check during exception
 return
Date: Mon, 22 Sep 2025 11:49:12 -0700
Message-ID: <20250922184924.2754205-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 08b7db7c46..ba1d775d81 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -675,6 +675,17 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         goto illegal_return;
     }
 
+    /*
+     * If GetCurrentEXLOCKEN, the exception return path must use GCSPOPCX,
+     * which will set PSTATE.EXLOCK.  We need not explicitly check FEAT_GCS,
+     * because GCSCR_ELx cannot be set without it.
+     */
+    if (new_el == cur_el &&
+        (env->cp15.gcscr_el[cur_el] & GCSCR_EXLOCKEN) &&
+        !(env->pstate & PSTATE_EXLOCK)) {
+        goto illegal_return;
+    }
+
     bql_lock();
     arm_call_pre_el_change_hook(cpu);
     bql_unlock();
-- 
2.43.0


