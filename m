Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7260C36018
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u169x-0000hj-Ny; Sat, 05 Apr 2025 12:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169s-0000gx-K0
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169q-0005Gh-L9
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso19558385e9.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869649; x=1744474449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtZrrkt2ntmoiQ4mVP99KUX/c8Ppft+k9zep++rss8s=;
 b=I46AHA4SouzmJg5Q5XokUgff3TaWwwUm1mtvrksYlf2Hb+g+WG00YVgRtigmykKK4a
 xkoZsXk0oEZfjvaZsKOLVtUuO4k7nQN8YlLKJdpZE7rgLDTyQitJJgpMNEy5nQAu158g
 LqBIwnLDCftPYXKCOyWaoHlGHLH68x4xuD8g0gDD4l6ieLYvgx7zUi6V6lCjk1i9BQ5H
 udUkxNYww+u28zc5uGDWUnAb90v0IVucom9uT7uXV3qY3cs+btffV+B3TZEp5N2xFJwQ
 /PbM2x1y2pMaDMBC/k9IfbUx7zgdgxd1SeinOCAP6lFae9/EvifKVtgNnXxZbrTool5v
 7vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869649; x=1744474449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtZrrkt2ntmoiQ4mVP99KUX/c8Ppft+k9zep++rss8s=;
 b=D3oR9l8Wh05eN1uausu7Pd5QhI1jLXYhh7iEIXdvUOWeuxNw7CE2ZOyGAJ96YesAJQ
 TLuC5RzfdYxz4Q43JWeVM+Zx4AKa6aEq6LW/nmJF/3lQy9K3shCx3Hg3ojJjVX6Y5Zw8
 kNvjNn0BN04OBk1DlQsMuc7tVdP4hsipVmwk3RHvIbIii4gPAA0vC9iBSLQFYy/GLQPD
 Jbdiz+U1qwSfZoCurCqMwCEtiVyFJeLK9+0t7/otOhqgIzLuKVjB1mpwRcKiXsHRUsWc
 i1iAg/Z6BSMG3GLMBVQ6LihrKz7q49Kt+P5ixmXWqSFjE66HOg1IN29mBLmXstSZHLjx
 Eafw==
X-Gm-Message-State: AOJu0YxMLOiWQ5Z5LfS2St1OPPUz6ATwTmTcHYMmxzwErXt8o+ZnSqU9
 PhyjcTG8mdQ/H3sfWqMRcHBca9HnpSzGKA5XLhvBl0dXxxvY6YiF6U5+yMAe+EDQQcW7IkE5+tb
 L
X-Gm-Gg: ASbGncs4Bip8ykZ+Y1GI6eLmfconuhVB+GAVWbKESWasiwbc31MMta1tQ/3bQI3yAkG
 Jz9uG+ALZqzRuz2qReC9yHKBwcan4bLemtVR4fCEHybuL4Oud8YAFxcR4QDe/3NADR/YkfQgmTI
 NmGon4en1LyMqcAvwfF/iDX2kWqUiufciYBnIrOfzL7/rWkw9G+2L0hbIgXRXVBgWiIu49Mi9Ft
 j0t7t7RYCOy0uVV4HtAExLPMsL+ECHW0hPsCJQMd+4qfwB3tOpM74obFrfSbLS+wkqVCRe3jc9R
 YOLNKYLHmISLdyvf0SpjBHTaq+aT19PbL6y9qCapwJt0y95LSWDm6ZJNYSQpbQ1ZC6COjiuefOV
 BswJwDxQG1hM1byjXzYDdFc0G
X-Google-Smtp-Source: AGHT+IGRxjjryaIQqVRYRdbKj/EpsAJKimNz9sl47phK88XbFx96DIzwGFO4T0fcTj0m+BFwieolhg==
X-Received: by 2002:a05:600c:35d6:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-43ecf85db98mr77995345e9.10.1743869648798; 
 Sat, 05 Apr 2025 09:14:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34be2ffsm76593335e9.22.2025.04.05.09.14.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:14:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 10/16] tcg: Have tcg_req_mo() use
 TCGCPUOps::guest_default_memory_order
Date: Sat,  5 Apr 2025 18:13:14 +0200
Message-ID: <20250405161320.76854-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

In order to use TCG with multiple targets, replace the
compile time use of TCG_GUEST_DEFAULT_MO by a runtime access
to TCGCPUOps::guest_default_memory_order via CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 23aac39b572..f5a3fd7e402 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -46,16 +46,15 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 
 /**
  * tcg_req_mo:
+ * @guest_mo: Guest default memory order
  * @type: TCGBar
  *
  * Filter @type to the barrier that is required for the guest
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
- *
- * This is a macro so that it's constant even without optimization.
  */
-#define tcg_req_mo(type) \
-    ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
+#define tcg_req_mo(guest_mo, type) \
+    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
 
 /**
  * cpu_req_mo:
@@ -67,7 +66,7 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  */
 #define cpu_req_mo(cpu, type)     \
     do {                          \
-        if (tcg_req_mo(type)) {   \
+        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
             smp_mb();             \
         }                         \
     } while (0)
-- 
2.47.1


