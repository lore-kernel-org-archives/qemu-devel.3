Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5347BD11198
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM3A-00044g-SX; Wed, 26 Nov 2025 15:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM34-0003tk-IN
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM32-0002VW-O8
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so738445e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188608; x=1764793408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vceLppWO/UrgbDY1SaGLlR83M8KLMGCrBYU9iCa1jJA=;
 b=VyBu94LI5Y5TfM9Ele3JDOUyG8zqMBpav8X8XyL+2OQKg9pabvarLUFRKKTGwWzKKZ
 OnvVIui60/xo7GuNwthy84rQS7EZmsjMY+88Nr4tYX+lD024L+Fr3nVYFCP6uYoa4TqM
 p5pLjCGZsKKHFs6YeX/xzDQQoJCjYjjgRwTVBZixkOqP89K02gt9gz6zvX51aPsQPmlX
 Tw3NEp56Wqb4Yit3BfeSodyMQFbJUccj2iVZxL9MeD9Xn3S1R5B0GV6SRy/McEyCGKSL
 uCj4mVL+sMOPoujlNvTzJ93V28eBpFPx/m3KIF+DyRn7PZ4rbY+C/ep4aMr9So4zBJpX
 2nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188608; x=1764793408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vceLppWO/UrgbDY1SaGLlR83M8KLMGCrBYU9iCa1jJA=;
 b=nQnA3qZoS6UaJOqNgF0SbW7UpAvEECRyG0OJIqQc17Z4ffG7N+aLjf2XgfJqUltwFL
 J2Forhe5rF14ptbtQSWdVxyLNu2Yg9ktHRKIHJaeMJU163BgWsvqbtPAx8KQNA7sI995
 b2PgitocRiCVOV0Ww/12O+PB1U6J7qXb+72DnED9C+MB8Tpx9lYVDUexAoIKAXijOrJE
 tRYtzMTh84PCRnG3CkCLuNoq07KhOZXfRT34KIieuIlxRTYSgM/B+N2n8tNrLkuxr5wU
 X/n0FVo+dl7Hot2E7D93g6MXDAlW5YGtBniT0T4mzafjkVxpl+6RWykgkcVkmg2BoFYR
 poEQ==
X-Gm-Message-State: AOJu0YyuxbuPjQSeomO8k+RYh5l48pb6TN6SOoclJD01nKVcAo4jSiuo
 PirC9xOpS9yurtKdOqdbIK237HJ5U2UURJ5iOFGPqBkH3wdRYPrr+YXjxtlbVv73dCZofYzlYu/
 61c6PxeZLkWuT
X-Gm-Gg: ASbGncvL4cDimC69HCDadR3+n4EFvywbx3k2N87V+COtmXcKsEXA4riyZ1C85eQ9d9L
 Q38o4Wguod/UiGRTIpPXgFShZZ+x5w2Bzh4oPMFm10OYCXyYQWYJoK691NNPBDhnzNLCJYLnHfb
 72emEVl+77VOoHGMxnf8XfFvE7aPCffkS7dw1LKjq/ojHxFiDFlqI6QZQBT87KugbVbzKx8cOtQ
 JKRd0tuv7zfBGTjX3Ru7e9zMFeWp5+XvrZdaYHum9hptf9HUL9Dl5K8ehB43yP+jQwZDe/FhoB5
 T4nwODMLR+JUq6kg81HxQNQv6JRXRiL+hL8+mljH8lpWvFkusUnYod3Hpogu5/UDppJ1MrXtd0f
 aZd4y5BTaKUC98jQO5MPr6Ye5WuscBkHK6D0BGUtFNrGibaslq30EST+Ha/r725ztQiNJEWpp4U
 wup6P66+couKsWrhl0mTNGIMFGo539aHNxpIg4yvb7rEwbSJgVZj7o5MA9EIik
X-Google-Smtp-Source: AGHT+IEZVb5qIrGBWKf8boEUT6JadFFAAFwl839thRDq8jpaEkVTpJiTtflNP59zKSir365tN6ufQQ==
X-Received: by 2002:a05:600c:1547:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-47904adff1cmr81076635e9.13.1764188607986; 
 Wed, 26 Nov 2025 12:23:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790ab8b21fsm62615265e9.0.2025.11.26.12.23.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:23:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-11.0 v3 12/22] target/mips: Introduce loadu8() & loads4()
 helpers
Date: Wed, 26 Nov 2025 21:21:48 +0100
Message-ID: <20251126202200.23100-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Rather than using complex cast via macro, introduce a pair
of helpers doing explicit casting.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 10319bf03a6..c1c4a60cf3f 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -29,7 +29,7 @@
 
 #ifndef CONFIG_USER_ONLY
 
-#define HELPER_LD_ATOMIC(name, insn, almask, do_cast)                         \
+#define HELPER_LD_ATOMIC(name, almask, cpu_load)                              \
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
 {                                                                             \
     if (arg & almask) {                                                       \
@@ -41,12 +41,23 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
     env->CP0_LLAddr = cpu_mips_translate_address(env, arg, MMU_DATA_LOAD,     \
                                                  GETPC());                    \
     env->lladdr = arg;                                                        \
-    env->llval = do_cast cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GETPC());  \
+    env->llval = cpu_load(env, arg, mem_idx, GETPC());                        \
     return env->llval;                                                        \
 }
-HELPER_LD_ATOMIC(ll, ldl, 0x3, (target_long)(int32_t))
+
+static target_ulong loads4(CPUMIPSState *env, target_ulong arg,
+                           unsigned mem_idx, uintptr_t ra)
+{
+    return (target_long)(int32_t)cpu_ldl_mmuidx_ra(env, arg, mem_idx, ra);
+}
+HELPER_LD_ATOMIC(ll, 0x3, loads4)
 #ifdef TARGET_MIPS64
-HELPER_LD_ATOMIC(lld, ldq, 0x7, (target_ulong))
+static target_ulong loadu8(CPUMIPSState *env, target_ulong arg,
+                           unsigned mem_idx, uintptr_t ra)
+{
+    return (target_ulong)cpu_ldq_mmuidx_ra(env, arg, mem_idx, ra);
+}
+HELPER_LD_ATOMIC(lld, 0x7, loadu8)
 #endif
 #undef HELPER_LD_ATOMIC
 
-- 
2.51.0


