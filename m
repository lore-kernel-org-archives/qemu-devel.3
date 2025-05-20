Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6B1C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLCl-0000KV-Bj; Tue, 20 May 2025 07:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLCg-0000CY-Hr
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:16 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLCe-0001LS-Dr
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:14 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2A16E20277F6;
 Tue, 20 May 2025 04:31:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A16E20277F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740720;
 bh=W4LKYthavmuvvxaZxR0lVZXzJBOu9RuspHqP0/OB6E0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IfVnqfZapC6M0V4Q59G0pabfQ03FHlGaj3Rg6xYYtkEPQfzrmhRTk8BlVGdHRXHk1
 pb04ZaYeFzh0dzEDnV8orD/N+70NXzmCbo3Vz64jCdBuwDPQluEXmsL1s9MLXiWFO7
 sBz7/gsVaPNXm2Gxix0ctv//mAlzBe5ylj0lL96Y=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 15/25] target/i386/mshv: Implement mshv_store_regs()
Date: Tue, 20 May 2025 13:30:08 +0200
Message-Id: <20250520113018.49569-16-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
 include/system/mshv.h       |  1 +
 target/i386/mshv/mshv-cpu.c | 89 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 458b182077..b2dec5a7ec 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -111,6 +111,7 @@ void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
+int mshv_set_generic_regs(int cpu_fd, hv_register_assoc *assocs, size_t n_regs);
 int mshv_arch_put_registers(const CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 0ba1dacaed..83dcdc7b70 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -37,6 +37,27 @@
 static QemuMutex *cpu_guards_lock;
 static GHashTable *cpu_guards;
 
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
 static void add_cpu_guard(int cpu_fd)
 {
     QemuMutex *guard;
@@ -62,12 +83,76 @@ static void remove_cpu_guard(int cpu_fd)
     }
 }
 
+int mshv_set_generic_regs(int cpu_fd, hv_register_assoc *assocs, size_t n_regs)
+{
+    struct mshv_vp_registers input = {
+        .count = n_regs,
+        .regs = assocs,
+    };
+
+    return ioctl(cpu_fd, MSHV_SET_VP_REGISTERS, &input);
+}
+
+static int set_standard_regs(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc *assocs;
+    size_t n_regs = sizeof(STANDARD_REGISTER_NAMES) / sizeof(hv_register_name);
+    int ret;
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    assocs = g_new0(hv_register_assoc, n_regs);
+
+    /* set names */
+    for (size_t i = 0; i < n_regs; i++) {
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
+    ret = mshv_set_generic_regs(cpu_fd, assocs, n_regs);
+    g_free(assocs);
+    if (ret < 0) {
+        error_report("failed to set standard registers");
+        return -errno;
+    }
+    return 0;
+}
+
 int mshv_store_regs(CPUState *cpu)
 {
-	error_report("unimplemented");
-	abort();
+    int ret;
+
+    ret = set_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to store standard registers");
+        return -1;
+    }
+
+    /* TODO: should store special registers? the equivalent hvf code doesn't */
+
+    return 0;
 }
 
+
 int mshv_load_regs(CPUState *cpu)
 {
 	error_report("unimplemented");
-- 
2.34.1


