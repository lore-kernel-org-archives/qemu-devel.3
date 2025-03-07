Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A9CC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdnS-00080Q-G1; Fri, 07 Mar 2025 14:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tqdnK-0007yZ-BB
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:42 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tqdnI-0005i3-AY
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:41 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 143082038F3B; Fri,  7 Mar 2025 11:55:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 143082038F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741377336;
 bh=AoIGXfPUFqblYJ9qFbRuKP1fGYQu1Y343cDG+VSqedM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rr+4aolHrO+/Uk5i38QbSEqjUr/1A+fUqCi8JTO1n3i5nba2URiBYMv11N0rJ1Lat
 qiGe/rUxIgpIG5vPS79PzLMJpOngBUi9UlNchSj+LwrBb5wosTgXHI/UHl21OudgmW
 /lc61u3orcazzxUZ6XaboTLnrJmxO/x2MDwNOi7M=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [PATCH v2 01/14] target/i386/hvf: introduce x86_emul_ops
Date: Fri,  7 Mar 2025 11:55:12 -0800
Message-Id: <1741377325-28175-2-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741377325-28175-1-git-send-email-liuwe@linux.microsoft.com>
References: <1741377325-28175-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
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

This will be used to remove HVF specific code from the instruction emulator.

For now we only introduce two hooks for x86_decode.c. More hooks will be added
when the code is refactored.

The emulator initialization function now takes in a pointer to the ops structure.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/hvf.c     | 20 +++++++++++++++++++-
 target/i386/hvf/x86_emu.c |  5 ++++-
 target/i386/hvf/x86_emu.h | 10 +++++++++-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 9ba0e04ac756..03456ffbc705 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -229,6 +229,24 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     return hv_vm_create(HV_VM_DEFAULT);
 }
 
+static void hvf_read_segment_descriptor(CPUState *s, struct x86_segment_descriptor *desc,
+                                        X86Seg seg)
+{
+    struct vmx_segment vmx_segment;
+    vmx_read_segment_descriptor(s, &vmx_segment, seg);
+    vmx_segment_to_x86_descriptor(s, &vmx_segment, desc);
+}
+
+static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    vmx_read_mem(cpu, data, gva, bytes);
+}
+
+static const struct x86_emul_ops hvf_x86_emul_ops = {
+    .read_mem = hvf_read_mem,
+    .read_segment_descriptor = hvf_read_segment_descriptor,
+};
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -237,7 +255,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int r;
     uint64_t reqCap;
 
-    init_emu();
+    init_emu(&hvf_x86_emul_ops);
     init_decoder();
 
     if (hvf_state->hvf_caps == NULL) {
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index ebba80a36b50..c15b5a7ca850 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -1231,6 +1231,8 @@ static struct cmd_handler {
 
 static struct cmd_handler _cmd_handler[X86_DECODE_CMD_LAST];
 
+const struct x86_emul_ops *emul_ops;
+
 static void init_cmd_handler(void)
 {
     int i;
@@ -1253,7 +1255,8 @@ bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
     return true;
 }
 
-void init_emu(void)
+void init_emu(const struct x86_emul_ops *o)
 {
+    emul_ops = o;
     init_cmd_handler();
 }
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index bc0fc72c761b..1422d06ea184 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -23,7 +23,15 @@
 #include "x86_decode.h"
 #include "cpu.h"
 
-void init_emu(void);
+struct x86_emul_ops {
+    void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
+    void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
+                                    enum X86Seg seg);
+};
+
+extern const struct x86_emul_ops *emul_ops;
+
+void init_emu(const struct x86_emul_ops *ops);
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins);
 void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_code);
 
-- 
2.47.2


