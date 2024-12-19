Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E6DE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBgH-0005wX-7m; Thu, 19 Dec 2024 03:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOBgF-0005nM-33
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:14:47 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOBgD-0000Kl-8P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734596085; x=1766132085;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HyQNL2QRST3bzAofC6NdSneNk+dJQgGE9UE8ka+3X3M=;
 b=bFObPyP/42X7hgOEHVtaSX83maSx9ppMIQejSEWnOoFb0g5HkrShqR8U
 5ye71wVYUtAWLFZYscryg7jLVrP9cA56IHpr08dV8W4y3Aug3OHikkC1A
 O3J2el2XswgibO57hQPtpaS197odVARFtkxr9CowJCTsODIuItsQxBO49
 ZPMw5qE7dAkajwo/Bl7ZSF3SMQeZk6HB5KCMJXv1bAXSDNYn1Old01xD2
 MVpVrEVC0/0koaTP5VJjq/DncpeQOUHsEJcwXEcI83O0f7dfeh+GQsaEy
 JYyQMCrlKNB/I1Ud89+Nm1WJMAB3ExjJTT8CXivRij2IRK6rJnia3An9W w==;
X-CSE-ConnectionGUID: RdvtOebYSZqXDQ33SVV2bg==
X-CSE-MsgGUID: AC8qWGOkQ6CusS2tIgz3vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34378675"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34378675"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 00:14:29 -0800
X-CSE-ConnectionGUID: 6Zn6Kp97QoubQDBwujTxcw==
X-CSE-MsgGUID: 3p7A14JdQe+SIqaC6tm+xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="129097570"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 19 Dec 2024 00:14:26 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 4/4] i386/cpu: add has_caches flag to check smp_cache
 configuration
Date: Thu, 19 Dec 2024 16:32:37 +0800
Message-Id: <20241219083237.265419-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219083237.265419-1-zhao1.liu@intel.com>
References: <20241219083237.265419-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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
index b954eb849027..fe66961341fe 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -325,6 +325,8 @@ bool machine_parse_smp_cache(MachineState *ms,
             return false;
         }
     }
+
+    mc->smp_props.has_caches = true;
     return true;
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5723ee76bdea..c647e507d1a9 100644
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
index bd5620dcc086..a9700fba991f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8039,13 +8039,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
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


