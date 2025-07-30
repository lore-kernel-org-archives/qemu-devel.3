Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D86C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 10:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh3ha-0003Sh-2v; Wed, 30 Jul 2025 06:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uh3dF-0000TU-Tk
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:01:59 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uh3dD-0000Fa-4W
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753869715; x=1785405715;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SX69dZbTeDRqT85P3OS0gxXN49cTJriiGqUqqVvCnTg=;
 b=hU+nKufKCyN6YkDxTk3h0CJjfUjSee6q3td6+6wEPhlmQ+NjB2cLLInM
 9C15u3I6JHHbyTwdsOBFO81PB/gwVwUdcZ1Ipwxz0fybAzYTUEOJGtg02
 ktiI0VIM7xsbW40AWsmI6kqBt3gJlwfUQSQM+LIrsyUeRkAmxaiFRdyLp
 xqK+FpDicQ5+huVNX4Qb8Ogc/wuk05NhysnEtqsHq5YEQuGGtyZ8g1eUi
 RzW6TvcuUKtbmsKTIM/35WYYrKTvhWpXqOpYTyLcOTDxmWBREqj8Uzmti
 F0g1egdxlVDg6WL50qdGp5AMRgVawOk079/GW0cmXSnxbHkBdm2VkcKlK g==;
X-CSE-ConnectionGUID: LmMGdtfKQ5epi+zy7uh9jA==
X-CSE-MsgGUID: hrMM+y2GTryLHxczXT60Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="59992082"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="59992082"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:01:53 -0700
X-CSE-ConnectionGUID: cGKLHRV1SXKiFfGFZv1WLA==
X-CSE-MsgGUID: 4bYSmVNaSiSIdJk6NiYbqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="162971758"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 30 Jul 2025 03:01:51 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 2/2] target/i386: Define enum X86ASIdx for x86's address
 spaces
Date: Wed, 30 Jul 2025 17:52:53 +0800
Message-ID: <20250730095253.1833411-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730095253.1833411-1-xiaoyao.li@intel.com>
References: <20250730095253.1833411-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.244, RCVD_IN_DNSWL_MED=-2.3,
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

Define X86ASIdx as enum, like ARM's ARMASIdx, so that it's clear index 0
is for memory and index 1 is for SMM.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-By: Kirill Martynov <stdcalllevi@yandex-team.ru>
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
index 1dc1ba9b4869..9c25b5583955 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -99,7 +99,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * initialized at register_smram_listener() after machine init done.
      */
     cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
-    cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
+    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
 
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


