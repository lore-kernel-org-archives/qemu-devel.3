Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136C3C19F53
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMX-0004wL-Rx; Mon, 29 Apr 2024 11:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMJ-0004aG-Rk
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMG-0005Kk-UR
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFncI6017546; Mon, 29 Apr 2024 15:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=6/yzYvmrOyiE45IoO54xQG76mwyvh+VmExAEkFTHCAM=;
 b=D42+6OfjTW27SCvs0i8gK3pIeD63IlspjayYtIZvjo2YHIPWIVLBGxLyehdP65wx7PR1
 jQ22ZNnPyU7Ij4UsOHcErHWKfFgUvxePPYSsaAzaGvURFjh2c0qLMYafr/AFnIu/Nfc4
 l2QGw4olRVo5xg1hy7Z4N0PK8HV/kRgrp/1j71ejPKaTERMFlZ+qqYeEuLJ53FCouKwb
 GTuO70f/O3gakCpErqalYFoDU/I7nxB9GlONbw3zUXxn7dN44wUbvvBAToPF7Pu91qwb
 zBaPG/w0JHAAdGd/n+lze4YErHTY/aoBf+mhzRJnNPpmWr73qVrb1txG/ooTHDXaU6Pl /A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cjxdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:56 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEheoP011366; Mon, 29 Apr 2024 15:55:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6pc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:56 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaHK034442;
 Mon, 29 Apr 2024 15:55:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-27; Mon, 29 Apr 2024 15:55:55 +0000
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
Subject: [PATCH V1 26/26] migration: only-migratable-modes
Date: Mon, 29 Apr 2024 08:55:35 -0700
Message-Id: <1714406135-451286-27-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: oF8VrummWUdED35UQ2I_pgZRACaZ_gmF
X-Proofpoint-ORIG-GUID: oF8VrummWUdED35UQ2I_pgZRACaZ_gmF
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

Add the only-migratable-modes option as a generalization of only-migratable.
Only devices that support all requested modes are allowed.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h       |  3 +++
 include/sysemu/sysemu.h        |  1 -
 migration/migration-hmp-cmds.c | 26 +++++++++++++++++++++++++-
 migration/migration.c          | 22 +++++++++++++++++-----
 migration/savevm.c             |  2 +-
 qemu-options.hx                | 16 ++++++++++++++--
 system/globals.c               |  1 -
 system/vl.c                    | 13 ++++++++++++-
 target/s390x/cpu_models.c      |  4 +++-
 9 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 5b963ba..3ad2cd9 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -119,6 +119,9 @@ bool migration_incoming_postcopy_advised(void);
 /* True if background snapshot is active */
 bool migration_in_bg_snapshot(void);
 
+void migration_set_required_mode(MigMode mode);
+bool migration_mode_required(MigMode mode);
+
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 5b4397e..0a9c4b4 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -8,7 +8,6 @@
 
 /* vl.c */
 
-extern int only_migratable;
 extern const char *qemu_name;
 extern QemuUUID qemu_uuid;
 extern bool qemu_uuid_set;
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 414c7e8..ca913b7 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "block/qapi.h"
 #include "migration/snapshot.h"
+#include "migration/misc.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
@@ -33,6 +34,28 @@
 #include "options.h"
 #include "migration.h"
 
+static void migration_dump_modes(Monitor *mon)
+{
+    int mode, n = 0;
+
+    monitor_printf(mon, "only-migratable-modes: ");
+
+    for (mode = 0; mode < MIG_MODE__MAX; mode++) {
+        if (migration_mode_required(mode)) {
+            if (n++) {
+                monitor_printf(mon, ",");
+            }
+            monitor_printf(mon, "%s", MigMode_str(mode));
+        }
+    }
+
+    if (!n) {
+        monitor_printf(mon, "none\n");
+    } else {
+        monitor_printf(mon, "\n");
+    }
+}
+
 static void migration_global_dump(Monitor *mon)
 {
     MigrationState *ms = migrate_get_current();
@@ -41,7 +64,7 @@ static void migration_global_dump(Monitor *mon)
     monitor_printf(mon, "store-global-state: %s\n",
                    ms->store_global_state ? "on" : "off");
     monitor_printf(mon, "only-migratable: %s\n",
-                   only_migratable ? "on" : "off");
+                   migration_mode_required(MIG_MODE_NORMAL) ? "on" : "off");
     monitor_printf(mon, "send-configuration: %s\n",
                    ms->send_configuration ? "on" : "off");
     monitor_printf(mon, "send-section-footer: %s\n",
@@ -50,6 +73,7 @@ static void migration_global_dump(Monitor *mon)
                    ms->decompress_error_check ? "on" : "off");
     monitor_printf(mon, "clear-bitmap-shift: %u\n",
                    ms->clear_bitmap_shift);
