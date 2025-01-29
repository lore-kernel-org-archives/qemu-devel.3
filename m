Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A65C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXL-0005F9-VR; Wed, 29 Jan 2025 11:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVV-0003HE-AM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:39 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVT-0005Hg-6i
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:37 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B9661F383;
 Wed, 29 Jan 2025 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUnVXpFQqxzjBZXmvQTIkTsUNjcdzug5M7k2BEjvNoA=;
 b=TSKWmTIQ56yNCM13wPSFmspGltRJ9iRe2PEccMUXQVnjrlnRtuUCajKQrWOefuAuBBpQ5G
 Lx3h9mxVvb3Y0kuAcSw6B6YN3qWQzIHJ/2r/4Wdv+RKTC7fY2rSB8zlzFE5Et+eRFksbWa
 VGbHoqTNirSM5SF2AQ6ah/xCo5TLaVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUnVXpFQqxzjBZXmvQTIkTsUNjcdzug5M7k2BEjvNoA=;
 b=Dy2CKKNO0AbM2qLHhl/17rjv9IcCqGg3VX8UJtUNT68qPvWrDV+M1AL3eY64561pZvUlxd
 ogJYzqzMCvPCh0BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUnVXpFQqxzjBZXmvQTIkTsUNjcdzug5M7k2BEjvNoA=;
 b=TSKWmTIQ56yNCM13wPSFmspGltRJ9iRe2PEccMUXQVnjrlnRtuUCajKQrWOefuAuBBpQ5G
 Lx3h9mxVvb3Y0kuAcSw6B6YN3qWQzIHJ/2r/4Wdv+RKTC7fY2rSB8zlzFE5Et+eRFksbWa
 VGbHoqTNirSM5SF2AQ6ah/xCo5TLaVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUnVXpFQqxzjBZXmvQTIkTsUNjcdzug5M7k2BEjvNoA=;
 b=Dy2CKKNO0AbM2qLHhl/17rjv9IcCqGg3VX8UJtUNT68qPvWrDV+M1AL3eY64561pZvUlxd
 ogJYzqzMCvPCh0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42572137DB;
 Wed, 29 Jan 2025 16:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AJQLAdxQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 13/42] migration: incoming channel
Date: Wed, 29 Jan 2025 13:00:30 -0300
Message-Id: <20250129160059.6987-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,oracle.com:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Extend the -incoming option to allow an @MigrationChannel to be specified.
This allows channels other than 'main' to be described on the command
line, which will be needed for CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-13-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 21 ++++++++++++++++-----
 qemu-options.hx       | 21 +++++++++++++++++++++
 system/vl.c           | 36 +++++++++++++++++++++++++++++++++---
 3 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b5ee98e691..5f2540fac3 100644
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
index 90fad31590..3d1af7325b 100644
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
index c567826718..504f05b954 100644
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
@@ -1813,6 +1816,30 @@ static void object_option_add_visitor(Visitor *v)
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
@@ -2738,8 +2765,11 @@ void qmp_x_exit_preconfig(Error **errp)
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
@@ -3458,7 +3488,7 @@ void qemu_init(int argc, char **argv)
                 if (!incoming) {
                     runstate_set(RUN_STATE_INMIGRATE);
                 }
-                incoming = optarg;
+                incoming_option_parse(optarg);
                 break;
             case QEMU_OPTION_only_migratable:
                 only_migratable = 1;
-- 
2.35.3


