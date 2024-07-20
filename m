Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EC6C3DA63
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZE-0007RY-Iq; Sat, 20 Jul 2024 15:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYt-0006pt-CI
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYj-0000pN-2M
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:02 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJAT2N021757;
 Sat, 20 Jul 2024 19:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=+svMWzFd5fTMtOMPInlaYfVGm5rk0v5rTgwc8FqpUes=; b=
 NaYfL5HSm6maWXJrVj4vUL66k+vbZfU5/oGoXpNzxt+EczPbFBHxLPo+cE9aV9Yd
 GUemXQEITDHNB/mFQhfmWsGRjxMsv9K0wn7/b6KzBIke2oyVr15aV742Pc4xjv32
 NEq80VL3u/AS2E3Q8NlZzqJQR94DE6qNOIpayClrEisy7grR69AOAtr/Gq0ptCMP
 bsWscsbaBlsLkwhHR7N80LDaBEf2BQx3GE/FquE7GYcpkUPJQR/LVDRjqFRm+e+l
 7qH053MI0mJvWe7gtpsw1fTDqXrqgUH//wgM0CghzmRBuv6RSzwQDj/xlTjVHn+O
 yVsFlz5VXnyxGpIOh3IHkg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk5jr04b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KI7MNd027535; Sat, 20 Jul 2024 19:15:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5putc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:41 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdf3028365;
 Sat, 20 Jul 2024 19:15:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-2; Sat, 20 Jul 2024 19:15:40 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 01/12] vfio: move cpr_exec_notifier
Date: Sat, 20 Jul 2024 12:15:26 -0700
Message-Id: <1721502937-87102-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200140
X-Proofpoint-GUID: AiT4tP8vkgJH0EV0qLH0UFEc2NZ00gAd
X-Proofpoint-ORIG-GUID: AiT4tP8vkgJH0EV0qLH0UFEc2NZ00gAd
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Move the cpr notifier to the base container.  This change will be squashed
into the "live update: vfio" series.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-legacy.c                  | 10 +++++-----
 include/hw/vfio/vfio-common.h         |  1 -
 include/hw/vfio/vfio-container-base.h |  1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 8f6224e..91be762 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -107,9 +107,9 @@ static const VMStateDescription vfio_container_vmstate = {
 static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
                                   MigrationEvent *e, Error **errp)
 {
-    VFIOContainer *container =
-        container_of(notifier, VFIOContainer, cpr_exec_notifier);
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer =
+        container_of(notifier, VFIOContainerBase, cpr_exec_notifier);
+    VFIOContainer *container = VFIO_CONTAINER(bcontainer);
 
     if (e->type != MIG_EVENT_PRECOPY_FAILED) {
         return 0;
@@ -147,7 +147,7 @@ bool vfio_legacy_cpr_register_container(VFIOContainerBase *bcontainer,
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
-    migration_add_notifier_mode(&container->cpr_exec_notifier,
+    migration_add_notifier_mode(&bcontainer->cpr_exec_notifier,
                                 vfio_cpr_fail_notifier,
                                 MIG_MODE_CPR_EXEC);
     return true;
@@ -158,5 +158,5 @@ void vfio_legacy_cpr_unregister_container(VFIOContainerBase *bcontainer)
     VFIOContainer *container = VFIO_CONTAINER(bcontainer);
 
     vmstate_unregister(NULL, &vfio_container_vmstate, container);
-    migration_remove_notifier(&container->cpr_exec_notifier);
+    migration_remove_notifier(&bcontainer->cpr_exec_notifier);
 }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1902c8f..9512a0c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -81,7 +81,6 @@ typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
-    NotifierWithReturn cpr_exec_notifier;
     bool vaddr_unmapped;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 3d30365..f8b7b26 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -52,6 +52,7 @@ typedef struct VFIOContainerBase {
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
     NotifierWithReturn cpr_reboot_notifier;
+    NotifierWithReturn cpr_exec_notifier;
     Error *cpr_blocker;
 } VFIOContainerBase;
 
-- 
1.8.3.1


