Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4D4C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5UB-0003WH-JI; Wed, 02 Jul 2025 17:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U8-0003VW-T9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U7-0003lf-Bt
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:20 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQfwY030336;
 Wed, 2 Jul 2025 21:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=F88eYIe03c7Ls4yKjocET+c+1VxLAyWt9CWpeWd2WrQ=; b=
 r93pMyaTi/xG5fPMxrCb/BfEPZzR0Xm3VRvh/Fylc1CDk/34E+FXECJVCuCQYdCA
 RhBp+TMizFo//577sc796fsmgH+4WpDIZ2lRhi7l1JrB6k4Z8W/u5gvY6go9Q2n1
 a4Ee8qhuTPJ9mQ6SIs750m3+P0VwNiwObisQAaeMfybF638XCIbcjw1105WB0lvf
 E3olPCkDmCCdQQyT9mmuE1zTGvBWKgk+GE+KQ4XYPWoEPZza529ZQOxq/qIciU8O
 53a32j3sqKQrCcUe8z5AGqKEjhFt+HxLlOMoai+Bz4XxTxtHjB4qCNAWdjNVP2RT
 S/gVh6ULxOnYMuYWcfTujA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766fyqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LdcMa034127; Wed, 2 Jul 2025 21:59:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:15 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgY020012;
 Wed, 2 Jul 2025 21:59:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-21; Wed, 02 Jul 2025 21:59:14 +0000
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
Subject: [PATCH V6 20/21] vfio/container: delete old cpr register
Date: Wed,  2 Jul 2025 14:58:57 -0700
Message-Id: <1751493538-202042-21-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-GUID: IDhW8kaUtTl6dYsH1EBL1o2qvIVPv8zf
X-Proofpoint-ORIG-GUID: IDhW8kaUtTl6dYsH1EBL1o2qvIVPv8zf
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6865abb4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=wb1fy916W68PL7SXvpoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MSBTYWx0ZWRfX2ycEhFySzWjx
 VQvatiZfAtrQYRQfBLhvzGJUzodRYE2eXfse9EgqzP7y+loyg4QZJuCUC/e61FEzL7YLQuq04z9
 el4zoHqmlHmpg8aE7Be3/nsIDFAfve3uSMlPUSigRQJsCmq2EA2uEz8hTNg0dIqnJIG3sjFxpUD
 s8pBFEyUyXs70aoK3ZShUAq0jfOvnBmcTHKhXvgqCZJPhBMcBY5RFfEdfoZ8abLWDsEiTp4T9e5
 GWm2I4h1ScdACwLcchxaN+O5PD8PAtVNj2VR3h7tgny00Dnoxk76/kuXHpIqrnB2JfUfYnpBg9n
 yaHkrMxTKavdbPDIKApIDhw6RYm4Ob6nKXMMrPYXKmECU8sCaC1GhufNxsZWSc2XmaSCt+AFTKj
 013O4Sjkf34kEuhMKfOYldLkeopeL3418CVO9GZCz1F5WHWbKsqccirzXewnkwvcLj3mBRsC
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  4 ----
 hw/vfio/cpr.c              | 13 -------------
 2 files changed, 17 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 4c17cb3..e9cd9b2 100644
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
index 0e903cd..af0f12a 100644
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


