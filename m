Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3F6C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEGq-0003m4-1p; Mon, 04 Mar 2024 14:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rhEGn-0003Uj-8N; Mon, 04 Mar 2024 14:46:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rhEGg-0007QI-Ix; Mon, 04 Mar 2024 14:46:40 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 424IxPx3031757; Mon, 4 Mar 2024 19:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=vo+WKV8MbQsrraREtNwMhTK5ldGUsUpxzAUuyWTmxR0=;
 b=nIep78jkuKQc4BI0nOSnTk/ZsmA0+SlWVLJ4O48RWf1iEI47Kmb/uTzL0Sl3ZUWTIS43
 Wtf7AgHV808nLgSM7DauPkWK2jsGhktrqpmuAW+AxyPfcNmST5+sJzviENRMh6sCsB9X
 igKIOBIpA7jG6c/UoHH6Y4U0CGsiG+joTt/NBoPqdKRZ0fMc1RY9DvtPlcmTqR1evoGO
 3El/MElIFVxKVS9W8/uVPyz6K1XxEXvUYgqpbC9cgvYE+d/10Z6WWBolI9xsZ7x4ILSg
 b2ixUuPPy5gzWXqC/zgJWs6ro60okEwZxs8gQ+YHkwj6znJ8iP7RNXoNc0Sa09HZrkNc vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthecmun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Mar 2024 19:46:25 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 424JZhDW019056; Mon, 4 Mar 2024 19:46:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wktj6agd3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Mar 2024 19:46:24 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 424JkE4A038523;
 Mon, 4 Mar 2024 19:46:23 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-196-188.vpn.oracle.com
 [10.39.196.188])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3wktj6ag50-7; Mon, 04 Mar 2024 19:46:23 +0000
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
Subject: [PATCH v1 6/8] virtio-ccw: Lock ioeventfd state with
 VIRTIO_F_NOTIFICATION_DATA
Date: Mon,  4 Mar 2024 14:46:10 -0500
Message-Id: <20240304194612.611660-7-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240304194612.611660-1-jonah.palmer@oracle.com>
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_15,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040152
X-Proofpoint-ORIG-GUID: LBnr6GJBu_KScHSE82TyjDoNEH_nSzuI
X-Proofpoint-GUID: LBnr6GJBu_KScHSE82TyjDoNEH_nSzuI
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

Prevent ioeventfd from being enabled/disabled when a virtio-ccw device
has negotiated the VIRTIO_F_NOTIFICATION_DATA transport feature.

Due to the ioeventfd not being able to carry the extra data associated
with this feature, the ioeventfd should be left in a disabled state for
emulated virtio-ccw devices using this feature.

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/s390x/virtio-ccw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index b4676909dd..936ba78fda 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -530,14 +530,16 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             if (ret) {
                 break;
             }
-            if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+            if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+                !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
                 virtio_ccw_stop_ioeventfd(dev);
             }
             if (virtio_set_status(vdev, status) == 0) {
                 if (vdev->status == 0) {
                     virtio_ccw_reset_virtio(dev);
                 }
-                if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+                if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+                    !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
                     virtio_ccw_start_ioeventfd(dev);
                 }
                 sch->curr_status.scsw.count = ccw.count - sizeof(status);
-- 
2.39.3


