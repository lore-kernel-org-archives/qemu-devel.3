Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B9FC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUag9-0008KA-Ic; Mon, 29 Jan 2024 18:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUae4-0006qE-Je
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:29 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUae2-0008W5-My
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:28 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bda741ad7dso2953502b6e.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569345; x=1707174145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0D5wvbqCBKDS3PIRJ2u8mID+Ysdp5Zl/usWtkQWmMI=;
 b=v20khRcTMp+4YR+Pd6g9IL+U3udxDQlZopse4FOoCtSicqb8mDYE+/mzleN3qbJ3UE
 ziPUjcChU9QSQgmxRk35uB9SLkmJtvnJ9rQwXEYd0DD68O1bjouDupLSr86AnE+pVvwo
 toHp64IaEttiurUQeTU283ln7zGwcYVKFosqIZ44NOsVyaWZ0YYKzNFoPzKUqVGSKunP
 IpL3HRLCPoFFzZQSSckHEMeS+t4MmMB9AozId9vjZF3o9HStkq+AGpd/5epCq0woqqWS
 TtB+tTm/ebqSdqfL88QbRdvvWqgOwLhilayTx2DtV2vtnLX8SL7VVWGy+r3U21bO39WI
 yYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569345; x=1707174145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0D5wvbqCBKDS3PIRJ2u8mID+Ysdp5Zl/usWtkQWmMI=;
 b=I5+BCFfUPA6YtTcK+tveHKGxmcz/hOrhS5/ZMKJBWwVJL3p8GoOpG3lg1LgrMLXnER
 mjeJw3tpu6vaPf9qeuuPt4lJ0nyckKbScAK6FSfcednedE4MTPzf9W31gYc37MxR+sZj
 K0jfaRDArLiGm6pvmXR32KR2vaw4uj+Y5/uTxlSU/5pOH+wPSm6dzvNL1Ird+G6ORoND
 JDZwFw2VDoqOEWaS/YU9lm8TSfZSsKi8XFKpsSmMikZoS71YY/mVOCZXcpotibwsYBsX
 yx0HuW8XCffkOIr25Wfusc8YoQMKjrsjCPAojiSOIJbc1q6ASbVxI2nWyXN9RbIoZdZG
 bN0Q==
X-Gm-Message-State: AOJu0YyQ0C6TlDVggzHHYAb5+vWBjYRpKHlHCR+RT2ELjCE1hbDKAEo1
 lMifhXZ4o/04DsGtzvSvx7YJIJ5iQMyuf0sWqx9j/kyeqpzpm+aofJCqNuQohH8UYMTnkAtZXSk
 vyio=
X-Google-Smtp-Source: AGHT+IE0qaf2IhZyAm/EP38aegeAxmpymypqC8H7cQ3lVwyTV/eFIY5am23rtwZ7RS/4ozXMSEqyrg==
X-Received: by 2002:a05:6808:1983:b0:3be:31d5:6dda with SMTP id
 bj3-20020a056808198300b003be31d56ddamr787551oib.10.1706569345527; 
 Mon, 29 Jan 2024 15:02:25 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 22/31] accel/tcg: Rename tcg_cpus_exec() -> tcg_cpu_exec()
Date: Tue, 30 Jan 2024 09:01:12 +1000
Message-Id: <20240129230121.8091-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

tcg_cpus_exec() operates on a single vCPU, rename it
as 'tcg_cpu_exec'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240124101639.30056-4-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.c | 2 +-
 accel/tcg/tcg-accel-ops-rr.c    | 2 +-
 accel/tcg/tcg-accel-ops.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 17c7ed00eb..44c4079972 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -15,7 +15,7 @@
 #include "sysemu/cpus.h"
 
 void tcg_cpu_destroy(CPUState *cpu);
-int tcg_cpus_exec(CPUState *cpu);
+int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
 
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index bcba314a65..c552b45b8e 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -92,7 +92,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
         if (cpu_can_run(cpu)) {
             int r;
             bql_unlock();
-            r = tcg_cpus_exec(cpu);
+            r = tcg_cpu_exec(cpu);
             bql_lock();
             switch (r) {
             case EXCP_DEBUG:
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 0617f66b5b..894e73e52c 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -258,7 +258,7 @@ static void *rr_cpu_thread_fn(void *arg)
                 if (icount_enabled()) {
                     icount_prepare_for_run(cpu, cpu_budget);
                 }
-                r = tcg_cpus_exec(cpu);
+                r = tcg_cpu_exec(cpu);
                 if (icount_enabled()) {
                     icount_process_data(cpu);
                 }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 9b84b84218..9c957f421c 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -68,7 +68,7 @@ void tcg_cpu_destroy(CPUState *cpu)
     cpu_thread_signal_destroyed(cpu);
 }
 
-int tcg_cpus_exec(CPUState *cpu)
+int tcg_cpu_exec(CPUState *cpu)
 {
     int ret;
     assert(tcg_enabled());
-- 
2.34.1


