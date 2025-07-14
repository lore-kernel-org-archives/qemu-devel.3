Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BCEC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEEr-0007Vt-Kt; Mon, 14 Jul 2025 04:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDub-0004eR-Ex
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:49 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDuX-0007OP-Q5
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752479262; x=1784015262;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qwRBWKP16OIxog568S/3DANL77UH91HATrNvZ4+PvjI=;
 b=KRCdrexdaJf+2AaVX9C/9L3Tnl71zrrOjk10rE7QGvvLdePMVHEsbuVB
 DuEyG1IfPTzZm3J6kzUt2x8z5iF/Z61to1UT1JbecEVI614YBofWYDa3l
 MOcXKuJUQcK+a0zxS2t8UtUQZ9ls9mFiXjh6NcKYnWsY0Jddogd7CmWKw
 nWGi9UpJ2nRhB8XIZlFsfqwtN+pWUQux/HxscSjpUKkHQmDPPqyugWfeZ
 f5Lehd57gRLjG5ivYGrdLzyiEXUo2406BEAJCcFn8PqeBMCvcXxlDV+Rm
 AGZYb4fmQ+96ivWTaSk6x97BU7QbTwdhZOoNr9a4q033dXQxzGMEvkSnT Q==;
X-CSE-ConnectionGUID: K3r3Kd9XQgqi1gDnBW7SsA==
X-CSE-MsgGUID: HqPkzkuITBWuEn/r+kN9xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58324654"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="58324654"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 00:47:39 -0700
X-CSE-ConnectionGUID: 6zsATw8ST5SG9llBlm/CjQ==
X-CSE-MsgGUID: 3Rd/7s9HSr+xqjfjf9kGFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="156952193"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 14 Jul 2025 00:47:36 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Tao Su <tao1.su@linux.intel.com>
Subject: [PATCH v2 2/7] i386/cpu: Mark CPUID 0x80000008 ECX bits[0:7] &
 [12:15] as reserved for Intel/Zhaoxin
Date: Mon, 14 Jul 2025 16:08:54 +0800
Message-Id: <20250714080859.1960104-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714080859.1960104-1-zhao1.liu@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

80000008H EAX Linear/Physical Address size.
              Bits 07-00: #Physical Address Bits*.
              Bits 15-08: #Linear Address Bits.
              Bits 31-16: Reserved = 0.
          EBX Bits 08-00: Reserved = 0.
              Bit 09: WBNOINVD is available if 1.
              Bits 31-10: Reserved = 0.
          ECX Reserved = 0.
          EDX Reserved = 0.

ECX/EDX in CPUID 0x80000008 leaf are reserved.

Currently, in QEMU, only ECX bits[0:7] and ECX bits[12:15] are encoded,
and both are emulated in QEMU.

Considering that Intel and Zhaoxin are already using the 0x1f leaf to
describe CPU topology, which includes similar information, Intel and
Zhaoxin will not implement ECX bits[0:7] and bits[12:15] of 0x80000008.

Therefore, mark these two fields as reserved and clear them for Intel
and Zhaoxin guests.

Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v1:
 * Consider Zhaoxin (Ewan).
 * Only clear ECX bits[0:7] and bits[12:15] for Intel/Zhaoxin, and do
   not cover other bits.
---
 target/i386/cpu.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 37e4bf51d890..abd529d587ba 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8387,15 +8387,25 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              *eax |= (cpu->guest_phys_bits << 16);
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
+
         if (threads_per_pkg > 1) {
             /*
-             * Bits 15:12 is "The number of bits in the initial
-             * Core::X86::Apic::ApicId[ApicId] value that indicate
-             * thread ID within a package".
-             * Bits 7:0 is "The number of threads in the package is NC+1"
+             * Don't emulate Bits [7:0] & Bits [15:12] for Intel/Zhaoxin, since
+             * they're using 0x1f leaf.
              */
-            *ecx = (apicid_pkg_offset(topo_info) << 12) |
-                   (threads_per_pkg - 1);
+            if (cpu->vendor_cpuid_only_v2 &&
+                (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+                    *ecx = 0;
+            } else {
+                /*
+                 * Bits 15:12 is "The number of bits in the initial
+                 * Core::X86::Apic::ApicId[ApicId] value that indicate
+                 * thread ID within a package".
+                 * Bits 7:0 is "The number of threads in the package is NC+1"
+                 */
+                *ecx = (apicid_pkg_offset(topo_info) << 12) |
+                       (threads_per_pkg - 1);
+            }
         } else {
             *ecx = 0;
         }
-- 
2.34.1


