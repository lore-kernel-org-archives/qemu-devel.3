Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A55E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEVt-0004cA-Pr; Thu, 19 Dec 2024 06:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVs-0004bt-3I
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:16 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVq-0005Kx-G0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606975; x=1766142975;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bkOTh7sm1DEDqwgD7+5B/BRslnhPu8TCuJZZUpkjQy8=;
 b=lXQ+dP6NZrx1pYg6b138glPblELdwwChd1V1mJkLGMaFMdHkE2Fk4LLg
 C4wBKdMIuo8gse3tOYJd8kB0kz6fPETk1cCx0RBlzvp6RPOTeR7Y5tV6f
 NoFb1uCUXFqXwK1wGhvBoakmJv/js2LrxuMlWaaLcpbD5G5+uPrMDWmD2
 gMIp8zbCdE6spEfs8vB3xTu68fGZ8We/TDery4Y4Nvp/UL1Nj9a6xFqW/
 RMOkGJlaHIG/oQCkXAK1FzEMweZHA2Gsv0mdGIGhPhcLU46eSEdfANnbq
 GbOLmE6kIo3uHkE89SCE+piBVLT7InhJZbBycteS1n/DVOwcxWHlIn6hG w==;
X-CSE-ConnectionGUID: qw0ivHvpRg6SjUSSSKhG8Q==
X-CSE-MsgGUID: gdsjSQgSRumsz293etq9hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34994976"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34994976"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:16:14 -0800
X-CSE-ConnectionGUID: mb9ALuozQ8eJr43EZAH5Jw==
X-CSE-MsgGUID: 4o1dBuVZSgKccpVCfL7pDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956179"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:16:10 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 08/10] cpu: Remove nr_cores from struct CPUState
Date: Thu, 19 Dec 2024 06:01:23 -0500
Message-Id: <20241219110125.1266461-9-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219110125.1266461-1-xiaoyao.li@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There is no user of it now, remove it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/cpu-common.c  | 1 -
 include/hw/core/cpu.h | 2 --
 system/cpus.c         | 1 -
 3 files changed, 4 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 09c79035949b..77089d4ed304 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -243,7 +243,6 @@ static void cpu_common_initfn(Object *obj)
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     /* user-mode doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for system-mode */
-    cpu->nr_cores = 1;
     cpu->nr_threads = 1;
     cpu->cflags_next_tb = -1;
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3ca0babcb3f..fb397cdfc53d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -407,7 +407,6 @@ struct qemu_work_item;
  *   Under TCG this value is propagated to @tcg_cflags.
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
  * @tcg_cflags: Pre-computed cflags for this cpu.
- * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU core.
  * @thread: Host thread details, only live once @created is #true
  * @sem: WIN32 only semaphore used only for qtest
@@ -466,7 +465,6 @@ struct CPUState {
     CPUClass *cc;
     /*< public >*/
 
-    int nr_cores;
     int nr_threads;
 
     struct QemuThread *thread;
diff --git a/system/cpus.c b/system/cpus.c
index ba633c7688b2..3db4a7d0ab4a 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -681,7 +681,6 @@ void qemu_init_vcpu(CPUState *cpu)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
 
-    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
     cpu->nr_threads =  ms->smp.threads;
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
-- 
2.34.1


