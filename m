Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DBDC19F53
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMJ-0004Zy-Qd; Mon, 29 Apr 2024 11:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMB-0004Vx-MS
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TM4-0005F1-LW
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:55 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmjb4006712; Mon, 29 Apr 2024 15:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=yo0i2IaEWoAUYk4MxRQWxqRVVF0sXL4SczE0OahgkO0=;
 b=PE63jmzQDU+UPeEli2ouHIbpcnZHEi7eNt0oCzknb9JGodR6oxkyq4I/JrVdnzhlOKR9
 OZzHGFakyJ6iFcmdcO5dkJOAM7E8kc+iToR2ZMP2L4cZnZbEQUYugXxGDA1RDqGjxq8i
 GA+EraQ3UuP2DuyZBLGAEV+R7R0GL6IwGD5zI43NAoFv1BYDxo06wi2n3ebSr71Lr+bX
 0QOR3+XpikRCMCxARntfu7tMxmiEZYtfqrsoslH9Go/6W492OQlYl9cv5JqMCXkLOuWj
 d+JRtNT75M0EntxfYQTzB7VJppRBXpw1Wz7Hhaui31Qu1dw0VaWp1zJOeuUUgtKRmZXv DA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdejwmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:41 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEgWMd011336; Mon, 29 Apr 2024 15:55:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j64f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:40 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGc034442;
 Mon, 29 Apr 2024 15:55:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-6; Mon, 29 Apr 2024 15:55:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 05/26] migration: precreate vmstate
Date: Mon, 29 Apr 2024 08:55:14 -0700
Message-Id: <1714406135-451286-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290101
X-Proofpoint-GUID: gMELQzHGA4M0LMoXiVrIZatgWVcZtksl
X-Proofpoint-ORIG-GUID: gMELQzHGA4M0LMoXiVrIZatgWVcZtksl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Provide the VMStateDescription precreate field to mark objects that must
be loaded on the incoming side before devices have been created, because
they provide properties that will be needed at creation time.  They will
be saved to and loaded from their own QEMUFile, via
qemu_savevm_precreate_save and qemu_savevm_precreate_load, but these
functions are not yet called in this patch.  Allow them to be called
before or after normal migration is active, when current_migration and
current_incoming are not valid.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/vmstate.h |  6 ++++
 migration/savevm.c          | 69 +++++++++++++++++++++++++++++++++++++++++----
 migration/savevm.h          |  3 ++
 3 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 294d2d8..4691334 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -198,6 +198,12 @@ struct VMStateDescription {
      * a QEMU_VM_SECTION_START section.
      */
     bool early_setup;
+
+    /*
+     * Send/receive this object in the precreate migration stream.
+     */
+    bool precreate;
+
     int version_id;
     int minimum_version_id;
     MigrationPriority priority;
diff --git a/migration/savevm.c b/migration/savevm.c
index 9789823..a30bcd9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -239,6 +239,7 @@ static SaveState savevm_state = {
 
 #define SAVEVM_FOREACH(se, entry)                                    \
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
+        if (!se->vmsd || !se->vmsd->precreate)
 
 #define SAVEVM_FOREACH_ALL(se, entry)                                \
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry)
@@ -1006,13 +1007,19 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
     }
 }
 
+static bool send_section_footer(SaveStateEntry *se)
+{
+    return (se->vmsd && se->vmsd->precreate) ||
+           migrate_get_current()->send_section_footer;
+}
+
 /*
  * Write a footer onto device sections that catches cases misformatted device
  * sections.
  */
 static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
 {
-    if (migrate_get_current()->send_section_footer) {
+    if (send_section_footer(se)) {
         qemu_put_byte(f, QEMU_VM_SECTION_FOOTER);
         qemu_put_be32(f, se->section_id);
     }
@@ -1319,6 +1326,52 @@ int qemu_savevm_state_prepare(Error **errp)
     return 0;
 }
 
+int qemu_savevm_precreate_save(QEMUFile *f, Error **errp)
+{
+    int ret;
+    SaveStateEntry *se;
+
+    qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
+    qemu_put_be32(f, QEMU_VM_FILE_VERSION);
+
+    SAVEVM_FOREACH_ALL(se, entry) {
+        if (se->vmsd && se->vmsd->precreate) {
+            ret = vmstate_save(f, se, NULL, errp);
+            if (ret) {
+                qemu_file_set_error(f, ret);
+                return ret;
+            }
+        }
+    }
+    qemu_fflush(f);
+    return 0;
+}
+
+int qemu_savevm_precreate_load(QEMUFile *f, Error **errp)
+{
+    unsigned int v;
+    int ret;
+
+    v = qemu_get_be32(f);
+    if (v != QEMU_VM_FILE_MAGIC) {
+        error_setg(errp, "Not a migration stream");
+        return -EINVAL;
+    }
+
+    v = qemu_get_be32(f);
+    if (v != QEMU_VM_FILE_VERSION) {
+        error_setg(errp, "Unsupported migration stream version");
+        return -ENOTSUP;
+    }
+
+    ret = qemu_loadvm_state_main(f, NULL);
+    if (ret) {
+        error_setg_errno(errp, -ret, "qemu_savevm_precreate_load");
+    }
+
+    return ret;
+}
+
 int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
 {
     ERRP_GUARD();
@@ -2559,7 +2612,7 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
     uint8_t read_mark;
     uint32_t read_section_id;
 
-    if (!migrate_get_current()->send_section_footer) {
+    if (!send_section_footer(se)) {
         /* No footer to check */
         return true;
     }
@@ -2895,9 +2948,12 @@ retry:
     while (true) {
         section_type = qemu_get_byte(f);
 
-        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
-        if (ret) {
-            break;
+        if (mis) {
+            ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst,
+                                              NULL);
+            if (ret) {
+                break;
+            }
         }
 
         trace_qemu_loadvm_state_section(section_type);
@@ -2936,6 +2992,9 @@ retry:
 out:
     if (ret < 0) {
         qemu_file_set_error(f, ret);
+        if (!mis) {
+            return ret;
+        }
 
         /* Cancel bitmaps incoming regardless of recovery */
         dirty_bitmap_mig_cancel_incoming();
diff --git a/migration/savevm.h b/migration/savevm.h
index 9ec96a9..6f207b5 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -70,4 +70,7 @@ int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy, bool inactivate_disks);
 
+int qemu_savevm_precreate_save(QEMUFile *f, Error **errp);
+int qemu_savevm_precreate_load(QEMUFile *f, Error **errp);
+
 #endif
-- 
1.8.3.1


