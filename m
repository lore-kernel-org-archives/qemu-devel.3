Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D58C0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX50-00026s-Vz; Wed, 22 Jan 2025 04:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4y-00025D-2r
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:31:20 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4w-0003Kd-Hh
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:31:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso65858095e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538276; x=1738143076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zX6wKmzI06nCmXct1pzxbuNtoEp265I9BJm+57rS6fc=;
 b=E0XnPb6KePl8gWoAp6nEc4OJu6MMWT+oFyLVvHN5GMFpBmDMP6fovKeMmqEHzQa4F4
 pWVtyg+agUupVTtV1W+IF57IJ8Tf5Oee4gJvbRCGs3hJThvR0PrYD+ZqkC5iXML26j2B
 qnGvxKFmE5cL9zwHdiLQlGwjSis9CnSAOPS/6RL5bR2rF5AB44y4O5uwtgxOhhhvL+Yz
 GLsOOUuqzRUC4iBBBY6KIFReLvPtjaovuUnfx7VRQe5kf8BPAV3R6y7uktz8RBtrCO/5
 /n5WViq8sHxtJzEXpSQIze5PwVfRp8cKinxTryuxlik1Lh3Y3/yAn51y74C7RS1nHQSE
 sIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538276; x=1738143076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zX6wKmzI06nCmXct1pzxbuNtoEp265I9BJm+57rS6fc=;
 b=dZLC7YuaQkHCp1bHTMtExVWK3qy/5m7Y7103HWk4/U6d9IWeEAIuIZL4nlwmyKB6Z1
 c4TQ8RRuekvSPDyb2mSBr+us9orO6xjwvQnH+/2P1BrW/JjsP/vOKIM7Ym0/GDgzUMKw
 eVGfD8rS2glp1qcSOfCcl69orgc4lamBT/LzlCU18Ft1+B14bG1mmNMSpR1ZcHVdl0Ds
 ObxK8n6vqWR+AJ6FTDtufPtyzQHC7fIHedUYMDSX9BvMjvzPUvG8BYycZjEnCTNtOnhs
 9yfdpCqrxiTlWcUBXA3MAKtibuV12h4natnJ/Vqe0ETnrft+TO7yI/CwwFmDjFzCvBC2
 q8Kw==
X-Gm-Message-State: AOJu0YwOjgFjGiE0WslXOHEr6Y2Rj3zIukdkESpQ4s4lMNPGTkiSfn+G
 d4YmhzOr37Ojw6HeIjBO6qURsjaEZqICZzW6Eq2bpJyaH+cvYQ67aDWBlRVKc9m6o/HxvGBpzWX
 nGFQ=
X-Gm-Gg: ASbGncvpc2V5HbFioNFTD8pZ3cB1PSCtNdkwZeorDx4Q1ScV6IlzRURpZb/PF3SJ2OT
 6DZj+3BoFT8Mrxxrhiepg2/Atm5ArN6XpJR3K2eedrpdep/9EqlLXLmOPkZog8jDnt4PjDQjOmw
 pBUVl7AMy4N0WjPvhbbu03i5fYFwpjifL+oAlEOIYveaNbAwLRxcDqLkySAmWbn5R8yBFSXdSPD
 iPT6Ri8/nFaIU+q45XaR6W+uL8PhsaSlW6jxn9FXgInegIrc3NlX8wgCCs77su2YNSPdrqsRpmd
 yjCMzGvfUw9D0KPWiesaazs22AljF4mYKFG0RQhy4VpB
X-Google-Smtp-Source: AGHT+IG6O9YAZndqYHtLAOIJrxfLy8HdpLW0g3XjNE4dMucyHCtbEMrzySz5+yEgU7OfImhUVkvOdw==
X-Received: by 2002:a05:600c:83ce:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-438913e0384mr202379415e9.12.1737538276486; 
 Wed, 22 Jan 2025 01:31:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318aae1sm17628795e9.1.2025.01.22.01.31.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 01:31:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/10] target/arm: Prefer cached CpuClass over
 CPU_GET_CLASS() macro
Date: Wed, 22 Jan 2025 10:30:28 +0100
Message-ID: <20250122093028.52416-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122093028.52416-1-philmd@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c         | 3 +--
 target/arm/tcg/cpu-v7m.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dc0231233a6..048b825a006 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -846,7 +846,6 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 
 static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUARMState *env = cpu_env(cs);
     uint32_t cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
@@ -946,7 +945,7 @@ static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
  found:
     cs->exception_index = excp_idx;
     env->exception.target_el = target_el;
-    cc->tcg_ops->do_interrupt(cs);
+    cs->cc->tcg_ops->do_interrupt(cs);
     return true;
 }
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 03acdf83e00..d2d0b94b630 100644
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


