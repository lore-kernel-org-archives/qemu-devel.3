Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AE7C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKist-0004Md-Gu; Thu, 29 May 2025 15:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKise-0004Hi-7k
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisb-0000U4-CB
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:31 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGftFf009742;
 Thu, 29 May 2025 19:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=/D9wW0mRZzt6Ou73lroYyqJm0hbT81dO0cpTqm3Jd18=; b=
 rA22uGM0KqV7Y9zD4AwRMRcgUXUGeAxDw/oNLxror7mQctRH1mqqiHpzrsAQp/tO
 /Pi8QxR7ARod6YIFcHhZSU6Zi7XwKvAgymMlUlQcYfkFH0772BIk/jXmjoR8/35f
 /prZe3meYx/yM4iikjt6AEai39tREdKlgfswPtZ7+dp8IHHEpdBfoBFj6lyIrM6V
 7NXpNPGNQw7ByQ/UXFbdb6BWhNoilJihCPQx/fDgLq0Oue0VBJnOpqnHRahTOFE8
 COkVuCRxxFJ1cRM+5Opg+HhxVVqjmfFiVbrmyFsk0kv9foETq2sJKIr0Z8fvJTzJ
 aPQ0svPJGu374lw0aINTTA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u0yvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THf60M020366; Thu, 29 May 2025 19:25:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4wbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:15 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeSB022158;
 Thu, 29 May 2025 19:25:15 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-43; Thu, 29 May 2025 19:25:15 +0000
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
Subject: [PATCH V4 42/43] iommufd: preserve DMA mappings
Date: Thu, 29 May 2025 12:24:38 -0700
Message-Id: <1748546679-154091-43-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: xMo3k4uHFCkd08irj49_MRTN2jjq6LPj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX3ThiWXkcKB2U
 yOUEvNOKmktucWHDT/iQsADjOcy3UKfQHMgQFWtce5nTgMeNw8oMxElL4OPsPgRe4I0dgU4204R
 WN+/Nxc54l9Jp0Is+GmQ9nMK/pzGFJ3Sdsy+YxhPJ8ZB4XkKseCjUAWhWIUZPHOVBHzTzKMs29O
 qOF+H4khFnjfzaFVjyxTu1uPWmZJiNXQmddfi2EKVHAoqObFmDJ0mKvx25ClsrZIC9DZ3pHKwoV
 6+DeAptheddJ8ciPd2PxOjCMczb7gbEP5X30FE6LNypSD02XOYWqL28vhBDbC8v5LBGBefm5EYi
 t9xczqnFAx69sJ3S3YH/Ibdl+O1fRQiwbvg6EtsJFcIQAIiJ+bW385L6LMajMMiurvJVUJjKHEg
 KBFpMYnYpszYx+dAyWm5cRyDmJcokfaKKn/IF/gh5SSDmVqK/y+EB9OOdFBIwwD2bJtHOPLR
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6838b49c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=jxt47dSdNjvG7kEyeNwA:9
X-Proofpoint-ORIG-GUID: xMo3k4uHFCkd08irj49_MRTN2jjq6LPj
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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
device in old QEMU, so suppress the map and unmap callbacks during incoming
CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 98d83aa..62d1f71 100644
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


