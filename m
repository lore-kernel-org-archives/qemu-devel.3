Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D253CC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSq-0005N9-C3; Tue, 22 Apr 2025 15:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSG-00048N-Gw
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:52 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSE-0007M6-BF
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2243803b776so87144335ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350728; x=1745955528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQncdcCBTAzD3tdjUYfUMSnmVN4uvUMzzqpT196vY4c=;
 b=dRCmGBwll1XObaBKqySKvhYxm/iKdqmRXz8pI7ra612AkbVbTY896TmN5XlEvrNiqO
 zd1wuGZhkYHe47Qb7IlUS8+1SxLB5vzxVcVkkEVYwhl+VWlktUim0GX+fUK1ZngAes6X
 KC07WMhr+O6EY3+nHm1GJIafH3N5W19WXPrBDi8+PYgp20d0eedviRsVvHohhhvHBudI
 Q61FRCtBAX3ewsJ1RmUf9VaDaZ4tJ5l9d646rznhd16v8M+0bogyGW46PgzaNsrrEbzI
 BMl3o89BT2FA3afTci6AlfOgYnhIEs0ENdk2W4Tk6Z03roSNXx2NYVXKvIbyTWS7qeTe
 F/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350728; x=1745955528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQncdcCBTAzD3tdjUYfUMSnmVN4uvUMzzqpT196vY4c=;
 b=MEZlmg8pjrTvbyM2Om7P5MWVS8Xst66GVz5WiXwn4kOroTV4Go4f6OOaPYLiUF2M9w
 Z9fhuRVPBOP86QJd/M/eaitmzQRVT7Cj6H6xczYzxtIIbicHoJc7qXllQadnilpSzukc
 b9VMEUdPVJPAumdpkJXJ3ZBogXrDzsRYRjzwIaVATjmrtF37B1XHiyF3A2SQCES1t07G
 mH11R0D8ARiuKIpezXoBuCBse7An1MyrIsC+e675GA90jz8BBlO4TZ5jc9uP6inSgj89
 bbHE07xqCBhylhTa+P5S1an8pUAwCk/ZXfAFKqxUU7MmqMRCHnCIb3pubswqjSu54xOo
 +bBg==
X-Gm-Message-State: AOJu0Yx9TCp84vOsJWcYPtqFRx12w+ZmxXxaxjK2+B6FxhqGwGLRaEbp
 8qJlTafx7VqlLEVhtwKrfQzs2ovpTn8vD2gQggtJmT0RlICmS1UipqD3ChLOsJlOAOCytPWeksP
 p
X-Gm-Gg: ASbGncvTEmllVhPoWSsYaAowIW7lokMyh1HFbmE5phZWs/S6OS8KQqrGwenlRwZNCZL
 aeWbbNp59ChUArzUOdCGS3k0WUjQAsDoMQD0ojErrJpq0rXJb1adPf1UBz6B4xzIJSz3+2MHdmc
 v1emVT2w2bysQA15q7OuRhCOYSWP4K0ZqswtUjx7qu3Hzw/lcEE/XyTzwWSPdCy8t0DvsfNknMg
 orWqR5NDPrva1CiOuyWvdg9f+sQzBgA5SfF/M6g+nFug+DCCy+dx54EiYkpGujdau/XWRSAYoXN
 PbUr6Zt+hMnFZiw1usHISTCBpAurc2xXLK+Hp6yt24oye6hOxZB+F9havrMHWHGYG5sJJjEqfps
 =
X-Google-Smtp-Source: AGHT+IEhNtJynkbCfBhrqh5s1DgEZssBHHajXaM+XiGoInegDVsDyioR37bXfhKn3mHQEM/7Em71Sw==
X-Received: by 2002:a17:903:2306:b0:223:517a:d2a3 with SMTP id
 d9443c01a7336-22c535a5567mr258099045ad.17.1745350728582; 
 Tue, 22 Apr 2025 12:38:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 133/147] tcg: Simplify tcg_req_mo() macro
Date: Tue, 22 Apr 2025 12:28:02 -0700
Message-ID: <20250422192819.302784-134-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Now that TCG_GUEST_DEFAULT_MO is always defined,
simplify the tcg_req_mo() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h | 9 +--------
 accel/tcg/tcg-all.c         | 3 ---
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 05abaeb8e0..1a46a7c87d 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -52,17 +52,10 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
  *
- * If TCG_GUEST_DEFAULT_MO is not defined, assume that the
- * guest requires strict ordering.
- *
  * This is a macro so that it's constant even without optimization.
  */
-#ifdef TCG_GUEST_DEFAULT_MO
-# define tcg_req_mo(type) \
+#define tcg_req_mo(type) \
     ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
-#else
-# define tcg_req_mo(type) ((type) & ~TCG_TARGET_DEFAULT_MO)
-#endif
 
 /**
  * cpu_req_mo:
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7a5b810b88..a5a1fd6a11 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -77,9 +77,6 @@ static bool default_mttcg_enabled(void)
         return false;
     }
 #ifdef TARGET_SUPPORTS_MTTCG
-# ifndef TCG_GUEST_DEFAULT_MO
-#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
-# endif
     return true;
 #else
     return false;
-- 
2.43.0


