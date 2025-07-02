Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4257C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5U9-0003Vb-9D; Wed, 02 Jul 2025 17:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U7-0003Ur-8j
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U5-0003lD-SI
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQeR9025466;
 Wed, 2 Jul 2025 21:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=A2iw9xMEROQhItLWlKKFEYuuia/3fs0O33KjNbXWGo0=; b=
 qIAtzyabL8pz8aLZvDJ+0z6XcDyqpUUEDSdKQ/UHPoe5qqzz38UfWX646eYc4YH+
 Yb/3BbEThuL1f3cPUmYpu8BQvi4J9ykq0Cmi+r1Au1JEcBfWEp9lR0W2+qsr3iq+
 Vc5KxYzMtx9SLVQtTPtekKNy0UA0Ee8QcRcdRwjGnZfoNyRE22njsAT8auogGI7j
 IsKluEcVQCh5oGm4ZCigQQMv8iTgx7bxAXvBXtUWXnTu6OdqabFtHhd9drJezTXJ
 gVm+BlACgkSxmLq56QynZNiWA+YSjr7JVMKuATblaezVGtbmYRGSdW/mawVe2Bi8
 1wr6gozLQGCCZNN4FJohOw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tffvgg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LoTe5033766; Wed, 2 Jul 2025 21:59:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:14 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgW020012;
 Wed, 2 Jul 2025 21:59:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-20; Wed, 02 Jul 2025 21:59:13 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 19/21] iommufd: preserve DMA mappings
Date: Wed,  2 Jul 2025 14:58:56 -0700
Message-Id: <1751493538-202042-20-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6865abb3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=jxt47dSdNjvG7kEyeNwA:9
X-Proofpoint-GUID: tbev4fqQuwKFOKrhIt4S1jA-j1V_wP33
X-Proofpoint-ORIG-GUID: tbev4fqQuwKFOKrhIt4S1jA-j1V_wP33
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX6vJ6gZAc3Q8k
 V7QCPQTNj+HP27acEYOShsklS0sDjJRLSqbzNlTR+5ofFPGI18Zws4s1sUFznMrjw9RQIoe38BO
 vQmAttRXMWZJJSi+8f1bKUqvAalFRwAuuRsVUJa1T8Pk76odhhr4Ib3c+gw+1rRIKjaV9jOBalo
 hqbUamu5oeaMpDsz4J/Jw+s00E6XFEL7vC3LmN7nDadwqaYjjjgP8Zsd2gavCUmRty4VQgiUyxP
 kg38sPZzxRaO/SbyN8PSz5JD/fqxUxq1QlraTg9AeU4aG5iFdFKvPcT9gty9Z9kDo2ngyi8yhcQ
 J4x/mphEnFBYawKv+F4LZSe+flgAOsvCzx0e5ryyDQ6miSyd7yTfFkiY7ugEirJ+XEScPz5JuNt
 Db7TYpav1wykxWBQT9hL+c5UuJemygzWGpjTvVhtqYbPG4qPxZ433Z2s21Ow93N9WjCGDBVz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

During cpr-transfer load in new QEMU, the vfio_memory_listener causes
spurious calls to map and unmap DMA regions, as devices are created and
the address space is built.  This memory was already already mapped by the
device in old QEMU, so suppress the map and unmap callbacks during incoming
CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 backends/iommufd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index e091792..2a33c7a 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -245,6 +245,10 @@ int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
         .length = size,
     };
 
+    if (cpr_is_incoming()) {
+        return 0;
+    }
+
     if (!readonly) {
         map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
     }
@@ -274,6 +278,10 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
         .length = size,
     };
 
+    if (cpr_is_incoming()) {
+        return 0;
+    }
+
     ret = ioctl(fd, IOMMU_IOAS_UNMAP, &unmap);
     /*
      * IOMMUFD takes mapping as some kind of object, unmapping
-- 
1.8.3.1


