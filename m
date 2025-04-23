Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB93C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YFn-000456-Uq; Wed, 23 Apr 2025 07:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YF8-0003uX-QW
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:22 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YF4-0002vs-G8
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745407574; x=1776943574;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sWI3DOLRDTWF/zbnA7amIpyitgpG1InAQItEsYRGi6E=;
 b=mrrM/knlm+MZ33jh4w1otR4vOtZsLWVDhhUYSibZLGP71W5W13AYenmS
 Mba4q3tQGtPxg0NzoOjLy/uxmKtpIZby27oDc0+NBfrjuCQEcAwhnhzYF
 ovEBthbmM6MC3Gk/+mhiJSnEvIZ1SUO056ZUaDVkJirivsPf1tjZlDtHh
 bZq1BtIt2BulGfQJT2Qorv4Z1tPlJtfVWWJl3N1KtniNSTYlSbO8SmI5O
 3qvaT4KQNP4J5vF3gMmzfXobbEtebQqy+hFVyIcdS1ilG/HbEFQwUzsCN
 lEMFZsPp2CPJNMnuTqOrtAvSl79MHAKQxxaDu8T5t45A9Dc/wPkAVg/1J A==;
X-CSE-ConnectionGUID: m9aJka83QV2GympMONDTcw==
X-CSE-MsgGUID: lkpI43R6THqMmIJ5/UA/MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50825246"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="50825246"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 04:26:11 -0700
X-CSE-ConnectionGUID: 7kic6yL5Ry26K8wLOk1jIg==
X-CSE-MsgGUID: FK6712zITSS+5mtmot+13g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137150718"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 23 Apr 2025 04:26:07 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 00/10] i386/cpu: Cache CPUID fixup,
 Intel cache model & topo CPUID enhencement
Date: Wed, 23 Apr 2025 19:46:52 +0800
Message-Id: <20250423114702.1529340-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

Hi all,

(Since patches 1 and 2 involve changes to x86 vendors other than Intel,
I have also cc'd friends from AMD and Zhaoxin.)

These are the ones I was going to clean up a long time ago:
 * Fixup CPUID 0x80000005 & 0x80000006 for Intel (and Zhaoxin now).
 * Add cache model for Intel CPUs.
 * Enable 0x1f CPUID leaf for specific Intel CPUs, which already have
   this leaf on host by default.

Overall, the enhancements to the Intel CPU models are still based on
feedback received over time, for a long time...

I'll introduce my changes one by one in the order of importance as I
see it. (The doc update is missing in this version.)


Intel Cache Model
=================

AMD has supports cache model for a long time. And this feature strats
from the Eduardo's idea [1].

Unfortunately, Intel does not support this, and I have received some
feedback (from Tejus on mail list [2] and kvm forum, and from Jason).

Additionally, after clearly defining the cache topology for QEMU's
cache model, outdated cache models can easily raise more questions. For
example, the default legacy cache model's L3 is per die, but SPR's
real L3 is per socket. Users may question how the L3 topology changes
when multiple dies are created (discussed with Daniel on [3]).

So, in this series, I have added cache models for SRF, GNR, and SPR
(because these are the only machines I can find at the moment :-) ).

Note that the cache models are based on the Scalable Performance (SP)
version, and the Xeon Advanced Performance (AP) version may have
different cache sizes. However, SP is sufficient as the default cache
model baseline. In the future, I will consider adding additional
parameters in "smp-cache" to adjust cache sizes to meet different needs.

[1]: https://lore.kernel.org/qemu-devel/20180320175427.GU3417@localhost.localdomain/
[2]: https://lore.kernel.org/qemu-devel/6766AC1F-96D1-41F0-AAEB-CE4158662A51@nutanix.com/
[3]: https://lore.kernel.org/qemu-devel/ZkTrsDdyGRFzVULG@redhat.com/

0x1f CPUID by default (for some CPUs)
=====================================

Once the cache model can be clearly defined, another issue is the
topology.

Currently, the cache topology is actually tied to the CPU topology.
However, in recent Intel CPUs (from cascadelake-AP - 2nd xeon [4]),
CPU topology information is primarily expressed using the 0x1f leaf.

Due to compatibility issues and historical reasons, the Guest's 0x1f
is not unconditionally exposed.

The discrepancy between having 0x1f on the Host but not on the Guest
does indeed cause problems (Manish mentioned in [5]).

Manish and Xiaoyao (for TDX) both attempted to enable 0x1f by default
for Intel CPUs [6] [7], but following Igor's suggestion, it is more
appropriate to enable it by default only for certain CPU models [8]. 

So, as I update the CPU model at this time, I think it's time to revisit
the community's idea (referencing patch 7, where I "took the liberty" to
merge the property-related work pieces from Manish and Xiaoyao, based on
a TDX patch from Xiaoyao [9]).

I enable the 0x1f leaf for SRF, GNR and SPR by default for better
emulation of real silicons.

[4]: https://lore.kernel.org/qemu-devel/ZpoWskY4XE%2F98jss@intel.com/
[5]: https://lore.kernel.org/qemu-devel/PH0PR02MB738410511BF51B12DB09BE6CF6AC2@PH0PR02MB7384.namprd02.prod.outlook.com/
[6]: https://lore.kernel.org/qemu-devel/20240722101859.47408-1-manish.mishra@nutanix.com/
[7]: https://lore.kernel.org/qemu-devel/20240813033145.279307-1-xiaoyao.li@intel.com/
[8]: https://lore.kernel.org/qemu-devel/20240723170321.0ef780c5@imammedo.users.ipa.redhat.com/
[9]: https://lore.kernel.org/qemu-devel/20250401130205.2198253-34-xiaoyao.li@intel.com/


CPUID 0x80000005 & 0x80000006 Fix
=================================

CPUID[0x80000005] is reserved for Intel, and Intel only supports
CPUID[0x80000006].ECX. And becuase AMD requires lines_per_tag to be not
0, which blocks Intel's new cache model.

Therefore, fix these 2 leaves for Intel (and Zhaoxin - which follows
Intel's SDM).

Thanks and Best Regards,
Zhao
---
Manish Mishra (1):
  i386/cpu: Add a "cpuid-0x1f" property

Xiaoyao Li (1):
  i386/cpu: Introduce enable_cpuid_0x1f to force exposing CPUID 0x1f

Zhao Liu (8):
  i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
  i386/cpu: Fix CPUID[0x80000006] for Intel CPU
  i386/cpu: Introduce cache model for SierraForest
  i386/cpu: Introduce cache model for GraniteRapids
  i386/cpu: Introduce cache model for SapphireRapids
  i386/cpu: Enable 0x1f leaf for SierraForest by default
  i386/cpu: Enable 0x1f leaf for GraniteRapids by default
  i386/cpu: Enable 0x1f leaf for SapphireRapids by default

 target/i386/cpu.c     | 346 ++++++++++++++++++++++++++++++++++++++++--
 target/i386/cpu.h     |   9 ++
 target/i386/kvm/kvm.c |   2 +-
 3 files changed, 343 insertions(+), 14 deletions(-)

-- 
2.34.1


