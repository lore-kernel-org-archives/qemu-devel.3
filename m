Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAE4C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmIU-000114-Lw; Wed, 24 Apr 2024 19:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIL-0000xr-Oi
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:44:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIJ-00028Y-KF
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:44:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ed32341906so481284b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714002291; x=1714607091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UcNiArx2YUV5oHwUywv/QvdvtoymVGfjzxZPBIu3NNw=;
 b=fFFJUdcqDuP4IdkIj6OWsLwIPzKvfeuL3V5TFiK+TBEI1aD19iVeo+KFXTO1HVBvgi
 n4KAp1x1xJTgqZNdX3xWyDlTT6iR8w9gW7OPh5Wzj6KGPgQVDMMasXf+rv8jc6r1sZUc
 9Goyy9aBkv8WpB7EqLuf2xQousydXSaRktoK7I2wqXm06YfdMmh1ZVtPqhWR42qNGdzZ
 IFGJKzH68aBWK9tI380nW9IgMqnW7cuKSDtqVlZ/DNaUIoRVZx3wqN1dKtYDrSsET4yy
 oNynTPHWrGUt+VD3UV2/9jTWus2C0kyVahhtQazgxuYISuzt9bN2sOF+yUL3dCw8UQsi
 IkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714002291; x=1714607091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UcNiArx2YUV5oHwUywv/QvdvtoymVGfjzxZPBIu3NNw=;
 b=msQ9Pv93J6claiU/fkFibx8HAaa63kVoI1jYuMO10MFm5uZ6YybniD88lDSVsuQq4Q
 o45mkwO68ZVMfTWl+ZF+cSqmZs5NWE15fnEn1emteEFsVRjxrUgAE5ZS6OWrgWZ14Rmz
 gAE83MElIsLgAchJeVVgQInfaiwDynpnnp/fKHdRb/t7B6BZHZdK3lWm+vRtaAjt+90g
 5kv9jrTCj10wgxSbCBjgjDTAVyfYqFpmsvTP3ZG77vYePkpjnuWwKVSgvn5AxurwsUUG
 a3LbYPkGaQ6Zs+bzVW+uq09hM5xsWByBFEqZQeAtukKoKDhL7/N9KzA7XJYRGKfLIFrw
 7DVA==
X-Gm-Message-State: AOJu0Yxs1pLJIyh8I71UrPwh4ywGVGpOrMXZfcwlaipnPEBweqvhnp6Y
 2UfohijQ0PZ4CLEZoM6TCuxAPzlSLOlZtLaP4+a/DvzWj5Z5TyS491SmX9krepdds4rL0GMFUy4
 Q
X-Google-Smtp-Source: AGHT+IEZRMbG+VqLiqglq6UFXjYojLIwOeg+Z6s4NTNFR85IiDiKl05rtLcKStEKAU+wzUgsNJGykw==
X-Received: by 2002:a05:6a20:3c91:b0:1a3:dc33:2e47 with SMTP id
 b17-20020a056a203c9100b001a3dc332e47mr4934910pzj.4.1714002291402; 
 Wed, 24 Apr 2024 16:44:51 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h17-20020a170902f55100b001e49428f327sm12531642plf.176.2024.04.24.16.44.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:44:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] target/alpha: Use cpu_env in preference to ALPHA_CPU
Date: Wed, 24 Apr 2024 16:44:32 -0700
Message-Id: <20240424234436.995410-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424234436.995410-1-richard.henderson@linaro.org>
References: <20240424234436.995410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

ALPHA_CPU has a dynamic object type assert, which is
unnecessary considering that these are all class hooks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


