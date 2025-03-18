Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D6FC28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 11:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuUfZ-0003ou-GO; Tue, 18 Mar 2025 06:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tuUfU-0003oa-Vz
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:59:33 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tuUfT-0003rv-4e
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:59:32 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 20F11233C0;
 Tue, 18 Mar 2025 13:59:27 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] qcow2: fix null pointer dereference in crypto block
Date: Tue, 18 Mar 2025 13:58:58 +0300
Message-ID: <20250318105924.258014-1-gerben@altlinux.org>
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

This error was discovered by fuzzing qemu-img.

The qcow2_refresh_limits() is missing a check
for the s->crypto pointer, which can lead to
a null pointer dereference. This commit adds the necessary check.

Reported-by: Leonid Reviakin <L.reviakin@fobos-nt.ru>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 block/qcow2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index dd6bcafbd8..55861a285a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1978,6 +1978,10 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
 
     if (bs->encrypted) {
         /* Encryption works on a sector granularity */
+        if (!s->crypto) {
+            error_setg(errp, "Encryption context is missing");
+            return;
+        }
         bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
     }
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
-- 
2.42.2


