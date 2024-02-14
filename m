Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC6CC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 12:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEXj-0003JQ-Pj; Wed, 14 Feb 2024 07:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXe-0003GM-Qb
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXc-0002Wx-CT
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:09 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EAYnfx009511; Wed, 14 Feb 2024 12:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=UoGNHLPH+itP1S2y+WSSydsBVt7PNZE//mjE23x+u7E=;
 b=TQbQauxQ6YHdY78YZsXlR4aEyFXf49xcR7UxKZoiWAWkIDado8FaTRFvxDLKT0jnUqum
 q3+rnCL4+3P/jWJHnClwoOTBw6IWzowq2hA7cfQAXD+KOSbpfzPMXoCH8cqJg/n0v27E
 nRZyK9E1c6l4IMKtB7i6bwIc+AhNZtn73T2DI2G2qLi7nJbLJt0jq1HsA6KAfClnWeOB
 d1Qo7rc9g6W3rxhhIVyt7U0WTuFQgWkS26huNF94iVDcKGC16QNUJzwaGgrw0rPo3ZZ1
 p/wn1H95b09PjlF1qO+0PHbFAW75YM5VrGpuqCdMUuPpTzeTeg1l575qANH/w/LgmkdL wA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8uvng7gp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 12:39:05 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41ECKqph013766; Wed, 14 Feb 2024 12:39:04 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3w6apbnn3q-4; Wed, 14 Feb 2024 12:39:04 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 03/12] vdpa: factor out vhost_vdpa_last_dev
Date: Wed, 14 Feb 2024 03:27:53 -0800
Message-Id: <1707910082-10243-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
References: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140098
X-Proofpoint-ORIG-GUID: Y0Kldbkss8FoBFo2idCgpbRCEQT4-WyS
X-Proofpoint-GUID: Y0Kldbkss8FoBFo2idCgpbRCEQT4-WyS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Generalize duplicated condition check for the last vq of vdpa
device to a common function.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index f7162da..1d3154a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -551,6 +551,11 @@ static bool vhost_vdpa_first_dev(struct vhost_dev *dev)
     return v->index == 0;
 }
 
+static bool vhost_vdpa_last_dev(struct vhost_dev *dev)
+{
+    return dev->vq_index + dev->nvqs == dev->vq_index_end;
+}
+
 static int vhost_vdpa_get_dev_features(struct vhost_dev *dev,
                                        uint64_t *features)
 {
@@ -1317,7 +1322,7 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
         vhost_vdpa_host_notifiers_uninit(dev, dev->nvqs);
     }
 
-    if (dev->vq_index + dev->nvqs != dev->vq_index_end) {
+    if (!vhost_vdpa_last_dev(dev)) {
         return 0;
     }
 
@@ -1347,7 +1352,7 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
 {
     struct vhost_vdpa *v = dev->opaque;
 
-    if (dev->vq_index + dev->nvqs != dev->vq_index_end) {
+    if (!vhost_vdpa_last_dev(dev)) {
         return;
     }
 
-- 
1.8.3.1


