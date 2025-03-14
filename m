Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC28DC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4gT-0005iC-Q9; Fri, 14 Mar 2025 09:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tt4g9-0005cb-Bo
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:02:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tt4g5-0005w0-V8
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:02:20 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBlrrp017187;
 Fri, 14 Mar 2025 13:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ublP1djrFks7Z6rsiOBVk+yhxjiYcY6fr2Ecz+OIuyk=; b=
 PoPO0HJWSUa0ALpv0R82VaD9HF5QnFx5WoEqHJrUD/VCrk4Y+9++dMRRtqle7ZT0
 K593bJkaPuYUdIATYvzI1UzeQmOaIlw4ibZUqpUbBuBhX4PTDHXLIy5RCMvaqEvW
 2JmuR/qozuk429XyKYtyCwZOgqFUiVj/Dt7aR4GqzKB1X0BRlQ9OiDm4Vu4MxyX2
 LvTE10eMOSfejWxauG9o4I1kr+8xVnR0OqtKTE08kURKYk9qucS8eYB3VhxMMU6J
 8RGPABUbXAMj8p5yZWpEz2UT83HjvAGdOp+7lofLhFkHCJAwPvSGq9Q+xmuInSUr
 WrvKEPsQdf8ZjAL7ZxSxVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dpesu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 13:02:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52ECm6Qp012272; Fri, 14 Mar 2025 13:02:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45atn41d40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 13:02:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52ED27RD015104;
 Fri, 14 Mar 2025 13:02:11 GMT
Received: from jonah-ol8.us.oracle.com
 (dhcp-10-43-73-135.usdhcp.oraclecorp.com [10.43.73.135])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 45atn41d05-4; Fri, 14 Mar 2025 13:02:10 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 jasowant@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyan@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v3 3/7] vdpa: set backend capabilities at vhost_vdpa_init
Date: Fri, 14 Mar 2025 09:01:50 -0400
Message-ID: <20250314130204.11380-4-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250314130204.11380-1-jonah.palmer@oracle.com>
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503140103
X-Proofpoint-GUID: QB74eKSIpJzYUNYNnyUumcoGDSD3YiH6
X-Proofpoint-ORIG-GUID: QB74eKSIpJzYUNYNnyUumcoGDSD3YiH6
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
index 79224d18d8..939a5a28a1 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -636,6 +636,12 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
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
@@ -1565,7 +1571,6 @@ const VhostOps vdpa_ops = {
         .vhost_set_vring_kick = vhost_vdpa_set_vring_kick,
         .vhost_set_vring_call = vhost_vdpa_set_vring_call,
         .vhost_get_features = vhost_vdpa_get_features,
-        .vhost_set_backend_cap = vhost_vdpa_set_backend_cap,
         .vhost_set_owner = vhost_vdpa_set_owner,
         .vhost_set_vring_endian = NULL,
         .vhost_backend_memslots_limit = vhost_vdpa_memslots_limit,
-- 
2.43.5


