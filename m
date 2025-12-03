Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B93D15D81
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoXo-0006ZB-5n; Wed, 03 Dec 2025 10:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXU-0006R5-Vh
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXT-0002iM-0x
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764774786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uql2Jh14ZIvD6Dx37oJvoRnNNVQg7ZfR9OxHHYcrW6M=;
 b=jLucwjuhO0xgaciVsG0uDUsJubFh2gOfQ9cSOEgxcRFF4j7C9LJqnZjfwZgD5MaAdphbME
 mE7Ce5p2aymu/vJkDoU2mWIvJiZQfr4RoegO/Z4jtsmAqnTVJJHtRNPOtcvw9sg1fWENfM
 IJaTzx7zQqQt3udpRWTAdaC6XPUyDtI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-0sPQuzvZOd2n4yUCludUOg-1; Wed,
 03 Dec 2025 10:13:02 -0500
X-MC-Unique: 0sPQuzvZOd2n4yUCludUOg-1
X-Mimecast-MFC-AGG-ID: 0sPQuzvZOd2n4yUCludUOg_1764774781
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7D0018002C1; Wed,  3 Dec 2025 15:13:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A23421800577; Wed,  3 Dec 2025 15:13:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/6] vfio-user: refactor out header handling
Date: Wed,  3 Dec 2025 16:12:47 +0100
Message-ID: <20251203151249.2707207-5-clg@redhat.com>
In-Reply-To: <20251203151249.2707207-1-clg@redhat.com>
References: <20251203151249.2707207-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Simplify vfio_user_recv_one() by moving the header handling out to a
helper function.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251203100316.3604456-4-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/proxy.c | 101 +++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 41 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 82c76c66654a1b7e03b281bdac5f602846b33ac6..e0f92025356fa9964434092cb0183128582a96c3 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -218,6 +218,61 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
     return 1;
 }
 
+static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
+                              VFIOUserHdr *hdr, int **fdp, size_t *numfdp,
+                              bool *isreply)
+{
+    struct iovec iov = {
+        .iov_base = hdr,
+        .iov_len = sizeof(*hdr),
+    };
+    int ret;
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, fdp, numfdp, 0,
+                                 errp);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "failed to read header");
+        return -1;
+    } else if (ret == 0) {
+        error_setg(errp, "failed to read header: EOF");
+        return -1;
+    } else if (ret < sizeof(*hdr)) {
+        error_setg(errp, "short read of header");
+        return -1;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr->size < sizeof(*hdr)) {
+        error_setg(errp, "bad header size");
+        return -1;
+    }
+
+    switch (hdr->flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        *isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        *isreply = true;
+        break;
+    default:
+        error_setg(errp, "unknown message type");
+        return -1;
+    }
+
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr->id, hdr->command, hdr->size,
+                             hdr->flags);
+    return 0;
+}
+
 /*
  * Receive and process one incoming message.
  *
@@ -230,10 +285,6 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     g_autofree int *fdp = NULL;
     VFIOUserFDs *reqfds;
     VFIOUserHdr hdr;
-    struct iovec iov = {
-        .iov_base = &hdr,
-        .iov_len = sizeof(hdr),
-    };
     bool isreply = false;
     int i, ret;
     size_t msgleft, numfds = 0;
@@ -257,45 +308,13 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         /* else fall into reading another msg */
     }
 
-    /*
-     * Read header
-     */
-    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
-                                 errp);
-    if (ret == QIO_CHANNEL_ERR_BLOCK) {
-        return ret;
-    }
-
-    /* read error or other side closed connection */
-    if (ret <= 0) {
-        goto fatal;
-    }
-
-    if (ret < sizeof(hdr)) {
-        error_setg(errp, "short read of header");
-        goto fatal;
-    }
-
-    /*
-     * Validate header
-     */
-    if (hdr.size < sizeof(VFIOUserHdr)) {
-        error_setg(errp, "bad header size");
-        goto fatal;
-    }
-    switch (hdr.flags & VFIO_USER_TYPE) {
-    case VFIO_USER_REQUEST:
-        isreply = false;
-        break;
-    case VFIO_USER_REPLY:
-        isreply = true;
-        break;
-    default:
-        error_setg(errp, "unknown message type");
+    ret = vfio_user_recv_hdr(proxy, errp, &hdr, &fdp, &numfds, &isreply);
+    if (ret < 0) {
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
         goto fatal;
     }
-    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
-                             hdr.flags);
 
     /*
      * For replies, find the matching pending request.
-- 
2.52.0


