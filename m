Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A25C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 12:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEXn-0003Lo-Nd; Wed, 14 Feb 2024 07:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXi-0003If-PT
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXh-0002Xw-7a
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EC4oAe015187; Wed, 14 Feb 2024 12:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=D1+WcSGEoC3bI1zoR2QKwGGpNmJHUDNN467lbXVCSGM=;
 b=JYA32NxKBYbsSmo6TnB9+3OA5mLxbfgy1dvt3GzcnpyQ0IzEh9aPU+2LjMlHcm/Efpyl
 iZAMQai1kgP7urFy6WyomRbMHRHUpUt4g10nySkCghgkzGIDp9bGmaz5a8zfcVcemktu
 r5Mr1blHdWJa7y+q2VwyT9XlbMCu3rHFdirEramVtyb+8FC5Xuwq/5r4zyy6ElS5Dz+4
 3h+ygzuxGtQ1SpQRkm1gcGfi62wneOMmEGF0cWgIYCYGPiHcl7KyKsnNAgUnhFvie0aJ
 XpsBAxlpc8+GYE/qXL6jr4aX+n/Je1DLyUbqPe+XwAh3Wk5nMKrr5UoUFNFqQknjQVdo Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8w6v81sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 12:39:10 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41ECKqpo013766; Wed, 14 Feb 2024 12:39:09 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3w6apbnn3q-8; Wed, 14 Feb 2024 12:39:09 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 07/12] vdpa: add vhost_vdpa_set_dev_vring_base trace for svq
 mode
Date: Wed, 14 Feb 2024 03:27:57 -0800
Message-Id: <1707910082-10243-8-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: KuRMhGS3BFAHqfXYYdkH9AyXNXwtkeH3
X-Proofpoint-ORIG-GUID: KuRMhGS3BFAHqfXYYdkH9AyXNXwtkeH3
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

For better debuggability and observability.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/trace-events | 2 +-
 hw/virtio/vhost-vdpa.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 28d6d78..20577aa 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -57,7 +57,7 @@ vhost_vdpa_dev_start(void *dev, bool started) "dev: %p started: %d"
 vhost_vdpa_set_log_base(void *dev, uint64_t base, unsigned long long size, int refcnt, int fd, void *log) "dev: %p base: 0x%"PRIx64" size: %llu refcnt: %d fd: %d log: %p"
 vhost_vdpa_set_vring_addr(void *dev, unsigned int index, unsigned int flags, uint64_t desc_user_addr, uint64_t used_user_addr, uint64_t avail_user_addr, uint64_t log_guest_addr) "dev: %p index: %u flags: 0x%x desc_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" log_guest_addr: 0x%"PRIx64
 vhost_vdpa_set_vring_num(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
-vhost_vdpa_set_vring_base(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
+vhost_vdpa_set_dev_vring_base(void *dev, unsigned int index, unsigned int num, bool svq) "dev: %p index: %u num: %u svq: %d"
 vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int num, bool svq) "dev: %p index: %u num: %u svq: %d"
 vhost_vdpa_set_vring_kick(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
 vhost_vdpa_set_vring_call(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 0de7bdf..004110f 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -972,7 +972,10 @@ static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *config,
 static int vhost_vdpa_set_dev_vring_base(struct vhost_dev *dev,
                                          struct vhost_vring_state *ring)
 {
-    trace_vhost_vdpa_set_vring_base(dev, ring->index, ring->num);
+    struct vhost_vdpa *v = dev->opaque;
+
+    trace_vhost_vdpa_set_dev_vring_base(dev, ring->index, ring->num,
+                                        v->shadow_vqs_enabled);
     return vhost_vdpa_call(dev, VHOST_SET_VRING_BASE, ring);
 }
 
-- 
1.8.3.1


