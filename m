Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF9BC3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 04:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTDQ0-0008Rt-3J; Mon, 15 Jul 2024 00:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTDPy-0008MY-L3
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 00:34:30 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTDPx-0004FI-1J
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 00:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721018070; x=1752554070;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tKr89zQ0Ud3Nsxehy7urxxT9zgviuntFd5ByL5dN0Dg=;
 b=lUt2b5b1ICKpMrpB8P2FcdNt86YdQf1oWHnoP41BtilYfO4ILVBUuKY8
 24rWQdBI0DGR+mI6bHwfod1tVK1jBsT2nhAbDsTiGpK9Mc+adZkJjEZ9X
 ICxOZrtkZ85F2Gbu74gdfS1A49F1MKAqkgMKnDWgIpOOlB/1n6hexx0ir
 23Hv2sTn59fgXYxeYb3yNh83bEef8eqvFebb5/YMI0Z5ARxhGMKdGl380
 x8qZ7AUPIPtBhqNEr1gj3Qg6VNQi4ZRs5depbEAJ24zB1uZdxoq3MB10q
 7p1eJ2sfcdRjzR2XlxTsOB8c/MhGxWQ7oCOYveqe58/hwPS3jGFw3tt3t Q==;
X-CSE-ConnectionGUID: r6JyMEQoQ1OHb6As3mRvZA==
X-CSE-MsgGUID: UHo/i+WNSXmmGc4TqgBGTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35809829"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35809829"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2024 21:34:28 -0700
X-CSE-ConnectionGUID: d46rdVzSQbq2gUIPsr/NmA==
X-CSE-MsgGUID: Bdj/zOvLSmGvktFde+KVAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="54043070"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 14 Jul 2024 21:34:25 -0700
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
Subject: [PATCH v3 3/8] target/i386/kvm: Only save/load kvmclock MSRs when
 kvmclock enabled
Date: Mon, 15 Jul 2024 12:49:50 +0800
Message-Id: <20240715044955.3954304-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715044955.3954304-1-zhao1.liu@intel.com>
References: <20240715044955.3954304-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

MSR_KVM_SYSTEM_TIME and MSR_KVM_WALL_CLOCK are attached with the (old)
kvmclock feature (KVM_FEATURE_CLOCKSOURCE).

So, just save/load them only when kvmclock (KVM_FEATURE_CLOCKSOURCE) is
enabled.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/kvm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6ad5a7dbf1fd..ac434e83b64c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3419,8 +3419,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
      */
     if (level >= KVM_PUT_RESET_STATE) {
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
-        kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
-        kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
+        if (env->features[FEAT_KVM] & CPUID_KVM_CLOCK) {
+            kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
+            kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
+        }
         if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
             kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, env->async_pf_int_msr);
         }
@@ -3895,8 +3897,10 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 #endif
-    kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
-    kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
+    if (env->features[FEAT_KVM] & CPUID_KVM_CLOCK) {
+        kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
+        kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
+    }
     if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
         kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
     }
-- 
2.34.1


