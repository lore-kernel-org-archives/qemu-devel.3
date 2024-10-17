Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219B6D374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SCy-000780-6P; Thu, 17 Oct 2024 11:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCv-00077H-Ql
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCu-00014Q-3A
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:33 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBdMG025055;
 Thu, 17 Oct 2024 15:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=zJQyAAgoRK7Sa1RkUhlX0t66qLvJZN64Bq3Y4xKVkos=; b=
 i8gMZCXedeopozj0wz8e6EwP3/lAW/iJNs+j2Vj/hzKWjVQ9JbBKt0RJDXcZOsvM
 Ec3j0HuPNBzqcDr8fbx4VZuv/DmAM3jSDS2saw1CCEtjdHY+h8q1qkjxsAepP0yd
 ABKNs/SLHFlB3FkCnBI0CSQ/azy2VZ3vlRDSCHYfn5wIcowdUAqkZNczOVOa5q6u
 y1ujihhJ95PTkpXHwWOM21UphZfPxPAjtbpkgPVvmSvU6makkLOG1h16ECu6DT3m
 3afKpQCrerREfEWYxUDTUdirb/+DHuWRfhO90e09qQnUpMOxYksmfUbt5JRLuSK/
 wotszkuWErhqgmVaWO3S0Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1apg1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HE32Dj027154; Thu, 17 Oct 2024 15:14:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy68j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:24 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgb017147;
 Thu, 17 Oct 2024 15:14:24 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-6; Thu, 17 Oct 2024 15:14:24 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 05/14] migration: init and listen during precreate
Date: Thu, 17 Oct 2024 08:14:06 -0700
Message-Id: <1729178055-207271-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170105
X-Proofpoint-GUID: Zoe9OEV40VBqLYRAoDdAtf3JXB0B91v5
X-Proofpoint-ORIG-GUID: Zoe9OEV40VBqLYRAoDdAtf3JXB0B91v5
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

Initialize the migration object as early as possible so that migration
configuration commands may be sent during the precreate phase.  Also,
start listening for the incoming migration connection during precreate,
so that the listen port number is assigned (if dynamic), and the user
can discover it during precreate via query-migrate.  The precreate phase
will be delineated in a subsequent patch.

The code previously called migration_object_init after memory backends
were created so that a subsequent migrate-set-capabilities call to set
MIGRATION_CAPABILITY_POSTCOPY_RAM would verify all backends support
postcopy.  See migrate_caps_check and postcopy_ram_supported_by_host.
The new code calls migration_object_init before backends are created.
However, migrate-set-capabilities will only be received during the
precreate phase for CPR, and CPR does not support postcopy.  If the
precreate phase is generalized in the future, then the ram compatibility
check must be deferred to the start of migration.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/vl.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index bca2292..d32203c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2753,17 +2753,7 @@ void qmp_x_exit_preconfig(Error **errp)
         replay_vmstate_init();
     }
 
-    if (incoming) {
-        Error *local_err = NULL;
-        if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, false, NULL, true, true,
-                                 &local_err);
-            if (local_err) {
-                error_reportf_err(local_err, "-incoming %s: ", incoming);
-                exit(1);
-            }
-        }
-    } else if (autostart) {
+    if (!incoming && autostart) {
         qmp_cont(NULL);
     }
 }
@@ -3751,6 +3741,18 @@ void qemu_init(int argc, char **argv)
      * called from do_configure_accelerator().
      */
 
+    /* Creates a QOM object */
+    migration_object_init();
+
+    if (incoming && !g_str_equal(incoming, "defer")) {
+        Error *local_err = NULL;
+        qmp_migrate_incoming(incoming, false, NULL, true, true, &local_err);
+        if (local_err) {
+            error_reportf_err(local_err, "-incoming %s: ", incoming);
+            exit(1);
+        }
+    }
+
     suspend_mux_open();
 
     qemu_disable_default_devices();
@@ -3773,20 +3775,9 @@ void qemu_init(int argc, char **argv)
                      machine_class->name, machine_class->deprecation_reason);
     }
 
-    /*
-     * Create backends before creating migration objects, so that it can
-     * check against compatibilities on the backend memories (e.g. postcopy
-     * over memory-backend-file objects).
-     */
     qemu_create_late_backends();
     phase_advance(PHASE_LATE_BACKENDS_CREATED);
 
-    /*
-     * Note: creates a QOM object, must run only after global and
-     * compat properties have been set up.
-     */
-    migration_object_init();
-
     /* parse features once if machine provides default cpu_type */
     current_machine->cpu_type = machine_class_default_cpu_type(machine_class);
     if (cpu_option) {
-- 
1.8.3.1


