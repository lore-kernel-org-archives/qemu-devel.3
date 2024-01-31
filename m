Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE56C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7Oo-0004J1-CU; Wed, 31 Jan 2024 05:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7Ol-0004IT-TG
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:00:52 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7Oi-0008Ke-S2
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706695248; x=1738231248;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g7kZcy8qMzcnRiMnRXVem45+V8mcU65tYpnu/7h40Zc=;
 b=XwjDGpnyhv88GnJcIk4ZOm/xK/i+nDoQ12RlYYths6QqNp6DJJGHoAbl
 IC9szqBs0oAA7P0prDLOR7uxZ1VXrO1dpWvzhgI7LMEe/UnWybSC7dEFk
 qgP7j6bB0W0ryw59iViIf4S5KOSqLoLltuEde/vIaqcL+Opqw5cu+80zg
 TN0du4AommvJg9ToWJavUYmm7sMgxadQxaXweaZC0hAs7lJO0YLikTadr
 MffQ4/YN6DYsIKprHi8b/KL/pn3keQt81HJJUikgK4h1NKU0DbfFRqZZE
 5NWlsRNmQY/jnsGNoRW7xWtRTz7jSGi7fshefPXN8tSrxW4T5Icfhs4aR Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25032494"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="25032494"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 02:00:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4035929"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 31 Jan 2024 02:00:42 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v8 01/21] hw/core/machine: Introduce the module as a CPU
 topology level
Date: Wed, 31 Jan 2024 18:13:30 +0800
Message-Id: <20240131101350.109512-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
References: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

In x86, module is the topology level above core, which contains a set
of cores that share certain resources (in current products, the resource
usually includes L2 cache, as well as module scoped features and MSRs).

To build the module level topology for x86 CPUs, introduce module level
support in MachineState and MachineClass.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v7:
 * New commit to introduce module level in -smp.
---
 hw/core/machine-smp.c | 2 +-
 hw/core/machine.c     | 1 +
 include/hw/boards.h   | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 25019c91ee36..a0a30da59aa4 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -234,7 +234,7 @@ void machine_parse_smp_config(MachineState *ms,
 
 unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
 {
-    return ms->smp.cores * ms->smp.clusters * ms->smp.dies;
+    return ms->smp.cores * ms->smp.modules * ms->smp.clusters * ms->smp.dies;
 }
 
 unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index fb5afdcae4cc..36fe3a4806f2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1148,6 +1148,7 @@ static void machine_initfn(Object *obj)
     ms->smp.sockets = 1;
     ms->smp.dies = 1;
     ms->smp.clusters = 1;
+    ms->smp.modules = 1;
     ms->smp.cores = 1;
     ms->smp.threads = 1;
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index bcfde8a84d10..78dea50054a1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -143,6 +143,7 @@ typedef struct {
  *                 provided SMP configuration
  * @books_supported - whether books are supported by the machine
  * @drawers_supported - whether drawers are supported by the machine
+ * @modules_supported - whether modules are supported by the machine
  */
 typedef struct {
     bool prefer_sockets;
@@ -151,6 +152,7 @@ typedef struct {
     bool has_clusters;
     bool books_supported;
     bool drawers_supported;
+    bool modules_supported;
 } SMPCompatProps;
 
 /**
@@ -338,6 +340,7 @@ typedef struct DeviceMemoryState {
  * @sockets: the number of sockets in one book
  * @dies: the number of dies in one socket
  * @clusters: the number of clusters in one die
+ * @modules: the number of modules in one cluster
  * @cores: the number of cores in one cluster
  * @threads: the number of threads in one core
  * @max_cpus: the maximum number of logical processors on the machine
@@ -349,6 +352,7 @@ typedef struct CpuTopology {
     unsigned int sockets;
     unsigned int dies;
     unsigned int clusters;
+    unsigned int modules;
     unsigned int cores;
     unsigned int threads;
     unsigned int max_cpus;
-- 
2.34.1


