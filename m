Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA24DC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKvW-0004I0-TH; Sat, 15 Mar 2025 02:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKt1-00064g-Qx; Sat, 15 Mar 2025 02:20:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKsy-0003gI-J0; Sat, 15 Mar 2025 02:20:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D2A62FF9E8;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AA23D1CAC51;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6E586558E7; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Denis Rastyogin <gerben@altlinux.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 28/51] block/qed: fix use-after-free by nullifying
 timer pointer after free
Date: Sat, 15 Mar 2025 09:17:34 +0300
Message-Id: <20250315061801.622606-28-mjt@tls.msk.ru>
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
Message-ID: <20250304083927.37681-1-gerben@altlinux.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 2ad638a3d160923ef3dbf87c73944e6e44bdc724)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/qed.c b/block/qed.c
index fa5bc11085..f321126241 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -353,6 +353,7 @@ static void bdrv_qed_detach_aio_context(BlockDriverState *bs)
 
     qed_cancel_need_check_timer(s);
     timer_free(s->need_check_timer);
+    s->need_check_timer = NULL;
 }
 
 static void bdrv_qed_attach_aio_context(BlockDriverState *bs,
-- 
2.39.5


