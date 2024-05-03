Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD89C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nDY-0000mz-J3; Fri, 03 May 2024 03:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDW-0000mW-JX
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDU-0001Ev-Rj
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41dc9c83e57so9514845e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720822; x=1715325622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oukcdiVQUJdJhgIgSZBe2+14jjl41PU9P9dpGWfTjTk=;
 b=dcYmfF/EtOphQuIq3jWxJ4YtudV6e9gc1wVOLZUax7vj+JMabRayq4zCf2rGDUFita
 jUzjy/iREpX0tU6pJ1XXlKYLCol3kVXa1+Dlv+wvnbLRlquwDB7Zj163FYEZIm2YTy9S
 tPC4BSxU2Fn9jeJJPuzLdc21j2KTLSPjCLaKdKKzSDFDVFe6oSZcutl5AgL7aJ3mBno2
 m0o9nPUDJFPZeJeqpIZ9BdPoS10NgmPrXzbv65haxukKaLRLW7ZXtQII2IwqA7OTZw7t
 Sx+IE95540L3saj0RxjEUmZ4RjKyAj/wZ83ScvwY+N4KoqGvb/BCoIWBE8mbP3J14EEX
 MlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720822; x=1715325622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oukcdiVQUJdJhgIgSZBe2+14jjl41PU9P9dpGWfTjTk=;
 b=noPATPhO+EKAVJbSjBCcqf3hF9Y/YfPmhUrjMBv6lM2ZuTd2XX2bJfNvb0y4cTvzu/
 XZJaH5TlAX73gNNqWRhDVtJVmuiS+iA70FGg8hBwBtes26lcoE7ae8+RjKCSWiSh/sQe
 v9S/spyB5utKxoYOcw5Iga+ZIe31YBuv7DL4Vq2yuv0+n8rjCMJxGnlG32yFANUCP/WU
 CvbZlRhBwIN9hX7RuEQSPy5KZH1Gl/juGbmPtRwV6Nt/b/svgY/0U+f55noL5AlCE0mF
 Zz7kpmHDOGz3mFnkWMKz7cigiJ6XxZA6RDvP01C7kNJUpawB949ogalKUdPF3VXojJUK
 O8dQ==
X-Gm-Message-State: AOJu0YwuWyvd1FEv2Loek9lUVsoiyqGwiQcs0mAfrrkX0NwIv7kSBf68
 Q9lSkE2Xr+qEyD2TzlWXNxcW0c7UBC+WPhVvU422VlREmgYyYNWyAiLdQOxkQMZhQ0edKeqUzKm
 K
X-Google-Smtp-Source: AGHT+IF+yYBvz2+rAu6snEmmeAWQ6Kp5GRIEJzmeLgwZY24GezuB4EMpbDefaeDlz25DADJNsrIHGw==
X-Received: by 2002:a05:600c:4508:b0:417:eb5d:281b with SMTP id
 t8-20020a05600c450800b00417eb5d281bmr4361515wmo.17.1714720822399; 
 Fri, 03 May 2024 00:20:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c384700b0041c12324eb6sm8377191wmr.22.2024.05.03.00.20.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 00:20:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/9] target/alpha: Use cpu_env in preference to ALPHA_CPU
Date: Fri,  3 May 2024 09:20:05 +0200
Message-ID: <20240503072014.24751-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503072014.24751-1-philmd@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

ALPHA_CPU has a dynamic object type assert, which is
unnecessary considering that these are all class hooks.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/cpu.c    | 15 ++++++---------
 target/alpha/helper.c |  8 ++++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 05f9ee41e9..f98d022671 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -28,25 +28,22 @@
 
 static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-
-    cpu->env.pc = value;
+    CPUAlphaState *env = cpu_env(cs);
+    env->pc = value;
 }
 
 static vaddr alpha_cpu_get_pc(CPUState *cs)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-
-    return cpu->env.pc;
+    CPUAlphaState *env = cpu_env(cs);
+    return env->pc;
 }
 
 static void alpha_restore_state_to_opc(CPUState *cs,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-
-    cpu->env.pc = data[0];
+    CPUAlphaState *env = cpu_env(cs);
+    env->pc = data[0];
 }
 
 static bool alpha_cpu_has_work(CPUState *cs)
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index d6d4353edd..c5e4958f8b 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -124,7 +124,7 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
                               MMUAccessType access_type,
                               bool maperr, uintptr_t retaddr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
+    CPUAlphaState *env = cpu_env(cs);
     target_ulong mmcsr, cause;
 
     /* Assuming !maperr, infer the missing protection. */
@@ -155,9 +155,9 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
     }
 
     /* Record the arguments that PALcode would give to the kernel. */
-    cpu->env.trap_arg0 = address;
-    cpu->env.trap_arg1 = mmcsr;
-    cpu->env.trap_arg2 = cause;
+    env->trap_arg0 = address;
+    env->trap_arg1 = mmcsr;
+    env->trap_arg2 = cause;
 }
 #else
 /* Returns the OSF/1 entMM failure indication, or -1 on success.  */
-- 
2.41.0


