Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFF9D15D81
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoYS-0007BF-Vh; Wed, 03 Dec 2025 10:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXY-0006Rv-2k
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXW-0002it-3i
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764774789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+yKALHb3uAN//fg1ALe7dyHhzyNtkmXWuzKRKk/KTU=;
 b=KZo1UMnXkrP3c0aGUDOe7+2tProrf+dnoxTqxdnxy9TD1/kMc8L5Ecnh546lmCO5hlhjDt
 tW8lYu9FRRfgUvXCu8M/FYA4l455xEBY0rR3XBmYOAPhFD9bKy1rNUYPnXG/9gfz+XW07T
 usBzzDCJE+mD1nQ9CJFOTMhmhxbkOxY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-uKdsIvmSM2aqJaOaubatdA-1; Wed,
 03 Dec 2025 10:13:04 -0500
X-MC-Unique: uKdsIvmSM2aqJaOaubatdA-1
X-Mimecast-MFC-AGG-ID: uKdsIvmSM2aqJaOaubatdA_1764774784
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1E241956062; Wed,  3 Dec 2025 15:13:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F5AA180044F; Wed,  3 Dec 2025 15:13:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 5/6] vfio-user: simplify vfio_user_recv_one()
Date: Wed,  3 Dec 2025 16:12:48 +0100
Message-ID: <20251203151249.2707207-6-clg@redhat.com>
In-Reply-To: <20251203151249.2707207-1-clg@redhat.com>
References: <20251203151249.2707207-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

This function was unnecessarily difficult to understand due to the
separate handling of request and reply messages. Use common code for
both where we can.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20251203100316.3604456-5-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/proxy.c | 68 +++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index e0f92025356fa9964434092cb0183128582a96c3..f2601eada5b9c8010e88bf4b3035a27811769b0d 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -281,15 +281,14 @@ static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
  */
 static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
 {
-    VFIOUserMsg *msg = NULL;
     g_autofree int *fdp = NULL;
-    VFIOUserFDs *reqfds;
-    VFIOUserHdr hdr;
+    VFIOUserMsg *msg = NULL;
     bool isreply = false;
-    int i, ret;
-    size_t msgleft, numfds = 0;
+    size_t msgleft = 0;
+    size_t numfds = 0;
     char *data = NULL;
-    char *buf = NULL;
+    VFIOUserHdr hdr;
+    int i, ret;
 
     /*
      * Complete any partial reads
@@ -317,8 +316,8 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     }
 
     /*
-     * For replies, find the matching pending request.
-     * For requests, reap incoming FDs.
+     * Find the matching request if this is a reply, or initialize a new
+     * server->client request.
      */
     if (isreply) {
         QTAILQ_FOREACH(msg, &proxy->pending, next) {
@@ -332,51 +331,44 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         }
         QTAILQ_REMOVE(&proxy->pending, msg, next);
 
-        /*
-         * Process any received FDs
-         */
-        if (numfds != 0) {
-            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
-                error_setg(errp, "unexpected FDs");
-                goto err;
-            }
-            msg->fds->recv_fds = numfds;
-            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
-        }
-    } else {
-        if (numfds != 0) {
-            reqfds = vfio_user_getfds(numfds);
-            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
-        } else {
-            reqfds = NULL;
-        }
-    }
-
-    /*
-     * Put the whole message into a single buffer.
-     */
-    if (isreply) {
         if (hdr.size > msg->rsize) {
             error_setg(errp, "reply larger than recv buffer");
             goto err;
         }
-        *msg->hdr = hdr;
-        data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        void *buf;
+
         if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
             error_setg(errp, "vfio_user_recv request larger than max");
             goto err;
         }
+
         buf = g_malloc0(hdr.size);
-        memcpy(buf, &hdr, sizeof(hdr));
-        data = buf + sizeof(hdr);
-        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg = vfio_user_getmsg(proxy, buf, NULL);
         msg->type = VFIO_MSG_REQ;
     }
 
+    *msg->hdr = hdr;
+    data = (char *)msg->hdr + sizeof(hdr);
+
+    if (numfds != 0) {
+        if (msg->type == VFIO_MSG_REQ) {
+            msg->fds = vfio_user_getfds(numfds);
+        } else {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(errp, "unexpected FDs in reply");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+        }
+
+        memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+    }
+
     /*
-     * Read rest of message.
+     * Read rest of message into the data buffer.
      */
+
     msgleft = hdr.size - sizeof(hdr);
     while (msgleft > 0) {
         ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
-- 
2.52.0


