Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51243C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUafa-0007if-Fr; Mon, 29 Jan 2024 18:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUae1-0006lq-RB
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:26 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadz-0008V9-Sx
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:25 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ddc5faeb7fso2586395b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569342; x=1707174142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeBfHlDAifxu4F1/UNQzzGCEUArq4HbYf2mScaRZKZ4=;
 b=R+i/ymPyT3LhQ9KcRwcs2NEiEGaDmz3bXPpSK3CmDbTXzujNDRf/qhxw6WfhmjKs7d
 nE0rSdjhBXYQeXbM3c/01lChxCAEWkXPtrVeo8xsYmVZkH5w0jhNM/+UDT93tboWKneF
 c3fdlnrqxdX3pL94xTb3QrHMrMPZXYC+zn/oB5EwRLyXDWzHUAZjphgUn7+LDMW213io
 NhBKd6Dj5+zg/LCCcjcKlDpAVZh6E6TFXDTzL9MP1Zl3iTzN0bJvV5VS3LE85IyJzImY
 jqTrIrSoqVMwofeBP2012wPWPgqBpY8gxpamoBn7CD8JBav7QTheDIr1cLX86SGjMV5X
 +yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569342; x=1707174142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeBfHlDAifxu4F1/UNQzzGCEUArq4HbYf2mScaRZKZ4=;
 b=WEMcUKWfThRfCTCyHy3ZG/fAwQKWOx6fOtuE+726AAOWAph+z4Nj4eGaJjfL0Fr56N
 wqgcPvO0C+BXf4CuU+X0tkDf+MUENOJE/894sIahREXtAEAGaqc1xzmaD+GRyV+63lXb
 ITHFdzXSRqIJaNYgZUK10Hj3fyCovyps5iwKxI0vApcQHuxqjMNSPcFEfsuI5P9DBMN6
 WOf45V7zdOlm77SZD0nPrNr1wybsp2ig2BBbSP0EgdHDB5Z3mH9+7ZTThVGhhVhKV72a
 eoiy5bPMfyioi9ftdxUKUvfThBNKxixtzW3yVAiz+R/J/4SogXgAZLqtezFdFsJ46FZ7
 /93g==
X-Gm-Message-State: AOJu0YzZSRC1BwaNaloukyZH8PLWLF9GC6bie2plLLTz9Vs1sXU/jG26
 ztRF8TGdEbg3BehOAw20Unp34wsy64pMER9ZSO/v7OnlA25+aJwJSArJThDq6LhZINmFR9FiZC9
 2Pks=
X-Google-Smtp-Source: AGHT+IElodDrhcfyaV5dBLowKtw8DZw8outmvFYRbBKYomg6QZnZcRGlFXSEbz/OHRPcrZEDPchoxQ==
X-Received: by 2002:a05:6a00:2d21:b0:6de:2f30:9aa4 with SMTP id
 fa33-20020a056a002d2100b006de2f309aa4mr2988012pfb.33.1706569342315; 
 Mon, 29 Jan 2024 15:02:22 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 21/31] accel/tcg: Rename tcg_cpus_destroy() -> tcg_cpu_destroy()
Date: Tue, 30 Jan 2024 09:01:11 +1000
Message-Id: <20240129230121.8091-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

tcg_cpus_destroy() operates on a single vCPU, rename it
as 'tcg_cpu_destroy'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240124101639.30056-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.c | 2 +-
 accel/tcg/tcg-accel-ops-rr.c    | 2 +-
 accel/tcg/tcg-accel-ops.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index f9bc6330e2..17c7ed00eb 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -14,7 +14,7 @@
 
 #include "sysemu/cpus.h"
 
-void tcg_cpus_destroy(CPUState *cpu);
+void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpus_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index af7307013a..bcba314a65 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -118,7 +118,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
-    tcg_cpus_destroy(cpu);
+    tcg_cpu_destroy(cpu);
     bql_unlock();
     rcu_remove_force_rcu_notifier(&force_rcu.notifier);
     rcu_unregister_thread();
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 3208035d85..0617f66b5b 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -131,7 +131,7 @@ static void rr_deal_with_unplugged_cpus(void)
 
     CPU_FOREACH(cpu) {
         if (cpu->unplug && !cpu_can_run(cpu)) {
-            tcg_cpus_destroy(cpu);
+            tcg_cpu_destroy(cpu);
             break;
         }
     }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 813065c0ec..9b84b84218 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -63,7 +63,7 @@ void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
     cpu->tcg_cflags |= cflags;
 }
 
-void tcg_cpus_destroy(CPUState *cpu)
+void tcg_cpu_destroy(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
 }
-- 
2.34.1


