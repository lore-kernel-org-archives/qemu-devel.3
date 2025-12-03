Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4891D15D82
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoXZ-0006Sd-Rt; Wed, 03 Dec 2025 10:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXS-0006PH-6O
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXQ-0002gv-DJ
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764774782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7j8HPwlPgmD2dWkBQauOccHqwt+qXIUbXS9kUXiuamM=;
 b=QXuApEJ+OI6f5He/kpWXIJRwj2pTU/3B6J0Ha799n6er29LFcquyBNtAkhyIvoxcDEtvOt
 8Qlr8Su3yzGffFMOgQSdSBguM9u1g7nX8sBcVVajgIrpJX3zKSyPiou+3FtImF1b8KES4A
 SDoDlUA56n/Y8kZL6xWeN8iDH6u8x80=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-K1PTMHi7Pcq_8SLPLu9tBQ-1; Wed,
 03 Dec 2025 10:12:59 -0500
X-MC-Unique: K1PTMHi7Pcq_8SLPLu9tBQ-1
X-Mimecast-MFC-AGG-ID: K1PTMHi7Pcq_8SLPLu9tBQ_1764774778
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 133241956058; Wed,  3 Dec 2025 15:12:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 842DC180045B; Wed,  3 Dec 2025 15:12:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 2/6] vfio-user: simplify vfio_user_process()
Date: Wed,  3 Dec 2025 16:12:45 +0100
Message-ID: <20251203151249.2707207-3-clg@redhat.com>
In-Reply-To: <20251203151249.2707207-1-clg@redhat.com>
References: <20251203151249.2707207-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It can figure out if it's a reply by itself, rather than passing that
information in.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20251203100316.3604456-2-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/proxy.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index bbd7ec243d6533533b40b2417aff4651c6c140fd..75845d7c89ecbc2534c6f1e3271d6a0dfff8e5cb 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -147,8 +147,7 @@ VFIOUserFDs *vfio_user_getfds(int numfds)
 /*
  * Process a received message.
  */
-static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
-                              bool isreply)
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg)
 {
 
     /*
@@ -157,7 +156,7 @@ static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
      *
      * Requests get queued for the BH.
      */
-    if (isreply) {
+    if ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY) {
         msg->complete = true;
         if (msg->type == VFIO_MSG_WAIT) {
             qemu_cond_signal(&msg->cv);
@@ -187,7 +186,6 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
 {
     VFIOUserMsg *msg = proxy->part_recv;
     size_t msgleft = proxy->recv_left;
-    bool isreply;
     char *data;
     int ret;
 
@@ -214,8 +212,7 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
      */
     proxy->part_recv = NULL;
     proxy->recv_left = 0;
-    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
-    vfio_user_process(proxy, msg, isreply);
+    vfio_user_process(proxy, msg);
 
     /* return positive value */
     return 1;
@@ -381,7 +378,7 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         data += ret;
     }
 
-    vfio_user_process(proxy, msg, isreply);
+    vfio_user_process(proxy, msg);
     return 0;
 
     /*
-- 
2.52.0


