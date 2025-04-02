Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0113C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05I7-0001PR-MH; Wed, 02 Apr 2025 17:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05I4-00019m-Dd
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05I2-0007Ez-Mx
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso944015e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627985; x=1744232785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZtZrrkt2ntmoiQ4mVP99KUX/c8Ppft+k9zep++rss8s=;
 b=aJsq6jqs1i6n/hDGUkv+3lv45BCRqlNLME4SAWIgyUByX2Uz8YZtejOqW7LTgq/KgO
 xGt+Nh71+nhHgm4Qu+4X7lyQcR3M0CQenp4mdDlqhu4IWcfd8VleC+mJetL+ZuEDNR2u
 jPRDP2/MeScY4ZkxfiXZyiCvywVy2jaXpa8pzfKHjaaPGvWXC7tmqrS7h1J0PuL/txxd
 qxdOu36+AW9RysZJt6+0kT+38uh+0IZGDCRO5O9+85LqCYuyOGX4oJeHG+UJSC5Z1+mt
 J4ZITF3rD0WcalhP90Y8Q7bSPSWFe5Den/Q1qq5Ip3ZSjVOyD50bh9E8DCo72xxtbNEx
 GC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627985; x=1744232785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtZrrkt2ntmoiQ4mVP99KUX/c8Ppft+k9zep++rss8s=;
 b=ICBK9RFg+u60b/Y26Xy4nN89tdvIXBEX4LkHLMMex5J6JGJ5G/Dfo4wpz8cFpEY7sD
 2Nf/q9k10sR5ktpVGOpk+NGeChSEPX5XED35X/YwoIsHiYXrUAoLzqEFO+9I1S/b9Xjg
 8qIolJwfU0/xtL/ZnqP5NMis+/OqwgAgKYYjZTNsAn+MYC6vq182SnWsYbbR/Ar5/dyQ
 2FwZmaJ8luCBLG6CEPdjBxhiZBdP+d3V0FHF0OmbkWAlswuIZ3vIP9r3scp4Yr7W1Y4R
 KvnzO7hPkPUp8Ia1BOwLSqoN2neEiJIXo8wMihxIsDwZl+KfBsEPw5VP0Fk1EiHExDV+
 4D3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbrYeKNtisNrDdEEmZUPRH8gjhaFLsVAJjSvH0mHVJDtMDEyZHxzmeZbzGdl1wtjI49CKCHh+eN1Xz@nongnu.org
X-Gm-Message-State: AOJu0Yxi6vWlJj/e2JVjE919yF1lv0/XEzPTEHN/gPNOv6dzaUNn8lAR
 84k/Fr0HpsMh7GN6slNGfUspt/F3ylPMU0dvI5+QVLnCMCQkoNKpGZ8UnSKjPceEhH8NrVQjAF2
 B
X-Gm-Gg: ASbGncvaB9sRJXOXoiKVIea383sk84e/80v5RGxsQmVVty60cS2indOn0IBdfjQfwVv
 znhhFVZR99yg7DVKT5asPIQGnY2CJr/EjtiV9GojBlDU2JPJAN/D8dhKS1k9bMOSjoU96iT8yjk
 Om4OZr6SUCmuGWnTVpuyoxL2+G9MdQ/KrYoIR0fuNGd7kXcYwFFJO6QSPlVENrrt0vbGZe0XdBS
 wYfocRyzlD9KQnJfBQMouRBW7AOGMKqq3Y7lb1Bw9Qv/g3NVDjUhAhyUDnoLvC/0gjja1dwspRE
 h2RetQvy9QttdZhuoO4qgYpnVTaSKtENDjgMo9iJmbeUJIboS7Q4BIjScxksiJzB2vyC4sPnY6m
 fJ8NJ/IfRnKL4Wc2gHuU=
X-Google-Smtp-Source: AGHT+IGbgOlYNcwlRQP1SNui6PD7AGt+mc6SyMgnD0zmKGSx+bKmiVmqfBzDK5WlPbHG3Ckp/NeATw==
X-Received: by 2002:a05:600c:818c:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-43eb5c18819mr42349185e9.11.1743627985182; 
 Wed, 02 Apr 2025 14:06:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb613a283sm31651105e9.37.2025.04.02.14.06.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 36/43] tcg: Have tcg_req_mo() use
 TCGCPUOps::guest_default_memory_order
Date: Wed,  2 Apr 2025 23:03:21 +0200
Message-ID: <20250402210328.52897-37-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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


