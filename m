Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EADC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMU-0004ib-KU; Mon, 29 Apr 2024 11:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMJ-0004Zp-Dd
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMF-0005Ex-VM
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:03 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmn2D023135; Mon, 29 Apr 2024 15:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=HZrv1nFWtE6Nl7XyPOcCaiN32/YoQ6R+20VVNPwSEUk=;
 b=bEDLS/LKXmi+P8SBtrIEujkndt551tLiCoCsXxydsfYwtLWU7VTv8wDNvdBOM60lUFJ9
 8jwYArAlqMB26iURylTQ7C30+XLkuq09hjWc5BM+AsfE7S6QWr5vL1/e/h9rHEBr3Kid
 8L9aJHHf8HhmWaVCbF4ksKMsurVji5oiiWzv780SqMfTQOpWeC5M+ARDtC91o59EPICG
 UA32KpeT2aidKhOFR3e2eYAIJrwZr6KIo7bgSrzdUVLo+sdWz8LU85w3ccYA70+16KQv
 lrF7CBHe8I+iXnxtgLiuozrvrm9GeoAQtkgurgccb7nBmepFqy5nbGH51srPRsKLm+go 3A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryv2wbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:42 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TFVc5C011501; Mon, 29 Apr 2024 15:55:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j65t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGg034442;
 Mon, 29 Apr 2024 15:55:41 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-8; Mon, 29 Apr 2024 15:55:41 +0000
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
Subject: [PATCH V1 07/26] migration: VMStateId
Date: Mon, 29 Apr 2024 08:55:16 -0700
Message-Id: <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: pEkksVTdrNfiyxDXjEK5ht38loEMuz1S
X-Proofpoint-ORIG-GUID: pEkksVTdrNfiyxDXjEK5ht38loEMuz1S
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

Define a type for the 256 byte id string to guarantee the same length is
used and enforced everywhere.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/exec/ramblock.h     | 3 ++-
 include/migration/vmstate.h | 2 ++
 migration/savevm.c          | 8 ++++----
 migration/vmstate.c         | 3 ++-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 0babd10..61deefe 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -23,6 +23,7 @@
 #include "cpu-common.h"
 #include "qemu/rcu.h"
 #include "exec/ramlist.h"
+#include "migration/vmstate.h"
 
 struct RAMBlock {
     struct rcu_head rcu;
@@ -35,7 +36,7 @@ struct RAMBlock {
     void (*resized)(const char*, uint64_t length, void *host);
     uint32_t flags;
     /* Protected by the BQL.  */
-    char idstr[256];
+    VMStateId idstr;
     /* RCU-enabled, writes protected by the ramlist lock */
     QLIST_ENTRY(RAMBlock) next;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 4691334..a39c0e6 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1210,6 +1210,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
 bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
 
+typedef char (VMStateId)[256];
+
 #define  VMSTATE_INSTANCE_ID_ANY  -1
 
 /* Returns: 0 on success, -1 on failure */
diff --git a/migration/savevm.c b/migration/savevm.c
index a30bcd9..9b1a335 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -197,13 +197,13 @@ const VMStateInfo vmstate_info_timer = {
 
 
 typedef struct CompatEntry {
-    char idstr[256];
+    VMStateId idstr;
     int instance_id;
 } CompatEntry;
 
 typedef struct SaveStateEntry {
     QTAILQ_ENTRY(SaveStateEntry) entry;
-    char idstr[256];
+    VMStateId idstr;
     uint32_t instance_id;
     int alias_id;
     int version_id;
@@ -814,7 +814,7 @@ int register_savevm_live(const char *idstr,
 void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque)
 {
     SaveStateEntry *se, *new_se;
-    char id[256] = "";
+    VMStateId id = "";
 
     if (obj) {
         char *oid = vmstate_if_get_id(obj);
@@ -2650,7 +2650,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     uint32_t instance_id, version_id, section_id;
     int64_t start_ts, end_ts;
     SaveStateEntry *se;
-    char idstr[256];
+    VMStateId idstr;
     int ret;
 
     /* Read section start */
diff --git a/migration/vmstate.c b/migration/vmstate.c
index ef26f26..437f156 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -471,7 +471,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
     trace_vmstate_subsection_load(vmsd->name);
 
     while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
-        char idstr[256], *idstr_ret;
+        VMStateId idstr;
+        char *idstr_ret;
         int ret;
         uint8_t version_id, len, size;
         const VMStateDescription *sub_vmsd;
-- 
1.8.3.1


