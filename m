Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D735C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kQx-0002op-Hn; Sat, 27 Apr 2024 11:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQw-0002oO-16
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQu-0005OO-An
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41b5e74fa2fso16883585e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233466; x=1714838266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+4yLUAOofyuOllTmkJb4TGA3hpl35wvUcTVB112zyg=;
 b=dFqn4C+QD63NUz1ypcjv3vIckR+TejO8Gs4IRrfPcqqMi7AsbodS6QFzNt0uOum+IG
 3s0QU/BqxKfz77RS3mgE5H10QJ9dryTLb4CzOc1PrWAiV2iBaqHrX6bTuPNklVGaQaDG
 3NBHvfFadxV89NZkwZrHpa5IB0adhxoIISYqCCXVL3rWPCHDMTuo0fzbbW439mceXHP5
 EJ8mW2IRJKUl8qs8yrAojMumOFj2VyZxon8fQiTDYtKjg3kdgcZbrPKIZSg/baBrnwe2
 +4bNukERoqlYlYAQhqgkVlKzf2TVHfQvdmX8p4I7BP5KPE30SE8iAEAfXqwt8I403tnS
 4hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233466; x=1714838266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P+4yLUAOofyuOllTmkJb4TGA3hpl35wvUcTVB112zyg=;
 b=ZH+SFjzrnmUKvbtmVSoBSjFKz++RsSTiJlBHYgfAhPoFP00aSunDK2vFz1DQJSYrJR
 mUiBzG0rvjE9pk2HMu9k/qK8yPVYoAverTdi5DnSs7IQsRleicJ54dJ4DRVjzm3/X0SY
 Dd04r7oWzKoiqHrnuu5QbztVikOGj3g8423rqnoud/s/Qsltyh1UEIPicrQuK9tan16k
 RupBrd1ELA2tj7T09FfO1p1D0/wQy35eAXKWAW/p3dRifkxp28zYv2IkuEsJpVWwoto+
 qrMdDJu/3Z0iBYH/+CycgtpdcOzbgf0IPcvTR2X3vehCcmWTyttF5D+x0B9y9o/kpe9T
 ZeyQ==
X-Gm-Message-State: AOJu0YwjaTPsTDCwbAxlaUnz8Jn15A5VTsKXLIxJe9GaFf8LlfkbD1hN
 eT5sRLJBVw88XgfVgmDfJ3Ci3/6lUUoAXBfcXjJAQVSwmbXm/HKflHJETrfLImICwjssRHXbRle
 AJkQ=
X-Google-Smtp-Source: AGHT+IGJAEArapbFYH+0z81cAAbhOTPNEyjXNpH6Gh0D2N9ktZUYgqrgte4axXyMaZsa0RPUtbVfFQ==
X-Received: by 2002:a05:600c:3acb:b0:41b:e55c:8e0d with SMTP id
 d11-20020a05600c3acb00b0041be55c8e0dmr991748wms.14.1714233466389; 
 Sat, 27 Apr 2024 08:57:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 e8-20020a05600c4e4800b0041bf7da4200sm994699wmq.33.2024.04.27.08.57.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:57:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/14] exec/cpu: Indent TARGET_PAGE_foo definitions
Date: Sat, 27 Apr 2024 17:57:05 +0200
Message-ID: <20240427155714.53669-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The TARGET_PAGE_foo definitions are defined with multiple
level of #ifdef'ry. Indent it a bit for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e75ec13cd0..eaa59a5cc1 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -139,19 +139,20 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 #ifdef TARGET_PAGE_BITS_VARY
 # include "exec/page-vary.h"
 extern const TargetPageBits target_page;
-#ifdef CONFIG_DEBUG_TCG
-#define TARGET_PAGE_BITS   ({ assert(target_page.decided); target_page.bits; })
-#define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
-                              (target_long)target_page.mask; })
+# ifdef CONFIG_DEBUG_TCG
+#  define TARGET_PAGE_BITS   ({ assert(target_page.decided); \
+                                target_page.bits; })
+#  define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
+                                (target_long)target_page.mask; })
+# else
+#  define TARGET_PAGE_BITS   target_page.bits
+#  define TARGET_PAGE_MASK   ((target_long)target_page.mask)
+# endif
+# define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
 #else
-#define TARGET_PAGE_BITS   target_page.bits
-#define TARGET_PAGE_MASK   ((target_long)target_page.mask)
-#endif
-#define TARGET_PAGE_SIZE   (-(int)TARGET_PAGE_MASK)
-#else
-#define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
-#define TARGET_PAGE_SIZE   (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
+# define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
+# define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
+# define TARGET_PAGE_MASK    ((target_long)-1 << TARGET_PAGE_BITS)
 #endif
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
-- 
2.41.0


