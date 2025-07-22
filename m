Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC29AC83F25
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 10:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueA2U-00019c-Na; Tue, 22 Jul 2025 06:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1ueA2S-00017P-52
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 06:16:00 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1ueA2M-00087G-Or
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 06:15:59 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id C68C52339B;
 Tue, 22 Jul 2025 13:15:47 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] linux-user: check for NULL before using
 interval_tree_iter_first result
Date: Tue, 22 Jul 2025 13:15:05 +0300
Message-ID: <20250722101544.16366-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Denis Rastyogin <gerben@altlinux.org>

interval_tree_iter_first() may return NULL if the interval tree is empty or invalid.
Add a check for NULL before dereferencing the pointer to avoid potential crashes
due to null pointer dereference in open_self_maps_2().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..d5d5912c96 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8172,6 +8172,9 @@ static int open_self_maps_2(void *opaque, vaddr guest_start,
     while (1) {
         IntervalTreeNode *n =
             interval_tree_iter_first(d->host_maps, host_start, host_start);
+        if (n == NULL) {
+            return -1;
+        }
         MapInfo *mi = container_of(n, MapInfo, itree);
         uintptr_t this_hlast = MIN(host_last, n->last);
         target_ulong this_gend = h2g(this_hlast) + 1;
-- 
2.42.2


