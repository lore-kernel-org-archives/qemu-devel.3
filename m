Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C608CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB5V-0005SQ-H0; Sat, 17 Oct 2026 16:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB3A-00032V-Rh; Sat, 17 Oct 2026 16:30:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB38-0004Py-VH; Sat, 17 Oct 2026 16:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268867; bh=n9ggVkRFD36M05i6I5ZiDf0rZoJ6NrBRyPhT6tS0uYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bvhtm5l2VC3YIwc7jmiwtyRMpNCkZStTlcMtbApRV9ogtdunI1MpR+9UZXNrxJMtE
 zhs2SwfEtEr3D/h/2s3HOjRKHWnVK0AtA5DzhSJV6mx8veNHahVaeDFX4zWOCxII7D
 EN0J93eadHDWb8dqGF8KH3Wk7x2pzqOKTx8XuRuDSLJiIn8z6WnfdFP5UTX6IaJCV2
 Su+MW2iKFmt5gF5pmVQcd2ULuZzDvw2JNTSoEh474RUCL2rAQ06SIIqKtc3xk5zFcP
 QmHP7obVqR7siPeoCpAPBfWiO9SJ5+oUyjxH87/IzO1y9vVG8vZ8svEHaA2rHT10hk
 8mH8Q38KDKLVA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C308D1DE767;
 Sat, 17 Oct 2026 23:27:47 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 83C5644343B;
 Sat, 17 Oct 2026 23:27:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 41/73] block/throttle-groups: fix crash when enabling
 I/O limits on a busy disk
Date: Sat, 17 Oct 2026 23:25:59 +0300
Message-ID: <20261017202638.728621-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

throttle_group_register_tgm() stores tgm->throttle_state before it takes
tg->lock, so the I/O path can see a member whose group still has NULL
tokens[] and an empty member list. A request in an iothread then reaches
throttle_group_co_io_limits_intercept(), wins tg->lock ahead of the
registering thread, and next_throttle_token() passes the NULL token to
throttle_group_next_tgm(), which dereferences it:

  throttle_group_next_tgm (tgm=0x0) at block/throttle-groups.c:185
  next_throttle_token (tgm=..., direction=THROTTLE_READ)
  throttle_group_co_io_limits_intercept (tgm=..., bytes=8192, ...)
  blk_co_do_preadv_part (blk=..., offset=..., bytes=8192, ...)
  blk_aio_read_entry (opaque=...)
  coroutine_trampoline (i0=..., i1=...)

blk_io_limits_enable() does not drain the BlockBackend, unlike its disable
counterpart, so nothing keeps requests away while the group is built. A
guest probing a disk that libvirt has just attached, at the moment the QoS
settings for it are applied, is enough to hit this.

Publish tgm->throttle_state with a release store once the member is
linked into the group and its timers exist, and read it with an acquire
load on the two unlocked I/O paths. A request that sees the new pointer
then also sees a fully built group.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20260908145554.3215221-2-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 429bf66a1f235847af89f7ef91d71b9c47b73892)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/block-backend.c b/block/block-backend.c
index 37ba7e9fc4..5e59bac1a3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1338,6 +1338,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
                       QEMUIOVector *qiov, size_t qiov_offset,
                       BdrvRequestFlags flags)
 {
+    ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
     int ret;
     BlockDriverState *bs;
     IO_CODE();
@@ -1357,9 +1358,8 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
     bdrv_inc_in_flight(bs);
 
     /* throttling disk I/O */
-    if (blk->public.throttle_group_member.throttle_state) {
-        throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
-                bytes, THROTTLE_READ);
+    if (qatomic_load_acquire(&tgm->throttle_state)) {
+        throttle_group_co_io_limits_intercept(tgm, bytes, THROTTLE_READ);
     }
 
     ret = bdrv_co_preadv_part(blk->root, offset, bytes, qiov, qiov_offset,
@@ -1413,6 +1413,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
                        QEMUIOVector *qiov, size_t qiov_offset,
                        BdrvRequestFlags flags)
 {
+    ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
     int ret;
     BlockDriverState *bs;
     IO_CODE();
@@ -1431,9 +1432,8 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     bdrv_inc_in_flight(bs);
     /* throttling disk I/O */
-    if (blk->public.throttle_group_member.throttle_state) {
-        throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
-                bytes, THROTTLE_WRITE);
+    if (qatomic_load_acquire(&tgm->throttle_state)) {
+        throttle_group_co_io_limits_intercept(tgm, bytes, THROTTLE_WRITE);
     }
 
     if (!blk->enable_write_cache) {
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 805e47270c..faf74a969d 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -581,7 +581,6 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
     ThrottleState *ts = throttle_group_incref(groupname);
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
 
-    tgm->throttle_state = ts;
     tgm->aio_context = ctx;
     qatomic_set(&tgm->restart_pending, 0);
 
@@ -602,6 +601,9 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
                          read_timer_cb,
                          write_timer_cb,
                          tgm);
+
+    /* The I/O path reads this without tg->lock, so publish it last */
+    qatomic_store_release(&tgm->throttle_state, ts);
 }
 
 /* Unregister a ThrottleGroupMember from its group, removing it from the list,
-- 
2.47.3


