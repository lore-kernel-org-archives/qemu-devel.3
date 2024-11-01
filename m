Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A311BE674B6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 08:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6mpe-0004w4-He; Fri, 01 Nov 2024 04:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6mpa-0004uw-Dv; Fri, 01 Nov 2024 04:16:32 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6mpY-0001QQ-NJ; Fri, 01 Nov 2024 04:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730448989; x=1761984989;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hWW510RNnBQVWsS5NN5EuNjpKq2iNzrMpdnodY3x60Y=;
 b=QNtwQWUvMTYlSKrkiEK0KsNl6EWM5MWRY35DGIpnIDYNdwlO+qCv4mc9
 mEbZpnORHuhnD0XYU9Q559bDGFqlhNS9qMMrW4MP8ieS8mbxHZQVAlKuQ
 KRWVPkYj5ZXWfS69EmvHgtVYffeQSU1k3gakOKWyolMN5nG0kG2DKuKCM
 MZUoGCU8cUMJCW0c8053dK1OET5KlxyxJCi+0n+Hwl5BFNNMOuTm6xuVe
 HURXM8oWBC7dOBSWtGZ7CvrBgTcgXn610zrDuW5yvgeX+wB/0P3jxbtlk
 5IMmaKok31kdqXOBh55LxrsaIFbAtrORUaFgFxbka6mFA4xqeP9RkDMMV w==;
X-CSE-ConnectionGUID: vcpWeIVSQ2yttjGhsuPkSA==
X-CSE-MsgGUID: WNwBiaFyTFmVRSmcCH+/Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="17846059"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; d="scan'208";a="17846059"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2024 01:16:27 -0700
X-CSE-ConnectionGUID: p/96yex/QsCHlmwk96VuAQ==
X-CSE-MsgGUID: bNhx6skIRDeQj4RNqMaPAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; d="scan'208";a="86834620"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 01 Nov 2024 01:16:22 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 5/9] hw/core: Add a helper to check the cache topology level
Date: Fri,  1 Nov 2024 16:33:27 +0800
Message-Id: <20241101083331.340178-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101083331.340178-1-zhao1.liu@intel.com>
References: <20241101083331.340178-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

Currently, we have no way to expose the arch-specific default cache
model because the cache model is sometimes related to the CPU model
(e.g., i386).

Since the user might configure "default" level, any comparison with
"default" is meaningless before the machine knows the specific level
that "default" refers to.

We can only check the correctness of the cache topology after the arch
loads the user-configured cache model from MachineState.smp_cache and
consumes the special "default" level by replacing it with the specific
level.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes since Patch v3:
 * New commit to make cache topology check as a separate helper, so that
   arch-specific code could use this helper to check cache topology.
---
 hw/core/machine-smp.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h   |  1 +
 2 files changed, 49 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index ebb7a134a7be..640b2114b429 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -348,3 +348,51 @@ void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
 {
     ms->smp_cache.props[cache].topology = level;
 }
+
+/*
+ * When both cache1 and cache2 are configured with specific topology levels
+ * (not default level), is cache1's topology level higher than cache2?
+ */
+static bool smp_cache_topo_cmp(const SmpCache *smp_cache,
+                               CacheLevelAndType cache1,
+                               CacheLevelAndType cache2)
+{
+    /*
+     * Before comparing, the "default" topology level should be replaced
+     * with the specific level.
+     */
+    assert(smp_cache->props[cache1].topology != CPU_TOPOLOGY_LEVEL_DEFAULT);
+
+    return smp_cache->props[cache1].topology > smp_cache->props[cache2].topology;
+}
+
+/*
+ * Currently, we have no way to expose the arch-specific default cache model
+ * because the cache model is sometimes related to the CPU model (e.g., i386).
+ *
+ * We can only check the correctness of the cache topology after the arch loads
+ * the user-configured cache model from MachineState and consumes the special
+ * "default" level by replacing it with the specific level.
+ */
+bool machine_check_smp_cache(const MachineState *ms, Error **errp)
+{
+    if (smp_cache_topo_cmp(&ms->smp_cache, CACHE_LEVEL_AND_TYPE_L1D,
+                           CACHE_LEVEL_AND_TYPE_L2) ||
+        smp_cache_topo_cmp(&ms->smp_cache, CACHE_LEVEL_AND_TYPE_L1I,
+                           CACHE_LEVEL_AND_TYPE_L2)) {
+        error_setg(errp,
+                   "Invalid smp cache topology. "
+                   "L2 cache topology level shouldn't be lower than L1 cache");
+        return false;
+    }
+
+    if (smp_cache_topo_cmp(&ms->smp_cache, CACHE_LEVEL_AND_TYPE_L2,
+                           CACHE_LEVEL_AND_TYPE_L3)) {
+        error_setg(errp,
+                   "Invalid smp cache topology. "
+                   "L3 cache topology level shouldn't be lower than L2 cache");
+        return false;
+    }
+
+    return true;
+}
diff --git a/include/hw/boards.h b/include/hw/boards.h
index cda12070fc52..e07fcf0983e1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -53,6 +53,7 @@ CpuTopologyLevel machine_get_cache_topo_level(const MachineState *ms,
                                               CacheLevelAndType cache);
 void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
                                   CpuTopologyLevel level);
+bool machine_check_smp_cache(const MachineState *ms, Error **errp);
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
 
 /**
-- 
2.34.1


