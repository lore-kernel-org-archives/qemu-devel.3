Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219FACA0FE5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk0FK-0007WM-Bi; Fri, 30 Aug 2024 07:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sk0FE-0007KQ-Or
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:56:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sk0FD-0002s0-4L
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:56:48 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U7tVQT014580;
 Fri, 30 Aug 2024 11:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=GDzThzEZjoZ6r7+i+SAGovwAeyGq4pC0eUTNr/TivRk=; b=
 K7qCk4///GOcVFvAwvOu6Qi2SKIDsLtHnBOvIdIEk7DELo/n9UEC0NZmgKYtVYHX
 CBvSXaaTsqeaoVoDGRvsQ0G5d30dkLDfpwbV+gvUGpHSqgvsGQk1YXUKySMsV+AC
 mdT18N3S+zWpK3xnzoXiMQvKlRof0+N41Fik60jDtm6YC7IYvKUqf2nJWkIlZ6FW
 lb/kX1dkJS2OSf6eSS1f+8twwcOO4NOsoeepYlFLiEydUcLeISEgLF+1PPh3sq67
 u2Y8tAQ26EYfVO52UAFhPti9LpxgSpuJNZd3DkYsy74OLKjZvMUgXMaSHf/eniiF
 MXS3kliRe5PbuXERHuFS1A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugxg1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 11:56:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47UAv4Rk036491; Fri, 30 Aug 2024 11:56:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4189jpg9eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 11:56:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47UBucxS028887;
 Fri, 30 Aug 2024 11:56:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4189jpg9ae-7; Fri, 30 Aug 2024 11:56:44 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Euan Turner <euan.turner@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 6/6] tap: postload fix for cpr
Date: Fri, 30 Aug 2024 04:56:37 -0700
Message-Id: <1725018997-363706-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1725018997-363706-1-git-send-email-steven.sistare@oracle.com>
References: <1725018997-363706-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300090
X-Proofpoint-GUID: 5Bzsy_u5n_DDYWkv1Pcif_Yx3eeg_gXv
X-Proofpoint-ORIG-GUID: 5Bzsy_u5n_DDYWkv1Pcif_Yx3eeg_gXv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

After cpr-exec of a multi-queue NIC, if any queues are unused, then
the corresponding tap is marked enabled in userland, but it is disabled
in the kernel for the fd that was preserved across exec.  One cannot call
tap_disable() during postload, because that eventually calls
IFF_DETACH_QUEUE, which fails because the queue is already detached.
Define tap_disable_postload to avoid IFF_DETACH_QUEUE.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/net/virtio-net.c | 20 ++++++++++++++++++++
 include/net/tap.h   |  1 +
 net/tap.c           | 17 +++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 8f30972..8dc0a02 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -728,6 +728,25 @@ static int peer_detach(VirtIONet *n, int index)
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
+    if (mode == MIG_MODE_CPR_EXEC || mode == MIG_MODE_CPR_TRANSFER) {
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
@@ -3056,6 +3075,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
      */
     n->saved_guest_offloads = n->curr_guest_offloads;
 
+    virtio_net_postload_queue_pairs(n);
     virtio_net_set_queue_pairs(n);
 
     /* Find the first multicast entry in the saved MAC filter */
diff --git a/include/net/tap.h b/include/net/tap.h
index 5d58551..9456abe 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -30,6 +30,7 @@
 
 int tap_enable(NetClientState *nc);
 int tap_disable(NetClientState *nc);
+void tap_disable_postload(NetClientState *nc);
 
 int tap_get_fd(NetClientState *nc);
 
diff --git a/net/tap.c b/net/tap.c
index 4d57a53..abc4994 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -1060,3 +1060,20 @@ int tap_disable(NetClientState *nc)
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
+    if (s->enabled == 0) {
+        return;
+    } else {
+        s->enabled = false;
+        tap_update_fd_handler(s);
+    }
+}
-- 
1.8.3.1


