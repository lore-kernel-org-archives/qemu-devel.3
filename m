Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17EE1098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aio-00031p-M9; Fri, 20 Mar 2026 10:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aik-00031W-K4
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:21:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aii-0007UE-8F
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:21:02 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8YgqW2601043; Fri, 20 Mar 2026 14:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=6Tfha
 /Vo501llrdOlIhu+ARsJApYqvEGj9lM2fvEUW8=; b=b7UkA9NdSekd+p05fb8Pz
 zWPxU6NJvufuT4FRC6/7JCrma1iLn/DlDVOUQiN89cKWkaWfBw0jNbKw3sjqwsH3
 Yr5I09L5N+9FdFwOflkZ7ohSgXd8Coz0BIOqKPOgBd+azLOqwBqvuP7tmUdzzuNG
 BInEFCp8LKX0UB6FyezEqso8CbJeE/vij0cOuqh7iBxAZMvKvhPotJ5/ERymJl1k
 ymqRtbn28WLjMfEiDmg0Z7fdmLaIJgoW3nsPAytRAjzAjjjmrcWdWclIUcQo6wu7
 IS8WZIVorVS9CuwazeOpyLyP7ryuQ6ld+lwKpraz1J55CdjAtDeVBdy+YvaHlCdr
 w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x9ths-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KECGLx030539; Fri, 20 Mar 2026 14:20:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb4bu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jv016730;
 Fri, 20 Mar 2026 14:20:42 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-14; Fri, 20 Mar 2026 14:20:42 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 13/14] virtio-net: detect pending Tx work for VQs
 mid-migration changes
Date: Fri, 20 Mar 2026 14:20:14 +0000
Message-ID: <20260320142015.3856652-14-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320142015.3856652-1-jonah.palmer@oracle.com>
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200114
X-Proofpoint-GUID: wQDeG2q5OHHnuZKdANF8J9E1PqO_WmSt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfX4mmqkJ8VZ4j+
 SzevoOjpCoAI2/JWWsdIb5xrGAVbB5JfkpHoVtOzPXzDpExt1B1Tp1rJT1j1I3iaxLdDAefH3C8
 FIucKRIT76GPHME+XT4p9OosVqw81NPO6ho+k6/ZzFvfVU8uCOroNpSN4ZmTiSR1jwpqk6uBl+1
 MmAYxNC3jSbiHUm8aUcP6iNfHOzMV8oI7NXDyD+trUWTD8EPXNhtRvTEsHxFaDrMnj7BiiVYZ9A
 wK76Gmm4TqKgOHM1MPvXMD4h/XVGJkynYLmfJgjn7HQHZLcjxWo+aRVQRTnmyR9YWfWhKmA7iya
 q5Z04slLsNyecb4Tqs/1VICrnjqqm781MLNExVLOT5+9YQ9G0opS4BZKNGzTPowceXtSdi5wagd
 gj07EFxMTwcWnlrDtH+qFAan185k3abwOHA8BrnEXUmYcmoC5d1eOZRrk3E2OQx27CU/WvDyB7A
 qls8wXVyQNgj6X5PEsg==
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69bd57bc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=PoidfZ1iDD9ysA-sajAA:9
X-Proofpoint-ORIG-GUID: wQDeG2q5OHHnuZKdANF8J9E1PqO_WmSt
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Track per-queue pending Tx work state during early migration time.

This includes a snapshot of pending Tx state for active queue pairs,
checking for deltas at the end of migration, and freeing the snapshot
buffer during device unrealize.

With this final delta signal in place, drop the temporary always-true
fallback in virtio_net_has_delta and return false when no deltas are
found.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c            | 26 +++++++++++++++++++++-----
 include/hw/virtio/virtio-net.h |  2 ++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3ee49a043a..483a43be4f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3943,6 +3943,14 @@ static int virtio_net_early_pre_save(void *opaque)
     vnet_mig->mq_early = n->multiqueue;
     vnet_mig->queue_pairs_early = n->curr_queue_pairs;
 
+    /* Tx waiting snapshot for active queue pairs */
+    if (!vnet_mig->tx_waiting_early) {
+        vnet_mig->tx_waiting_early = g_new0(uint32_t, n->max_queue_pairs);
+    }
+    for (int i = 0; i < n->curr_queue_pairs; i++) {
+        vnet_mig->tx_waiting_early[i] = n->vqs[i].tx_waiting;
+    }
+
     /* RSS state snapshot */
     vnet_mig->rss_enabled_early = n->rss_data.enabled;
     vnet_mig->rss_redirect_early = n->rss_data.redirect;
@@ -4254,6 +4262,8 @@ static void virtio_net_device_unrealize(DeviceState *dev)
         n->migration->mtable_macs_early = NULL;
         g_free(n->migration->vlans_early);
         n->migration->vlans_early = NULL;
+        g_free(n->migration->tx_waiting_early);
+        n->migration->tx_waiting_early = NULL;
         g_free(n->migration->rss_indirections_table_early);
         n->migration->rss_indirections_table_early = NULL;
         g_free(n->migration);
@@ -4412,6 +4422,16 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
         return true;
     }
 
+    /* Has any active queue's tx_waiting changed? */
+    if (!vnet_mig->tx_waiting_early) {
+        return true;
+    }
+    for (int i = 0; i < n->curr_queue_pairs; i++) {
+        if (n->vqs[i].tx_waiting != vnet_mig->tx_waiting_early[i]) {
+            return true;
+        }
+    }
+
     /* Has the VirtIONet's RSS state changed? */
     if (n->rss_data.enabled != vnet_mig->rss_enabled_early ||
         n->rss_data.redirect != vnet_mig->rss_redirect_early ||
@@ -4439,11 +4459,7 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
         }
     }
 
-    /*
-     * Always return true for now until we're able to detect all possible
-     * changes to a VirtIONet device.
-     */
-    return true;
+    return false;
 }
 
 static bool virtio_net_needed(void *opaque)
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 88074a0976..dbbacc83bb 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -180,6 +180,7 @@ typedef struct VirtIONetQueue {
  * @guest_offloads_early: Guest offloads snapshot.
  * @mq_early: Multiqueue state snapshot.
  * @queue_pairs_early: Queue pairs snapshot.
+ * @tx_waiting_early: Per-queue pending-Tx snapshot.
  * @rss_enabled_early: RSS enabled flag.
  * @rss_redirect_early: RSS redirect flag.
  * @rss_populate_hash_early: RSS populate hash flag.
@@ -201,6 +202,7 @@ typedef struct VirtIONetMigration {
     uint64_t guest_offloads_early;
     int mq_early;
     uint16_t queue_pairs_early;
+    uint32_t *tx_waiting_early;
     bool rss_enabled_early;
     bool rss_redirect_early;
     bool rss_populate_hash_early;
-- 
2.51.0


