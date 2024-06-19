Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7CDC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 14:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJwHJ-0004fc-6N; Wed, 19 Jun 2024 10:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sJwHD-0004eV-BP
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:27:08 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sJwH9-0001zY-Gs
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718807223; x=1750343223;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=elKJG0XjV2yjbEMTXMJHgHHF+Tv8ht7AwVlPwyJqLpc=;
 b=luGCs+HvS0xiqvaYbbE4Sd2Ifcd4x68Q6/xbE2Njfd4ZRKuKZdpuR1IV
 Wgn575rWTSiyGSYX3kz6tYGopE4TFLKkxWTWiOpHIyd8cSfaktbC7Pkjb
 AKS8brotPTAbeQoz5wdcyFISDCc2pWqcIszc+ocq38Ae0F3Wwnk+uJ3/P
 0yrhJnQeCQ2b6eYxhpr5tFZiltgasua6UjPicJryI7fORpMj/fm1SoPM9
 l11iwPfznNmJDRLftHKqea5Oh/npb/YLWPYKsALmhdIxpLseouP2wg0RZ
 f9MLI4Hxqs0qcaQ7garw6kK2iIybrwuYe2mPz6LHxpjXxIDH7l/5pshFD A==;
X-CSE-ConnectionGUID: hJuJkdGFT+igOLAK4Mi6rw==
X-CSE-MsgGUID: ZenX6BEVSXGakP2nmYF2XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15462614"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; d="scan'208";a="15462614"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2024 07:26:59 -0700
X-CSE-ConnectionGUID: kZX/MSc1S7ieZh8N0ySy4w==
X-CSE-MsgGUID: lp0wNIZjRzO2aTZcMQgBMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; d="scan'208";a="41788914"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2024 07:26:58 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/3] target/i386/cpu: Misc Cleanup on host-cache-info
Date: Wed, 19 Jun 2024 22:42:12 +0800
Message-Id: <20240619144215.3273989-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

This series is mainly to addresss Igor's comment about if one check in
host-cache-info could be removed [1], i.e., whether Guest's cache
topology should be self-consistent (able to correspond to Guest's CPU
topology level, as we currently do with the Guest cache topo).

I originally thought (in the mail thread with Igor) that host-cache-info
should allow Guest and Host to have the same topology level information,
e.g. if Host shares cache on core level, then via host-cache-info, Guest
should also share on core level.

But in practice, I gave up on this idea, because in the cache info
passthrough case, it should be possible for Guest to get the original
Host cache info (including the original threads sharing cache) without
further modifying the info to Guest.

Therefore, I simply added the comment in PATCH 3 to hopefully illustrate
the need for such a check.

Hope my explanation is clear enough so that my poor English doesn't
bother you!

[1]: https://lore.kernel.org/qemu-devel/20240527170317.14520a2f@imammedo.users.ipa.redhat.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (3):
  target/i386/cpu: Use hex mask to check for valid cache CPUID leaf
  target/i386/cpu: Check guest_thread_ids_per_pkg for host-cache-info
    case
  target/i386/cpu: Add comment about adjusting the Guest cache topo for
    host-cache-info

 target/i386/cpu.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

-- 
2.34.1


