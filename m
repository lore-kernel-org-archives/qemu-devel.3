Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0071CCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYtE-0001rH-1O; Tue, 16 Sep 2025 12:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYt9-0001kl-02
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:50:44 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYt1-0006nu-Bk
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:50:42 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id BDD95201551D;
 Tue, 16 Sep 2025 09:50:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDD95201551D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041433;
 bh=+TuKu5puVJDVqEopV+cmTrbpR5ySM2nIGKbVGgr7J54=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hj42dPKfwewaQ1zbxIiT3VZ3OnQnDH+5qKZJ6v0x8Zc/TyFt1qIT2n/lO/1RxdgRo
 4VKlvffnf1wuwVbM5eMHjQxaT2YX2r4tPkjkl49TagECbeLCYESfgnGhOYgokMakll
 6IgrSZU/2jX4ZT0FH3lIhu7Nk1/crxDa+l1njfhE=
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
Subject: [PATCH v4 14/27] target/i386/mshv: Implement mshv_get_standard_regs()
Date: Tue, 16 Sep 2025 18:48:34 +0200
Message-Id: <20250916164847.77883-15-magnuskulke@linux.microsoft.com>
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

Fetch standard register state from MSHV vCPUs to support debugging,
migration, and other introspection features in QEMU.

Fetch standard register state from a MHSV vCPU's. A generic get_regs()
function and a mapper to map the different register representations are
introduced.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv.h       |   1 +
 target/i386/mshv/mshv-cpu.c | 116 +++++++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index abd17af73e..a893caf254 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -90,6 +90,7 @@ typedef enum MshvVmExit {
 void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
+int mshv_get_standard_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index aa6776c2ae..f51b6461d1 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -95,6 +95,66 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
     return 0;
 }
 
+static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
+                            size_t n_regs)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    int vp_index = cpu->cpu_index;
+    hv_input_get_vp_registers *in;
+    hv_register_value *values;
+    size_t in_sz, names_sz, values_sz;
+    int i, ret;
+    struct mshv_root_hvcall args = {0};
+
+    /* find out the size of the struct w/ a flexible array at the tail */
+    names_sz = n_regs * sizeof(hv_register_name);
+    in_sz = sizeof(hv_input_get_vp_registers) + names_sz;
+
+    /* fill the input struct */
+    in = g_malloc0(in_sz);
+    in->vp_index = vp_index;
+    for (i = 0; i < n_regs; i++) {
+        in->names[i] = assocs[i].name;
+    }
+
+    /* allocate value output buffer */
+    values_sz = n_regs * sizeof(union hv_register_value);
+    values = g_malloc0(values_sz);
+
+    /* create the hvcall envelope */
+    args.code = HVCALL_GET_VP_REGISTERS;
+    args.in_sz = in_sz;
+    args.in_ptr = (uint64_t) in;
+    args.out_sz = values_sz;
+    args.out_ptr = (uint64_t) values;
+    args.reps = (uint16_t) n_regs;
+
+    /* perform the call */
+    ret = mshv_hvcall(cpu_fd, &args);
+    g_free(in);
+    if (ret < 0) {
+        g_free(values);
+        error_report("Failed to retrieve registers");
+        return -1;
+    }
+
+    /* assert we got all registers */
+    if (args.reps != n_regs) {
+        g_free(values);
+        error_report("Failed to retrieve registers: expected %zu elements"
+                     ", got %u", n_regs, args.reps);
+        return -1;
+    }
+
+    /* copy values into assoc */
+    for (i = 0; i < n_regs; i++) {
+        assocs[i].value = values[i];
+    }
+    g_free(values);
+
+    return 0;
+}
+
 static int set_standard_regs(const CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -148,11 +208,63 @@ int mshv_store_regs(CPUState *cpu)
     return 0;
 }
 
+static void populate_standard_regs(const hv_register_assoc *assocs,
+                                   CPUX86State *env)
+{
+    env->regs[R_EAX] = assocs[0].value.reg64;
+    env->regs[R_EBX] = assocs[1].value.reg64;
+    env->regs[R_ECX] = assocs[2].value.reg64;
+    env->regs[R_EDX] = assocs[3].value.reg64;
+    env->regs[R_ESI] = assocs[4].value.reg64;
+    env->regs[R_EDI] = assocs[5].value.reg64;
+    env->regs[R_ESP] = assocs[6].value.reg64;
+    env->regs[R_EBP] = assocs[7].value.reg64;
+    env->regs[R_R8]  = assocs[8].value.reg64;
+    env->regs[R_R9]  = assocs[9].value.reg64;
+    env->regs[R_R10] = assocs[10].value.reg64;
+    env->regs[R_R11] = assocs[11].value.reg64;
+    env->regs[R_R12] = assocs[12].value.reg64;
+    env->regs[R_R13] = assocs[13].value.reg64;
+    env->regs[R_R14] = assocs[14].value.reg64;
+    env->regs[R_R15] = assocs[15].value.reg64;
+
+    env->eip = assocs[16].value.reg64;
+    env->eflags = assocs[17].value.reg64;
+    rflags_to_lflags(env);
+}
+
+int mshv_get_standard_regs(CPUState *cpu)
+{
+    struct hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)];
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
+
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = STANDARD_REGISTER_NAMES[i];
+    }
+    ret = get_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get standard registers");
+        return -1;
+    }
+
+    populate_standard_regs(assocs, env);
+    return 0;
+}
 
 int mshv_load_regs(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    int ret;
+
+    ret = mshv_get_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to load standard registers");
+        return -1;
+    }
+
+    return 0;
 }
 
 int mshv_arch_put_registers(const CPUState *cpu)
-- 
2.34.1


