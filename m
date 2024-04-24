Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF7FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 15:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzegS-0005Q5-Ec; Wed, 24 Apr 2024 11:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzegO-0005D4-JU
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:37:18 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzegL-0005hL-RL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713973034; x=1745509034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lS2Q3aIy/l8MzrROqyj1dCcQs09BZjEA1LjJ1XbG+sY=;
 b=agUvlFN0AyenbpJfrMoS+Onidd3BE2L7cei+8vOmGAbTR/fDw/Icb5T8
 LzRCaQMjpetqOePHGc89PZcYXK9RBFWHLGoSueqm3dL9ZFZHgonDGfdoi
 puQOOvBbNc6sOKHDn4Ccp9MMTQkNNp8n5+5Ur1yEn3wfcXDDeV1baXfgZ
 Aj3mTlicS2GgFCPBR/AxyG3JH3smJyWB7aPV1m7caoVDd03xdIz/ODyY1
 zActGeqdjWX+UnFUNwckOjD2X8xY/UWEWaqGTLVkDt1lNLWwgSR8NJHmM
 D8rpbS+nv5a/Kw7sPhyz5LDzk7WgRi69KDqXrQEK1mz7GPcHa5iY5YGcp Q==;
X-CSE-ConnectionGUID: ZyUrXzo6SNiJcSAYGlxeWw==
X-CSE-MsgGUID: Wl2m4r7WRfKMuIhI3kueYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="12545764"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="12545764"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 08:36:57 -0700
X-CSE-ConnectionGUID: KnWFnh9CSnWa6F3Zp6NdOQ==
X-CSE-MsgGUID: z78Fm+TdTOKRxdJ4ynTXAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="25363287"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 24 Apr 2024 08:36:52 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v11 12/21] i386: Introduce module level cpu topology to
 CPUX86State
Date: Wed, 24 Apr 2024 23:49:20 +0800
Message-Id: <20240424154929.1487382-13-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424154929.1487382-1-zhao1.liu@intel.com>
References: <20240424154929.1487382-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Intel CPUs implement module level on hybrid client products (e.g.,
ADL-N, MTL, etc) and E-core server products.

A module contains a set of cores that share certain resources (in
current products, the resource usually includes L2 cache, as well as
module scoped features and MSRs).

Module level support is the prerequisite for L2 cache topology on
module level. With module level, we can implement the Guest's CPU
topology and future cache topology to be consistent with the Host's on
Intel hybrid client/E-core server platforms.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
---
Changes since v7:
 * Mapped x86 module to smp module instead of cluster.
 * Re-wrote the commit message to explain the reason why we needs module
   level.
 * Dropped Michael/Babu's ACKed/Tested tags since the code change.
 * Re-added Yongwei's Tested tag For his re-testing.

Changes since v1:
 * The background of the introduction of the "cluster" parameter and its
   exact meaning were revised according to Yanan's explanation. (Yanan)
---
 hw/i386/x86.c     | 5 +++++
 target/i386/cpu.c | 1 +
 target/i386/cpu.h | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 004627fa8985..3b5cf75d5bf3 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -313,6 +313,11 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     init_topo_info(&topo_info, x86ms);
 
+    if (ms->smp.modules > 1) {
+        env->nr_modules = ms->smp.modules;
+        /* TODO: Expose module level in CPUID[0x1F]. */
+    }
+
     if (ms->smp.dies > 1) {
         env->nr_dies = ms->smp.dies;
         set_bit(CPU_TOPO_LEVEL_DIE, env->avail_cpu_topo);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 504ec569e0b2..8f34a5b8d726 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7871,6 +7871,7 @@ static void x86_cpu_init_default_topo(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
 
+    env->nr_modules = 1;
     env->nr_dies = 1;
 
     /* SMT, core and package levels are set by default. */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fa9b6679387e..630129838c08 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1899,6 +1899,9 @@ typedef struct CPUArchState {
     /* Number of dies within this CPU package. */
     unsigned nr_dies;
 
+    /* Number of modules within one die. */
+    unsigned nr_modules;
+
     /* Bitmap of available CPU topology levels for this CPU. */
     DECLARE_BITMAP(avail_cpu_topo, CPU_TOPO_LEVEL_MAX);
 } CPUX86State;
-- 
2.34.1


