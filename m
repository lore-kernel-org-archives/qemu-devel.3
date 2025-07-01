Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD14C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWepK-0006e5-Ux; Tue, 01 Jul 2025 13:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWeog-0006OH-So
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:30:51 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWeoc-0007Iv-4p
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:30:45 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 638AF2119388;
 Tue,  1 Jul 2025 10:30:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 638AF2119388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751391030;
 bh=4LvCJGwmpIjKrsgYwC24zk+8wmMxFtEhjy4AN5gbITE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SWQ0iY6so0cyh9AVREV7pV/NW4hgpVese8FeGiYayblnHQ/P4fNWN6/Yoq67zdumE
 QH0oANfL84JB7TrZDpel2rMdg8dUhyBHmx0r1H/xpy93N8ixf1ZfmNAJ7x6zNNjes2
 I4kkJvveooWYwJeAqk8R8oVDnDcQ0DMWmQpfQYtw=
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
Subject: [PATCH v2 22/27] target/i386/mshv: Integrate x86 instruction
 decoder/emulator
Date: Tue,  1 Jul 2025 19:28:29 +0200
Message-Id: <20250701172834.44849-23-magnuskulke@linux.microsoft.com>
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

Connect the x86 instruction decoder and emulator to the MSHV backend
to handle intercepted instructions. This enables software emulation
of MMIO operations in MSHV guests. MSHV has a translate_gva hypercall
that is used to accessing the physical guest memory.

A guest might read from unmapped memory regions (e.g. OVMF will probe
0xfed40000 for a vTPM). In those cases 0xFF bytes is returned instead of
aborting the execution.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mem.c            |  65 +++++++++++++++++++
 accel/mshv/mshv-all.c       |   2 +-
 include/system/mshv.h       |   6 +-
 target/i386/mshv/mshv-cpu.c | 126 +++++++++++++++++++++++++++++++++++-
 4 files changed, 196 insertions(+), 3 deletions(-)

diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index f51e9fee8e..6d7a726898 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -58,6 +58,71 @@ static int map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool map)
     return set_guest_memory(vm_fd, &region);
 }
 
+static int handle_unmapped_mmio_region_read(uint64_t gpa, uint64_t size,
+                                            uint8_t *data)
+{
+    warn_report("read from unmapped mmio region gpa=0x%lx size=%lu", gpa, size);
+
+    if (size == 0 || size > 8) {
+        error_report("invalid size %lu for reading from unmapped mmio region",
+                     size);
+        return -1;
+    }
+
+    memset(data, 0xFF, size);
+
+    return 0;
+}
+
+int mshv_guest_mem_read(uint64_t gpa, uint8_t *data, uintptr_t size,
+                        bool is_secure_mode, bool instruction_fetch)
+{
+    int ret;
+    MemTxAttrs memattr = { .secure = is_secure_mode };
+
+    if (instruction_fetch) {
+        trace_mshv_insn_fetch(gpa, size);
+    } else {
+        trace_mshv_mem_read(gpa, size);
+    }
+
+    ret = address_space_rw(&address_space_memory, gpa, memattr, (void *)data,
+                           size, false);
+    if (ret == MEMTX_OK) {
+        return 0;
+    }
+
+    if (ret == MEMTX_DECODE_ERROR) {
+        return handle_unmapped_mmio_region_read(gpa, size, data);
+    }
+
+    error_report("failed to read guest memory at 0x%lx", gpa);
+    return -1;
+}
+
+int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
+                         bool is_secure_mode)
+{
+    int ret;
+    MemTxAttrs memattr = { .secure = is_secure_mode };
+
+    trace_mshv_mem_write(gpa, size);
+    ret = address_space_rw(&address_space_memory, gpa, memattr, (void *)data,
+                           size, true);
+    if (ret == MEMTX_OK) {
+        return 0;
+    }
+
+    if (ret == MEMTX_DECODE_ERROR) {
+        warn_report("write to unmapped mmio region gpa=0x%lx size=%lu", gpa,
+                    size);
+        return 0;
+    }
+
+    error_report("Failed to write guest memory");
+    return -1;
+}
+
 static int set_memory(const MshvMemoryRegion *mshv_mr, bool add)
 {
     int ret = 0;
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d95893806f..e9f880b83e 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -432,7 +432,7 @@ static int mshv_init(MachineState *ms)
         return -1;
     }
 
-    mshv_init_cpu_logic();
+    mshv_init_mmio_emu();
 
     mshv_init_msicontrol();
 
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 9e3242d5e6..63104af68c 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -101,7 +101,7 @@ typedef enum MshvVmExit {
     MshvVmExitSpecial  = 2,
 } MshvVmExit;
 
