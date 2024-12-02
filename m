Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A61DD78323
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Zr-00059J-2W; Mon, 02 Dec 2024 08:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Ln-00081k-S2
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lg-0005mX-Nb
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:28 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DIY83012846;
 Mon, 2 Dec 2024 13:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=rq8NerJdvkXQsuBr1MGXnTxqN79ZMc4lonX0yPws4+o=; b=
 oRFzjM3OylhpQ84GYimDxD3twmioTXOVTrGaljPfOKyJGCs8KVajJ4Gzadhnd3AU
 Q0gH570PFGod3IJAghpa6hmx2KRdu2XgXVPErBasm7MZJrUAVl1SXYneqV4yopQ+
 lnrLpAFeXZ9bBVRoF7vzWoGjkVSgc7XShl6zjPFBq2b77llv94I4+TVWZgoywVF8
 B2LSgcIE7h4ypyn+K+nIbgGUMES348mQRJkqA2/VftVJR8k1ZyXeDUoaBEvZG+tH
 8NoUcY4CblbMshZ2PlWfhwYP8xk+TtHr7AsSXsj4dXvtkpGRIrwvQfgD9bzYhZhQ
 Isao3uzbI5xFed+w8Z0w6w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c3347-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2CmKYQ032740; Mon, 2 Dec 2024 13:20:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:20 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCEp032806;
 Mon, 2 Dec 2024 13:20:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-10; Mon, 02 Dec 2024 13:20:19 +0000
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
Subject: [PATCH V4 09/19] migration: incoming channel
Date: Mon,  2 Dec 2024 05:20:01 -0800
Message-Id: <1733145611-62315-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_09,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020116
X-Proofpoint-ORIG-GUID: A3pdK6DAAW_0IoLvDL9HdR45Wd6R0WUt
X-Proofpoint-GUID: A3pdK6DAAW_0IoLvDL9HdR45Wd6R0WUt
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Extend the -incoming option to allow an @MigrationChannel to be specified.
This allows channels other than 'main' to be described on the command
line, which will be needed for CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |  2 ++
 migration/migration.c    | 18 ++++++++++++++----
 migration/migration.h    |  2 --
 qemu-options.hx          | 17 +++++++++++++++++
 system/vl.c              | 35 +++++++++++++++++++++++++++++++++--
 5 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 804eb23..259d4aa 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -106,4 +106,6 @@ bool migration_incoming_postcopy_advised(void);
 /* True if background snapshot is active */
 bool migration_in_bg_snapshot(void);
 
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 83dabc7..a5cf148 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2046,6 +2046,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
+    MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
 
     /*
      * Having preliminary checks for uri and channel
@@ -2056,12 +2057,21 @@ void qmp_migrate(const char *uri, bool has_channels,
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
diff --git a/migration/migration.h b/migration/migration.h
index 0956e92..5cd0f29 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -522,8 +522,6 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
                                       Error **errp);
 
 void migrate_add_address(SocketAddress *address);
-bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
-                       Error **errp);
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 
 #define qemu_ram_foreach_block \
diff --git a/qemu-options.hx b/qemu-options.hx
index 02b9118..fab50ce 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4937,10 +4937,17 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
     "-incoming exec:cmdline\n" \
     "                accept incoming migration on given file descriptor\n" \
     "                or from given external command\n" \
+    "-incoming @MigrationChannel\n" \
+    "                accept incoming migration on the channel\n" \
     "-incoming defer\n" \
     "                wait for the URI to be specified via migrate_incoming\n",
     QEMU_ARCH_ALL)
 SRST
+The -incoming option specifies the migration channel for an incoming
+migration.  It may be used multiple times to specify multiple
+migration channel types.  The channel type is specified in @MigrationChannel,
+and is 'main' for all other forms of -incoming.
+
 ``-incoming tcp:[host]:port[,to=maxport][,ipv4=on|off][,ipv6=on|off]``
   \ 
 ``-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]``
@@ -4960,6 +4967,16 @@ SRST
     Accept incoming migration as an output from specified external
     command.
 
+``-incoming @MigrationChannel``
+    Accept incoming migration on the channel.  See the QAPI documentation
+    for the syntax of the @MigrationChannel data element.  For example:
+    ::
+
+        -incoming '{"channel-type": "main",
+                    "addr": { "transport": "socket",
+                              "type": "unix",
+                              "path": "my.sock" }}'
+
 ``-incoming defer``
     Wait for the URI to be specified via migrate\_incoming. The monitor
     can be used to change settings (such as migration parameters) prior
diff --git a/system/vl.c b/system/vl.c
index 4151a79..2c24c60 100644
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
@@ -159,6 +160,7 @@ typedef struct DeviceOption {
 static const char *cpu_option;
 static const char *mem_path;
 static const char *incoming;
+static MigrationChannelList *incoming_channels;
 static const char *loadvm;
 static const char *accelerators;
 static bool have_custom_ram_size;
@@ -1821,6 +1823,35 @@ static void object_option_add_visitor(Visitor *v)
     QTAILQ_INSERT_TAIL(&object_opts, opt, next);
 }
 
+static void incoming_option_parse(const char *str)
+{
+    MigrationChannel *channel;
+
+    if (str[0] == '{') {
+        QObject *obj = qobject_from_json(str, &error_fatal);
+        Visitor *v = qobject_input_visitor_new(obj);
+
+        qobject_unref(obj);
+        visit_type_MigrationChannel(v, "channel", &channel, &error_fatal);
+        visit_free(v);
+    } else if (!strcmp(str, "defer")) {
+        channel = NULL;
+    } else {
+        migrate_uri_parse(str, &channel, &error_fatal);
+    }
+
+    /* New incoming spec replaces the previous */
+
+    if (incoming_channels) {
+        qapi_free_MigrationChannelList(incoming_channels);
+    }
+    if (channel) {
+        incoming_channels = g_new0(MigrationChannelList, 1);
+        incoming_channels->value = channel;
+    }
+    incoming = str;
+}
+
 static void object_option_parse(const char *str)
 {
     QemuOpts *opts;
@@ -2730,7 +2761,7 @@ void qmp_x_exit_preconfig(Error **errp)
     if (incoming) {
         Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, false, NULL, true, true,
+            qmp_migrate_incoming(NULL, true, incoming_channels, true, true,
                                  &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
@@ -3477,7 +3508,7 @@ void qemu_init(int argc, char **argv)
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


