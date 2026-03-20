Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38B81098788
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aiZ-0002xc-Az; Fri, 20 Mar 2026 10:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiW-0002wb-Mt
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiV-0007QP-1c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:48 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8Y1Yk2599977; Fri, 20 Mar 2026 14:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=Sv8Wm
 SJvIUPxUqFls32F8YWlQumpgBOdkE/KHWzHOE0=; b=Namk8hFSlcXJSbvMdix/u
 d92faPzwe0J4RFINq5xw3MJ8JfbgBVqjuFq9GbB5WIOmbCzrAJlT3CjY0WLxTspr
 U1arIN1UQXmz+vl5nlAizXUgQngGfSLZSXwvkLnFBCahIFCBxWMrAsXspmpcXOBC
 xZJLYzfo9c5+m+DLJ/jO4aBGYsUHCSovFNuK4nQyyf0aFjIJp1pLnvHq5pLX9RxB
 oDIPhdRk9sEWr8WyzIfwaHPMv9Qv8LiXBQVxunCSIcV1W8qQ6Izub7wBtnH74Roc
 C5D3W+vWwBIzffIZzJgy2vlWEke7B7hVXfNJZW8YhRzbtukAfhM3WtynDsF6i10G
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x9tha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KDEaMa030672; Fri, 20 Mar 2026 14:20:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb45e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jf016730;
 Fri, 20 Mar 2026 14:20:29 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-6; Fri, 20 Mar 2026 14:20:29 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 05/14] virtio-net: detect VirtIODevice config buffer
 mid-migration change
Date: Fri, 20 Mar 2026 14:20:06 +0000
Message-ID: <20260320142015.3856652-6-jonah.palmer@oracle.com>
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
X-Proofpoint-GUID: jj9kXF1RJk9L2I3Ie9DumYTx6VlLpb4x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfX+HIH9nDjHzd1
 13UywatPY8zGwIViFKaGc44+JBF/3xNlxqQmWJdp3WJSpfz7Fj/FaA/ishTv7TYGWObZBbHCRfG
 HpXqS9bXMXYE03MwzYrKNgfTTld8pM8C8uXb3X5asfcxxRqgZbuLKX3DDWUuxI/D5SmJpAr7XcX
 pClLQNPibNq0ezlM2lf9kqSfwRl0/jVA1Iu8VTEuJeiLvC6xV/GRFB52Xm3KZcEPlL4p6H8DbkI
 dMbi5wcLlGbQSF+d0NUWBEZsfE/bLgeCkFcijAubWPADW2V11FB6l3XdfntohO+9q4DEvaO2vEO
 8znTv4oDGvHpnHsZbIrEIqj1JamTcniLHMMYO6wg3MKj7z43bnofBXQ17XZyhOv5052Unk86dZV
 2C3MICnQFtiGDNMZVrqstqxsQSbXqPfMA8TyxEjcR7OJiA1PtKFTHiZwiroyYcLaIOkETFm+IF8
 OHkxhNNzHgg48RC3Rlw==
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69bd57af b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=1bn3fnhKCm_T0IbXVqwA:9
X-Proofpoint-ORIG-GUID: jj9kXF1RJk9L2I3Ie9DumYTx6VlLpb4x
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

This patch saves the config buffer and its length of a virtio-net
device's VirtIODevice to compare with later during the stop-and-copy
phase.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c        | 21 +++++++++++++++++++++
 include/hw/virtio/virtio.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2733e0130c..ca4385df1a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3871,6 +3871,15 @@ static int virtio_net_early_pre_save(void *opaque)
     VirtIODevMigration *vdev_mig = vdev->migration;
 
     vdev_mig->status_early = vdev->status;
+
+    /* VirtIODevice config buffer snapshot */
+    g_free(vdev_mig->config_early);
+    vdev_mig->config_len_early = vdev->config_len;
+    if (vdev->config_len) {
+        vdev_mig->config_early = g_memdup2(vdev->config, vdev->config_len);
+    } else {
+        vdev_mig->config_early = NULL;
+    }
     return 0;
 }
 
@@ -4150,6 +4159,9 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 
     if (n->early_mig) {
+        g_free(vdev->migration->config_early);
+        vdev->migration->config_early = NULL;
+
         g_free(vdev->migration);
         vdev->migration = NULL;
 
@@ -4251,6 +4263,15 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
         return true;
     }
 
+    /* Has the VirtIODevice's config buffer changed? */
+    if (vdev->config_len != vdev_mig->config_len_early) {
+        return true;
+    }
+    if (vdev->config_len && memcmp(vdev->config, vdev_mig->config_early,
+                                   vdev->config_len) != 0) {
+        return true;
+    }
+
     /*
      * Always return true for now until we're able to detect all possible
      * changes to a VirtIONet device.
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 752c46ce53..9949b94b64 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -103,10 +103,14 @@ enum virtio_device_endian {
  * struct VirtIODevMigration - Common VirtIODevice migration structure
  * @early_load: Flag to indicate an early virtio_load for the device.
  * @status_early: Device status at the time it was sent early.
+ * @config_len_early: Length of the config buffer at the time it was sent early.
+ * @config_early: Config buffer at the time it was sent early.
  */
 typedef struct VirtIODevMigration {
     bool early_load;
     uint8_t status_early;
+    size_t config_len_early;
+    uint8_t *config_early;
 } VirtIODevMigration;
 
 /**
-- 
2.51.0


