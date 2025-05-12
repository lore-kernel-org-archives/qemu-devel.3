Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D10C3ABD7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBh-0000Cb-K0; Mon, 12 May 2025 11:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9y-00050B-8W
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9w-0006m0-D9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:41 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9eAg024086;
 Mon, 12 May 2025 15:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=+WcY3I7bDmEPWHLMdoe23B8LTUR7SlNnbIABTazXPsw=; b=
 Z9Wsm1lvaNFsa1pbJd6/+j4hJw2nS518ZewIR23jhiPorgXmw8c+2+1G7/T45svR
 hm1PDtV4daQQhW5HWVvR72s6uqU6lVEIHOIdwf1grZnugA70oiU2mS0JjoUF4ozz
 6A9Fx4Fd0gMcXUbcCUdJnIZ8twVzczH8vaQimOmSuu0uItPjuJ0IRthsojXBL35H
 Dc77euOZ/rfgLQmzX/Fh5fl61bLCwzs0uiPXFwGZ3a+Oy5qoMfvdlGuGXCAxbwRQ
 gDVFogzF8ixn654ANHnclSnh3/b1WlSK9BmoHJ1v4EvoXBU59jGmqxGQ58EOShSu
 +vQlUwwsOH+Dwjcu0CZt9w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2aqs5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE0xI4002520; Mon, 12 May 2025 15:33:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk62030605;
 Mon, 12 May 2025 15:33:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-43; Mon, 12 May 2025 15:33:25 +0000
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
Subject: [PATCH V3 42/42] vfio/container: delete old cpr register
Date: Mon, 12 May 2025 08:32:53 -0700
Message-Id: <1747063973-124548-43-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: sgx1uGSReI--4-HN3qhKuLSjQR5Lsp61
X-Proofpoint-GUID: sgx1uGSReI--4-HN3qhKuLSjQR5Lsp61
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=682214c7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=wb1fy916W68PL7SXvpoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX/wsXsq2/V2/E
 4O55vpGBJVfivVMjAWRIchAXVoYfrKMekAo5cqb/vwA3pwMjbMwVWkrnZa8gH+UgpxE9ycvQYDU
 8iN/p+rMmXu+esYR/q+n4BJPXXoMU1hPsa7iHUa8FIV3lJdQhAfRRmJG6fyFd2u7Fa3Z2boigXz
 VszkclrPBlbOE8msInujpdJwWFCYbL5EuJ2WBYMBvar0F8RiiTx+JJME4hRnHjdgnYMLm5iT/pV
 +QTjkOmgKMAY2/p961wm9sz7HuEFvNZ14u6kRtShkGWGORyJI6wkYoG7canQoWo3qLRVd0SKDrR
 aBX+d4OP9ljQULgm32/pIFEhbSeiJLR6ipcShx4nHdVFc2AVJ4sqS3NYJbdO5ervi/g0NOFc+Lt
 hPL77QY5JwRgNgoWNPfkWAFp0M2VCLds0+VGXtMx3ESnSJuPME/8JZzb/g4SZ1rahx285oHn
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
 hw/vfio/cpr.c              | 13 -------------
 include/hw/vfio/vfio-cpr.h |  4 ----
 2 files changed, 17 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 7609c62..ea1773e 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -30,19 +30,6 @@ int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
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
 
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index b98c247..601037b 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -41,10 +41,6 @@ void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
                              Error **errp);
 
-bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
-                                 Error **errp);
-void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
-
 bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
                                          Error **errp);
 void vfio_iommufd_cpr_unregister_container(
-- 
1.8.3.1


