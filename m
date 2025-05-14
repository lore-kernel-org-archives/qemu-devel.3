Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAE1C3ABDE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7UF-0006wF-U2; Wed, 14 May 2025 04:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UD-0006ng-JN; Wed, 14 May 2025 04:29:09 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UA-0006H0-U7; Wed, 14 May 2025 04:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747211347; x=1778747347;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=836Ep7tG5Dlv+jTQ31nvdVjjOxRRfYfEjYN1IhyCB6o=;
 b=n5P49jUFBGdBW6TgbISqE6mto3cQXm/RCmcwOOCkpzoX2xKC9VI6zrQJ
 ZO7JDVB/Ek2fcLu851CCH1Y9kMAGc0Hsf/oZmA145XC6X3WeO3SrYFK0d
 UWxMnj4YomRm7I2v1DwhEKjSYA0upgse51Dark62VkSIAx4O2i1CJGts4
 YEAiLOwNozHsOwtXJY6asu6bGUoAuHH0PM/1WEKDMDttyGhVom9RFLYtK
 aoj0dcd3BXPinQPBcym6E/8rBkRXzblVairdvg2x8l0V24CL/oowKBhPQ
 6bG6Iavkao9kDhsq1p6F00uQL52PiNeOZTlsbf8dndoQp7NaFG9YGxoK/ Q==;
X-CSE-ConnectionGUID: 8COvPUv+QVm4TSucCbq6Zg==
X-CSE-MsgGUID: v6+Iz64fQuCs4taToY/2vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66505588"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="66505588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:29:04 -0700
X-CSE-ConnectionGUID: JX1z1X70RriXvdcJ5JumnQ==
X-CSE-MsgGUID: OHmN9ajmT6+QpSStXDBeoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169065827"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 01:29:02 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH 5/9] hw/hyperv/hv-balloon: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Date: Wed, 14 May 2025 16:49:53 +0800
Message-Id: <20250514084957.2221975-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514084957.2221975-1-zhao1.liu@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

The QOM type of HvBalloon is declared by OBJECT_DECLARE_SIMPLE_TYPE,
which means it doesn't need the class!

Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement
the type, then there's no need for class definition.

Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/hyperv/hv-balloon.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 94b0abbd6834..db3be4246eae 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -67,10 +67,6 @@
  * these requests
  */
 
-struct HvBalloonClass {
-    VMBusDeviceClass parent_class;
-} HvBalloonClass;
-
 typedef enum State {
     /* not a real state */
     S_NO_CHANGE = 0,
@@ -162,8 +158,8 @@ typedef struct HvBalloon {
     MemoryRegion *mr;
 } HvBalloon;
 
-OBJECT_DEFINE_TYPE_WITH_INTERFACES(HvBalloon, hv_balloon, HV_BALLOON, VMBUS_DEVICE, \
-                                   { TYPE_MEMORY_DEVICE }, { })
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(HvBalloon, hv_balloon, HV_BALLOON, VMBUS_DEVICE, \
+                                          { TYPE_MEMORY_DEVICE }, { })
 
 #define HV_BALLOON_SET_STATE(hvb, news)             \
     do {                                            \
-- 
2.34.1


