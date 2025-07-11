Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AB8C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAvv-0007gj-US; Fri, 11 Jul 2025 06:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAvt-0007bJ-Pa
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:24:46 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAvq-0003Bv-3i
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752229482; x=1783765482;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zl43e+CyaFSKAJntbnBbjx0GgHa30iQdOvMsXVgK9W4=;
 b=J1P5dRVzJzhRyPKpgYDUxftkxBZZ0JWn7ST4Cayc6slEd9JvuFBbfF8h
 Q+27NTRBisrZtkIzYvXaLZhw7+8f/2JxB/zCky4FGvWUbUVxjIEoOs8AS
 C91uKqrdzR6/43mvafogncGt0rnuBQqvK1BddJsRcIhSmh7ZAtolJHxPR
 Kh1/8r+BKJqBBrADdlIK0CWli45XQ2XL+mIQuxxzUaZfVXf0oVIvCZygd
 Jl/Xbglw0EJ1iOiywpbkOsNXT0IqIVhXb4LNU9t/HLjyKtAp7CDbMsbJz
 sSzJeaQQIsZ3wDKsIcAbWXEJtfvTGNBWuAxRxIibuaKCh+Yrbag304UvG g==;
X-CSE-ConnectionGUID: S55TRlAoSYqFYvQs2qGN1Q==
X-CSE-MsgGUID: yukygoULSNKOE6tZZ7TEvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65875691"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="65875691"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:24:39 -0700
X-CSE-ConnectionGUID: Y5e4Fe+HTLqBaMgt9NDwbQ==
X-CSE-MsgGUID: h6KCOQvNRvy0aa40FqoxyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="156894318"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 11 Jul 2025 03:24:36 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 0/9] i386/cpu: Intel cache model & topo CPUID enhencement
Date: Fri, 11 Jul 2025 18:45:54 +0800
Message-Id: <20250711104603.1634832-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

This series is based on another series dedicated to cleaning up the
legacy cache models:

https://lore.kernel.org/qemu-devel/20250711102143.1622339-1-zhao1.liu@intel.com/

And this series focuses only on improvements to the named CPU models:
 * Add cache model for Intel CPUs (and YongFeng).
 * Enable 0x1f CPUID leaf for specific Intel CPUs, which already have
   this leaf on host by default.

You can also find the patches at here (branch: cache-model-v3.0-rebase-
07-10-2025):

https://gitlab.com/zhao.liu/qemu/-/tree/cache-model-v3.0-rebase-07-10-2025?ref_type=heads


Change Log
==========

Changes since RFC (20250423114702.1529340-1-zhao1.liu@intel.com):
 * Split CPUID fixes into another series.
 * Since TDX was merged, rebase and rename 0x1f property to
   "x-force-cpuid-0x1f". (Igor)
 * Include cache model for YongFeng from Ewai.


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
the community's idea.

I enable the 0x1f leaf for SRF, GNR and SPR by default for better
emulation of real silicons.

Change Log
==========

Changes Since v1:
 * Polish the note and enable 0x1f leaf for YongFeng.
 * Add R-b/T-b tags.


Reference
=========

[4]: https://lore.kernel.org/qemu-devel/ZpoWskY4XE%2F98jss@intel.com/
[5]: https://lore.kernel.org/qemu-devel/PH0PR02MB738410511BF51B12DB09BE6CF6AC2@PH0PR02MB7384.namprd02.prod.outlook.com/
[6]: https://lore.kernel.org/qemu-devel/20240722101859.47408-1-manish.mishra@nutanix.com/
[7]: https://lore.kernel.org/qemu-devel/20240813033145.279307-1-xiaoyao.li@intel.com/
[8]: https://lore.kernel.org/qemu-devel/20240723170321.0ef780c5@imammedo.users.ipa.redhat.com/
[9]: https://lore.kernel.org/qemu-devel/20250401130205.2198253-34-xiaoyao.li@intel.com/

Thanks and Best Regards,
Zhao

---
Ewan Hai (1):
  i386/cpu: Introduce cache model for YongFeng

Manish Mishra (1):
  i386/cpu: Add a "x-force-cpuid-0x1f" property

Zhao Liu (7):
  i386/cpu: Introduce cache model for SierraForest
  i386/cpu: Introduce cache model for GraniteRapids
  i386/cpu: Introduce cache model for SapphireRapids
  i386/cpu: Enable 0x1f leaf for SierraForest by default
  i386/cpu: Enable 0x1f leaf for GraniteRapids by default
  i386/cpu: Enable 0x1f leaf for SapphireRapids by default
  i386/cpu: Enable 0x1f leaf for YongFeng by default

 target/i386/cpu.c | 405 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 405 insertions(+)

-- 
2.34.1


