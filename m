Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241CBC71130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27l-0002pV-4x; Tue, 10 Jun 2025 12:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15t-0004ZT-GQ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15s-0006Gp-1V
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:57 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXkAX026798;
 Tue, 10 Jun 2025 15:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=32SCIQDcDGPU7ytO00zwMeeRgARqAbrXKwyvqajVH/k=; b=
 WJBHhUrLHSn+WLo1xieFXvJEtT3wujPW+Ytn9IxBRjF2dhsnTQBvoIHkCDrDkBpU
 /BOlkvhdgOZp+tYn59kkkYVVx2L0HLbcQ3TXTVj8ptnJb4jSEHbDqC4ujd3D86da
 ILMc1NC0Q5VQwyrvqCrGz5lxPmp6RE2uaijS6qELSV9B+f+3r4wTet4zFx6cdphs
 +ZGoPYNCmCGC//0C+4l++vC85xSB7rdKOgXMK4XTO1LIMn5UjUT4FZFguuRSHl8N
 8PxjVRPWOwJ2aDHclaR91GWWoFDnM+jgDzFvhWaW59b7/w/sf8MpGQmE6sDfr3zy
 DZbAYX5ccYnxK7F3uxj5kQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjuwne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEZpsV003330; Tue, 10 Jun 2025 15:40:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wc5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:53 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrgL028825;
 Tue, 10 Jun 2025 15:40:52 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-38; Tue, 10 Jun 2025 15:40:52 +0000
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
Subject: [PATCH V5 37/38] vfio/container: delete old cpr register
Date: Tue, 10 Jun 2025 08:39:50 -0700
Message-Id: <1749569991-25171-38-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=68485205 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=wb1fy916W68PL7SXvpoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfXyalGBQWcAA7e
 sny5BNFEFyDSbX0678KZx0H8m4WQwXjgDoFSq93UYrCMFs+IcbxVmOGdqw9f7hiNnaKDV/kBRVT
 e/2RscFeif6ysAnCVq8lSFNMpuJo6jWom2crnksSNfU0fXo+xMQmBnS6SS4YqVa4m+1nl4+AzqN
 QScu6qS72zhW1tl26sYZfvN3PqOfX1NmUIGJWbdbEmRywtvJWxXfyuMLmTikbvxfukIkBwmxn97
 YIARAOPVsg+htwr+Bcc84Vqkf35G4HeOao4zKM7yrn8WlC/kmWTrIc5NZEMe7LwsrrxTKEfrw9Y
 NIFCljL2Jrl/Ch/y5OB9vsxRmmA0ma0NFuACf4PBf6BrQ5qke9MEZagmXu9sdbvcoZZ5RqjIWBs
 G90ERQ/3wtlzokfB3U62ACFHNbu4kDr5x1mHQnzWig12WqZ1pScgzhkPzKYipnGaRbtKX2Y1
X-Proofpoint-ORIG-GUID: hjpf7QKJA7jLKSvQJWtwnjbWwl2lzlrf
X-Proofpoint-GUID: hjpf7QKJA7jLKSvQJWtwnjbWwl2lzlrf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

vfio_cpr_[un]register_container is no longer used since they were
subsumed by container type-specific registration.  Delete them.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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


