Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C4C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MRo-00079K-TV; Fri, 26 Apr 2024 10:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRg-00075N-Qo
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:21:01 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRf-0001u1-1i
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:21:00 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59C7C22774;
 Fri, 26 Apr 2024 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+035CNw8GklI6SUjAuE0D7i3DayB3sEpp59Ii7Ebiuk=;
 b=GWClYEBHBo3L2iHt5dAdpAbD3l8LxmwBLYK+9PeQ95Nn81pqiqsa1eKW6u1A9VG1RpEGzy
 CqWeQpvIq0f0eqiiLTXf819Tmvz0NGECUIh7bNYYFennD4b9j2KZ2Yse+Wjc7O5RK9DqY0
 k0wuC7T0qjGjXdXRJTh7qvup9MDDcIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+035CNw8GklI6SUjAuE0D7i3DayB3sEpp59Ii7Ebiuk=;
 b=xWtbof2nS+LgqzIPU/bq/k/UMiKo8eE3L6tXTvKNJS4mGprPWhzfxzV3GfIL8q2rrJx+pL
 Pw+VuEW8EYUKZeDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+035CNw8GklI6SUjAuE0D7i3DayB3sEpp59Ii7Ebiuk=;
 b=GWClYEBHBo3L2iHt5dAdpAbD3l8LxmwBLYK+9PeQ95Nn81pqiqsa1eKW6u1A9VG1RpEGzy
 CqWeQpvIq0f0eqiiLTXf819Tmvz0NGECUIh7bNYYFennD4b9j2KZ2Yse+Wjc7O5RK9DqY0
 k0wuC7T0qjGjXdXRJTh7qvup9MDDcIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+035CNw8GklI6SUjAuE0D7i3DayB3sEpp59Ii7Ebiuk=;
 b=xWtbof2nS+LgqzIPU/bq/k/UMiKo8eE3L6tXTvKNJS4mGprPWhzfxzV3GfIL8q2rrJx+pL
 Pw+VuEW8EYUKZeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CA17136DB;
 Fri, 26 Apr 2024 14:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QNNBBUe4K2YWcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 14:20:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 4/9] migration: Add direct-io parameter
Date: Fri, 26 Apr 2024 11:20:37 -0300
Message-Id: <20240426142042.14573-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240426142042.14573-1-farosas@suse.de>
References: <20240426142042.14573-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

This is currently only used with the mapped-ram migration that has a
clear window guaranteed to perform aligned writes.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/osdep.h           |  2 ++
 migration/migration-hmp-cmds.c | 11 +++++++++++
 migration/options.c            | 30 ++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 18 +++++++++++++++---
 util/osdep.c                   |  9 +++++++++
 6 files changed, 68 insertions(+), 3 deletions(-)

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
index 7e96ae6ffd..8496a2b34e 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -397,6 +397,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
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
@@ -690,6 +697,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
index 239f5ecfb4..ae464aa4f2 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -826,6 +826,22 @@ int migrate_decompress_threads(void)
     return s->parameters.decompress_threads;
 }
 
+bool migrate_direct_io(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    /* For now O_DIRECT is only supported with mapped-ram */
+    if (!s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM]) {
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
@@ -1061,6 +1077,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_zero_page_detection = true;
     params->zero_page_detection = s->parameters.zero_page_detection;
 
+    if (s->parameters.has_direct_io) {
+        params->has_direct_io = true;
+        params->direct_io = s->parameters.direct_io;
+    }
+
     return params;
 }
 
@@ -1097,6 +1118,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_vcpu_dirty_limit = true;
     params->has_mode = true;
     params->has_zero_page_detection = true;
+    params->has_direct_io = qemu_has_direct_io();
 }
 
 /*
@@ -1416,6 +1438,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_zero_page_detection) {
         dest->zero_page_detection = params->zero_page_detection;
     }
+
+    if (params->has_direct_io) {
+        dest->direct_io = params->direct_io;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1570,6 +1596,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_zero_page_detection) {
         s->parameters.zero_page_detection = params->zero_page_detection;
     }
+
+    if (params->has_direct_io) {
+        s->parameters.direct_io = params->direct_io;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index ab8199e207..aa5509cd2a 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -76,6 +76,7 @@ uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
 bool migrate_cpu_throttle_tailslow(void);
 int migrate_decompress_threads(void);
+bool migrate_direct_io(void);
 uint64_t migrate_downtime_limit(void);
 uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 8c65b90328..1a8a4b114c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -914,6 +914,9 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. This
+#     requires that the @mapped-ram capability is enabled. (since 9.1)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -948,7 +951,8 @@
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
            'mode',
-           'zero-page-detection'] }
+           'zero-page-detection',
+           'direct-io'] }
 
 ##
 # @MigrateSetParameters:
@@ -1122,6 +1126,9 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. This
+#     requires that the @mapped-ram capability is enabled. (since 9.1)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1176,7 +1183,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*direct-io': 'bool' } }
 
 ##
 # @migrate-set-parameters:
@@ -1354,6 +1362,9 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. This
+#     requires that the @mapped-ram capability is enabled. (since 9.1)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1405,7 +1416,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*direct-io': 'bool' } }
 
 ##
 # @query-migrate-parameters:
diff --git a/util/osdep.c b/util/osdep.c
index e996c4744a..d0227a60ab 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -277,6 +277,15 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
 }
 #endif
 
+bool qemu_has_direct_io(void)
+{
+#ifdef O_DIRECT
+    return true;
+#else
+    return false;
+#endif
+}
+
 static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
 {
     int ret;
-- 
2.35.3


