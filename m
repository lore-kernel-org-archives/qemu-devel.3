Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82801606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=me5M4mxe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWEJR-0008Mo-DA; Wed, 25 Nov 2026 09:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xWEJF-0008Ki-85
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:49:22 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xWEJD-0007N8-7V
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:49:20 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.58])
 by linux.microsoft.com (Postfix) with ESMTPSA id 281C520B7170;
 Wed, 25 Nov 2026 06:49:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 281C520B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795618152;
 bh=XV7YvHEaSEieA8wmY48i0AyjBuEQa91Ft6PnsOiMnGA=;
 h=From:To:Cc:Subject:Date:From;
 b=me5M4mxey578krAcja3O3Q0woh4dt+7dk4nc7O+lPJCgJgWduGRauGSRRoQ5zIj/Y
 RGh4a2bDGTe0aarty9D4DaGTw77KflHy/lcSGQMzuGVxta2zfz+76WCa3wcW7jmJoA
 q+UqpvUksHWVFm/zFW4ksfTu+KA2LLP6y2S2aLrU=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH] target/i386/mshv: add SynIC MSR init routine
Date: Wed, 25 Nov 2026 15:49:11 +0100
Message-Id: <20261125144911.52270-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Windows guests on Microsoft Hypervisor expect to be initialized with a
specific set of values in its SynIC MSRs, otherwise the paravirtualized
timers will not work and boot will stall.

Reference:

https://github.com/microsoft/openvmm/blob/8d4e0313/vmm_core/virt/src/x86/vp.rs

L1801-L1813

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv.h       |  3 +++
 include/system/mshv_int.h   |  1 +
 target/i386/cpu.c           |  4 ++++
 target/i386/mshv/mshv-cpu.c |  5 +++++
 target/i386/mshv/synic.c    | 14 ++++++++++++++
 5 files changed, 27 insertions(+)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 864f2aa34d..1c80916619 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -79,4 +79,7 @@ void mshv_init_irq_routing(MshvState *s);
 /* cpuid */
 uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 
+/* cpu */
+void mshv_arch_reset_vcpu(CPUState *cpu);
+
 #endif
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 01da21affe..e3e46304f9 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -172,5 +172,6 @@ int mshv_set_siefp(int cpu_fd, const uint8_t *page);
 bool mshv_synic_enabled(const CPUState *cpu);
 int mshv_get_synthetic_timers(int cpu_fd, uint8_t *state);
 int mshv_set_synthetic_timers(int cpu_fd, const uint8_t *state);
+void mshv_init_synic(CPUState *cpu);
 
 #endif
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a4d4..7d587a846c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9569,6 +9569,10 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
         kvm_arch_reset_vcpu(cpu);
     }
 
+    if (mshv_enabled()) {
+        mshv_arch_reset_vcpu(cs);
+    }
+
     x86_cpu_set_sgxlepubkeyhash(env);
 
     env->amd_tsc_scale_msr =  MSR_AMD64_TSC_RATIO_DEFAULT;
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index c145bbc447..be6530d641 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -2467,6 +2467,11 @@ static int set_unimplemented_msr_action(int vm_fd)
     return 0;
 }
 
+void mshv_arch_reset_vcpu(CPUState *cpu)
+{
+    mshv_init_synic(cpu);
+}
+
 int mshv_arch_post_init_vm(int vm_fd)
 {
     int ret;
diff --git a/target/i386/mshv/synic.c b/target/i386/mshv/synic.c
index 4c629adc3a..7bd6727376 100644
--- a/target/i386/mshv/synic.c
+++ b/target/i386/mshv/synic.c
@@ -204,3 +204,17 @@ int mshv_set_siefp(int cpu_fd, const uint8_t *page)
 
     return 0;
 }
+
+void mshv_init_synic(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    size_t i;
+
+    env->msr_hv_synic_control  = 1;
+    env->msr_hv_synic_evt_page = 0;
+    env->msr_hv_synic_msg_page = 0;
+    for (i = 0; i < HV_SINT_COUNT; i++) {
+        env->msr_hv_synic_sint[i] = 0x10000;
+    }
+}
-- 
2.34.1


