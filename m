Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CCCE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7bQ-0003MB-C5; Tue, 24 Dec 2024 11:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7b2-000353-OE
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7az-0003Aj-GW
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:24 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEg0vj018774;
 Tue, 24 Dec 2024 16:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=7kFJ0zmHucddFmQ2m7BgbUF4qwTdpmWYozvjpnaJiUM=; b=
 k9SYmUJynfO6Esr/ajJg5PWv9qcc2Gk7uL0nPP1zJF/aHedBH7JgEPj8rDkBY8gc
 eVGUy70IWFrsN8iy9F2EJMwPdwejeV95uY4K8QEaOtZnQ0Z89UVKFPTM7eG1HKNV
 GOXcGZUdznvCsrlEcUjuIaXw4ik/LVcgI+ljNhGxmkfKxyiZj4Ce8faZvA8s8rLM
 D7zMFo4oVnb7F23/Qkr/dwPtWyTBtV1uElxGOZACE+B+sbgoVsCK9BC1PCn01E9S
 59RNn+tH+7nb+LX6SGqF23A2c6J7Ep9jKOBE1g2i8czpsxP9KaDQFj4/kqJARCvE
 ah/PlvRCR9AlL97VV0Jpsw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43qgeqs30s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BOGG6RY022588; Tue, 24 Dec 2024 16:17:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm484gkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BOGH9Xc021973;
 Tue, 24 Dec 2024 16:17:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 43nm484ggj-12; Tue, 24 Dec 2024 16:17:16 +0000
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
Subject: [PATCH V5 11/23] migration: incoming channel
Date: Tue, 24 Dec 2024 08:16:56 -0800
Message-Id: <1735057028-308595-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240141
X-Proofpoint-ORIG-GUID: c1hDKsKn4RtRnsGq40SIISw7RablprQD
X-Proofpoint-GUID: c1hDKsKn4RtRnsGq40SIISw7RablprQD
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
---
 migration/migration.c | 18 ++++++++++++++----
 qemu-options.hx       | 21 +++++++++++++++++++++
 system/vl.c           | 36 +++++++++++++++++++++++++++++++++---
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 881684a..7c9bc5b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2057,6 +2057,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
+    MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
 
     /*
      * Having preliminary checks for uri and channel
@@ -2067,12 +2068,21 @@ void qmp_migrate(const char *uri, bool has_channels,
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
index b1f56b7..f1a30ef 100644
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
index 2261014..7343a27 100644
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
@@ -2756,8 +2783,11 @@ void qmp_x_exit_preconfig(Error **errp)
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
@@ -3506,7 +3536,7 @@ void qemu_init(int argc, char **argv)
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


