Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE18C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueCKY-000392-S8; Tue, 22 Jul 2025 08:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJU-0002O7-3g
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJN-0006L2-VG
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:42 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TAwT024411;
 Tue, 22 Jul 2025 12:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=ogUus
 Nb8abplo4/L0tdtqGz4oTrmEgBVtp4/Ei2IsC4=; b=ifLfv4BarK5GBAQVdLcPZ
 3NmJkpgWEK7lnRVGWFWqLe7Qfoj1gayYwMnXyXUhSwfODJClEmv683eVliv9THYl
 CPSAHABfD3hpj4/bEBYjsQbsHw6IsLjrOuD17S2Jb/GtIQXJQyQXy+SH8j9apF1r
 tKyQ3bxLV+XotWr1wXHcDRcEb3SqkBj2gtWNqqn1FlFomLux6J8HSHkWpYx+buJk
 pAMzv/UmKOh3FyhqeKUk31/JQT+ykmLFxpSDhfCX10cGfGa86QbxpeQj0F0V3KJS
 p+uFbNPG7fY0IGLeyUfpZbGS9X1lRwpqm/SagwrhciTon0Ay5BWSqU9wZOu9s06I
 Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057qw70x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56MBJr7g010262; Tue, 22 Jul 2025 12:41:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4801t99gc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:35 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56MCfT3v039536;
 Tue, 22 Jul 2025 12:41:34 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4801t99g9h-5; Tue, 22 Jul 2025 12:41:34 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com,
 eperezma@redhat.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 4/6] virtio-net: iter live migration - migrate vmstate
Date: Tue, 22 Jul 2025 12:41:25 +0000
Message-ID: <20250722124127.2497406-5-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250722124127.2497406-1-jonah.palmer@oracle.com>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220104
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=687f8700 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=sg1MOQW8EVPkchQJ_ukA:9
X-Proofpoint-ORIG-GUID: 3npKTO5TyU8r6hxB6GtgL0lawjxwGUWC
X-Proofpoint-GUID: 3npKTO5TyU8r6hxB6GtgL0lawjxwGUWC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwNCBTYWx0ZWRfX6e7mD6CalmPb
 1nnEy+r6LjZLk1AgytXyrd7W23J1NZiJeYLke6j1ZHl6yg+Sm4VWJfsfEDXpgamDvfiM0fGp+f5
 yN2bqDV4f+9/VRnRkNyTVlOE+bIXstHqZ70qzHOJPe698yYLcogApA5aHKtEzc60QP22aPZQ/Kw
 XdUjZ66MAZKLcOTbibOhAkf2gdVA+oDNDtzPE1GbRtFcPyDmfzQz85Hk+yZEhtSENCLr6mlwwEI
 ncw8XmGHuH3strrqcGKK5gNMFpZvdyI/rlJ3cCslpFiExs/ZQiSmhbZZss87NG4nl4nWUht1ZGn
 6L43GGaBHSZurqxsl8SdcSUbjMWh6sC4o5NXKM5XnCbTXNu+tlihRcF7mgVOrhXuh6z3oe1hFX+
 YXWZPPiUFKSDO3tQ49eZCXmga5XwAZesDaUghmYDZmK+Z5wkXP81zp0VnZBWP9LoSjNSeshq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Lays out the initial groundwork for iteratively migrating the state of a
virtio-net device, starting with its vmstate (via vmstate_save_state &
vmstate_load_state).

The original non-iterative vmstate framework still runs during the
stop-and-copy phase when the guest is paused, which is still necessary
to migrate over the final state of the virtqueues once the sourced has
been paused.

Although the vmstate framework is used twice (once during the iterative
portion and once during the stop-and-copy phase), it appears that
there's some modest improvement in guest-visible downtime when using a
virtio-net device.

When tracing the vmstate_downtime_save and vmstate_downtime_load
tracepoints, for a virtio-net device using iterative live migration, the
non-iterative downtime portion improved modestly, going from ~3.2ms to
~1.4ms:

Before:
-------
vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
  instance_id=0 downtime=3594

After:
------
vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
  instance_id=0 downtime=1607

This improvement is likely due to the initial vmstate_load_state call
(while the guest is still running) "warming up" all related pages and
structures on the destination. In other words, by the time the final
stop-and-copy phase starts, the heavy allocations and page-fault
latencies are reduced, making the device re-loads slightly faster and
the guest-visible downtime window slightly smaller.

Future patches could improve upon this by skipping the second
vmstate_save/load_state calls (during the stop-and-copy phase) and
instead only send deltas right before/after the source is stopped.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c            | 37 ++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h |  8 ++++++++
 2 files changed, 45 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 19aa5b5936..86a6fe5b91 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3808,16 +3808,31 @@ static bool virtio_net_is_active(void *opaque)
 
 static int virtio_net_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
+    VirtIONet *n = opaque;
+
+    qemu_put_be64(f, VNET_MIG_F_INIT_STATE);
+    vmstate_save_state(f, &vmstate_virtio_net, n, NULL);
+    qemu_put_be64(f, VNET_MIG_F_END_DATA);
+
     return 0;
 }
 
 static int virtio_net_save_live_iterate(QEMUFile *f, void *opaque)
 {
+    bool new_data = false;
+
+    if (!new_data) {
+        qemu_put_be64(f, VNET_MIG_F_NO_DATA);
+        return 1;
+    }
+
+    qemu_put_be64(f, VNET_MIG_F_END_DATA);
     return 1;
 }
 
 static int virtio_net_save_live_complete_precopy(QEMUFile *f, void *opaque)
 {
+    qemu_put_be64(f, VNET_MIG_F_NO_DATA);
     return 0;
 }
 
@@ -3833,6 +3848,28 @@ static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **errp)
 
 static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
 {
+    VirtIONet *n = opaque;
+    uint64_t flag;
+
+    flag = qemu_get_be64(f);
+    if (flag == VNET_MIG_F_NO_DATA) {
+        return 0;
+    }
+
+    while (flag != VNET_MIG_F_END_DATA) {
+        switch (flag) {
+        case VNET_MIG_F_INIT_STATE:
+        {
+            vmstate_load_state(f, &vmstate_virtio_net, n, VIRTIO_NET_VM_VERSION);
+            break;
+        }
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Uknown flag 0x%"PRIx64, __func__, flag);
+            return -EINVAL;
+        }
+
+        flag = qemu_get_be64(f);
+    }
     return 0;
 }
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index b9ea9e824e..d6c7619053 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -163,6 +163,14 @@ typedef struct VirtIONetQueue {
     struct VirtIONet *n;
 } VirtIONetQueue;
 
+/*
+ * Flags to be used as unique delimiters for virtio-net devices in the
+ * migration stream.
+ */
+#define VNET_MIG_F_INIT_STATE          (0xffffffffef200000ULL)
+#define VNET_MIG_F_END_DATA            (0xffffffffef200001ULL)
+#define VNET_MIG_F_NO_DATA             (0xffffffffef200002ULL)
+
 struct VirtIONet {
     VirtIODevice parent_obj;
     uint8_t mac[ETH_ALEN];
-- 
2.47.1


