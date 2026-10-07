Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77127CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUbH-0002w1-2Z; Wed, 07 Oct 2026 12:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb4-0002sP-7A
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb2-0006IP-1l
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eshJtHgyJKJk5tRLayiO00kWIQWkNbAYPjt973sQ3uw=;
 b=dll3WyH5AEE7MF7F3WpmNUyaUEOw0YLJMRVSLTlQCvwm6ermB453cVLFtJBCvg8MWRZxhL
 sDKYy1s7sp0uaPfYjfMqYsX2JRtOxCb6fPjN6IMt0TBC41N44oCSF/BYQhNy7OPCBhyf4O
 dRtP9lZgk0Fp8tq3o3BM0qIEmEOC/6o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-rVpxEUl-O9GsuDmeFhzGAA-1; Wed,
 07 Oct 2026 12:34:18 -0400
X-MC-Unique: rVpxEUl-O9GsuDmeFhzGAA-1
X-Mimecast-MFC-AGG-ID: rVpxEUl-O9GsuDmeFhzGAA_1791390857
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FCC6196F765; Wed,  7 Oct 2026 16:34:17 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A954D1956087; Wed,  7 Oct 2026 16:34:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 02/21] block/throttle-groups: fix crash when enabling I/O
 limits on a busy disk
Date: Wed,  7 Oct 2026 18:32:43 +0200
Message-ID: <20261007163302.332250-3-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 block/block-backend.c   | 12 ++++++------
 block/throttle-groups.c |  4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 37ba7e9fc40..5e59bac1a3c 100644
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
index 2dfd9d62aac..37814b84fe0 100644
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
2.56.0


