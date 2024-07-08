Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C513C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpSF-0005Iq-Qs; Mon, 08 Jul 2024 10:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpS8-0004iw-Vc
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpS7-0002XU-Dm
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:52 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fWc8004202;
 Mon, 8 Jul 2024 14:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=h
 6QCvrXNXbMo96ylbAuUbody2amhcysKXy86lcrhEOE=; b=S3sKXGhx0/IKiu6Xd
 UvrtSW41wR/HChUsuT9GTgzwamTgomGW2hHe9DPdJWNZcHA3VO7OogfFPPH8gJvp
 ZFP63LOPt8odd07yYVAWxerDGxYNciWNwypmO/4+clFT1+6gs7Kxo97iRd8wgkc7
 9QXnXi7li7ti1y1i4U+tV+OvXwmwV2yK5pirWHR0HViwB4/rN3B4hVU+m3x3uzPm
 omgldXlT1/Po4Gn8A8pAJ5/Au3+S6eAHbBSYVVC9/oqS1X0KEB/oaVwIeb4b2EHl
 jVtnqqPzlNG2czlrz02ds2/pVs2VYtlJdT5/rHhYImqkXTIcnMNNXkoRZUsBfgXd
 3vJPA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8as74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 468DF53V007576; Mon, 8 Jul 2024 14:34:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu1r751-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:47 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 468EXkZL037381;
 Mon, 8 Jul 2024 14:34:47 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-56-128.vpn.oracle.com
 [10.175.56.128])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 407tu1r6ms-10; Mon, 08 Jul 2024 14:34:47 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 09/10] vfio/migration: Don't block migration device dirty
 tracking is unsupported
Date: Mon,  8 Jul 2024 15:34:19 +0100
Message-Id: <20240708143420.16953-10-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-1-joao.m.martins@oracle.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=885
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080109
X-Proofpoint-GUID: j2Ekyn-hqIH0sCttE1hBhLfbraXQYpNq
X-Proofpoint-ORIG-GUID: j2Ekyn-hqIH0sCttE1hBhLfbraXQYpNq
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

By default VFIO migration is set to auto, which will support live
migration if the migration capability is set *and* also dirty page
tracking is supported.

For testing purposes one can force enable without dirty page tracking
via enable-migration=on, but that option is generally left for testing
purposes.

So starting with IOMMU dirty tracking it can use to acomodate the lack of
VF dirty page tracking allowing us to minimize the VF requirements for
migration and thus enabling migration by default for those.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/migration.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 34d4be2ce1b1..89195928666f 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1012,6 +1012,7 @@ void vfio_reset_bytes_transferred(void)
  */
 bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 {
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(vbasedev->hiod);
     Error *err = NULL;
     int ret;
 
@@ -1036,7 +1037,10 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    if (!vbasedev->dirty_pages_supported) {
+    if (!vbasedev->dirty_pages_supported &&
+        (vbasedev->iommufd &&
+         !hiodc->get_cap(vbasedev->hiod,
+                         HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL))) {
         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
             error_setg(&err,
                        "%s: VFIO device doesn't support device dirty tracking",
-- 
2.17.2


