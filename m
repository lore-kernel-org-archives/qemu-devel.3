Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3CE1098789
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aie-0002z4-C6; Fri, 20 Mar 2026 10:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aic-0002ym-NH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aib-0007SU-5H
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8YgqU2601043; Fri, 20 Mar 2026 14:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=WZW6c
 fdUQ7XelXX/kKjZrZAeuGEVV32c0tTyGafjG/Y=; b=g2Cc8n5b7YokDjrZgZU6h
 DrMGtoP7bNhH29vAMGAtdfwiyjqH0h74RduZ4eauFGiSyhu42moOIgdnW5b/uu5e
 jPIoGhr5hY7QK8OoJidhOfcvR5ZDeGCFQebAicbaAQ/J4jFOL71vSk+ZNPCAyUqe
 U3I4j1PkxcZNUWsrUPu0+AmW7+IvHTzswdR6ndQKv09Toz8e/qbhK+bA0QNS5gXK
 I/i6v8/hVivNrwHYN990Iyl8SeOKQLkTkM/HRYkZN8VbbP22WEZ9PIuf3iopsx9g
 PIOwuqTcm0dWB/xqcerlmUD+DjT7rz9oP7oJKgL7uKjD7iIgsXeFrc7MBUtQs4CC
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x9thh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KCGFcf030802; Fri, 20 Mar 2026 14:20:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb48w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:37 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jn016730;
 Fri, 20 Mar 2026 14:20:36 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-10; Fri, 20 Mar 2026 14:20:36 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 09/14] virtio-net: detect VirtIONet Rx filter mid-migration
 changes
Date: Fri, 20 Mar 2026 14:20:10 +0000
Message-ID: <20260320142015.3856652-10-jonah.palmer@oracle.com>
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
X-Proofpoint-GUID: Yi2I8xQfZRn7ZtBEGdBxU_z3To095nWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfXy9KvEGOscD0T
 QLfDMT7UUmOZvG4gDdllAQ3JruaB2aWwXhIx+epkw19Z/AUeiFBVl/IUC19ZSNp1azwmCl2pF0W
 mGf5hUV5KAEVZOTIXxHmM1ytSDpttVx79RCOMs1VHHDzs9QXYFp7o+kxfmRBCIEXZImRvgII/Jn
 RYefriLoHqH2XhQJbkVyYkImvZcYnpo9TzQg6nz+G/CX0dQECl+FgwTV/tiww203R6xpCK3aRoD
 /hNnpPUOpI7XfDRmA/lsb7LbhcM+iMphf+IUKcVytZM6YH+l3Q5zKuC0oHwvr4xpdsqfMnxaa+M
 WbkpOvjD62BhUq/yQRdfohUJ/qrTon0Mz93Q8MmR2aYzWKCFR9/3iYvkCPQ6RUc6ExmOtHzqSvW
 BoO4CKwbUdOcXddlQS41YvpXwAOa/wQMQsz9FwdpglimqZQoma9gpc0CpZ1/yz9HIX4NbNGBeEM
 qy+DjxLqaLyjZpPXklQ==
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69bd57b5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=nK3-aE-XDlKPtvZYpUgA:9
X-Proofpoint-ORIG-GUID: Yi2I8xQfZRn7ZtBEGdBxU_z3To095nWJ
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

This patch saves the virtio-net device's Rx filter flags as a bit-packed
uint8_t to compare with later during the stop-and-copy phase.

A local enum VirtIONetRxFlags and static inline virtio_net_rx_flags_pack
function is introduced to bit-pack VirtIONet's promisc, allmulti,
alluni, nomulti, nouni, and nobcast into a single byte for easier
comparison.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c            | 28 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 88ce33b1d2..42c585142d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3864,6 +3864,26 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     return qatomic_read(&n->failover_primary_hidden);
 }
 
+enum VirtIONetRxFlags {
+    VNET_RX_F_PROMISC  = 1u << 0,
+    VNET_RX_F_ALLMULTI = 1u << 1,
+    VNET_RX_F_ALLUNI   = 1u << 2,
+    VNET_RX_F_NOMULTI  = 1u << 3,
+    VNET_RX_F_NOUNI    = 1u << 4,
+    VNET_RX_F_NOBCAST  = 1u << 5,
+};
+
+/* Pack current Rx filter flags into a single uint8_t for comparison */
+static inline uint8_t virtio_net_rx_flags_pack(const VirtIONet *n)
+{
+    return (n->promisc  ? VNET_RX_F_PROMISC  : 0) |
+           (n->allmulti ? VNET_RX_F_ALLMULTI : 0) |
+           (n->alluni   ? VNET_RX_F_ALLUNI   : 0) |
+           (n->nomulti  ? VNET_RX_F_NOMULTI  : 0) |
+           (n->nouni    ? VNET_RX_F_NOUNI    : 0) |
+           (n->nobcast  ? VNET_RX_F_NOBCAST  : 0);
+}
+
 static int virtio_net_early_pre_save(void *opaque)
 {
     VirtIONet *n = opaque;
@@ -3906,6 +3926,9 @@ static int virtio_net_early_pre_save(void *opaque)
         memcpy(vnet_mig->mtable_macs_early, n->mac_table.macs, bytes);
     }
 
+    /* Rx filter flags snapshot */
+    vnet_mig->rx_flags_early = virtio_net_rx_flags_pack(n);
+
     return 0;
 }
 
@@ -4327,6 +4350,11 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
         }
     }
 
+    /* Has the VirtIONet's Rx filter flags changed? */
+    if (virtio_net_rx_flags_pack(n) != vnet_mig->rx_flags_early) {
+        return true;
+    }
+
     /*
      * Always return true for now until we're able to detect all possible
      * changes to a VirtIONet device.
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 59345f1811..9135d277ff 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -175,6 +175,7 @@ typedef struct VirtIONetQueue {
  * @mtable_uni_overflow_early: Unicast overflow MAC table entries.
  * @mtable_multi_overflow_early: Multicast overflow MAC table entries.
  * @mtable_macs_early: MAC table entries.
+ * @rx_flags_early: Bit-packed RX filters (promisc, allmulti, alluni, etc.).
  */
 typedef struct VirtIONetMigration {
     uint16_t status_early;
@@ -183,6 +184,7 @@ typedef struct VirtIONetMigration {
     uint8_t mtable_uni_overflow_early;
     uint8_t mtable_multi_overflow_early;
     uint8_t *mtable_macs_early;
+    uint8_t rx_flags_early;
 } VirtIONetMigration;
 
 struct VirtIONet {
-- 
2.51.0


