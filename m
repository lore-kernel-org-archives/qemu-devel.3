Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F92FC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjng-0001xz-30; Wed, 07 May 2025 14:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjna-0001uV-KJ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnZ-0004rO-1B
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:18 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547ILdjY019143;
 Wed, 7 May 2025 18:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=5dek9YSXT8NlCdPBSBT4Iaj628VDwxiAIfKZ63Ecuso=; b=
 IG3PTCoaGkvFkLBofv5/LntvBi2LFdVWRB9qLSWKxQRpZSE2Z8i/G+EB7Ne2SWsG
 oT7fx+qlneR5kZ05BCzXQbyDO/LcdPPUSnkqwYygJD70aA8OOSq9I2hOczecOcse
 GHthuDEkuLsLSz6euxwBDA0ihP/KuDhkSCGACgZBMRMHqluQhzCVnk6iGAqcx5sA
 mX/stsDfutAAmxIkitAPUgTw8eX1uyoSqcQJyStkNpnySCMRQKjUuxsPjPsjjJ9K
 AEVDYaLnRtic/uQRoHktgGDVgZPQBxLBgc/jQoLMVYvMIUL8q0OaclZ6X9yxOYQI
 F8LEkGL9Laa8y/Dmh7+mKg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gcqrg23p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 547I5imN036206; Wed, 7 May 2025 18:47:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46d9kbhdbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:13 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 547Il3j1029452;
 Wed, 7 May 2025 18:47:12 GMT
Received: from dhcp-10-43-71-250.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-250.usdhcp.oraclecorp.com [10.43.71.250])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46d9kbhd41-4; Wed, 07 May 2025 18:47:12 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com
Subject: [PATCH v4 3/7] vdpa: set backend capabilities at vhost_vdpa_init
Date: Wed,  7 May 2025 14:46:43 -0400
Message-ID: <20250507184647.15580-4-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507184647.15580-1-jonah.palmer@oracle.com>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070170
X-Proofpoint-GUID: _2tMPaJ0QP-qL1d5LqUN9hFUY-pe3Ky-
X-Authority-Analysis: v=2.4 cv=aJHwqa9m c=1 sm=1 tr=0 ts=681baab2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=DFJfL8PK9GXO38_WzYsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _2tMPaJ0QP-qL1d5LqUN9hFUY-pe3Ky-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3MCBTYWx0ZWRfX7tKwoaWoOxNd
 43jBKpj0ADxWTePt62cC7iJCWeVa0weeYU57OeGGhejjWNbHZUtgcJZAM9i4qHudVF1rvYLBtDP
 2/vo/S3a9ged625HzL+rKAYvAFkhUEAZP8fCbpUrkCsC83NSlhnKJY7V/c5EBHOevftBTSlU1cF
 B9ZjXPcL/76k8Yk5dB3YkxHjVbxuacwoZMAIavZ80Dz928904E28VO/zDWtfdy4IMJiQzLbKu8I
 A4Mpq+IUaJWBl5YBfNF7jsy0tCYbcjIbqQgBIScXUUH7wjuVyikA0//yplLY4wFZJOLKV2eXOge
 6NnXuMhmM8qJAuNp5TIJgeYK/ExCr6XkSVTnC78tYQ+/v8UyeuEZ0yPE23RZheonXq2Ls5+FO6g
 gfWhT4IiRaqrp3buykjIm/LIHw7F14hL0fcognCyKQWbzcUcTxuWj2/5LVkFdKl/mdIXMH9x
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eugenio Pérez <eperezma@redhat.com>

The backend does not reset them until the vdpa file descriptor is closed
so there is no harm in doing it only once.

This allows the destination of a live migration to premap memory in
batches, using VHOST_BACKEND_F_IOTLB_BATCH.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 6b242ca56a..e9826ede2c 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -634,6 +634,12 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
     v->dev = dev;
     dev->opaque =  opaque ;
     v->shared->listener = vhost_vdpa_memory_listener;
+
+    ret = vhost_vdpa_set_backend_cap(dev);
+    if (unlikely(ret != 0)) {
+        return ret;
+    }
+
     vhost_vdpa_init_svq(dev, v);
 
     error_propagate(&dev->migration_blocker, v->migration_blocker);
@@ -1563,7 +1569,6 @@ const VhostOps vdpa_ops = {
         .vhost_set_vring_kick = vhost_vdpa_set_vring_kick,
         .vhost_set_vring_call = vhost_vdpa_set_vring_call,
         .vhost_get_features = vhost_vdpa_get_features,
-        .vhost_set_backend_cap = vhost_vdpa_set_backend_cap,
         .vhost_set_owner = vhost_vdpa_set_owner,
         .vhost_set_vring_endian = NULL,
         .vhost_backend_memslots_limit = vhost_vdpa_memslots_limit,
-- 
2.43.5


