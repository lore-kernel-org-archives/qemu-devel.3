Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C391FC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVSy-00077c-At; Thu, 17 Jul 2025 16:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW7-0008Vw-VB
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW4-00009N-RO
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:39 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0i1e027515;
 Thu, 17 Jul 2025 18:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=ajpWdz5Bmpx9vi2dQrGhELIFN7Sz7KP+mHjix1dvIRM=; b=
 KeO7OyGca/Pi3e68bfrkDLFXaayViawjl0tluXyxAlVCdJzn7/Ev6BiJTPpj8+iv
 ywoTZvwmM64MQLFWlnahGTnunmyoS4BNICIwEiSppfOCn3jw3Ke1hAkaXn3Nyb07
 GKxEYe6R3xaTjMXpIZm/C1L3ezSQVpDA1Qe/QmgNOQG3rhmuAp8vijaHdw6Nzv++
 xCCoY8N5XlKm03i7tHyIDgGSEdhERtb7T8kD1QXQYhejD4WE9xRvcq1f2tRZ0v++
 f701JdhHYj2XS1eGXNBJ1DAyaxEp0onU+gV1Zgk9jE5kispXU60HMHjIhCj8k7Vd
 rF+Pqj+lYPORL8HSPg9j3Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b3s4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56HHVq5L024538; Thu, 17 Jul 2025 18:39:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5d2tbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:34 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HIcoix007425;
 Thu, 17 Jul 2025 18:39:33 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5d2t8q-9; Thu, 17 Jul 2025 18:39:33 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V2 8/8] tap: postload fix for cpr
Date: Thu, 17 Jul 2025 11:39:28 -0700
Message-Id: <1752777568-236368-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2NSBTYWx0ZWRfX8yw7Qvt04cTg
 w0NRc1ZQ1aewDLz6o9Za3EIer+LYPX3MsWwFPlppMW8LslOOKSAZO8Ssrz3CzZOAaGyYYRIQl0d
 alMcT5d3AwkrzmYz3n/To33U8woOvE9MVHaoH3ZtvNUCnUxb+7HBMW2qF9zBAtg60VQJrDJgLcP
 Q8p8mU8soTZrDfyDjdWbZGmmd1XtLy6KiFeAH6Xg9BXInx+7Bpv7Tu1B2yJew5uVW/uRmpnAcXv
 x4sMgqCETlSDWs+4tmbb3MUfJF3WPAZTdTHkmxgqnEUc1PIEWR3WVu/hZDzOYaEg+6r3SMsAGyC
 CiAJX+RI5OI+oeGQUIM+yUc7gDXKnUd+QQisoARynng2YXDJ+r7Gxa7Uv1QChBy6uedDxQqsd/s
 uGaBUlKMAz1fEcNlT/EVDDdOQCP3/yJElCxEbIylZuUtsCFg1cwreVHJk3OBrMRIh37kynMK
X-Proofpoint-GUID: R1-d_nKOJJzgfFpRDfkSB2ofKPXPCWUf
X-Proofpoint-ORIG-GUID: R1-d_nKOJJzgfFpRDfkSB2ofKPXPCWUf
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68794367 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=h1OFwVCXqnWUJWdIchYA:9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

After cpr of a multi-queue NIC, if any queues are unused, then the
corresponding tap is marked enabled in userland, but it is disabled in the
kernel for the fd that was preserved.  One cannot call tap_disable() during
postload, because that eventually calls IFF_DETACH_QUEUE, which fails
because the queue is already detached.  Define tap_disable_postload to
avoid IFF_DETACH_QUEUE.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/net/tap.h   |  1 +
 hw/net/virtio-net.c | 20 ++++++++++++++++++++
 net/tap-win32.c     |  5 +++++
 net/tap.c           | 17 +++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/include/net/tap.h b/include/net/tap.h
index 5d58551..9456abe 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -30,6 +30,7 @@
 
 int tap_enable(NetClientState *nc);
 int tap_disable(NetClientState *nc);
+void tap_disable_postload(NetClientState *nc);
 
 int tap_get_fd(NetClientState *nc);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index eb93607..b45128e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -730,6 +730,25 @@ static int peer_detach(VirtIONet *n, int index)
     return tap_disable(nc->peer);
 }
 
+/*
+ * Set the disabled flag on unused queue pairs after vmstate load, without
+ * calling IFF_DETACH_QUEUE, which fails because the queue is already detached.
+ */
+static void virtio_net_postload_queue_pairs(VirtIONet *n)
+{
+    int i;
+    MigMode mode = migrate_mode();
+
+    if (mode == MIG_MODE_CPR_TRANSFER) {
+        for (i = n->curr_queue_pairs; i < n->max_queue_pairs; i++) {
+            NetClientState *nc = qemu_get_subqueue(n->nic, i);
+            if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_TAP) {
+                tap_disable_postload(nc->peer);
+            }
+        }
+    }
+}
+
 static void virtio_net_set_queue_pairs(VirtIONet *n)
 {
     int i;
@@ -3106,6 +3125,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
      */
     n->saved_guest_offloads = n->curr_guest_offloads;
 
+    virtio_net_postload_queue_pairs(n);
     virtio_net_set_queue_pairs(n);
 
     /* Find the first multicast entry in the saved MAC filter */
diff --git a/net/tap-win32.c b/net/tap-win32.c
index 671dee9..66be7c9 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -771,3 +771,8 @@ int tap_disable(NetClientState *nc)
 {
     abort();
 }
+
+void tap_disable_postload(NetClientState *nc)
+{
+    abort();
+}
diff --git a/net/tap.c b/net/tap.c
index 6a12751..c7f9023 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -1079,3 +1079,20 @@ int tap_disable(NetClientState *nc)
         return ret;
     }
 }
+
+/*
+ * On cpr restart, the tap is marked enabled in userland, but it might be
+ * disabled in the kernel, and IFF_DETACH_QUEUE will fail because it is
+ * already detached.  This function disables without calling IFF_DETACH_QUEUE.
+ */
+void tap_disable_postload(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    if (!s->cpr || s->enabled == 0) {
+        return;
+    } else {
+        s->enabled = false;
+        tap_update_fd_handler(s);
+    }
+}
-- 
1.8.3.1


