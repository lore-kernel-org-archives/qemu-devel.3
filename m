Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58280CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYuE-0006AP-0q; Tue, 16 Sep 2025 12:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYuA-0005rs-LO
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:51:47 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYu7-0006wY-IJ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:51:45 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 06E32201551D;
 Tue, 16 Sep 2025 09:51:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06E32201551D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041492;
 bh=U46aKR5cGVNg50iBr7A0bmAwBvajfntUwbnXqVuCYQo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AQR+sToqp6AeAEm5gUD3J2d6C3EYzgavoM+XyuNaI5bMzTRCdINvpD3SvMZWufutr
 93wQcCd3nfJ1h1WqNfftMyeTgt6CgkYQ489cAeYYt9ZSC5DkDmfrDuthbceR2VdCg/
 PJv336RHvN4WrP5jqocFSw1BB7jHu2K7uhOOwW/k=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 25/27] target/i386/mshv: Use preallocated page for hvcall
Date: Tue, 16 Sep 2025 18:48:45 +0200
Message-Id: <20250916164847.77883-26-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
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

There are hvcalls that are invoked during MMIO exits, the payload is of
dynamic size. To avoid heap allocations we can use preallocated pages as
in/out buffer for those calls. A page is reserved per vCPU and used for
set/get register hv calls.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       |  2 +-
 include/system/mshv.h       |  7 +++++++
 target/i386/mshv/mshv-cpu.c | 39 +++++++++++++++++++++++++------------
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 2f7b325985..35a10f7a78 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -398,8 +398,8 @@ static int mshv_init_vcpu(CPUState *cpu)
     uint8_t vp_index = cpu->cpu_index;
     int ret;
 
-    mshv_arch_init_vcpu(cpu);
     cpu->accel = g_new0(AccelCPUState, 1);
+    mshv_arch_init_vcpu(cpu);
 
     ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
     if (ret < 0) {
diff --git a/include/system/mshv.h b/include/system/mshv.h
index fc0a2829c1..c57a4058bc 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -74,9 +74,16 @@ typedef struct MshvState {
 } MshvState;
 extern MshvState *mshv_state;
 
+typedef struct MshvHvCallArgs {
+    void *base;
+    void *input_page;
+    void *output_page;
+} MshvHvCallArgs;
+
 struct AccelCPUState {
     int cpufd;
     bool dirty;
+    MshvHvCallArgs hvcall_args;
 };
 
 typedef struct MshvMsiControl {
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 6b7e795a36..52afc6b303 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -33,6 +33,11 @@
 
 #include <sys/ioctl.h>
 
+#define MAX_SIZE(a, b) ((a) > (b) ? (a) : (b))
+#define MAX_REGISTER_COUNT (MAX_SIZE(ARRAY_SIZE(STANDARD_REGISTER_NAMES), \
+                            MAX_SIZE(ARRAY_SIZE(SPECIAL_REGISTER_NAMES), \
+                                     ARRAY_SIZE(FPU_REGISTER_NAMES))))
+
 static enum hv_register_name STANDARD_REGISTER_NAMES[18] = {
     HV_X64_REGISTER_RAX,
     HV_X64_REGISTER_RBX,
@@ -150,7 +155,7 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
     int cpu_fd = mshv_vcpufd(cpu);
     int vp_index = cpu->cpu_index;
     size_t in_sz, assocs_sz;
-    hv_input_set_vp_registers *in;
+    hv_input_set_vp_registers *in = cpu->accel->hvcall_args.input_page;
     struct mshv_root_hvcall args = {0};
     int ret;
 
@@ -159,7 +164,7 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
     in_sz = sizeof(hv_input_set_vp_registers) + assocs_sz;
 
     /* fill the input struct */
-    in = g_malloc0(in_sz);
+    memset(in, 0, sizeof(hv_input_set_vp_registers));
     in->vp_index = vp_index;
     memcpy(in->elements, assocs, assocs_sz);
 
@@ -171,7 +176,6 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
 
     /* perform the call */
     ret = mshv_hvcall(cpu_fd, &args);
-    g_free(in);
     if (ret < 0) {
         error_report("Failed to set registers");
         return -1;
@@ -192,8 +196,8 @@ static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
 {
     int cpu_fd = mshv_vcpufd(cpu);
     int vp_index = cpu->cpu_index;
-    hv_input_get_vp_registers *in;
-    hv_register_value *values;
+    hv_input_get_vp_registers *in = cpu->accel->hvcall_args.input_page;
+    hv_register_value *values = cpu->accel->hvcall_args.output_page;
     size_t in_sz, names_sz, values_sz;
     int i, ret;
     struct mshv_root_hvcall args = {0};
@@ -203,15 +207,14 @@ static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
     in_sz = sizeof(hv_input_get_vp_registers) + names_sz;
 
     /* fill the input struct */
-    in = g_malloc0(in_sz);
+    memset(in, 0, sizeof(hv_input_get_vp_registers));
     in->vp_index = vp_index;
     for (i = 0; i < n_regs; i++) {
         in->names[i] = assocs[i].name;
     }
 
-    /* allocate value output buffer */
+    /* determine size of value output buffer */
     values_sz = n_regs * sizeof(union hv_register_value);
-    values = g_malloc0(values_sz);
 
     /* create the hvcall envelope */
     args.code = HVCALL_GET_VP_REGISTERS;
@@ -223,16 +226,13 @@ static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
 
     /* perform the call */
     ret = mshv_hvcall(cpu_fd, &args);
-    g_free(in);
     if (ret < 0) {
-        g_free(values);
         error_report("Failed to retrieve registers");
         return -1;
     }
 
     /* assert we got all registers */
     if (args.reps != n_regs) {
-        g_free(values);
         error_report("Failed to retrieve registers: expected %zu elements"
                      ", got %u", n_regs, args.reps);
         return -1;
@@ -242,7 +242,6 @@ static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
     for (i = 0; i < n_regs; i++) {
         assocs[i].value = values[i];
     }
-    g_free(values);
 
     return 0;
 }
@@ -1695,6 +1694,19 @@ void mshv_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
+    AccelCPUState *state = cpu->accel;
+    size_t page = HV_HYP_PAGE_SIZE;
+    void *mem = qemu_memalign(page, 2 * page);
+
+    /* sanity check, to make sure we don't overflow the page */
+    QEMU_BUILD_BUG_ON((MAX_REGISTER_COUNT
+                      * sizeof(hv_register_assoc)
+                      + sizeof(hv_input_get_vp_registers)
+                      > HV_HYP_PAGE_SIZE));
+
+    state->hvcall_args.base = mem;
+    state->hvcall_args.input_page = mem;
+    state->hvcall_args.output_page = (uint8_t *)mem + page;
 
     env->emu_mmio_buf = g_new(char, 4096);
 }
@@ -1703,7 +1715,10 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
+    AccelCPUState *state = cpu->accel;
 
+    g_free(state->hvcall_args.base);
+    state->hvcall_args = (MshvHvCallArgs){0};
     g_free(env->emu_mmio_buf);
     env->emu_mmio_buf = NULL;
 }
-- 
2.34.1


