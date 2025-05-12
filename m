Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B198C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVA0-0005Aa-PZ; Mon, 12 May 2025 11:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9i-0004Yn-Qr
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9g-0006jR-Ol
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:26 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9e5Q029137;
 Mon, 12 May 2025 15:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=b2Gof96PFupyFrPm2XbwGPJgdLp0usvNBsOTThxFgkw=; b=
 q2jyEbpwuUWzfKUvHStQi8nQtKhLmL5kanJiE8+1MH0Oh2TRyuQLWbciAGvORLVz
 Zuu7dZyztw1erLH7rbCWwGTxPyHJDFWsy9/Pdd1TzMS4+vdaNjRsddP74R4bQ+F1
 ztcWTUjzXWKVq5kaL4M1LM9gy5AqCOfzYbkNmX8s8UUxFmYDBQau5EhZdL6qC091
 ob3USwtRCQ3/2hnx1FF1Of/vNQSYmPlXC6hCB4Ka8Gag9Nv+/3EK3U5pu2qNs379
 0aZ9zyOuGGQHZZUCLMB37lCKhYhctvEIoTZ8OYHFtraLYtujrKFZ19mFEjdeSea7
 iWWOJ94VyP/+rPRuNLBf6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwju7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE7gRs002441; Mon, 12 May 2025 15:33:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5g030605;
 Mon, 12 May 2025 15:33:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-33; Mon, 12 May 2025 15:33:18 +0000
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
Subject: [PATCH V3 32/42] vfio/iommufd: export iommufd_cdev_get_info_iova_range
Date: Mon, 12 May 2025 08:32:43 -0700
Message-Id: <1747063973-124548-33-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=682214c0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=W7tdPdk9eiapbsINNfkA:9
X-Proofpoint-GUID: 7nWvVr44L-G0dYXK8YQ0G6BPrXDYT4lO
X-Proofpoint-ORIG-GUID: 7nWvVr44L-G0dYXK8YQ0G6BPrXDYT4lO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXwlVmieDeBIJx
 yjWxXFzphGu89U6SZFzMSF28R0PJII50WS78xzEjUlq7tHHwD1p5CxmagZL1u73iwoxv9whStBq
 S3wwLlBFhnboGI89VEpuW7+UiIQwtyXLbJTSwDzGGSIRH37KKEFXVU7/bDZFnmsthq/0lOCnWcE
 Vmc2RXKMqM0o0pnBSPU41uS3B8U56qBUlkdR5Bv02RdUV7+a05TKNS0PDCc5N6e6kw3PyOlQN3/
 Ir1JGZAKXgLGJzEJmBAwj6BQ0amdtsFAK8uPZ8rANpXlgLZwFf7jTOCV7R0Lcvs+p6UzT2T9aOt
 uvP8RCD79QTqdpEmPqUtStjhqN/MO8diONI0vJEoyhiUZURwsLxVRvUtQsbp2Yw1feidSJAzaDk
 UHoJcDs9hKIMUJQoghrxa6ecjnHhLeprpJR01xMdkzVPcbDj/4N2BofdeWleKiSGZ1WMHBBd
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Export iommufd_cdev_get_info_iova_range, for use by CPR in a subsequent
patch to reconstruct the userland device state.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/iommufd.c      | 4 ++--
 hw/vfio/vfio-iommufd.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6eb417a..f645a62 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -459,8 +459,8 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
     return ram_block_uncoordinated_discard_disable(state);
 }
 
-static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
-                                             uint32_t ioas_id, Error **errp)
+bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
+                                      uint32_t ioas_id, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
     g_autofree struct iommu_ioas_iova_ranges *info = NULL;
diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 07ea0f4..5615dcd 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -31,4 +31,7 @@ typedef struct VFIOIOMMUFDContainer {
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
 
+bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
+                                      uint32_t ioas_id, Error **errp);
+
 #endif /* HW_VFIO_VFIO_IOMMUFD_H */
-- 
1.8.3.1


