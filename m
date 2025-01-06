Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93982E77199
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 15:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUpUG-0001Pw-Mr; Mon, 06 Jan 2025 10:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tUpUD-0001Oc-MZ; Mon, 06 Jan 2025 10:57:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tUpUB-0000ys-VO; Mon, 06 Jan 2025 10:57:49 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506EtnCh021905;
 Mon, 6 Jan 2025 15:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=+l3BegQC2et9jox+ySKJLE3pOigeHiqg5BztLGOc8Dc=; b=
 ilWwDKhihdH/RLbidiX+N3DNtOZlk1V1BVl8yqAljAQokfgFakXXHIg1E05/mvNz
 JsfdMi0HFA1ef+7zljcmNCrt8S/NivKi+9KaI38jnGfEnoslDlLh/d+CLDL7pj8R
 fNUxM4rdEJ9LRPx20rA3xqPoh8KVIh+cGg7LVnhL09MtSP1/oONPjrne9zT1A/Ll
 zMrbqOHGr2jPPvlIAs9DUOWBnsXZe+RTqKm+kly3uLpYmI77UhXyzi6QC/nV+a5Q
 CnKxiOo5EBD9xM0yLyYQUc9+a3L8bKimccmmNmVGy9LbGd+uGDc3gXNfy1badKHT
 zVCCGvZ2MEcwJXVkNUpxLw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhsjjqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2025 15:57:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 506F5hw2027471; Mon, 6 Jan 2025 15:57:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xue7nw50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2025 15:57:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 506FvegH016161;
 Mon, 6 Jan 2025 15:57:44 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-185-77.vpn.oracle.com
 [10.65.185.77])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 43xue7nw2a-3; Mon, 06 Jan 2025 15:57:44 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: dtatulea@nvidia.com, mcoqueli@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, qemu-stable@nongnu.org, leiyang@redhat.com,
 anisinha@redhat.com
Subject: [PATCH v3 2/2] net: move backend cleanup to NIC cleanup
Date: Mon,  6 Jan 2025 10:57:35 -0500
Message-ID: <20250106155737.976977-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250106155737.976977-1-jonah.palmer@oracle.com>
References: <20250106155737.976977-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060140
X-Proofpoint-GUID: XUwaSb-o1KIcZgjDR6IFPf63BhcTOhzH
X-Proofpoint-ORIG-GUID: XUwaSb-o1KIcZgjDR6IFPf63BhcTOhzH
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.369,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
---
 net/net.c        | 33 +++++++++++++++++++++++++++------
 net/vhost-vdpa.c |  8 --------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/net/net.c b/net/net.c
index 07d760569b..8ffaaa4a13 100644
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
@@ -1680,6 +1687,9 @@ void net_cleanup(void)
      * of the latest NET_CLIENT_DRIVER_NIC, and operate on *p as we walk
      * the list.
      *
+     * However, the NIC may have peers that trust to be clean beyond this
+     * point.  For example, if they have been removed with device_del.
+     *
      * The 'nc' variable isn't part of the list traversal; it's purely
      * for convenience as too much '(*p)->' has a tendency to make the
      * readers' eyes bleed.
@@ -1687,6 +1697,17 @@ void net_cleanup(void)
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
index 231b45246c..7195d340a0 100644
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
2.43.5


