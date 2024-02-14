Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B280C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 12:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEXy-0003Sa-J6; Wed, 14 Feb 2024 07:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXq-0003Oo-4l
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXn-0002a4-Fx
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:20 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EBlbeJ019218; Wed, 14 Feb 2024 12:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=MwyvA3gq7GPBR5S7Fs2XooWtR7OGtNIfR+fNtKH8n8U=;
 b=gb/xlPRaElYD7w5jXCUwzc8Xm+oXEE39rh9xvQNMEZ5PAOr0CdeTUCY4fzEwH4GU9Bib
 bcgbAT60vVRPnAXWnlh+2gA/OMLwPYr+VxrRF33TxacENh3Mqu4pgu+KbPUFfLlRNsCZ
 Ir4Bxp8NObpXlowS4sZ8Mnciale0P2IoHjxy0VvULc6kdLX35A6IPeInOX29FmZGOhcp
 JM8/zaeKLs49LAavTAVRk610ScHg/6uU4SoHPexZ1SOQR8GbwvogYqVWuLUmzQ4aD0Qm
 mPnlBu2gjFrDHj3ko2jCVn/yglmJOhewQnHlHzWxeaoxoTOciRCzMepftlxCsHduyFt+ KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8varg5d2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 12:39:18 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41ECKqpx013766; Wed, 14 Feb 2024 12:39:17 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3w6apbnn3q-13; Wed, 14 Feb 2024 12:39:17 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 12/12] vdpa: fix network breakage after cancelling migration
Date: Wed, 14 Feb 2024 03:28:02 -0800
Message-Id: <1707910082-10243-13-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: 7KPI141GI8qmONnyZoY-Wz-43a4XyM8V
X-Proofpoint-ORIG-GUID: 7KPI141GI8qmONnyZoY-Wz-43a4XyM8V
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

Fix an issue where cancellation of ongoing migration ends up
with no network connectivity.

When canceling migration, SVQ will be switched back to the
passthrough mode, but the right call fd is not programed to
the device and the svq's own call fd is still used. At the
point of this transitioning period, the shadow_vqs_enabled
hadn't been set back to false yet, causing the installation
of call fd inadvertently bypassed.

Fixes: a8ac88585da1 ("vhost: Add Shadow VirtQueue call forwarding capabilities")
Cc: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 004110f..dfeca8b 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1468,7 +1468,15 @@ static int vhost_vdpa_set_vring_call(struct vhost_dev *dev,
 
     /* Remember last call fd because we can switch to SVQ anytime. */
     vhost_svq_set_svq_call_fd(svq, file->fd);
-    if (v->shadow_vqs_enabled) {
+    /*
+     * When SVQ is transitioning to off, shadow_vqs_enabled has
+     * not been set back to false yet, but the underlying call fd
+     * will have to switch back to the guest notifier to signal the
+     * passthrough virtqueues. In other situations, SVQ's own call
+     * fd shall be used to signal the device model.
+     */
+    if (v->shadow_vqs_enabled &&
+        v->shared->svq_switching != SVQ_TSTATE_DISABLING) {
         return 0;
     }
 
-- 
1.8.3.1


