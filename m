Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A43E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEVl-0004YN-QH; Thu, 19 Dec 2024 06:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVd-0004WT-KS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:02 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVb-0005H9-SA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606960; x=1766142960;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6HpxBDbI/9GKhzbGJA3ef0PtUFQ2lSE7HfhNWpqrw2g=;
 b=UrxFuh/CYrEv/i9CZh1r9ygLdZUXnLcJgeL5M4oFhIU7h9X/jy/GEs5t
 l+o+2SbNSpyO2PDViFMMpLggp+4Xgg34eXI4WIIPXO7D65Jq+JncyjibV
 uu/0/Pcf+RbAALGua7pAV8eACkW0F8YaiZBfz1fOFBnu25Y0izmb6ZAU6
 ENa1AVa+vd6uNAR3dOWzTwFWuIAjcR11rV+af+1XELE5/6ns7i/WrmGb7
 1bEFa+/C0qzQq6eHYWomULH7NYESBgUA87eICatW6mAGMs7s5s7K7p9jO
 R94OhLJCKuvMB1Z7UARZp4FOT4a4J+c+9cjCqUA794SCztzrWH+9rAQ2i A==;
X-CSE-ConnectionGUID: W7yG2nrPS6aqpr1QI+xGWw==
X-CSE-MsgGUID: cFUZWSXzQVKPaMO8Y0zghg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34994942"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34994942"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:16:00 -0800
X-CSE-ConnectionGUID: klXGd20tTbe5rItSGbY+Jw==
X-CSE-MsgGUID: limWjYT1SPGUx1IbFuSEQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956148"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:15:56 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 03/10] i386/cpu: Drop cores_per_pkg in cpu_x86_cpuid()
Date: Thu, 19 Dec 2024 06:01:18 -0500
Message-Id: <20241219110125.1266461-4-xiaoyao.li@intel.com>
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

Local variable cores_per_pkg is only used to calculate threads_per_pkg.
No need for it. Drop it and open-code it instead.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 525339945920..ad6889abdf5e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6498,7 +6498,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t limit;
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
-    uint32_t cores_per_pkg;
     uint32_t threads_per_pkg;
 
     topo_info.dies_per_pkg = env->nr_dies;
@@ -6506,9 +6505,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
     topo_info.threads_per_core = cs->nr_threads;
 
-    cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
-                    topo_info.dies_per_pkg;
-    threads_per_pkg = cores_per_pkg * topo_info.threads_per_core;
+    threads_per_pkg = topo_info.threads_per_core * topo_info.cores_per_module *
+                      topo_info.modules_per_die * topo_info.dies_per_pkg;
 
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
-- 
2.34.1


