Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF5FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 01:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG5wJ-0002Tv-5A; Mon, 03 Nov 2025 20:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vG5wG-0002TZ-OL
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 20:34:24 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vG5wB-0007Lu-6P
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 20:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1762220059; x=1793756059;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AIUWjy6jb3RCtAzhW965OPha/0p0ABul/nwNI5TWDz0=;
 b=eluc3gdBRUsBOwFado5NiEpVc/e+LMTC6z/qio1pc7YspFeQ7XUAbqUi
 +xG3uQs0RYZ42TxWegqo95Y2AXjIKE9gniE/hC2+IZo7DtbEP7rlplJRW
 0XUNrkgqLFSjZvxhbHL2Z9mLBMs1diEV/WiVZUp8UU36G78ld8VOKrfnz
 KiO/mRVCllOEkbk/uItqwRRXifJB+F17dF4bJom/DDI3ibH+rcP1qIZMP
 T5u82qPFYFD450HDUFRz7kJQItPFwx2PtsVImU2zb0KVDJCbGZkUJ4FqY
 iHbGDjJrJRPZPfpcH198wVstOMd6JDU41jS625opdHZROmSY8QT7q8vNf A==;
X-CSE-ConnectionGUID: jgug/Iw0RbyiVPlJo1gplA==
X-CSE-MsgGUID: 9Dw3ubLrShuJuJUTu6XgVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="218574705"
X-IronPort-AV: E=Sophos;i="6.19,277,1754924400"; d="scan'208";a="218574705"
Received: from unknown (HELO az2uksmgr2.o.css.fujitsu.com) ([52.151.125.19])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 10:34:10 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by az2uksmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id 6675D8203FC
 for <qemu-devel@nongnu.org>; Tue,  4 Nov 2025 01:34:10 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (az2nlsmom3.o.css.fujitsu.com
 [10.150.26.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 1B9718D29C2
 for <qemu-devel@nongnu.org>; Tue,  4 Nov 2025 01:34:10 +0000 (UTC)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by az2nlsmom3.fujitsu.com (Postfix) with ESMTP id 99E19101BB7A;
 Tue,  4 Nov 2025 01:34:06 +0000 (UTC)
To: peterx@redhat.com,
	farosas@suse.de
Cc: zhangckid@gmail.com, zhanghailiang@xfusion.com, qemu-devel@nongnu.org,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] migration: Fix transition to COLO state from precopy
Date: Tue,  4 Nov 2025 09:36:06 +0800
Message-ID: <20251104013606.1937764-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.139.117;
 envelope-from=lizhijian@fujitsu.com; helo=esa4.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit 4881411136 ("migration: Always set DEVICE state") set a new DEVICE
state before completed during migration, which broke the original transition
to COLO. The migration flow for precopy has changed to:
active -> pre-switchover -> device -> completed.

This patch updates the transition state to ensure that the Pre-COLO
state corresponds to DEVICE state correctly.

Fixes: 4881411136 ("migration: Always set DEVICE state")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a63b46bbef..6ec7f3cec8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3095,9 +3095,9 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
 
-    if (migrate_colo() && s->state == MIGRATION_STATUS_ACTIVE) {
+    if (migrate_colo() && s->state == MIGRATION_STATUS_DEVICE) {
         /* COLO does not support postcopy */
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+        migrate_set_state(&s->state, MIGRATION_STATUS_DEVICE,
                           MIGRATION_STATUS_COLO);
     } else {
         migration_completion_end(s);
-- 
2.44.0


