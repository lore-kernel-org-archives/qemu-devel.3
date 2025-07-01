Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96B6C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeoM-00053K-F7; Tue, 01 Jul 2025 13:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWeoJ-0004qY-QD
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:30:23 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWeoF-0007CK-Dn
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:30:22 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5AEDE211223E;
 Tue,  1 Jul 2025 10:30:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AEDE211223E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751391007;
 bh=C+7n42woL/2+vR6WztTsm5hGebodSG3pZWyoUwEkXhA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rat76WuM0Nhji7YcwgK8wNL1O2t2VWAGjtiYFxMgiIMSM4gGj7/xCtxPdBNbhTHYW
 L8r76aumOPgZkJf4YjHUWiE5+XyXGG7D4kl2uP7oynVBJh6OUiTcXkkfO56PmidNiD
 xhPkWZl3yPkh0i1i/9eXiR9twANow2cM1Flho2lQ=
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
Subject: [PATCH v2 16/27] target/i386/mshv: Implement mshv_get_standard_regs()
Date: Tue,  1 Jul 2025 19:28:23 +0200
Message-Id: <20250701172834.44849-17-magnuskulke@linux.microsoft.com>
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

Fetch standard register state from MSHV vCPUs to support debugging,
migration, and other introspection features in QEMU.

Fetch standard register state from a MHSV vCPU's. A generic get_regs()
function and a mapper to map the different register representations are
introduced.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv.h       |  1 +
 target/i386/mshv/mshv-cpu.c | 69 +++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index adce4153d9..65f7fa15a0 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -88,6 +88,7 @@ typedef enum MshvVmExit {
 void mshv_init_cpu_logic(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
+int mshv_get_standard_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 4bd4e29b72..cb59d74eb4 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -61,6 +61,18 @@ int mshv_set_generic_regs(int cpu_fd, hv_register_assoc *assocs, size_t n_regs)
     return ioctl(cpu_fd, MSHV_SET_VP_REGISTERS, &input);
 }
 
+static int get_generic_regs(int cpu_fd, struct hv_register_assoc *assocs,
+                            size_t n_regs)
+{
+    struct mshv_vp_registers input = {
+        .count = n_regs,
+        .regs = assocs,
+    };
+
+    return ioctl(cpu_fd, MSHV_GET_VP_REGISTERS, &input);
+}
+
+
 static int set_standard_regs(const CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -115,11 +127,64 @@ int mshv_store_regs(CPUState *cpu)
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
+    int cpu_fd = mshv_vcpufd(cpu);
+    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
+
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = STANDARD_REGISTER_NAMES[i];
+    }
+    ret = get_generic_regs(cpu_fd, assocs, n_regs);
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


