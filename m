Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767B4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXZO-0007P8-HP; Mon, 12 May 2025 14:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWy-0002YN-M2
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:46 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWt-00006a-DK
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22e16234307so50729555ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073130; x=1747677930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJInTwepDQvyARNpaPXuaRooiI+RbVpis9kB0Baf804=;
 b=FrYCxdjhDsTOdf++LtVpSEVNH9TjFM5wqKE/0Y1m6qK8n2fSGjg0HnB/EuroFBR0An
 lne9o6qwUc+PKM7r7BYwzXkD0NXlRAJB6fba1InjseBP5ZsmGJL5gHKuvnYuuwUFpLWR
 j4r23sXhBklFCNop4Ttce4NUJitg1EdZ/Z+3qoulKXO6O1Ojf/PBKX/TQ6/hDrHbUYrq
 MgTJsaE/dWYfMfUahs4FPwaAIfbWuARkXHJp0lYRS/5sq+CTtxYugjCiSYeSVS5+HkCm
 /LkSpuPx7Wwv7Ik1F8rnOcVcJFcDtbqUUQcGgTcYLFc1osy0I174083C6Z8EJX1gTUwT
 LXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073130; x=1747677930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJInTwepDQvyARNpaPXuaRooiI+RbVpis9kB0Baf804=;
 b=Mhr3cPzuuw/7P0EcNvs5y/BBfV9QwuWvk9HsuTISSHyx+kuOb3VZ+UlayGq3awujsv
 RUgp3GhwHQvUjuHyW3ffAveNu24HVEwGg2Zzuq5htG3mJzvse+agz4qQLQpjr3dK4xdO
 +HARMLmHtvqld2M9mlP7FAwO54Z2rZtTOs5bP8X92moZBgsVIyYTWf7iI+ZbCgCHvwq8
 uKVAh/mJvztg+/dfBZInAJOW57p7YJvt657CWmP/wNRabTAIr7Nm8kCed58aRhk9x4se
 ZZWsl1ol9cAdPZBvE22T9vZdx1cRPiyCH08kvOltHV42U3cviSJ/s2ylUSf+KstLCaWX
 9v5A==
X-Gm-Message-State: AOJu0YyseDq/WjCCaDI6rTPnns6J5DG1iUoJ1H+BtF7DHqnDF29bSIJ0
 0jhu/50nQuN9PHBcJSpoAYZfeDuQOgfHpuB097EUBKfv4nCSRML3zaznQG/rwrurtLlZ3L/orHz
 L
X-Gm-Gg: ASbGncuPrPlpAaLUQW4JAfA0baKomJyYA71PF3zncdBvKTgaCS1x6Y9zVljm0iw8o0r
 Ags305DZkj8JP7FyPUcuTLFuCNRK1WJGUsVzqhwF5OP4I5S1irhfz97bXIFYO8VRhGmdmThPEx6
 503gT0fAkaRZfT9uo1/tG5Uxl/lQ3VxsSQiQyKQVtxNQvb6+qtNt93WtCwoeGtwEihN3zJ5wdGf
 yAi3Asr9Ue429z05yLqF4hivHutx4s66qG5KqQZzT9hnug3WOV45VGziTCADpqqy8JpKT351zab
 vzPSRUqFXctoG0Vri+SySKeJZ4zqEIbkhrDZuudzcJI6FiLOhQs=
X-Google-Smtp-Source: AGHT+IHxrzHChDFcYnRSVaKACPNNaf4kZqDUlSJo1+aUJyFrfDQpSCpvtq014nivMaomuT6gO5OwyA==
X-Received: by 2002:a17:902:dac9:b0:21f:5063:d3ca with SMTP id
 d9443c01a7336-2317cb41a37mr4886665ad.16.1747073129894; 
 Mon, 12 May 2025 11:05:29 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 20/48] target/arm/helper: replace target_ulong by vaddr
Date: Mon, 12 May 2025 11:04:34 -0700
Message-ID: <20250512180502.2395029-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3795dccd16b..d2607107eb9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10621,7 +10621,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
-    target_ulong addr = env->cp15.vbar_el[new_el];
+    vaddr addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
-- 
2.47.2


