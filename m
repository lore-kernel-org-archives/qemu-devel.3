Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C9CC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cnq-0005w0-I3; Sun, 28 Apr 2024 18:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cnm-0005uj-TI
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:18 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cnl-0005V5-5N
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:18 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51dc5c0ffdbso263357e87.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342515; x=1714947315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+LV9oUMRwRHrcXmsm53k8GPuSzrV4FPRLpNCNB4qFc=;
 b=yW7nXVE9UMSNgdIQVYPeILGvKoPj0qqrAemeG/1sGD3dGCVxwk67N82wuHNfZB4yoh
 euAdsB+ptQGSUeNv04Dft729nhIkch2IwAlTf6ZfJf1wZOGCerRP04ey2oEWNZpAVHK9
 G+uepxaQ6qlfr84u1KM8dSrfmaU1Jl0UOxLlryZlqItkYDlP2GYSMUdqaDs7hOLKd4Qr
 2pamaXiCP5QAAlymKeDHauXFneqAMjWt/2P4QjiVqWcOFGMRG/xrxXEzGPa5MGmW5ho6
 +as35t2gDImrhAbjzI9aCuuRzvNztgKgxv4D9SaycyEze9qSf+0pFZQepLphuwzkY5RH
 jQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342515; x=1714947315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+LV9oUMRwRHrcXmsm53k8GPuSzrV4FPRLpNCNB4qFc=;
 b=rZJ2nPcPxeVjXDx1YuBe+exWghG4UjGiP3DiStrQiC7h4p5wToWRMRkjhczUjY1BI8
 R+CWLPm5X87Oc8ya2UHv1SvrO3fpJ8dD7tTMCmgjRIPxx1fI4WzhZ4wVM6MZTINl3Bve
 wWFc3zupFcg1FsfuxjQMGrSD+d09XG1dFfr/t3HHBWtwOPpld5ZgLlCEjVohE6N2D96L
 qKWk5dE2o/QCR/+VG/JNvoNQiEc8tBez4ufzbNVjNQDukpmzVhRWfW7tpgyBetilRoIh
 49uP2VGclF6nhgEAi4sQUfCz1Nz/+0KbNymfp9YHggvGEOMl8faCcEcvuipMVb51UF6+
 J7aA==
X-Gm-Message-State: AOJu0Yyu1TygjS7zICoFTjtYisumDvXL7A1TwRcyaxPJQoAS7Li5VX7g
 ItH1NiqP8vQhsTIPIGktYvJDJK7ScI2Bw+alFliZ8kEk0YxNicSJ6MKbkCgIBEi5VzVJIGmhy9v
 D
X-Google-Smtp-Source: AGHT+IETHybTnbV9iZwvYmsu33kUx/FHmJpY497B1CuxWAgA058EzJkztFn6f763thocIX00+VHiQA==
X-Received: by 2002:a05:6512:130c:b0:51d:3fe4:c3cc with SMTP id
 x12-20020a056512130c00b0051d3fe4c3ccmr2919256lfu.0.1714342514869; 
 Sun, 28 Apr 2024 15:15:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 eb16-20020a170907281000b00a58764e6c45sm7413730ejc.173.2024.04.28.15.15.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/24] accel/tcg: Duplicate cpu_exit() for user / system
Date: Mon, 29 Apr 2024 00:14:30 +0200
Message-ID: <20240428221450.26460-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

We will introduce a per-accelerator vCPU exit() handler
for system emulation. Duplicate cpu_exit() because the
handler won't be accessible from user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/user-exec.c | 8 ++++++++
 hw/core/cpu-common.c  | 8 --------
 system/cpus.c         | 8 ++++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f49435df9d..404d8a145c 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -46,6 +46,14 @@ void cpu_interrupt(CPUState *cpu, int mask)
     qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
 }
 
+void cpu_exit(CPUState *cpu)
+{
+    qatomic_set(&cpu->exit_request, 1);
+    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
+    smp_wmb();
+    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+}
+
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 9b3efba82f..cbafc79033 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -78,14 +78,6 @@ void cpu_reset_interrupt(CPUState *cpu, int mask)
     }
 }
 
-void cpu_exit(CPUState *cpu)
-{
-    qatomic_set(&cpu->exit_request, 1);
-    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
-    smp_wmb();
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
-}
-
 static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     return 0;
diff --git a/system/cpus.c b/system/cpus.c
index 68d161d96b..e0530ad603 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -419,6 +419,14 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     do_run_on_cpu(cpu, func, data, &bql);
 }
 
+void cpu_exit(CPUState *cpu)
+{
+    qatomic_set(&cpu->exit_request, 1);
+    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
+    smp_wmb();
+    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+}
+
 static void qemu_cpu_stop(CPUState *cpu, bool exit)
 {
     g_assert(qemu_cpu_is_self(cpu));
-- 
2.41.0


