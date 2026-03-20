Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4571098788
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3anU-0000QE-Qs; Fri, 20 Mar 2026 10:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3anT-0000Q0-2Z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:25:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3anP-0008DC-Bf
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:25:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8YS0d2600858; Fri, 20 Mar 2026 14:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=CtDC4
 SmxftQNWsi8FwdOovszRY7UDOffW9Wp0/30uS8=; b=WlSYdFbHjqUgBSKJ9Ceiv
 pwQYFBcY7+t0nM9U/TecTVyKggxvdTaIM9n0oPA4T0Iu0wDiEa1d/X9aekpF7pAM
 znrNoNP51OVgdn5NkLJUxQbjziqubeQaJap6ruwN7owTJvlXoYcUcqGiou5fiNmi
 u/Wbc1G4Q24edYQuGxzLHglMtoX++y7pzY5lrm7/wPr6lJGTwwLrHwjHbUYUwaL2
 dKUhVb4ryecDUG/F/dkthOf74ZAFhJhYZIOiXtNP3k1kzB60Aqx0kDSZeTwztVMp
 q5YNtUBQU/0oazYeJots4e411enDsQ1SIv1QxRGv0jASKL5Ee9SU5Lq0Z+T0xLYG
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x9thd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KDON7h030599; Fri, 20 Mar 2026 14:20:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb46w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jj016730;
 Fri, 20 Mar 2026 14:20:33 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-8; Fri, 20 Mar 2026 14:20:33 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 07/14] virtio-net: detect VirtIONet MAC table mid-migration
 changes
Date: Fri, 20 Mar 2026 14:20:08 +0000
Message-ID: <20260320142015.3856652-8-jonah.palmer@oracle.com>
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
X-Proofpoint-GUID: 8xT3ica83MfohWhuayaEWfe9FF7EzM6n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfXwOoMA4IfuWon
 QsImUiXTayI8bfHR0qnZDFdd/yN0ihfUFCYq3yBkijOMWMVWSSpXFdXuP0po/llXTZSq0zudzXa
 oyOvgofj6FVQmJcdSQ7x2nx9vH833krkQWaR9+lHagwiq61Pl7HrvQ4PscHXtlZaUethVjSj+ZE
 sG6O8TUjhlkUoUM7R4SjHOSxXEpNekJnweuZ8WmPteHehWKux9r2HnYoyw/i93tsy4pUswpuVpC
 J/+9zKx5esBv9QkyJXmsu0ZjECS5Eqit9BsxkoWMUyV5sAsOiilkUvxlHco9ZLjdc9RuEUjNMfm
 zYaXd+xrDIasCZ4ZIqxW8gWha+ltFnOA1t77AYyj0PS11ihBxUWcYoslonn6kfKzMXUM4XumBXP
 ofM5M7vZbpeqxkmaRvA6xyigiT4iH305srin+wKme2bgB0jpbGyaBS/rax+AXwPc1wbREYFUbGb
 d8wT+H796fynUyuj8zA==
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69bd57b2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=uv6Ftj0Ief3x8EZWz6YA:9
X-Proofpoint-ORIG-GUID: 8xT3ica83MfohWhuayaEWfe9FF7EzM6n
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

This patch saves the virtio-net device's MAC table information to
compare with later during the stop-and-copy phase.

We leave out mac_table.first_multi since it's derived post-load.

Note: we store the exact mac_table.in_use value and the MIN macro is
only used to bound copy & compare byte spans for safety.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c            | 34 ++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4f14bba510..2dd130777e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3884,6 +3884,26 @@ static int virtio_net_early_pre_save(void *opaque)
 
     /* VirtIONet MAC info snapshot */
     memcpy(vnet_mig->mac_early, n->mac, ETH_ALEN);
+    vnet_mig->mtable_in_use_early = n->mac_table.in_use;
+    vnet_mig->mtable_uni_overflow_early = n->mac_table.uni_overflow;
+    vnet_mig->mtable_multi_overflow_early = n->mac_table.multi_overflow;
+    /*
+     * Allocate baseline buffer once. Only copy the used slice each time.
+     * This avoids repeated allocations and keeps memcmp fast
+     */
+    if (!vnet_mig->mtable_macs_early) {
+        vnet_mig->mtable_macs_early =
+            g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
+    }
+    /*
+     * Copy used portion only. Cap byte span with MIN for safety even if
+     * a buggy config reports more than capacity.
+     */
+    if (vnet_mig->mtable_in_use_early) {
+        uint32_t used = MIN(vnet_mig->mtable_in_use_early, (uint32_t)MAC_TABLE_ENTRIES);
+        size_t bytes = (size_t)used * ETH_ALEN;
+        memcpy(vnet_mig->mtable_macs_early, n->mac_table.macs, bytes);
+    }
 
     return 0;
 }
@@ -4171,6 +4191,8 @@ static void virtio_net_device_unrealize(DeviceState *dev)
         g_free(vdev->migration);
         vdev->migration = NULL;
 
+        g_free(n->migration->mtable_macs_early);
+        n->migration->mtable_macs_early = NULL;
         g_free(n->migration);
         n->migration = NULL;
 
@@ -4286,6 +4308,18 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
     if (memcmp(n->mac, vnet_mig->mac_early, ETH_ALEN) != 0) {
         return true;
     }
+    if (n->mac_table.in_use != vnet_mig->mtable_in_use_early ||
+        n->mac_table.uni_overflow != vnet_mig->mtable_uni_overflow_early ||
+        n->mac_table.multi_overflow != vnet_mig->mtable_multi_overflow_early) {
+        return true;
+    }
+    if (n->mac_table.in_use) {
+        uint32_t used = MIN(n->mac_table.in_use, (uint32_t)MAC_TABLE_ENTRIES);
+        size_t bytes = (size_t)used * ETH_ALEN;
+        if (memcmp(n->mac_table.macs, vnet_mig->mtable_macs_early, bytes) != 0) {
+            return true;
+        }
+    }
 
     /*
      * Always return true for now until we're able to detect all possible
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 280155366c..1e1f1a3995 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -170,9 +170,17 @@ typedef struct VirtIONetQueue {
 /**
  * struct VirtIONetMigration - VirtIONet migration structure
  * @mac_early: MAC address early migration snapshot.
+ * @mtable_in_use_early: In-use MAC table entries.
+ * @mtable_uni_overflow_early: Unicast overflow MAC table entries.
+ * @mtable_multi_overflow_early: Multicast overflow MAC table entries.
+ * @mtable_macs_early: MAC table entries.
  */
 typedef struct VirtIONetMigration {
     uint8_t mac_early[ETH_ALEN];
+    uint32_t mtable_in_use_early;
+    uint8_t mtable_uni_overflow_early;
+    uint8_t mtable_multi_overflow_early;
+    uint8_t *mtable_macs_early;
 } VirtIONetMigration;
 
 struct VirtIONet {
-- 
2.51.0


