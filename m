Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058A2C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xF1-0007lT-0k; Tue, 08 Sep 2026 10:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x3xEy-0007ju-TB
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:56:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x3xEu-0005wm-58
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:56:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so45479615e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788879358; x=1789484158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GJe9uMqiJ7PAQfCXo+h1K8uHGVVKiXLgLu8g5cRrXtE=;
 b=GBamlsZCz9rql6X+k+2Tvo7EfiM9F692oLgWrTjbMw3bhOFdWBEjOFR7doC+TRPwXw
 0ixcjoAIRBwtVjaRNMzhFnG3Tto1zJ5TLhST6J6IFSSGJjxi/6LWzvF+zFNKo/HsdrSk
 HLBCWkfYdX/L3TCqVhA6a7zKM2l+4SAkM8w6m6jgbnuEFpxJs+n+brjQkGvPKOKxvLcS
 v1x3WaMJR28qnmeiOSfKHz6u1+cxyb179mWCwbOD+xWkJpMCDUN0V8uNNK++DboZZAVM
 vOXA6o8O5ErFzbpVmK1I2FgHGHSAwlEvLz0PDaH6fJ8Uh3/LKErwzpT2ovv9Pjt9cngD
 d72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788879358; x=1789484158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GJe9uMqiJ7PAQfCXo+h1K8uHGVVKiXLgLu8g5cRrXtE=;
 b=sqoFdzYdBWsOC8l1OlIoXJh/Nhs6pfB+gHvMnDrm9lsmPM2ctyAXXqOehnikMkA+Rw
 +jgVf1N3JFYoanH0yTwTA5wbSEgd0LB8jtV3hSO9QKuW9lC+LQ+6gT6XrWKj68qGRXzs
 klc8PcxbZ2kjt8ilTUCYyASacK9pkSwDdpGn2amU7mWq2YUFBLWrG8ta6pUGP2VhVAAS
 Tl5vxeT+rmrIq7ZANMnm23zxecfaEVhYo1pXONbQ85b1OfdwrV4n6UMPhgLenQXfu30+
 tmEQ7a5R4L0pXSw4supH9FcDX2DQyT5QHbIlP7x1GZa3WT+r6EtS9gRtaC6aSxU1031E
 Bspw==
X-Gm-Message-State: AFuF++moPhKoWcBnbNOH4pJIqRqsnCUzPdj0NR8MhcMQWJN2LOEehReY
 xyqpunQRWp/TXx7xcb6XWkgNC/0x11WXhMG2Rk4J73GfT7tI5sydVAuZxgpzCM0cqDP5JiPC9hO
 b68Oa
X-Gm-Gg: AYBFou2SG1GBW70/J0AD7piO/iAtYzHB0vf5TtVKpetr8olJpiYTFlyX/NmBYfnrESR
 h6cucRIy9uy4CRVN1p36hBPnpDE2c88k/m/Qigk4Hiz2FMlTHFrH7LKbMiCtujmszT72WA4NYrE
 mXn/qpVSmxYg1mz6HKFaKneYkqIaFzPxn2xVIDRTXQ3n3gWirQBgQ4fxMTkeNOoNqDoMYLbt05U
 VKopFaGctvOIiNqTlB/j7FieToA6qKhVCwLhVFxANeftQdJTtcXKmg0rlyAYXdHF0aLtxyCMI+Z
 yJlXc9WpTKOrEUW6cwbpU4WMgo40q1mQQGQz17XwAY7CJiOn4KLfQb7r1fMSTwFBE4/jQjy3Htr
 knSH5O/2NE17INRsSyVuzFynNSH5B8fahLx6kbESsDQZAv+Y1736Kdm8rOL+f8wKfdF4PobyklO
 WuXx2E8kS47jJm0o0ze8FusFkz5HADC3JfiTAr9+CGlh2cntKo61DjsauuRjo=
X-Received: by 2002:a05:600c:3b11:b0:49c:f7c4:dc54 with SMTP id
 5b1f17b1804b1-49cf82512b9mr511461025e9.14.1788879358142; 
 Tue, 08 Sep 2026 07:55:58 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:695d:ab39:8b90:f8d6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm275342355e9.4.2026.09.08.07.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 07:55:57 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alberto Garcia <berto@igalia.com>
Subject: [PATCH] block/throttle-groups: fix crash when enabling I/O limits on
 a busy disk
Date: Tue,  8 Sep 2026 16:55:53 +0200
Message-ID: <20260908145554.3215221-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908145554.3215221-1-den@openvz.org>
References: <20260908145554.3215221-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

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
---
 block/block-backend.c   | 12 ++++++------
 block/throttle-groups.c |  4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

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
2.53.0


