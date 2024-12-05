Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCBCE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIrj-0000QN-Aq; Thu, 05 Dec 2024 15:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJIrh-0000Pv-4F
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:54:25 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJIre-0003U7-Jn
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:54:24 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43494a20379so13635185e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733432060; x=1734036860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U5CLz4zSNPKZZlkg6NDeJ+mVR7cJfNveoNGi+tfJ0ro=;
 b=uky1UUOiLqwwszG1XwTsFK73dPUXp/pV6w4a4IIqQcv3TdERAX29OrJwOTf7AiCSxj
 98R4dvExrNxas/QpaCbfpG8pj5xHndN36Wagi2UJBAPkXXWpM4M5tbQRf7YArGQDlOnB
 W+l+eidYNldIdJildxZkf8fcmuOarTtn5pOf3vScj8xwFcQ9BVxNcDmeDJzcimuFtG1g
 0Wi4kXo8sMO2lnSV5jmn1zicRsLB6hrT7EwGMgN4jApPO4OCOYEusrWGBXs+vNlxiCy3
 HiUTF8Xe9eeYPZwDc+mzkwn9YXxuUnFi6D+Zr1TrGkazvXQx2tOfoqMjtXrix5O7k80F
 al7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733432060; x=1734036860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5CLz4zSNPKZZlkg6NDeJ+mVR7cJfNveoNGi+tfJ0ro=;
 b=SLy/qKfDo3zVJ3y7wNECENqpLHGKdGpnmwBhd8uXKoFr/5M++x9lNoxvArsE5tAvd/
 Y81sEIvrq3Ff/YGo3JQlLMP93Uis5lVdOtqndAiFHTuPiM+159SPk95SR2ZhOOjQ17G1
 lJsMdBLr2sranSyIKWz/pC8e2tUAQjuzZQZET/fX35wBaIjqivq0XhDRfkczMVMzs0Ys
 8qa4LOVMDbn76OL65OibRYBKZT/qBpeMf6YUHBRrEWVW1hiGXhqrM7l1AgBbGGgwaDe2
 PGVWaLXRlLt5W6UeoP8mgoqegDjzBRTT/1xL3jY3AmmpfutdJWt72J0dP5upytbym8Uk
 x/9g==
X-Gm-Message-State: AOJu0Yx74qxj6s6+0xvRx9F7vuGyfnJRF3s0mSBtLjus9tjCWDkPWYRX
 ufjQSbYCCyklstPk7cBKvmDhliZV5tqlKWC9DFtuNJoIFRnmlh5V0WqpDx7qNO6NDhGQKbnIT9r
 J
X-Gm-Gg: ASbGncvrYmaka4TKoshq9kpQDx4lccIAdK65w7hPT0k3SXLBSkLJi39mFJw8lnYksDP
 vucwewvD0ktwxXZh0yC1jsAoYupBToMDPF+1SNYfvN1dN+RqBPCpcQcPuI+5LnK1GCU4twUHue8
 SaT1Au/JYBJTohKOj919qGiNiSw3woVjZ9mua7jRLaO2tRy3huPlm950RSzOIE1t9nJbXbvMnfD
 wglwpnN8CGUNV4q8qW1YxpT311O5YJvfntFpDMBkFYDm8OjIapoV2FrbTej4SdSHGUV0wfHrRjF
 Ce7KE6skC+aPKpZK7VfHalRb
X-Google-Smtp-Source: AGHT+IEUIaeyBsBVV8K7Ec89tbrrmTuPG7rIig36RDlHo9/ff+H73vpDVb6Qb+v82Pz1IGQBIE9TEQ==
X-Received: by 2002:a05:600c:1ca2:b0:433:c463:62dd with SMTP id
 5b1f17b1804b1-434ddedbd28mr5368965e9.27.1733432059740; 
 Thu, 05 Dec 2024 12:54:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861fd46cc8sm2843497f8f.59.2024.12.05.12.54.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Dec 2024 12:54:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] target/sparc: Use memcpy() and remove memcpy32()
Date: Thu,  5 Dec 2024 21:54:18 +0100
Message-ID: <20241205205418.67613-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Rather than manually copying each register, use
the libc memcpy(), which is well optimized nowadays.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/win_helper.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index b53fc9ce940..0c4b09f2c14 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -24,29 +24,19 @@
 #include "exec/helper-proto.h"
 #include "trace.h"
 
-static inline void memcpy32(target_ulong *dst, const target_ulong *src)
-{
-    dst[0] = src[0];
-    dst[1] = src[1];
-    dst[2] = src[2];
-    dst[3] = src[3];
-    dst[4] = src[4];
-    dst[5] = src[5];
-    dst[6] = src[6];
-    dst[7] = src[7];
-}
-
 void cpu_set_cwp(CPUSPARCState *env, int new_cwp)
 {
     /* put the modified wrap registers at their proper location */
     if (env->cwp == env->nwindows - 1) {
-        memcpy32(env->regbase, env->regbase + env->nwindows * 16);
+        memcpy(env->regbase, env->regbase + env->nwindows * 16,
+               sizeof(env->gregs));
     }
     env->cwp = new_cwp;
 
     /* put the wrap registers at their temporary location */
     if (new_cwp == env->nwindows - 1) {
-        memcpy32(env->regbase + env->nwindows * 16, env->regbase);
+        memcpy(env->regbase + env->nwindows * 16, env->regbase,
+               sizeof(env->gregs));
     }
     env->regwptr = env->regbase + (new_cwp * 16);
 }
@@ -361,8 +351,8 @@ void cpu_gl_switch_gregs(CPUSPARCState *env, uint32_t new_gl)
     dst = get_gl_gregset(env, env->gl);
 
     if (src != dst) {
-        memcpy32(dst, env->gregs);
-        memcpy32(env->gregs, src);
+        memcpy(dst, env->gregs, sizeof(env->gregs));
+        memcpy(env->gregs, src, sizeof(env->gregs));
     }
 }
 
@@ -393,8 +383,8 @@ void cpu_change_pstate(CPUSPARCState *env, uint32_t new_pstate)
         /* Switch global register bank */
         src = get_gregset(env, new_pstate_regs);
         dst = get_gregset(env, pstate_regs);
-        memcpy32(dst, env->gregs);
-        memcpy32(env->gregs, src);
+        memcpy(dst, env->gregs, sizeof(env->gregs));
+        memcpy(env->gregs, src, sizeof(env->gregs));
     } else {
         trace_win_helper_no_switch_pstate(new_pstate_regs);
     }
-- 
2.45.2


