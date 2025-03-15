Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7B9C28B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKyZ-0000sN-2g; Sat, 15 Mar 2025 02:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKuY-0001rd-Ou; Sat, 15 Mar 2025 02:22:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKuW-0003p2-Et; Sat, 15 Mar 2025 02:22:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 203C4FF9F8;
 Sat, 15 Mar 2025 09:17:08 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EB5E91CAC61;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 951F455907; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefano Stabellini <stefano.stabellini@amd.com>,
 Olaf Hering <olaf@aepfle.de>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Anthony PERARD <anthony.perard@vates.tech>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 44/51] xen: No need to flush the mapcache for grants
Date: Sat, 15 Mar 2025 09:17:50 +0300
Message-Id: <20250315061801.622606-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Stabellini <stefano.stabellini@amd.com>

On IOREQ_TYPE_INVALIDATE we need to invalidate the mapcache for regular
mappings. Since recently we started reusing the mapcache also to keep
track of grants mappings. However, there is no need to remove grant
mappings on IOREQ_TYPE_INVALIDATE requests, we shouldn't do that. So
remove the function call.

Fixes: 9ecdd4bf08 (xen: mapcache: Add support for grant mappings)
Cc: qemu-stable@nongnu.org
Reported-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Message-Id: <20250206194915.3357743-2-edgar.iglesias@gmail.com>
Signed-off-by: Anthony PERARD <anthony.perard@vates.tech>
(cherry picked from commit 68adcc784bad13421ac7211c316a751fb99fcb94)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 18ba7b1d8f..cd412493ea 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -700,7 +700,6 @@ void xen_invalidate_map_cache(void)
     bdrv_drain_all();
 
     xen_invalidate_map_cache_single(mapcache);
-    xen_invalidate_map_cache_single(mapcache_grants);
 }
 
 static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
-- 
2.39.5


