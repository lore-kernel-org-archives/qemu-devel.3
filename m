Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A091098788
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aih-0002zw-08; Fri, 20 Mar 2026 10:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aie-0002z5-Ve
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aic-0007Sn-No
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8Y4Ob3254798; Fri, 20 Mar 2026 14:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=eLmq7
 5GeGNkeMqSupIjOA38TXJGPu/+T/5yeiI4IKGc=; b=gu3ss3icfa80m2XRddZ8I
 T5FT/Y9nyHWc7atf6X3P2AAOWevTAn5v5M2FsTHrztnukKvoxcTSsm6/WTHAtCyt
 XRYOUrxlTz7LIGBdw5MP7mY4m7Rj9aU4XpbO8Eharu6k/LR3EA21tESxklcZY3XI
 0cnE1dVVmbqw5zeMfVRkhHouq/CMfqZTbJ3SHTX0uFUIlYhaZuPRW35W8aAiZLw/
 UY2IilsiL7aREVyw/EKBnwZtgJXSZsFho8/AxfaF8zXAGlWm5ZjXsE2g2Stxyqj1
 PkUCkQXLRxzcQmmRoGEe56KYtJmTwQ+OA+ntoTwLB6NNqxiSkU1P36vWf0mrKprs
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj69pce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KDGJQn003488; Fri, 20 Mar 2026 14:20:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb484-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:35 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jl016730;
 Fri, 20 Mar 2026 14:20:35 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-9; Fri, 20 Mar 2026 14:20:34 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 08/14] virtio-net: detect VirtIONet status mid-migration
 change
Date: Fri, 20 Mar 2026 14:20:09 +0000
Message-ID: <20260320142015.3856652-9-jonah.palmer@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69bd57b4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=05msrqz8p71NSpwwBZQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfX2daJWhYEOrya
 n82EZAxl+1ZSqqkZ8WcdTBUv7JWb3Ym6ntr4vNJm2Jrfo0eeTtZsGExMpEyuofw+G3FF38k/mNW
 mWOG9fQB6A/1gPcCgE+WiCYSsdR/NhwrZFSAouVt9UFx8BE/shyUryvnJO7EvZkQbuEoP43mYH8
 J9IQa9LsMqGwhTiEBSn1Oj+vFcRlEbqQOLoJZQ3uvQNjs49vMeLBq3zhC2oWnpHDDRffNSnshIc
 u7jfPHu4VvDdiliKbZxSqcb7QFtWz0cZvyS/i8kIOOpT671dPo85/BZspP7y1IN+ruspkw42x5V
 NWQ5uzWAN0Yi24KID5aWUu2T+lLZhe0H8zLVEvCkZxB3T0wxINItSwrE07LZiSeW6QWJK463wgc
 +Cem8mVIt65qOaPGD2RsW1aOtlJcPBjsHxKiDxDFARirVMzk2Qvf8rN1MPL1MJflc2y5yo9QrGC
 3Ow2E/2fzRfhb5lGgaQ==
X-Proofpoint-GUID: UQv5J_Y4hHZ7MB1lJovp-UFTEFUKB2nI
X-Proofpoint-ORIG-GUID: UQv5J_Y4hHZ7MB1lJovp-UFTEFUKB2nI
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

Save VirtIONet's status field during early migration and compare it
again during stop-and-copy.

VirtIONet keeps its own status bits here, including VIRTIO_NET_S_LINK_UP
and VIRTIO_NET_S_ANNOUNCE.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c            | 6 ++++++
 include/hw/virtio/virtio-net.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2dd130777e..88ce33b1d2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3872,6 +3872,7 @@ static int virtio_net_early_pre_save(void *opaque)
     VirtIONetMigration *vnet_mig = n->migration;
 
     vdev_mig->status_early = vdev->status;
+    vnet_mig->status_early = n->status;
 
     /* VirtIODevice config buffer snapshot */
     g_free(vdev_mig->config_early);
@@ -4304,6 +4305,11 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
         return true;
     }
 
+    /* Has the VirtIONet's status changed? */
+    if (n->status != vnet_mig->status_early) {
+        return true;
+    }
+
     /* Has the VirtIONet's MAC info changed? */
     if (memcmp(n->mac, vnet_mig->mac_early, ETH_ALEN) != 0) {
         return true;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 1e1f1a3995..59345f1811 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -169,6 +169,7 @@ typedef struct VirtIONetQueue {
 
 /**
  * struct VirtIONetMigration - VirtIONet migration structure
+ * @status_early: VirtIONet status snapshot.
  * @mac_early: MAC address early migration snapshot.
  * @mtable_in_use_early: In-use MAC table entries.
  * @mtable_uni_overflow_early: Unicast overflow MAC table entries.
@@ -176,6 +177,7 @@ typedef struct VirtIONetQueue {
  * @mtable_macs_early: MAC table entries.
  */
 typedef struct VirtIONetMigration {
+    uint16_t status_early;
     uint8_t mac_early[ETH_ALEN];
     uint32_t mtable_in_use_early;
     uint8_t mtable_uni_overflow_early;
-- 
2.51.0


