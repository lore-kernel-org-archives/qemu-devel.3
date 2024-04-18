Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D3AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 09:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxOPi-0002Md-EM; Thu, 18 Apr 2024 05:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxOPg-0002LB-Sy
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:50:40 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxOPf-0000bx-AN
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713433839; x=1744969839;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=67wYxFpR0HmgfUT+8PMx6saVlYwoggN34mvmll1aXh4=;
 b=LOkJ/VSK9kGet20izNreLXcW2PVgJhvShqihTMxnHYH2TP6OFYjHa7zp
 mCtUvU6XmCnG7m6iSpBMfQaJMOqQuJS7nERmgXZIFRAnjYmIhfkR+c9bc
 e5E+0DoIyjMTcdbpOGfGaFs6ejvS1LLGG3nlQreBmt5ThVh7oJSLeYLu1
 U/l4libfIJ/5O8tLHk/JfTU9LGMrD1xCANnDJZM1l4PUYpcXxgTdcYvOr
 9Ccubfp2uCzgk4Aw2Oz3r35Z3+Ttskhg9eFPjg8hMfrvqPg+uzr0vVEQj
 pmoYDq5ysymAj69aYeATZ0p7Tu9z8ZRZCWyA4uoaqysYRssPkcdXzZKFj g==;
X-CSE-ConnectionGUID: nQK3/9opRXaH2IQG+QjmBQ==
X-CSE-MsgGUID: y+aL9H5US3WH8JZD2ByTIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8837602"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8837602"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 02:50:36 -0700
X-CSE-ConnectionGUID: xSWiApeISRSI0Nr6w2Sh/g==
X-CSE-MsgGUID: bza7xcyYRiOrrFZA55Lfog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="27507019"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 18 Apr 2024 02:50:34 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/3] hw/cxl/cxl-cdat: Make ct3_build_cdat() return boolean
Date: Thu, 18 Apr 2024 18:04:32 +0800
Message-Id: <20240418100433.1085447-3-zhao1.liu@linux.intel.com>
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

So make ct3_build_cdat() return boolean, and this is the preparation for
cxl_doe_cdat_init() returning boolean.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/cxl/cxl-cdat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index b3e496857a77..e7bc1380bfbf 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -44,7 +44,7 @@ static void cdat_len_check(CDATSubHeader *hdr, Error **errp)
     }
 }
 
-static void ct3_build_cdat(CDATObject *cdat, Error **errp)
+static bool ct3_build_cdat(CDATObject *cdat, Error **errp)
 {
     g_autofree CDATTableHeader *cdat_header = NULL;
     g_autofree CDATEntry *cdat_st = NULL;
@@ -58,7 +58,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     cdat_header = g_malloc0(sizeof(*cdat_header));
     if (!cdat_header) {
         error_setg(errp, "Failed to allocate CDAT header");
-        return;
+        return false;
     }
 
     cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
@@ -67,14 +67,14 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     if (cdat->built_buf_len <= 0) {
         /* Build later as not all data available yet */
         cdat->to_update = true;
-        return;
+        return true;
     }
     cdat->to_update = false;
 
     cdat_st = g_malloc0(sizeof(*cdat_st) * (cdat->built_buf_len + 1));
     if (!cdat_st) {
         error_setg(errp, "Failed to allocate CDAT entry array");
-        return;
+        return false;
     }
 
     /* Entry 0 for CDAT header, starts with Entry 1 */
@@ -109,6 +109,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     cdat_st[0].length = sizeof(*cdat_header);
     cdat->entry_len = 1 + cdat->built_buf_len;
     cdat->entry = g_steal_pointer(&cdat_st);
+    return true;
 }
 
 static bool ct3_load_cdat(CDATObject *cdat, Error **errp)
-- 
2.34.1


