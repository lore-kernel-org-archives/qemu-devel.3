Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE025CA5FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxF-0007XR-Hx; Sun, 18 Jan 2026 17:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxE-0007RT-9e
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:04 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxC-0001b1-MX
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:03 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so24440205ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774141; x=1769378941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7SIDQmcUGJxe8HENT1y7sz0lq6rggxli56KTnwm55A=;
 b=B14pfnRn53v93aVc5KR3HzjS+3K6Zgfvb1ClgMNGc7kUoax2X5+RIffADFKUiuFBaT
 D3787ejC6pkJl00LPsdNUgavr+VcTxeBKdslzE2PoVVQpi9Mf+l9beCovx6sImNVA5SJ
 ykdaeqeDZbCisYjWvrxrIvKTfLmNlz3GhIorpMYWKRBhMK1h7X7tprxiOL+r5gKtrL/e
 y+f7UHwb8VK+0zHIacQJEdo+kHsPo9z03+Bv5LS/VUL7lKk/ZreIUsiBDkixV9ptLN7O
 RNCw8RtoLFOd7V9S9BL5ShvRjfR9DITDk2vO1JIQ5uN1nqKF4ZRQAKYg0Z1+UcnuwYuT
 EEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774141; x=1769378941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q7SIDQmcUGJxe8HENT1y7sz0lq6rggxli56KTnwm55A=;
 b=ZoewKnMo/O2YQty9aLycqhImrrOZSvlB23KHhMiZK9mr+YLynDdTsPXVpcASM1fNJK
 ifss6RHqG3B3GGgm2FMV+NZfv+wXtwkjb2PLlb/Dll6ZrcLYYx0y7wNJ51iuPTvY5eHj
 K7RkyXn1tQB2y5N7tym6U/Kg2/8rl8wBzrbE+yb7cjxFvxg0gEV1MjnQdVLCoaDvwcuq
 85v1l7xXiWMMBu0PlWJMrBBym2lJ3fdMVoeTAhIapfEo6F8vIJl3Ih2mivhw9LmeiZ7P
 0tw4Y/wwZJ2VaD6+vbsul2+l/BgqaIIzK9NaGBQZ6B/jqa2PQtAaXRZCMc8ythvpyQyH
 GP4g==
X-Gm-Message-State: AOJu0YxQfsunkG6eMUEIqJ6mJxQQVqKaQMniItk49nnM09ClOmbHg5fc
 GxxgmlS9ziDrFNO5etqvuGAFpl5OeyEjcolR7+jLBVrqpQrzzRq3UkZWtgOm9eoVdix7QxxZOuM
 x0zgE8dYLJg==
X-Gm-Gg: AY/fxX4CMKGhgec9sQG6rX/+EpwlOib1CmXZ8NF4d8Z7+N0bo+lli2T9Wr1GcpmAsG9
 dTBg48MTkpo4cvrUtXFtU6Sv7Lysr7uQaw6zysayDB7VDnlzjDyNacH7wnYEjMvG2b3a8+Ronih
 qH1JdDUnWqx+aLP/8AeJNAKBkKYqiN+96UUjkvu2AKJ7GV6JegAZRSUirNG5ZY3q0uu6NkxBvJ5
 ydN2Yz9/pEcsSyk2fbc709Reppnznql6ISK3oVJ7UTrYn+CRXfTpOIqQOnw9RZm/KzY/7ctpAbx
 OqnuFw8md0zfcOdr7+l0oLpK9L3al5OA7/SjmsydYC5Ij/qUBjU6BiaZf47tuyozYdMvIKU//XT
 4VXzCN9a4oLdTbuke/iXJ4odMkcuCaRWwPBAT7uSmwupHwKz1n8XiLi2GRiTefUOcGzEQUL5+eH
 3JBlT6Yco9J40SQ6nrTg==
X-Received: by 2002:a17:902:e94d:b0:29f:2b9:6cca with SMTP id
 d9443c01a7336-2a7176cdb07mr96721965ad.44.1768774140881; 
 Sun, 18 Jan 2026 14:09:00 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 41/54] accel/tcg: Drop CONFIG_ATOMIC64 test from translator.c
Date: Mon, 19 Jan 2026 09:04:01 +1100
Message-ID: <20260118220414.8177-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 034f2f359e..f3eddcbb2e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -352,15 +352,13 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
             return true;
         }
         break;
-#ifdef CONFIG_ATOMIC64
     case 8:
         if (QEMU_IS_ALIGNED(pc, 8)) {
-            uint64_t t = qatomic_read__nocheck((uint64_t *)host);
+            uint64_t t = qatomic_read((uint64_t *)host);
             stq_he_p(dest, t);
             return true;
         }
         break;
-#endif
     }
     /* Unaligned or partial read from the second page is not atomic. */
     memcpy(dest, host, len);
-- 
2.43.0


