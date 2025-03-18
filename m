Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12880C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZS-00030F-SV; Tue, 18 Mar 2025 17:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY9-0001MP-SH
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY8-0000qx-AR
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2241053582dso22093805ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333555; x=1742938355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeHYr04W0m2zNJjTvbQgJtgjfEjOKbLo8D+48jtu/vU=;
 b=Thjj7smfIybFRLhDcJUVzvjGF1VhHJyNtuT1AjeilrFEYw4dZceuQt2uycqo7S455A
 1vGIX+g4a4uqsUVCxoowzPrXGwT+Y0wC5wBsAoDKthVcJZUjF4js+HjnAJWtaBapoFTj
 gOAPzwgwnJC26tsKyn3pRuPrH6Zg4q9mtBSbKKhhf/VCFDxrYiP8pkhEjBF0mVK31UQu
 cqMvxfiRwt1ff+JFDJUdE3kaA6Ztz4M6zDh0byGWzmlnVRkTwT7VS5Kld484XWWrKx2p
 61GHew1FbTDmo+axMvFaxbEv12/2QvSJmX5GnR4MDWwo4qegzg1SCdgTBPRUML2dnYZN
 O9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333555; x=1742938355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeHYr04W0m2zNJjTvbQgJtgjfEjOKbLo8D+48jtu/vU=;
 b=fKNTcC0BSoILifVZ33t/rmj/+8EYGB7zR1bnO1Bs9MwEYUIMcp10Go2rX7rrYeC3/a
 /pO5m4XYAolgxvWoytrGq1MDLA6ddWND9IhR8WqrdevWKCs3kindakv0++atU3mT+d/8
 cj0hNY+1iBXDwb5W82OQ1s9Mxl2W2o25Jny0JLKkFXTD9Mh3TYiw3TQ1jTtIRbYXAlVU
 c5dTmm14haoXfbWVrRDQFQaOe0NzF+YA6xnwgE1t3MTBdwt75rm+7Aiv7lc4pDwgFnyH
 6QhBsgb5jCPwE0ep+etkDdzJukL3wvFGBb53khL6GUfuU2B4h+XXWaSJnvOnibhtwpuu
 3uGw==
X-Gm-Message-State: AOJu0Yx5LJIuBk9l7XlTDYX/g0tHVRjs1TPWROIIk9uSYQch4gX6JH/R
 btGoDpNvUVZchApMTWGNW1pkfjwCnRHSdv+So6c+MncSJICiFKm9uDEDHT2PBk5qdI86OZ74HEl
 0
X-Gm-Gg: ASbGncs+tBbuTPZXY3jlTQD2ZlzjB37LuAvDRPMXMmDWCWZxQbgYiozx+KcmMmVIgOT
 Z6H5z1j454Zm6URwwjRFuQ8WPy7GnJx1ZOf+CFAu80ftTRyViP9wAaubJ9NV45kLrwBsK+cQvHD
 l4GlUw+Be1H+72Xafh79cGVVRz/9F9hfK3IfbYpXzLgmw5OXhSiatyNShiFUAFZG74TIyCaZJur
 XTQeUUMtwRekzhsRPhwz7U1I9Vy1zxvxAR9tviaeELFNKxUc7qs8e5Wq0s+wDOlARnHYQR7PxYP
 VWsV+LWZd4sO8O7RL/URsHv38CXs7X/qLKyuTpetZ8sS4J/s0DhD28mZBjdrphffmTV01i4RwQU
 W
X-Google-Smtp-Source: AGHT+IEU5X6Hp9CxAqBbUK/LRBm59SVQ1RBZtj1MoDWdySuzw+MfgdnorCm3O5mQhTMfZQlsO6nexA==
X-Received: by 2002:a05:6a20:9c89:b0:1f5:8e54:9f10 with SMTP id
 adf61e73a8af0-1fbecd48b02mr364618637.34.1742333555077; 
 Tue, 18 Mar 2025 14:32:35 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 35/42] include/hw/intc: Remove ifndef CONFIG_USER_ONLY from
 armv7m_nvic.h
Date: Tue, 18 Mar 2025 14:32:00 -0700
Message-ID: <20250318213209.2579218-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.  The inlines
for user-only are unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/intc/armv7m_nvic.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 89fe8aedaa..7b9964fe7e 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -189,21 +189,7 @@ int armv7m_nvic_raw_execution_priority(NVICState *s);
  * @secure: the security state to test
  * This corresponds to the pseudocode IsReqExecPriNeg().
  */
-#ifndef CONFIG_USER_ONLY
 bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure);
-#else
-static inline bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure)
-{
-    return false;
-}
-#endif
-#ifndef CONFIG_USER_ONLY
 bool armv7m_nvic_can_take_pending_exception(NVICState *s);
-#else
-static inline bool armv7m_nvic_can_take_pending_exception(NVICState *s)
-{
-    return true;
-}
-#endif
 
 #endif
-- 
2.43.0


