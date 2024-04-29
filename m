Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43948C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMb-00055E-F1; Mon, 29 Apr 2024 11:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMI-0004Y7-2G
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TME-0005KM-WD
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:01 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFnpqi003604; Mon, 29 Apr 2024 15:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=0z80vD9gJHUUN6VSjk6F74K/JUahJKBy+uwGOPFalAc=;
 b=JmWtfTCsB4t31pozNc6Du5FyR2NY10OE22AO8tKVZnxOxXqiJ1m8ISTZmC51peEbRniq
 WL1y4nXU+ECeXJoBjsJRIaii2H7XMg55vH6yoy5tc28tCY8WZBAeqwCdg39Ogu9Zv3yq
 Z4NJ+hkST6eJ33Z650E/HxcfznRaYPG4QahVo8fdBM0Vy521M1MAsKImBrsWK0jhvlq+
 D2NZ7G3Rdv01FHCEgnw1t1b240Oaga4HUSA+QFtBqq2DmE4ZemkBJlEqzwgzAN3c2X6I
 EgPMEuVkbqoQSq+JZfpJaca++iFefxKYfDBPyF1Aw0b574G0EamFrQy7O8Q4KMQu9jb5 qQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9ck10x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:54 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TF1T3C011502; Mon, 29 Apr 2024 15:55:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaHE034442;
 Mon, 29 Apr 2024 15:55:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-24; Mon, 29 Apr 2024 15:55:53 +0000
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
Subject: [PATCH V1 23/26] migration: misc cpr-exec blockers
Date: Mon, 29 Apr 2024 08:55:32 -0700
Message-Id: <1714406135-451286-24-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: UARJ5-I5Ju3WsUQCfewP7UeGh73cvy83
X-Proofpoint-ORIG-GUID: UARJ5-I5Ju3WsUQCfewP7UeGh73cvy83
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add blockers for cpr-exec migration mode for devices and options that do
not support it.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 accel/xen/xen-all.c    |  5 +++++
 backends/hostmem-epc.c | 12 ++++++++++--
 hw/vfio/migration.c    |  3 ++-
 replay/replay.c        |  6 ++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 0bdefce..9a7ed0f 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -78,6 +78,7 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
 static int xen_init(MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    Error *blocker = NULL;
 
     xen_xc = xc_interface_open(0, 0, 0);
     if (xen_xc == NULL) {
@@ -112,6 +113,10 @@ static int xen_init(MachineState *ms)
     mc->default_ram_id = NULL;
 
     xen_mode = XEN_ATTACH;
+
+    error_setg(&blocker, "xen does not support cpr exec");
+    migrate_add_blocker_mode(&blocker, MIG_MODE_CPR_EXEC, &error_fatal);
+
     return 0;
 }
 
diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index 735e2e1..837300f 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -15,6 +15,7 @@
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
 #include "sysemu/hostmem.h"
+#include "migration/blocker.h"
 #include "hw/i386/hostmem-epc.h"
 
 static bool
@@ -23,6 +24,7 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     g_autofree char *name = NULL;
     uint32_t ram_flags;
     int fd;
+    Error *blocker = NULL;
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
@@ -38,8 +40,14 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     name = object_get_canonical_path(OBJECT(backend));
     ram_flags = (backend->share ? RAM_SHARED : 0) | RAM_PROTECTED;
-    return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
-                                          backend->size, ram_flags, fd, 0, errp);
+    if (!memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
+                                        name, backend->size, ram_flags,
+                                        fd, 0, errp)) {
+        return false;
+    }
+    error_setg(&blocker, "memory-backend-epc does not support cpr exec");
+    migrate_add_blocker_mode(&blocker, MIG_MODE_CPR_EXEC, &error_fatal);
+    return true;
 }
 
 static void sgx_epc_backend_instance_init(Object *obj)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 06ae409..b9cd783 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -898,7 +898,8 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
     vbasedev->migration_blocker = error_copy(err);
     error_free(err);
 
-    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
+    return migrate_add_blocker_modes(&vbasedev->migration_blocker, errp,
+                                     MIG_MODE_NORMAL, MIG_MODE_CPR_EXEC, -1);
 }
 
 /* ---------------------------------------------------------------------- */
diff --git a/replay/replay.c b/replay/replay.c
index a2c576c..1bf3f38 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -19,6 +19,7 @@
 #include "qemu/option.h"
 #include "sysemu/cpus.h"
 #include "qemu/error-report.h"
+#include "migration/blocker.h"
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
@@ -339,6 +340,11 @@ G_NORETURN void replay_sync_error(const char *error)
 static void replay_enable(const char *fname, int mode)
 {
     const char *fmode = NULL;
+    Error *blocker = NULL;
+
+    error_setg(&blocker, "replay is not compatible with cpr");
+    migrate_add_blocker_mode(&blocker, MIG_MODE_CPR_EXEC, &error_fatal);
+
     assert(!replay_file);
 
     switch (mode) {
-- 
1.8.3.1


