Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34322C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9S-0003tK-Ie; Mon, 12 May 2025 11:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9L-0003hQ-Uy
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9J-0006eD-E2
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CCAADk019736;
 Mon, 12 May 2025 15:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=coxxrO3jwCxhvRTGFRerp9PEWUUZTdEqNuK6uBtf+kg=; b=
 sYq9T30gy3A/Y6oP0bUF2mFPmZz0rqopYZazd4RSYwLcxjbZyBJKiKVJNobpjZId
 IE8nsephM6bQZ9ZQSv1ZiAgMzedGEJHbl3bmrM2ZK4iQtoQ/lIrp7bOxbcavO+RM
 30mri7XgDeu49XU51x5i19utaWN0GmelRedrJdoDtlIQ4lHFcFihFRejX6stm2wg
 swo12VAP+iDC5enyCTW5aJBcBL2iPQCbPwAgnkXDcyWV0GOsvHk2wCjfUlanr8DH
 Z9lOQr3yszI6a9NQ6Gl8t14a0BTySc8TJtXBjfjXZy9MYui7EhFy1naZB7Brw8MV
 gyvXG6W6xaNbvFBIjHTl/A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2scv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE0rdG002876; Mon, 12 May 2025 15:32:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3665a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:58 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk4k030605;
 Mon, 12 May 2025 15:32:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-5; Mon, 12 May 2025 15:32:57 +0000
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
Subject: [PATCH V3 04/42] vfio: vfio_find_ram_discard_listener
Date: Mon, 12 May 2025 08:32:15 -0700
Message-Id: <1747063973-124548-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX2hwWOQEQs6fd
 OWrd8BLNJTWCSuVK04Q+vb7wDW84Y4FDfwg5i4E7DqhxlrwsIbpTQ+dS7FN0Rt5URPQPLw7hICd
 cLjvjVSXoWSMn+wqX5Apzedyh4GzEwsxLe2TBuTqlMFRfusTK5PMQ8U4OxAv+NBJp9fXAnDtONH
 bYj068IoMzxdotTNU1WdLAGrRlyCeGPqtU1jq4SnUFoPxKq4wiF9wIJUDFwjQc8WkYsB3It02yX
 6/PKjAejYRj0iJKevm6R4cov46MD9J9anVIPKyTbiOQCKbSW6RF7t6wh/sIAKaSKAe/Mq9TTwvw
 eakm1QnG6fpPVEZ/WT3HalNIvxz7leiggiMy0mSbH2TbJ3fe5Ob6qnoBPVRtpxc7Cl6P2REd9xU
 HYSFEHX0g5IGatAsh38LguKa1pnAP2iRBnB+kA6n0ULFkFuWuGTLE7BwM2HIHYjYkp/ICUo2
X-Proofpoint-GUID: UdW-DEIlY82_yuSMv9tmIkqR75I8_jsE
X-Proofpoint-ORIG-GUID: UdW-DEIlY82_yuSMv9tmIkqR75I8_jsE
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214aa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=MtPhzGyV-s5HnW-BJbUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
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

Define vfio_find_ram_discard_listener as a subroutine so additional calls to
it may be added in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c                    | 35 ++++++++++++++++++++++-------------
 include/hw/vfio/vfio-container-base.h |  3 +++
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index bfacb3d..5642d04 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -449,6 +449,26 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
     }
 }
 
+VFIORamDiscardListener *vfio_find_ram_discard_listener(
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
@@ -1075,19 +1095,8 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
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
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 3d392b0..1dc760f 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -183,4 +183,7 @@ struct VFIOIOMMUClass {
     void (*release)(VFIOContainerBase *bcontainer);
 };
 
+VFIORamDiscardListener *vfio_find_ram_discard_listener(
+    VFIOContainerBase *bcontainer, MemoryRegionSection *section);
+
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
-- 
1.8.3.1


