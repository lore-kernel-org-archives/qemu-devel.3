Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BC31098789
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ail-00031o-Te; Fri, 20 Mar 2026 10:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aij-00031S-W5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:21:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aii-0007U9-7t
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:21:01 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8Y1Pq3254709; Fri, 20 Mar 2026 14:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=4IRZN
 sKOEQvEBxuGoSOEPinbP8pM41l95Q7Te63ES10=; b=mh1vuPJm531wFxjKRID2R
 aybWQIJXrbU6WRJIxmTNeug8jQoh4sTDbBjC+rusAY/tlZ361vjpFtPVsBrnnW43
 KsFvGdAtlctZW+Zla+bZF3XU1CA4fjAqW/XxG2GnatOKelq84jcCJl/AMt9rFbtl
 BFdCnOClbCSomE1uSNuL6HzNmYtAf6G1ibmcAnSpl7cQOf5HzXzKL8w+vsz1HlWZ
 2+bAhd99uEUTNi+SNEyZOWw67JzwvKqqQhpBmg5PQBR+tEFHLaB1A4m0r8cFvAel
 Kx+8njbH62GU/o6E5KE9Xpx7Wo0BX+kA46lEZ6rCHbEV9uSYNvuXyi+Ea0kJppYp
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj69pcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:42 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KDO8G5030461; Fri, 20 Mar 2026 14:20:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb4ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jt016730;
 Fri, 20 Mar 2026 14:20:41 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-13; Fri, 20 Mar 2026 14:20:41 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 12/14] virtio-net: detect RSS state mid-migration changes
Date: Fri, 20 Mar 2026 14:20:13 +0000
Message-ID: <20260320142015.3856652-13-jonah.palmer@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69bd57ba b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=xolrWOXZR5NoubjuY-4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfXwa+KQBMeCwwq
 Xq+pA2+mHa0nT+59CbDeNpONOY2qvkrp40jx23p9Kej/LoCMprboF3g6nXPffMNdxDfEojQtYOA
 C9w4IB3eCAojpkYO57yAKO0mmcwK/N+s/T4YsUKGmgF4yc5/rNravsxzQ59t3wsdNVdRMLH41ZB
 4fi8Xdu2OoVKm2D4cnjLTHx9evaelrXLXei8l5O0fA8t2v/0e9m+2I7uIDlL6aXHIrN43KJtZhf
 8OlmvDH/s0kC3pqIdLAnXTz+YP5pya0zXGqOpoaYDsXEy3HQ9VKnaDJOQwR+Rv/ldHEFnpg3YeI
 pqtfWB1yXzCzcRORf9c+YJ1RRrZSh37V31xPCysWhxbyDp4eFDTTFMjdcPQNO6xyVfDSNDVJP3I
 SVHjFIXx+ley4Tx1EdHBJoHcfwhcFi4CkJ/YsJbQF6yI7O91+MTqRkClm91/2LYku1HGswDTAoO
 SbSNfBie74CPw+8hbIw==
X-Proofpoint-GUID: WEvD-XYFaP69R0WpIVs1TLY38zLpbKrt
X-Proofpoint-ORIG-GUID: WEvD-XYFaP69R0WpIVs1TLY38zLpbKrt
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

Save the current RSS state at early migration time to compare with
later during the stop-and-copy phase.

Only the RSS state that can change mid-migration is tracked.

RSS fields derived from backend capability/feature negotiation (for
example software-RSS capability flags and supported/peer hash capability
metadata) are intentionally excluded from delta checks.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c            | 50 ++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h | 16 +++++++++++
 2 files changed, 66 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2c0b42debb..3ee49a043a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3943,6 +3943,27 @@ static int virtio_net_early_pre_save(void *opaque)
     vnet_mig->mq_early = n->multiqueue;
     vnet_mig->queue_pairs_early = n->curr_queue_pairs;
 
