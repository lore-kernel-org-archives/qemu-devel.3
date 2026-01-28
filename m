Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C82D46C15
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 23:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlEnT-0000ER-GD; Wed, 28 Jan 2026 18:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnS-0000Da-D5
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:18:02 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnQ-0001j1-RL
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769642281; x=1801178281;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6+39BohlqHVgxOCjKzqyCTw+ClCJeAPxpVGdX6TNBB4=;
 b=AujTmIFuu8DbyLPcbsg/4JjBaZO421ax9bClmeePQfjD9bO0c6uA3hgD
 NJBYtdCMG+6IAi7pgGy9ItrGVvR5XbLVGHPsm0g+tUz3JxZMlNnVjcH54
 g3L6VfStw0S+w6H2/tXe5x7ES3cHU+7CpWgVujMKfcA3fBfeIH5Mzi4Ih
 myiT1OOqbr3ZX6YVlEPLtRNb/0SBVvm8HtSBqhb82W/DeL+sFOHk1sqlw
 k9bSLqSJPyQt4V1wPabOBVdXR/B/Grg2zwXvJ4hHGiLB2A0gBbgmEm6Ko
 s7id1Z9i7MPe2PCtgfehVI51rw9JXBFnXJdkP96qrpLYb2zj862ch7WOY w==;
X-CSE-ConnectionGUID: dcUP9UnqQAiROYFvvC1i+A==
X-CSE-MsgGUID: E++6xh7lTgKc+0N1WxorlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462354"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="73462354"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:43 -0800
X-CSE-ConnectionGUID: sh1uBdSpQ7ak5CJQl2wDHA==
X-CSE-MsgGUID: 0sB7ehxMQbiQhy6+npxnnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208001794"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:42 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 11/11] target/i386: Disable guest PEBS capability when not
 enabled
Date: Wed, 28 Jan 2026 15:09:48 -0800
Message-ID: <20260128231003.268981-12-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128231003.268981-1-zide.chen@intel.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When PMU is disabled, guest CPUID must not advertise Debug Store
support.  Clear both CPUID.01H:EDX[21] (DS) and CPUID.01H:ECX[2]
(DS64) in this case.

Set IA32_MISC_ENABLE[12] (PEBS_UNAVAILABLE) when Debug Store is not
exposed to the guest.

Note: Do not infer that PEBS is unsupported from
IA32_PERF_CAPABILITIES[11:8] (PEBS_FMT) being 0.  A value of 0 is a
valid PEBS record format on some CPUs.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- New patch.

 target/i386/cpu.c | 6 ++++++
 target/i386/cpu.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ec6f49916de3..445361ab7a06 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9180,6 +9180,10 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
         env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_MWAIT;
     }
 
+    if (!(env->features[FEAT_1_EDX] & CPUID_DTS)) {
+        env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL;
+    }
+
     memset(env->dr, 0, sizeof(env->dr));
     env->dr[6] = DR6_FIXED_1;
     env->dr[7] = DR7_FIXED_1;
@@ -9474,6 +9478,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
         }
 
+        env->features[FEAT_1_ECX] &= ~CPUID_EXT_DTES64;
+        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
         env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
     }
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5ab107dfa29f..0fecf561173e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -483,6 +483,7 @@ typedef enum X86Seg {
 /* Indicates good rep/movs microcode on some processors: */
 #define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)
 #define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
+#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL  (1ULL << 12)
 #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
 #define MSR_IA32_MISC_ENABLE_DEFAULT    (MSR_IA32_MISC_ENABLE_FASTSTRING     |\
                                          MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
-- 
2.52.0


