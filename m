Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B355C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 14:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uArI8-00039g-5r; Fri, 02 May 2025 10:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uArHu-00037u-O9
 for qemu-devel@nongnu.org; Fri, 02 May 2025 10:22:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uArHr-0008Q5-PH
 for qemu-devel@nongnu.org; Fri, 02 May 2025 10:22:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425Wwpr013912;
 Fri, 2 May 2025 14:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=4ASApZ37fW9+ZvQP59jI22FHv5xnviVlx/FMkwbG9nU=; b=
 Js/A9kaOBdT6f8USL73MpTaDqluh50d3Y6mBRBye8+YxZYrcb2OhJ6d1igrC5532
 zGopsczYhQeHEh5Y66amMabEhyc4N1IXXRFMLBJ7vFkR78anSXK3aPqndC+N5818
 BHDAFN+wkA5O7RA3NnCnBAiN8DW/BcenUmbBMaB7cwiKrVOrxx0q8Pa3dXjcEekY
 2JvdZ34yWDt/qEvbBvEB9AhaXMECC/tm8F3gvk8L4rIvZsGimU7EjgyatEsiUBF2
 +0/OnVUZaLnz6V3AgqSIIu9ZJTULWV5uCQvsehAIlsbKgyWCvY23vYzcKJ8SHgeO
 TmaFjExmkBy+x3tbDl4c/A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utda7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 14:22:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 542Cvhkr023734; Fri, 2 May 2025 14:22:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxm33q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 14:22:44 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 542EIQws039705;
 Fri, 2 May 2025 14:22:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 468nxm33ng-4; Fri, 02 May 2025 14:22:43 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 3/3] vfio/container: vfio_container_group_add
Date: Fri,  2 May 2025 07:22:40 -0700
Message-Id: <1746195760-101443-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746195760-101443-1-git-send-email-steven.sistare@oracle.com>
References: <1746195760-101443-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_02,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020114
X-Proofpoint-GUID: Y5LijCi5QHotaPp_of5So-wikRgbN-iI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDExNCBTYWx0ZWRfX02p3VPiwR3wv
 tY5V0iLmKk1EUkqAOsDcXtdukUh4u3dbiYT0/3kyQfYd3r+H6SwWj008g0mVfMswT5Nx5198wE/
 DMD2ffU9JfC1qWyRfEVI+kt1jtvB+OEtoC3cOxXdvSHoyvYkUIntrMp6b/QJ79iDpiunxRXp6hQ
 pomhsr30ZkOv23Je1UXH6y55tnAXfDNjJyMeSI6pqc7HiBj3680VuiE3dNc0o7MEyRIBHRQ4XhA
 46/Lfwv9aaotAwTgu26Pk8A+NPC9WNpxBGCEUe3h/QHiQSMne9gVRU1m5WOsC7whhpr8BYwCWbK
 dfZkLk19SvM2+Un0Sb6CUqhmnm41EkIzqmcYVbB0ZdBSXuke1E+L816PfA8hsq2jOawRz9Svse4
 UVJ7wL6upHm2rcDGu3uD4ndQXQ5JvDfXr4LJUfrVoK88noYJnx8DqyOVf1PK2YhrmE34Hdln
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=6814d535 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=hyRgTmVC71PfrdBveaoA:9
 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: Y5LijCi5QHotaPp_of5So-wikRgbN-iI
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add vfio_container_group_add to de-dup some code.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cedric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 26433ae..d0b8dfc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -558,6 +558,26 @@ static bool vfio_attach_discard_disable(VFIOContainer *container,
     return !ret;
 }
 
+static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
+                                     Error **errp)
+{
+    if (!vfio_attach_discard_disable(container, group, errp)) {
+        return false;
+    }
+    group->container = container;
+    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+    vfio_group_add_kvm_device(group);
+    return true;
+}
+
+static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
+{
+    QLIST_REMOVE(group, container_next);
+    group->container = NULL;
+    vfio_group_del_kvm_device(group);
+    vfio_ram_block_discard_disable(container, false);
+}
+
 static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
                                    Error **errp)
 {
@@ -568,20 +588,13 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     VFIOIOMMUClass *vioc = NULL;
     bool new_container = false;
     bool group_was_added = false;
-    bool discard_disabled = false;
 
     space = vfio_address_space_get(as);
 
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOContainer, bcontainer);
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            if (!vfio_attach_discard_disable(container, group, errp)) {
-                return false;
-            }
-            group->container = container;
-            QLIST_INSERT_HEAD(&container->group_list, group, container_next);
-            vfio_group_add_kvm_device(group);
-            return true;
+            return vfio_container_group_add(container, group, errp);
         }
     }
 
@@ -608,11 +621,6 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
         goto fail;
     }
 
-    if (!vfio_attach_discard_disable(container, group, errp)) {
-        goto fail;
-    }
-    discard_disabled = true;
-
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
@@ -620,12 +628,11 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
         goto fail;
     }
 
-    vfio_group_add_kvm_device(group);
-
     vfio_address_space_insert(space, bcontainer);
 
-    group->container = container;
-    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+    if (!vfio_container_group_add(container, group, errp)) {
+        goto fail;
+    }
     group_was_added = true;
 
     if (!vfio_listener_register(bcontainer, errp)) {
@@ -640,15 +647,11 @@ fail:
     vfio_listener_unregister(bcontainer);
 
     if (group_was_added) {
-        QLIST_REMOVE(group, container_next);
-        vfio_group_del_kvm_device(group);
+        vfio_container_group_del(container, group);
     }
     if (vioc && vioc->release) {
         vioc->release(bcontainer);
     }
-    if (discard_disabled) {
-        vfio_ram_block_discard_disable(container, false);
-    }
     if (new_container) {
         vfio_cpr_unregister_container(bcontainer);
         object_unref(container);
-- 
1.8.3.1


