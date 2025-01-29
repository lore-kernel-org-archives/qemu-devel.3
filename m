Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E132CC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9IO-0000YU-An; Wed, 29 Jan 2025 09:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IF-0000V1-1U
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IB-0001KE-Iw
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:50 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXubm030033;
 Wed, 29 Jan 2025 14:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=E9od75KsDI1UDodFCf9AtXjSsO7FaXEqr0f9p3pxvFc=; b=
 Lm6lZL8oDE6JcJv86qbnOl39eoLEpb6xkxL9jBsnjUo8hTl4E2e0S0bGwbv13KzI
 5pRmTmnaGnf4kxG2oqRXrzAzqEAsSPod4zIX7rb8tXvzqWqOWJDbuuSSRv484cx+
 up4xgtGSFqOYxfHvGslAHPg+zPt5QM8VaQedhmsXVqvL57uOpUNz1cVy+PA8gePG
 hdBUTu44h99HPQxNCwudVX3IZcsVWOmXKRaxiKdJmmt72vSaFBdbiCG1r9teKPu2
 VEMCDVww8Jh7vo95yspwiu2v97B1uRtAvHTmsd3rZbyqKMgniBM1cwMfdkHgCd3Y
 6N4Q9U6m4m1ROJ5au3gmIg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fn2ug601-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TDQChk037049; Wed, 29 Jan 2025 14:43:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8I003307;
 Wed, 29 Jan 2025 14:43:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-3; Wed, 29 Jan 2025 14:43:42 +0000
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
Subject: [PATCH V1 02/26] migration: lower handler priority
Date: Wed, 29 Jan 2025 06:42:58 -0800
Message-Id: <1738161802-172631-3-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: 6bkExv9r8OzgTquyfJWPNWLICwQtfFMe
X-Proofpoint-GUID: 6bkExv9r8OzgTquyfJWPNWLICwQtfFMe
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

Define a vmstate priority that is lower than the default, so its handlers
run after all default priority handlers.  Since 0 is no longer the default
priority, translate an uninitialized priority of 0 to MIG_PRI_DEFAULT.

CPR for vfio will use this to install handlers for containers that run
after handlers for the devices that they contain.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/vmstate.h | 3 ++-
 migration/savevm.c          | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index a1dfab4..3055a46 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -155,7 +155,8 @@ enum VMStateFlags {
 };
 
 typedef enum {
-    MIG_PRI_DEFAULT = 0,
+    MIG_PRI_LOW = 1,            /* Must happen after default */
+    MIG_PRI_DEFAULT,
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
     MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
diff --git a/migration/savevm.c b/migration/savevm.c
index 264bc06..5dd2dc4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -232,7 +232,7 @@ typedef struct SaveState {
 
 static SaveState savevm_state = {
     .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
-    .handler_pri_head = { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] = NULL },
+    .handler_pri_head = { [0 ... MIG_PRI_MAX] = NULL },
     .global_section_id = 0,
 };
 
@@ -704,7 +704,7 @@ static int calculate_compat_instance_id(const char *idstr)
 
 static inline MigrationPriority save_state_priority(SaveStateEntry *se)
 {
-    if (se->vmsd) {
+    if (se->vmsd && se->vmsd->priority) {
         return se->vmsd->priority;
     }
     return MIG_PRI_DEFAULT;
-- 
1.8.3.1


