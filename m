Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2CCC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 09:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxOPk-0002Nh-ID; Thu, 18 Apr 2024 05:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxOPi-0002MI-6o
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:50:42 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxOPg-0000aD-Il
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713433840; x=1744969840;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lbPQJi6mKHN3eHLyUnR9ZyEzQusJyhNv4/DgxwHqZeo=;
 b=V29vtrMqXPuxDfuVvrwM7600EmyIosl9Mywy7KG85cnrfq4wD6czEjeS
 GGSJBM7LsoNoAbTICrhpFByjJIdxQ9ar1COtlGODRnE3Kk4nteb49jc04
 6CjVFyD9c6EdeMXGUlJNZnu30mI3KVMU09YBu/lqTNQfVhVRDBhb4tfGz
 3HtPIMjDqxGOfgDrufPyxu93niu4D/xN6Cqbp0jtRnlGcuOYLKwWVLNAG
 OCv8X39RR6UmNvqXyy20IbuQv4/kQj/2lQNlNcCQX8Izqu6yD7lIQ4H+R
 Z4In7bDOanuUS7Xv1rl8Noh+pWIBYt5Tlu/hImt7gU5J3sUUI/6trb38m g==;
X-CSE-ConnectionGUID: T4gF78TiQ7+r20Q5XAQLWA==
X-CSE-MsgGUID: e0MKVOHoTZ2pAnR4vnFOjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8837609"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8837609"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 02:50:38 -0700
X-CSE-ConnectionGUID: SLTL1c/PQsKDo57QFAAwZA==
X-CSE-MsgGUID: weLucs5dT8ScFG3wHcvIQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="27507038"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 18 Apr 2024 02:50:36 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/3] hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return boolean
Date: Thu, 18 Apr 2024 18:04:33 +0800
Message-Id: <20240418100433.1085447-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418100433.1085447-1-zhao1.liu@linux.intel.com>
References: <20240418100433.1085447-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.17;
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

As error.h suggested, the best practice for callee is to return
something to indicate success / failure.

With returned boolean, there's no need to dereference @errp to check
failure case.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/cxl/cxl-cdat.c              | 6 +++---
 hw/mem/cxl_type3.c             | 3 +--
 hw/pci-bridge/cxl_upstream.c   | 3 +--
 include/hw/cxl/cxl_component.h | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index e7bc1380bfbf..959a55518e65 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -189,14 +189,14 @@ static bool ct3_load_cdat(CDATObject *cdat, Error **errp)
     return true;
 }
 
-void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp)
+bool cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp)
 {
     CDATObject *cdat = &cxl_cstate->cdat;
 
     if (cdat->filename) {
-        ct3_load_cdat(cdat, errp);
+        return ct3_load_cdat(cdat, errp);
     } else {
-        ct3_build_cdat(cdat, errp);
+        return ct3_build_cdat(cdat, errp);
     }
 }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b0a7e9f11b64..3e42490b6ce8 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -705,8 +705,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
     cxl_cstate->cdat.private = ct3d;
-    cxl_doe_cdat_init(cxl_cstate, errp);
-    if (*errp) {
+    if (!cxl_doe_cdat_init(cxl_cstate, errp)) {
         goto err_free_special_ops;
     }
 
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 783fa6adac19..e51221a5f334 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -338,8 +338,7 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
     cxl_cstate->cdat.build_cdat_table = build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = free_default_cdat_table;
     cxl_cstate->cdat.private = d;
-    cxl_doe_cdat_init(cxl_cstate, errp);
-    if (*errp) {
+    if (!cxl_doe_cdat_init(cxl_cstate, errp)) {
         goto err_cap;
     }
 
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 5012fab6f763..945ee6ffd045 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -273,7 +273,7 @@ hwaddr cxl_decode_ig(int ig);
 CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
 bool cxl_get_hb_passthrough(PCIHostState *hb);
 
-void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
+bool cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
 void cxl_doe_cdat_release(CXLComponentState *cxl_cstate);
 void cxl_doe_cdat_update(CXLComponentState *cxl_cstate, Error **errp);
 
-- 
2.34.1


