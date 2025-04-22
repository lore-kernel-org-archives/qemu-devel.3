Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F5DC369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JTD-0006hm-5D; Tue, 22 Apr 2025 15:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSJ-0004Df-P7
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:57 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSH-0007Mi-7z
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so59303145ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350731; x=1745955531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFR9lsWoMXNYRBlDfEvBXzbnQL4knAWePayfKJdKcZo=;
 b=P1WNj+bwGmp8ugxK1jKvHw0yQRI1PsMmNOIHzLfSrHQxPrVKLFMJHnJ9xlW8NR9xBo
 9HFi8WQFDbB3g/NpbEkNknbRUWOzQ0T7rbLl+cSrfGwjR9eQ3Q22ykqKa8ockFtDAsdF
 yqvLpsq+XvRw8gjjYh34OYSsyUkWhKzmk4LQp5ZHEUVj3pEcvkD4yeu1WSc4Z19hXZAt
 SurUNqa+/3L5NmHmjpUFlrAPKaFiXUd19Z9d4N5jZdMjWkJCzqOfIF70zY3KWnkeiwRE
 DAGzXtW8bMBYY8e00NONB9oNxtchtcoaNeZ/dv8lsh6tKnkEAJTfK09pV6XmQFxZbGhY
 WSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350731; x=1745955531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NFR9lsWoMXNYRBlDfEvBXzbnQL4knAWePayfKJdKcZo=;
 b=lCscyYEnk9aw4lWncIttcLOiQEjjr1urAUFBZM/KcV1dVV8PPIxUvL8/Q4tMCTlSj7
 nAk5SVw8+6u3Scl87bCrION5mE3LFGifN/no/EOzdjl/uuvJ5nJA1P0ekU8zb+a5W/zX
 PbkRCFVbGs/+xM/MtxiupVPFTnHLom8zoynXqo+E7TMoZMWp3xUQyzoB82tZ7ZsqJWOR
 KL1e6zY2VoFl9rBFsuk6tMoaLjLeqSZUebkf20OvoRGeo6eiEpjqMhDVuQbQHjnO2Cfn
 F+djx4OurtRqnMwe7KkQxq6nd3DK2X5sodJ4o9L4SvWUXnSh8wAndAMToCAiWpk+WuD7
 FE5Q==
X-Gm-Message-State: AOJu0Yzx7n1LifGggWP2lv3L5l1Ypr3LkXtXjitd15RmgAoJvZGfaPjF
 6anZ50rGLVlMoAN1rM5rPf/gLSwFxjqB6AwEgfvHkoZndkVN86HAvVL9Ef5fZ0z8bzxD2Cdf7Zo
 b
X-Gm-Gg: ASbGnctSYx7yBktnszcOR0OZEF0ByFr3A1RIL5x39TDYLxWvZDwKTYTtYOFyHOQ0tkj
 PWzyOtbNj7JNRAb1N5HRMQ6MwcTQyl+yKaO+rvAXWkoQ/4jwDOyvLPwKv1Sjyjl/hFdGo9AYrj+
 HLjner1zjMN7+RHaZ9cIfTwMMR2gNKl+Qb5cRN7roMC8huhL0xeRb9uDnGFIDGU7SxbJYyWY7rN
 BbD1ExPWA4F21gpn+DmBq1ydX09MehwV02MKfagmgQ09A9XlaAuh6gqaznRaE9xtr1rO8hH0UCw
 VfHIE/P+Lf4DBtr7Kn6/+Fx9goZDjxrsKm2hb+60r6hAKJjVc37CoyoHsri633ZDzoknUCJdWDA
 =
X-Google-Smtp-Source: AGHT+IGKhPtN38jryYnImHi6oAruAJqqx6NzT3JhvY/HSUk2qIyahtf81egAcj939wy31z44SHFrzw==
X-Received: by 2002:a17:902:e544:b0:216:2bd7:1c2f with SMTP id
 d9443c01a7336-22c5359c356mr202602155ad.18.1745350731528; 
 Tue, 22 Apr 2025 12:38:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 137/147] tcg: Have tcg_req_mo() use
 TCGCPUOps::guest_default_memory_order
Date: Tue, 22 Apr 2025 12:28:06 -0700
Message-ID: <20250422192819.302784-138-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

In order to use TCG with multiple targets, replace the
compile time use of TCG_GUEST_DEFAULT_MO by a runtime access
to TCGCPUOps::guest_default_memory_order via CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 23aac39b57..f5a3fd7e40 100644
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
2.43.0


