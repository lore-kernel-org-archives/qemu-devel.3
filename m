Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9690C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHbx-0003u3-3b; Thu, 03 Jul 2025 06:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbs-0003jN-0t
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbq-0000jJ-6A
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453643020bdso68396655e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540163; x=1752144963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMVCQTvVGe/Hz2DEmM07zNOYeNDGY8/7Dwwnom0rM8Q=;
 b=ad9paKDBomAiWjpGtq6QoKimix6suRx1+sZhiqdGG1Dcj5d1eGyLQ9V+UpEEjhupH1
 9pTEqPgOjVmAW6kIDjiFt0S1FdO2NTVGB/RufNtsvp3DLUEbmHm9U7/3B/AR+bBn/qTH
 T6Ra/JQU/xQTqz0j1tkmTa4Qiy7m9JQ79cVWlHrXHfIZrtQ+mhDrfu+UeioxbVEdtS5e
 7dEBE87mXwg3/aC9AAv2eiyRMnGAAoGT/aKOvNI6CAPVhAWFGzisruNK0evPTts8urkL
 5yqHFM/7QVU2ni2gvTNE4nKWTy99Sw+8zBIKEpHtHnR+OjNb9whM9APKMAA52hEif3wK
 a2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540163; x=1752144963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMVCQTvVGe/Hz2DEmM07zNOYeNDGY8/7Dwwnom0rM8Q=;
 b=keW0KpYK1PoeDGnGHv3M8BWqRZsSdUAKLpKw/bfgOotHfanFASokhaTv7hg9wC5JvL
 dX+GHZ+soF3nktJwksNEax5fq99yFgSa20yUt/3s6VYCjc14Tr/NYbglaWVJhCIMy1b5
 KAMZob3H321+lT/CVveZfMVbCSF6i3RcYaKxdiBRUxpZN8cfrGzVQt0e56xf4fUuPG2C
 RDDazP35I6KRtJoPnyR6jq5jmJJm6rV+/XNhDGFCes7xF3iFihC5yfqnkKVq3h0xaoO7
 unMJ9iCsPlqZr+gTvrqtBXHVM4T+rQkIpgZ/Yo6mHgjuuJKUzyTulkrWVxQ+rnbV5rkn
 3pdQ==
X-Gm-Message-State: AOJu0YyT2TjyxtXYGn5X3uljRkrCztYeB6zOKGYSnryqwmvSgC8BMc37
 v1FGBnGCa4whLBq41lOglsC7eh2rbHwEyUy1AYOPMZkE36LZRYXx5ZRN1Bou4CTNIyQC0FCdypq
 KC2BjEQs=
X-Gm-Gg: ASbGncsPC2j0ROYgz13LxBGhw+i9pxW13jyuad0D0HAtUxgbx9NvimBAZu+oQTK1gzy
 b3JxcS7XSatscNvWHzUEdGRKdVEuV+CVksEQmvy0yu/MbGFqE0hxFlxrFCYUNKw3kWlkEq+xz+W
 UjVioIlb7j8UPSl3aJOxH8fEe+JqCqe79LaSSAnckLJZiKuBcnR/Kt5aIduQC8gFPFWhWN6bOKj
 z3lkhVgRx8IsEbt1TnPGW0HfRCHxI7tn9DZ7aOCLBi7tOsNig2Cw8657Phr6IZGS41+OaXITzcg
 Y8uug3/RLp0kp38aQwpTGxeWZPY19jAWJOdndJ2/oJA2YXOH3hOGvF2U1Z1qWV3iRFnmoRFN6dD
 av6MgsGK52vyDtU0F1Ftw3g==
X-Google-Smtp-Source: AGHT+IHRXWokL5MOT0i7s0s1AgeUsTebRY+EJxnCZglAAZYqkG9epS9CkFuuRnILEdA3VJz5woDksg==
X-Received: by 2002:a05:600c:3f05:b0:451:e394:8920 with SMTP id
 5b1f17b1804b1-454a372e226mr57162345e9.27.1751540163340; 
 Thu, 03 Jul 2025 03:56:03 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9969a8bsm23455185e9.2.2025.07.03.03.56.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:56:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 04/69] system/cpus: Assert interrupt handling is done with
 BQL locked
Date: Thu,  3 Jul 2025 12:54:30 +0200
Message-ID: <20250703105540.67664-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
---
 accel/tcg/tcg-accel-ops.c | 2 --
 system/cpus.c             | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index b24d6a75625..6116644d1c0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -93,8 +93,6 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 /* mask must never be zero, except for A20 change call */
 void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
-    g_assert(bql_locked());
-
     cpu->interrupt_request |= mask;
 
     /*
diff --git a/system/cpus.c b/system/cpus.c
index d16b0dff989..a43e0e4e796 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -265,6 +265,8 @@ static void generic_handle_interrupt(CPUState *cpu, int mask)
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
+    g_assert(bql_locked());
+
     if (cpus_accel->handle_interrupt) {
         cpus_accel->handle_interrupt(cpu, mask);
     } else {
-- 
2.49.0


