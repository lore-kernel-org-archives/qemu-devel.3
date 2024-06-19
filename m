Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574B9C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 14:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJwHK-0004gM-69; Wed, 19 Jun 2024 10:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sJwHD-0004eZ-MT
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:27:08 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sJwHB-00021I-E8
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718807225; x=1750343225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dW4JZqyv2HQnY1oRhM4turAV/HChrJd/xE6wbSSCvpA=;
 b=erNcAOUWXOKfhfWT/XuIunwPDT/1ramGlw52f9bv8bBWeWTxERzPaEfS
 CZ/vj9h+3tgF6CwUZ821NHoCmRzA8x8tEphX2eEUp8gc/42+wvy+xia1q
 L0IBr2OilpCO5SPXak9Dc3wfw8GL6xLxxL0GrUSRFsG2Eogd06OXL7pJo
 QEDRW8fjEGYQvQWYPwdz79QXcYVUNoUhKGbXryWh9kTt6dmnVCDMJ2eV/
 zV+5eT92S+X58/mrJe8lmFIkizTLgW8A+nXErhr8p5xVqft22atTFP15b
 dilfEnGXk1dJJuZ+656jSNaPZklVEADqBnHSUFOHtUiDM32/LnEoEaIT/ g==;
X-CSE-ConnectionGUID: Dc88kBqURQaecDq2ZscSnQ==
X-CSE-MsgGUID: BMmn2lEmTmOInZKgvaZIbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15462618"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; d="scan'208";a="15462618"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2024 07:27:02 -0700
X-CSE-ConnectionGUID: wZbUsAKbT5eNfILqs6JKuw==
X-CSE-MsgGUID: lKzIdo7DQSCfFYAMvFcXxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; d="scan'208";a="41788945"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2024 07:27:01 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/3] target/i386/cpu: Check guest_thread_ids_per_pkg for
 host-cache-info case
Date: Wed, 19 Jun 2024 22:42:14 +0800
Message-Id: <20240619144215.3273989-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619144215.3273989-1-zhao1.liu@intel.com>
References: <20240619144215.3273989-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The CPUID[4].EAX[bits 25:14] encodes the "maximum number of addressable
IDs for logical processors", which value may be different with the
actual number of threads.

For example, there's a Guest with the topology like: 3 threads per core
and 3 cores per package. Its maximum ids for package level is 15 (0xf),
but it has 9 threads per package.

Therefore, using "threads_per_pkg" to check sharing threads overflow (out
of package scope) is not sufficient.

Use Guest's maximum ids for package level information to compare with
Host's.

Note the original check is stricter, but it can be mathematically proven
that the original check does not contain redundant case (e.g.
guest_thread_ids_per_pkg >= host_thread_ids_per_cache > threads_per_pkg,
which is impossible for the current QEMU APIC ID encoding rule).

Therefore, the behavior of this feature is consistent before and after
the change.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c4d4048ec32a..c20ff69b7b65 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6453,16 +6453,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * set 24..14, 31..26 bit to configured values
              */
             if (*eax & 0x1f) {
-                int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
+                int host_thread_ids_per_cache;
+                int guest_thread_ids_per_pkg;
 
                 *eax &= ~0xFC000000;
                 *eax |= max_core_ids_in_package(&topo_info) << 26;
-                if (host_vcpus_per_cache > threads_per_pkg) {
+
+                host_thread_ids_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
+                guest_thread_ids_per_pkg =
+                    max_thread_ids_for_cache(&topo_info,
+                                             CPU_TOPO_LEVEL_PACKAGE);
+
+                if (host_thread_ids_per_cache > guest_thread_ids_per_pkg) {
                     *eax &= ~0x3FFC000;
 
                     /* Share the cache at package level. */
-                    *eax |= max_thread_ids_for_cache(&topo_info,
-                                CPU_TOPO_LEVEL_PACKAGE) << 14;
+                    *eax |= guest_thread_ids_per_pkg << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
-- 
2.34.1


