Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A1BD3E787
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 02:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8W7d-00076T-C7; Tue, 05 Nov 2024 21:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7T-00071K-8L
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:50:11 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7R-0003OA-Hk
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730861406; x=1762397406;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JcVwYkgHmlLrfByBJgICNQrNbswie+WUwEU7n23xvn8=;
 b=e4vprRTVDRh1eGfGCpsGg51FxVivho78uArRoghZYd6HbyfM1LT5gFyR
 38GwwRmww/uNZe/1R91pi6pGJNromznYeZqrDTuJvJZSD7j0h2a0HDfkw
 nhCVTPkdskC4mv1Z6w3nMhC2ZbTr7y3ioySQzVd1RyXn070C5dBQNF46c
 +D99O6rc4w/pG8c0j46ZglW715Hu7zl6LsJ+MartGGacGhYMTdk4T1R7d
 KDg8WNsNWu3P7p/1/2DJdeSU/R3SU0zK6YizqLipoL2CeanM/9Yigj9zU
 48uajstJEzb1/Y446b1epRFNEqGWYJnoctgb3Digk2lN1IzFTottPdOqS A==;
X-CSE-ConnectionGUID: t2q2nvOISXaTSIBS114ovw==
X-CSE-MsgGUID: R0K1VOrvRKqP6Zqb3kaIKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30492271"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30492271"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 18:50:05 -0800
X-CSE-ConnectionGUID: T5TLU2G+Su6PkrVLoalTGw==
X-CSE-MsgGUID: YSLwJp0WSqyljdTgl/zOVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="115077998"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2024 18:50:02 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 05/11] target/i386/kvm: Save/load MSRs of kvmclock2
 (KVM_FEATURE_CLOCKSOURCE2)
Date: Wed,  6 Nov 2024 11:07:22 +0800
Message-Id: <20241106030728.553238-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106030728.553238-1-zhao1.liu@intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

MSR_KVM_SYSTEM_TIME_NEW and MSR_KVM_WALL_CLOCK_NEW are bound to
kvmclock2 (KVM_FEATURE_CLOCKSOURCE2).

Add the save/load support for these 2 MSRs just like kvmclock MSRs.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
---
 target/i386/cpu.h     |  2 ++
 target/i386/kvm/kvm.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c4ec64e0078f..79c28a48eb70 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1886,6 +1886,8 @@ typedef struct CPUArchState {
 
     uint64_t system_time_msr;
     uint64_t wall_clock_msr;
+    uint64_t system_time_new_msr;
+    uint64_t wall_clock_new_msr;
     uint64_t steal_time_msr;
     uint64_t async_pf_en_msr;
     uint64_t async_pf_int_msr;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4aba034865bb..b175cd4a4bcb 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3962,6 +3962,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
             kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
             kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
         }
+        if (env->features[FEAT_KVM] & CPUID_KVM_CLOCK2) {
+            kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME_NEW,
+                              env->system_time_new_msr);
+            kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK_NEW,
+                              env->wall_clock_new_msr);
+        }
         if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
             kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, env->async_pf_int_msr);
         }
@@ -4442,6 +4448,10 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
         kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
     }
+    if (env->features[FEAT_KVM] & CPUID_KVM_CLOCK2) {
+        kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME_NEW, 0);
+        kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK_NEW, 0);
+    }
     if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
         kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
     }
@@ -4708,6 +4718,12 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_KVM_WALL_CLOCK:
             env->wall_clock_msr = msrs[i].data;
             break;
+        case MSR_KVM_SYSTEM_TIME_NEW:
+            env->system_time_new_msr = msrs[i].data;
+            break;
+        case MSR_KVM_WALL_CLOCK_NEW:
+            env->wall_clock_new_msr = msrs[i].data;
+            break;
         case MSR_MCG_STATUS:
             env->mcg_status = msrs[i].data;
             break;
-- 
2.34.1


