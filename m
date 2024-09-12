Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A3AEED617
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 16:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1son5V-0002Ld-An; Thu, 12 Sep 2024 12:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1son5R-00029r-Ny
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1son5Q-0000Sc-2r
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726160067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2xNoKaAcmCj7OrOKmudvGTJcmTVIkiqTYlCh9phBBI=;
 b=WJ425wk9BUMPA3x4T2w9oXwQigeKe/NbWG/gO+PZ/RRA+rIU2GUvwW/HVSqDKctHS4rkBx
 RXzDOdGiIs7+m34yWMSmDCqLviindg4OsNeRE9JUERaYtR0wyFbU9c+H8g+yuMWrlA2sTY
 7RoYNz0uALqe6zeI1f0g1aUKvnBiVkA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-3BGCAJJAPAmQ3k3B_K3peQ-1; Thu,
 12 Sep 2024 12:54:24 -0400
X-MC-Unique: 3BGCAJJAPAmQ3k3B_K3peQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D72D1956048; Thu, 12 Sep 2024 16:54:23 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.192.146])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B06C1956053; Thu, 12 Sep 2024 16:54:19 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
Cc: dtatulea@nvidia.com, mcoqueli@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, qemu-stable@nongnu.org, leiyang@redhat.com,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 2/2] net: move backend cleanup to NIC cleanup
Date: Thu, 12 Sep 2024 18:54:08 +0200
Message-ID: <20240912165408.234447-3-eperezma@redhat.com>
In-Reply-To: <20240912165408.234447-1-eperezma@redhat.com>
References: <20240912165408.234447-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
v2: Remove NIC peer also at net_cleanup. vhost-user trust all the
backends are clean before qemu removes char devices.

This is not a requisite introduced by this commit as
system/runstate.c:qemu_cleanup shows.
---
 net/net.c        | 33 +++++++++++++++++++++++++++------
 net/vhost-vdpa.c |  8 --------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/net/net.c b/net/net.c
index 9f96509b2a..d097ac3e74 100644
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
@@ -1686,6 +1693,9 @@ void net_cleanup(void)
      * of the latest NET_CLIENT_DRIVER_NIC, and operate on *p as we walk
      * the list.
      *
+     * However, the NIC may have peers that trust to be clean beyond this
+     * point.  For example, if they have been removed with device_del.
+     *
      * The 'nc' variable isn't part of the list traversal; it's purely
      * for convenience as too much '(*p)->' has a tendency to make the
      * readers' eyes bleed.
@@ -1693,6 +1703,17 @@ void net_cleanup(void)
     while (*p) {
         nc = *p;
         if (nc->info->type == NET_CLIENT_DRIVER_NIC) {
+            NICState *nic = qemu_get_nic(nc);
+
+            if (nic->peer_deleted) {
+                int queues = MAX(nic->conf->peers.queues, 1);
+
+                for (int i = 0; i < queues; i++) {
+                    NetClientState *nc = qemu_get_subqueue(nic, i);
+                    qemu_cleanup_net_client(nc->peer, false);
+                }
+            }
+
             /* Skip NET_CLIENT_DRIVER_NIC entries */
             p = &QTAILQ_NEXT(nc, next);
         } else {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 46b02c50be..e1a1c91e48 100644
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
2.46.0


