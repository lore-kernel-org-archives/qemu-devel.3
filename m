Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12089C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkWc-0000Av-Br; Tue, 16 Jul 2024 11:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkWT-00006a-TR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:55:26 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkWO-0007SW-T2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721145321; x=1752681321;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M+INEDceyzqNpPErcKN6L7u48TTH5fEDjgdcYW5fAXE=;
 b=RmSdTa8u6fKU4Hwykhzlr+HD0az6CDdVnSRLWHWuRu6rPX2oPo475nQ4
 2Snv11i0eCwf3PUk5kUaPsr7sc9+AEuN5zdslJe6x2KX7lMUAJGlWqpzn
 lo8CC9NsUzIigJ3sHnZwtzVQU5romzRfn3PA59WCLGIC+S3V/H8tSfISd
 YQ7sWZwlqSYs9wBnZqwbYGYDOBCnZuxvBrYRXSaC1QeqZE3FQE66Zed54
 gTwSghJZzW2uXRMYDIq+yc6n5ZyS7Tt4VFHwXDitZH/DI0wc+Rb2paCeG
 bjOAJtDNB6Racn5rVjlzHWik1ukzoMpLhnIEHXl+mzvZCTQxlQFqICq4V Q==;
X-CSE-ConnectionGUID: KhCsjZsxTc6km0F4SgipXg==
X-CSE-MsgGUID: 8i+vroKPSOC+Hhm5aj5TlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18743719"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="18743719"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 08:54:58 -0700
X-CSE-ConnectionGUID: yaG6rVfWQRio/3iUZpNdng==
X-CSE-MsgGUID: NRCi32nqSbSgQyQJ9+MGCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="50788325"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 16 Jul 2024 08:54:55 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 4/9] target/i386/kvm: Save/load MSRs of kvmclock2
 (KVM_FEATURE_CLOCKSOURCE2)
Date: Wed, 17 Jul 2024 00:10:10 +0800
Message-Id: <20240716161015.263031-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716161015.263031-1-zhao1.liu@intel.com>
References: <20240716161015.263031-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
---
 target/i386/cpu.h     |  2 ++
 target/i386/kvm/kvm.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b59bdc1c9d9d..35dc68631989 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1826,6 +1826,8 @@ typedef struct CPUArchState {
 
     uint64_t system_time_msr;
     uint64_t wall_clock_msr;
+    uint64_t system_time_new_msr;
+    uint64_t wall_clock_new_msr;
     uint64_t steal_time_msr;
     uint64_t async_pf_en_msr;
     uint64_t async_pf_int_msr;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ac434e83b64c..64e54beac7b3 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3423,6 +3423,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
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
@@ -3901,6 +3907,10 @@ static int kvm_get_msrs(X86CPU *cpu)
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
@@ -4167,6 +4177,12 @@ static int kvm_get_msrs(X86CPU *cpu)
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


