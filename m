Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873D8E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSE-0000NX-PZ; Wed, 11 Dec 2024 11:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSA-0000L7-GS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:46 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS8-0007kM-QX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso13109345e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934043; x=1734538843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lRJiit52f5redlFxi2z3tbKksS9bryLnGPt7oPWvzf4=;
 b=WpFfEk0rPbrsbyKKT5O8ghIn+v419hyksvspTIqLrw1G8tXQ6aw3jValVKRqmOdatw
 14asKTgKUQGQlTqAd6UbvNTWMsqgtuzyebQxfOcK+/S+vlEdOykMpUhtxSvyqmk/3Auf
 +n+K9wCDf8U+3/JuegwsO+UkYtAI1aUGHeDGLmKzKt1X9Qi/NAkt3KOmBn8rTBWnPmqU
 CBJENw0ccF4eN/UwcqFkUnaqNJ9gzc4btZANdg7Qm4R32VdygSrD+e/yuR0kgnAZAPKN
 5igqYT3pKnV54Ag0ITUI5tglJrJBrMT8dPM1tXEhcoDoXjOyGv0ufdIEx0I0AdD7Rihf
 q7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934043; x=1734538843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRJiit52f5redlFxi2z3tbKksS9bryLnGPt7oPWvzf4=;
 b=SnuFZEq1vnhvFQP2lgN/jkGO8mCOfuCVB+SYLCIi/QUq5FY4enVUkjGTsj+Bq4kg7W
 2HmDPIraPz4qaGXwm8TqAr6l1kjIS4yhGIzeVsSUNYSGuOdgiesVOUUFjrjjR0u+yc+4
 /1yLk9Z9/6kJmXtMgwBIFoo0vMNqQ9GkEf1i91pA7uKB5VlqXHYjjqEDAyeDdlfbkKVr
 XHMTUlpaLiJsTwjNC9/4hYfjOMy9fWihP3XYuS8crDtkbCLf2JsFvbUqk3ptxRyLfpi9
 5tv3ZuJgs56Zr2HqOy38NuS3ZLFHbT7IDgIsilS6tP1PnsZJUqv8xF0sI4MY+uv5+L6t
 oOlQ==
X-Gm-Message-State: AOJu0Yy6oHk9YqzKEbcj/zeBZJrR9zqlRshI5ZLUWxrBYjVosAG4BErj
 b921j145kGXJe2HbU7ZhvCEUVufZekng5CQ+OX8/3BABqca3DqVHOrXGsuXqBL37ktYKE27jS9a
 o
X-Gm-Gg: ASbGncs2yHv+H1pDLHeR+7Pn0c6L+J+zhL8sBQAlz4facsCiTbMLKeh56+jEYEfOwS0
 JIHunRXFptW00vEKCJmCN3elPGnAZRRWrTPUxQaD+5HTphJI+n7SexhfxbkPFP1AD4/ebrejEQr
 wsW7Yh9CpXEIo54t2S75bqT1CSbyTSaViqWNJAne6Q4Uqz27Rv7I5xL6svxmg7IY6k6BG/qwvJx
 CduVtyU7mjL8oAYjz09rYZOzTBZ52OAm5xtyWePtTV975R8TnFPy71whqdm
X-Google-Smtp-Source: AGHT+IEIqQMUMC0Nwx+cFm3rDUovTqBfmGq/iSOyqalSgzGVrTHBYb5LRHb7XRT4v/5+2fwPhLFdfw==
X-Received: by 2002:a05:600c:1d20:b0:434:a529:3b87 with SMTP id
 5b1f17b1804b1-4361c36f5ccmr34039695e9.10.1733934043288; 
 Wed, 11 Dec 2024 08:20:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/72] fpu: Remove use_first_nan field from float_status
Date: Wed, 11 Dec 2024 16:19:23 +0000
Message-Id: <20241211162004.2795499-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The use_first_nan field in float_status was an xtensa-specific way to
select at runtime from two different NaN propagation rules.  Now that
xtensa is using the target-agnostic NaN propagation rule selection
that we've just added, we can remove use_first_nan, because there is
no longer any code that reads it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-27-peter.maydell@linaro.org
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
index d9f0797edaf..84ba4ed20e6 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -309,7 +309,6 @@ typedef struct float_status {
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


