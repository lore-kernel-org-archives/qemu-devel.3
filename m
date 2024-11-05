Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4081D1CA3B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DHc-00075b-53; Tue, 05 Nov 2024 01:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DFq-0003v8-Mb
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:41:31 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DFF-0001vd-Nc
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788854; x=1762324854;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Pfq6Mcq11nNik95S/q8D/VnbY9hYdtshEgdTuCa1i80=;
 b=QChRkxRZwNrq8GCwW26Ax5FxR1z34sxbilHz0/rblbNLqD+By90An9Pl
 CtQxhE7c1F8PxoRRD8nQ2eQ9qCYWrrtoueOFPr8T/2ZbfsOt2vst3Srrs
 ibSO2Vt5/F1uL/NaKTMzdQi3l+78k78UI3kjGy1st9Ji8mG3xq09y2AIA
 BFd1NPB9WGcXpXhXc1ewQJ2NPg2VboUgmA3ooxydO7vavZ9Wl/N5AENV8
 aa8wNccZMhSJstqLPJWVSMVNYAQlHldw3p08JFp9i8sYRuIHMYTmZM7v3
 wcmDMoSu9pw5WaKN0zQP0hCUnXjGAqpa9An9kIbW+q4DWPyNbxUKs4Qtm Q==;
X-CSE-ConnectionGUID: Hggi8ScXS+KUluoimmC5og==
X-CSE-MsgGUID: 0H4ma58zSvG3z3sB1gKUHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689951"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689951"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:40:31 -0800
X-CSE-ConnectionGUID: 1JcGSuUsQHiwhLm+UNgIxA==
X-CSE-MsgGUID: 7h2gpC2BS6GDQQ3w3SMvwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83990113"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:40:26 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 58/60] cpu: Introduce qemu_early_init_vcpu()
Date: Tue,  5 Nov 2024 01:24:06 -0500
Message-Id: <20241105062408.3533704-59-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently cpu->nr_cores and cpu->nr_threads are initialized in
qemu_init_vcpu(), which is called a bit late in *cpu_realizefn() for
each ARCHes.

x86 arch would like to set CPUID_HT in env->features[FEAT_1_EDX] based
on the value of cpu->nr_threads * cpu->nr_cores. It requires nr_cores
and nr_threads being initialized earlier.

Introdue qemu_early_init_vcpu() for this purpose.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/tcg/user-exec-stub.c | 4 ++++
 include/hw/core/cpu.h      | 8 ++++++++
 system/cpus.c              | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4fbe2dbdc883..64baf917b55c 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -10,6 +10,10 @@ void cpu_remove_sync(CPUState *cpu)
 {
 }
 
+void qemu_early_init_vcpu(CPUState *cpu)
+{
+}
+
 void qemu_init_vcpu(CPUState *cpu)
 {
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3ca0babcb3f..854b244e1ad6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1063,6 +1063,14 @@ void start_exclusive(void);
  */
 void end_exclusive(void);
 
+/**
+ * qemu_early_init_vcpu:
+ * @cpu: The vCPU to initialize.
+ *
+ * Early initializes a vCPU.
+ */
+void qemu_early_init_vcpu(CPUState *cpu);
+
 /**
  * qemu_init_vcpu:
  * @cpu: The vCPU to initialize.
diff --git a/system/cpus.c b/system/cpus.c
index 1c818ff6828c..98cb8aafa50b 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -662,6 +662,14 @@ const AccelOpsClass *cpus_get_accel(void)
     return cpus_accel;
 }
 
+void qemu_early_init_vcpu(CPUState *cpu)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
+    cpu->nr_threads =  ms->smp.threads;
+}
+
 void qemu_init_vcpu(CPUState *cpu)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
-- 
2.34.1


