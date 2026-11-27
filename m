Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB05606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=UIx1W6yC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxuL-0006MG-Oy; Fri, 27 Nov 2026 10:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xWxuD-0006LM-FZ
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:30:37 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xWxuA-0003SR-Ch
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:30:32 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.58])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1024C20B7166;
 Fri, 27 Nov 2026 07:30:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1024C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795793421;
 bh=YPiZfyq7QVUD3+7p0OXsQba01iJq1e4+QQLTcv8l6OM=;
 h=From:To:Cc:Subject:Date:From;
 b=UIx1W6yCy9WKornxwYY6JhLJ3MvrrVrZ7KMe+xZ2SBQ9+2GEHiPJsRzPWHlH3hjGL
 gev1ZCVPh0BGddPFoVlqMbfDv6zRPtR7GPvLHI4YxWMKe0lUNFuSYHXd55Cv0XZ0H0
 HwrwTjmoDPvSGjnBAHrkthIww7DcFvJB5ojTjtNM=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] target/i386/mshv: use common emulator for str pio
Date: Fri, 27 Nov 2026 16:30:20 +0100
Message-Id: <20261127153020.179180-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The mshv-local PIO emulation had a bug in which we did not honor a
segment-override prefix on OUTS (the handler always read the source from
DS:RSI, even when ES:RSI was requested). This was triggered by IDE boot of
Windows ISOs.

This change switches to the common decoder/emulator for string pio. This
resolves the bug and removes the last remaining call to translate_gva()
in favor of a userland table walk.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 328 +++++++++++-------------------------
 1 file changed, 98 insertions(+), 230 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index c145bbc447..2465267a54 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -28,6 +28,7 @@
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "emulate/x86_flags.h"
+#include "emulate/x86_mmu.h"
 #include "gdbstub/enums.h"
 
 #include "accel/accel-cpu-target.h"
@@ -309,47 +310,6 @@ static int get_xc_reg(CPUState *cpu)
     return 0;
 }
 
-static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
-                         uint64_t flags)
-{
-    int ret;
-    int cpu_fd = mshv_vcpufd(cpu);
-    int vp_index = cpu->cpu_index;
-
-    hv_input_translate_virtual_address in = { 0 };
-    hv_output_translate_virtual_address out = { 0 };
-    struct mshv_root_hvcall args = {0};
-    uint64_t gva_page = gva >> HV_HYP_PAGE_SHIFT;
-
-    in.vp_index = vp_index;
-    in.control_flags = flags;
-    in.gva_page = gva_page;
-
-    /* create the hvcall envelope */
-    args.code = HVCALL_TRANSLATE_VIRTUAL_ADDRESS;
-    args.in_sz = sizeof(in);
-    args.in_ptr = (uint64_t) &in;
-    args.out_sz = sizeof(out);
-    args.out_ptr = (uint64_t) &out;
-
-    /* perform the call */
-    ret = mshv_hvcall(cpu_fd, &args);
-    if (ret < 0) {
-        error_report("Failed to invoke gva->gpa translation");
-        return -errno;
-    }
-
-    if (out.translation_result.result_code != HV_TRANSLATE_GVA_SUCCESS) {
-        error_report("Failed to translate gva (" TARGET_FMT_lx ") to gpa", gva);
-        return -1;
-    }
-
-    *gpa = ((out.gpa_page << HV_HYP_PAGE_SHIFT)
-         | (gva & ~(uint64_t)HV_HYP_PAGE_MASK));
-
-    return 0;
-}
-
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs)
 {
@@ -1711,27 +1671,55 @@ static inline MemTxAttrs get_mem_attrs(bool is_secure_mode)
     return memattr;
 }
 
-static void pio_read(uint64_t port, uint8_t *data, uintptr_t size,
-                     bool is_secure_mode)
+static int pio_read(uint16_t port, uint8_t *data, uintptr_t size,
+                    bool is_secure_mode)
 {
-    int ret = 0;
+    int ret;
     MemTxAttrs memattr = get_mem_attrs(is_secure_mode);
+
     ret = address_space_rw(&address_space_io, port, memattr, (void *)data, size,
                            false);
     if (ret != MEMTX_OK) {
-        error_report("Failed to read from port %lx: %d", port, ret);
-        abort();
+        error_report("Failed to read from port %x: %d", port, ret);
+        return -1;
     }
+
+    return 0;
 }
 
