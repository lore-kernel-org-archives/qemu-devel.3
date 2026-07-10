Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F77C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8H0-0006o4-Af; Fri, 10 Jul 2026 06:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wi8Gz-0006nb-1h
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:15:57 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wi8Gx-0006HL-JJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:15:56 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p3e9c0c70.dip0.t-ipconnect.de
 [62.156.12.112])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1166D20B716F;
 Fri, 10 Jul 2026 03:15:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1166D20B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783678548;
 bh=Jn8tM3gPqJHIZqmfAJS0m6WTLE5cquacWSQOkwm6lnU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DEJeoAuZhu7Ko6udy9jxkmlDqaexPi4mZgnuIu4DRU55zpnMD4IK8XEfOwOZNYPdV
 nf/LnMWJkSSHEO6hl97rmUsIRDqGauN1nHHHR08Fr/EsNKLDarY4+bgloiMUpInJdE
 qYCP3TI+AGJ1In7moVF3fEeudpgE/E8K0Zr8J/bQ=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: [PATCH 04/12] accel/mshv: install dummy handler for SIG_IPI
Date: Fri, 10 Jul 2026 12:15:26 +0200
Message-Id: <20260710101534.664604-5-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
References: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is similar to HVF's implementation. We want to interrupt the blocking
vcpu run. The self-kick was effectively a no-op for mshv.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 7b3c13cf1e..f9511ca050 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -621,17 +621,13 @@ static int mshv_cpu_exec(CPUState *cpu)
 }
 
 /*
- * The signal handler is triggered when QEMU's main thread receives a SIG_IPI
- * (SIGUSR1). This signal causes the current CPU thread to be kicked, forcing a
- * VM exit on the CPU. The VM exit generates an exit reason that breaks the loop
- * (see mshv_cpu_exec). If the exit is due to a Ctrl+A+x command, the system
- * will shut down. For other cases, the system will continue running.
+ * We need a dummy handler to make SIG_IPI a deliverable signal. The kernel
+ * handler will be woken up by the caught signal and instruct the hypervisor
+ * to suspend execution (the concrete mechanism differs between schedulers)
+ * and return to userspace.
  */
-static void sa_ipi_handler(int sig)
+static void dummy_handler(int sig)
 {
-    /* TODO: call IOCTL to set_immediate_exit, once implemented. */
-
-    qemu_cpu_kick_self();
 }
 
 static void init_signal(CPUState *cpu)
@@ -641,7 +637,7 @@ static void init_signal(CPUState *cpu)
     sigset_t set;
 
     memset(&sigact, 0, sizeof(sigact));
-    sigact.sa_handler = sa_ipi_handler;
+    sigact.sa_handler = dummy_handler;
     sigaction(SIG_IPI, &sigact, NULL);
 
     pthread_sigmask(SIG_BLOCK, NULL, &set);
-- 
2.34.1


