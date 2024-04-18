Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793CAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 09:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxOPk-0002Nb-C6; Thu, 18 Apr 2024 05:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxOPg-0002Kt-5M
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:50:40 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxOPe-0000aD-62
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713433838; x=1744969838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y+y8pbPG6aAYtksMSfCcD9zV1UGDITyzpAQD1vynnmE=;
 b=fRXx/ICByeYSmqj/oAAeKDjx4RL2tH/P4TYnf4WgdOLiJS2oH6z8lbgx
 tECGoZK3g1+josO/jazG14z3I2g8dvrYQJE/988SyWBXWC3WlhxEbhUrG
 EK3v2yyCjLkqOPcezJSiu5USej1uPl/e9I0g3Ca5lyj7jnvqriwt2q7I4
 G/nTCw5ZJGGAeHUOJbR2s+QZDTe3+vGSQzDoQ2nwsOPpQhWa1ZfzuOnZP
 8QpQZj1PoExwqr3/mwMeA/kh49UGWVyIAIVx7/GjAZ6B1/4O/ooGX+9nU
 WjLHqmFifrj+62fvcoYjLYL5IXldJ5h4ia4qceVI7F8sZda7RDgpmc2jz g==;
X-CSE-ConnectionGUID: HwwD7+3BTqKkQN0CCMoNvQ==
X-CSE-MsgGUID: 1nNLKCs+T++axV5oVPRslg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8837592"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8837592"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 02:50:34 -0700
X-CSE-ConnectionGUID: KzSb7/g4SSS6AvmZ8ThkqQ==
X-CSE-MsgGUID: 7xwLRKhYSEWwrkZYpW+52g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="27507000"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 18 Apr 2024 02:50:32 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/3] hw/cxl/cxl-cdat: Make ct3_load_cdat() return boolean
Date: Thu, 18 Apr 2024 18:04:31 +0800
Message-Id: <20240418100433.1085447-2-zhao1.liu@linux.intel.com>
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

So make ct3_load_cdat() return boolean, and this is the preparation for
cxl_doe_cdat_init() returning boolean.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/cxl/cxl-cdat.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 551545f7823b..b3e496857a77 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -111,7 +111,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     cdat->entry = g_steal_pointer(&cdat_st);
 }
 
-static void ct3_load_cdat(CDATObject *cdat, Error **errp)
+static bool ct3_load_cdat(CDATObject *cdat, Error **errp)
 {
     g_autofree CDATEntry *cdat_st = NULL;
     g_autofree uint8_t *buf = NULL;
@@ -127,11 +127,11 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
                              &file_size, &error)) {
         error_setg(errp, "CDAT: File read failed: %s", error->message);
         g_error_free(error);
-        return;
+        return false;
     }
     if (file_size < sizeof(CDATTableHeader)) {
         error_setg(errp, "CDAT: File too short");
-        return;
+        return false;
     }
     i = sizeof(CDATTableHeader);
     num_ent = 1;
@@ -139,19 +139,19 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
         hdr = (CDATSubHeader *)(buf + i);
         if (i + sizeof(CDATSubHeader) > file_size) {
             error_setg(errp, "CDAT: Truncated table");
-            return;
+            return false;
         }
         cdat_len_check(hdr, errp);
         i += hdr->length;
         if (i > file_size) {
             error_setg(errp, "CDAT: Truncated table");
-            return;
+            return false;
         }
         num_ent++;
     }
     if (i != file_size) {
         error_setg(errp, "CDAT: File length mismatch");
-        return;
+        return false;
     }
 
     cdat_st = g_new0(CDATEntry, num_ent);
@@ -185,6 +185,7 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
     cdat->entry_len = num_ent;
     cdat->entry = g_steal_pointer(&cdat_st);
     cdat->buf = g_steal_pointer(&buf);
+    return true;
 }
 
 void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp)
-- 
2.34.1


