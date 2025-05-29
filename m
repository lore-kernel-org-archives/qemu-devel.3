Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72A9C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKis4-0003zo-Ty; Thu, 29 May 2025 15:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirz-0003xq-L9
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirx-0000C8-KO
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsD7022014;
 Thu, 29 May 2025 19:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=FfGaPWkw5+fA+BbPzNjjZN7wkjCtFXBTDQqfy4/oqCU=; b=
 QnBlxrdWyrCcTt9OO9ovgQ+ElRvDYdJ7IUzoODZAtUrimJypg3oxELSYNKWLvMOX
 K+7o2Il0lPuDDuQLoTpmD1kJksSLPuQ3OPXWZZWsMg6SzfSbzTzkEmZkSiClREkv
 aRtXcHoa0ko246v3dJr+2bEPeLtEuekZm/tqnYNhokLULlt1L6cvpJfT4cVNKP2Z
 vEGXCC0Uz6zOshSdPX3PXp5ZUzUNQP62KW+mG5vNW+Nh+HaEgb03jvFc3aVUvSbh
 Jv7wMWDqr6oZD3HPvUsSGaFROuoUB69skqEvzma4tNJ5+d6QR2w2bdEg0w0ViBAL
 jXshOQh5ctCUzIsadP5SGA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym12j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THfAdJ020441; Thu, 29 May 2025 19:24:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeQx022158;
 Thu, 29 May 2025 19:24:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-7; Thu, 29 May 2025 19:24:45 +0000
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
Subject: [PATCH V4 06/43] migration: lower handler priority
Date: Thu, 29 May 2025 12:24:02 -0700
Message-Id: <1748546679-154091-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: 6gZuCshl2P95IBGE_XggaBzrgsadqNSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX8KPrfELRUcA7
 bFjOJRY0/cnOJw4B8Xtrmy57zpTBRoGxKmGuaZ7VLbAcaRGn9FgpQvUcLv4foKwg6nZNWmoWUBi
 N8z66k66NBBKeLQZic7+3lNbejAISCCGugtIITXpssMCZ111MVpAZtn1pSRRJQiyx28bRel99eC
 eS+hilNoURzEgXz346GgWEo84ptNOwW18l0xxbcyjnMZ31AO7de+kZ1RsExrM94ivco8CGec+9C
 moFbBCeOjlyotvxtRcRh06ZMg4RxhlM+4kPW9J12DVW6rn+G62uMIp3/JfqyPI54zZTxydC7sSw
 BAV32PZBX4DFIjC8erk2beO/bpHkcjycjkenx7oplUuPd3OgMhckjojLBBkmnYEkin8ybU5CpGq
 WkQEpsm/H7PvlNMWUXra18RzlXzHLo3Kcm+QTpbr3uap7AJCAQgojkl3nO7yA/cezoKCY7/P
X-Proofpoint-ORIG-GUID: 6gZuCshl2P95IBGE_XggaBzrgsadqNSX
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838b47f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=AmUmXUaXWCDEmLEOI0wA:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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
index 006514c..7e87815 100644
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


