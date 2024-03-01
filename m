Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB95C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 13:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg3B5-0001VJ-5q; Fri, 01 Mar 2024 08:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rg3B2-0001Sl-8U; Fri, 01 Mar 2024 08:43:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rg3B0-0004ra-3Z; Fri, 01 Mar 2024 08:43:51 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42198usA012317; Fri, 1 Mar 2024 13:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=+yib/Zj3rSXJ1hKbXY1gPDcB2uxuzIu3Eyv0AgFx4+0=;
 b=WL0p0doH3CRMR1U0iyYXtNtPy0M6metfdQpU0LJjZzm+RJzfHOPrrqh2kWAk1CoVFOsQ
 pP9V91nm2z3PggTKrozaRqGVD4FnbufgUWDdLrM62gO0uabxYv65IpS01s55O97/Z9Gv
 jg2GJZsanksXTLiggot0AWyXRB/Bj4QsqL0HdTFzOQGpNIClI7aO0RquGsJB3hoCgY0w
 IkNpIj6PPB/dkJPjKKgSweV9CfJ6k3p3qu+uKFlRXoenQ5poshaqiH2N2qivT+IXnqGt
 rMnIlsTIhk0q08cpVrGnOXcPxME38GqpwBD8pgMCTxITRR610WlwoTOelYi4+oJLEpbN DQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gds5kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Mar 2024 13:43:39 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 421CwuK4009384; Fri, 1 Mar 2024 13:43:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wjrqmtre6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Mar 2024 13:43:39 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421DhWAQ026578;
 Fri, 1 Mar 2024 13:43:38 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-160-211.vpn.oracle.com
 [10.65.160.211])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3wjrqmtr9m-5; Fri, 01 Mar 2024 13:43:38 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 jonah.palmer@oracle.com, raphael@enfabrica.net, kwolf@redhat.com,
 hreitz@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, cohuck@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Subject: [RFC 4/8] virtio-mmio: Lock ioeventfd state with
 VIRTIO_F_NOTIFICATION_DATA
Date: Fri,  1 Mar 2024 08:43:26 -0500
Message-Id: <20240301134330.4191007-5-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240301134330.4191007-1-jonah.palmer@oracle.com>
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_13,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010114
X-Proofpoint-ORIG-GUID: wAQDAHZ40iGWB_ja4NigNc5az8y-vd-z
X-Proofpoint-GUID: wAQDAHZ40iGWB_ja4NigNc5az8y-vd-z
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Prevent ioeventfd from being enabled/disabled when a virtio-mmio device
has negotiated the VIRTIO_F_NOTIFICATION_DATA transport feature.

Due to ioeventfd not being able to carry the extra data associated with
this feature, the ioeventfd should be left in a disabled state for
emulated virtio-mmio devices using this feature.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio-mmio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 2bac77460e..fc780a03b2 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -424,7 +424,8 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         virtio_update_irq(vdev);
         break;
     case VIRTIO_MMIO_STATUS:
-        if (!(value & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        if (!(value & VIRTIO_CONFIG_S_DRIVER_OK) &&
+            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
             virtio_mmio_stop_ioeventfd(proxy);
         }
 
@@ -436,7 +437,8 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
 
         virtio_set_status(vdev, value & 0xff);
 
-        if (value & VIRTIO_CONFIG_S_DRIVER_OK) {
+        if ((value & VIRTIO_CONFIG_S_DRIVER_OK) &&
+            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
             virtio_mmio_start_ioeventfd(proxy);
         }
 
-- 
2.39.3


