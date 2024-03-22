Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F5EC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 15:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhHp-0001AJ-8A; Fri, 22 Mar 2024 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhHk-00017o-4z
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:58:24 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhHi-0005cE-8P
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:58:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41477e77151so10493935e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711123100; x=1711727900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TU+ztvKvf1LMC2G6CQqJztGFsXq/Nhw2cglRUoGn74=;
 b=IRj4kd+GPrthWtyOnlnyX43CyFb4Te1FWMpz+4OyGJqkZnyFynoLvD/46mcWJ2E25y
 UXM3+3XM69RmdSLX5FyOJ+xmEFbJrt6bD4iR4KqYYp2UERTwPuwNwZXuQO5i5GULOc4M
 ocTeNcnLEH45R0NTTTd6CxTQEFlEDsXMEP82u6aK0Yt1MH/GZlcsl5m7YxhatXUf5rJi
 fU1FpqCeLSfB61gU4vuNqCX6P39HejAxA3KuUCpwhW2ztUw6KX39gIpu1xizd7YKxTlA
 HdIVUAAKlLdkNqfbCI9MthZ4putL6Ww3FvJiE1E047gfypzs1XiIZe9ZwojBNAhYiYaJ
 wYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711123100; x=1711727900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TU+ztvKvf1LMC2G6CQqJztGFsXq/Nhw2cglRUoGn74=;
 b=h0YQFs3udpzbDZjpwK3sNQtUHxYV924oxXQUsRBURG0SR3NBhojG5FH2ZfU7ob9w8q
 Fq4GBZ8YWTxW1Qr/7QBN+OhhFWeAIern6lJCePJ16g2bR3MzfwbUpn05Gfiwsv93w+qv
 X0X9xPYb9NJ1/vetDifxkQEI9SvaTrq4PYTWqogkVcnOvjlE7918dkHco2UQv9RV8tjs
 F6ECBmopDRZOXqlVk+Rgw8RHmW2g/tktQlN/l+lwMhnKVUKBWU+T3QqnO2tRUA9Fh2b+
 0jPfvjcSNOaSFdAHyfjn8kU2pQeTpgNGBLvHah+I8wTcwmnmZ5wH2fuMyM/ZhPqdtv+t
 eLqg==
X-Gm-Message-State: AOJu0YySUFCUHTnRt6TibqVuQ8TBd0WoFZXXgthN+5FtKF3PEFabBVIJ
 qMwz4B/z6OWv9xm6RVDbvxFc8G/hYRBtR2CSKpRPOmDazJ/pcv6FFrfOtZiMRfYd3GiPouhdab/
 5
X-Google-Smtp-Source: AGHT+IFBwoa0F4DIGhMdnfgG4ZL0wD0js7Yzi82TYLRbo+BUNVB6BylmcSSkRnm/710W4SQfaw+BMA==
X-Received: by 2002:a05:6000:884:b0:33d:4966:fa8f with SMTP id
 cs4-20020a056000088400b0033d4966fa8fmr1957943wrb.46.1711123099991; 
 Fri, 22 Mar 2024 08:58:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d43c9000000b0033ec9007bacsm2331559wrr.20.2024.03.22.08.58.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Mar 2024 08:58:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc@lmichel.fr>, Luc Michel <luc.michel@amd.com>,
 Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 1/2] hw/clock: Let clock_set_mul_div() return boolean
 value
Date: Fri, 22 Mar 2024 16:58:09 +0100
Message-ID: <20240322155810.5733-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240322155810.5733-1-philmd@linaro.org>
References: <20240322155810.5733-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Let clock_set_mul_div() return a boolean value whether the
clock has been updated or not, similarly to clock_set().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/clock.h | 4 +++-
 hw/core/clock.c    | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index bb12117f67..eb58599131 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -357,6 +357,8 @@ char *clock_display_freq(Clock *clk);
  * @multiplier: multiplier value
  * @divider: divider value
  *
+ * @return: true if the clock is changed.
+ *
  * By default, a Clock's children will all run with the same period
  * as their parent. This function allows you to adjust the multiplier
  * and divider used to derive the child clock frequency.
@@ -374,6 +376,6 @@ char *clock_display_freq(Clock *clk);
  * Note that this function does not call clock_propagate(); the
  * caller should do that if necessary.
  */
-void clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider);
+bool clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider);
 
 #endif /* QEMU_HW_CLOCK_H */
diff --git a/hw/core/clock.c b/hw/core/clock.c
index d82e44cd1a..a19c7db7df 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -143,14 +143,20 @@ char *clock_display_freq(Clock *clk)
     return freq_to_str(clock_get_hz(clk));
 }
 
-void clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider)
+bool clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider)
 {
     assert(divider != 0);
 
+    if (clk->multiplier == multiplier && clk->divider == divider) {
+        return false;
+    }
+
     trace_clock_set_mul_div(CLOCK_PATH(clk), clk->multiplier, multiplier,
                             clk->divider, divider);
     clk->multiplier = multiplier;
     clk->divider = divider;
+
+    return true;
 }
 
 static void clock_initfn(Object *obj)
-- 
2.41.0


