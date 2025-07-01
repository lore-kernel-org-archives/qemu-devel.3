Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177A0C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDf-0003Vc-RZ; Tue, 01 Jul 2025 10:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDd-0003RM-FZ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDb-00078x-Ah
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450cf214200so28566425e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381056; x=1751985856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kywse2u9MhU8QPCYXPxuKeKrJVPdiRbR+9Ey6S9IQUI=;
 b=pyGI2OEG6JrzRtWnJa91e45KgTiQtKdvK97K2gQWZ9zpyZx1MrO//fqxW4vJbzrD5D
 U9OEf7D1Np50E628F80K9+XpVFVDazw9nNS+bpMReQA1mNAOS07a+qJ53qpRPO6SzTXe
 yXsXEc/sYGMS6kb+KjklPiatb2VTIdTSzLGi9DLidP9Mam2WdF1wtx7thadlMAhSMhow
 /fTm1MKbd3CmD3Poxt0sOT7zv+dpa6nFplKnW2Gfa4EJDHvfTTQhbyB9LGiOy5pXhqTT
 n4gCvTy3vWix/Vc0iVmdmfTqTJ2xD4L5hVXful3EicBN+eoRAM2vbfOCjdYkDdqpLl+X
 r9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381056; x=1751985856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kywse2u9MhU8QPCYXPxuKeKrJVPdiRbR+9Ey6S9IQUI=;
 b=LGuOIapChF5971f1HeO61V5NxomXds1fHyaqWrObTAdqtUmzpKR5SnEenlfKyuU7bz
 433/Btk0+2c2nb/gtLQEsfHwNkjK7zjsjycHE+iG3tQyzvKRwZl/3vwPigC7ynKQJsRj
 QgwkhQlZT6G/K2PmgK43kn132okfKBxu0Nooy19wzHKRtaVGEAhirSQJLcuE0jxZvSp0
 xV27K75beWJLVpnIVOrOlgJ1C45GcextHfsGc+Jp/EK/oqsg31S/rMOFykGI42UgCMLQ
 DbOPdMqBahH1WZPDNMziRltHBjW38ZXSMzqw11UFIHlpZrkQ5Jclwwcg8slMhOcZh53g
 7aLg==
X-Gm-Message-State: AOJu0YxNhiM2IdjdElZShkxq1XaSoUitD0IUw7lfh3q9m+ySWn8n3RWJ
 u55zrpa/JvwuxQxO5URPaxcCggwxHMK/M/rRny3RtOXHZKFrOUaPu7iJPf+N6WcLRU/YZe8Y65Z
 Z904P
X-Gm-Gg: ASbGnctFUuL32sMrvFYB7n1jXGiFO/YGgxWTJ3U9iipCORJmFiKmmOVGgwjPA3NzGT+
 3JOvNGVW4W99ubf+YiMC9gGq97CRJB60J7DmF9DNzri5LkUMSiJkpA/HJOoz/USVNe4ckVOFe8/
 za5ziy7F4DKHdBFgNsl6l0lGz7UJm1tFNdHwnhLIX7ggkq9W10pmf0VoFGyfKgS/Eqlw8i4IvM0
 pS9bQNCFRMlWDImyFyT9EYparuO6lFK+akXAVeaEc8+EZe8AwvVeZsJYxNZZLaycdXseeYO52MD
 u8wCYZJcjb2q38mSulNpfQ43fn3eFy16G8P2foHTLpePxAavbYSXMlldy8Jlvj5keIZGx6tjR9y
 AC6TBVToROdhVhxbokmf4TuXLj1HpQnTOJI5V
X-Google-Smtp-Source: AGHT+IHDmbNVArM/W2fKHWa3khcPay7FObbQC2jcTJngJdHbmLv5gyPAsc9TGpCKoyl+GY0JvwbRog==
X-Received: by 2002:a05:600c:8595:b0:453:5fde:fb5b with SMTP id
 5b1f17b1804b1-4538ee7130bmr128989675e9.19.1751381055841; 
 Tue, 01 Jul 2025 07:44:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823c57d7sm207939995e9.40.2025.07.01.07.44.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 45/68] accel/tcg: Factor tcg_vcpu_thread_precreate() out
Date: Tue,  1 Jul 2025 16:39:53 +0200
Message-ID: <20250701144017.43487-46-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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

Factor tcg_vcpu_thread_precreate() out for re-use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 1 +
 accel/tcg/tcg-accel-ops-mttcg.c | 3 +--
 accel/tcg/tcg-accel-ops-rr.c    | 3 +--
 accel/tcg/tcg-accel-ops.c       | 7 +++++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 6feeb3f3e9b..129af89c3e7 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -14,6 +14,7 @@
 
 #include "system/cpus.h"
 
+void tcg_vcpu_thread_precreate(CPUState *cpu);
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index dfcee30947e..462be7596b9 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -133,8 +133,7 @@ void mttcg_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    g_assert(tcg_enabled());
-    tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
+    tcg_vcpu_thread_precreate(cpu);
 
     /* create a thread per vCPU with TCG (MTTCG) */
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 6eec5c9eee9..fc33a13e4e8 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -311,8 +311,7 @@ void rr_start_vcpu_thread(CPUState *cpu)
     static QemuCond *single_tcg_halt_cond;
     static QemuThread *single_tcg_cpu_thread;
 
-    g_assert(tcg_enabled());
-    tcg_cpu_init_cflags(cpu, false);
+    tcg_vcpu_thread_precreate(cpu);
 
     if (!single_tcg_cpu_thread) {
         single_tcg_halt_cond = cpu->halt_cond;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 95ff451c148..861996649b7 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -41,6 +41,7 @@
 #include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
+#include "hw/boards.h"
 
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
@@ -69,6 +70,12 @@ void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
     tcg_cflags_set(cpu, cflags);
 }
 
+void tcg_vcpu_thread_precreate(CPUState *cpu)
+{
+    g_assert(tcg_enabled());
+    tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
+}
+
 void tcg_cpu_destroy(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
-- 
2.49.0


