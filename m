Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBE8CD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 18:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKKr6-0000g1-F2; Tue, 05 May 2026 14:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wKKr4-0000fg-6K
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:50:50 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wKKr1-0006jG-Tf
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:50:49 -0400
Received: from laptop.localdomain (unknown [86.121.140.248])
 by linux.microsoft.com (Postfix) with ESMTPSA id AD4BD20B716C;
 Tue,  5 May 2026 11:50:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD4BD20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778007042;
 bh=0BKwOecAhGjoVx5AIvhBMINDtDxE83/qd2X5k8o4a3M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b79crTMftNC+TelxPmY49Gsnezfg5vHhvkJapjNewH3I83BVriVlIgLzkKauWqL7x
 pc7pbmE9+sLvx94I6zjzZHZ7KdWUDQc5jofu0cpWBsxnct0EQ5B/1G/ESmtpV5QHOX
 TRBs3YiCaSP47FF2I3C6xNiaGfyy7ayfYgsGUo9Y=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 4/7] target/i386/mshv: hv_vp_register_page setup for the
 vcpu
Date: Tue,  5 May 2026 21:50:25 +0300
Message-ID: <20260505185028.237207-5-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
References: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the vcpu is created, call mmap to configure access to the register page.
In case the call to mmap fails, we log an error and continue with the
previous logic (using hypercalls).

Update CPUArchState to store a pointer to the mmapped hv_vp_register_page.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 target/i386/cpu.h           |  5 +++++
 target/i386/mshv/mshv-cpu.c | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 16de67e546..fd4c3712b1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2019,6 +2019,11 @@ typedef struct CPUArchState {
     uint64_t msr_bndcfgs;
     uint64_t efer;
 
+#ifdef CONFIG_MSHV
+    /* Shared register page */
+    struct hv_vp_register_page *regs_page;
+#endif
+
     /* Beginning of state preserved by INIT (dummy marker).  */
     struct {} start_init_save;
 
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 9defd05db6..3a3c269c33 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1587,6 +1587,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     CPUX86State *env = &x86_cpu->env;
     AccelCPUState *state = cpu->accel;
     size_t page = HV_HYP_PAGE_SIZE;
+    void *regs_page;
     void *mem = qemu_memalign(page, 2 * page);
 
     /* sanity check, to make sure we don't overflow the page */
@@ -1595,6 +1596,22 @@ void mshv_arch_init_vcpu(CPUState *cpu)
                       + sizeof(hv_input_get_vp_registers)
                       > HV_HYP_PAGE_SIZE));
 
+
+    /* mmap the registers page */
+    regs_page = mmap(NULL, page, PROT_READ | PROT_WRITE,
+                    MAP_SHARED, mshv_vcpufd(cpu),
+                    MSHV_VP_MMAP_OFFSET_REGISTERS * page);
+    if (regs_page == MAP_FAILED) {
+        /*
+         * Error is not fatal, but we won't be able to use the
+         * fast path for register access
+         */
+        error_report("register page mmap failed: %s", strerror(errno));
+        env->regs_page = NULL;
+    } else {
+        env->regs_page = (struct hv_vp_register_page *) regs_page;
+    }
+
     state->hvcall_args.base = mem;
     state->hvcall_args.input_page = mem;
     state->hvcall_args.output_page = (uint8_t *)mem + page;
@@ -1608,6 +1625,11 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
     CPUX86State *env = &x86_cpu->env;
     AccelCPUState *state = cpu->accel;
 
+    /* Unmap the register page */
+    if (env->regs_page) {
+        munmap(env->regs_page, HV_HYP_PAGE_SIZE);
+        env->regs_page = NULL;
+    }
     g_free(state->hvcall_args.base);
     state->hvcall_args = (MshvHvCallArgs){0};
     g_clear_pointer(&env->emu_mmio_buf, g_free);
-- 
2.53.0


