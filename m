Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B423C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVB1-0006HY-Kj; Mon, 12 May 2025 11:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9x-0004vE-4E
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9v-0006lb-Cl
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9ecn029129;
 Mon, 12 May 2025 15:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=XLrCTKGFruf0GPFNWdhqLbN5dikVH5O0REmxBHoChLk=; b=
 fyBrvh0RfV1kfI8ro3qAnxsH1JuzmfCn1hgit9BjjsK/CENEvKrct1tSMo+qzhKi
 6maV0egpQumr9pw9JzHoFsG+DCDoagEI46VHUWqmJn8seBnPcl6aNdEiqqwEO0H7
 WTDwCz7pWkNrr1Yu093cS7PlZkQlDwaHfF+nlzmwM2ni9NV/ToEsNzNzbohhYQ7f
 oEpCDm/KPhTw6jvhF91+mn4O9wWmiDxwRV7ye1N2BeiO3ldYeQy+uehVuQOy2VHG
 LuYGlk0uCAH/6DzIERTlQ5LByu4dRUFXtPTSZt6GhYoWU/N8hkIwpsM02aHf6ZXQ
 KXu5UR+7MWzu6Zv5TOzRlg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwju7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE4OLT002600; Mon, 12 May 2025 15:33:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366vw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk60030605;
 Mon, 12 May 2025 15:33:24 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-42; Mon, 12 May 2025 15:33:24 +0000
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
Subject: [PATCH V3 41/42] iommufd: preserve DMA mappings
Date: Mon, 12 May 2025 08:32:52 -0700
Message-Id: <1747063973-124548-42-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=682214c6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=jxt47dSdNjvG7kEyeNwA:9
X-Proofpoint-GUID: dVN9o5_IGwPceBqlh1Pzopel8Z2A7NUG
X-Proofpoint-ORIG-GUID: dVN9o5_IGwPceBqlh1Pzopel8Z2A7NUG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX5/atHVjcsERy
 PAVIdOisla8fFs6qvKttErG7Ea1ox1c8UGJLfwIBbQIiRGsST/p31Hgf/dUUxqMYVql2xrwm1jw
 mWYo9YcWXGvq9QS8wfaBsFgMFIIL55dnXoTXEWLnck9LgZ1ntOkp5llAdIqsZW8V4v0TWHT5ugl
 6TBpZZ0wW/nZcWdmliYGViIk148czEOkTD8sErkrB9wt7wsOnjMjsxwWHRjLSEmiYYrKASM5778
 B7tAtCfO8rxju4NyxwBrXF0/2ga4Mwx0ue/gEf14sVTUEQfXRKoC0mj8C4MDKFSfxo/jdL7CDZF
 DohRUY0rQif+GFQBWjYtJ3Ds8/X27OVX8KfZrombqjxz4l2uSA7NbqDEMnHph4c+wQicyGAD7pz
 OMuWX2RpL4150v13wnmzZ+l/DC87b5qUM1N9TUZ5EAM7RWX5nufb+YZEeKYcKxvCsKqeWmzN
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

During cpr-transfer load in new QEMU, the vfio_memory_listener causes
spurious calls to map and unmap DMA regions, as devices are created and
the address space is built.  This memory was already already mapped by the
device in old QEMU, so suppress the map and unmap callbacks during CPR --
eg, if the reused flag is set.  The reused flag is cleared in the post_load
handler.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c    | 8 ++++++++
 hw/vfio/cpr-iommufd.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 492747c..c765f2d 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -209,6 +209,10 @@ int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
         .length = size,
     };
 
+    if (be->cpr_reused) {
+        return 0;
+    }
+
     if (!readonly) {
         map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
     }
@@ -240,6 +244,10 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
         .length = size,
     };
 
+    if (be->cpr_reused) {
+        return 0;
+    }
+
     ret = ioctl(fd, IOMMU_IOAS_UNMAP, &unmap);
     /*
      * IOMMUFD takes mapping as some kind of object, unmapping
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 67be775..9680f5a 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -67,6 +67,7 @@ static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-iommufd-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .priority = MIG_PRI_LOW,   /* Must happen after devices and groups */
     .pre_save = vfio_container_pre_save,
     .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
-- 
1.8.3.1


