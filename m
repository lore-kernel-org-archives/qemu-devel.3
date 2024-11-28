Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F4BD690F8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc32-0007kO-If; Thu, 28 Nov 2024 05:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGc01-0002Ew-VI
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzu-0000lO-PR
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:50 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434a0fd9778so6064475e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790618; x=1733395418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zfa3WE0hEeXkZktlw3Eszp/UyNtqhw8PzXG1xyTaEO4=;
 b=oqntGWrbUm9WHtxzp+8LOwkGNa8RbeB98PixlPUozsUYFkWWzsK9LxLa43gA2gSVAQ
 sLG0RzcJS1wvMAvxP4eoXG5N3S+NAdCzspAXLfpKey4h9/y9/lUnzM7hPsO+RloAA3pt
 EI+UgHRJKpEYvUhnR+J3JzlCXSW4MM4Cm6KmO71jtmw1tCYnmUqi+raWIP13lyYITkoH
 sGoysmz7irkDEMmYx/J8/DPn0XEEEfpBQTQHgvzDHu8UIuQ3AUaEMYuCsHBXulaLvggP
 mNNYWQUuEI8MAiQ5e4Ok6mnAAnnWKV7Jo0cDuNw6sXIyNPU4GLBeOjtyArbuoGMQiD0M
 koRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790618; x=1733395418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zfa3WE0hEeXkZktlw3Eszp/UyNtqhw8PzXG1xyTaEO4=;
 b=hdK+LMmED2UKNAGdKolRn5LucaXZMALjBSswL1ViYE949l680aLVHcfcgD7Yqy4lT+
 L6LY5jwA33Kik1dPfm4k/Z0gpY0omd3K2ztoPSNs2WVtKgDPKDWrDT0MgbqvNY4RYtGO
 Nh27zIcENkG5EClaeOzbYk6EWileACW49/obwX7j88ZTSkluty9epjRxy13BVB5rUrga
 FGXKyFKZZ0Cwo6oTEtibMuDvTC019TAxw7xzZ5w4XX2ZAJk7WntoHccpexpqmC4XCY7X
 ZJblhHw/qhV+PfocX1thNOkLu0EwG3W/LLI4KU8GhM3zFsCW6mkmaebfsit0W1eIYqs1
 AnaA==
X-Gm-Message-State: AOJu0Yw6eZVUB2vwiGsSV21NlxJhamzUfWjVHbMq+kTud8ixhdywXxEl
 onCwlR/teLunhvKlbCFjmxeRzAh9OD9NwECB8WxWmLefpLrCbn9Mogksxh8Uee4XiBSLq3r4QR2
 I
X-Gm-Gg: ASbGncuyoJXHZPbQArl1EbQDCF7Wjcus3cwRP02BkyP7563OQ6TRdtpx5fzKtHH3b9A
 B2Lx0iNvTrVSDsX2iaEkUhMpF4Qmi+6ixajmmNRChxKNK2CVWtztMLVg/PHrZdLEiUC/J6KkEVz
 iCu0fobNbR8wTILN3h+f9gDJgHqPUeq13skkepKS82s9E/T8ygepWJG5m5uq8zQFvXSr9aQFhwT
 mKj7AFYIfERNjXaQQ+gPHxesnel8cJ863QanUo7eyE90jz6q2vkYzc=
X-Google-Smtp-Source: AGHT+IEkBsbVJvsOrZdU/bWIWX4Mwf9E2dHz/HQ9DDr+QVOG3OEjoakFnX8ebUp0N0dtsxDmzVj6gw==
X-Received: by 2002:a05:600c:1e2a:b0:434:a8ef:442f with SMTP id
 5b1f17b1804b1-434a9e0b47amr51873015e9.32.1732790617727; 
 Thu, 28 Nov 2024 02:43:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH for-10.0 25/25] fpu: Remove use_first_nan field from
 float_status
Date: Thu, 28 Nov 2024 10:43:10 +0000
Message-Id: <20241128104310.3452934-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The use_first_nan field in float_status was an xtensa-specific way to
select at runtime from two different NaN propagation rules.  Now that
xtensa is using the target-agnostic NaN propagation rule selection
that we've just added, we can remove use_first_nan, because there is
no longer any code that reads it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat-helpers.h | 5 -----
 include/fpu/softfloat-types.h   | 1 -
 target/xtensa/fpu_helper.c      | 1 -
 3 files changed, 7 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index cf06b4e16bf..10a6763532c 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -113,11 +113,6 @@ static inline void set_snan_bit_is_one(bool val, float_status *status)
     status->snan_bit_is_one = val;
 }
 
-static inline void set_use_first_nan(bool val, float_status *status)
-{
-    status->use_first_nan = val;
-}
-
 static inline void set_no_signaling_nans(bool val, float_status *status)
 {
     status->no_signaling_nans = val;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 79220f8c67f..e2db92c72fa 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -291,7 +291,6 @@ typedef struct float_status {
      * softfloat-specialize.inc.c)
      */
     bool snan_bit_is_one;
-    bool use_first_nan;
     bool no_signaling_nans;
     /* should overflowed results subtract re_bias to its exponent? */
     bool rebias_overflow;
diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 4b1b021d824..53fc7cfd2af 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -59,7 +59,6 @@ static const struct {
 
 void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
 {
-    set_use_first_nan(use_first, &env->fp_status);
     set_float_2nan_prop_rule(use_first ? float_2nan_prop_ab : float_2nan_prop_ba,
                              &env->fp_status);
     set_float_3nan_prop_rule(use_first ? float_3nan_prop_abc : float_3nan_prop_cba,
-- 
2.34.1


