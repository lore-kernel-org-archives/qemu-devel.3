Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90F1CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUE-0005oZ-0n; Fri, 15 May 2026 10:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU7-0005iL-6V
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU4-0000vH-Id
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so83786825e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855147; x=1779459947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PhqHUhwfIQWqhESGZ3sqsj6+o6aM/A5Mqby6FRMskD4=;
 b=wwEJrwjDYoWAXYdcVhMhz4UHDnJ6v1+Aw5+Ql9q3IeGgI6xesyuYOZDImRzscHKnP6
 ikL9TOtz+HaGBQTHWW448Az6F+N4zoeQyzeT90WmDft/QNPA/IJDfr8NL3W3W85Ajcfw
 Zisqsxwu2rv6o8cDUrumca6RB1HWhfU3SlhZWJkU5OJL9d8OdgSiYKK+gtYTMuiBta/m
 SK74qgSa06BM+PsS+W+CD9AK5Wm+NAXOLmhLB8yNDPZEBdTy0AwF3/jKWHlLD3cr/a64
 8Zyg2tudOUTlCFgQ8YClE/eCAx0Lf/7R94dOVWQza5QQ6if2dzsq7QWGJwJq4/INj+2P
 Uv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855147; x=1779459947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PhqHUhwfIQWqhESGZ3sqsj6+o6aM/A5Mqby6FRMskD4=;
 b=GTtNIaIXrfZj1D7UEUPyFO1PtiKLcrFoHi098jbhq56CT+GJLPVh7NgeiiOd76zNkj
 2RdLMJt0h3e+87N385xv4KjE2XwL67vOdZvJJrKFJt54EKmYhX5Jn/C9fiR/p3XoO2FF
 Rns9l8pdgr46pb+qlNNh9+IJdHVOrWaIygtL8YlmbYYUAq+q2HYT/77r2axj+QxHnPxN
 MI0uYM7sWpol6ipYzNagA1pePlQHzLyMKnmOT2JF3B5SJ75qIS6hKO0sjcT0uldT9MNy
 NxK0ISI7G/lm0CKUzAol03u1SwCN1ICbaG0pumto+UwlbfnB3UNpWSWHgeBHac52Wiiu
 sRGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qrii7Hjcens5iRvLhwR27EyIzV/ctTClKN8HmX0VRpaSGNlnDMOoLaFJTa4WpG7lAh/q2fvJ63azj@nongnu.org
X-Gm-Message-State: AOJu0Yy77kaXM+VvXepnPnvQOifcTeSG6BmVWaxOUI3wzeepJUN3twUs
 CcNecD6P720yTUVm5WjvK4pY7DONnZ9719fEGcAnYsKzxu40NhyLeAQkVaqvOIsqccdziIRU68+
 DsXpV
X-Gm-Gg: Acq92OESzzHno4OEU25kcksuG7k9pYW3VkxOZMSrlJM1cWTvssI9LPbL5iA8fm51yqv
 /OR6B0nx3BVjItvD1V1A1n6a4vOdIYFpxGvSJNb7qoSL6RdNhbT2gYFk6aPeD16oKuNgtTWZL6j
 SoqGUGpxQX5iMhiGXBfbCljlEcGbqUSETYYftdQPZlYk6pK2pERO+SOpjY66BVyjEiY8q3EEaPb
 wNjvZaaKl8dYQ9L0gItbznkYG8zJ2zkRP/V6MjqdE+MG7QBCm1SFDzNgPJP4PriDE9RC5MH1Ybq
 mY46UPy3l1WQPyonLkpsV5dnC+mvyDsx18F6WBCA2IEX/WMcVcCe/yram8RAyfaVGWZjlMgIKfn
 iW4IvqODswA8JQjLDBqhYM1IFTw8RJJmcxbivX/uiAekpR3bBYfTVl5iT/AUjtPsPMpUuvp7zfd
 gzJvwTmkmwc6tzLKHf/ClH9+SpCU/9OoiASjqjmZxEQM+NChvgmaWEEu0WYzPVKSquxcrXBXuZh
 dDEuox4xLMuQaYJzcvBNu8Ji3Y9ymBBgCluyJRKog==
X-Received: by 2002:a05:600c:a00f:b0:48a:5301:bb5c with SMTP id
 5b1f17b1804b1-48fe63263dfmr59705095e9.16.1778855146806; 
 Fri, 15 May 2026 07:25:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 03/14] target/arm/ptw: Flip sense of get_phys_addr_v6
 return value
Date: Fri, 15 May 2026 15:25:30 +0100
Message-ID: <20260515142541.571911-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 93e77b3eb6..fa251f5b5c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1326,11 +1326,11 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
     result->f.attrs.space = out_space;
     result->f.attrs.secure = arm_space_is_secure(out_space);
     result->f.phys_addr = phys_addr;
-    return false;
+    return true;
 do_fault:
     fi->domain = domain;
     fi->level = level;
-    return true;
+    return false;
 }
 
 /*
@@ -3791,7 +3791,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                   memop, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
-        return get_phys_addr_v6(env, ptw, address, access_type, result, fi);
+        return !get_phys_addr_v6(env, ptw, address, access_type, result, fi);
     } else {
         return get_phys_addr_v5(env, ptw, address, access_type, result, fi);
     }
-- 
2.43.0


