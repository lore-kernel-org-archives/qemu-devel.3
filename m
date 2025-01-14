Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4C7C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkek-0004t9-DP; Tue, 14 Jan 2025 12:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXked-0004q5-5T
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkeW-0004XO-SB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:36 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC0lOZ020683;
 Tue, 14 Jan 2025 17:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=kCHlHLjR18k1Pqlms+ywU8yWmIhLhIYcY/4kHbhVxVA=; b=
 hSNzDmDjOe+UlpAsmlSZlu+cuE2dYoNYDmeHgk+PTnnxIaw3Sc/lXTpmIWVyeLHK
 5idRqCBrf/YfR+SGTCTKIm1GX73FcpTHybYDtYX3O2sLCBbMe8p//Ha6KEYwWup/
 DKmHMQrVPeYGk1rPzC0RSO0/iYpnxPFbqPyAA5ZHGrnzKFPk3jwN04yktPSw5tcf
 zKL0DMKPr7B9DEdnMXks9pNWamVu85CwFFQLwTxZdWeYz90qENB9K7GdYDiDOUDC
 rGq1WQf92xXWV6I89neEqzO0JtXqKiTWJr91ObJIGo4LuBBV9MKw8NYeALNgtQk0
 BFHFrS3bhqaKqToSCdE8hA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcpc11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EGfd5t020405; Tue, 14 Jan 2025 17:24:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3eq6f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50EHNtXs013352;
 Tue, 14 Jan 2025 17:24:17 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 443f3eq5us-13; Tue, 14 Jan 2025 17:24:17 +0000
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
Subject: [PATCH V6 12/24] migration: incoming channel
Date: Tue, 14 Jan 2025 09:23:42 -0800
Message-Id: <1736875434-106563-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140133
X-Proofpoint-GUID: 3sE30T76xBy9WoiFYCSD-bt0RKIRGzQi
X-Proofpoint-ORIG-GUID: 3sE30T76xBy9WoiFYCSD-bt0RKIRGzQi
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Extend the -incoming option to allow an @MigrationChannel to be specified.
This allows channels other than 'main' to be described on the command
line, which will be needed for CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 21 ++++++++++++++++-----
 qemu-options.hx       | 21 +++++++++++++++++++++
 system/vl.c           | 36 +++++++++++++++++++++++++++++++++---
 3 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b5ee98e..5f2540f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -695,7 +695,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     if (channels) {
         /* To verify that Migrate channel list has only item */
         if (channels->next) {
-            error_setg(errp, "Channel list has more than one entries");
+            error_setg(errp, "Channel list must have only one entry, "
+                             "for type 'main'");
             return;
         }
         addr = channels->value->addr;
@@ -2054,6 +2055,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
+    MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
 
     /*
      * Having preliminary checks for uri and channel
@@ -2064,12 +2066,21 @@ void qmp_migrate(const char *uri, bool has_channels,
     }
 
     if (channels) {
-        /* To verify that Migrate channel list has only item */
-        if (channels->next) {
-            error_setg(errp, "Channel list has more than one entries");
+        for ( ; channels; channels = channels->next) {
+            MigrationChannelType type = channels->value->channel_type;
+
+            if (channelv[type]) {
+                error_setg(errp, "Channel list has more than one %s entry",
+                           MigrationChannelType_str(type));
+                return;
+            }
+            channelv[type] = channels->value;
+        }
+        addr = channelv[MIGRATION_CHANNEL_TYPE_MAIN]->addr;
+        if (!addr) {
+            error_setg(errp, "Channel list has no main entry");
             return;
         }
-        addr = channels->value->addr;
     }
 
     if (uri) {
diff --git a/qemu-options.hx b/qemu-options.hx
index 90fad31..3d1af73 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4940,10 +4940,18 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
     "-incoming exec:cmdline\n" \
     "                accept incoming migration on given file descriptor\n" \
     "                or from given external command\n" \
+    "-incoming <channel>\n" \
+    "                accept incoming migration on the migration channel\n" \
     "-incoming defer\n" \
     "                wait for the URI to be specified via migrate_incoming\n",
     QEMU_ARCH_ALL)
 SRST
+The -incoming option specifies the migration channel for an incoming
+migration.  It may be used multiple times to specify multiple
+migration channel types.  The channel type is specified in <channel>,
+or is 'main' for all other forms of -incoming.  If multiple -incoming
+options are specified for a channel type, the last one takes precedence.
+
 ``-incoming tcp:[host]:port[,to=maxport][,ipv4=on|off][,ipv6=on|off]``
   \ 
 ``-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]``