+    migration_dump_modes(mon);
 }
 
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
diff --git a/migration/migration.c b/migration/migration.c
index 4984dee..5535b84 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1719,17 +1719,29 @@ static bool is_busy(Error **reasonp, Error **errp)
     return false;
 }
 
-static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
+static int migration_modes_required;
+
+void migration_set_required_mode(MigMode mode)
+{
+    migration_modes_required |= BIT(mode);
+}
+
+bool migration_mode_required(MigMode mode)
+{
+    return !!(migration_modes_required & BIT(mode));
+}
+
+static bool modes_are_required(Error **reasonp, Error **errp, int modes)
 {
     ERRP_GUARD();
 
-    if (only_migratable && (modes & BIT(MIG_MODE_NORMAL))) {
+    if (migration_modes_required & modes) {
         error_propagate_prepend(errp, *reasonp,
-                                "disallowing migration blocker "
-                                "(--only-migratable) for: ");
+                                "-only-migratable{-modes}  specified, but: ");
         *reasonp = NULL;
         return true;
     }
+
     return false;
 }
 
@@ -1783,7 +1795,7 @@ int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
     modes = get_modes(mode, ap);
     va_end(ap);
 
-    if (is_only_migratable(reasonp, errp, modes)) {
+    if (modes_are_required(reasonp, errp, modes)) {
         return -EACCES;
     } else if (is_busy(reasonp, errp)) {
         return -EBUSY;
diff --git a/migration/savevm.c b/migration/savevm.c
index 6087c3a..e53ac84 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3585,7 +3585,7 @@ void vmstate_register_ram_global(MemoryRegion *mr)
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 {
     /* check needed if --only-migratable is specified */
-    if (!only_migratable) {
+    if (!migration_mode_required(MIG_MODE_NORMAL)) {
         return true;
     }
 
diff --git a/qemu-options.hx b/qemu-options.hx
index f0dfda5..946d731 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4807,8 +4807,20 @@ DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
     "-only-migratable     allow only migratable devices\n", QEMU_ARCH_ALL)
 SRST
 ``-only-migratable``
-    Only allow migratable devices. Devices will not be allowed to enter
-    an unmigratable state.
+    Only allow devices that can migrate using normal mode. Devices will not
+    be allowed to enter an unmigratable state.
+ERST
+
+DEF("only-migratable-modes", HAS_ARG, QEMU_OPTION_only_migratable_modes, \
+    "-only-migratable-modes mode1[,...]\n"
+    "                allow only devices that are migratable using mode(s)\n",
+    QEMU_ARCH_ALL)
+SRST
+``-only-migratable-modes mode1[,...]``
+    Only allow devices which are migratable using all modes in the list,
+    which guarantees that migration will not fail due to a blocker.
+    If both only-migratable-modes and only-migratable are specified,
+    or are specified multiple times, then the required modes accumulate.
 ERST
 
 DEF("nodefaults", 0, QEMU_OPTION_nodefaults, \
diff --git a/system/globals.c b/system/globals.c
index e353584..fdc263e 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -48,7 +48,6 @@ const char *qemu_name;
 unsigned int nb_prom_envs;
 const char *prom_envs[MAX_PROM_ENVS];
 uint8_t *boot_splash_filedata;
-int only_migratable; /* turn it off unless user states otherwise */
 int icount_align_option;
 
 /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
diff --git a/system/vl.c b/system/vl.c
index b76881e..7e73be9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3458,7 +3458,18 @@ void qemu_init(int argc, char **argv)
                 incoming = optarg;
                 break;
             case QEMU_OPTION_only_migratable:
-                only_migratable = 1;
+                migration_set_required_mode(MIG_MODE_NORMAL);
+                break;
+            case QEMU_OPTION_only_migratable_modes:
+                {
+                    int i, mode;
+                    g_autofree char **words = g_strsplit(optarg, ",", -1);
+                    for (i = 0; words[i]; i++) {
+                        mode = qapi_enum_parse(&MigMode_lookup, words[i], -1,
+                                               &error_fatal);
+                        migration_set_required_mode(mode);
+                    }
+                }
                 break;
             case QEMU_OPTION_nodefaults:
                 has_defaults = 0;
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8ed3bb6..42ad160 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -16,6 +16,7 @@
 #include "kvm/kvm_s390x.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
+#include "migration/misc.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
@@ -526,7 +527,8 @@ static void check_compatibility(const S390CPUModel *max_model,
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (only_migratable && test_bit(S390_FEAT_UNPACK, model->features)) {
+    if (migration_mode_required(MIG_MODE_NORMAL) &&
+        test_bit(S390_FEAT_UNPACK, model->features)) {
         error_setg(errp, "The unpack facility is not compatible with "
                    "the --only-migratable option. You must remove either "
                    "the 'unpack' facility or the --only-migratable option");
-- 
1.8.3.1


