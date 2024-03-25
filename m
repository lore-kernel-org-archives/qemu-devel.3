Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F02C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romFc-0002jc-IE; Mon, 25 Mar 2024 11:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1romFb-0002j0-3y
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:28:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1romFZ-0000Eu-Jx
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:28:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33ec7e38b84so3217101f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711380515; x=1711985315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGixc8/beFlJTVTR97uUt5Nz0tk7RL3jZppYJHNPExI=;
 b=zUO5lcGH+H3miZ8LyQYp7HMTlvl8rHp7dhA2m+VJQ8b94V+Tx8h3L7CTecgVGSgycO
 kOUUwLwMIjJSRY2BX7uOB4Vh1SgbeB+gN6LM2k0adBB+sNQ/Ih0Gz7Ul+G/eQW5nSLjU
 1Yujyp0UrA5TpOc1dpajKHuXsARD58aPE0hJLULpZY8MWAqLp9i7N8UWQ/ve7p5PGTut
 w6s5YxZ6rkN5V8R7bH9GK074wVZWLbpIOcLyEHgNlKlWcXAMajKp/xlsQO4Y/neT9Zp0
 Lgtmh5zebll45NwsGxFmRhPEp0GCb3z/xYR4YV1pFgwV5hjlnW/30CzJkhpfyHEKzzxN
 dVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711380515; x=1711985315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGixc8/beFlJTVTR97uUt5Nz0tk7RL3jZppYJHNPExI=;
 b=fP6SpaMsCD6YNJMwp8HeugZPQJ22lWMAfUHUotJ8ByJ2HkCuGGl2Ji7vA0U07ZlqtQ
 DF5W+6kj0WfFY65NImMAfKQ0hPzDlJSaNIk61t2wJQGrRhyVJk5WEtVqfHew6QgCGtsf
 pwtpLM5Xlkpx5xJ6+riWayGiAhFCjSrcZRzoXBS+hCokIKW2qGP0Pzu7NHZtWh/YM9hl
 hqaX8aBplPo9Sbl51Q3APDwket1CnWnqXiB+QgprKJp9ix5XjXUgizlrfkOLF6mmFaWI
 6JSC0xdLKcqgTdBN4V4f5sLDn56WcBI2g1MlSd/ihoxHvGOXLHYdxsy6dmTgN3xh7snN
 X5wg==
X-Gm-Message-State: AOJu0YwwAmIMQCtwFl/xW/lopleCCzz06eMS6wdqxqwHK/qCgFp5zvJu
 0XyUwjNFOf+RW4AbnDihRnQfJaDDadc7n7SSlDbpe3bJ5w+KbvZnQ7gVNfQk8jFOZAO09NBEDa7
 3Gig=
X-Google-Smtp-Source: AGHT+IHowE13s+6qgHHIByS+gTCvsxd/g8aCKZXu1VsMhiSdpmbWkevtqlaELc1aeektRDq/jNK9zw==
X-Received: by 2002:a5d:52c6:0:b0:33e:b1e7:742a with SMTP id
 r6-20020a5d52c6000000b0033eb1e7742amr3826539wrv.10.1711380515517; 
 Mon, 25 Mar 2024 08:28:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 df10-20020a5d5b8a000000b0033e756ed840sm9759377wrb.47.2024.03.25.08.28.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 08:28:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v3 1/3] hw/clock: Let clock_set_mul_div() return a
 boolean value
Date: Mon, 25 Mar 2024 16:28:24 +0100
Message-ID: <20240325152827.73817-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325152827.73817-1-philmd@linaro.org>
References: <20240325152827.73817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Let clock_set_mul_div() return a boolean value whether the
clock has been updated or not, similarly to clock_set().

Return early when clock_set_mul_div() is called with
same mul/div values the clock has.

Acked-by: Luc Michel <luc@lmichel.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/clocks.rst | 4 ++++
 include/hw/clock.h    | 4 +++-
 hw/core/clock.c       | 8 +++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index c4d14bde04..b2d1148cdb 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -279,6 +279,10 @@ You can change the multiplier and divider of a clock at runtime,
 so you can use this to model clock controller devices which
 have guest-programmable frequency multipliers or dividers.
 
+Similary to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
+the clock state was modified; that is, if the multiplier or the diviser
+or both were changed by the call.
+
 Note that ``clock_set_mul_div()`` does not automatically call
 ``clock_propagate()``. If you make a runtime change to the
 multiplier or divider you must call clock_propagate() yourself.
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


