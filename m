Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7518E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 17:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIVH-0006pF-EF; Fri, 10 Jan 2025 12:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tWIVE-0006o4-Cy
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:08:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tWIVB-00055y-2Y
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:08:56 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AENWpt011289;
 Fri, 10 Jan 2025 17:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=Z4X9p
 dAtcIuUAr4xIUQlyk4R+cHWp5T5SvV8DQ7MnAQ=; b=A4vVxv5AfYgZC5WGcroSj
 5jYVEqE2OSsQY5Wqe7PbRRVnA1mpg6MTAfZUL6qy1zCRhbVttMBEizF1nJLm/QCa
 /AOaMjdjXRcNvPUAMcA4fn+HBZDcGYJzANhap8Bq+SDRCNiuFA6HesTnoJ/z7PON
 56WjgvI4iZXPK+GTXdUvWnfhRHcTPRgvaEJA8N8jCXiq3FoXXSgDt8lX/3ZuGGJf
 IPWNGUV4pX3G27pN9tFAZGRKsLfxzCucxJTl5MNwlrlZZn35dkM//mzMGLilBCer
 wue51v8q82rlGCCk5raDik4Evn0WcIaxNc89LX9dRm1V4G5w3gY2eLnnBTni5nKR
 Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442b8ujw5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 17:08:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50AFQHYK004832; Fri, 10 Jan 2025 17:08:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xuecp0uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 17:08:48 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50AH1lkQ031831;
 Fri, 10 Jan 2025 17:08:48 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-193-76.vpn.oracle.com
 [10.39.193.76])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 43xuecp0qc-3; Fri, 10 Jan 2025 17:08:48 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v3 2/5] vhost-iova-tree: Remove range check for IOVA allocator
Date: Fri, 10 Jan 2025 12:08:31 -0500
Message-ID: <20250110170837.2747532-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250110170837.2747532-1-jonah.palmer@oracle.com>
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_07,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=921 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100134
X-Proofpoint-ORIG-GUID: jFihRy2b98oZ3doTjL22JwB77mtXznvs
X-Proofpoint-GUID: jFihRy2b98oZ3doTjL22JwB77mtXznvs
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.369,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

Removes the range check portion in vhost_iova_tree_map_alloc.

The previous patch decoupled the IOVA allocator from adding mappings to
the IOVA->HVA tree (now a partial SVQ IOVA->HVA tree) and instead adds
the allocated IOVA range to an IOVA-only tree. No value exists under
translated_addr for the IOVA-only mappings, so this check is no longer
needed.

This check was moved to vhost_iova_tree_insert in the previous patch
since that function handles adding IOVA->HVA mappings to the SVQ
IOVA->HVA tree.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-iova-tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index b1cfd17843..f6a5694857 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -93,8 +93,7 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
     /* Some vhost devices do not like addr 0. Skip first page */
     hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
 
-    if (map->translated_addr + map->size < map->translated_addr ||
-        map->perm == IOMMU_NONE) {
+    if (map->perm == IOMMU_NONE) {
         return IOVA_ERR_INVALID;
     }
 
-- 
2.43.5


