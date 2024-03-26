Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08602CD1288
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp8zh-0003mi-8r; Tue, 26 Mar 2024 11:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zd-0003ie-LF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zb-0001BP-3Y
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4148f00fa66so7143855e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467937; x=1712072737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEpSqRrZid1z1e37NHudEuzz5YNqDapUwXxK6rE0oII=;
 b=SHsd5c8TYX8qJFueCgo0EsI22nDG1ks16kPkbO9T1/B9g1N2Mj8ArG/aW0NnY4wZJa
 udLXqCVPf6a3NpD5a3fu6qMRAwIRnTYXc/GxcQEBDZ4W2IdLiO5HomnW5tlFp51Gsqti
 nuYGliiTC4hg22cU14OdEtbVI/LK8yQiUoWN4tceHRpODRGVblabWhDRldm1si+XoIZA
 67hUU8/Ic3NV96epOcfXrxq8vnYPuI+uF3t6TQNZOp27kfg21K0RybyMEUPj6CQ/SXkE
 ywf2RMbXcUPlXHSgZhMCSETynvmuvxU4KDjo8BtwUUOJTf7XgGEa8kOVoelYPmU/yhLb
 tkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467937; x=1712072737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEpSqRrZid1z1e37NHudEuzz5YNqDapUwXxK6rE0oII=;
 b=uQX0c3fzLn25dWPPLMMMFPi8ehWWn/2gkTTbZr70CQx430tVmQIUrrzws90wR4L+6v
 jEnGLpbBp1irK5qmsKOQm75Gb9yQq8EiEEW724Tlqu5PEFHvBQHclzh9FI0kA4sbOP42
 LkGrmtzJxzj2fDw9hJvrxuJJYzfLbxDgPtzPdxYM7QCO7SC2jU1lWYB9LXYwPfopqja8
 9JwG2ygpXLuLvDshUdTubNXkYjnI+nZV/05o8Gmzpx43hoqvIG4rsEHJnDgPHK1mLstH
 kpuqrgPf5RB1qvTxJBEEgvs+jQ2vy1AiAh6ibRxpJg3lZGuEFOHZW6P8dq3mhVsEL30U
 jAgg==
X-Gm-Message-State: AOJu0Yxzz0yFKYNNyekaeMh12JxqI/zDIWjgZqsefmQNcxYHq2mnQU55
 1TR8nZNcwiwxBwOp6Muvk7iMlx/kzHfYLo4g6AfQYLyahUfhHDG8LUTqWAZaEjr1AKVrX+gGOmI
 W
X-Google-Smtp-Source: AGHT+IFkjv2NMxzzHIUuSQqpDYgVVwKQ7xgi1IJXIspAa6m6oXoQgUjqA8bO/SXIgX2f43o9Otspuw==
X-Received: by 2002:a05:600c:3113:b0:413:ee55:8bba with SMTP id
 g19-20020a05600c311300b00413ee558bbamr9797996wmo.4.1711467937217; 
 Tue, 26 Mar 2024 08:45:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b004147ec48845sm11842490wmo.26.2024.03.26.08.45.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:45:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc@lmichel.fr>, Alistair Francis <alistair.francis@wdc.com>,
 Damien Hedde <damien.hedde@dahe.fr>
Subject: [PULL 05/13] hw/clock: Let clock_set_mul_div() return a boolean value
Date: Tue, 26 Mar 2024 16:44:56 +0100
Message-ID: <20240326154505.8300-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20240325152827.73817-2-philmd@linaro.org>
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


