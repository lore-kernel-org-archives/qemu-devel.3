Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6DFC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwSu-0004PU-KH; Fri, 14 Feb 2025 09:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSt-0004Ox-QR
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSs-0004SU-CD
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:47 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtRAx011445;
 Fri, 14 Feb 2025 14:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=Uq/w+DXMHomToGU2bYKJT7qBPRUqltM3NGgb7hJdbvA=; b=
 Q3V76ZSgefR0rs8plV3i6apVA/i1zhnLyaT3xm0pCtJHMSyxbv290rTdv3W5H0Bf
 5WFzsoHlniYJQlarRfI0YYOGYXFSGofQ/toTDhy5XCXTXobLuSrjXxzlH+WYzDCf
 zvh3KZCSZqNxUcjWAD9S9iJhnjwsTBSAd41BTUdmYbjVdAwcAT12A/2Cw75GXXud
 XlNAg/BPBuk9ac/W0r5RxUnBv7oN5TAY+fFu1fMP0ibRblJs3dVqOhoiCKiYipQp
 bUlI71dSH0eBYJuHpTPueSJPGcV06tkNGJNkLQGxLADKsjzTWxIWm2vADX+aboTj
 tdM254GrxTgJ9I+eN2oQMQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqbwmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECxs2X025360; Fri, 14 Feb 2025 14:14:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksg90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPX006920;
 Fri, 14 Feb 2025 14:14:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-11; Fri, 14 Feb 2025 14:14:42 +0000
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
Subject: [PATCH V2 10/45] vfio/container: export vfio_legacy_dma_map
Date: Fri, 14 Feb 2025 06:13:52 -0800
Message-Id: <1739542467-226739-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-ORIG-GUID: PmCt7Nza1NjjnMBDL9F7SkI-bQUmyz9_
X-Proofpoint-GUID: PmCt7Nza1NjjnMBDL9F7SkI-bQUmyz9_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Export vfio_legacy_dma_map so it may be referenced outside the file
in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c           | 4 ++--
 include/hw/vfio/vfio-common.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 21f2706..931c435 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -176,8 +176,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     return 0;
 }
 
-static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                        ram_addr_t size, void *vaddr, bool readonly)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 780646e..7f33476 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -280,6 +280,9 @@ void vfio_reset_bytes_transferred(void);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
+int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                        ram_addr_t size, void *vaddr, bool readonly);
+
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info);
-- 
1.8.3.1


