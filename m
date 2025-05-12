Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715FFC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBb-0008RU-CQ; Mon, 12 May 2025 11:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9s-0004pi-BR
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9l-0006lO-5p
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9fV2026121;
 Mon, 12 May 2025 15:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=s/9zJ/8LZ1etS/7GGII1rzUsyyrVUg4uJ+8sv0vjdFw=; b=
 kqlIOqXgYNmmAJDeFS8+5XOCHFcPuDIy80f0SSwB73VlGEMFeK8FmMSemyS8uyOL
 dLQxgPTSMciNyO/S6haDmEZojcOHlOpJeJJQMm1Z2BaujD5NSRJSNk8OVp1vsoOs
 PXJP4Uwo2gFqM1e4cuA99cNfGkFoZDPa2ftj9d8DZSoG/6ymsLLqpQjUgi68zbO7
 lGqimFhHex/3CJLcpwhlFsQXzlEncZPUR7AECXIcGIHuEns91T5jr6n1IwioW0Pk
 nWDG/XXgPcisnvlw3HiKbI5bNwGmX9qFvUNl3v51ztDxtyviqigWc1YAUPaIF9++
 I3U+dRcwFOptNaV2LOeedg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c2rbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE0qCY002414; Mon, 12 May 2025 15:33:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:23 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5u030605;
 Mon, 12 May 2025 15:33:23 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-40; Mon, 12 May 2025 15:33:23 +0000
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
Subject: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
Date: Mon, 12 May 2025 08:32:50 -0700
Message-Id: <1747063973-124548-40-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXwW1/Ti6X/zFJ
 DbLKG0l9WVA7nyQooIhL+Mcug2T9ebdHJhxetiYpw0u7xLFPI5EHqiwt9IuLJNJDElmemfqJSy2
 r/JtmZfV6Uu2rGH12izdx/sd2reLyTlYrtKGd3/qWfS1O+uIpBTV+Q7jodUQy0nX4fvDnw0U6/o
 kA0kdu/EWeejSlANuira7b2Axe2tf0cndEX0tRzARw7Q1JBPFLVQkR7NfFikiP7mQMsVSTxIyjV
 kXJusNBd9IyUhU2vhko7+MO7xk1KmsSzvDvZ84Et5gblM+bI4nlp+GEAa5c3BiEHt+oc7bxIRu/
 ykBx5XYMv2doK/XIh7OhA7SuizuuXJEXo/YtUl9LPW27Iz1+kWNbdfoVEmwJ4AUbG5Wm/+nXqoc
 Z/JVFwuII2LxA7F9FTDadmn7kUlgYzoPANmhPAwPMK2wmcg+ctSyTHFS65tbNuwI/180VQir
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=682214c5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=OvROBqR4kuGC_iUvkPMA:9
X-Proofpoint-GUID: EQP8fLDok6c4o2CBhu3uWcvBhYvyaGYA
X-Proofpoint-ORIG-GUID: EQP8fLDok6c4o2CBhu3uWcvBhYvyaGYA
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Save the hwpt_id in vmstate.  In realize, skip its allocation from
iommufd_cdev_attach -> iommufd_cdev_attach_container ->
iommufd_cdev_autodomains_get.

Rebuild userland structures to hold hwpt_id by calling
iommufd_cdev_rebuild_hwpt at post load time.  This depends on hw_caps, which
was restored by the post_load call to vfio_device_hiod_create_and_realize.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-iommufd.c      |  7 +++++++
 hw/vfio/iommufd.c          | 24 ++++++++++++++++++++++--
 hw/vfio/trace-events       |  1 +
 hw/vfio/vfio-iommufd.h     |  3 +++
 include/hw/vfio/vfio-cpr.h |  1 +
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 24cdf10..6d3f4e0 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -110,6 +110,12 @@ static int vfio_device_post_load(void *opaque, int version_id)
         error_report_err(err);
         return false;
     }
+    if (!vbasedev->mdev) {
+        VFIOIOMMUFDContainer *container = container_of(vbasedev->bcontainer,
+                                                       VFIOIOMMUFDContainer,
+                                                       bcontainer);
+        iommufd_cdev_rebuild_hwpt(vbasedev, container);
+    }
     return true;
 }
 
@@ -121,6 +127,7 @@ static const VMStateDescription vfio_device_vmstate = {
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
         VMSTATE_INT32(devid, VFIODevice),
+        VMSTATE_UINT32(cpr.hwpt_id, VFIODevice),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index d980684..ec79c83 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -318,6 +318,7 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
 static void iommufd_cdev_use_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt *hwpt)
 {
     vbasedev->hwpt = hwpt;
+    vbasedev->cpr.hwpt_id = hwpt->hwpt_id;
     vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
 }
@@ -373,6 +374,23 @@ static bool iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
     return true;
 }
 
+void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
+                               VFIOIOMMUFDContainer *container)
+{
+    VFIOIOASHwpt *hwpt;
+    int hwpt_id = vbasedev->cpr.hwpt_id;
+
+    trace_iommufd_cdev_rebuild_hwpt(container->be->fd, hwpt_id);
+
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        if (hwpt->hwpt_id == hwpt_id) {
+            iommufd_cdev_use_hwpt(vbasedev, hwpt);
+            return;
+        }
+    }
+    iommufd_cdev_make_hwpt(vbasedev, container, hwpt_id, false, NULL);
+}
+
 static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
                                          VFIOIOMMUFDContainer *container,
                                          Error **errp)
@@ -567,7 +585,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
             vbasedev->iommufd != container->be) {
             continue;
         }
-        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
+        if (!vbasedev->cpr.reused &&
+            !iommufd_cdev_attach_container(vbasedev, container, &err)) {
             const char *msg = error_get_pretty(err);
 
             trace_iommufd_cdev_fail_attach_existing_container(msg);
@@ -605,7 +624,8 @@ skip_ioas_alloc:
     bcontainer = &container->bcontainer;
     vfio_address_space_insert(space, bcontainer);
 
-    if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
+    if (!vbasedev->cpr.reused &&
+        !iommufd_cdev_attach_container(vbasedev, container, errp)) {
         goto err_attach_container;
     }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e90ec9b..4955264 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -190,6 +190,7 @@ iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int devi
 iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
 iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id) " [iommufd=%d] Successfully attached device %s (%d) to id=%d"
 iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d] Successfully detached %s"
+iommufd_cdev_rebuild_hwpt(int iommufd, int hwpt_id) " [iommufd=%d] hwpt %d"
 iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 148ce89..78af0d8 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -38,4 +38,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
 bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                       uint32_t ioas_id, Error **errp);
 
+void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
+                               VFIOIOMMUFDContainer *container);
+
 #endif /* HW_VFIO_VFIO_IOMMUFD_H */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 1379b20..b98c247 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -24,6 +24,7 @@ typedef struct VFIODeviceCPR {
     bool reused;
     Error *mdev_blocker;
     Error *id_blocker;
+    uint32_t hwpt_id;
 } VFIODeviceCPR;
 
 struct VFIOContainer;
-- 
1.8.3.1


