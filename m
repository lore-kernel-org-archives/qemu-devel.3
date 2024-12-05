Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D086FE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDVf-0005hQ-J3; Thu, 05 Dec 2024 10:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJDVd-0005ge-T7
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:11:17 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJDVc-0005Nt-65
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733411476; x=1764947476;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5yVOz/EdTEquJQjewhLrTNSpZfPzXEvXdfHrpNFHV4k=;
 b=POZt0w5VMUE2QBFhQXriWv6pkcDWE7GZPSP1+p7iFQcHjHgjIRsKfihA
 zvfIoGe2vqKxs4jZdSsZLNub1M2Z3QFk/inphnlG/TXSoAIY+T4pi8u9p
 yjOnHy9L3s+Bj5WjExPcuMYlGaBgtdFW2fuumABDkUh4QuG6aCif1Qcj4
 hHN4ajwoRvNIe2LjNcTG6Uuin8U8AxbZ4YG4AKatIOTn5SRYFXPLfgNPR
 uFZimSmazmDmnjKoV7wSR/ppT6d/oOqjtXM1+hdcaPqAZwPuuelBSQ9yA
 rv9yDU+WWFafA3EpAyhp4OWigy1qGMX4P4AAMnkGP/CiK0E3NfcRrmDqs Q==;
X-CSE-ConnectionGUID: /o/c8ISuR9aGHuWotCn/XA==
X-CSE-MsgGUID: GfallRMqTmuJndHOoLlT1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33786185"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="33786185"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 07:11:14 -0800
X-CSE-ConnectionGUID: M6PpUGHlSvSFoAXumBbZFg==
X-CSE-MsgGUID: xl2h8GJlRpuDZZ5t5zSsXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="93803132"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 05 Dec 2024 07:11:11 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: xiaoyao.li@intel.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 4/4] cpu: Remove nr_cores from struct CPUState
Date: Thu,  5 Dec 2024 09:57:16 -0500
Message-Id: <20241205145716.472456-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205145716.472456-1-xiaoyao.li@intel.com>
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.822, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

There is no user of it now, remove it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/core/cpu-common.c  | 1 -
 hw/i386/x86-common.c  | 2 +-
 include/hw/core/cpu.h | 2 --
 system/cpus.c         | 1 -
 4 files changed, 1 insertion(+), 5 deletions(-)

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
 
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index f7a20c1da30c..2dd7d8e34b76 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -377,7 +377,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
      */
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
-     * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
+     * CPUState::nr_threads fields instead of globals */
     x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
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
index 1c818ff6828c..909d8128e81b 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -666,7 +666,6 @@ void qemu_init_vcpu(CPUState *cpu)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
 
-    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
     cpu->nr_threads =  ms->smp.threads;
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
-- 
2.34.1


