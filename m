Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B65EC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1ou-0000qT-QZ; Thu, 07 Aug 2025 10:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uk1o3-0008DW-96
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:41:30 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uk1nz-0000z8-60
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:41:22 -0400
Received: from localhost.localdomain (unknown [167.220.208.72])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8346D201BC7A;
 Thu,  7 Aug 2025 07:41:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8346D201BC7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1754577676;
 bh=DhmZyG4P75oWPVb56TqklPV6+NTQD7S+hBfPcfsjdr4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lmyASoL+NAmNGlH/ZN3u/I8yGyQePuoF+tw8jNlQrBIUx3MUs2NNFaUr/Gb5EF3sW
 2tUjSb/dqKwQLIcDjHAU13bxfWW4HimFxlxDuivbvusVwS7/HYQRfOZAl4wLKoVjBT
 aYX28rWyhwfywThEzROuTu3vzLRgF+hgRXjrxBMo=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/26] accel/mshv: Add vCPU signal handling
Date: Thu,  7 Aug 2025 16:39:36 +0200
Message-Id: <20250807143951.1154713-12-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
index a4eeaeec76..65166e82b0 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -523,6 +523,35 @@ static int mshv_cpu_exec(CPUState *cpu)
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
@@ -539,6 +568,7 @@ static void *mshv_vcpu_thread(void *arg)
         error_report("Failed to init vcpu %d", cpu->cpu_index);
         goto cleanup;
     }
+    init_signal(cpu);
 
     /* signal CPU creation */
     cpu_thread_signal_created(cpu);
-- 
2.34.1


