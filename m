Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4941C1098788
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aig-0002zv-JM; Fri, 20 Mar 2026 10:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aif-0002z9-3u
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aid-0007T8-JC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:56 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8YlNi2499511; Fri, 20 Mar 2026 14:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=QPkNy
 dstWfbqDceZLKUfsIAfh5zBIBp/4EWX8VCgJDs=; b=V6Ih8xlGiUhsFEhe9U8BD
 L0tawMhcUaRky5V3hGtxxZtecx+4WX6+7Rqmfy7dgLP74ayrGI7lQCE33j9bGy1b
 1C4vF58CVzs2yhgj2snpPuIe/wJKy/FLIabDVDWFg8Z5JCvlX+wz3UUIppSKXmwG
 nSjnDVTnm6US+BaKSNYFdd/h28Z9H3280+/pIA72yOQU8J+WU4CrUnkEEBFpOPry
 /Dlpv2lWEwWtWdXfQA8FrzCaU2Xs0fhgFnRe/xsWm+CDYwLEjNMyFUHw2PWeQB5a
 GDXWG26J1RHdXGtpWauSMDX5BeTc23gTrebJUHIAfB43zXnjdHLUuKVfQojsQY5P
 A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rhsek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KCs2Oh030277; Fri, 20 Mar 2026 14:20:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb49f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:38 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jp016730;
 Fri, 20 Mar 2026 14:20:38 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-11; Fri, 20 Mar 2026 14:20:38 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 10/14] virtio-net: detect VirtIONet VLAN filter table changes
Date: Fri, 20 Mar 2026 14:20:11 +0000
Message-ID: <20260320142015.3856652-11-jonah.palmer@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69bd57b7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=uRB8GxAVLDhh3WKyutIA:9
X-Proofpoint-ORIG-GUID: B2hfockT636NSvyTkjRpq3dtqq6eRwX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfXylgWyGHO78jq
 cGQ2lvDcLXWOzeqpzcXodxX9a8o4HVBkhk1xd7QQ6XlzPssSzF3tp3XPGmCHNG4zBkAJTppuGHc
 9JNPHT244MuDKPwYeIDgX1/Bs/VTEhEB6+rbmZxq6eE8djhwXGa5o5gyR5EbIQ9i/23qhPu8RL6
 syefSiIQ6CYABRvGBBFXH7Lvr7nz4Ryu3kzh1Wk2XRnTSevEGnfYsjpddTE5dJAOWRxwP5O9jA1
 xr/Rw7dPlKDbHY51fmAWRNYDT2cnwMAySnq/tpw8F2tMI81RX5BhFUjKj/M7HxGInY9L/FX+ju/
 Akh5gGWFzYFB10JdJAHrwo5Gxq7NgyRYCEh73Mlpdd6qxgOQOiHupOwu45ONpdqmnF5UrOypq/i
 4lfU3Om4WrZk4FP/mvIWls76l+AhTeFk+0+oSGzJQrntauWTFVehydMyxk0weDgN5T87UBs4x02
 63UKHKoXCrZGOf1SPgQ==
X-Proofpoint-GUID: B2hfockT636NSvyTkjRpq3dtqq6eRwX7
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

Save the current state of virtio-net's VLAN filter table at early
migration time to compare with later during the stop-and-copy phase.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c            | 14 ++++++++++++++
 include/hw/virtio/virtio-net.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 42c585142d..b3f71d8f84 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3890,6 +3890,7 @@ static int virtio_net_early_pre_save(void *opaque)
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     VirtIODevMigration *vdev_mig = vdev->migration;
     VirtIONetMigration *vnet_mig = n->migration;
+    size_t vlans_size = (size_t)(MAX_VLAN >> 3);
 
     vdev_mig->status_early = vdev->status;
     vnet_mig->status_early = n->status;
@@ -3929,6 +3930,12 @@ static int virtio_net_early_pre_save(void *opaque)
     /* Rx filter flags snapshot */
     vnet_mig->rx_flags_early = virtio_net_rx_flags_pack(n);
 
+    /* VLAN filter table snapshot */
+    if (!vnet_mig->vlans_early) {
+        vnet_mig->vlans_early = g_malloc0(vlans_size);
+    }
+    memcpy(vnet_mig->vlans_early, n->vlans, vlans_size);
+
     return 0;
 }
 
@@ -4217,6 +4224,8 @@ static void virtio_net_device_unrealize(DeviceState *dev)
 
         g_free(n->migration->mtable_macs_early);
         n->migration->mtable_macs_early = NULL;
+        g_free(n->migration->vlans_early);
+        n->migration->vlans_early = NULL;
         g_free(n->migration);
         n->migration = NULL;
 
@@ -4355,6 +4364,11 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
         return true;
     }
 
+    /* Has the VirtIONet's VLAN filter table changed? */
+    if (memcmp(n->vlans, vnet_mig->vlans_early, MAX_VLAN >> 3) != 0) {
+        return true;
+    }
+
     /*
      * Always return true for now until we're able to detect all possible
      * changes to a VirtIONet device.
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 9135d277ff..5df2dd0513 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -176,6 +176,7 @@ typedef struct VirtIONetQueue {
  * @mtable_multi_overflow_early: Multicast overflow MAC table entries.
  * @mtable_macs_early: MAC table entries.
  * @rx_flags_early: Bit-packed RX filters (promisc, allmulti, alluni, etc.).
+ * @vlans_early: VLAN filter table snapshot.
  */
 typedef struct VirtIONetMigration {
     uint16_t status_early;
@@ -185,6 +186,7 @@ typedef struct VirtIONetMigration {
     uint8_t mtable_multi_overflow_early;
     uint8_t *mtable_macs_early;
     uint8_t rx_flags_early;
+    uint8_t *vlans_early;
 } VirtIONetMigration;
 
 struct VirtIONet {
-- 
2.51.0


