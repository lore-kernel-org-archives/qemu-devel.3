Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8D2C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiss-0004Lk-KF; Thu, 29 May 2025 15:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisa-0004Gi-Kt
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisX-0000Sx-Ou
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:27 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsfV009713;
 Thu, 29 May 2025 19:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=In627JaG1hPFqxgXXuJFpml26dBJklsKNbeCDRzAIeI=; b=
 ofzAWYkdbB7Lf7NnrlUrUisuX2KNIvvD+Je1Em2u4rwmU9I3oUngojtinurE+9NU
 qGkZbCs7mwor4k5QHnNqTW73aMlqci3+3/Z9mkeT2tqnIS4XaiumnOWj0Ieao9Dn
 26F1faLvPnDz7S1KZfJ4Rnp16Kgot/TDjW51ijdkBrhsP2rgP/o/K7XY+q1crBYS
 A4b3WfXMtXeZw5aWvefhTbGhwUzo4Okp2+H+5lUlTERR5CbC3CY++M0/xPCQaxcQ
 wF2qhb/5pcOn0e2OpmBmWafzBcnUiY75yPTZA+v1eGz9joFYJ8iOLPWl+bRU1Eve
 +9kBczWwFiFe4RhbHpyD3A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u0yve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THjBKZ020311; Thu, 29 May 2025 19:25:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRx022158;
 Thu, 29 May 2025 19:25:10 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-37; Thu, 29 May 2025 19:25:10 +0000
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
Subject: [PATCH V4 36/43] migration: vfio cpr state hook
Date: Thu, 29 May 2025 12:24:32 -0700
Message-Id: <1748546679-154091-37-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: iA1A7o1LaE_BcdeokNa4w5ID-a8RqRi0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX4/jgOn+zWgsn
 QE6U8RAysMHDF2b2BNNHS9yzt5zLDT5B7a4QlptuuTPk+vcin8cpH6oX9O0hMbc4Jtz4Qf2W53P
 asKr7qdmnqD31Yg1nirDOYrKOXMnfaWWbKzVK02NK5DLWjktN7mw9u90QFHuASy0wur7Cz6vRir
 LOOZywx+mTfcjjUONoDpJPsQ5/+PKJwywsY46yPuu48hM2mZVa61P+c10+M+tz9qTZvvm7EXLEg
 8625jcso3Wvp1p865ja0Yli2UfqtxrSnpy3sYqOK1vB/mWZyaRpyw/1laoCLEqRVLXS7KpNmEha
 CzF40ujMjtiYH4fdGXI04VSXfmV+jcRC/OMEYk3+zYa3WeUOxsu6NM5afNyCMyAKfcOho+G4GWR
 Kb+YrmCZaZKxU/TJ+h3tGdUZoyMdbukLDLci+m56Z+Q5b5TGs+mxk+YuA6AigeIyNm8Qkexm
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6838b497 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=bezEeA6fTHJnwGyA9vgA:9
X-Proofpoint-ORIG-GUID: iA1A7o1LaE_BcdeokNa4w5ID-a8RqRi0
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

Define a list of vfio devices in CPR state, in a subsection so that
older QEMU can be live updated to this version.  However, new QEMU
will not be live updateable to old QEMU.  This is acceptable because
CPR is not yet commonly used, and updates to older versions are unusual.

The contents of each device object will be defined by the vfio subsystem
in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/hw/vfio/vfio-cpr.h |  1 +
 include/migration/cpr.h    | 12 ++++++++++++
 hw/vfio/cpr-iommufd.c      |  2 ++
 migration/cpr.c            | 14 +++++---------
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index b9b77ae..619af07 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -74,5 +74,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                                int nr);
 
 extern const VMStateDescription vfio_cpr_pci_vmstate;
+extern const VMStateDescription vmstate_cpr_vfio_devices;
 
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 7fd8065..8fd8bfe 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -9,11 +9,23 @@
 #define MIGRATION_CPR_H
 
 #include "qapi/qapi-types-migration.h"
+#include "qemu/queue.h"
 
 #define MIG_MODE_NONE           -1
 
 #define QEMU_CPR_FILE_MAGIC     0x51435052
 #define QEMU_CPR_FILE_VERSION   0x00000001
+#define CPR_STATE "CprState"
+
+typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
+typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice) CprVFIODeviceList;
+
+typedef struct CprState {
+    CprFdList fds;
+    CprVFIODeviceList vfio_devices;
+} CprState;
+
+extern CprState cpr_state;
 
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 60bd7e8..3e78265 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -14,6 +14,8 @@
 #include "system/iommufd.h"
 #include "vfio-iommufd.h"
 
+const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later patch */
+
 static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
 {
     if (!iommufd_change_process_capable(be)) {
diff --git a/migration/cpr.c b/migration/cpr.c
index 4574608..47898ab 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -22,13 +22,7 @@
 /*************************************************************************/
 /* cpr state container for all information to be saved. */
 
-typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
-
-typedef struct CprState {
-    CprFdList fds;
-} CprState;
-
-static CprState cpr_state;
+CprState cpr_state;
 
 /****************************************************************************/
 
@@ -129,8 +123,6 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 }
 
 /*************************************************************************/
-#define CPR_STATE "CprState"
-
 static const VMStateDescription vmstate_cpr_state = {
     .name = CPR_STATE,
     .version_id = 1,
@@ -138,6 +130,10 @@ static const VMStateDescription vmstate_cpr_state = {
     .fields = (VMStateField[]) {
         VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_cpr_vfio_devices,
+        NULL
     }
 };
 /*************************************************************************/
-- 
1.8.3.1


