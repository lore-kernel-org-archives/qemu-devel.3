Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF03C3ABAD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 14:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uArHy-00038F-3Z; Fri, 02 May 2025 10:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uArHt-00037i-JF
 for qemu-devel@nongnu.org; Fri, 02 May 2025 10:22:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uArHr-0008Pp-EH
 for qemu-devel@nongnu.org; Fri, 02 May 2025 10:22:49 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425Wm2r016319;
 Fri, 2 May 2025 14:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=4Y0h102crVZrLUiDEGK2GSp8Qjx6UOZQO641hMFgWw4=; b=
 n7DLkLOHeccy0qgRUoUi53sD49DFyhW4BJrATuH7idmf9TvIn8k53FuAyj1M++lZ
 ZvhsbzbCGa6Rgf+fprR8bF7s6G/BzI7MKlkUxDtE3swP1cvwzdCgJL2QlJcAIKvW
 Qp24TMmO0YKZJNWozIkGYPUnIe2EozQv8lMCpdWGrJbzgSxq7pV4KQ0Q9/oJ3Nsg
 31GQsuSIEv9V/xHryjF0IbRgkiqutwSgTEjX8o2b3QFQXyHbPZmacQQFDHvFbHVo
 A54mYuAo/OnhPXIjBrJYRI6U8AGqXooc8Uc8EMXE9cgqKR1rSxLYC4TXLpL1+T8d
 aAdW5feY8YM7eU/QIEoFVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usnbt5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 14:22:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 542CRrtN023749; Fri, 2 May 2025 14:22:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxm33pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 14:22:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 542EIQwo039705;
 Fri, 2 May 2025 14:22:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 468nxm33ng-2; Fri, 02 May 2025 14:22:42 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 1/3] vfio/container: ram discard disable helper
Date: Fri,  2 May 2025 07:22:38 -0700
Message-Id: <1746195760-101443-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: QVT3TdxAo1IIWA4JefZ7gnwYHDebsLDM
X-Proofpoint-GUID: QVT3TdxAo1IIWA4JefZ7gnwYHDebsLDM
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=6814d534 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=d_plV5qU0UxEAfvj6MwA:9
 cc=ntf awl=host:13130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDExNCBTYWx0ZWRfX3YJRKPpdcn0w
 xaHTtfEdluo+md9tVHPTYtGvNCvoa/qxoM5lwW1D56eTZo79xnjJ2JoanoELrQLs42PXGHmL0Fi
 pQrJfxEON0CGEdt0WG4YTEfpRc4IRHgjTDN+Kcayw3+5Sy0UBDpaU4tSYO4ywt9P7wJ3PINxob+
 QaoqskUlYxGwKpjdQWZFYAlaJop13pjRSSy50Xx4/19JV1mArvD0xX2C41bjcpIASuLl1XlVts5
 k7iM9o2LU7Y75ZhPANKdotLbAh1XsB7dLeoNJ3W7DI5jGNBWpb33T52qM06qa2qdHIIt28vkrrR
 e9EXxg27aChCAN/c5tZwLBdSrCBoq6zSKcfYkAIZRGVYrKL07pQVaBwxhoYIy0Cn2zkIAzcvpnD
 pLZhUNTLzOWMhFTPlhDw/YmI0+Qt3PIQ2OWvEeGMWJPH3UlTsq+58vWHe+ZgqS2QmxTIX3Re
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

Define a helper to set ram discard disable, generate error messages,
and cleanup on failure.  The second vfio_ram_block_discard_disable
call site now performs VFIO_GROUP_UNSET_CONTAINER immediately on failure,
instead of relying on the close of the container fd to do so in the kernel,
but this is equivalent.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cedric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 77ff56b..bf4bbd2 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -511,16 +511,10 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     return true;
 }
 
-static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
-                                   Error **errp)
+static bool vfio_attach_discard_disable(VFIOContainer *container,
+                                        VFIOGroup *group, Error **errp)
 {
-    VFIOContainer *container;
-    VFIOContainerBase *bcontainer;
-    int ret, fd;
-    VFIOAddressSpace *space;
-    VFIOIOMMUClass *vioc;
-
-    space = vfio_address_space_get(as);
+    int ret;
 
     /*
      * VFIO is currently incompatible with discarding of RAM insofar as the
@@ -553,18 +547,32 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
      * details once we know which type of IOMMU we are using.
      */
 
+    ret = vfio_ram_block_discard_disable(container, true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER, &container->fd)) {
+            error_report("vfio: error disconnecting group %d from"
+                         " container", group->groupid);
+        }
+    }
+    return !ret;
+}
+
+static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
+                                   Error **errp)
+{
+    VFIOContainer *container;
+    VFIOContainerBase *bcontainer;
+    int ret, fd;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+
+    space = vfio_address_space_get(as);
+
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOContainer, bcontainer);
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            ret = vfio_ram_block_discard_disable(container, true);
-            if (ret) {
-                error_setg_errno(errp, -ret,
-                                 "Cannot set discarding of RAM broken");
-                if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
-                          &container->fd)) {
-                    error_report("vfio: error disconnecting group %d from"
-                                 " container", group->groupid);
-                }
+            if (!vfio_attach_discard_disable(container, group, errp)) {
                 return false;
             }
             group->container = container;
@@ -596,9 +604,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
         goto free_container_exit;
     }
 
-    ret = vfio_ram_block_discard_disable(container, true);
-    if (ret) {
-        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+    if (!vfio_attach_discard_disable(container, group, errp)) {
         goto unregister_container_exit;
     }
 
-- 
1.8.3.1