-void mshv_init_cpu_logic(void);
+void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_configure_vcpu(const CPUState *cpu, const MshvFPU *fpu, uint64_t xcr0);
@@ -151,6 +151,10 @@ typedef struct MshvMemoryRegion {
 
 int mshv_add_mem(int vm_fd, const MshvMemoryRegion *mr);
 int mshv_remove_mem(int vm_fd, const MshvMemoryRegion *mr);
+int mshv_guest_mem_read(uint64_t gpa, uint8_t *data, uintptr_t size,
+                        bool is_secure_mode, bool instruction_fetch);
+int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
+                         bool is_secure_mode);
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
 
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index a17be79a77..d177fe5826 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -102,6 +102,34 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
     HV_X64_REGISTER_XMM_CONTROL_STATUS,
 };
 
+static int translate_gva(int cpu_fd, uint64_t gva, uint64_t *gpa,
+                         uint64_t flags)
+{
+    int ret;
+    union hv_translate_gva_result result = { 0 };
+
+    *gpa = 0;
+    mshv_translate_gva args = {
+        .gva = gva,
+        .flags = flags,
+        .gpa = (__u64 *)gpa,
+        .result = &result,
+    };
+
+    ret = ioctl(cpu_fd, MSHV_TRANSLATE_GVA, &args);
+    if (ret < 0) {
+        error_report("failed to invoke gpa->gva translation");
+        return -errno;
+    }
+    if (result.result_code != HV_TRANSLATE_GVA_SUCCESS) {
+        error_report("failed to translate gva (" TARGET_FMT_lx ") to gpa", gva);
+        return -1;
+
+    }
+
+    return 0;
+}
+
 int mshv_set_generic_regs(int cpu_fd, hv_register_assoc *assocs, size_t n_regs)
 {
     struct mshv_vp_registers input = {
@@ -921,8 +949,104 @@ int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
     return 0;
 }
 
-void mshv_init_cpu_logic(void)
+static int guest_mem_read_with_gva(const CPUState *cpu, uint64_t gva,
+                                   uint8_t *data, uintptr_t size,
+                                   bool fetch_instruction)
+{
+    int ret;
+    uint64_t gpa, flags;
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    flags = HV_TRANSLATE_GVA_VALIDATE_READ;
+    ret = translate_gva(cpu_fd, gva, &gpa, flags);
+    if (ret < 0) {
+        error_report("failed to translate gva to gpa");
+        return -1;
+    }
+
+    ret = mshv_guest_mem_read(gpa, data, size, false, fetch_instruction);
+    if (ret < 0) {
+        error_report("failed to read from guest memory");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int guest_mem_write_with_gva(const CPUState *cpu, uint64_t gva,
+                                    const uint8_t *data, uintptr_t size)
+{
+    int ret;
+    uint64_t gpa, flags;
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
+    ret = translate_gva(cpu_fd, gva, &gpa, flags);
+    if (ret < 0) {
+        error_report("failed to translate gva to gpa");
+        return -1;
+    }
+    ret = mshv_guest_mem_write(gpa, data, size, false);
+    if (ret < 0) {
+        error_report("failed to write to guest memory");
+        return -1;
+    }
+    return 0;
+}
+
+static void write_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
+{
+    if (guest_mem_write_with_gva(cpu, addr, data, bytes) < 0) {
+        error_report("failed to write memory");
+        abort();
+    }
+}
+
+static void read_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
+{
+    if (guest_mem_read_with_gva(cpu, addr, data, bytes, false) < 0) {
+        error_report("failed to read memory");
+        abort();
+    }
+}
+
+static void fetch_instruction(CPUState *cpu, void *data,
+                              target_ulong addr, int bytes)
+{
+    if (guest_mem_read_with_gva(cpu, addr, data, bytes, true) < 0) {
+        error_report("failed to fetch instruction");
+        abort();
+    }
+}
+
+static void read_segment_descriptor(CPUState *cpu,
+                                    struct x86_segment_descriptor *desc,
+                                    enum X86Seg seg_idx)
+{
+    bool ret;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    SegmentCache *seg = &env->segs[seg_idx];
+    x86_segment_selector sel = { .sel = seg->selector & 0xFFFF };
+
+    ret = x86_read_segment_descriptor(cpu, desc, sel);
+    if (ret == false) {
+        error_report("failed to read segment descriptor");
+        abort();
+    }
+}
+
+static const struct x86_emul_ops mshv_x86_emul_ops = {
+    .fetch_instruction = fetch_instruction,
+    .read_mem = read_mem,
+    .write_mem = write_mem,
+    .read_segment_descriptor = read_segment_descriptor,
+};
+
+void mshv_init_mmio_emu(void)
 {
+    init_decoder();
+    init_emu(&mshv_x86_emul_ops);
 }
 
 void mshv_arch_init_vcpu(CPUState *cpu)
-- 
2.34.1


