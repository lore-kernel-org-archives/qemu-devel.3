Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CFFC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2gZ-0006Up-5J; Wed, 02 Jul 2025 15:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fm-00066S-7A
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fh-00033K-30
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so3280013f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482743; x=1752087543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kywse2u9MhU8QPCYXPxuKeKrJVPdiRbR+9Ey6S9IQUI=;
 b=kGUOk3NRWz5NbkCVF/ZjDzNYZz4/rI+ckNJPYLzMdOcN13UWA7cnwBQpG3kuVfgI4L
 Wla0iqouRYEdv8pR77K3wiqfzoZSy/PK4KO4509A0ff1l/ksb0sFzvGin6zSfg7cZPbz
 ydii4JLxU4I32zJLw4J8xZNgOQUQLBelFDktF++CVFgnTkN1NdJ6lvRe4Xl/VXEhIbgF
 6a/NrU+3bun4dsWEXePPccKVmwArBPGGseIzYSKa6B5pNK+nPrdmtfHoIc3oJRlS2ZwU
 NEf0byuTyXTWHLzH68jRpYj0ccl6qZRe2W1wTce22i5kTsxeJv6JSaTZI1qP7sPTMZFa
 blQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482743; x=1752087543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kywse2u9MhU8QPCYXPxuKeKrJVPdiRbR+9Ey6S9IQUI=;
 b=sgk2UVU3CL8Yg8/WoX1i0IEEJ9ooMe3W3nzl2ILbaLjDXIyLezJjbOEDR9Zd2sKLpD
 UkiX9EwBADriwc78vrJyIBMri/Zgs3EIAT16fUUzr3pMRq8Slrg1owxIhR0612idq7P8
 fc2kKo3TsqzZrpTK+XVi/jzFOSeoBxlc9lgdp8TxlZvFsWcEP/Uc5unG8kWbnfMR181f
 dTLzO58CnoTrrzrTGiOBnPErND/FIcVIQH11AczIpZrmYbDweJ2A6Rh8yHN1u+nMhuuC
 7wXS6mAvZeM9YFvMsIF7ihmdwyfehgQJZx4v8aG31h0TNs6Q/VnaHaTY9aEhr54rjSDV
 WAGg==
X-Gm-Message-State: AOJu0YzrRAsJFM/oYPmoOak4nfCVPgzf7QoVz/iPayPfc8V7TPtTpetk
 qxPq5a4eNMr0buEAr4QBnp51XOyiMIdtVgEUojZboP/Ru8bnfPFk/Vc4oMQuFH/Q/B5p9HZwH5I
 0amHS
X-Gm-Gg: ASbGnct39sFrU/9rmwcOXT61j4PrNwFAlRbYMWZ4l8sJyMzX3RkzNB5GUWfa5B8Zndy
 rG3PE7lJ4fSF7IZMlO9HnX5L8OA9JG3vInlddKMDxtSWEn0rBS6U4T3U0FzQSecQdh27uDuzbKo
 gpVDqkpJEGzNHdpLwvVq9zJlfff6jZBkQOzs1FUVUwYCG1VudOjMZmIY8/ZRxLwBIQmHEawr3/V
 162oLd08KGLhZfCe8mkqT5s3WSEH7+XX9ribBsoHqWItkEwDCmLhW7NeUoXS/tIdzMAFAhBOfqH
 YicoiHcruqtevPwzIfVCCWRaZd1P8GWMS00WYvVeTs3nY2i9ozqv8oZKQ964GTvw452akwZQxeV
 Le/K9xgX91IHZIMYSq6dXaTySNP9rhXr6gVi8
X-Google-Smtp-Source: AGHT+IF5f1MuiaXv1E2LUQIq46hVrppr8hReHwlJyDdmfVxaR96pmDtGNrItgSxYdHTyX15g4e14DA==
X-Received: by 2002:a05:6000:4805:b0:3a5:3b63:58f0 with SMTP id
 ffacd0b85a97d-3b1fea8f858mr2946242f8f.18.1751482742756; 
 Wed, 02 Jul 2025 11:59:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bac51bsm5693935e9.39.2025.07.02.11.59.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 45/65] accel/tcg: Factor tcg_vcpu_thread_precreate() out
Date: Wed,  2 Jul 2025 20:53:07 +0200
Message-ID: <20250702185332.43650-46-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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


