Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91653C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNAIY-0007ew-Cz; Thu, 05 Jun 2025 09:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNAIW-0007eB-7V
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:06:20 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNAIS-0005jO-Ua
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749128777; x=1780664777;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bWeo9lD/JYISHzI8hwlLcunUZFInNqo2ewuFKeaXEng=;
 b=FFGPAVG9rBaZjfwYUYBmWq/e+hqHOsenscDTiLejhOCYUxJvx07+JPt+
 cE6oRz1IX2K49P2h9Ug6w1jviP4hxsRShzREGhLnVYfiNWxVuZTIDj1RD
 xer8+w0IM5yAqwO/f9vxiyn7ZCz+tTgP/5P0SLyK8Z/KVVaNL0VxVHVwr
 /Ai4+Pe8Qrs8mb7ysTA+MyXk6tbYs6jg59v22/EKkHVDXNXE0aLr0Dpm7
 0yPtxER10mudJt++Rlu7k/OTDsZCYfFExBzQibDHk3d+xaDPxASl5NS6H
 qp/XmDyOS6OTUH3JNZ1A+RP2vN08ZrpX4wpyVkChrGYx0y1K+o1kfZIGd w==;
X-CSE-ConnectionGUID: 3QfYsklZT2asVtxwP+k10w==
X-CSE-MsgGUID: AF2Rk6QVTKKUcFRzk47BSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="50944526"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="50944526"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 06:06:11 -0700
X-CSE-ConnectionGUID: gYqPSB94QFy5EuABjlEE/g==
X-CSE-MsgGUID: mNQST26EQB6rTpvcGHkERA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="150518859"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 05 Jun 2025 06:06:09 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] hw/core/cpu: Move CacheType to general cpu.h
Date: Thu,  5 Jun 2025 21:27:22 +0800
Message-Id: <20250605132722.3597593-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

I386 has already defined cache types in target/i386/cpu.h.

Move CacheType to hw/core/cpu.h, so that ARM and other architectures
could use it.

Cc: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
This is for Ali's ARM cache topology support:
https://lore.kernel.org/qemu-devel/aEFnFI+wglkmLD5G@intel.com/

(Ali, if maintainer doesn't pick this, you can include this into your
 series freely.)
---
 include/hw/core/cpu.h | 6 ++++++
 target/i386/cpu.h     | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1e87f7d393ec..33296a1c080e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1126,4 +1126,10 @@ extern const VMStateDescription vmstate_cpu_common;
 #define UNASSIGNED_CPU_INDEX -1
 #define UNASSIGNED_CLUSTER_INDEX -1
 
+enum CacheType {
+    DATA_CACHE,
+    INSTRUCTION_CACHE,
+    UNIFIED_CACHE
+};
+
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1146465c8c62..8efea2ef2686 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1768,12 +1768,6 @@ typedef enum TPRAccess {
 
 /* Cache information data structures: */
 
-enum CacheType {
-    DATA_CACHE,
-    INSTRUCTION_CACHE,
-    UNIFIED_CACHE
-};
-
 typedef struct CPUCacheInfo {
     enum CacheType type;
     uint8_t level;
-- 
2.34.1


