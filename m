Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DE9E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLq6x-0003gx-0i; Thu, 12 Dec 2024 15:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLq6r-0003fc-3d
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:34 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLq6n-0000wT-OF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:32 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71e3005916aso218952a34.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734036507; x=1734641307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHgc1l1qpRSvTvA+hPA/du3JarE2ikdn84gpIsEZ7/E=;
 b=G3tfvUtlWQv17YMNSSy7Dlv94/9/DxKgFZeQHP1PF3vxXe39Gml3vXZxtOIDhil+Pi
 GOIvZZvqVbNR9sqYfbqfbz9mKhchkVcHd1TPoiDr47D13CgRLJzImjCRLw1f2Dk2Za6k
 LcMUf7303c6VED72jKj5dA3RrfDCRbWwg3qER0xctLMihRvbVkBXDm86ptZEEFUmK7Ve
 2RqLL4obVIRnln8xIQQ6S8Wxly0zhxgp52Y13ng3T61cLylxBm2bXGy4d3USxJ5fitF5
 /dpQ6JgFtzmRPbrlSFSWzTF+8X/M2QgUptAsGWJDZ9wxipeUmMbAABWtoBe4oRGV1j7I
 CQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734036507; x=1734641307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHgc1l1qpRSvTvA+hPA/du3JarE2ikdn84gpIsEZ7/E=;
 b=SuJ8LCqABkZTj30GWoWBKCc7T1fPPF96UHKXn38Lg3iuYdVeTYejXYJMfUWiaLXdot
 oYUFrQ9utEc77JmhMdFq5Pp+rXVIKM2mNEYhmqyZpSrlsaQDtnsUjuYzaa+CLdDSOJOB
 XiPE17XdgksnSfylBvPJTMeEzlNdMABEDEwIz/KWz9in6pP8eLD+UQkqfu3EZizkVwOe
 m75fCUd4GgZtFl8OZfKPnA57vQfXNsFD1uL9QJ0LNeUdyovOpexBONf/RdgYY/ODSAKp
 2s9SvzE9xfW5v39rbNXjnUeJ1zJz7ukh95LbCtTUChhNixKQ2OJgxP5WwIyhFqatkm8V
 bbGw==
X-Gm-Message-State: AOJu0Yx0lr9/XkfzaT+nZSXG4rhssdALUw5usTScqgUFyo0qG3k0n64f
 TidSwVrSBYY44YafmUWpfeLc1RR8sXOMzQChLnW4Wze/2rkr04ZQ0oZ9glXKIkTyk+6/3699KOV
 /wVw2VpkU
X-Gm-Gg: ASbGncsMEPV6rxsOo78XB5OSNe3OW3DCQlrubwsXjWoJTGT7Xx6mDvEfU4xK5u7TMlF
 4fczdhZBSXu/LotMDbZWDK87oky9B+fUJin0yhIpC9Aa+R8k5tJL1YqVAHzl828J3FTRux2orUQ
 y+dxgASEvtBSMl1SDl0NU8vgzVxZUU53BuA3dErXqxPLiREi4kJwgyOplFkU0S4HHGFp7RzipHV
 4Zmu49BBAvySUsiGCGYGZedBm9Nn8QIR1l3gV4VtU7IKTmG05Sjl//Po4ZveZyj
X-Google-Smtp-Source: AGHT+IGZdsrWMtUCicd+a7D4tz5fW/3WytgdxRzydpyddzubPsJvODk/5qAJ2M1suBSA80gco4iz3w==
X-Received: by 2002:a05:6830:658a:b0:71d:4385:6662 with SMTP id
 46e09a7af769-71e37136da8mr1304267a34.27.1734036507400; 
 Thu, 12 Dec 2024 12:48:27 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2b8197b58sm2129758eaf.12.2024.12.12.12.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 12:48:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 4/4] target/sparc: Use memcpy() and remove memcpy32()
Date: Thu, 12 Dec 2024 14:48:18 -0600
Message-ID: <20241212204818.2468583-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212204818.2468583-1-richard.henderson@linaro.org>
References: <20241212204818.2468583-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Rather than manually copying each register, use
the libc memcpy(), which is well optimized nowadays.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241205205418.67613-1-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/win_helper.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index b53fc9ce94..0c4b09f2c1 100644
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
2.43.0


