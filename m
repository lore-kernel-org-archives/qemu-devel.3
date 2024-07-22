Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7666AC3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0ML-0002Cl-TS; Mon, 22 Jul 2024 17:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0MH-0001w0-QG
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0ME-0006RD-E8
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:13 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MKtf7c029624;
 Mon, 22 Jul 2024 21:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=i
 t5gHDkbe+9G6naJjQV0IFhHjLF/UM6ENZP2pWprYUc=; b=VNyBmd+qfaCFrRlL9
 5bfSonN00XOxgoI/q4XHK3703n4vS749Vl32VOpjipZ4SoTGUj5Lq12K88pR7OYO
 LfJ4gcXcOshtWOijlIRWWC2Ds/+InbT4dVYxxg7/vXug8XhjEI30frdJQF5BAZZm
 7fwt8L4rSHEbsi2vkqflTb/h45HXLIFU+kX73DavrFmjjeUNPBaldIakbvb4LCGr
 vunm0LM/wVDPdg0mkidOt7RJi36bjx3JMmAQXD/qwN5UR0lSynjYyqDR8RMaejs8
 W6zIfw31ZRnDHHKtnlVXgYiVenfLNJCrI2rVG6TAIM+r6REPtKr1YIOGnZE7c9rW
 IglZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe7bskh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:14:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MKPefb010962; Mon, 22 Jul 2024 21:14:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29qa7ma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:14:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46ML6txH040372;
 Mon, 22 Jul 2024 21:14:06 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-61-12.vpn.oracle.com
 [10.175.61.12])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 40h29qa7av-9; Mon, 22 Jul 2024 21:14:06 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v6 8/9] vfio/migration: Don't block migration device dirty
 tracking is unsupported
Date: Mon, 22 Jul 2024 22:13:25 +0100
Message-Id: <20240722211326.70162-9-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-1-joao.m.martins@oracle.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_14,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=898 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220157
X-Proofpoint-GUID: JjT9L4azc0Ei7p4gCSrrsyRb5YRbHUOF
X-Proofpoint-ORIG-GUID: JjT9L4azc0Ei7p4gCSrrsyRb5YRbHUOF
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

By default VFIO migration is set to auto, which will support live
migration if the migration capability is set *and* also dirty page
tracking is supported.

For testing purposes one can force enable without dirty page tracking
via enable-migration=on, but that option is generally left for testing
purposes.

So starting with IOMMU dirty tracking it can use to accomodate the lack of
VF dirty page tracking allowing us to minimize the VF requirements for
migration and thus enabling migration by default for those too.

While at it change the error messages to mention IOMMU dirty tracking as
well.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/migration.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 34d4be2ce1b1..cbfaef7afffe 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1036,16 +1036,16 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    if (!vbasedev->dirty_pages_supported) {
+    if (!vbasedev->dirty_pages_supported && !vbasedev->iommu_dirty_tracking) {
         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
             error_setg(&err,
-                       "%s: VFIO device doesn't support device dirty tracking",
-                       vbasedev->name);
+                       "%s: VFIO device doesn't support device and "
+                       "IOMMU dirty tracking", vbasedev->name);
             goto add_blocker;
         }
 
-        warn_report("%s: VFIO device doesn't support device dirty tracking",
-                    vbasedev->name);
+        warn_report("%s: VFIO device doesn't support device and "
+                    "IOMMU dirty tracking", vbasedev->name);
     }
 
     ret = vfio_block_multiple_devices_migration(vbasedev, errp);
-- 
2.17.2


