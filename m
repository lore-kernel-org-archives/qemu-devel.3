Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D387BC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9U-0003xO-8z; Mon, 12 May 2025 11:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9O-0003lI-SH
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9N-0006er-0i
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:06 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9jNZ003954;
 Mon, 12 May 2025 15:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=EmekNBTkl/BtARLpvHSO2n9sUsanO6iJMTvMr5B9Adw=; b=
 nt6BBFvLZ/ujvYFkjlhZ6OFbfZO2Zh4BS836rb91yrQMflIMmH8nJGxR9P9pRrY0
 ZtjAQit4ErsfF/ZnJd5yk3TZnBew7bvB/L9VwZhwfHqRzlia50jhBNT9ay2OM1Jr
 2w1b+qYwmIuOuUzM8ILTwY4GH+hssg5sh6eGcYoz0LKtV9Zoi/Ye+6SldjvGCFuZ
 tDcQ6VShdzeV/gcGlmXdGIlNQBaue1JRzE18CAEeiLwOm4jCi5jUu1iOaQd0NkNo
 BbewWe24nu6AOgiAGS9iBWpWHAYr/BpZm82ell4RmYixjc1DuK9YsKzK/lSDU4XG
 nlmWM7K9ywzi5q+Gxu2Cvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0epjsbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE8bfp002380; Mon, 12 May 2025 15:33:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3667r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:01 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk4s030605;
 Mon, 12 May 2025 15:33:00 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-9; Mon, 12 May 2025 15:33:00 +0000
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
Subject: [PATCH V3 08/42] vfio/container: export vfio_legacy_dma_map
Date: Mon, 12 May 2025 08:32:19 -0700
Message-Id: <1747063973-124548-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX9yR67nQ/D3T8
 9+H5BhKegh27OG1rCq1Esay527WzSA4SVmd+EDxqavdxshYU1OYU5UfHICAPksOYDgv3CM3h5eO
 DxMQlRKwKDo71rC7yX/+l51yJs7VF9Jx0kP8zhdYvn3SZhMpxCrNUTfCJhfXkQZ5bBxyqjNlC5i
 CaC9vxwD8QTP5JDJ03IdOXSpgXx8alq1nvAw9qAcnw9DR2XQMBMeGL7OtUx6/UJ4NlxqAmrS/Q9
 pHz/MdcNPMHoZVqSXHLhiaklxB5weFmc4o8nAZ05dLC/6m7p3xRb42tViQV8n4afcZ2t0/Np8ZG
 1IrrHnEfPLxOO3YqFltBejVQFqK/RcmnnM8yretfRy9CAA4WX5CaK4AJCjBAajCkrMrlFxWNkRM
 5SWIatOpUH0/we03le7h2dlxUesj76RxSZKs96ZV8yhCPGdcr5KnxVgjVjp8jeMl/KlUOD1t
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=682214ae b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=H5cwdl4v8wBIYuNaQqYA:9
X-Proofpoint-ORIG-GUID: hZZmI3bN4so-199AQBtO0Qtw6bQPjuBk
X-Proofpoint-GUID: hZZmI3bN4so-199AQBtO0Qtw6bQPjuBk
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

Export vfio_legacy_dma_map so it may be referenced outside the file
in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c                   | 4 ++--
 include/hw/vfio/vfio-container-base.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 278a220..a554683 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -208,8 +208,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                        ram_addr_t size, void *vaddr, bool readonly)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 1dc760f..a2f6c3a 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -186,4 +186,7 @@ struct VFIOIOMMUClass {
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
     VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                        ram_addr_t size, void *vaddr, bool readonly);
+
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
-- 
1.8.3.1


