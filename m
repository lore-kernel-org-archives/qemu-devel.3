Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB71DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMH-0004Xw-Eb; Mon, 29 Apr 2024 11:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMB-0004Vr-7s
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TM4-0005Ea-75
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:53 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmsuB024847; Mon, 29 Apr 2024 15:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=DxeHxy1bq5kO0rBm8da1QGgj35Yav5ReaUbTJuUkAjA=;
 b=ObyA7MC7BP6AojsHELxfJbKKq9q9NfcQUo9dTwLiWtj7Z2ezazbFB/kj6MY/wjTe37pU
 W+l6MDSyxbaCQQnQAEQ7knNrzYZ5kQyNfyOQ+UWz0Wy+Bh7UFmMJ0xUvbiuGr3KrojNr
 4mBJOOqbpJ2yE1MQcIxDZ94bv2sfWO5sKCDs88FWQDr/sB0a57aKfc/wJL5OJNhsW5mj
 UcM11T9J7XCL3xFBHCxpGkPEmhOJjJ6HDye6eEWl/mb03a/+3csApVBx+Wphoo2D6NZq
 /804KKAQDTWRXZUATACoYcdk3vPBeWnGox/JQlA1bzBdMB2B7D6X7QyhaAVI+JYMHkNz Cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsetx3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:40 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEuHws011355; Mon, 29 Apr 2024 15:55:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j634-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:39 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGY034442;
 Mon, 29 Apr 2024 15:55:38 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-4; Mon, 29 Apr 2024 15:55:38 +0000
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
Subject: [PATCH V1 03/26] migration: SAVEVM_FOREACH
Date: Mon, 29 Apr 2024 08:55:12 -0700
Message-Id: <1714406135-451286-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: siASKqHzQ5DYvLwFrORQhU0nLO1ACnbl
X-Proofpoint-GUID: siASKqHzQ5DYvLwFrORQhU0nLO1ACnbl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define an abstraction SAVEVM_FOREACH to loop over all savevm state
handlers, and replace QTAILQ_FOREACH.  Define variants for ALL so
we can loop over all handlers vs a subset of handlers in a subsequent
patch, but at this time there is no distinction between the two.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/savevm.c | 55 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4509482..6829ba3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -237,6 +237,15 @@ static SaveState savevm_state = {
     .global_section_id = 0,
 };
 
+#define SAVEVM_FOREACH(se, entry)                                    \
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
+
+#define SAVEVM_FOREACH_ALL(se, entry)                                \
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry)
+
+#define SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se)                   \
+    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se)
+
 static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id);
 
 static bool should_validate_capability(int capability)
@@ -674,7 +683,7 @@ static uint32_t calculate_new_instance_id(const char *idstr)
     SaveStateEntry *se;
     uint32_t instance_id = 0;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH_ALL(se, entry) {
         if (strcmp(idstr, se->idstr) == 0
             && instance_id <= se->instance_id) {
             instance_id = se->instance_id + 1;
@@ -690,7 +699,7 @@ static int calculate_compat_instance_id(const char *idstr)
     SaveStateEntry *se;
     int instance_id = 0;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->compat) {
             continue;
         }
@@ -816,7 +825,7 @@ void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque)
     }
     pstrcat(id, sizeof(id), idstr);
 
-    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
+    SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se) {
         if (strcmp(se->idstr, id) == 0 && se->opaque == opaque) {
             savevm_state_handler_remove(se);
             g_free(se->compat);
@@ -939,7 +948,7 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
 {
     SaveStateEntry *se, *new_se;
 
-    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
+    SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se) {
         if (se->vmsd == vmsd && se->opaque == opaque) {
             savevm_state_handler_remove(se);
             g_free(se->compat);
@@ -1223,7 +1232,7 @@ bool qemu_savevm_state_blocked(Error **errp)
 {
     SaveStateEntry *se;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->vmsd && se->vmsd->unmigratable) {
             error_setg(errp, "State blocked by non-migratable device '%s'",
                        se->idstr);
@@ -1237,7 +1246,7 @@ void qemu_savevm_non_migratable_list(strList **reasons)
 {
     SaveStateEntry *se;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->vmsd && se->vmsd->unmigratable) {
             QAPI_LIST_PREPEND(*reasons,
                               g_strdup_printf("non-migratable device: %s",
@@ -1276,7 +1285,7 @@ bool qemu_savevm_state_guest_unplug_pending(void)
 {
     SaveStateEntry *se;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->vmsd && se->vmsd->dev_unplug_pending &&
             se->vmsd->dev_unplug_pending(se->opaque)) {
             return true;
@@ -1291,7 +1300,7 @@ int qemu_savevm_state_prepare(Error **errp)
     SaveStateEntry *se;
     int ret;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->save_prepare) {
             continue;
         }
@@ -1321,7 +1330,7 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
     json_writer_start_array(ms->vmdesc, "devices");
 
     trace_savevm_state_setup();
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
             ret = vmstate_save(f, se, ms->vmdesc, errp);
             if (ret) {
@@ -1365,7 +1374,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
 
     trace_savevm_state_resume_prepare();
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->resume_prepare) {
             continue;
         }
@@ -1396,7 +1405,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
     int ret;
 
     trace_savevm_state_iterate();
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->save_live_iterate) {
             continue;
         }
@@ -1461,7 +1470,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     SaveStateEntry *se;
     int ret;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->save_live_complete_postcopy) {
             continue;
         }
@@ -1495,7 +1504,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     SaveStateEntry *se;
     int ret;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops ||
             (in_postcopy && se->ops->has_postcopy &&
              se->ops->has_postcopy(se->opaque)) ||
@@ -1543,7 +1552,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     Error *local_err = NULL;
     int ret;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
             /* Already saved during qemu_savevm_state_setup(). */
             continue;
@@ -1649,7 +1658,7 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
     *must_precopy = 0;
     *can_postcopy = 0;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->state_pending_estimate) {
             continue;
         }
@@ -1670,7 +1679,7 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
     *must_precopy = 0;
     *can_postcopy = 0;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->state_pending_exact) {
             continue;
         }
@@ -1693,7 +1702,7 @@ void qemu_savevm_state_cleanup(void)
     }
 
     trace_savevm_state_cleanup();
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->ops && se->ops->save_cleanup) {
             se->ops->save_cleanup(se->opaque);
         }
@@ -1778,7 +1787,7 @@ int qemu_save_device_state(QEMUFile *f)
     }
     cpu_synchronize_all_states();
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         int ret;
 
         if (se->is_ram) {
@@ -1801,7 +1810,7 @@ static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
 {
     SaveStateEntry *se;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH_ALL(se, entry) {
         if (!strcmp(se->idstr, idstr) &&
             (instance_id == se->instance_id ||
              instance_id == se->alias_id))
@@ -2680,7 +2689,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis,
     }
 
     trace_qemu_loadvm_state_section_partend(section_id);
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->load_section_id == section_id) {
             break;
         }
@@ -2755,7 +2764,7 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
 {
     SaveStateEntry *se;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->switchover_ack_needed) {
             continue;
         }
@@ -2775,7 +2784,7 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
     int ret;
 
     trace_loadvm_state_setup();
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->load_setup) {
             continue;
         }
@@ -2801,7 +2810,7 @@ void qemu_loadvm_state_cleanup(void)
     SaveStateEntry *se;
 
     trace_loadvm_state_cleanup();
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->ops && se->ops->load_cleanup) {
             se->ops->load_cleanup(se->opaque);
         }
-- 
1.8.3.1


