Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF9BCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENEC-00054t-B3; Wed, 07 Oct 2026 04:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xEIt2-000057-C0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:04:28 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xEIsy-0004cB-7w
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:04:11 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.46])
 by linux.microsoft.com (Postfix) with ESMTPSA id 53FE420B716D;
 Tue,  6 Oct 2026 09:48:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53FE420B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791305327;
 bh=AL4sp3TkGvdtEM1QJ08Inmb4FA5wGCa7jieuaUQo7KY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cPcerY4JvuJtVTCrxvuhpzBi3J4hmeZPARiLwaZwiJOQuQ0xPL992pNc7DYej4g0B
 Ac/lxQObqVcPPyFj8r3/sFMpom7poaBhzU5mDSGx0GxYwgkGgpg31eqXFmKPtsjsJ2
 5aXKXkJOecPdJkzSq2UmjlNMvAaD4J4NsU7+kAp4=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/11] target/i386/mshv: fix pio handlers clobbering
 device-modified registers
Date: Tue,  6 Oct 2026 18:49:00 +0200
Message-Id: <20261006164905.776466-7-magnuskulke@linux.microsoft.com>
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
Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 72 +++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 22 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 5a34357693..4f113da02d 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1718,10 +1718,12 @@ static int handle_pio_non_str(CPUState *cpu,
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
@@ -1752,21 +1754,36 @@ static int handle_pio_non_str(CPUState *cpu,
 
     /* Advance RIP and update RAX */
     rip = info->header.rip + insn_len;
-    rax = info->rax;
 
-    reg_names[0] = HV_X64_REGISTER_RIP;
-    reg_values[0] = rip;
-    reg_names[1] = HV_X64_REGISTER_RAX;
-    reg_values[1] = rax;
+    if (cpu->vcpu_dirty) {
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
+        cpu->vcpu_dirty = false;
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
 
-    cpu->vcpu_dirty = false;
-
     return 0;
 }
 
@@ -1915,6 +1932,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
     bool repop = info->access_info.rep_prefix == 1;
     size_t repeat = repop ? info->rcx : 1;
     size_t insn_len = info->header.instruction_length;
+    uint64_t rip;
     bool direction_flag;
     uint32_t reg_names[3];
     uint64_t reg_values[3];
@@ -1944,18 +1962,28 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
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
+    if (cpu->vcpu_dirty) {
+        env->eip = rip;
+        if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
+            env->regs[R_ESI] = info->rsi;
+        } else {
+            env->regs[R_EDI] = info->rdi;
+        }
+        /* Sync modified standard registers back and clear dirty. */
+        store_regs(cpu);
+        cpu->vcpu_dirty = false;
+    } else {
+        reg_names[1] = HV_X64_REGISTER_RIP;
+        reg_values[1] = rip;
 
-    cpu->vcpu_dirty = false;
+        ret = set_x64_registers(cpu, reg_names, reg_values);
+        if (ret < 0) {
+            error_report("Failed to set x64 registers");
+            return -1;
+        }
+    }
 
     return 0;
 }
-- 
2.34.1


