Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEE5C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 17:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKM1h-0008Gn-6x; Thu, 20 Jun 2024 13:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sKM1P-0007u2-Jy; Thu, 20 Jun 2024 13:56:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sKM1N-0005X4-Ro; Thu, 20 Jun 2024 13:56:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHBHgF030769;
 Thu, 20 Jun 2024 17:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 corp-2023-11-20; bh=F5TLKDfjBB7mwqJGVlHMC/XnQgarvAemroewf5Vljas=; b=
 YDGlbU9ecsNW7Ez8sUw0v+6RMyWQGS/zuTzw65XqSFd9hDTvdj0tZF4HSXpG/X6F
 CkhaHxvhoJ8//1lKeskmzMpgK6nDgf65Ba+7uD0mYhCFabIpo906a33XIGInE/lf
 FXolYHkKW7smKKr8Er3UKVEz7cqtUkA4Io9Lz/QwnXOVd6fnjepouZMJCHPQukMg
 JOZBJ2qbWLvAS+OD41RYEhXWAvu2s6xxMe/Ui1/pMmb3ZR+acCXqEDGdGo8pzD+t
 Jggh/cyL9ByF6Bxw4Cxd19zqc6WcvleRJrlgz2qO+n4TqxNKcmIviSKYECz0xEhS
 dvAoS9kIQfrz+4D3I4zHlQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkgr313-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2024 17:56:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45KHDrcw012888; Thu, 20 Jun 2024 17:56:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yvrn3hnp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2024 17:56:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45KHuF0n018715;
 Thu, 20 Jun 2024 17:56:19 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-208-85.vpn.oracle.com
 [10.39.208.85])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3yvrn3hnjv-3; Thu, 20 Jun 2024 17:56:19 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 eperezma@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v3 2/6] virtio: virtqueue_pop - VIRTIO_F_IN_ORDER support
Date: Thu, 20 Jun 2024 13:56:06 -0400
Message-ID: <20240620175612.2381019-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175612.2381019-1-jonah.palmer@oracle.com>
References: <20240620175612.2381019-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406200129
X-Proofpoint-GUID: Hql_KFXDWPX99xTBHDBOfVxJaS5Dh1m1
X-Proofpoint-ORIG-GUID: Hql_KFXDWPX99xTBHDBOfVxJaS5Dh1m1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add VIRTIO_F_IN_ORDER feature support in virtqueue_split_pop and
virtqueue_packed_pop.

VirtQueueElements popped from the available/descritpor ring are added to
the VirtQueue's used_elems array in-order and in the same fashion as
they would be added the used and descriptor rings, respectively.

This will allow us to keep track of the current order, what elements
have been written, as well as an element's essential data after being
processed.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 893a072c9d..9cbf75f021 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1630,6 +1630,12 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
         elem->in_sg[i] = iov[out_num + i];
     }
 
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
+        vq->used_elems[vq->last_avail_idx - 1].index = elem->index;
+        vq->used_elems[vq->last_avail_idx - 1].len = elem->len;
+        vq->used_elems[vq->last_avail_idx - 1].ndescs = elem->ndescs;
+    }
+
     vq->inuse++;
 
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
@@ -1758,6 +1764,13 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
 
     elem->index = id;
     elem->ndescs = (desc_cache == &indirect_desc_cache) ? 1 : elem_entries;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
+        vq->used_elems[vq->last_avail_idx].index = elem->index;
+        vq->used_elems[vq->last_avail_idx].len = elem->len;
+        vq->used_elems[vq->last_avail_idx].ndescs = elem->ndescs;
+    }
+
     vq->last_avail_idx += elem->ndescs;
     vq->inuse += elem->ndescs;
 
-- 
2.43.0


