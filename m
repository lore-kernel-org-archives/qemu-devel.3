Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3171DC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 05:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdDa-0001Ef-EM; Tue, 29 Jul 2025 01:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdDH-0001A0-SF
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 01:49:27 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdDF-0003O2-Mt
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 01:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753768162; x=1785304162;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jmBWm4UYQ2MUZHTUtB5Bnn1r1nrxFRr3zI05N00L7cw=;
 b=hc/jXRSjxyhyGzDz+q9tz6gTlgBji4f390U2TvHR3+DSlXmS2p4YWfrP
 lZDZPfeJPKsdQYakjcX7Lbhunns+l7CrwufYMMj7B+zVFabTOloZSHlVZ
 l74dFpgf3sXt5V8Hvn/kt49c6JRZseNDX7Nn6mlIgoE8RzYsJjZijhh6F
 8DXgNWrWJUvYcwvp8bKmY2DDSlwd7nzWK34ZlIxKWhiKqvHIm+Obq5SxJ
 H/1HkIMLtIIrknEq534S9egcL2rbUwy1tnczA+F1nil2NYT7RlQWIrxfw
 QHEQScJPfwVcNANynDynTJFeykLD8ALPBRss1JT8dv9zG9pHA6Oc/Xg0S g==;
X-CSE-ConnectionGUID: bKDFMo4LRZO5Dt8Aos6eSg==
X-CSE-MsgGUID: a/et28icTMaTObv1OjHEBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55907960"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55907960"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 22:49:21 -0700
X-CSE-ConnectionGUID: sTnBFxWwSMyqZVlt9vbTuw==
X-CSE-MsgGUID: iOyoLozTQDCR9mjdXjNLzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="199750970"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa001.jf.intel.com with ESMTP; 28 Jul 2025 22:49:18 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 2/2] target/i386: Define enum X86ASIdx for x86's address spaces
Date: Tue, 29 Jul 2025 13:40:23 +0800
Message-ID: <20250729054023.1668443-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729054023.1668443-1-xiaoyao.li@intel.com>
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.299, RCVD_IN_DNSWL_MED=-2.3,
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

Like ARM defines ARMASIdx, do the same to define X86ASIdx as enum. So
that it's more clear what index 0 is for memory and index 1 is for SMM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c              | 2 +-
 target/i386/cpu.h                | 5 +++++
 target/i386/kvm/kvm-cpu.c        | 2 +-
 target/i386/kvm/kvm.c            | 4 ++--
 target/i386/tcg/system/tcg-cpu.c | 4 ++--
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f865..e56c217a5a0d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2797,7 +2797,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     s->memory_listener.listener.coalesced_io_del = kvm_uncoalesce_mmio_region;
 
     kvm_memory_listener_register(s, &s->memory_listener,
-                                 &address_space_memory, 0, "kvm-memory");
+                                 &address_space_memory, X86ASIdx_MEM, "kvm-memory");
     memory_listener_register(&kvm_io_listener,
                              &address_space_io);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f977fc49a774..e0be7a740685 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2574,6 +2574,11 @@ static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
 
+typedef enum X86ASIdx {
+    X86ASIdx_MEM = 0,
+    X86ASIdx_SMM = 1,
+} X86ASIdx;
+
 #ifndef CONFIG_USER_ONLY
 static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
 {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index aa657c2a4627..36f5892d330e 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -99,7 +99,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * register_smram_listener() after machine init done.
      */
     cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
-    cpu_address_space_init(cs, 0, "cpu-mmeory", cs->memory);
+    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-mmeory", cs->memory);
 
     return true;
 }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 47fb5c673c8e..5621200be0f0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2728,10 +2728,10 @@ static void register_smram_listener(Notifier *n, void *unused)
 
     address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
     kvm_memory_listener_register(kvm_state, &smram_listener,
-                                 &smram_address_space, 1, "kvm-smram");
+                                 &smram_address_space, X86ASIdx_SMM, "kvm-smram");
 
     CPU_FOREACH(cpu) {
-        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
+        cpu_address_space_init(cpu, X86ASIdx_SMM, "cpu-smm", &smram_as_root);
     }
 }
 
diff --git a/target/i386/tcg/system/tcg-cpu.c b/target/i386/tcg/system/tcg-cpu.c
index 0538a4fd51a3..7255862c2449 100644
--- a/target/i386/tcg/system/tcg-cpu.c
+++ b/target/i386/tcg/system/tcg-cpu.c
@@ -74,8 +74,8 @@ bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
     memory_region_set_enabled(cpu->cpu_as_mem, true);
 
     cs->num_ases = 2;
-    cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
-    cpu_address_space_init(cs, 1, "cpu-smm", cpu->cpu_as_root);
+    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
+    cpu_address_space_init(cs, X86ASIdx_SMM, "cpu-smm", cpu->cpu_as_root);
 
     /* ... SMRAM with higher priority, linked from /machine/smram.  */
     cpu->machine_done.notify = tcg_cpu_machine_done;
-- 
2.43.0