+    /* RSS state snapshot */
+    vnet_mig->rss_enabled_early = n->rss_data.enabled;
+    vnet_mig->rss_redirect_early = n->rss_data.redirect;
+    vnet_mig->rss_populate_hash_early = n->rss_data.populate_hash;
+    vnet_mig->rss_runtime_hash_types_early = n->rss_data.runtime_hash_types;
+    vnet_mig->rss_indirections_len_early = n->rss_data.indirections_len;
+    vnet_mig->rss_default_queue_early = n->rss_data.default_queue;
+    memcpy(vnet_mig->rss_key_early, n->rss_data.key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
+
+    /* Snapshot RSS indirections table if present */
+    g_free(vnet_mig->rss_indirections_table_early);
+    vnet_mig->rss_indirections_table_early = NULL;
+
+    if (n->rss_data.indirections_len && n->rss_data.indirections_table) {
+        /* Casting to size_t avoids implicit narrow/widen arithmetic */
+        size_t bytes = (size_t)n->rss_data.indirections_len * sizeof(uint16_t);
+
+        vnet_mig->rss_indirections_table_early =
+            g_memdup2(n->rss_data.indirections_table, bytes);
+    }
+
     return 0;
 }
 
@@ -4233,6 +4254,8 @@ static void virtio_net_device_unrealize(DeviceState *dev)
         n->migration->mtable_macs_early = NULL;
         g_free(n->migration->vlans_early);
         n->migration->vlans_early = NULL;
+        g_free(n->migration->rss_indirections_table_early);
+        n->migration->rss_indirections_table_early = NULL;
         g_free(n->migration);
         n->migration = NULL;
 
@@ -4389,6 +4412,33 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
         return true;
     }
 
+    /* Has the VirtIONet's RSS state changed? */
+    if (n->rss_data.enabled != vnet_mig->rss_enabled_early ||
+        n->rss_data.redirect != vnet_mig->rss_redirect_early ||
+        n->rss_data.populate_hash != vnet_mig->rss_populate_hash_early ||
+        n->rss_data.runtime_hash_types != vnet_mig->rss_runtime_hash_types_early ||
+        n->rss_data.indirections_len != vnet_mig->rss_indirections_len_early ||
+        n->rss_data.default_queue != vnet_mig->rss_default_queue_early) {
+        return true;
+    }
+    if (memcmp(n->rss_data.key, vnet_mig->rss_key_early,
+               VIRTIO_NET_RSS_MAX_KEY_SIZE) != 0) {
+        return true;
+    }
+    if (n->rss_data.indirections_len) {
+        size_t bytes = (size_t)n->rss_data.indirections_len * sizeof(uint16_t);
+
+        /* If either side lacks a buffer when len > 0, treat as changed */
+        if (!n->rss_data.indirections_table ||
+            !vnet_mig->rss_indirections_table_early) {
+            return true;
+        }
+        if (memcmp(n->rss_data.indirections_table,
+                   vnet_mig->rss_indirections_table_early, bytes) != 0) {
+            return true;
+        }
+    }
+
     /*
      * Always return true for now until we're able to detect all possible
      * changes to a VirtIONet device.
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5d6179fa19..88074a0976 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -180,6 +180,14 @@ typedef struct VirtIONetQueue {
  * @guest_offloads_early: Guest offloads snapshot.
  * @mq_early: Multiqueue state snapshot.
  * @queue_pairs_early: Queue pairs snapshot.
+ * @rss_enabled_early: RSS enabled flag.
+ * @rss_redirect_early: RSS redirect flag.
+ * @rss_populate_hash_early: RSS populate hash flag.
+ * @rss_runtime_hash_types_early: RSS runtime hash types.
+ * @rss_indirections_len_early: RSS indirections length.
+ * @rss_default_queue_early: RSS default queue.
+ * @rss_key_early: RSS key.
+ * @rss_indirections_table_early: RSS indirections table.
  */
 typedef struct VirtIONetMigration {
     uint16_t status_early;
@@ -193,6 +201,14 @@ typedef struct VirtIONetMigration {
     uint64_t guest_offloads_early;
     int mq_early;
     uint16_t queue_pairs_early;
+    bool rss_enabled_early;
+    bool rss_redirect_early;
+    bool rss_populate_hash_early;
+    uint32_t rss_runtime_hash_types_early;
+    uint16_t rss_indirections_len_early;
+    uint16_t rss_default_queue_early;
+    uint8_t rss_key_early[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+    uint16_t *rss_indirections_table_early;
 } VirtIONetMigration;
 
 struct VirtIONet {
-- 
2.51.0


