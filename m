Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F96C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueaL-0005bK-KF; Tue, 18 Mar 2025 17:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY4-0001KO-U2
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY3-0000oj-8G
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:32 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223594b3c6dso133166015ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333550; x=1742938350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmJPVBq1IIiVyK6FrvUDybHt88qCAdqwKT6ScZgiv/Y=;
 b=htK1UucRyLeRCv464+txXqLlEJGqxIyujKkSMhJWfpvOuh/dU3nTKHVZh5XNek0pJ8
 qS03M3iQC8B12IykvKen/JDBEK+L/rWgUlHVCFVemoBrtpwc+P4dsAb6qwz22I4y+V4v
 8bRoyF+p7d+TJpc6tywUkNV7weE98piMms8sQfl86UHUgxHMXtMUzR0/pNkC2kNxGAYt
 ChoQVPklMXkJGwT6SYqiVXNLnwLHlSKM0qbJK+L8GFjet/arS6kaL4gLsWyg1exZNAna
 7VdVhe9YKCK6/ZrvX7GqLaK7ACjG0XByCxLwbbWboZZHfCwq59Rib4WCM9s6duQht2PL
 Mt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333550; x=1742938350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmJPVBq1IIiVyK6FrvUDybHt88qCAdqwKT6ScZgiv/Y=;
 b=UzzIMwrVIzRM9n80Mki61Uw4uxkv3ddJ9LjCVvvLbfh54h7bvveByC7oR2LM9jNL3v
 5vGE3uVebe62k0XiRg1yC1xaCD1JpdOMb64WJkA6d0KuWfZQ/IwAGRT07/7wK4A9uJ+X
 sH6YfGF2ljGxH0r1HbyGGsnKsyZUL10aOmk6FBgPhZwVT9i+OhvTFhwxwaS5mP/qurrX
 Ytdj1F17/BtihYNmlAeuHH74UG8/Rh50Zfd8Vvszry9dbrEyQ+fnsb/aSsJJp/979oE7
 dD/XKyduu+2Ushm4mALvFVZJ6p57jqVbrU6lePUnnrBxiFZTXY+6kVvWpeqQuXHZfoXK
 aI6A==
X-Gm-Message-State: AOJu0YxaIaUvjPSg3LVA55b99byw5o+05Eqhd1KHHcwrw5CT5VFVm4re
 RGuOXZkakFAuc6+yr5lrkpATJvA+T2Z7ljAKuGqTScsIsufHe2bZXty6yGk1q3/T2wtR5kQNKae
 h
X-Gm-Gg: ASbGncujFbZa+USa27T2zA+f49c1MYRyc+l4jw6YlOQwHksMolCjayUL7VNAoQhDfBv
 noVgBabQ3lnOCYkGB3roZZ/D5plEs/2ZdkU3EEy7Ih9jP7ag4ca9EVGSfwOByeA6PkiEcXnGaX2
 7vEtgYtC6Xxl/29q1hUrDL+JPrrU08fxvenMX0/Httzgv17mMeVderHXamxL5kwPDN3G2T4u715
 ssRkF3+DlSwh6+S5MQf5HsWE8Bp9WPnTauz0/3eI+elIekvKuIX9sxliuCM37YNTV5KA4t6L8LC
 KS7Ee3LnVAgQaBK8ajMGrX5fEfVlGx6eVVv9cjr31WqwEwHrnRRUSebRGgPc53MqIs7aSOxe0Y5
 Y
X-Google-Smtp-Source: AGHT+IHi9ZdF0SpeQcIIcqQGUgGclzzKMakrfoHzKLBqtMqJ0ENmIhyhXywww+LQUw+VkfL0pb/BVw==
X-Received: by 2002:a05:6a20:9f4d:b0:1f3:2e85:c052 with SMTP id
 adf61e73a8af0-1fbed31614amr328947637.35.1742333549841; 
 Tue, 18 Mar 2025 14:32:29 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 27/42] target/mips: Restrict semihosting tests to system
 mode
Date: Tue, 18 Mar 2025 14:31:52 -0700
Message-ID: <20250318213209.2579218-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

We do not set CONFIG_SEMIHOSTING in
configs/targets/mips*-linux-user.mak.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b207106dd7..47df563e12 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -32,8 +32,10 @@
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
-#include "semihosting/semihost.h"
 #include "fpu_helper.h"
+#ifndef CONFIG_USER_ONLY
+#include "semihosting/semihost.h"
+#endif
 
 const char regnames[32][3] = {
     "r0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
@@ -415,12 +417,11 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     restore_pamask(env);
     cs->exception_index = EXCP_NONE;
 
+#ifndef CONFIG_USER_ONLY
     if (semihosting_get_argc()) {
         /* UHI interface can be used to obtain argc and argv */
         env->active_tc.gpr[4] = -1;
     }
-
-#ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_mips_reset_vcpu(cpu);
     }
-- 
2.43.0


