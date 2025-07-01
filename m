Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C86FC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeoK-0004r0-1f; Tue, 01 Jul 2025 13:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWenu-0004JZ-Qy
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:29:59 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWens-0006w1-VL
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:29:58 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 644CE211223A;
 Tue,  1 Jul 2025 10:29:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 644CE211223A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751390994;
 bh=HKF4J8hoT7FC44YXYO93SNqvkBKB3tZSrogS2AjQ5UE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lvv5edfUjTTtU4K6roulYYhoy5FVWxEiiYKukTw5ZQ/JqxkXi8VyrvGw8Vbm10VJM
 GWsDb6pcfoDtm0s7dVKaxbMe1o1+gBuUIvKuKh8eTahvy1rW58UKy8dW3Tnj/gPqVZ
 8QFL1XkvQWhrTfu1XWWME5t4PhP1hS0iVEY1hVpA=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 13/27] accel/mshv: Add vCPU signal handling
Date: Tue,  1 Jul 2025 19:28:20 +0200
Message-Id: <20250701172834.44849-14-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Implement signal handling for MSHV vCPUs to support asynchronous
interrupts from the main thread.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 04900a2bfe..d95893806f 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -524,6 +524,35 @@ static int mshv_cpu_exec(CPUState *cpu)
     return ret;
 }
 
+/*
+ * The signal handler is triggered when QEMU's main thread receives a SIG_IPI
+ * (SIGUSR1). This signal causes the current CPU thread to be kicked, forcing a
+ * VM exit on the CPU. The VM exit generates an exit reason that breaks the loop
+ * (see mshv_cpu_exec). If the exit is due to a Ctrl+A+x command, the system
+ * will shut down. For other cases, the system will continue running.
+ */
+static void sa_ipi_handler(int sig)
+{
+    /* TODO: call IOCTL to set_immediate_exit, once implemented. */
+
+    qemu_cpu_kick_self();
+}
+
+static void init_signal(CPUState *cpu)
+{
+    /* init cpu signals */
+    struct sigaction sigact;
+    sigset_t set;
+
+    memset(&sigact, 0, sizeof(sigact));
+    sigact.sa_handler = sa_ipi_handler;
+    sigaction(SIG_IPI, &sigact, NULL);
+
+    pthread_sigmask(SIG_BLOCK, NULL, &set);
+    sigdelset(&set, SIG_IPI);
+    pthread_sigmask(SIG_SETMASK, &set, NULL);
+}
+
 static void *mshv_vcpu_thread(void *arg)
 {
     CPUState *cpu = arg;
@@ -540,6 +569,7 @@ static void *mshv_vcpu_thread(void *arg)
         error_report("Failed to init vcpu %d", cpu->cpu_index);
         goto cleanup;
     }
+    init_signal(cpu);
 
     /* signal CPU creation */
     cpu_thread_signal_created(cpu);
-- 
2.34.1


