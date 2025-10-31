Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E923CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwUi-0001Pf-PW; Fri, 31 Oct 2025 17:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwUe-0001K0-4e
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:17:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwUY-000233-Dx
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:17:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso29540895e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945416; x=1762550216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BJHpf/Ud1QOlRd/7U6e5GwuRJK2wrW22e/TCzP2i1Oo=;
 b=Lyq9MOqFv0boQGrq8z3i76OobUlrwhYKGWgTMCkVo/ZBwtataDKuynhewhOzPEcykd
 8lND/XbnEM3kZi2I1JUDgYtOUZkGQLIUDucPdRBNlScU4d0p7aAUsZko9cq56IqQ7vQG
 4XdbEZrtp0N0msyS2JKynzriSxtZGGKWa8KasDl8sZWy03Jmg7wHqsWXV0ECXxAcYj3+
 3y+EyNcPtbYHAmQUKiW++Yl6N7kua6EvrTWRBFi2uL8BV2o8LDaejmIl8EMqILVAev/9
 7VJGLIQd1OUT9SlW69nXHMzIvulIClu7sBWmCXuidDCs35+5htEQQgWXDO6Mv3mUjkzZ
 YFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945416; x=1762550216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJHpf/Ud1QOlRd/7U6e5GwuRJK2wrW22e/TCzP2i1Oo=;
 b=bJaR+aJNH6+YUxL4m0kXHgxldKTS84lbRvnOGyHb/76Bo86AgNHRBuo7+RbndSgBUx
 oG4WrPEaTi7RfBWJ2zInqbiyqedmDSXJueeqzyOte3YVt4wCC/LC5mTsVmLcv1deUGs/
 IqHiiRJJcvYhqwhKCUTD41A7d3Z5+heL+MKxKNzElx1Rf7ghft95Xr0JU9TidPDpB8dJ
 GheW2JRrpfspXDQ/I4D4GMKqTsOtimeHNI1NULcYNDcwc6rbaePEcZD1N4au5YRmDdDC
 +9VNZLX9RVr7fbQGODCGSGU7Eh2cXB9RUJP0fpcVAk+HB+Uao9s9Xvu56WMt0ztV4eU2
 FdMw==
X-Gm-Message-State: AOJu0Yywx8DL7AxxoNTaACCLuxdCtLArrDQRXiNl5PA30oUmT25qRG1h
 o0bFHdRbnCaUvM0zj3wZbBsUfxZ7b4FNcmhxXha7MaMZyxqt1mE0dvWvZwgwPZ/o3vijrNLepi0
 3uJVAdm8ejw==
X-Gm-Gg: ASbGncua+2vk83LCn2CQNUYPmdfMjVjhlURHBcoD/yrb1B/vHdzqz9jeGUMFwHqmTuh
 LPgU5hn53/o0UbfOLzMSvRU9QXbSTzzTZOnTEulxSs6iUkwGwkKkMRcaLCr7bgzhy0egq6+WRH3
 99FhtZIlUf2HMzpNXCSy0Ud6yZPiKdgcr/yEaisr0A+t3bxDQcjnEl9t4xTFoKxyrQZQnYnDOuk
 0Cbfm78UmdjjicIutZnUB0+dbU6jDbCKPwbDNgCbDT+H1ucYuGb9wiTAuNRDUPx0soygxkQY3iE
 n6PuYIPytlFwKUuosLlkxnfPfdDoaTgNtRRxm3epby8fH8t3XYDWiRYF8h0B9HwCuYvQLbZbFoT
 mGKkNFYkWY3EevxREwisteW/rKx+RvcHS2Lti8gug0BjyoSytwVTd/2RLMmUy5M5XabusSOaBSq
 juapMXHzc7KT0zxOW1iMvJjP3loNDtKxyAy3ElL46Xv41TheaXd6tWtDvxjui3EPB0
X-Google-Smtp-Source: AGHT+IFOmZX78ffQkn1JNO9R2lfzRfwKWyMaf5tybQ2657Fe3HyF1BJxuEjM/LcU92/0s93mQaiz7A==
X-Received: by 2002:a05:600c:4e05:b0:46e:3550:9390 with SMTP id
 5b1f17b1804b1-477308b60camr41389605e9.20.1761945416555; 
 Fri, 31 Oct 2025 14:16:56 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1406a45sm5298498f8f.47.2025.10.31.14.16.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 14:16:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] accel/tcg: Use cpu_is_stopped() helper to access
 CPUState::stopped
Date: Fri, 31 Oct 2025 22:15:12 +0100
Message-ID: <20251031211518.38503-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031211518.38503-1-philmd@linaro.org>
References: <20251031211518.38503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250925025520.71805-5-philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 2fb46439971..f84342e0449 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -197,7 +197,7 @@ static void *rr_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* wait for initial kick-off after machine start */
-    while (first_cpu->stopped) {
+    while (cpu_is_stopped(first_cpu)) {
         qemu_cond_wait_bql(first_cpu->halt_cond);
 
         /* process any pending work */
-- 
2.51.0


