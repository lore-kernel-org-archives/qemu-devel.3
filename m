Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA5EC7EE30
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 03:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUznC-0002hA-VB; Thu, 26 Jun 2025 23:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUznB-0002gj-5K
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:30:21 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUzn9-0007Kq-Iu
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750995020; x=1782531020;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vqumn9WyfeJIP89iUmDECJNuxthMp5H2k50wGBtggFg=;
 b=AHQeCeOywG82sbcFnruN5quMpi03ekoVHDoVLMVh05KgdHdAOdRw8btV
 ra2TnGlbOBLKs+UmOESX4m+/XxxfIniFXP6BlCx8vhCWv2rbKoYvy8Zoc
 EyMy6pSIoczkqsyFFamH59QD8ZJLS1+gH26ptk9xj1g3LdSBlmjASKjSQ
 Imk61rgHQXOOY6mzsO4yj/hrvSxJs/dG9wRFpCTvOcPoxD8TNr2QziHjs
 lkvmAUYQzn14J7pjyGcGg/l9iETLBqe0r7efxGBj8w7WaP/owGYMfu2bz
 SEZFBfWlS9WZCPKnVP6I8cb2X/P4jh0JiMU8vNxSVqIS03/9RLVYQI6o7 w==;
X-CSE-ConnectionGUID: +Ns6FmY7REu31GF+sdq+Rg==
X-CSE-MsgGUID: jTLAGG3aQkGGZV2ldaXY2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53247139"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="53247139"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 20:30:18 -0700
X-CSE-ConnectionGUID: qt+G+2++SoChamGiwrMUhg==
X-CSE-MsgGUID: bRaS3BYaSi2tHxhCpuRb7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="157084643"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 26 Jun 2025 20:30:16 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/4] i386/cpu: Mark CPUID 0x80000007[EBX] as reserved for Intel
Date: Fri, 27 Jun 2025 11:51:27 +0800
Message-Id: <20250627035129.2755537-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627035129.2755537-1-zhao1.liu@intel.com>
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Per SDM,

80000007H EAX Reserved = 0.
          EBX Reserved = 0.
          ECX Reserved = 0.
          EDX Bits 07-00: Reserved = 0.
              Bit 08: Invariant TSC available if 1.
              Bits 31-09: Reserved = 0.

EAX/EBX/ECX in CPUID 0x80000007 leaf are reserved for Intel.

At present, EAX is reserved for AMD, too. And AMD hasn't used ECX in
QEMU. So these 2 registers are both left as 0.

Therefore, only fix the EBX and excode it as 0 for Intel.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 867e08236540..6d590a9af389 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8374,7 +8374,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
     case 0x80000007:
         *eax = 0;
-        *ebx = env->features[FEAT_8000_0007_EBX];
+        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
+            *ebx = 0;
+        } else {
+            *ebx = env->features[FEAT_8000_0007_EBX];
+        }
         *ecx = 0;
         *edx = env->features[FEAT_8000_0007_EDX];
         break;
-- 
2.34.1


