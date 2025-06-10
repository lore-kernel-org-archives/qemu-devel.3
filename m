Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154C8C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27p-00030k-9B; Tue, 10 Jun 2025 12:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP153-0004Kr-Rg
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP151-0005vT-MZ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXgwG007057;
 Tue, 10 Jun 2025 15:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=os4V9oK8JAtfJNBxo/pn0Lvi0VUC5ckpCkYGhVSNoG8=; b=
 m+rYYw8bmQgk8DNsKXn0wQNAmPcXJ7hHEL8VBvhqXxOmkZWgUxXHqOvLLkcxZ4ex
 0oiXZ9U6elltb8cQDUyX872mHq3IbFeNI71xVJK3vsjp1UGIJgE5CpVdln59Lk3B
 LCfonVF44c6t3F8r3pGnBw/4yx1MmKrQsiudmJ++5eOBizF1cGKvZSVjEaV+WEsn
 61TxRbCJIJKL77P5UjSj9xe6RinpC43fExPxCRf6MVQ6X2nKdClo+qwIFScAiIj4
 Cc5we1ltqk0lppdd/LCs9UV77P9PGbFvDwT9MRyuvrBMZzmR+gQnyqJs/cdp395b
 At4dU6OGX73aISzFwG9daA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74vjpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:39:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEp9R7003279; Tue, 10 Jun 2025 15:39:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wamg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:39:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfB028825;
 Tue, 10 Jun 2025 15:39:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-3; Tue, 10 Jun 2025 15:39:55 +0000
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
Subject: [PATCH V5 02/38] migration: lower handler priority
Date: Tue, 10 Jun 2025 08:39:15 -0700
Message-Id: <1749569991-25171-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=684851cd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=AmUmXUaXWCDEmLEOI0wA:9
 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: 686vOCUfQQUycUGJ-G41DgwpqNFIMcXb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX7SlT88zqkKZc
 mS+J5gJBTjPHJNW2d9gosQqrDxlO7AJ4K+9HhAvkkvyDYhaNH/Kw8Pw03sLBqY71rCEBmoKJG35
 tVOnmfhg4qLjHSzuv3DWwVI3Zt9eu8BpTuABZ9lQq12rJ555Qgou2zsZH2mykX3ucOKf6+bAW8s
 cWwmLTpvsupO/d6h4WSH5G2Q0+5GL2XeSylCQ4BqsKGQmfmXHqxD5cbwQh5WhDZ6uC8a8vtjgDk
 wTHHGMC/BcIbEqxAUPkHCI4OTrZautD6NwGamPLoxx08AhPYzMjwd3+iLjP5jJyim/FpjZzElMV
 fHceGwqDGitp8+jufl7Tcit6L20YskfjMDGmXvBTSmX9F5+bIV1NwVZ8iUnNoNqZjckG8TX0Xy+
 NJGAjuEohmyVYGIRZT6iv7a7J2JXKlUhbSMMtqUgcU8XrrX+WfrQk+nIbJsyfJdAWu7+MalG
X-Proofpoint-GUID: 686vOCUfQQUycUGJ-G41DgwpqNFIMcXb
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

Define a vmstate priority that is lower than the default, so its handlers
run after all default priority handlers.  Since 0 is no longer the default
priority, translate an uninitialized priority of 0 to MIG_PRI_DEFAULT.

CPR for vfio will use this to install handlers for containers that run
after handlers for the devices that they contain.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h | 6 +++++-
 migration/savevm.c          | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index a1dfab4..1ff7bd9 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -155,7 +155,11 @@ enum VMStateFlags {
 };
 
 typedef enum {
-    MIG_PRI_DEFAULT = 0,
+    MIG_PRI_UNINITIALIZED = 0,  /* An uninitialized priority field maps to */
+                                /* MIG_PRI_DEFAULT in save_state_priority */
+
+    MIG_PRI_LOW,                /* Must happen after default */
+    MIG_PRI_DEFAULT,
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
     MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
diff --git a/migration/savevm.c b/migration/savevm.c
index 52105dd..bb04a45 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -266,7 +266,7 @@ typedef struct SaveState {
 
 static SaveState savevm_state = {
     .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
-    .handler_pri_head = { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] = NULL },
+    .handler_pri_head = { [0 ... MIG_PRI_MAX] = NULL },
     .global_section_id = 0,
 };
 
@@ -737,7 +737,7 @@ static int calculate_compat_instance_id(const char *idstr)
 
 static inline MigrationPriority save_state_priority(SaveStateEntry *se)
 {
-    if (se->vmsd) {
+    if (se->vmsd && se->vmsd->priority) {
         return se->vmsd->priority;
     }
     return MIG_PRI_DEFAULT;
-- 
1.8.3.1


