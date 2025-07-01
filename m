Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD08C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWepZ-0006zn-Jp; Tue, 01 Jul 2025 13:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWeos-0006QX-69
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:30:59 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWeon-0007Lo-Uq
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:30:57 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 587C92112239;
 Tue,  1 Jul 2025 10:30:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 587C92112239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751391042;
 bh=QZDzWZMzPcxjbTxKmB09N+RGsXAVaQXEfIPlk952L+A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nAoKdtVNyuqUyc09TylOCS8LtYVm73YSqrpvHbe0mdOLOXS7U0Z83VvOF0lKc7MNP
 MP9tPX7sPMG5pi717O1/+BUipKnzRY4smMTShilc8FLlVurqoXXq74O46Fodbd5Tox
 w+BWxs9Mgf+IelfAdhogp/BFiVrTQ0XLZhc9+om4=
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
Subject: [PATCH v2 25/27] target/i386/mshv: Handle HVMSG_X64_HALT vm exit
Date: Tue,  1 Jul 2025 19:28:32 +0200
Message-Id: <20250701172834.44849-26-magnuskulke@linux.microsoft.com>
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

Implemented handler for HVMSG_X64_HALT exit messages from the
hypervisor.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       |  3 +++
 include/system/mshv.h       |  1 +
 target/i386/mshv/mshv-cpu.c | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index e9f880b83e..f6ad2b6d2b 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -506,6 +506,9 @@ static int mshv_cpu_exec(CPUState *cpu)
         switch (exit_reason) {
         case MshvVmExitIgnore:
             break;
+        case MshvVmExitHlt:
+            ret = EXCP_HLT;
+            break;
         default:
             ret = EXCP_INTERRUPT;
             break;
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 63104af68c..27d7e3dff3 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -99,6 +99,7 @@ typedef enum MshvVmExit {
     MshvVmExitIgnore   = 0,
     MshvVmExitShutdown = 1,
     MshvVmExitSpecial  = 2,
+    MshvVmExitHlt      = 3,
 } MshvVmExit;
 
 void mshv_init_mmio_emu(void);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 353073ed50..41a3398ec8 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "qemu/memalign.h"
 #include "qemu/typedefs.h"
+#include "qemu/main-loop.h"
 
 #include "system/mshv.h"
 #include "system/address-spaces.h"
@@ -1413,6 +1414,26 @@ static int handle_pio(CPUState *cpu, const struct hyperv_message *msg)
     return handle_pio_non_str(cpu, &info);
 }
 
+static int handle_halt(CPUState *cpu)
+{
+    int ret = 0;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    uint32_t hw_irq = cpu->interrupt_request & CPU_INTERRUPT_HARD;
+    uint32_t nmi_irq = cpu->interrupt_request & CPU_INTERRUPT_NMI;
+    bool irqs_enabled = (env->eflags & IF_MASK) != 0;
+
+    bql_lock();
+    if (!nmi_irq && (!hw_irq || !irqs_enabled)) {
+        cpu->exception_index = EXCP_HLT;
+        cpu->halted = true;
+        ret = 1;
+    }
+    bql_unlock();
+
+    return ret;
+}
+
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 {
     int ret;
@@ -1441,6 +1462,11 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
             return MshvVmExitSpecial;
         }
         return MshvVmExitIgnore;
+    case HVMSG_X64_HALT:
+        ret = handle_halt(cpu);
+        if (ret < 0) {
+            return MshvVmExitHlt;
+        }
     default:
         break;
     }
-- 
2.34.1


