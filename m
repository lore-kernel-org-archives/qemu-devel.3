Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C761C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 12:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trcB9-0006To-W5; Mon, 10 Mar 2025 08:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trcB1-0006Ga-L2
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trcAz-00056O-D2
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741609446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dwt1EUwNOdtOybw1UDYslyRkZzbPoiB/Rdx21wIxFBA=;
 b=IvX0R1z/X/QBCHvIZo37fhzcSQRS68oQq/Nv2DfeB58uVCn+cFg9Yew40SAXc6JuQxzDwd
 JPOnD8ZjCazKkp7w1mOEqfnq6zt3f//sKkwKevyz4j5orQWOQ1CVjIFbNCfVxHwVnDab8o
 RsG+SeUqZiQP2Zov9yLicxilCWJq21Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-q1wt-34SOm-Ak8g0yzbC5w-1; Mon,
 10 Mar 2025 08:22:57 -0400
X-MC-Unique: q1wt-34SOm-Ak8g0yzbC5w-1
X-Mimecast-MFC-AGG-ID: q1wt-34SOm-Ak8g0yzbC5w_1741609376
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AF841800259; Mon, 10 Mar 2025 12:22:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DAB01800370; Mon, 10 Mar 2025 12:22:52 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 2/5] net: move backend cleanup to NIC cleanup
Date: Mon, 10 Mar 2025 20:22:37 +0800
Message-ID: <20250310122240.2908-3-jasowang@redhat.com>
In-Reply-To: <20250310122240.2908-1-jasowang@redhat.com>
References: <20250310122240.2908-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
structures if peer nic is present") effectively delayed the backend
cleanup, allowing the frontend or the guest to access it resources as
long as the frontend is still visible to the guest.

However it does not clean up the resources until the qemu process is
over.  This causes an effective leak if the device is deleted with
device_del, as there is no way to close the vdpa device.  This makes
impossible to re-add that device to this or other QEMU instances until
the first instance of QEMU is finished.

Move the cleanup from qemu_cleanup to the NIC deletion and to
net_cleanup.

Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present")
Reported-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c        | 33 +++++++++++++++++++++++++++------
 net/vhost-vdpa.c |  8 --------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/net/net.c b/net/net.c
index 4eb78a1299..39d6f28158 100644
--- a/net/net.c
+++ b/net/net.c
@@ -428,7 +428,13 @@ void qemu_del_net_client(NetClientState *nc)
         object_unparent(OBJECT(nf));
     }
 
-    /* If there is a peer NIC, delete and cleanup client, but do not free. */
+    /*
+     * If there is a peer NIC, transfer ownership to it.  Delete the client
+     * from net_client list but do not cleanup nor free.  This way NIC can
+     * still access to members of the backend.
+     *
+     * The cleanup and free will be done when the NIC is free.
+     */
     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_NIC) {
         NICState *nic = qemu_get_nic(nc->peer);
         if (nic->peer_deleted) {
@@ -438,16 +444,13 @@ void qemu_del_net_client(NetClientState *nc)
 
         for (i = 0; i < queues; i++) {
             ncs[i]->peer->link_down = true;
+            QTAILQ_REMOVE(&net_clients, ncs[i], next);
         }
 
         if (nc->peer->info->link_status_changed) {
             nc->peer->info->link_status_changed(nc->peer);
         }
 
-        for (i = 0; i < queues; i++) {
-            qemu_cleanup_net_client(ncs[i], true);
-        }
-
         return;
     }
 
@@ -465,8 +468,12 @@ void qemu_del_nic(NICState *nic)
 
     for (i = 0; i < queues; i++) {
         NetClientState *nc = qemu_get_subqueue(nic, i);
-        /* If this is a peer NIC and peer has already been deleted, free it now. */
+        /*
+         * If this is a peer NIC and peer has already been deleted, clean it up
+         * and free it now.
+         */
         if (nic->peer_deleted) {
+            qemu_cleanup_net_client(nc->peer, false);
             qemu_free_net_client(nc->peer);
         } else if (nc->peer) {
             /* if there are RX packets pending, complete them */
@@ -1681,6 +1688,9 @@ void net_cleanup(void)
      * of the latest NET_CLIENT_DRIVER_NIC, and operate on *p as we walk
      * the list.
      *
+     * However, the NIC may have peers that trust to be clean beyond this
+     * point.  For example, if they have been removed with device_del.
+     *
      * The 'nc' variable isn't part of the list traversal; it's purely
      * for convenience as too much '(*p)->' has a tendency to make the
      * readers' eyes bleed.
@@ -1688,6 +1698,17 @@ void net_cleanup(void)
     while (*p) {
         nc = *p;
         if (nc->info->type == NET_CLIENT_DRIVER_NIC) {
+            NICState *nic = qemu_get_nic(nc);
+
+            if (nic->peer_deleted) {
+                int queues = MAX(nic->conf->peers.queues, 1);
+
+                for (int i = 0; i < queues; i++) {
+                    nc = qemu_get_subqueue(nic, i);
+                    qemu_cleanup_net_client(nc->peer, false);
+                }
+            }
+
             /* Skip NET_CLIENT_DRIVER_NIC entries */
             p = &QTAILQ_NEXT(nc, next);
         } else {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index bd01866878..f7a54f46aa 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -224,14 +224,6 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
 
-    /*
-     * If a peer NIC is attached, do not cleanup anything.
-     * Cleanup will happen as a part of qemu_cleanup() -> net_cleanup()
-     * when the guest is shutting down.
-     */
-    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_NIC) {
-        return;
-    }
     munmap(s->cvq_cmd_out_buffer, vhost_vdpa_net_cvq_cmd_page_len());
     munmap(s->status, vhost_vdpa_net_cvq_cmd_page_len());
     if (s->vhost_net) {
-- 
2.42.0


