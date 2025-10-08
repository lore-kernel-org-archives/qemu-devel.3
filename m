Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CC0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cDA-0001DJ-14; Wed, 08 Oct 2025 18:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cD6-0001A5-Qp
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:37 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCV-0007PD-ND
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:36 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b5515eaefceso224270a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960794; x=1760565594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9PGE542gvCPCZ3kL83WZF55iv8iEjMdwRFvuv/fA+g=;
 b=oyHH2DKeGUgNMM6FXjOnaaOW768rAVH099xn5yxGjthKb27jHEa387drGkFH+xrY/0
 YCPOirYiYFr2QmnR9/fE1zMEzK2Kjocl9YdnnxuhieqcrvqQD/f0J68CET/5ZWY1WjF6
 QOJAQEEmPHeHwnWaTRbpNgWqkl765KxlJPM9ZL+/zOfmD/X4c+j8g6QMKEIi3W21lYfF
 1W0t5jZyLHtdnVzm7uu+eTm6IxlB+2QWnbXP9Ir74OMvJMlYOZYb3uhdllsrBiAGDcql
 TK7v+eMOs9LrIX54eqS5+87HQFnkzDCQv5/oEH+pbLb1E2RxoGqrUPotPlM3Q3DOsu0g
 nPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960794; x=1760565594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X9PGE542gvCPCZ3kL83WZF55iv8iEjMdwRFvuv/fA+g=;
 b=iewxhxJamD06uLr0AGxc5ZP8/N+mB5nNzTFAJ+kzMciAss7U8Sowga+Loep+zGwvmy
 u4lEgM4iRwe+uBoH6joK6Y8O8tA8ag99Zi5RnnjuoQ3lEjsQC7zQHQnlzLTOMV0Ha4TF
 0BYNOc1WlW6sVbv4zwW5NeWhpGGlQLKOQCcwC9/1TmThvb8EIjjLnEnjtkS7SOhmDGH4
 zKq9GA3GNUrr/1oUASgWHggg6CZm+OWsq1Pp0h3KA5Z7p35SlpwXuPInhyVGFwTgpRnb
 G0Jx2s5AwQE8hMAFkBOC47hEqU51d4Ki7oILoumu60DIvQEj+d9p3+8WP5SsGXftQXRN
 oaaQ==
X-Gm-Message-State: AOJu0Yyx/aHZlyN/zzZoCTzilCdM9VxRMea4VKqGe0QRma28y/IQf2fi
 RsVD1ETICcbZHJsOfsoU7yw/ewfmuCggd5g+5XHrZN9qTe103u58u8QK1hty0r1zDiMWjbuzYBv
 w78k1XZE=
X-Gm-Gg: ASbGnctUyicGXo0xQ2VenCWC/s8ATYdIaAFX5Q1MatbluYuO8o5nuG+SrVyKTqkbMf+
 HqjCj/+J+wxMY1afePs6QKNxIg//Cg1djuhaN4DP3hh7zipeVpNpDYVuz1u8b9oGkJPbJshJWwr
 GUCyBx8oyoNCt8ebERR+NFJcpo2Z4baQnwh+kc2lS//s9vNaiK9uONDlcNG0xIW02D7srAcq1Da
 v4yNfg4wTPTVAq8R9F79tXZT2KBzd3YEECZNBcOT40aZXjufTi5rYoD4t/t97XwEXJJ5vH4adQG
 xT93titlUGe7zI7AJjsFtypyl8N0DMsjO70+D/oblUxE5UuTzHvHF8VzSPrvJPwgh284yxwzhgQ
 Rp5UHEjYNNNdj1JsEnVhc/1r/Fbjk4b40fx2nnmrPu30AoCnPH4xG7unT
X-Google-Smtp-Source: AGHT+IGRx5c1p6BygS6+r6i6HroaURKDKfS6N3edlFmhnI2lYBvIcXCpnfhC73cS1beQ9LBI07Qk/g==
X-Received: by 2002:a05:6a21:33a0:b0:24c:1f78:1803 with SMTP id
 adf61e73a8af0-32da83db8fcmr6924831637.38.1759960793709; 
 Wed, 08 Oct 2025 14:59:53 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 60/73] target/arm: Copy EXLOCKEn to EXLOCK on exception to
 the same EL
Date: Wed,  8 Oct 2025 14:56:00 -0700
Message-ID: <20251008215613.300150-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Per R_WTXBY, PSTATE.EXLOCK is 0 on an exception to a higher EL,
and copied from EXLOCKEn otherwise.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1aa0a157b7..0077788e1e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9071,8 +9071,13 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         } else {
             addr += 0x600;
         }
-    } else if (pstate_read(env) & PSTATE_SP) {
-        addr += 0x200;
+    } else {
+        if (pstate_read(env) & PSTATE_SP) {
+            addr += 0x200;
+        }
+        if (is_a64(env) && (env->cp15.gcscr_el[new_el] & GCSCR_EXLOCKEN)) {
+            new_mode |= PSTATE_EXLOCK;
+        }
     }
 
     switch (cs->exception_index) {
-- 
2.43.0


