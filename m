Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1024ECAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TLg-0005ly-5B; Wed, 24 Sep 2025 13:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TLD-0005Y8-OM
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:31:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TKa-0006bP-Uy
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:31:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so430865e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758735047; x=1759339847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fd0ACioI7nAwjU2+jn1cQHZUjIyZfiZiM6lI/YiscPY=;
 b=KRHJseRlxLpprt2wqnWk4gv2JEuxxyDyDlSsRA8H3egbyWN8wshZceHS+RO5IjFkQ+
 vVNkk2IKwltYCYhjh1HvhkMJGxje5xOssMRFX5JjGx+vJ/ZAnc7RvfasC95tKdqCJOc0
 baPVgeerQR2MH1ALFVmCWHZPr3WxYE1NggLY1UyifVSgJpVLLVIAnFW+bDyLRCqjmOU7
 ENRoOnZ3iJvUp2Ns8DGQOc/HxP5g9K1gyRR5x0oR21JIwi4KspO47SkF7UvfIap97Zq2
 2qad060X/IAL5nYR1XnsCa6eYZ9NiWn4H6m3d9YdbzT7FcpAc/UQev8SLyo/rPrih+El
 Nv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758735047; x=1759339847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fd0ACioI7nAwjU2+jn1cQHZUjIyZfiZiM6lI/YiscPY=;
 b=J8EbV0d3il6XfCGgY/+Ho9MpOfzZGAeuQ1xNoilQagACgirymF8VGGKUWCKay1s1Zi
 BtSwyllzKaXWgsYYXqgZMlJjFLxg6b+LtyAQBFiULLkhWQWogQN4cLRRZbG5rkWJTU5V
 5bXZhY6uAX2ZA2DFoSxDNxa4jdb40Mh25LzcNCNVpY9ANVyXXi/gmS7n4keKD2QBVjER
 oMYkeihRjnlOx+GBZnJwd4Jr+3eC9rNViwNMXtC33Qcha8XgQzDX87YtX+InBflwjYIM
 ogbyiOW0WkQxzaZWdQaSQkUstVbNLBSzfcBK1u0rTR9VY5grT2J1qoiccirnB0DpzMtT
 LPwQ==
X-Gm-Message-State: AOJu0YxHkfLso3SGdp1l4gwdPuQlahxvfh2N26trJTOtURsRMoK6j+gl
 gcqCpaeSOKdn8CKNYcwVFMXTMAcJD3+PnlEPI/bB6k8EgxRZJlbJBqTk1F6vsxHASFofTeIJvqU
 tVw3ZgX9nQQ==
X-Gm-Gg: ASbGncuO/2XKIh0prTeSZKNJv76UrH+MgVGLKFziNyDLO39Ug1yyrbQNkHXe7hWiKEJ
 IwWYMkUfMIdSlapWSB20u3GVabkVtKqBmdc9R+HaLly1icjeBqn8u1MqX/sTiywX/c1XNeEx3CZ
 1Au2yFVmprpxZx8lvJJdmlj9gmElu9duh1FNGnU9pbA56kggZ1xx59/XCX9fVaX3Sst/sNaCFBc
 zLkC80CRZiMbUT+IoL5GYD8C8ws8WogTI8w1nc0rtcZIClBhryu7eMICEKWzUN5L2spMIqc5DME
 zDhrT6MtNd5VtCouchnG6no6wvwS7zRLL8iAKpqSDt0kik/4c8BI5g402IvjzmIiLYu3on1CB3F
 r/FxjsqV3HXc/RjLObl+KOGRS2tj08lHCuAqVoM9G3yTuCxnL8F5JkgzTMe1RjbsL6GcgSLmA
X-Google-Smtp-Source: AGHT+IE9JiUFqPAwF6RmQ+hjWrNP2s1/eKDamfcsa4fA52+Ybz+YIc8X7LNr//8o5jV2aMbvWpuNtw==
X-Received: by 2002:a05:600c:8215:b0:45b:71ac:b45a with SMTP id
 5b1f17b1804b1-46e329b2583mr6900535e9.11.1758735047128; 
 Wed, 24 Sep 2025 10:30:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9b1dd4sm39652165e9.8.2025.09.24.10.30.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 10:30:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 bharata.rao@gmail.com, benh@kernel.crashing.org,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] target/ppc: Re-use gen_pause() in gen_wait()
Date: Wed, 24 Sep 2025 19:30:28 +0200
Message-ID: <20250924173028.53658-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924173028.53658-1-philmd@linaro.org>
References: <20250924173028.53658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Avoid open-coding gen_pause() in gen_wait().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/translate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a1a97e0fd2e..1b5d2521deb 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1982,17 +1982,18 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
 
 /***                            Integer logical                            ***/
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 static void gen_pause(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_constant_i32(1);
     tcg_gen_st_i32(t0, tcg_env,
                    -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
 
-    /* Stop translation, this gives other CPUs a chance to run */
+    /*
+     * Stop translation, as the CPU is supposed to sleep from now,
+     * giving other CPUs a chance to run
+     */
     gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 }
-#endif /* defined(TARGET_PPC64) */
 
 /***                             Integer rotate                            ***/
 
@@ -3368,11 +3369,7 @@ static void gen_wait(DisasContext *ctx)
      * to occur.
      */
     if (wc == 0) {
-        TCGv_i32 t0 = tcg_constant_i32(1);
-        tcg_gen_st_i32(t0, tcg_env,
-                       -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
-        /* Stop translation, as the CPU is supposed to sleep from now */
-        gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
+        gen_pause(ctx);
     }
 
     /*
-- 
2.51.0


