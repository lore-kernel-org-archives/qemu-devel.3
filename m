Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F9ECA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENIz-0008OQ-7w; Wed, 07 Oct 2026 04:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xEIVk-0004ee-3k
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:40:18 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xEIVb-0000gL-PZ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:40:06 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.46])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0E98E20B7172;
 Tue,  6 Oct 2026 09:48:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E98E20B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791305341;
 bh=V7k5ksSW4RsHuCytgbLs9kBX9VPnsl0XS1+v389uO0s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=niOUKbq4WyvJm2J0dL8Ro2fTkM1NG1YHJczG50TpuemhgTfkH+YzyeRPcFDs4FqHj
 pZQpG0PXCNSa1TaWckpcBa8zRK/qM8NGnxNZOJpTZZzRbHczSU3lvUIHqwEpylX1QI
 KlLHBnL4JmW0DoSLX6ixjesfHpqAJUdnXCifqTBw=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 11/11] target/i386/mshv: support single-stepping
Date: Tue,  6 Oct 2026 18:49:05 +0200
Message-Id: <20261006164905.776466-12-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
References: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

Single-step by toggling RFLAGS.TF around the vCPU run, as WHPX does.
TF is set only on the live register, never in env->eflags, so it is not read
back and re-applied by a later register store.
The resulting #DB is reported to gdb by mshv_handle_debug() whenever the vCPU
is single-stepping.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 0670e7a5ae..4df73bb497 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -2091,17 +2091,67 @@ static int handle_exception_interrupt(CPUState *cpu,
     return 0;
 }
 
+/*
+ * Flip RFLAGS.TF like WHPX. Set it only on the live register, not env->eflags,
+ * so a later store won't put it back.
+ */
+static int arch_set_single_step(CPUState *cpu, bool enable)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    hv_register_assoc assoc = { .name = HV_X64_REGISTER_RFLAGS };
+    uint64_t rflags;
+    int ret;
+
+    if (env->regs_page && env->regs_page->isvalid != 0) {
+        rflags = env->regs_page->rflags;
+        rflags = enable ? (rflags | TF_MASK) : (rflags & ~TF_MASK);
+        env->regs_page->rflags = rflags;
+        env->regs_page->dirty |= (1u << HV_X64_REGISTER_CLASS_FLAGS);
+        return 0;
+    }
+
+    ret = mshv_get_generic_regs(cpu, &assoc, 1);
+    if (ret < 0) {
+        return ret;
+    }
+    rflags = assoc.value.reg64;
+    rflags = enable ? (rflags | TF_MASK) : (rflags & ~TF_MASK);
+    assoc.value.reg64 = rflags;
+    return mshv_set_generic_regs(cpu, &assoc, 1);
+}
+
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 {
     int ret;
     enum MshvVmExit exit_reason;
     int cpu_fd = mshv_vcpufd(cpu);
+    bool single_step;
+
+    /* enable single stepping by flipping RFLAGS.TF */
+    single_step = cpu_single_stepping(cpu);
+    if (single_step) {
+        ret = arch_set_single_step(cpu, true);
+        if (ret < 0) {
+            error_report("Failed to arm single-step (TF) on vcpu %d: %s",
+                         cpu->cpu_index, strerror(-ret));
+            *exit = MshvVmExitShutdown;
+            return -1;
+        }
+    }
 
     ret = ioctl(cpu_fd, MSHV_RUN_VP, msg);
     if (ret < 0) {
         return MshvVmExitShutdown;
     }
 
+    /* disable single stepping by flipping RFLAGS.TF */
+    if (single_step && arch_set_single_step(cpu, false) < 0) {
+        error_report("Failed to clear single-step (TF) on vcpu %d",
+                     cpu->cpu_index);
+        return -1;
+    }
+
     switch (msg->header.message_type) {
     case HVMSG_UNRECOVERABLE_EXCEPTION:
         return MshvVmExitShutdown;
-- 
2.34.1


