Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88767C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKq1-0005jj-D4; Sun, 09 Mar 2025 13:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpu-0005Uq-73
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKps-0004tl-Kz
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so6368945e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542790; x=1742147590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vGcEABqB5MF8s9y7Im+YzfdcGovmNjIepWuE2Ltrdio=;
 b=w1NNDaTRlDz7fS6T345ZxXx1VKYGaVAnRpYC11JVDcmv2zIdriBWlP9vHf7YhokG6+
 GI5aJ9vaAf8eu295UpovhpZWXyQEoQvp49YdGh3q5BZLpRvc0qw3Uzqlk9CAyqCm8lZZ
 Ky6luLMygyv9vz34xsL/2oP4AP9wUyQKV4Mz9Bnw0x4+PAWk8e8oAYXVQ+m+Mzlx4XOv
 tANs7WxXNUCuNvUUfa/ZUm5WEm8viqofo3eQ6WnyUtTpWfP1cJ3tveNsAF3LvXnaIlFE
 fDZE9itBU5o+zOZRqiSPbEvU4kIs3AvEPdU2tWNyCuko4bsEhXOCgdXvjFKmoEfMRBxs
 oBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542790; x=1742147590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vGcEABqB5MF8s9y7Im+YzfdcGovmNjIepWuE2Ltrdio=;
 b=QIJ1p4zBigqHUwN9TMUi8dfnWHGzpiQriELTBo1ec5O5na5SzJsiucu2PHQYA8CLPJ
 exSMQs+6/8r5YjNooZwTMNzKFfg67bOyPdUE/fEG5RlyL4Nc8XCVadRRBgk7ZzkcMEC+
 CC2f5Mi4nuhd6MVTh2M6yxr21+BHKQCpuh9HOK6YDWAQcqvLVmVK2WwRzU6SfIxFcASO
 leISBPsAyb5nB5GwEBsGy6fuCt7m0g8Mo4HrOQHG0xnRdu/kgXiC6U1IhzDPdJ4AS3pn
 ztlOVcrjhJUkRSLowqIHNkUeVFdeb86Q+UDuQSZe3NKAgLGt830ewRv3a56rD1XMhBEj
 OWDg==
X-Gm-Message-State: AOJu0Yw4WvpCklItFqHGdBcFuDi65oNJoTewgaBa4O1d4Re3XCThSKHu
 /+jQISz7npC2rbnickt92t2bpnR971AzDX1BiRNVXW3bJsQW6/Eq3wvYhTpFgUd87nODFKKPIp/
 99zA=
X-Gm-Gg: ASbGncuXd1EjzPvTvtn7DGb0m6n33e/atAM2NBPryOragD/XSNIT2WlNOMD/4xMAHdN
 0EVaDZgyzBDReIwvNJXVUMnOyVX1bo6NP9l8/qRttERVHw/rpNl5ReqsFfSIhzZjhwm7+MCPy2S
 hck4ep+Q8wQh5uyamNbYs9HMU7+uOIYYsd3JKSJAA3XBuFEeKlAs3VUZi+D+vWO1qGZLn7W/Q0B
 gk8wnup5x+nhH/t+OlNRSjP2h5R0+I9Uyrwps0jMDlcrdXhDMVw9Zqizdena3tNYv3H7PbAIzZH
 udtL311GqERwnLvRupLlIBRE+Yox6z6Vv3pYuFeEquum4z7wzdmhNgl8A5jaEkLvOoi/QytV0kM
 kubcmKCtWmQ5zOjkj2eRWEKfh1w3AMQ==
X-Google-Smtp-Source: AGHT+IEjRI2FI8/eX28Q3ARWS4drD3f9uGeRrfyhYOGhPLpiYdmQEIBAS3zO7wOdFx2bZh1GKSLIyw==
X-Received: by 2002:a05:600c:4e45:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-43cfa3f9022mr2504015e9.2.1741542789932; 
 Sun, 09 Mar 2025 10:53:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce5d2808dsm62590335e9.13.2025.03.09.10.53.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/38] target/arm: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Sun,  9 Mar 2025 18:51:42 +0100
Message-ID: <20250309175207.43828-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250122093028.52416-11-philmd@linaro.org>
---
 target/arm/cpu.c         | 3 +--
 target/arm/tcg/cpu-v7m.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index cacbbc615a2..d7e61d08bbb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -830,7 +830,6 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 
 static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUARMState *env = cpu_env(cs);
     uint32_t cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
@@ -930,7 +929,7 @@ static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
  found:
     cs->exception_index = excp_idx;
     env->exception.target_el = target_el;
-    cc->tcg_ops->do_interrupt(cs);
+    cs->cc->tcg_ops->do_interrupt(cs);
     return true;
 }
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 29a41fde694..c4dd3092726 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -19,7 +19,6 @@
 
 static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     bool ret = false;
@@ -35,7 +34,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_HARD
         && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
         cs->exception_index = EXCP_IRQ;
-        cc->tcg_ops->do_interrupt(cs);
+        cs->cc->tcg_ops->do_interrupt(cs);
         ret = true;
     }
     return ret;
-- 
2.47.1


