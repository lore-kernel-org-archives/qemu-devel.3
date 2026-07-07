Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1144AC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh17q-0000Mm-L9; Tue, 07 Jul 2026 04:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wh17p-0000MR-Df
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:25:53 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wh17n-0001cd-NJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:25:53 -0400
Received: from laptop.localdomain (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8261220B716C;
 Tue,  7 Jul 2026 01:25:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8261220B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783412746;
 bh=wEn+53lQG2l3oniVWxO+V07vxnRjBrR5rdFRqQzojCk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CWw2yifH6s9OorpHpTi/GZxB7NCttomcAhaOzr6q8j7MT8FoEs++dovT560VxhHeP
 QfZvlrUPP6cXkCLvrJVAaowXvKgd42HWo3B0XTSDSLThRpNIJR60GEXg9bKRRx4SMq
 Y8wSg1+wUhX7Raj8KndqmnO8l21q2NaZcomURo68=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 5/5] target/i386/mshv: fix pio handlers clobbering
 device-modified registers
Date: Tue,  7 Jul 2026 11:25:31 +0300
Message-ID: <20260707082531.178539-6-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707082531.178539-1-dblanzeanu@linux.microsoft.com>
References: <20260707082531.178539-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
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

When a device handler (e.g. vmport) calls cpu_synchronize_state() during
I/O port dispatch, it sets cpu->accel->dirty = true and may modify
registers directly in env. The old PIO code ignored this: it
unconditionally wrote the stale info->rax from the VM-exit intercept
message back to the hypervisor and then cleared dirty, discarding any
register changes made by the device.

Bifurcate both handlers on cpu->accel->dirty:

handle_pio_non_str:
- dirty path: update env->eip directly. For reads (IN), merge the I/O
  result into env->regs[R_EAX] (which may have been modified by the
  device) rather than info->rax. For writes (OUT), leave RAX untouched.
  Flush all registers via mshv_store_regs() and clear dirty.
- non-dirty path: write RIP and RAX via set_x64_registers hypercall as
  before.

handle_pio_str:
- dirty path: update env->eip and the appropriate index register
  (RSI for OUTS, RDI for INS) directly. Flush via mshv_store_regs()
  and clear dirty.
- non-dirty path: write the index register and RIP via
  set_x64_registers. Drop the RAX assignment that was here before;
  string I/O does not modify RAX, and set_x64_registers is hardcoded
  to write only 2 registers so the third slot was silently ignored
  anyway.

Remove the unconditional "cpu->accel->dirty = false" at the end of both
handlers. In the non-dirty fast path it was redundant (already false).
In the dirty path it was actively harmful: it told the vcpu run loop
that env was clean when it was not, losing the device's modifications.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 74 +++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index ab86c01af1..f8683dd79a 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1637,7 +1637,7 @@ static int pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
     return ret;
 }
 
-static int handle_pio_non_str(const CPUState *cpu,
+static int handle_pio_non_str(CPUState *cpu,
                               hv_x64_io_port_intercept_message *info)
 {
     size_t len = info->access_info.access_size;
@@ -1646,10 +1646,12 @@ static int handle_pio_non_str(const CPUState *cpu,
     uint32_t val, eax;
     const uint32_t eax_mask =  0xffffffffu >> (32 - len * 8);
     size_t insn_len;
-    uint64_t rip, rax;
+    uint64_t rip;
     uint32_t reg_names[2];
     uint64_t reg_values[2];
     uint16_t port = info->port_number;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
 
     if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
         union {
@@ -1680,21 +1682,36 @@ static int handle_pio_non_str(const CPUState *cpu,
 
     /* Advance RIP and update RAX */
     rip = info->header.rip + insn_len;
-    rax = info->rax;
 
-    reg_names[0] = HV_X64_REGISTER_RIP;
-    reg_values[0] = rip;
-    reg_names[1] = HV_X64_REGISTER_RAX;
-    reg_values[1] = rax;
+    if (cpu->accel->dirty) {
+        env->eip = rip;
+        if (access_type != HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
+            /*
+             * For reads, merge the I/O result into the current RAX.
+             * Use env->regs[R_EAX] as the base since a device handler
+             * (e.g. vmport) may have called cpu_synchronize_state()
+             * and modified registers.
+             */
+            eax = (((uint32_t)env->regs[R_EAX]) & ~eax_mask)
+                  | (val & eax_mask);
+            env->regs[R_EAX] = (uint64_t)eax;
+        }
+        /* Sync modified standard registers back and clear dirty. */
+        store_regs(cpu);
+        cpu->accel->dirty = false;
+    } else {
+        reg_names[0] = HV_X64_REGISTER_RIP;
+        reg_values[0] = rip;
+        reg_names[1] = HV_X64_REGISTER_RAX;
+        reg_values[1] = info->rax;
 
-    ret = set_x64_registers(cpu, reg_names, reg_values);
-    if (ret < 0) {
-        error_report("Failed to set x64 registers");
-        return -1;
+        ret = set_x64_registers(cpu, reg_names, reg_values);
+        if (ret < 0) {
+            error_report("Failed to set x64 registers");
+            return -1;
+        }
     }
 
-    cpu->accel->dirty = false;
-
     return 0;
 }
 
@@ -1810,6 +1827,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
     bool repop = info->access_info.rep_prefix == 1;
     size_t repeat = repop ? info->rcx : 1;
     size_t insn_len = info->header.instruction_length;
+    uint64_t rip;
     bool direction_flag;
     uint32_t reg_names[3];
     uint64_t reg_values[3];
@@ -1839,18 +1857,28 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
         reg_values[0] = info->rdi;
     }
 
-    reg_names[1] = HV_X64_REGISTER_RIP;
-    reg_values[1] = info->header.rip + insn_len;
-    reg_names[2] = HV_X64_REGISTER_RAX;
-    reg_values[2] = info->rax;
+    rip = info->header.rip + insn_len;
 
-    ret = set_x64_registers(cpu, reg_names, reg_values);
-    if (ret < 0) {
-        error_report("Failed to set RIP and RAX registers");
-        return -1;
-    }
+    if (cpu->accel->dirty) {
+        env->eip = rip;
+        if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
+            env->regs[R_ESI] = info->rsi;
+        } else {
+            env->regs[R_EDI] = info->rdi;
+        }
+        /* Sync modified standard registers back and clear dirty. */
+        store_regs(cpu);
+        cpu->accel->dirty = false;
+    } else {
+        reg_names[1] = HV_X64_REGISTER_RIP;
+        reg_values[1] = rip;
 
-    cpu->accel->dirty = false;
+        ret = set_x64_registers(cpu, reg_names, reg_values);
+        if (ret < 0) {
+            error_report("Failed to set x64 registers");
+            return -1;
+        }
+    }
 
     return 0;
 }
-- 
2.53.0


