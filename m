Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F59C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEF2-0007qN-Im; Mon, 14 Jul 2025 04:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDua-0004eO-W7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:50 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDuV-0007Nf-Vn
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752479260; x=1784015260;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=A2xl69pTZ7gXL6pO/Q3cKP2tsM3Uvcc04TeHhF5oK5Q=;
 b=laLGO81J5L9A6eJ28N6CeyD0OFdvbvyfJ1iTTnkYMiIKjlNqWBi1IZkJ
 NKdSaAIFen4V48EpX8IzXupGnA/hI+FYPXbB1xAXtkbYQ3M8MDxLmP4s/
 CerB1bKem9rj+0Tq5ywnreO8IsHn53UuI44hSzFmyPX5Z+GB9rTfQeUiP
 24yj7OaFSmRfD4Kdkfrw/bp51xZQXTXQ+RTvVFMWvsqCKdLQRZOMg79C2
 O7cvrsYT2O96bNhUMMISlkn0OT4B37fq1fPrErE3y660XxOqZp/AfmELf
 B99XR7QqP9RW8empGJdowgrJjs1YU/oDS+8iy0YG6WH+6rJsXY7/DKRQn w==;
X-CSE-ConnectionGUID: DrQHdkMeS9uNDHQPbgPjhA==
X-CSE-MsgGUID: G5IsqVAGQHSEPytxX551bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58324638"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="58324638"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 00:47:33 -0700
X-CSE-ConnectionGUID: Q2zZ8nctTmSgg1axozJ7Cg==
X-CSE-MsgGUID: hgsGgzb+TfuMl03iZQd+zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="156952186"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 14 Jul 2025 00:47:31 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 0/7] i386/cpu: Clean Up Reserved CPUID Leaves & Topology
 Overflow Fix
Date: Mon, 14 Jul 2025 16:08:52 +0800
Message-Id: <20250714080859.1960104-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

To avoid the series being too trivial, I've merged the two previous
series together again.

This series is based on:

https://lore.kernel.org/qemu-devel/20250711102143.1622339-1-zhao1.liu@intel.com/

And you can find the codes at:

https://gitlab.com/zhao.liu/qemu/-/tree/cache-model-v3.0-rebase-07-10-2025?ref_type=heads


Part 1 (Patch 1-3)
==================

Since the previsor unified cache model series has already introduced a
new compat property "x-vendor-cpuid-only-v2", it's a chance to once
again consolidate more vendor-specific CPUIDs.

I also checked the CPUID leaves currently supported by Intel & AMD and
found that since the previous "x-vendor-cpuid-only," AMD has already
cleaned up the Intel-specific CPUIDs quite well.

As for Intel, the only cleanup needed is for the "extended function
CPUID" leaves (0x80000000~0x80000008). That's what these patches does.

Considerring the disscussion around AMD's arch capabilities MSR,
explicitly changing feature bits in QEMU that require host support is
inappropriate. CPUID adjustments based on the vendor should be limited
to parts that are fully emulated within QEMU (such as topology, vendor,
etc.).

Therefore, in v2, I dropped the modifications to 0x80000007 and narrowed
the changes to 0x80000008 to only the fields related to CPU topology.

Previous v1:

https://lore.kernel.org/qemu-devel/20250627035129.2755537-1-zhao1.liu@intel.com/


Part 2 (Patch 4-7)
==================

These patches collect and organize several topology-related cleanups and
fixes.

Comparing with v1, I provides the oveflow example for patch 6 & 7.

Note, In addition to the 0x1, 0x4, and 0x8000001d leaves involved in the
patch series, there is also the 0x1f leaf related to topology. However,
the upper limit for CPUID.1FH.EBX[bits 15:0] is 65,535 threads, which
provides enough room. Therefore, this field does not currently require
overflow checks.

PS: The previous patch 4 tried to fix overflow directly. But now we have
the "x-vendor-cpuid-only-v2", it's a chance to fix addressable ID for
new machines.

Previous v1:

https://lore.kernel.org/qemu-devel/20250227062523.124601-1-zhao1.liu@intel.com/

Thanks and Best Regards,
Zhao

---
Chuang Xu (1):
  i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]

Qian Wen (2):
  i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]
  i386/cpu: Fix overflow of cache topology fields in CPUID.04H

Zhao Liu (4):
  i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf as reserved for
    Intel
  i386/cpu: Mark CPUID 0x80000008 ECX bits[0:7] & [12:15] as reserved
    for Intel/Zhaoxin
  i386/cpu: Reorder CPUID leaves in cpu_x86_cpuid()
  i386/cpu: Honor maximum value for CPUID.8000001DH.EAX[25:14]

 target/i386/cpu.c | 130 ++++++++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 46 deletions(-)

-- 
2.34.1


