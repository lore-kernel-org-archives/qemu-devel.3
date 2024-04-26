Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2A8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0IGl-0003bd-5O; Fri, 26 Apr 2024 05:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s0IGi-0003bL-SB
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:53:24 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s0IGg-0006B7-SX
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714125203; x=1745661203;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qijGxXFvV8iZRXcREWHGG85ad89+AhgWWgpYseJlNhg=;
 b=ViTPW3Asyt1nGhz25GUAFoXZc0BVrcBAklKv39cozW0MwRdXEKHhQ7vW
 TK8mroCfOQQ9fUwhPTGisGErDd2B7nE42VHiRGIDx9sLR4GFlI3JHZxL4
 cTUkOZTG9C9YhwaA7hRoBZ9bPuN+1X4XNsr7vg5vG1iCm7WPZMcVbmW13
 houfhPaZOcQ0Pu/sw/p8VpryIJ2ayF+veWPA7wr9WhZbZgFjHMOwqewQv
 HN29yQTvuEBn4Tc+7Huu8IBTRNOleM2OKnBdKuD+z+xJJsImKh86KbzWv
 HEdh/BSKVa/7lixj3+PoTz67KALbBUOBe8KzEUIUFehYqd7rztij/Xx5r A==;
X-CSE-ConnectionGUID: GGh4wb74QvWOkC24xLPw7g==
X-CSE-MsgGUID: BwLIHBUHQcWK0fpvD10S6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9707411"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9707411"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 02:53:21 -0700
X-CSE-ConnectionGUID: LD77/FKTQr2Z/8ciWMY+UQ==
X-CSE-MsgGUID: g1IuyKSmQXmpL7xat0jwpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; d="scan'208";a="25412325"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 26 Apr 2024 02:53:19 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/6] target/i386/kvm: Only Save/load kvmclock MSRs when
 kvmclock enabled
Date: Fri, 26 Apr 2024 18:07:12 +0800
Message-Id: <20240426100716.2111688-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426100716.2111688-1-zhao1.liu@intel.com>
References: <20240426100716.2111688-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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
index b2c52ec9561f..75d2091c4f8c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3372,8 +3372,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
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
@@ -3837,8 +3839,10 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_LSTAR, 0);
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


