Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54933C27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 14:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJwHM-0004gp-Qq; Wed, 19 Jun 2024 10:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sJwHF-0004f0-CK
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:27:10 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sJwHD-0001zY-LQ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718807227; x=1750343227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jauyaYw1jnW78rNrSjJFkZYuoVLlFWiJ834BoOczctA=;
 b=mmEAmnPrhWR3VNUXDJ8qk2rAtwnDwTAbh06KPnnQbNseCI2y79hcuknH
 7mhv7j9VIgVOrE4H5kmTAAgGrHE1F5ry8jWyW7Zi9kki4+HZuu/ATf0/V
 wM5VWTFgYJJdGhzEXpbQWj/oCCS141Kwk7atzZ1uWfu0hFZiVFV+IZfCO
 0CjLTWBtMhn9XucLe9a7tgg9xAALfvT0JEOAVbuhs4NQXfQeWMSkg8rX7
 xErVHsbU24rL56FGP/KkPwBS72MAo/LL2C1GYMVwjE34+YldhckgwQV7b
 L6CQBYW36bARpa178VbKmnxoJuBdNPQaLffF9KgxkDfzjJCiw5UaLNggQ Q==;
X-CSE-ConnectionGUID: GNfd0UxKRwGKc1lKVz4iJg==
X-CSE-MsgGUID: 1MP1EhUqT1mwJqMDgpBjOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15462621"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; d="scan'208";a="15462621"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2024 07:27:03 -0700
X-CSE-ConnectionGUID: 9nq9c4cwQqCXBlvrHikAaw==
X-CSE-MsgGUID: zp1aJjmwTK+k5Tt/P4xhJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; d="scan'208";a="41788952"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2024 07:27:02 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/3] target/i386/cpu: Add comment about adjusting the Guest
 cache topo for host-cache-info
Date: Wed, 19 Jun 2024 22:42:15 +0800
Message-Id: <20240619144215.3273989-4-zhao1.liu@intel.com>
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

The host-cache-info needs the check to ensure the valid maximum
addressable thread IDs.

We don't need to adjust the information in this one field for all cache
topology cases by default, even though Host's cache topology may not
correspond to Guest's CPU topology level.

For example, when a Geust (3 threads per core) runs on a Host with 1
threads per core, the L2 cache topo (L2 per core on Host) obtained by
Guest does not correspond to the Guest's core level. So for the case
where the topology of Guest and Host are very inconsistent, it is not
possible to do a perfect job, so we try to let the Guest have similar
cache topo info as Host, at least in the case of an even distribution
of vCPUs, which can benefit the Guest internal scheduling.

To this end, add a comment to explain why we need to care for this check
and why we don't need to adjust the topology for all cache cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c20ff69b7b65..71300ac6d197 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6463,7 +6463,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 guest_thread_ids_per_pkg =
                     max_thread_ids_for_cache(&topo_info,
                                              CPU_TOPO_LEVEL_PACKAGE);
-
+                /*
+                 * We handle this case because it causes sharing threads to
+                 * overflow out of the package scope. In other cases, there
+                 * is no need to adjust the cache topology info for the Guest,
+                 * as the Host's maximum addressable thread IDs are not out of
+                 * bounds in the Guest's APIC ID scope, and are always valid,
+                 * even though Host's cache topology may not correspond to
+                 * Guest's CPU topology level.
+                 */
                 if (host_thread_ids_per_cache > guest_thread_ids_per_pkg) {
                     *eax &= ~0x3FFC000;
 
-- 
2.34.1


