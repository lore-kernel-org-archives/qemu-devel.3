Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1F8D2C552
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3F4Q-0006RZ-CB; Tue, 22 Oct 2024 09:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3F4I-0006CC-71; Tue, 22 Oct 2024 09:37:04 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3F4G-0000FX-G7; Tue, 22 Oct 2024 09:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729604220; x=1761140220;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TEjT9vfLlCt/Mc8nTWxqbY6vNGP1X8MOONe4ssw/sls=;
 b=BSocPHnAoGa9ZgTk5J2XWGXwM7+MLute2Y/NzeRY6IR06RaujuUHRKFM
 Hh0XQW3GeM/yRUDrknd7ZL1dYAnTYBJ/+v/hMss0M9vfAHysktI3Cygh6
 sY0IJlJ6wYzjlLbYuGuwdQtTX6IwWkDa25E5/8WUJ3kXXCeSJBE74SJ4V
 cdHwZ19pTYpefDUY5hYC6l7/c75u5zzntUh3UGzD/rf45looCKWbv4hP3
 ClwvOrKPlsFblMvF7IBPR3/qhQ4yMtkkGeAkFgQMvd2R+wU4dTV886pZl
 pAZKD7dkEXRCplT5OhZYkxO3XbdyW4dM6j8sxy7kn8tdzXKnpqStr/rfW A==;
X-CSE-ConnectionGUID: 5K9po2hwTiy10D6T8P5hLg==
X-CSE-MsgGUID: 47xuvSWtQjmzM3B01EDEWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46603793"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="46603793"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 06:36:58 -0700
X-CSE-ConnectionGUID: 0mi/KwG8SrmbGUlx6dY4Bw==
X-CSE-MsgGUID: QFOw/PCjSN68kmzEB8qccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="79782484"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 22 Oct 2024 06:36:53 -0700
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
 Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 9/9] i386/cpu: add has_caches flag to check smp_cache
 configuration
Date: Tue, 22 Oct 2024 21:51:51 +0800
Message-Id: <20241022135151.2052198-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022135151.2052198-1-zhao1.liu@intel.com>
References: <20241022135151.2052198-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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

From: Alireza Sanaee <alireza.sanaee@huawei.com>

Add has_caches flag to SMPCompatProps, which helps in avoiding
extra checks for every single layer of caches in x86 (and ARM in
future).

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Note: Picked from Alireza's series with the changes:
 * Moved the flag to SMPCompatProps with a new name "has_caches".
   This way, it remains consistent with the function and style of
   "has_clusters" in SMPCompatProps.
 * Dropped my previous TODO with the new flag.
---
Changes since Patch v2:
 * Picked a new patch frome Alireza's ARM smp-cache series.
---
 hw/core/machine-smp.c |  2 ++
 include/hw/boards.h   |  3 +++
 target/i386/cpu.c     | 11 +++++------
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 640b2114b429..6ae7c4765402 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -324,6 +324,8 @@ bool machine_parse_smp_cache(MachineState *ms,
             return false;
         }
     }
+
+    mc->smp_props.has_caches = true;
     return true;
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 192f78539a6e..e6680701eec3 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -156,6 +156,8 @@ typedef struct {
  * @modules_supported - whether modules are supported by the machine
  * @cache_supported - whether cache (l1d, l1i, l2 and l3) configuration are
  *                    supported by the machine
+ * @has_caches - whether cache properties are explicitly specified in the
+ *               user provided smp-cache configuration
  */
 typedef struct {
     bool prefer_sockets;
@@ -166,6 +168,7 @@ typedef struct {
     bool drawers_supported;
     bool modules_supported;
     bool cache_supported[CACHE_LEVEL_AND_TYPE__MAX];
+    bool has_caches;
 } SMPCompatProps;
 
 /**
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b6e12b46c9cc..9a81402e71c4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7884,13 +7884,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    /*
-     * TODO: Add a SMPCompatProps.has_caches flag to avoid useless updates
-     * if user didn't set smp_cache.
-     */
-    if (!x86_cpu_update_smp_cache_topo(ms, cpu, errp)) {
-        return;
+    if (mc->smp_props.has_caches) {
+        if (!x86_cpu_update_smp_cache_topo(ms, cpu, errp)) {
+            return;
+        }
     }
 
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
-- 
2.34.1


