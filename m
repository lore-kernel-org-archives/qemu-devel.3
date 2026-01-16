Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1C9D4A602
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 06:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgcvr-0007IX-NN; Fri, 16 Jan 2026 01:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vgcvp-0007Fx-6O
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:03:37 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vgcvn-0008Pp-0G
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768543415; x=1800079415;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qfzWsW5hcNYwh342rAtckBYgSg+g62JfKIiycmKaqmU=;
 b=heXC4mF0/gAQSb+Lul7nJI9uo9OAT2mJK87CN4VeuuQ5nGVv5LsA4J6T
 lAw8FpPNoTir7+PnhX3TxEHwEyo1LEXBn3lZTu5ejAmRGuT98qrkCi6oH
 ZhjQ2QRUTs2fgAYEzNRS5MADSJKXt4cWqzWLaEEEhY57yE5QNoAjpI8pw
 jpkNUOIzzbmfmvoBm7m4jQNaqEMiYzU33+blJu7CCnlY8pgJtVHXHcvJa
 EW5khAELvm7fsWexsbCYBwY0GJL6YvWmPNMvT04YF7zAke7YVkJI5wKQ4
 BUagkQckG2ksNaQXRwnSios/VveY/s9x9tAYqpMnr7vx9A2YWxbcSWWWb A==;
X-CSE-ConnectionGUID: lIGVKRzeQy+8Q62c58Kfhw==
X-CSE-MsgGUID: TEhhjMQhRp+Zz1WsZw5FDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="81223333"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; d="scan'208";a="81223333"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 22:03:31 -0800
X-CSE-ConnectionGUID: XDsNYSEhTe+vaeOttPoB3A==
X-CSE-MsgGUID: Fb1IaSFsSH20YA4oaOMGMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; d="scan'208";a="204361397"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 22:03:29 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio/migration: Fix page size calculation
Date: Fri, 16 Jan 2026 01:03:15 -0500
Message-ID: <20260116060315.65723-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Coverity detected an issue of left shifting int by more than 31 bits leading
to undefined behavior.

In practice bcontainer->dirty_pgsizes always have some common page sizes
when dirty tracking is supported.

Resolves: Coverity CID 1644186
Resolves: Coverity CID 1644187
Resolves: Coverity CID 1644188
Fixes: 46c763311419 ("vfio/migration: Add migration blocker if VM memory is too large to cause unmap_bitmap failure").
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index f857dc25ed..b4695030c7 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1173,7 +1173,7 @@ static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
      * can also switch to use IOMMUFD backend if there is a need to migrate
      * large VM.
      */
-    page_size = 1 << ctz64(bcontainer->dirty_pgsizes);
+    page_size = 1ULL << ctz64(bcontainer->dirty_pgsizes);
     max_size = bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE * page_size;
 
     return current_machine->ram_size > max_size;
-- 
2.47.1


