Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541FFCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUB-0005mc-7X; Fri, 15 May 2026 10:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU3-0005dz-FX
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:48 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU1-0000uE-PK
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so4968846f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855144; x=1779459944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yf8wcNB7EGw9UdeWFsayhgKXIy2x+KdJELXRYJSdqk0=;
 b=wbJCCcQy/nyPQD9steLrXg1kYhmWpCQA+B1QnAGGjYAAMwHIhnVC0pP1qAIE8am8XC
 rb+ZpHXf6MF6F+i230I2q3hiTrnpd8iIlTpABjRTjGjUN9TIskNcWyUjYBnbE9PVgbnf
 4L6HwbbxtHgFdwI+uQ8ZiHTz1hDD1DxbErXQOrVrXevWJPZRP1NYm0+2gxJVLXj/Ambx
 u8s4UgxLzczDAQCMo14Omm88EGh65aY7LXg8S/zZlf/6fSBNA7nSBbLNvrABzU8fD4Id
 e4lchvIsB81ViTMXZfHQ0L7XL2PUOcGSYH/c+PwaXms0PQWM+wlLGHz/lMXki8ZtXUiY
 gFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855144; x=1779459944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Yf8wcNB7EGw9UdeWFsayhgKXIy2x+KdJELXRYJSdqk0=;
 b=r9wMHP6JqbhrqzYhD7QrFGDcJaTGQNI0NipG5WLiktzteBRK4BdIHhNPSb2aOJKvOW
 ZGtb0aOzNnbJRJ45snknoiNjgaNmjvPMaXayF00l3wsmncOcRFKL8tboWRFa6gNPdVVL
 6Wd3eIbp0kxtt3VxnNjhz+sHE8sJoAunLscLM6qxzCz0A8/GwMQ/yDDa49A9qKzzWXpv
 6UK8zwJYAbc+wCNudi6anT9AhPN8hR5ciWU5kgbUkmeAit7Eo9IjSjmRF/rEFC1HkKRX
 xjOF7eVvyZP97hsMVoqZzpvbxxGhixV+XopYnSIAIb75+9WxSwlHb11yNuazlKAxy9pM
 vVXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CCy5DIYYB4zWSMgDpItwKTxkXKioYoPu7USmoTbSu24jgxoe3qLV9vQ6cwF+yOSMkM1tSNhrxfbZy@nongnu.org
X-Gm-Message-State: AOJu0YzD0VHLvI2bpDuAFLFanVxFkGWeGkxT+ZYr2WblzZ/NMYHF+TmA
 CG1euApKCQmQvMKiqBQBbsz81ip/7Z7DumUe2EgVfHcqOSWIteJ8V33Z8kBHJkCdXRM=
X-Gm-Gg: Acq92OHvGgSuBhCtu2e+vXy3602CO6LjSUW+ZTr3dd0FcV3MCQyT0CgaLRnuBBbhktw
 Wb1hq+7JezwpXGigzMAKjEzd25CNCKXA2Z0brgPF0ogBiSkaZ2BVDDooR4mjMNxuQaM7FS7Sdjz
 q6Or9oBZs530cnvxWIpefi+2cuW2t+htZDF44mRgtKIPdvLg+ZbJLzKqaQUb8/hvJcckkcL6C8u
 agJTfK+r0Lp6gJLFIHjNawPJdopC7OH8AS633xAVTviqv2dDCVtSqWJyxa/O/XW1Kl9FtXlVont
 D62PGibuigMDcEYFdIaYR6NOUQbRs5VrTbtTmrZfsXHlQ2J0Nu/XqLIyMsp2hAhVmcKcCE4/Ig5
 byZPGm1bLoZJfu/f7J2vOzYpys6d89AX7ggLO83+ubQoNH6I+YKd32EMklrAKxfjgJlzfEaDl9G
 3GU3XfwUhbfSZDZJnORkQxsB5CsqxEGeZ8s5Da/AG6tzjJMs6JI599gLVy/BQcEfMZfOMnUyPE+
 eSyAfW3XPiq96lhI+BgpHz1NRUdWEU=
X-Received: by 2002:a05:6000:1844:b0:43f:ea91:63ff with SMTP id
 ffacd0b85a97d-45e5c3673a5mr5736112f8f.10.1778855144101; 
 Fri, 15 May 2026 07:25:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 01/14] target/arm/ptw: Flip sense of
 get_phys_addr_disabled return value
Date: Fri, 15 May 2026 15:25:28 +0100
Message-ID: <20260515142541.571911-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

We want to bring all the get_phys_addr* functions in ptw.c into line
with the sense that translate_for_debug() has and which seems more
logical: true on success, and false on failure.

Start with get_phys_addr_disabled().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8706dd59dd..8a412f463a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3506,7 +3506,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
                 fi->type = ARMFault_AddressSize;
                 fi->level = 0;
                 fi->stage2 = false;
-                return 1;
+                return false;
             }
 
             /*
@@ -3548,7 +3548,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
     result->f.lg_page_size = TARGET_PAGE_BITS;
     result->cacheattrs.shareability = shareability;
     result->cacheattrs.attrs = memattr;
-    return false;
+    return true;
 }
 
 static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
@@ -3682,7 +3682,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     case ARMMMUIdx_Phys_Root:
     case ARMMMUIdx_Phys_Realm:
         /* Checking Phys early avoids special casing later vs regime_el. */
-        return get_phys_addr_disabled(env, ptw, address, access_type,
+        return !get_phys_addr_disabled(env, ptw, address, access_type,
                                       result, fi);
 
     case ARMMMUIdx_Stage1_E0:
@@ -3782,7 +3782,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
-        return get_phys_addr_disabled(env, ptw, address, access_type,
+        return !get_phys_addr_disabled(env, ptw, address, access_type,
                                       result, fi);
     }
 
-- 
2.43.0


