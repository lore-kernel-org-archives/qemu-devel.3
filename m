Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D976E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBTJ-0001Yj-Fx; Fri, 13 Dec 2024 14:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBTG-0001OB-4M
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:37:06 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBTD-0005D2-Se
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:37:05 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3eb7ecc3c54so1134603b6e.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734118622; x=1734723422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHgc1l1qpRSvTvA+hPA/du3JarE2ikdn84gpIsEZ7/E=;
 b=iS+2DhVNN3hRQAmnW2XhE5lHqcctXIl+XX4NXn/nRyVqcgpBBT3Ykv7td6H95/2Gzu
 OJ48oGovvPCwWZOO7vrpMJSh4MeXqH3MCA2DjUtfFr++sgHdgTYSrNJ4x0hsv1biCc/c
 HGVzYmikJ9IXP/pcaiQqwxktZUhwI1nZ4fsbBS4pbDcLTUgHVgBS/Mn0RtWZjD6Bzzcp
 8fr9mxb0BwpdVWLvjKpOLfJ7IafmwRD12KpmilyugHxol7AFQYxRRqouK8VCKFPy5Nfm
 tAOxUHJFIXvOoLBe6Ue9a3eeRUuSrdY7v1evxa1DiaZ1hZW/SMgM5lPsvpCI4nSXK/xe
 EWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118622; x=1734723422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHgc1l1qpRSvTvA+hPA/du3JarE2ikdn84gpIsEZ7/E=;
 b=bN+hRlWIzypuc5hdgt3SvlgMMsscbqK0O8+IqyXf8CfQL3kmQ7k6LOpcSSkkzYqUjL
 Deharh/myCQxKlT+qmjBtrgmwM3SUWHoBRgzFkZwbQ9atzVD9JplPiXJtGl2Bdk6sYL7
 W1ct84l4KUviUES6Ifa6NeBAd0pbq226peQSNRl6HWdN/fQdB8hXp4/iQW3xYZpj73Sd
 lZ7j3tQlMPVayWoAVcQM4sYGdh4qtDLb8Af7xI/SxI6gTc1/7JWKZUaoqabhJl0PcxWj
 TRlmpJsOAcbevhtpOLSOGVP9SLNvkzLBgWHFwcv6fc0DhW6eWBaL4BacXufYZ/RNF21v
 waaA==
X-Gm-Message-State: AOJu0Yy7IushDePyMys1NHJZm/6s/fvXaL23SJ7E4HErmMb5xV41NR+T
 +nJfFruLJUEZuBlmZDuqTmwxQq+PnCVw1IO+qfouDUjJAVMU279rXiKiTf4xnvxkMrBDgbWnLtD
 48cin4okQ
X-Gm-Gg: ASbGncsHcQUXtC14nLoiNrCoTnZfyElu0kh9AsnLvudJkJOEWaLPYNGV1KJKiy9SaDx
 AYFjT9T+DRzwEmJaJYdIiz19a0gmWVrAlkjMFQmqX2ZjFNGgaXK20yl5mlr9tfm9Pfvg34jinYi
 nubtAYj1XyMJZ20vnLmNYyMiNnYtjpNqTvd7OMY/HqeSP7lEzXf4DSp97BTNY9VR+Vk4JAqahFu
 dKAZu5pNRREGk6taGoBX8vP86dv48KgM743598wL5eTTCagaUsLzEmsQRx0GXfP
X-Google-Smtp-Source: AGHT+IFG7GCxsgRnm6iDR7NRyLUgDqn6xqLfITFvZAApZrlBiMdjU6ZI9fQftE2p7wcu46JTRRbPxw==
X-Received: by 2002:a05:6871:4309:b0:29f:9554:9b94 with SMTP id
 586e51a60fabf-2a3ac6c3984mr2175028fac.18.1734116890717; 
 Fri, 13 Dec 2024 11:08:10 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 4/4] target/sparc: Use memcpy() and remove memcpy32()
Date: Fri, 13 Dec 2024 13:06:38 -0600
Message-ID: <20241213190750.2513964-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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


