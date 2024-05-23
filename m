Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A34C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 12:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA7hi-000451-Sf; Thu, 23 May 2024 08:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhibin.li@intel.com>)
 id 1sA3s0-0003wn-Gp
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:32:16 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhibin.li@intel.com>)
 id 1sA3ry-0004Nm-2t
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716453134; x=1747989134;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nT8UVHoVMPvOayZ++Vv/EwsYJ0iAXVuVzWJs/feu1dY=;
 b=j3qAXNJz34GNOAsUR169SNVq9j0z6sH3okvF05LNmcPbOdiChhHfOaoX
 7pY2ptIRMzFZux5/990OxVaGxf8mY7SG2MQnc6xdGI7FIgIBOIaIMDL9h
 McJxm4spKMC1W/KjZnMePsFZ2dErF3hykJFf2etEc9EhOKFqomaVwk1bj
 W5w99Ztx+IeQP/r8y3DLikuKiV+JxlbUIosbq7WQtM7ULTp+GZ5ncPL26
 Re21/7EFBgfIprO31vP8punyrKwkcJn+DNbwoebMvimeK9OPsUYIuZlIo
 wjKE9i5XVPleKmsP0o2wjK3HrcLofUK8+bu+EfGj42Cm/KPWR6pae0c8y g==;
X-CSE-ConnectionGUID: dklwAa1aRTu1k2cb/xhXNA==
X-CSE-MsgGUID: YorTke9FQCaIUGlmPqnC0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="38134070"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208,223";a="38134070"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 01:32:08 -0700
X-CSE-ConnectionGUID: Y89ueP43S+mcdK6iGBOhcw==
X-CSE-MsgGUID: DB2JQ678TGqKyH7Ul9wdaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208,223";a="34193705"
Received: from flexbp2.sh.intel.com (HELO localhost) ([10.239.82.162])
 by orviesa007.jf.intel.com with ESMTP; 23 May 2024 01:32:06 -0700
From: Zhibin Li <zhibin.li@intel.com>
To: qemu-devel@nongnu.org
Cc: zhibin.li@intel.com
Subject: [PATCH] dump: use 10 base for phys_base
Date: Thu, 23 May 2024 16:32:05 +0800
Message-ID: <20240523083205.2248593-1-zhibin.li@intel.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhibin.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 May 2024 08:37:51 -0400
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

From vmcoreinfo 'phys_base' is a decimal instead a hexadecimal so use base of
10 instead of 16 when converting this string.

Signed-off-by: Zhibin Li <zhibin.li@intel.com>
---
Hi everyone. I'm trying to use 'dump-guest-memory' QMP command to generate a kdump-compressed vmcore file which can be consumed by makedumpfile tool (the command I used is: `dump-guest-memory -l -R test.bin`).

I found that the generated vmcore cannot be parsed correctly by 'makedumpfile' and I noticed that the 'phys_base' is incorrect with KASLR enabled. This is just a quick fix and please let me know if you have any comments.

By the way, with this fix 'makedumpfile' can proceed to handle the generated vmcore but later on some other issues were found. I'm still trying to debug this. If you have any BKMs about using 'makedumpfile' with QEMU please let me know. Thanks!

 dump/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/dump.c b/dump/dump.c
index 84064d890d..e42ab3ccac 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1760,7 +1760,7 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
         }
 
         if (prefix && g_str_has_prefix(lines[i], prefix)) {
-            if (qemu_strtou64(lines[i] + strlen(prefix), NULL, 16,
+            if (qemu_strtou64(lines[i] + strlen(prefix), NULL, 10,
                               &phys_base) < 0) {
                 warn_report("Failed to read %s", prefix);
             } else {
-- 
2.43.2


