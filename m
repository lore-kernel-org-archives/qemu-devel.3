Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62FFC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaDB-0006fG-Gl; Fri, 06 Jun 2025 12:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCw-0006Hx-5B
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCt-0003Sa-M2
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so29934005e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228374; x=1749833174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4qlPyVP19TOs/IkzQVFEBQPCs8QxMwe6aQWLV0wFtw=;
 b=N4Ye0nXQeR035nDvUHQWs+lGh5qx7PKXKvu03yT3NMCoFc5y54QlUH7btIQ1T10leF
 NV7uUO4c1D8dqvZwYmnjfSGw/waL4fLNMySw0qsr6Szlmd/y749khoDWFIUYaCMKPHu5
 LqnOhszswPC52dVRt/fp32f2TEi44lzgj1oMuSiRbwD8uxnzuJanYsbnilNv25l55gsa
 tfkw6hNayefNPUvU+hVqzkCkKqN2H1Kago8qruZoY2+KIObh7w83IeQtfpZ1urBddcI4
 SeL5Mf4yah2JA314GnJFlqcKGlcpzVs9iDofrX3zKfZsMCODr8G+NYVZzbo+DFt59SzL
 NYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228374; x=1749833174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4qlPyVP19TOs/IkzQVFEBQPCs8QxMwe6aQWLV0wFtw=;
 b=YjfHHvaYDLRR9QcXEBZgkp3tY5qiCQ+/FyiU7+tVjGJjWdmdnkVdk9vJyPtOExlukj
 CgbcmXfTTuzxBqzGln9jCsCwefeCBqnj5RFu01+++AZ0o9zXK2yKCAD1mgugWPvTP/hy
 0VgBI5/rQEpsIepKWJEhyy5z8IeQHcAhbXI3mwDyQb5VZr90U+Euflz/iu2T1GopJdmV
 7OUQZF7ZRZLaw00fV/9IZ0DIRM0g06SgF/EHz9l+JOFlVAlyw1/Ugk1WcKRgjiW6vDLO
 VXalsaYpnNQN0urvmikNzcCur1+ImhtBQX6cKstg5gV0Q/3eZwYScCWpsHlILobGO/Db
 96/g==
X-Gm-Message-State: AOJu0YwTWTWEXoYAdCZp+KZxpCgRaAyjaHsg/uE4AftEbv07E7wJhOGb
 Q031RztmNAhlLXGeR12RRJWts4CSY6C+3wphKXyGEPxA5BimhwSNCI8g7s2nYWhd5Fv1syQSx9X
 aTA9St/h/tA==
X-Gm-Gg: ASbGncv06l+m6QrMsDKj1RwQqPG6oPIlyZ084cRCfLpwaYP4+g50emuWQx7uW5A1kE6
 5+GP2lIO5dUx5k+T5/tGM1E9llONH0+8QTGHk4R5zUMlCooOzhwrUtY0zrSpPSJPq/voG4qYbGQ
 Dux7aZQkPGLnRLz95qJIhAXRiirKY4AoBx3iqOFvVePSkflCNolLWV0iqQ4XnFrkIR1niUuHHDx
 w2MfAeP2TiYqwBFpByNaBZrYAfHJwz7JHYsaoaekxIxRUmn/S9cj4JpBwzTnDm9HRj6BtrNrrI4
 0/fgrPKo1AnLa/LOFo2Q0uaYZMdqhldcXvA/YscGQ90OLSqE7jLz6m5CYtNTWxA5TehICtTSlu2
 TLXKhxL69sbSNcLElhV5IGhdyVBAmnxKfLs7LG9JBg3CaVSb+
X-Google-Smtp-Source: AGHT+IEKYod3eqsOm/9hKAMbNssa5gpIELDdRp5eDU9k2t0nVsWJoNd2vfuGtxNF4UDUHzBfVx7v5g==
X-Received: by 2002:a05:600c:3ba1:b0:44a:b478:1387 with SMTP id
 5b1f17b1804b1-4520147ea0amr46702795e9.17.1749228373574; 
 Fri, 06 Jun 2025 09:46:13 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452137281b0sm30312505e9.29.2025.06.06.09.46.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:46:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 15/19] accel/tcg: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri,  6 Jun 2025 18:44:14 +0200
Message-ID: <20250606164418.98655-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.h |  3 +--
 accel/tcg/tcg-accel-ops-mttcg.c | 16 +---------------
 accel/tcg/tcg-accel-ops.c       |  3 ++-
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
index 8ffa7a9a9fe..8bf2452c886 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.h
+++ b/accel/tcg/tcg-accel-ops-mttcg.h
@@ -13,7 +13,6 @@
 /* kick MTTCG vCPU thread */
 void mttcg_kick_vcpu_thread(CPUState *cpu);
 
-/* start an mttcg vCPU thread */
-void mttcg_start_vcpu_thread(CPUState *cpu);
+void *mttcg_cpu_thread_routine(void *arg);
 
 #endif /* TCG_ACCEL_OPS_MTTCG_H */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 462be7596b9..96ce065eb59 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -61,7 +61,7 @@ static void mttcg_force_rcu(Notifier *notify, void *data)
  * current CPUState for a given thread.
  */
 
-static void *mttcg_cpu_thread_fn(void *arg)
+void *mttcg_cpu_thread_routine(void *arg)
 {
     MttcgForceRcuNotifier force_rcu;
     CPUState *cpu = arg;
@@ -128,17 +128,3 @@ void mttcg_kick_vcpu_thread(CPUState *cpu)
 {
     cpu_exit(cpu);
 }
-
-void mttcg_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    tcg_vcpu_thread_precreate(cpu);
-
-    /* create a thread per vCPU with TCG (MTTCG) */
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
-             cpu->cpu_index);
-
-    qemu_thread_create(cpu->thread, thread_name, mttcg_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index e58e1c3738f..954e85dc13c 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -210,7 +210,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
     AccelOpsClass *ops = ac->ops;
 
     if (qemu_tcg_mttcg_enabled()) {
-        ops->create_vcpu_thread = mttcg_start_vcpu_thread;
+        ops->cpu_thread_routine = mttcg_cpu_thread_routine;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
         ops->handle_interrupt = tcg_handle_interrupt;
     } else {
@@ -226,6 +226,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
         }
     }
 
+    ops->thread_precreate = tcg_vcpu_thread_precreate;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
-- 
2.49.0


