Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D748D11196
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM3Z-0005a2-P8; Wed, 26 Nov 2025 15:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3U-0005KM-V0
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:01 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3S-0002cf-Fe
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:00 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso534415e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188636; x=1764793436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfwJWQq9l5xaVFukygP6b1kdZjjf6Z4zWUecnl8bZmA=;
 b=g4wHSttFKuzDkdwzFT9R60R4rQzgIdG/dXCXvxcZMUS3BO2296Nsdyw8nHwPpszN3x
 SIvc+QD1NmxOQ4Dnfa++PdbgTYNUE2xJTXp3own+kiDSr57gViFgXDkNlwARnGmf86Fu
 JQXW7FF0R03HKGe8yRhbhOUs0klhGfmDMYOyKkxxoSp/0Ci09lFglBnzLrKuuskVC/2s
 IB1MLl5J9bZa07UDRblR6RAua3obY9hccwkHEiOE3DuiZRihW1GXVw315AwyBVHPwBAS
 j7v+c53YHLXvsk54MhumA2l/JIBTsW47aIUIrOoMnnVPhdUOVoW/Lkw63MwEHuC4Lp+G
 3RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188636; x=1764793436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EfwJWQq9l5xaVFukygP6b1kdZjjf6Z4zWUecnl8bZmA=;
 b=mlNuyAaWiFxQXRaj4tbvvt0HjMAq03YSn0SU6mogzzeSI1585XDmaa0DstJDBIUMLB
 oXJ5Vi9b4bWs6F4jxMkgIeZtoEvDbRssr1cx9k+IGCtLh8afv47g5Iicljh7X+bM5P0j
 Qk+rENRbReH1q/ea8RBdql6tEsVtgu5ixaGId1xFcgqnUgrrUGgn5ONGLGPvnYhz6paY
 g7g7QIXGtfD1MYWvh4R8RtWUXYO4FjWAgimUP/InL47qcAOLUYZ62f9SYiVu9t1OEUwF
 hN2m1CADLR/MNTqmN2tsBYgzOzo+EpFQB6DLPwBCbLp6yvj/YAsIQCrznrL+wnG20F4l
 C2Vw==
X-Gm-Message-State: AOJu0YwIcI+J/yAdhnUUKgl/02mr1gLJMCwVwN3amIMkJPJaF3OB+TAG
 xJxySM8Bv3c4Qjv5vgjFuuMO3SNTEXaIb6ZIbzFJweDzJc4FlgmSID2pfh5s+ozjh/2HaaBRk5E
 0Y+jZitB5MJ4H
X-Gm-Gg: ASbGncv2y6Wa35fs0S8Q7SeEthB+NrffVohz6U0+GdqvymuN0gnzD8Z2FwOano+uklt
 MJvNWCEQ3/rUVp7mn18So0b9/yCBVTUofv4Z9g33QOnZQHKiA4HfE6LO6IXdwaJ5QaguBoJROFc
 HNWqWzWWp5q4rDz5TsfOpE1IHRgeJt3UbhJqLx+7R0q5UMawyT9QlN6Z1frCQFMF9BLV7hwJa8C
 uypMe/SFzGQPFGGnz12cvthlLl3XShSKJTwjeuVTAfQfLdk0sWYeD9IcW7XFAI51VR11stDeDTh
 Q+alM3FrXfKkUoz1fxLttZz3bWDrOP3iWBFLYyAJqvYtIx9vNm1H/kfDNzNy0lxVIQ3VqeUQVSZ
 8+LKh0W/rS3Se2sNj1J7rGWgz8G60xEtECSjSgJWLHzAGo4M9iIQ/EQpQCDamLN9K9+PAJQvs52
 pK+pkzaNnq4GfphWj6YRDgddwv8XcIiQQ7e0woCDji8mDEK+03cyreLLliH/r+re2aiNPJVB0=
X-Google-Smtp-Source: AGHT+IF0CZwJnAeZXjmhNJC4xxVAoMs/WntUBeNV1FGayZ55KSNYWge/7S1UXJJ9T2FUTscYRa9OiA==
X-Received: by 2002:a05:600c:4e93:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-477c10e1ccdmr222091045e9.15.1764188636610; 
 Wed, 26 Nov 2025 12:23:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790add4b46sm64568165e9.4.2025.11.26.12.23.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:23:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-11.0 v3 16/22] target/mips: Expand HELPER_LD_ATOMIC()
Date: Wed, 26 Nov 2025 21:21:52 +0100
Message-ID: <20251126202200.23100-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Since it is easier to maintain a plain C function,
expand the HELPER_LD_ATOMIC() macro as do_ll().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 51 +++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 85f73c9081d..f3652034afa 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -29,23 +29,26 @@
 
 #ifndef CONFIG_USER_ONLY
 
-#define HELPER_LD_ATOMIC(name, cpu_load)                                      \
-target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int memop_idx)\
-{                                                                             \
-    MemOpIdx oi = memop_idx;                                                  \
-    MemOp op = get_memop(oi);                                                 \
-    unsigned size = memop_size(op);                                           \
-    if (arg & (size - 1)) {                                                   \
-        if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
-            env->CP0_BadVAddr = arg;                                          \
-        }                                                                     \
-        do_raise_exception(env, EXCP_AdEL, GETPC());                          \
-    }                                                                         \
-    env->CP0_LLAddr = cpu_mips_translate_address(env, arg, MMU_DATA_LOAD,     \
-                                                 GETPC());                    \
-    env->lladdr = arg;                                                        \
-    env->llval = cpu_load(env, arg, oi, GETPC());                             \
-    return env->llval;                                                        \
+static target_ulong do_ll(target_ulong (*cpu_load_mmu)(CPUMIPSState *,
+                                                       target_ulong,
+                                                       MemOpIdx, uintptr_t),
+                          CPUMIPSState *env, target_ulong arg,
+                          MemOpIdx oi, uintptr_t ra)
+{
+    MemOp op = get_memop(oi);
+    unsigned size = memop_size(op);
+
+    if (arg & (size - 1)) {
+        if (!(env->hflags & MIPS_HFLAG_DM)) {
+            env->CP0_BadVAddr = arg;
+        }
+        do_raise_exception(env, EXCP_AdEL, ra);
+    }
+    env->CP0_LLAddr = cpu_mips_translate_address(env, arg, MMU_DATA_LOAD, ra);
+    env->llval = cpu_load_mmu(env, arg, oi, ra);
+    env->lladdr = arg;
+
+    return env->llval;
 }
 
 static target_ulong loads4(CPUMIPSState *env, target_ulong arg,
@@ -53,16 +56,24 @@ static target_ulong loads4(CPUMIPSState *env, target_ulong arg,
 {
     return (target_long)(int32_t)cpu_ldl_mmu(env, arg, oi, ra);
 }
-HELPER_LD_ATOMIC(ll, loads4)
+
+target_ulong helper_ll(CPUMIPSState *env, target_ulong arg, int memop_idx)
+{
+    return do_ll(loads4, env, arg, memop_idx, GETPC());
+}
+
 #ifdef TARGET_MIPS64
 static target_ulong loadu8(CPUMIPSState *env, target_ulong arg,
                            MemOpIdx oi, uintptr_t ra)
 {
     return (target_ulong)cpu_ldq_mmu(env, arg, oi, ra);
 }
-HELPER_LD_ATOMIC(lld, loadu8)
+
+target_ulong helper_lld(CPUMIPSState *env, target_ulong arg, int memop_idx)
+{
+    return do_ll(loadu8, env, arg, memop_idx, GETPC());
+}
 #endif
-#undef HELPER_LD_ATOMIC
 
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.51.0


