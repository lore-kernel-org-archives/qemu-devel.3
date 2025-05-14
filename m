Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4F5C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHSD-0000Bo-78; Wed, 14 May 2025 15:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHN7-0005g2-TQ; Wed, 14 May 2025 15:02:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHN2-0007k0-V7; Wed, 14 May 2025 15:02:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ED900121D9D;
 Wed, 14 May 2025 22:00:32 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 01C3B20BA8F;
 Wed, 14 May 2025 22:00:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aleksandr Partanen <alex.pentagrid@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 19/23] xen: mapcache: Fix finding matching entry
Date: Wed, 14 May 2025 22:00:31 +0300
Message-Id: <20250514190041.104759-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
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

From: Aleksandr Partanen <alex.pentagrid@gmail.com>

If we have request without lock and hit unlocked or invalid
entry during the search, we remap it immediately,
even if we have matching entry in next entries in bucket.
This leads to duplication of mappings of the same size,
and to possibility of selecting the wrong element
during invalidation and underflow it's entry->lock counter

Signed-off-by: Aleksandr Partanen <alex.pentagrid@gmail.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
(cherry picked from commit a4b20f737cda06bb8706a83e27f7fa89863ae689)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 698b5c53ed..2c8f861fdb 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -376,12 +376,12 @@ tryagain:
 
     entry = &mc->entry[address_index % mc->nr_buckets];
 
-    while (entry && (lock || entry->lock) && entry->vaddr_base &&
-            (entry->paddr_index != address_index || entry->size != cache_size ||
+    while (entry && (!entry->vaddr_base ||
+            entry->paddr_index != address_index || entry->size != cache_size ||
              !test_bits(address_offset >> XC_PAGE_SHIFT,
                  test_bit_size >> XC_PAGE_SHIFT,
                  entry->valid_mapping))) {
-        if (!free_entry && !entry->lock) {
+        if (!free_entry && (!entry->lock || !entry->vaddr_base)) {
             free_entry = entry;
             free_pentry = pentry;
         }
-- 
2.39.5


