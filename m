Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1907FC25B10
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CoT-00077d-7O; Sun, 28 Apr 2024 18:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoO-00072R-26
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:57 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoM-0005eD-9T
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:55 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a58e787130fso204938966b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342552; x=1714947352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pl64tl5YQ1s8CCdAHkFJJC3DjPcNFHytDHp/sUwDIA=;
 b=qlLWQJnReeS3YoeLxcTzzR9/4lIi/DsT/X+cjlHOgJqRHTftSDXM4zRkZiXPgg44Zj
 BeYLfZyotro96WdQFUeSIffRC72cdYzO3u2CkR0ZzOJQFJRzSbtTtbE+VYQGlyfUvJUY
 bun6VLkH+OCy0xHV1FffE9m00ouXHhr5O527XZLPmJC5GEMp/+wWqCUenZtpHLarfd3S
 lrv0H7V0GJ3w4fu26uzOPLOLTZSPzNBAYurehLskolgeTWYZ6dONd9lBgKMrh2OgF0F9
 +68WBpbGIgtT26rIMerABRLwTSmjVRchV60HyIByzPc5aQ+cFXvdd1o5RL4N2bwCK+2J
 ki/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342552; x=1714947352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pl64tl5YQ1s8CCdAHkFJJC3DjPcNFHytDHp/sUwDIA=;
 b=Pma81riL/7NV8pl2lkL7wiQdUgR99cQ4NKZC3atQHMMaJPCLev1m+rn9muEJmf+y9g
 TKPk45fXtNub5asDQ0degOa3ErfEXXIwNwG6z/6HwbWIbx4x7geztQv51k6+r3NpfArU
 JgqbYFfG5FYrvR+PpCy4sOnNu73kVKrQdLnzOu3UrUUpWl7BRasFnHfcCPEk2RPIO7AK
 JOygNXLkwQ86L9qY05239Gu4+EySbrAjFttAc89YksHj+Fxf/YIiOrWkUJXxypMmoBOc
 8ki/cI91p8KtJSXpTQbIk6S9DvDVYR1zkBbYnMoW6OlOVHoDue5vz6+LJyWVFyPvQtrj
 11kw==
X-Gm-Message-State: AOJu0YwUFBg40Ue3vWVZDYpcHPRQMR1hJRnKl7kRNlcRgVF9xME7Jwsb
 yJYGPZiPJA/p+3IKyjGjipRnyLl64qtk8CD4jUOwlKpNTLvY5vXwk3R7l4vkvydawQuYWpfpHBi
 t
X-Google-Smtp-Source: AGHT+IHC39XAp5K2Qc7+wVReZgJ2b4N0ntfbN+7HcK/FiCmTDJd3cqknQD02Y+Cuxg57+J01xkQDhA==
X-Received: by 2002:a17:906:a216:b0:a58:bf24:edc7 with SMTP id
 r22-20020a170906a21600b00a58bf24edc7mr7487607ejy.20.1714342552492; 
 Sun, 28 Apr 2024 15:15:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 bi10-20020a170906a24a00b00a54c12de34dsm13120778ejb.188.2024.04.28.15.15.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/24] accel/tcg: Allocate per-vCPU accel state in
 create_vcpu_thread()
Date: Mon, 29 Apr 2024 00:14:37 +0200
Message-ID: <20240428221450.26460-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/vcpu-state.h          | 7 +++++++
 accel/tcg/tcg-accel-ops-mttcg.c | 2 ++
 accel/tcg/tcg-accel-ops-rr.c    | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index e407d914df..d0dd1bbff8 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -8,6 +8,13 @@
 
 #include "hw/core/cpu.h"
 
+/**
+ * AccelCPUState:
+ */
+struct AccelCPUState {
+    /* Empty */
+};
+
 #ifdef CONFIG_USER_ONLY
 static inline TaskState *get_task_state(const CPUState *cs)
 {
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index c552b45b8e..767b321a0d 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -35,6 +35,7 @@
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
+#include "accel/tcg/vcpu-state.h"
 
 typedef struct MttcgForceRcuNotifier {
     Notifier notifier;
@@ -135,6 +136,7 @@ void mttcg_start_vcpu_thread(CPUState *cpu)
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
     g_assert(tcg_enabled());
+    cpu->accel = g_new0(AccelCPUState, 1);
     tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
 
     cpu->thread = g_new0(QemuThread, 1);
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 894e73e52c..419b94f786 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -36,6 +36,7 @@
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-rr.h"
 #include "tcg-accel-ops-icount.h"
+#include "accel/tcg/vcpu-state.h"
 
 /* Kick all RR vCPUs */
 void rr_kick_vcpu_thread(CPUState *unused)
@@ -314,6 +315,7 @@ void rr_start_vcpu_thread(CPUState *cpu)
     static QemuThread *single_tcg_cpu_thread;
 
     g_assert(tcg_enabled());
+    cpu->accel = g_new0(AccelCPUState, 1);
     tcg_cpu_init_cflags(cpu, false);
 
     if (!single_tcg_cpu_thread) {
-- 
2.41.0