-static int pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
+static int pio_write(uint16_t port, const uint8_t *data, uintptr_t size,
                      bool is_secure_mode)
 {
-    int ret = 0;
+    int ret;
     MemTxAttrs memattr = get_mem_attrs(is_secure_mode);
+
     ret = address_space_rw(&address_space_io, port, memattr, (void *)data, size,
                            true);
-    return ret;
+    if (ret != MEMTX_OK) {
+        error_report("Failed to write to port %x: %d", port, ret);
+        return -1;
+    }
+
+    return 0;
+}
+
+static void handle_io(CPUState *cpu, uint16_t port, void *buffer,
+                      int direction, int size, int count)
+{
+    uint8_t *data = buffer;
+    int i, ret;
+    MemTxAttrs memattr = {0};
+    bool write = (direction != 0);
+
+    for (i = 0; i < count; i++, data += size) {
+        ret = address_space_rw(&address_space_io, port, memattr, (void *)data,
+                               size, write);
+        if (ret != MEMTX_OK) {
+            error_report("Failed to %s port %x: %d",
+                         write ? "write to" : "read from", port, ret);
+            abort();
+        }
+    }
 }
 
 static int handle_pio_non_str(CPUState *cpu,
@@ -1812,202 +1800,68 @@ static int handle_pio_non_str(CPUState *cpu,
     return 0;
 }
 
-static int read_memory(const CPUState *cpu, uint64_t initial_gva,
-                       uint64_t initial_gpa, uint64_t gva, uint8_t *data,
-                       size_t len)
+static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
 {
-    int ret;
-    uint64_t gpa, flags;
-    uint64_t cur_gva = gva;
-    size_t page_left, chunk;
-    uint8_t *cur_data = data;
-
-    /*
-     * If the read spans multiple pages,
-     * we need to translate and read each page separately
-     */
-    while (len > 0) {
-        page_left = HV_HYP_PAGE_SIZE - (cur_gva & (HV_HYP_PAGE_SIZE - 1));
-        chunk = MIN(len, page_left);
-
-        if (cur_gva == initial_gva) {
-            gpa = initial_gpa;
-        } else {
-            flags = HV_TRANSLATE_GVA_VALIDATE_READ;
-            ret = translate_gva(cpu, cur_gva, &gpa, flags);
-            if (ret < 0) {
-                return -1;
-            }
-        }
-
-        ret = mshv_guest_mem_read(gpa, cur_data, chunk,
-                                  false, false);
-        if (ret < 0) {
-            error_report("failed to read guest mem");
-            return -1;
-        }
+    uint8_t access_type = info->header.intercept_access_type;
+    size_t insn_len = info->header.instruction_length;
+    bool success;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct x86_decode decode = { 0 };
+    x86_insn_stream stream = {
+        .bytes = info->instruction_bytes,
+        .len = insn_len,
+    };
 
-        cur_gva += chunk;
-        cur_data += chunk;
-        len -= chunk;
+    if (info->access_info.access_size != 1 &&
+        info->access_info.access_size != 2 &&
+        info->access_info.access_size != 4) {
+        error_report("Invalid string pio access size: %u",
+                     info->access_info.access_size);
+        return -1;
     }
 
-    return 0;
-}
-
-static int write_memory(const CPUState *cpu, uint64_t gva, const uint8_t *data,
-                        size_t len)
-{
-    int ret;
-    uint64_t gpa, flags;
-    uint64_t cur_gva = gva;
-    size_t page_left, chunk;
-    const uint8_t *cur_data = data;
-
-    /*
-     * If the write spans multiple pages,
-     * we need to translate and write each page separately
-     */
-    while (len > 0) {
-        page_left = HV_HYP_PAGE_SIZE - (cur_gva & (HV_HYP_PAGE_SIZE - 1));
-        chunk = MIN(len, page_left);
-
-        flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
-        ret = translate_gva(cpu, cur_gva, &gpa, flags);
-        if (ret < 0) {
-            error_report("failed to translate gva to gpa");
-            return -1;
-        }
-
-        ret = mshv_guest_mem_write(gpa, cur_data, chunk, false);
-        if (ret != MEMTX_OK) {
-            error_report("failed to write to mmio");
-            return -1;
-        }
-
-        cur_gva += chunk;
-        cur_data += chunk;
-        len -= chunk;
+    if (insn_len == 0 ||
+        insn_len > info->instruction_byte_count ||
+        info->instruction_byte_count > sizeof(info->instruction_bytes)) {
+        error_report("Invalid string pio instruction length: %zu", insn_len);
+        return -1;
     }
 
-    return 0;
-}
-
-static int handle_pio_str_write(CPUState *cpu,
-                                hv_x64_io_port_intercept_message *info,
-                                size_t repeat, uint16_t port,
-                                bool direction_flag)
-{
-    int ret;
-    uint64_t src;
-    uint8_t data[4] = { 0 };
-    size_t len = info->access_info.access_size;
-
-    src = linear_addr(cpu, info->rsi, R_DS);
+    load_regs(cpu);
 
-    for (size_t i = 0; i < repeat; i++) {
-        ret = read_memory(cpu, 0, 0, src, data, len);
-        if (ret < 0) {
-            error_report("Failed to read memory");
-            return -1;
-        }
-        ret = pio_write(port, data, len, false);
-        if (ret < 0) {
-            error_report("Failed to write to io port");
-            return -1;
-        }
-        src += direction_flag ? -len : len;
-        info->rsi += direction_flag ? -len : len;
+    if (decode_instruction_stream(env, &decode, &stream) != insn_len) {
+        error_report("String pio instruction length mismatch: "
+                     "decoded %d, expected %zu", decode.len, insn_len);
+        return -1;
     }
 
-    return 0;
-}
-
-static int handle_pio_str_read(CPUState *cpu,
-                               hv_x64_io_port_intercept_message *info,
-                               size_t repeat, uint16_t port,
-                               bool direction_flag)
-{
-    int ret;
-    uint64_t dst;
-    size_t len = info->access_info.access_size;
-    uint8_t data[4] = { 0 };
-
-    dst = linear_addr(cpu, info->rdi, R_ES);
-
-    for (size_t i = 0; i < repeat; i++) {
-        pio_read(port, data, len, false);
-
-        ret = write_memory(cpu, dst, data, len);
-        if (ret < 0) {
-            error_report("Failed to write memory");
-            return -1;
-        }
-        dst += direction_flag ? -len : len;
-        info->rdi += direction_flag ? -len : len;
+    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE
+        ? decode.cmd != X86_DECODE_CMD_OUTS
+        : decode.cmd != X86_DECODE_CMD_INS) {
+        error_report("String pio direction mismatch");
+        return -1;
     }
 
-    return 0;
-}
-
-static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
-{
-    uint8_t access_type = info->header.intercept_access_type;
-    uint16_t port = info->port_number;
-    bool repop = info->access_info.rep_prefix == 1;
-    size_t repeat = repop ? info->rcx : 1;
-    size_t insn_len = info->header.instruction_length;
-    uint64_t rip;
-    bool direction_flag;
-    uint32_t reg_names[3];
-    uint64_t reg_values[3];
-    int ret;
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-
-    load_regs(cpu);
-
-    direction_flag = (env->eflags & DESC_E_MASK) != 0;
-
-    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
-        ret = handle_pio_str_write(cpu, info, repeat, port, direction_flag);
-        if (ret < 0) {
-            error_report("Failed to handle pio str write");
-            return -1;
-        }
-        reg_names[0] = HV_X64_REGISTER_RSI;
-        reg_values[0] = info->rsi;
-    } else {
-        ret = handle_pio_str_read(cpu, info, repeat, port, direction_flag);
-        if (ret < 0) {
-            error_report("Failed to handle pio str read");
-            return -1;
-        }
-        reg_names[0] = HV_X64_REGISTER_RDI;
-        reg_values[0] = info->rdi;
+    if (decode.operand_size != info->access_info.access_size) {
+        error_report("String pio access size mismatch: decoded %d, expected %u",
+                     decode.operand_size, info->access_info.access_size);
+        return -1;
     }
 
-    rip = info->header.rip + insn_len;
+    if (!!decode.rep != !!info->access_info.rep_prefix) {
+        error_report("String pio REP prefix mismatch");
+        return -1;
+    }
 
-    if (cpu->vcpu_dirty) {
-        env->eip = rip;
-        if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
-            env->regs[R_ESI] = info->rsi;
-        } else {
-            env->regs[R_EDI] = info->rdi;
-        }
-        /* Sync modified standard registers back and clear dirty. */
-        store_regs(cpu);
-        cpu->vcpu_dirty = false;
-    } else {
-        reg_names[1] = HV_X64_REGISTER_RIP;
-        reg_values[1] = rip;
+    success = exec_instruction(env, &decode);
+    store_regs(cpu);
+    cpu->vcpu_dirty = false;
 
-        ret = set_x64_registers(cpu, reg_names, reg_values);
-        if (ret < 0) {
-            error_report("Failed to set x64 registers");
-            return -1;
-        }
+    if (!success) {
+        error_report("Failed to emulate string pio at " TARGET_FMT_lx,
+                     info->header.rip);
+        return -1;
     }
 
     return 0;
@@ -2290,8 +2144,22 @@ static void read_segment_descriptor(CPUState *cpu,
     x86_set_segment_base(desc, seg->base);
 }
 
+static bool is_user_mode(CPUState *cpu)
+{
+    CPUX86State *env = &X86_CPU(cpu)->env;
+
+    /* If the guest is in real mode, it is not user mode. */
+    if (!(env->cr[0] & CR0_PG_MASK)) {
+        return false;
+    }
+
+    return (env->segs[R_CS].selector & 3) == 3 || (env->eflags & VM_MASK);
+}
+
 static const struct x86_emul_ops mshv_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
+    .is_user_mode = is_user_mode,
+    .handle_io = handle_io,
 };
 
 void mshv_init_mmio_emu(void)
-- 
2.34.1


