Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72651C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYp6-0004w6-O2; Tue, 20 Feb 2024 17:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYp5-0004vt-EX
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:47 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYp3-0006Pa-HD
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 295FA1FB53;
 Tue, 20 Feb 2024 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfxk7AwQkvxyEfclM3uo109mvNYDQUaIrrIjIu9TT3o=;
 b=dRB3ISp5eTV4at/r3qBC1YWz7+QcWoWBbBndtEs4EwQqSwluyMuNEtvaSHhR1wtmPYAovV
 9CljS+UJi82RfGj1Bj23Z8BrhxXdmu7VVZmSlANvMa0QfY/030h8Seh2heQj4iLsc60wkc
 xSYB7B4LGtV8WCnozXhPrO415wAD5lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfxk7AwQkvxyEfclM3uo109mvNYDQUaIrrIjIu9TT3o=;
 b=nBNANta2en4x7uVK12ICJ7J7s5iei56N3VLveS+GEovENC0tES3k2GKLdQEPDlGWHhL57M
 z9VCliFmrMTNUMAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfxk7AwQkvxyEfclM3uo109mvNYDQUaIrrIjIu9TT3o=;
 b=dRB3ISp5eTV4at/r3qBC1YWz7+QcWoWBbBndtEs4EwQqSwluyMuNEtvaSHhR1wtmPYAovV
 9CljS+UJi82RfGj1Bj23Z8BrhxXdmu7VVZmSlANvMa0QfY/030h8Seh2heQj4iLsc60wkc
 xSYB7B4LGtV8WCnozXhPrO415wAD5lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfxk7AwQkvxyEfclM3uo109mvNYDQUaIrrIjIu9TT3o=;
 b=nBNANta2en4x7uVK12ICJ7J7s5iei56N3VLveS+GEovENC0tES3k2GKLdQEPDlGWHhL57M
 z9VCliFmrMTNUMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52F8D139D0;
 Tue, 20 Feb 2024 22:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uEHNBuIq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v4 27/34] migration: Add direct-io parameter
Date: Tue, 20 Feb 2024 19:41:31 -0300
Message-Id: <20240220224138.24759-28-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dRB3ISp5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nBNANta2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 295FA1FB53
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add the direct-io migration parameter that tells the migration code to
use O_DIRECT when opening the migration stream file whenever possible.

This is currently only used with the fixed-ram migration that has a
clear window guaranteed to perform aligned writes.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/osdep.h           |  2 ++
 migration/migration-hmp-cmds.c | 11 +++++++++++
 migration/options.c            | 30 ++++++++++++++++++++++++++++++
 qapi/migration.json            | 18 +++++++++++++++---
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index c7053cdc2b..645c14a65d 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -612,6 +612,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
 #endif
 
+bool qemu_has_direct_io(void);
+
 #if defined(__HAIKU__) && defined(__i386__)
 #define FMT_pid "%ld"
 #elif defined(WIN64)
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 99b49df5dd..77313346c2 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -392,6 +392,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MODE),
             qapi_enum_lookup(&MigMode_lookup, params->mode));
+
+        if (params->has_direct_io) {
+            monitor_printf(mon, "%s: %s\n",
+                           MigrationParameter_str(
+                               MIGRATION_PARAMETER_DIRECT_IO),
+                           params->direct_io ? "on" : "off");
+        }
     }
 
     qapi_free_MigrationParameters(params);
@@ -681,6 +688,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_mode = true;
         visit_type_MigMode(v, param, &p->mode, &err);
         break;
+    case MIGRATION_PARAMETER_DIRECT_IO:
+        p->has_direct_io = true;
+        visit_type_bool(v, param, &p->direct_io, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index bfcd2d7132..b347dbc670 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -823,6 +823,22 @@ int migrate_decompress_threads(void)
     return s->parameters.decompress_threads;
 }
 
+bool migrate_direct_io(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    /* For now O_DIRECT is only supported with fixed-ram */
+    if (!s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM]) {
+        return false;
+    }
+
+    if (s->parameters.has_direct_io) {
+        return s->parameters.direct_io;
+    }
+
+    return false;
+}
+
 uint64_t migrate_downtime_limit(void)
 {
     MigrationState *s = migrate_get_current();
@@ -1042,6 +1058,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_mode = true;
     params->mode = s->parameters.mode;
 
+    if (s->parameters.has_direct_io) {
+        params->has_direct_io = true;
+        params->direct_io = s->parameters.direct_io;
+    }
+
     return params;
 }
 
@@ -1077,6 +1098,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_x_vcpu_dirty_limit_period = true;
     params->has_vcpu_dirty_limit = true;
     params->has_mode = true;
+    params->has_direct_io = qemu_has_direct_io();
 }
 
 /*
@@ -1386,6 +1408,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_mode) {
         dest->mode = params->mode;
     }
+
+    if (params->has_direct_io) {
+        dest->direct_io = params->direct_io;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1530,6 +1556,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_mode) {
         s->parameters.mode = params->mode;
     }
+
+    if (params->has_direct_io) {
+        s->parameters.direct_io = params->direct_io;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 3fce5fe53e..41241a2178 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -878,6 +878,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. This
+#     requires that the 'fixed-ram' capability is enabled. (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -911,7 +914,8 @@
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
-           'mode'] }
+           'mode',
+           'direct-io'] }
 
 ##
 # @MigrateSetParameters:
@@ -1070,6 +1074,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. This
+#     requires that the 'fixed-ram' capability is enabled. (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1123,7 +1130,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*direct-io': 'bool' } }
 
 ##
 # @migrate-set-parameters:
@@ -1298,6 +1306,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. This
+#     requires that the 'fixed-ram' capability is enabled. (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1348,7 +1359,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*direct-io': 'bool' } }
 
 ##
 # @query-migrate-parameters:
-- 
2.35.3


