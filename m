Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C32C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURdA-0008OC-D9; Mon, 29 Jan 2024 08:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rURd3-0008NP-CP
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rURcz-0004dP-Ig
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706534656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEY/03v+aSw42tIRGuHD6+WMpVoHm4K6M49mhh/iPpw=;
 b=FPviiG/vBuZqetAseT++sDo8Qm4CTBmCTPjhJX0yLH4EuBS4cLuX+LOGb+ernLZbOO7GAl
 u8iDbMnl18vG3GHzwz2S2euC1vX/GWu56QFB2qlXtFq6OdhCCW92Y0B1y1sy4FYrB47ux2
 8kyNeyKeObBQbMQoBLM8XVhkDnaZ350=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-FBVqc_YOMgW6oLj1xT54Hw-1; Mon,
 29 Jan 2024 08:24:15 -0500
X-MC-Unique: FBVqc_YOMgW6oLj1xT54Hw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA7763CBDF60;
 Mon, 29 Jan 2024 13:24:14 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65AC1488;
 Mon, 29 Jan 2024 13:24:13 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: si-wei.liu@oracle.com, leiyang@redhat.com, yajunw@nvidia.com,
 Ani Sinha <anisinha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 dtatulea@nvidia.com, mcoqueli@redhat.com
Subject: [PATCH 2/2] net: move backend cleanup to NIC cleanup
Date: Mon, 29 Jan 2024 14:24:07 +0100
Message-Id: <20240129132407.1474202-3-eperezma@redhat.com>
In-Reply-To: <20240129132407.1474202-1-eperezma@redhat.com>
References: <20240129132407.1474202-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move the cleanup from qemu_cleanup to the NIC deletion.

Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present")
Acked-by: Jason Wang <jasowang@redhat.com>
Reported-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
Carring the Acked-by Jason as it was given when I proposed this one year
ago to qemu-security@nongnu.org off list, trying to solve CVE-2023-3301.
---
 net/net.c        | 19 +++++++++++++------
 net/vhost-vdpa.c |  8 --------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/net.c b/net/net.c
index 11e19d3bed..fb6e130c62 100644
--- a/net/net.c
+++ b/net/net.c
@@ -422,7 +422,13 @@ void qemu_del_net_client(NetClientState *nc)
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
@@ -432,16 +438,13 @@ void qemu_del_net_client(NetClientState *nc)
 
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
 
@@ -459,8 +462,12 @@ void qemu_del_nic(NICState *nic)
 
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
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3726ee5d67..64825136a3 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -221,14 +221,6 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
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
2.39.3


