Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD57AE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mj-0007LH-9J; Thu, 19 Feb 2026 05:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mg-0007IK-0X
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:34 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MY-00066n-S2
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:28 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso6899945e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497265; x=1772102065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9LXzQTqxkQXahmIsDgzrgeXb5SVwBMg20npmY/DlT+Q=;
 b=Zxdk+Prk1eB5nzoDakxNSXAwsRuYfTOImHD38kG/EDJMvwreG9nZSWkB8327/ju1b+
 M7qzC4zrACDSP8N407/2moDptetiAM+Y5xIJGUGzTSXEL9YfcuGYRpHykjrsNUlZxlr1
 6xYmowSSI3Us38KlWcU29++g6Hbn4+7cvB4VwJGqqFj9WzbmBV3uh3FkcKAW2efuAO7K
 dDGL+Nv8vOm57L++25NOy/GZXHC4Hd2I+Q/nIUh9HYB7rj1mePpPKR7UWUJcrPx3IRI+
 2JR+k0FKJUd+9q/t0Lpg5I/z11pCvO6bSjMuKpPEUqt4r/G1AVV1iYiQbT457cARE9KO
 ciIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497265; x=1772102065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9LXzQTqxkQXahmIsDgzrgeXb5SVwBMg20npmY/DlT+Q=;
 b=AozrkshL0YtuSJXf1Yz5hr990M6leQzD/puh3oYqBYEA2ZHok+R29wYad6ddpJWB53
 DZPu+0K467nuakommKnVGJdvG8zK4zye5A9QfDF21lkrpOpDlLBqKfhUzate6sr5fpm5
 DsnAJMSJ+TVbyeGmpvyTOUbRoRacWTLmDdSLzsB/DFSiQ1BWJiWoFBP4Mj8bQa15UKq+
 cYPCFB8LiA27YntXrbNzh/iMMfXE+0rMKwlZnW6wlfUBV8II3mjV0EfrlKGoqyyGv14P
 lN4G3J0RjVVtDQGcEJjNd4OZhSVw1ncf9ScOwIXVZrsq5vT3ryoIVEW57irCm2knFauK
 BLfg==
X-Gm-Message-State: AOJu0YwpAk50VpfTojQ68X1LzFJi189+McwGo+nuvj7yL/vHDQCn4k/A
 qQKZh0FB363Nxqnq0/uk3ao/YcdPwjum/7uT1GQ3t0OvFjbaYLzI2whg8Qbp3I9tPxhP9oRu6XA
 kJhwM
X-Gm-Gg: AZuq6aLjjiTaOhOqbBifFO7u9Pq+LrZ4IcYlWHijSVxwlUTZ/2EQOo9Pqdm2NuUUyGj
 mF0ZmQkZOQZc2Vi64MSqL7zW5KlBpwBfvsxSFvs4HKKEF7VR+I6iXaPLweJ4uu5TNtvJsPv+1gs
 xIKGdFmB4UlmZ7UO0AMfTDSzhY4yf/DeJWpowGUCu0Xe2/kWFDVksJ/P8Ez6RT4FzCCVlk30rJT
 goHhZaFE9LrZsbu2IjoiiLatvCd0JS3X/3umqeWeEe52y4rUEmqc6J0FDv3WEEMQF/OoEaSgkFr
 VrHLaEokDuF0DXKaHM4LJokEMkDACjy98DErDgk0qXDs6t7UO64UsG9UEcJqO72yEAfZtqHQdPg
 yrUD+dLGY6z4Dx2xQX8LxD/SSBN+LQrb8vDA6g4ieWnnApwg7+QyasWI9rFOGFny/CigOzgZbiV
 Lc4oG9awWyeB68SbDjP8Z7vOZP+nuS/ww30CwzAvh7voGBkgEVtD/cG5J9jHYcQDHzv1gUfp4ri
 x/dyKHXR/5YMWoDAdLidDJ9hbDmRa0=
X-Received: by 2002:a05:600c:c3cc:10b0:483:8f0f:36fe with SMTP id
 5b1f17b1804b1-4838f0f371bmr127044055e9.1.1771497264975; 
 Thu, 19 Feb 2026 02:34:24 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/32] target/arm: Don't require helper prototypes in helper.c
Date: Thu, 19 Feb 2026 10:33:53 +0000
Message-ID: <20260219103405.3793357-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

In arm_cpu_do_interrupt_aarch64() we call the TCG helper function
helper_rebuild_hflags_a64(), which requires helper.c to include the
TCG helper function prototypes even when this file is being compiled
with TCG disabled.

We don't actually need to do this -- because we have already written
the new EL into pstate and updated env->aarch64, we can call
aarch64_rebuild_hflags() to achieve the same effect. This is the
function we use everywhere else in this file to update hflags.

Switch to aarch64_rebuild_hflags() and drop the include of the
TCG helper headers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-3-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e12b2455d3..6bfab90981 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -36,9 +36,6 @@
 #include "target/arm/gtimer.h"
 #include "qemu/plugin.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 static void switch_mode(CPUARMState *env, int mode);
 
 int compare_u64(const void *a, const void *b)
@@ -9479,7 +9476,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     aarch64_restore_sp(env, new_el);
 
     if (tcg_enabled()) {
-        helper_rebuild_hflags_a64(env, new_el);
+        arm_rebuild_hflags(env);
     }
 
     env->pc = addr;
-- 
2.43.0


