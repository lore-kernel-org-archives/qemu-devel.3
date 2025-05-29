Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FF5C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisv-0004ZY-O4; Thu, 29 May 2025 15:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisV-0004FG-EK
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisS-0000Ud-Nb
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:22 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGg7VP004866;
 Thu, 29 May 2025 19:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=VJ1vCYMMJIn0h3H36c41RmlCgZ0lxWBB4m2cZlDO0/8=; b=
 SCkptm5JNuvFoZtZdKonPy/c6YM+n46405OThEGOpqQlqxq/XiRJCPH7AgSBmMJA
 iMJkeKJU/VXZTEuUy3MIaLgGRZZNJZHKu7gqQbBowbiY4lbFk4LIkGnQSPJtE6WO
 1NDt27P5eumC2ewzPDFV/c9A1jKZXomVAZjcCJZ2e7hM4hxxU9xmEAAq7DcXqD5K
 RXRzulCBP8K4URxUQ8R1rQowiwflJQ1UmMQVps2y8AkTRcAMPHRRFAcXlZTtEt99
 zmQnFrXe1kd9+xB3ttLfFni7/7Xo714WgZ0V/MkwFFqlQaecmJNpH2Ps+qKu2ATF
 l5hHDFFXft2GanwfXuB1/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pf0n0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THfFHk020324; Thu, 29 May 2025 19:25:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4wby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeSD022158;
 Thu, 29 May 2025 19:25:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-44; Thu, 29 May 2025 19:25:16 +0000
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
Subject: [PATCH V4 43/43] vfio/container: delete old cpr register
Date: Thu, 29 May 2025 12:24:39 -0700
Message-Id: <1748546679-154091-44-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-ORIG-GUID: rrbqgRn5R9k7jxwRTXEBBojJW_I9TMRD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX1n/cQbMu4mzm
 gwyU0hmiKoY7eMLotegfBeQbKSMoY6qwqJLwjQwLvlM3rLYFA6GDVB6jTHfAB8HRPrTwLORN13P
 58r7jmbx1qdyJibPDRezF3bhh3ELP/fCboOydKCx58RVl7U7zTjqTBpdo4jKvCnartliKUlgqYl
 3RDVQAoLtQznlgXrKNd+JbYVLm1phzqjv1bpkhOko3zQWoRiUMKdlaKkAKwdUGaNF8sh4ezyDUQ
 0Nn1Ls8iacu2aYOtHE49MneGK5nXmw9sODjr1wCFHTek8QZQrO3y4TJHESBaQqGO6OUwOxDfxBF
 qhAZQkaoONB56gW0Q9BaMvZu9iaKlYPqc8IMgfSw/2IQdm8/FiFEfbFt0Yr/k1NoYn5zFQi/EPH
 Nq+x2FeScPFP10XYBbJZ7jJat+gVbgs66F4XeedCxipiV0NTJ4/iWLgEQ+z1FRyCPrYMtaWx
X-Proofpoint-GUID: rrbqgRn5R9k7jxwRTXEBBojJW_I9TMRD
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=6838b49d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=wb1fy916W68PL7SXvpoA:9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

vfio_cpr_[un]register_container is no longer used since they were
subsumed by container type-specific registration.  Delete them.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/hw/vfio/vfio-cpr.h |  4 ----
 hw/vfio/cpr.c              | 13 -------------
 2 files changed, 17 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index f88e4ba..5b6c960 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -44,10 +44,6 @@ void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
                              Error **errp);
 
-bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
-                                 Error **errp);
-void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
-
 bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
                                          Error **errp);
 void vfio_iommufd_cpr_unregister_container(
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index f5555ca..c97e467 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -29,19 +29,6 @@ int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
-bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
-{
-    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
-                                vfio_cpr_reboot_notifier,
-                                MIG_MODE_CPR_REBOOT);
-    return true;
-}
-
-void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
-{
-    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
-}
-
 #define STRDUP_VECTOR_FD_NAME(vdev, name)   \
     g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
 
-- 
1.8.3.1


