Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853D5C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6GdV-0003nC-C5; Mon, 14 Sep 2026 20:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdQ-0003Xe-VV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:53 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdO-0004p1-77
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7CB21FF47;
 Tue, 15 Sep 2026 00:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqUe3TPv9qECyKsu1k70GVLFCuSujUErlrH9f8pYvrc=;
 b=Vh2Uw4Z76RNj1qX4X0DmXqn7hxNdySz1wXVPx/YwLpnEXCKSt2bFJT7rdRXvoEWlbdeJc7
 wJQvPX4fZYbAtZb/R9PmMqBo+SWtTE7I2zUHMRsHcF7bB/AgpMpfquo/g9l0jiwyg+Mowq
 z5Bo3HY6HHgMU9I0/i88NAbj0Hv+nSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqUe3TPv9qECyKsu1k70GVLFCuSujUErlrH9f8pYvrc=;
 b=R+r81ZVF0SWx42McO8q4ihEifNOCOY4q5Ul//k2JcniCKKsZidUyljCSc/WixMOBvCuzw0
 y05CB3DC4et+4FBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mXDBtZCc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xH5v82eD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqUe3TPv9qECyKsu1k70GVLFCuSujUErlrH9f8pYvrc=;
 b=mXDBtZCctPva4bXzpFVzf8aeL/qAbAnC8VNk/gBEy6HaYuTvkrFfPwaWhn8ffXGmEacB4P
 /MSuyYIPec+D0eIqjDuWZErdEkffYqQaxM/GBNfHhMjf9YXWrDqvfkkgE5R6U6+m8n+VSj
 8ph/45hMkvXLFt3mmOtGOrLkhPpxpcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqUe3TPv9qECyKsu1k70GVLFCuSujUErlrH9f8pYvrc=;
 b=xH5v82eD0qM+3WzSi0kRcF9ixA7TXJ9LRhVwVvv3zKvUhEA6YfMFsPqoHjGFg9TL3SbAKy
 ldfjZnHIYGn++oAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D73013710;
 Tue, 15 Sep 2026 00:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gk6xFQeLqGqIFAAAD6G6ig:T15
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 00:02:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 14/20] migration: Use output visitor in info command
Date: Mon, 14 Sep 2026 21:02:02 -0300
Message-ID: <20260915000209.3692668-15-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915000209.3692668-1-farosas@suse.de>
References: <20260915000209.3692668-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B7CB21FF47
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The hmp_info_migrate_parameters function currently open-codes the
mon_printf calls for each migration parameter. As with the set command
in the last patch, this should not be necessary as the QAPI
infrastructure already has generated code that takes type and struct
member names into account, including converting _ from C into the '-'
character as part of parameter names strings.

The current code is also quite painful to rebase if a series has been
carried for a long time while parameters have been added in master.

Replace all of this with a conversion from MigrationParameters to
QDict using an output visitor and a loop over the QDict that prints
per-QAPI-type formatted strings.

Modelled after block/qapi.c:dump_qobject, but with some changes to
keep the migration command output formatting.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 234 +++++++++++----------------------
 migration/options.c            |   2 +-
 migration/options.h            |   1 +
 3 files changed, 81 insertions(+), 156 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7491c79a2e..00d2d310af 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -26,8 +26,12 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
 #include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qobject/qbool.h"
 #include "qobject/qdict.h"
+#include "qobject/qjson.h"
 #include "qobject/qlist.h"
+#include "qobject/qnum.h"
 #include "qobject/qstring.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
@@ -318,171 +322,91 @@ void hmp_info_migrate_capabilities(MonitorHMP *hmp, const QDict *qdict)
     qapi_free_MigrationCapabilityStatusList(caps);
 }
 
-static void monitor_print_cpr_exec_command(MonitorHMP *hmp, strList *args)
+static void hmp_migrate_print_qobject(MonitorHMP *hmp, const char *label,
+                                      QObject *obj)
 {
-    monitor_hmp_printf(hmp, "%s:",
-        MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_COMMAND));
+    const char *sep;
 
