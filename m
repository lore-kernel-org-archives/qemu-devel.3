Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861DDC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0y-0002WT-GA; Fri, 12 Jul 2024 08:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0v-0002CT-QY; Fri, 12 Jul 2024 08:04:38 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0t-0005sR-TW; Fri, 12 Jul 2024 08:04:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70b2a0542c2so1833513b3a.3; 
 Fri, 12 Jul 2024 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785874; x=1721390674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Glz2DqADEJDP1/FMyA12+YvM7zVFWvLEyd5Ky5OeaTQ=;
 b=dIe2irl4t2XEzUx7hF9y6rRu7a8SZTU4Lv8apQNPbmWa4LCDVJBwBUg4DmbJelpvuV
 rhJ3tmS/KxbA1a1QBPE+pyiUxurt6pUHPDUtW+Cc0ArHw6nL3Pj97usGUmq/mf8crv8m
 EyiEkaXN3KVnQye7KXVez63xVSCJYLt3chPZzblH+fEwXBxcynad6kBj+ydrtwPfZinV
 ccPFvXBtMPT/2Mjg+ie+OoNE4mkGXQzZog2KqMcNReKYCn7vhaa2IU/m3Ic20gkMoMUR
 Ut7VmX1PfPcHQGEjFIdgo193PeExVkoo50D+YeoEATTwspmUjBnd8OrkZr8xAcFlxeGe
 iYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785874; x=1721390674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Glz2DqADEJDP1/FMyA12+YvM7zVFWvLEyd5Ky5OeaTQ=;
 b=d15WvGsI+QQGcgovQSL9He1VLcG8r9UgQXfEGFG4Fv21GbwNTul8CKgCli2PUi6bgD
 L71bqXm6hw/ViJojXIcQ99EaJo7FdFm9cl4yJYBWeVYPW3nQtyES76JRBItuyMnwzYV0
 8Mu66Q9rV7W6uohMj+TO/dCXoFE0SgN15/+XPDFn+v8GqrJC/e+gXBvCUWhS5BbVdY6j
 1A1tvJaKPUO6vgjsnWvssgac0OlkTRqXlmlu6hWH0kMsKTUPN5FGzONqzfau5PlE74tl
 1736zgsf5WHatLKfGzkOC0DkXqV3Ou1mTRvZe6enGP1OxYTb7DCkxoKMN+qxZ5eiQrvN
 xAuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp9v6L4hrYDWCJr9OrNQG31pngo3CCZ4ro3Qfh2cpdOY701MPbobrRtEM2Ni/QzCELpaCAME6WjsoK79lgGNO+6OsJJgI=
X-Gm-Message-State: AOJu0Yx8aMO/oktgKZ74T+P5nEs3yWfXb/D6qDOg7+3r0TNaQU7g07ty
 osTY4ERi+kK8cHx51eSy/kCCU/oGTyu33n4e5iZ082H5a5u+Xu3+7OIkHQ==
X-Google-Smtp-Source: AGHT+IFcZxsBteEgx8S80szg3xNi5sqQy87RBLSLz1JW9U94SK+iPPzdTJ/8Q6jzx2V3bZA7CZ+2FA==
X-Received: by 2002:a05:6a00:4f90:b0:70a:ffc7:f921 with SMTP id
 d2e1a72fcca58-70b435f6296mr14695383b3a.22.1720785873657; 
 Fri, 12 Jul 2024 05:04:33 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:04:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 16/19] system/cpus: Add cpu_pause() function
Date: Fri, 12 Jul 2024 22:02:43 +1000
Message-ID: <20240712120247.477133-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This factors the CPU pause function from pause_all_vcpus() into a
new cpu_pause() function, similarly to cpu_resume(). cpu_resume()
is moved to keep it next to cpu_pause().

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/core/cpu.h |  8 ++++++++
 system/cpus.c         | 30 +++++++++++++++++-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a2c8536943..e6acfcb59a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -984,6 +984,14 @@ void cpu_reset_interrupt(CPUState *cpu, int mask);
  */
 void cpu_exit(CPUState *cpu);
 
+/**
+ * cpu_pause:
+ * @cpu: The CPU to pause.
+ *
+ * Pauses CPU, i.e. puts CPU into stopped state.
+ */
+void cpu_pause(CPUState *cpu);
+
 /**
  * cpu_resume:
  * @cpu: The CPU to resume.
diff --git a/system/cpus.c b/system/cpus.c
index d3640c9503..5e3a988a0a 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -568,6 +568,22 @@ void cpu_thread_signal_destroyed(CPUState *cpu)
     qemu_cond_signal(&qemu_cpu_cond);
 }
 
+void cpu_pause(CPUState *cpu)
+{
+    if (qemu_cpu_is_self(cpu)) {
+        qemu_cpu_stop(cpu, true);
+    } else {
+        cpu->stop = true;
+        qemu_cpu_kick(cpu);
+    }
+}
+
+void cpu_resume(CPUState *cpu)
+{
+    cpu->stop = false;
+    cpu->stopped = false;
+    qemu_cpu_kick(cpu);
+}
 
 static bool all_vcpus_paused(void)
 {
@@ -588,12 +604,7 @@ void pause_all_vcpus(void)
 
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
     CPU_FOREACH(cpu) {
-        if (qemu_cpu_is_self(cpu)) {
-            qemu_cpu_stop(cpu, true);
-        } else {
-            cpu->stop = true;
-            qemu_cpu_kick(cpu);
-        }
+        cpu_pause(cpu);
     }
 
     /* We need to drop the replay_lock so any vCPU threads woken up
@@ -613,13 +624,6 @@ void pause_all_vcpus(void)
     bql_lock();
 }
 
-void cpu_resume(CPUState *cpu)
-{
-    cpu->stop = false;
-    cpu->stopped = false;
-    qemu_cpu_kick(cpu);
-}
-
 void resume_all_vcpus(void)
 {
     CPUState *cpu;
-- 
2.45.1