@@ -4963,6 +4971,19 @@ SRST
     Accept incoming migration as an output from specified external
     command.
 
+``-incoming <channel>``
+    Accept incoming migration on the migration channel.  For the syntax
+    of <channel>, see the QAPI documentation of ``MigrationChannel``.
+    Examples:
+    ::
+
+        -incoming '{"channel-type": "main",
+                    "addr": { "transport": "socket",
+                              "type": "unix",
+                              "path": "my.sock" }}'
+
+        -incoming main,addr.transport=socket,addr.type=unix,addr.path=my.sock
+
 ``-incoming defer``
     Wait for the URI to be specified via migrate\_incoming. The monitor
     can be used to change settings (such as migration parameters) prior
diff --git a/system/vl.c b/system/vl.c
index 61285ad..251efa0 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -123,6 +123,7 @@
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qapi-visit-compat.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qapi/qapi-visit-migration.h"
 #include "qapi/qapi-visit-ui.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-commands-migration.h"
@@ -159,6 +160,8 @@ typedef struct DeviceOption {
 static const char *cpu_option;
 static const char *mem_path;
 static const char *incoming;
+static const char *incoming_str[MIGRATION_CHANNEL_TYPE__MAX];
+static MigrationChannel *incoming_channels[MIGRATION_CHANNEL_TYPE__MAX];
 static const char *loadvm;
 static const char *accelerators;
 static bool have_custom_ram_size;
@@ -1822,6 +1825,30 @@ static void object_option_add_visitor(Visitor *v)
     QTAILQ_INSERT_TAIL(&object_opts, opt, next);
 }
 
+static void incoming_option_parse(const char *str)
+{
+    MigrationChannelType type = MIGRATION_CHANNEL_TYPE_MAIN;
+    MigrationChannel *channel;
+    Visitor *v;
+
+    if (!strcmp(str, "defer")) {
+        channel = NULL;
+    } else if (migrate_is_uri(str)) {
+        migrate_uri_parse(str, &channel, &error_fatal);
+    } else {
+        v = qobject_input_visitor_new_str(str, "channel-type", &error_fatal);
+        visit_type_MigrationChannel(v, NULL, &channel, &error_fatal);
+        visit_free(v);
+        type = channel->channel_type;
+    }
+
+    /* New incoming spec replaces the previous */
+    qapi_free_MigrationChannel(incoming_channels[type]);
+    incoming_channels[type] = channel;
+    incoming_str[type] = str;
+    incoming = incoming_str[MIGRATION_CHANNEL_TYPE_MAIN];
+}
+
 static void object_option_parse(const char *str)
 {
     QemuOpts *opts;
@@ -2753,8 +2780,11 @@ void qmp_x_exit_preconfig(Error **errp)
     if (incoming) {
         Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, false, NULL, true, true,
-                                 &local_err);
+            g_autofree MigrationChannelList *channels =
+                g_new0(MigrationChannelList, 1);
+
+            channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
+            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
@@ -3503,7 +3533,7 @@ void qemu_init(int argc, char **argv)
                 if (!incoming) {
                     runstate_set(RUN_STATE_INMIGRATE);
                 }
-                incoming = optarg;
+                incoming_option_parse(optarg);
                 break;
             case QEMU_OPTION_only_migratable:
                 only_migratable = 1;
-- 
1.8.3.1


