Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2175C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 09:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxOSF-0005Zt-3k; Thu, 18 Apr 2024 05:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxOSD-0005Zh-TQ
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:53:17 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxOSC-0000sk-Bi
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713433997; x=1744969997;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pSE4sw8sEmhVNn6Z8gs3SlL9juuU9kHHJYJauxlbyGo=;
 b=fVRHqXtvQUriyVUaiLqKJfMogiNqemzpXypTPY/fEz05Fa97zKDM4ek7
 nUTKTudxxMcYdArYMsdOAXpQZyWu9IlB9z4A8FXrX3SfPdIVyLxSoJl2+
 lWzkJU4j+/S432Ch0G1YYBiZFFj1rde3/elzd4xZmyH0oyBXMTeKFA46B
 Rc368rt72jWRGtnWnSFTYovB6ifK3TYqzhMw+yE6qPyo4D7t4hPwxmyo7
 b6kE7vl54Fxoe2qYNDKFXLkDsiuFqebd2lR+vsPJQ22dGcoyZmt5Q/0DB
 bPTsEmPHqw7fqiyXrD17aQsLNAXk5+iqWlbI4ycCVmnOKn98rJZqX52ps g==;
X-CSE-ConnectionGUID: yxwjKjgXSseoJ9E6GRgY2A==
X-CSE-MsgGUID: R3hprJDYQHSaM85gVg8OEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12756601"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="12756601"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 02:53:15 -0700
X-CSE-ConnectionGUID: J0T+FlFISt++hgl8eLXt2g==
X-CSE-MsgGUID: MDqYUXTKQH+rpy4YlY9P7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="60355675"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 18 Apr 2024 02:53:13 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] accel/tcg/icount-common: Consolidate the use of
 warn_report_once()
Date: Thu, 18 Apr 2024 18:07:16 +0800
Message-Id: <20240418100716.1085491-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Use warn_report_once() to get rid of the static local variable "notified".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Note: After cleaning up similar uses in x86, only icount-common.c and
virtio-mem.c still have "only once" usage with static variables.
However, virtio-mem.c uses warn_report_err() and has no associated
*_err_once variant, so it does not need to be cleaned up.
---
 accel/tcg/icount-common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index a4a747d1dc99..8d3d3a7e9dc9 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -336,10 +336,8 @@ void icount_start_warp_timer(void)
     deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                           ~QEMU_TIMER_ATTR_EXTERNAL);
     if (deadline < 0) {
-        static bool notified;
-        if (!icount_sleep && !notified) {
-            warn_report("icount sleep disabled and no active timers");
-            notified = true;
+        if (!icount_sleep) {
+            warn_report_once("icount sleep disabled and no active timers");
         }
         return;
     }
-- 
2.34.1


