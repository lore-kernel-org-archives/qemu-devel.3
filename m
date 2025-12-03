Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70010D15D81
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoYY-0007dF-7t; Wed, 03 Dec 2025 10:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXZ-0006Si-Rs
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXX-0002j4-QS
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764774791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEW2UfNdED2lFgqYqppyNm5h6ZDcg1lFChiE7ZEFkO0=;
 b=Ou+dvqvtovuh5ppGwU8E81GWCun2mCt1L2ZwEtFTLD35nZ/kNt047U8dyVtFaF+jtlotEA
 b3BhKMDwRL7mFIYLwPuOL8mzf2lP02j8AhZsQg1zoJiEZjOANScR7SEf4e58Jv9WEytkrP
 sPv5IWYQTxn5LvmdyKcTt8LF1i8aSAY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-d4sxeehqM7W781voywBnUw-1; Wed,
 03 Dec 2025 10:13:06 -0500
X-MC-Unique: d4sxeehqM7W781voywBnUw-1
X-Mimecast-MFC-AGG-ID: d4sxeehqM7W781voywBnUw_1764774786
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D09D118002F9; Wed,  3 Dec 2025 15:13:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FC38180045B; Wed,  3 Dec 2025 15:13:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 6/6] vfio-user: recycle msg on failure
Date: Wed,  3 Dec 2025 16:12:49 +0100
Message-ID: <20251203151249.2707207-7-clg@redhat.com>
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

If we fail to read an incoming request, recycle the message.

Resolves: Coverity CID 1611807
Resolves: Coverity CID 1611808
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20251203100316.3604456-6-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/proxy.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index f2601eada5b9c8010e88bf4b3035a27811769b0d..314dfd23d8af385532bb87219fb3153961942cba 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -412,11 +412,22 @@ err:
     for (i = 0; i < numfds; i++) {
         close(fdp[i]);
     }
-    if (isreply && msg != NULL) {
-        /* force an error to keep sending thread from hanging */
-        vfio_user_set_error(msg->hdr, EINVAL);
-        msg->complete = true;
-        qemu_cond_signal(&msg->cv);
+    if (msg != NULL) {
+        if (msg->type == VFIO_MSG_REQ) {
+            /*
+             * Clean up the request message on failure. Change type back to
+             * NOWAIT to free.
+             */
+            msg->type = VFIO_MSG_NOWAIT;
+            vfio_user_recycle(proxy, msg);
+        } else {
+            /*
+             * Report an error back to the sender. Sender will recycle msg.
+             */
+            vfio_user_set_error(msg->hdr, EINVAL);
+            msg->complete = true;
+            qemu_cond_signal(&msg->cv);
+        }
     }
     return -1;
 }
-- 
2.52.0


