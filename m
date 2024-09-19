Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67A2CDD56A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr6AU-0003Us-AQ; Wed, 18 Sep 2024 21:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr6AI-0002TG-0a; Wed, 18 Sep 2024 21:41:02 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr6AF-00058t-DT; Wed, 18 Sep 2024 21:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726710059; x=1758246059;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yof4pkElgDw/rHKl12O9snBHTn5fw7x3AIk3IaZiwVQ=;
 b=heY2zlvoe0J+UMULvBIP+iAuaSOmQr50A+nULomSaF2Xb/5UfbD1rmkY
 h88/lUSki2Un2h5KIj+yuSMYrCFBxzxlR62/jw9JWwtj6SxlyDpSxrb4+
 ncZZsS8ec/IlIc4xdIK7W9g+KVYXkcm0WWyXdWmm0psHu25sVfDrBbgZH
 n+r3ncBFoNgN0HNkIAGb/D3Tb92pzfh/rl98cM2N1/0SS1uj2f2XQLgeU
 uK1hH4xzItLVLStxjqgt7ILaSBdh4pNdYvnBhdKaNB1V7Pg97PbzkwKyZ
 sQHrjptxZmymWa1oNIaIKKDa2lseLHl1FGfxLFr8SNzGo5fwbUjXGZEqX Q==;
X-CSE-ConnectionGUID: gS+gDEHsRfGlhX5hhZkfCA==
X-CSE-MsgGUID: 8jD+AB2yQ3iIoi90M9GtVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25798035"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25798035"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:40:58 -0700
X-CSE-ConnectionGUID: nl6/vbvKRUyF+/RLJLKJoA==
X-CSE-MsgGUID: zZt2sOthQ+SFZ3bJiPNv0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058946"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:40:52 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 11/15] hw/core: Support topology tree in none machine for
 compatibility
Date: Thu, 19 Sep 2024 09:55:29 +0800
Message-Id: <20240919015533.766754-12-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919015533.766754-1-zhao1.liu@intel.com>
References: <20240919015533.766754-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

None machine accepts any CPU types, even some CPUs may have the
bus_type.

To address this, set topo_tree_supported as true for none machine, then
none machine will have a CPU slot with CPU bus to collect any topology
device with bus_type specified.

And since arch_id_topo_level is not set, the topology devices will be
directly inserted under the CPU slot without being organized into a tree
structure.

For the CPUs without bus_type, topo_tree_supported will not affect them.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/null-machine.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index f586a4bef543..101649f3e8c1 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -54,6 +54,11 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_sdcard = 1;
+    /*
+     * For compatibility with arches and CPUs that already
+     * support topology tree.
+     */
+    mc->smp_props.topo_tree_supported = true;
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
-- 
2.34.1


