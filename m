Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC4CC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNom-0003Hk-GL; Tue, 04 Mar 2025 03:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tpNoR-0003Gx-UF
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 03:39:41 -0500
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tpNoO-0000z7-K8
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 03:39:39 -0500
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id D3FE12336E;
 Tue,  4 Mar 2025 11:39:31 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] block/qed: fix use-after-free by nullifying timer pointer
 after free
Date: Tue,  4 Mar 2025 11:39:10 +0300
Message-ID: <20250304083927.37681-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

In the QED block driver, the need_check_timer timer is freed in
bdrv_qed_detach_aio_context, but the pointer to the timer is not
set to NULL. This can lead to a use-after-free scenario
in bdrv_qed_drain_begin().

The need_check_timer pointer is set to NULL after freeing the timer.
Which helps catch this condition when checking in bdrv_qed_drain_begin().

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2852
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 block/qed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qed.c b/block/qed.c
index 382c9e5335..ac24449ffb 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -353,6 +353,7 @@ static void bdrv_qed_detach_aio_context(BlockDriverState *bs)
 
     qed_cancel_need_check_timer(s);
     timer_free(s->need_check_timer);
+    s->need_check_timer = NULL;
 }
 
 static void bdrv_qed_attach_aio_context(BlockDriverState *bs,
-- 
2.42.2


