Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D800FC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkNC9-0001tu-1S; Wed, 13 Mar 2024 07:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rkNC3-0001qh-6W; Wed, 13 Mar 2024 07:54:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rkNC1-0004W8-Ka; Wed, 13 Mar 2024 07:54:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42D8hf6W019449; Wed, 13 Mar 2024 11:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=GwgG0TlnuH60D7eYVRfGoFmyfV85hwQmxpUebEvO+p8=;
 b=A3YfGJZT/eLFi7MwgUFCqzPZdcOAHsHr9PQbBjccvPoogn24hua6Ht2jW+ynuvG5U0h1
 GDKJHHt6KR6Ny4NUvOS0oJwBj6MsRuaxj+011qTbTDdTqUFrQzHf9IFee0D0TCbuLET1
 5Lo99rvyHwnhYl51Tjh1rd6OuLiEbkTXjKUTJl8q9yY4+PSoJPWTNQ7CuhERNhGWb5FA
 seRtrdP0/1QBM5MFZ6HU3cysC9jrCb0xTIDlMVpCR4iNHuAB4t+nXSGHXzXWEgdNNOBy
 v6YZsLT70zv8dqTSE4BMlYYvHwDlwUe0PuxDka52uiITkWgnwkk6Et0eKfYP7Gl/wNTr OA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej40u29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 11:54:31 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42DB3uA0028601; Wed, 13 Mar 2024 11:54:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre78pek4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 11:54:30 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42DBsMLh035677;
 Wed, 13 Mar 2024 11:54:29 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-201-251.vpn.oracle.com
 [10.39.201.251])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3wre78peed-5; Wed, 13 Mar 2024 11:54:29 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 jonah.palmer@oracle.com, raphael@enfabrica.net, kwolf@redhat.com,
 hreitz@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, cohuck@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, leiyang@redhat.com,
 schalla@marvell.com, vattunuru@marvell.com, jerinj@marvell.com,
 dtatulea@nvidia.com, virtio-fs@lists.linux.dev
Subject: [PATCH v2 4/6] virtio-ccw: Handle extra notification data
Date: Wed, 13 Mar 2024 07:54:10 -0400
Message-Id: <20240313115412.3334962-5-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240313115412.3334962-1-jonah.palmer@oracle.com>
References: <20240313115412.3334962-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130089
X-Proofpoint-GUID: Y7Qb_3RDelyYiR254eLElqUMlHZI28YZ
X-Proofpoint-ORIG-GUID: Y7Qb_3RDelyYiR254eLElqUMlHZI28YZ
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

Add support to virtio-ccw devices for handling the extra data sent from
the driver to the device when the VIRTIO_F_NOTIFICATION_DATA transport
feature has been negotiated.

The extra data that's passed to the virtio-ccw device when this feature
is enabled varies depending on the device's virtqueue layout.

That data passed to the virtio-ccw device is in the same format as the
data passed to virtio-pci devices.

Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/s390x/s390-virtio-ccw.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b1dcb3857f..7631e4aa41 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -140,9 +140,11 @@ static void subsystem_reset(void)
 static int virtio_ccw_hcall_notify(const uint64_t *args)
 {
     uint64_t subch_id = args[0];
-    uint64_t queue = args[1];
+    uint64_t data = args[1];
     SubchDev *sch;
+    VirtIODevice *vdev;
     int cssid, ssid, schid, m;
+    uint16_t vq_idx = data;
 
     if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
         return -EINVAL;
@@ -151,12 +153,18 @@ static int virtio_ccw_hcall_notify(const uint64_t *args)
     if (!sch || !css_subch_visible(sch)) {
         return -EINVAL;
     }
-    if (queue >= VIRTIO_QUEUE_MAX) {
+
+    if (vq_idx >= VIRTIO_QUEUE_MAX) {
         return -EINVAL;
     }
-    virtio_queue_notify(virtio_ccw_get_vdev(sch), queue);
-    return 0;
 
+    vdev = virtio_ccw_get_vdev(sch);
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
+        virtio_queue_set_shadow_avail_data(vdev, data);
+    }
+
+    virtio_queue_notify(vdev, vq_idx);
+    return 0;
 }
 
 static int virtio_ccw_hcall_early_printk(const uint64_t *args)
-- 
2.39.3


