Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAE5CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYtD-0001n3-HW; Tue, 16 Sep 2025 12:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYt1-0001id-MG
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:50:38 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYsw-0006ne-7Z
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:50:34 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 84D93201551B;
 Tue, 16 Sep 2025 09:50:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 84D93201551B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041427;
 bh=92Zwia7AwSoqZyf4FAGeyiSGym/P5bstL9cfswPucz4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QlkV+m6A3H78laYUMiiWHO/cm4YmNPChtFLm9vuAcVNpiOD+DkUIySsLtbw5u34Vg
 zLTgDDDrEJtjH1hwHCa/xdcvYFhFcRiuURBk7t9DHWgmCH2jRQtnt5GPZcE5REPwrl
 pFlL2Am0kAsiS5VuwAFK7C9s6Y2ncseKfxs6UQGA=
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
Subject: [PATCH v4 13/27] target/i386/mshv: Implement mshv_store_regs()
Date: Tue, 16 Sep 2025 18:48:33 +0200
Message-Id: <20250916164847.77883-14-magnuskulke@linux.microsoft.com>
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

Add support for writing general-purpose registers to MSHV vCPUs
during initialization or migration using the MSHV register interface. A
generic set_register call is introduced to abstract the HV call over
the various register types.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv.h       |   3 +
 target/i386/mshv/mshv-cpu.c | 116 +++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index a2103b0a24..abd17af73e 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -19,6 +19,7 @@
 #include "hw/hyperv/hyperv-proto.h"
 #include "linux/mshv.h"
 #include "hw/hyperv/hvhdk.h"
+#include "hw/hyperv/hvgdk_mini.h"
 #include "qapi/qapi-types-common.h"
 #include "system/memory.h"
 #include "accel/accel-ops.h"
@@ -92,6 +93,8 @@ void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
+int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
+                          size_t n_regs);
 int mshv_arch_put_registers(const CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index e848461c0e..aa6776c2ae 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -31,12 +31,124 @@
 
 #include <sys/ioctl.h>
 
+static enum hv_register_name STANDARD_REGISTER_NAMES[18] = {
+    HV_X64_REGISTER_RAX,
+    HV_X64_REGISTER_RBX,
+    HV_X64_REGISTER_RCX,
+    HV_X64_REGISTER_RDX,
+    HV_X64_REGISTER_RSI,
+    HV_X64_REGISTER_RDI,
+    HV_X64_REGISTER_RSP,
+    HV_X64_REGISTER_RBP,
+    HV_X64_REGISTER_R8,
+    HV_X64_REGISTER_R9,
+    HV_X64_REGISTER_R10,
+    HV_X64_REGISTER_R11,
+    HV_X64_REGISTER_R12,
+    HV_X64_REGISTER_R13,
+    HV_X64_REGISTER_R14,
+    HV_X64_REGISTER_R15,
+    HV_X64_REGISTER_RIP,
+    HV_X64_REGISTER_RFLAGS,
+};
+
+int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
+                          size_t n_regs)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    int vp_index = cpu->cpu_index;
+    size_t in_sz, assocs_sz;
+    hv_input_set_vp_registers *in;
+    struct mshv_root_hvcall args = {0};
+    int ret;
+
+    /* find out the size of the struct w/ a flexible array at the tail */
+    assocs_sz = n_regs * sizeof(hv_register_assoc);
+    in_sz = sizeof(hv_input_set_vp_registers) + assocs_sz;
+
+    /* fill the input struct */
+    in = g_malloc0(in_sz);
+    in->vp_index = vp_index;
+    memcpy(in->elements, assocs, assocs_sz);
+
+    /* create the hvcall envelope */
+    args.code = HVCALL_SET_VP_REGISTERS;
+    args.in_sz = in_sz;
+    args.in_ptr = (uint64_t) in;
+    args.reps = (uint16_t) n_regs;
+
+    /* perform the call */
+    ret = mshv_hvcall(cpu_fd, &args);
+    g_free(in);
+    if (ret < 0) {
+        error_report("Failed to set registers");
+        return -1;
+    }
+
+    /* assert we set all registers */
+    if (args.reps != n_regs) {
+        error_report("Failed to set registers: expected %zu elements"
+                     ", got %u", n_regs, args.reps);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_standard_regs(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)];
+    int ret;
+    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
+
+    /* set names */
+    for (size_t i = 0; i < ARRAY_SIZE(STANDARD_REGISTER_NAMES); i++) {
+        assocs[i].name = STANDARD_REGISTER_NAMES[i];
+    }
+    assocs[0].value.reg64 = env->regs[R_EAX];
+    assocs[1].value.reg64 = env->regs[R_EBX];
+    assocs[2].value.reg64 = env->regs[R_ECX];
+    assocs[3].value.reg64 = env->regs[R_EDX];
+    assocs[4].value.reg64 = env->regs[R_ESI];
+    assocs[5].value.reg64 = env->regs[R_EDI];
+    assocs[6].value.reg64 = env->regs[R_ESP];
+    assocs[7].value.reg64 = env->regs[R_EBP];
+    assocs[8].value.reg64 = env->regs[R_R8];
+    assocs[9].value.reg64 = env->regs[R_R9];
+    assocs[10].value.reg64 = env->regs[R_R10];
+    assocs[11].value.reg64 = env->regs[R_R11];
+    assocs[12].value.reg64 = env->regs[R_R12];
+    assocs[13].value.reg64 = env->regs[R_R13];
+    assocs[14].value.reg64 = env->regs[R_R14];
+    assocs[15].value.reg64 = env->regs[R_R15];
+    assocs[16].value.reg64 = env->eip;
+    lflags_to_rflags(env);
+    assocs[17].value.reg64 = env->eflags;
+
+    ret = mshv_set_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to set standard registers");
+        return -errno;
+    }
+    return 0;
+}
+
 int mshv_store_regs(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    int ret;
+
+    ret = set_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to store standard registers");
+        return -1;
+    }
+
+    return 0;
 }
 
+
 int mshv_load_regs(CPUState *cpu)
 {
     error_report("unimplemented");
-- 
2.34.1


