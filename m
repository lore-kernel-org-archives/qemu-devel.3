Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FD3C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gdh-0005pm-0p; Wed, 02 Sep 2026 04:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdf-0005mo-BG; Wed, 02 Sep 2026 04:48:11 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdb-0007AL-CN; Wed, 02 Sep 2026 04:48:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id AEFCF80CB4;
 Wed, 02 Sep 2026 11:48:01 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b72::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id xlfWR5raWmI0-e6xhaPvL; Wed, 02 Sep 2026 11:48:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788338881;
 bh=TgxIjFOhuWPMszwvJ2w3DFwhDFqQquG/4E8vpUo8r7w=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=YOljxP/g98cUZJq4Bpwa1R63JEz+8luvnDa/HySeuqNZlBwPfveIOypZB2qolwghz
 +dsE2U9qSq+0u6ZvHfta4KoMb/yMWocVBisyzcwAsUmDxXCnv3Y7ZgHbgwIFDWO/SS
 mipbpabaJ7ovIZxWabd/oGj2eDo+vpp2nFfbFudY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, vsementsov@yandex-team.ru,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 2/8] block/nbd: never index requests[] with an unchecked cookie
Date: Wed,  2 Sep 2026 11:47:48 +0300
Message-ID: <20260902084754.140103-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902084754.140103-1-vsementsov@yandex-team.ru>
References: <20260902084754.140103-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Cookies are converted into indices of s->requests[] in several places
and the result is used right away, without any check:

    int i = COOKIE_TO_INDEX(cookie);
    ...
    return nbd_co_receive_offset_data_payload(s, s->requests[i].offset,

COOKIE_TO_INDEX() subtracts one, so a zero cookie becomes an index of
-1 and the access lands in front of the array. This is undefined and,
depending on the type of the index and on what the compiler has put
there, it can as well pass silently: at the site above i is signed, so
even a plain i < MAX_NBD_REQUESTS check would happily let -1 through.

Route every conversion through a helper which hands out the slot only
for a cookie in range and owned by a request in flight, so that the
check can not be forgotten again. The helper reports through an Error,
as the one cookie which is not ours to trust, the one taken from the
wire in nbd_receive_replies(), is a protocol error rather than an
internal inconsistency and has to stay a channel error. Every other
cookie is one we have issued and still own, so a bad value there is a
bug in this file, which is what &error_abort spells out.

The cookie of the reply in flight goes through the helper as well. It
is not an unchecked value either: it has passed the check on the wire
path, or it has been cleared by the previous commit.

Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20260820115228.587427-3-den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/nbd.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index d9b776283f4..d0a7097034c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -136,6 +136,19 @@ static void nbd_clear_bdrvstate(BlockDriverState *bs)
     s->x_dirty_bitmap = NULL;
 }
 
+static NBDClientRequest *nbd_request_by_cookie(BDRVNBDState *s, uint64_t cookie,
+                                               Error **errp)
+{
+    uint64_t ind = COOKIE_TO_INDEX(cookie);
+
+    if (ind >= MAX_NBD_REQUESTS || !s->requests[ind].coroutine) {
+        error_setg(errp, "unexpected cookie value");
+        return NULL;
+    }
+
+    return &s->requests[ind];
+}
+
 /* Called with s->receive_mutex taken.  */
 static bool coroutine_fn nbd_recv_coroutine_wake_one(NBDClientRequest *req)
 {
@@ -422,7 +435,8 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
                                             Error **errp)
 {
     int ret;
-    uint64_t ind = COOKIE_TO_INDEX(cookie), ind2;
+    NBDClientRequest *req = nbd_request_by_cookie(s, cookie, &error_abort);
+    NBDClientRequest *owner;
     QEMU_LOCK_GUARD(&s->receive_mutex);
 
     while (true) {
@@ -437,10 +451,10 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
              * woken by whoever set s->reply.cookie (or never wait in this
              * yield). So, we should not wake it here.
              */
-            ind2 = COOKIE_TO_INDEX(s->reply.cookie);
-            assert(!s->requests[ind2].receiving);
+            owner = nbd_request_by_cookie(s, s->reply.cookie, &error_abort);
+            assert(!owner->receiving);
 
-            s->requests[ind].receiving = true;
+            req->receiving = true;
             qemu_co_mutex_unlock(&s->receive_mutex);
 
             qemu_coroutine_yield();
@@ -454,7 +468,7 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
              */
 
             qemu_co_mutex_lock(&s->receive_mutex);
-            assert(!s->requests[ind].receiving);
+            assert(!req->receiving);
             continue;
         }
 
@@ -474,17 +488,16 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
             error_setg(errp, "unexpected structured reply");
             goto err;
         }
-        ind2 = COOKIE_TO_INDEX(s->reply.cookie);
-        if (ind2 >= MAX_NBD_REQUESTS || !s->requests[ind2].coroutine) {
+        owner = nbd_request_by_cookie(s, s->reply.cookie, errp);
+        if (!owner) {
             ret = -EINVAL;
-            error_setg(errp, "unexpected cookie value");
             goto err;
         }
         if (s->reply.cookie == cookie) {
             /* We are done */
             return 0;
         }
-        nbd_recv_coroutine_wake_one(&s->requests[ind2]);
+        nbd_recv_coroutine_wake_one(owner);
     }
 
 err:
@@ -861,7 +874,6 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
 {
     ERRP_GUARD();
     int ret;
-    int i = COOKIE_TO_INDEX(cookie);
     void *local_payload = NULL;
     NBDStructuredReplyChunk *chunk;
 
@@ -919,8 +931,9 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
             return -EINVAL;
         }
 
-        return nbd_co_receive_offset_data_payload(s, s->requests[i].offset,
-                                                  qiov, errp);
+        return nbd_co_receive_offset_data_payload(
+                s, nbd_request_by_cookie(s, cookie, &error_abort)->offset,
+                qiov, errp);
     }
 
     if (nbd_reply_type_is_error(chunk->type)) {
@@ -1067,7 +1080,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
 
 break_loop:
     qemu_mutex_lock(&s->requests_lock);
-    s->requests[COOKIE_TO_INDEX(cookie)].coroutine = NULL;
+    nbd_request_by_cookie(s, cookie, &error_abort)->coroutine = NULL;
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
     qemu_mutex_unlock(&s->requests_lock);
-- 
2.43.0


