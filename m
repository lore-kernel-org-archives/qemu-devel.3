Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A0BE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 09:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNq8T-0006Yy-Ab; Wed, 18 Dec 2024 04:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1tNq8R-0006Y6-7j
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:14:27 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1tNq8P-0001mR-2o
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734513265; x=1766049265;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VhK6YJCxy3UNdY56dm9LpsnVCa7MhAkw47y80bUy74U=;
 b=YOX4+En+aGoBoj0jB96BPTx+E5qeVU25kLvkfc8PT3YSqQrIIZMqGzXp
 ONWo44mFKRJl9yaynB/5ummmRYOIJoXBu0MvC+Pbikh3tWqKM1flN4Whp
 EcP/66QkO4ldEzgot7EOOg8Mkj5Q9FOiOt7wPvijzo/9Hm8KUKJKzBo6b
 wEkuY8DK3WJPgtIhQ9YuBypvGoR+QkFtDNKmLgrx2ScTKcrNt0q/K5f7b
 BmjSuPEjc4dTEFaLkys2HD1bTb9vRQoBZWYy49qKeSoBvMcWBeljH0Nox
 PjRWTjbqR3nEkjSxpRKIGWuM76Z0i82EWbhAE8yWtIjA8fjd9AAiggqkR A==;
X-CSE-ConnectionGUID: mouUqFitQUiVJz4mjcy/5w==
X-CSE-MsgGUID: AemB7ed9RcaAAl0XzgY6ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="37815600"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="37815600"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 01:14:18 -0800
X-CSE-ConnectionGUID: mdKrFj6XToKvQIOU6dUTqg==
X-CSE-MsgGUID: 7PxwsLOQRpetzpbqHhFP5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="121066394"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa002.fm.intel.com with ESMTP; 18 Dec 2024 01:14:16 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, jason.zeng@intel.com,
 yichen.wang@bytedance.com
Subject: [PATCH 1/3] multifd: bugfix for migration using compression methods
Date: Wed, 18 Dec 2024 17:14:11 +0800
Message-ID: <20241218091413.140396-2-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218091413.140396-1-yuan1.liu@intel.com>
References: <20241218091413.140396-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yuan1.liu@intel.com;
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

When compression is enabled on the migration channel and
the pages processed are all zero pages, these pages will
not be sent and updated on the target side, resulting in
incorrect memory data on the source and target sides.

The root cause is that all compression methods call
multifd_send_prepare_common to determine whether to compress
dirty pages, but multifd_send_prepare_common does not update
the IOV of MultiFDPacket_t when all dirty pages are zero pages.

The solution is to always update the IOV of MultiFDPacket_t
regardless of whether the dirty pages are all zero pages.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Jason Zeng <jason.zeng@intel.com>
---
 migration/multifd-nocomp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 55191152f9..2e4aaac285 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -362,6 +362,7 @@ int multifd_ram_flush_and_sync(void)
 bool multifd_send_prepare_common(MultiFDSendParams *p)
 {
     MultiFDPages_t *pages = &p->data->u.ram;
+    multifd_send_prepare_header(p);
     multifd_send_zero_page_detect(p);
 
     if (!pages->normal_num) {
@@ -369,8 +370,6 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
         return false;
     }
 
-    multifd_send_prepare_header(p);
-
     return true;
 }
 
-- 
2.43.0


