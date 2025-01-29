Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952C6C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9IO-0000YV-Bd; Wed, 29 Jan 2025 09:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IF-0000V2-1a
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IB-0001KJ-Hb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:50 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXsLf011637;
 Wed, 29 Jan 2025 14:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=+Iwsp7trPWLEgogrVD3j3VhwXPXWDwHPvQKMLMMUmX8=; b=
 mGCdLZVJ6uZ87eL+iBn6Vx3jezIM6QQKaeMhbaKQBLwFLxviWUIhm8RYCHG4Yj8G
 Bz2wYa5zdlmsFZhOYKzgAF6zSKmyRgXTr2d3gGmn/I2306KTLyZRMr3RFZyEIWDs
 pFpDchxMn9LbgCu04rgZ3oYw/qQ7a1RPZFohoKkG1bpH9qeX6XXpUysUJBCkuhQ9
 xxC0rvyastZ0FDToAdgzp2GmCwljqny4na2KcLXvNJ8Vj30GUSe0aSHNRW0lRGfc
 9p2pFtQBU9VqEcRWBnBjS2qSpO1toJcuxK5CQsUo9I5SJN/tmd8tWlRZepFMiXoP
 UjcvFOI5O+0ZyE6s88zyHg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fnk9g3hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TE74Kc037042; Wed, 29 Jan 2025 14:43:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:44 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8K003307;
 Wed, 29 Jan 2025 14:43:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-4; Wed, 29 Jan 2025 14:43:43 +0000
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
Subject: [PATCH V1 03/26] vfio: vfio_find_ram_discard_listener
Date: Wed, 29 Jan 2025 06:42:59 -0800
Message-Id: <1738161802-172631-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290119
X-Proofpoint-ORIG-GUID: jDfzW7I2hK_wCx6JeGuOOO0KaAjLbADM
X-Proofpoint-GUID: jDfzW7I2hK_wCx6JeGuOOO0KaAjLbADM
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
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

Define vfio_find_ram_discard_listener as a subroutine so additional calls to
it may be added in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/common.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f7499a9..7370332 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -555,6 +555,26 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
     return true;
 }
 
+static VFIORamDiscardListener *vfio_find_ram_discard_listener(
+    VFIOContainerBase *bcontainer, MemoryRegionSection *section)
+{
+    VFIORamDiscardListener *vrdl = NULL;
+
+    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
+        if (vrdl->mr == section->mr &&
+            vrdl->offset_within_address_space ==
+            section->offset_within_address_space) {
+            break;
+        }
+    }
+
+    if (!vrdl) {
+        hw_error("vfio: Trying to sync missing RAM discard listener");
+        /* does not return */
+    }
+    return vrdl;
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -1266,19 +1286,8 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
                                             MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
-    VFIORamDiscardListener *vrdl = NULL;
-
-    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
-        if (vrdl->mr == section->mr &&
-            vrdl->offset_within_address_space ==
-            section->offset_within_address_space) {
-            break;
-        }
-    }
-
-    if (!vrdl) {
-        hw_error("vfio: Trying to sync missing RAM discard listener");
-    }
+    VFIORamDiscardListener *vrdl =
+        vfio_find_ram_discard_listener(bcontainer, section);
 
     /*
      * We only want/can synchronize the bitmap for actually mapped parts -
-- 
1.8.3.1