-    while (args) {
-        monitor_hmp_printf(hmp, " %s", args->value);
-        args = args->next;
+    if (!obj) {
+        return;
+    }
+
+    /*
+     * Put a space after labels
+     * foo: bar
+     *     ^
+     */
+    if (label && label[0] && label[strlen(label) - 1] == ':') {
+        sep = " ";
+    } else {
+        sep = "";
+    }
+
+    switch (qobject_type(obj)) {
+    case QTYPE_QNUM: {
+        g_autofree char *str = qnum_to_string(qobject_to(QNum, obj));
+
+        monitor_hmp_printf(hmp, "%s%s%s", label, sep, str);
+        break;
+    }
+    case QTYPE_QSTRING:
+        monitor_hmp_printf(hmp, "%s%s%s", label, sep,
+                           qstring_get_str(qobject_to(QString, obj)));
+        break;
+    case QTYPE_QDICT: {
+        QDict *d = qobject_to(QDict, obj);
+        const QDictEntry *e;
+        int i = 0;
+
+        monitor_hmp_printf(hmp, "%s%s", label, sep);
+
+        for (e = qdict_first(d); e; e = qdict_next(d, e), i++) {
+            g_autofree char *l = g_strdup_printf("%s:", qdict_entry_key(e));
+            if (i) {
+                monitor_hmp_printf(hmp, " ");
+            }
+            hmp_migrate_print_qobject(hmp, l, qdict_entry_value(e));
+        }
+        break;
+    }
+    case QTYPE_QLIST: {
+        const QListEntry *e;
+
+        monitor_hmp_printf(hmp, "%s\n", label);
+        for (e = qlist_first(qobject_to(QList, obj)); e; e = qlist_next(e)) {
+            hmp_migrate_print_qobject(hmp, " ", e->value);
+            monitor_hmp_printf(hmp, "\n");
+        }
+
+        break;
+    }
+    case QTYPE_QBOOL:
+        monitor_hmp_printf(hmp, "%s%s%s", label, sep,
+                           qbool_get_bool(qobject_to(QBool, obj)) ?
+                           "on" : "off");
+        break;
+    case QTYPE_NONE:
+    case QTYPE_QNULL:
+    default:
+        g_assert_not_reached();
+        break;
     }
-    monitor_hmp_printf(hmp, "\n");
 }
 
 void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict)
 {
-    MigrationParameters *params;
-    MigrationState *s = migrate_get_current();
+    MigrationParameters *params = qmp_query_migrate_parameters(NULL);
+    g_autoptr(QDict) d;
+    const QDictEntry *e;
 
-    params = qmp_query_migrate_parameters(NULL);
+    assert(params);
 
-    if (params) {
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_INITIAL),
-            params->announce_initial);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_MAX),
-            params->announce_max);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_ROUNDS),
-            params->announce_rounds);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
-            params->announce_step);
-        assert(params->has_throttle_trigger_threshold);
-        monitor_hmp_printf(hmp, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD),
-            params->throttle_trigger_threshold);
-        assert(params->has_cpu_throttle_initial);
-        monitor_hmp_printf(hmp, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL),
-            params->cpu_throttle_initial);
-        assert(params->has_cpu_throttle_increment);
-        monitor_hmp_printf(hmp, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT),
-            params->cpu_throttle_increment);
-        assert(params->has_cpu_throttle_tailslow);
-        monitor_hmp_printf(hmp, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
-            params->cpu_throttle_tailslow ? "on" : "off");
-        assert(params->has_max_cpu_throttle);
-        monitor_hmp_printf(hmp, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
-            params->max_cpu_throttle);
-        assert(params->tls_creds);
-        monitor_hmp_printf(hmp, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
-                       params->tls_creds->u.s);
-        assert(params->tls_hostname);
-        monitor_hmp_printf(hmp, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
-                       params->tls_hostname->u.s);
-        assert(params->tls_authz);
-        monitor_hmp_printf(hmp, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-                       params->tls_authz->u.s);
-        assert(params->has_max_bandwidth);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
-            params->max_bandwidth);
-        assert(params->has_avail_switchover_bandwidth);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
-            params->avail_switchover_bandwidth);
-        assert(params->has_max_postcopy_bandwidth);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
-            params->max_postcopy_bandwidth);
-        assert(params->has_downtime_limit);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
-            params->downtime_limit);
-        assert(params->has_x_checkpoint_delay);
-        monitor_hmp_printf(hmp, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
-            params->x_checkpoint_delay);
-        monitor_hmp_printf(hmp, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
-            params->multifd_channels);
-        monitor_hmp_printf(hmp, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
-            MultiFDCompression_str(params->multifd_compression));
-        assert(params->has_zero_page_detection);
-        monitor_hmp_printf(hmp, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
-            qapi_enum_lookup(&ZeroPageDetection_lookup,
-                params->zero_page_detection));
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
-            params->xbzrle_cache_size);
+    d = migrate_params_to_dict(params, NULL);
+    for (e = qdict_first(d); e; e = qdict_next(d, e)) {
+        g_autofree char *label = g_strdup_printf("%s:", qdict_entry_key(e));
 
-        if (s->has_block_bitmap_mapping) {
-            BitmapMigrationNodeAliasList *nal;
-            BitmapMigrationNodeAlias *na;
-            BitmapMigrationBitmapAliasList *bal;
-            BitmapMigrationBitmapAlias *ba;
-            BitmapMigrationBitmapAliasTransform *bat;
-
-            monitor_hmp_printf(hmp, "%s:\n",
-                           MigrationParameter_str(
-                               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
-
-            for (nal = params->block_bitmap_mapping; nal; nal = nal->next)
-            {
-                na = nal->value;
-                monitor_hmp_printf(hmp, " bitmaps:\n");
-                for (bal = na->bitmaps; bal; bal = bal->next) {
-                    ba = bal->value;
-                    bat = ba->transform;
-
-                    monitor_hmp_printf(hmp, " name: %s", ba->name);
-                    if (bat && bat->has_persistent) {
-                        monitor_hmp_printf(hmp, " transform:");
-                        if (bat->persistent) {
-                            monitor_hmp_printf(hmp, " persistent: on");
-                        } else {
-                            monitor_hmp_printf(hmp, " persistent: off");
-                        }
-                    }
-                    monitor_hmp_printf(hmp, " alias: %s\n", ba->alias);
-                }
-                monitor_hmp_printf(hmp, " node-name: %s alias: %s\n",
-                                   na->node_name, na->alias);
-            }
-
-            monitor_hmp_printf(hmp, "\n");
-        }
-
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-        MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD),
-        params->x_vcpu_dirty_limit_period);
-
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
-            params->vcpu_dirty_limit);
-
-        assert(params->has_mode);
-        monitor_hmp_printf(hmp, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MODE),
-            qapi_enum_lookup(&MigMode_lookup, params->mode));
-
-        if (params->has_direct_io) {
-            monitor_hmp_printf(hmp, "%s: %s\n",
-                               MigrationParameter_str(
-                                   MIGRATION_PARAMETER_DIRECT_IO),
-                               params->direct_io ? "on" : "off");
-        }
-
-        if (params->has_x_rdma_chunk_size) {
-            monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
-                           MigrationParameter_str(
-                               MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
-                           params->x_rdma_chunk_size);
-        }
-
-        assert(params->has_cpr_exec_command);
-        monitor_print_cpr_exec_command(hmp, params->cpr_exec_command);
+        hmp_migrate_print_qobject(hmp, label, qdict_entry_value(e));
+        monitor_hmp_printf(hmp, "\n");
     }
 
     qapi_free_MigrationParameters(params);
diff --git a/migration/options.c b/migration/options.c
index 46d040fc3f..29b96f48c1 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1097,7 +1097,7 @@ static void tls_opt_to_str(StrOrNull *opt)
     opt->u.s = g_strdup("");
 }
 
-static QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp)
+QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp)
 {
     QObject *obj = NULL;
     Visitor *v = qobject_output_visitor_new(&obj);
diff --git a/migration/options.h b/migration/options.h
index c7da2d0b5b..0d9f88c11e 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -94,4 +94,5 @@ uint64_t migrate_rdma_chunk_size(void);
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
 bool migrate_params_free(MigrationParameters *params, Error **errp);
+QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp);
 #endif
-- 
2.53.0


