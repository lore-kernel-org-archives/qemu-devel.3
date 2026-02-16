Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A12DE81A3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 16:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs14y-00028i-9T; Mon, 16 Feb 2026 11:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vs14m-00027u-MN
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 11:03:56 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vs14k-0005nL-VF
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 11:03:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso26462275e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 08:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771257833; x=1771862633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbBuvUw9blZWZ8nku4XhCXzyBFDPHIgEib9kHdOYrNs=;
 b=nj6GHOx8HjFrsBgwYWFIfRLcefKUTzSaQMZxvtii47sgG/F1LrQz1tAMeINb7gs5Qy
 8xibiTZQTCkwZCk/dqnTKU4TMm5LtYkGKAL0Qw9kkYQr0o9ri7g4k454kbaiA5vDMf+m
 Qf6TI8kMChIH922AtP0cTRDztDdSHfSM1B7yPOVXSoVpWDZ+4GD5P1B3Xxl+vyCrpXKG
 Ws548oRA0WwN0Zy4ooPhxEwK1+/aQd6bmGueJ5qWGo7t5hAEb24H9wxwuN/6chKrUjnX
 Gx73VkB192EJ1ZB10tc4QAEe9vR3Sosaq+6RHK2pooPKmPyvxQUCg52uEuk8JpIhgiJg
 6tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771257833; x=1771862633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QbBuvUw9blZWZ8nku4XhCXzyBFDPHIgEib9kHdOYrNs=;
 b=AOjf9o5HA9Yqd1m2O4u3UxUw8jOQg/5kcCfQpwky6PoLQ6M24WVQZ2lfBnpnnOHo2C
 mJltOYWMztvair/7cdig/5+HwHsj+eUaPbE04d4dDxZMLaRO6rWMgaB7EKY4OyqQ6Oc4
 ApUPyFLzWm/Kn+yc3C/MfbfMoNZZSHEXS2pPe2sB5TTTzk29m26lbNPdOmMhKasWOMJF
 FcXygnTEqPHUPZuQTTEqM7cQmMqbii5R5OLUZ2YZVwkTxTRbaWBZTI1HwkuLAaZIo1B2
 TY3ED0c39kpKkz6QRBDI79e+uqyYC9Vd3tJbA8b1uZV3MyutfPc9Rj3hw4MH+nHYOebu
 C3zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURvIbpZWqJ+pUcU4FuPGcuGeiLu3uBPDx1YKaaRlaflfKInHYFwCNEWVNxXqp3XBARPHwQR6cY0BuC@nongnu.org
X-Gm-Message-State: AOJu0Yy6/Pxq688O17WQRaLTawZYUWOqkDo6PMzu589JE6XR6Wt3PTs5
 duwsN4F28aF1Nx4RKC0gBlpE0XbcFHDCxq4iRsrQBubPv6hp3Xo1nb/7m3JeR8FzthuWGpRCiKC
 Ix9EQ
X-Gm-Gg: AZuq6aImEO+MEJs7bsozWb5WcbiTDSloVfr8s0LGPNA8tP9tyBoLjnwsY3u1/lqDD9g
 E5sFjIUPGjqZmshsG9xUg7Sh8lspcXbXbaqQzW/S9VX3R6GIbbN1wB6AuOwUiaXrjw2EJqlCtaU
 YKVeay2LACaTbtZ8n3DQQNSaJ/ROufxPrYMWLUt1vmVboOmc4dbOXZcigVJp4xHo8rQ1dRwhz4M
 yfmuJW24jeFii7gS81tl1A8DevDO99HMfcki3twlrXhq0ZumwvSxuFTmctPPub880Ino6thiDqj
 zYGlpwNYA3WO2jH5gXFRzoJ8Arr4kEnAnjrUUL+WC0oJDXVA7bhACrYTd6MXLy5y+BZ4N6Osros
 sC50JttnBiJqNGDo/w+tVsQFLOUtYoTMp52soLNRLGV/+zjlI3yVjAFfuVAbgKs8TfQCkjEsfwM
 +Ofee4HxeFxV2tkcVGupOIV1NT5z1LNmtCGz4lgNP2uG/zVdiCaiAsWlBj7szBM0CO/pRf/p6v9
 uje38YqHZtDZhABpS2MHfxZqXMFNnw=
X-Received: by 2002:a05:600c:1d24:b0:480:4a90:1b00 with SMTP id
 5b1f17b1804b1-48373a5d80dmr194005935e9.20.1771257833319; 
 Mon, 16 Feb 2026 08:03:53 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d92267bsm661713185e9.0.2026.02.16.08.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:03:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/2] target/arm: Don't require helper prototypes in helper.c
Date: Mon, 16 Feb 2026 16:03:49 +0000
Message-ID: <20260216160349.3079657-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216160349.3079657-1-peter.maydell@linaro.org>
References: <20260216160349.3079657-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
---
 target/arm/helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8c5769477c..033baf7e71 100644
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
@@ -9473,7 +9470,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     aarch64_restore_sp(env, new_el);
 
     if (tcg_enabled()) {
-        helper_rebuild_hflags_a64(env, new_el);
+        arm_rebuild_hflags(env);
     }
 
     env->pc = addr;
-- 
2.43.0


