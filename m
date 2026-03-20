Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB6C1098788
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aij-000317-Bd; Fri, 20 Mar 2026 10:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aii-00030a-Fl
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:21:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aig-0007Tu-LX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:21:00 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8Y3OM3323029; Fri, 20 Mar 2026 14:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=JHqAd
 7pd2hBqwvzRs6exVJIc5gcSW1KgIUAEh93nhxs=; b=c0ujCpVjzWwlD+0mMJPW6
 Hsn0mijCt+ZW96+N2CR1oQAmnANKPjZhNjGQu04s3lAJoBKv6vr7fEt68N8R5MVZ
 Jrnk4S53CHvYRjcoWyVxEwYB33v3kQsMAn4yAbfDPeLBEFa7Yx2j+e0oX7TF9OXh
 1PbT3yBQt5kDcDuslL0liA5KE5BFLmsIaThUnIzJGs6pPSVrIFQXrsG9heEYI3dm
 cPKJb5JBxj9QhXYE5QSVG8Ir1m5GoQIW2xIIEw9boTXTnSosm8NNKPUQQ803HHio
 xDPNabKWpGj+QYzE0VO+OEA7PY5MtGdIQgpD120jX3jrMCAW2K8Kny/2k4Bew0RW
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8htk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KDmXNA030464; Fri, 20 Mar 2026 14:20:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb4a7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:40 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jr016730;
 Fri, 20 Mar 2026 14:20:39 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-12; Fri, 20 Mar 2026 14:20:39 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 11/14] virtio-net: detect VirtIONet guest offload & MQ
 mid-migration changes
Date: Fri, 20 Mar 2026 14:20:12 +0000
Message-ID: <20260320142015.3856652-12-jonah.palmer@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfXx7GQF14C0HsV
 YtNvmURLzaK5FDnUJmW1REviiDnAw+VHRx8WAK8c1F/OY+gB07uCYE0ChZqkEhVLaMSj6eKpu68
 Mr7YopJiAM63MJQ8LvLBov4SRx+Dm8/TfMHPFcSpmebiyif90wm4b3wa2cyAqFyl08OUfvzpzZM
 TCQoIBrm32hccPwgltzt5OnlLM5Fqj7jeuh00KNLOopeVx6uN9eDmR+SABvlnVBp54NX9f2uVJO
 ODa3BJrTnxWR5WFM7E7e4sysFJSajJ+OiQKRo8b+XEaIU65luQWq6oANQjRVLuCH8biyevKUdIV
 qmKw/096ZBGZEQ5R7fsSTejGMtcxaYB2Cu6lWlxmeKLaI/eZfsTIOew+djrkdo8/YLpxJA7loVm
 c6jBSa07022ntAKkiA4PRQj9eQhXFO8L88l09M9Dhh48NUEQXBZLcKLwtj/biXwHQanQCQdHSzh
 OfC4kTkqYFsZXHKWJpQ==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bd57b9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=rw_dZD_eKbb5xvwdQzAA:9
X-Proofpoint-GUID: PEmg51LwUQb-_BlgdrSCD13jnJxkLLSK
X-Proofpoint-ORIG-GUID: PEmg51LwUQb-_BlgdrSCD13jnJxkLLSK
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

Save the state of virtio-net's guest offloads and multiqueue
configuration at early migration time to compare with later during
the stop-and-copy phase.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c            | 20 ++++++++++++++++++++
 include/hw/virtio/virtio-net.h |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b3f71d8f84..2c0b42debb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3936,6 +3936,13 @@ static int virtio_net_early_pre_save(void *opaque)
     }
     memcpy(vnet_mig->vlans_early, n->vlans, vlans_size);
 
+    /* Guest offloads snapshot */
+    vnet_mig->guest_offloads_early = n->curr_guest_offloads;
+
+    /* Multiqueue state snapshot */
+    vnet_mig->mq_early = n->multiqueue;
+    vnet_mig->queue_pairs_early = n->curr_queue_pairs;
+
     return 0;
 }
 
@@ -4369,6 +4376,19 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
         return true;
     }
 
+    /* Has the VirtIONet's guest offloads changed? */
+    if (n->curr_guest_offloads != vnet_mig->guest_offloads_early) {
+        return true;
+    }
+
+    /* Has the VirtIONet's multiqueue state changed? */
+    if (n->multiqueue != vnet_mig->mq_early) {
+        return true;
+    }
+    if (n->curr_queue_pairs != vnet_mig->queue_pairs_early) {
+        return true;
+    }
+
     /*
      * Always return true for now until we're able to detect all possible
      * changes to a VirtIONet device.
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5df2dd0513..5d6179fa19 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -177,6 +177,9 @@ typedef struct VirtIONetQueue {
  * @mtable_macs_early: MAC table entries.
  * @rx_flags_early: Bit-packed RX filters (promisc, allmulti, alluni, etc.).
  * @vlans_early: VLAN filter table snapshot.
+ * @guest_offloads_early: Guest offloads snapshot.
+ * @mq_early: Multiqueue state snapshot.
+ * @queue_pairs_early: Queue pairs snapshot.
  */
 typedef struct VirtIONetMigration {
     uint16_t status_early;
@@ -187,6 +190,9 @@ typedef struct VirtIONetMigration {
     uint8_t *mtable_macs_early;
     uint8_t rx_flags_early;
     uint8_t *vlans_early;
+    uint64_t guest_offloads_early;
+    int mq_early;
+    uint16_t queue_pairs_early;
 } VirtIONetMigration;
 
 struct VirtIONet {
-- 
2.51.0


