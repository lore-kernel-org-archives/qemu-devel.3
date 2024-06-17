Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B475C2BB85
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYO-0003tb-R4; Mon, 17 Jun 2024 14:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYN-0003tI-7x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:07 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYL-0004uB-Co
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42F8521AD5;
 Mon, 17 Jun 2024 18:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlkxaYgY8mSil0KBcsjbPyn9bEQ8GI9qfd/aA4XAzyM=;
 b=rTfhPWLnIPgZmgE4Ri/VUSGJPp0yqEBrz9rMfQ20Q67FWkT3vr6mGn/fJgsjVW2m4IOTKi
 PL9Ai06nMY/hzQISmD5QU9RyHTPX78dAKvJr4EXo3WQ63wSN55sTMVJ7t2Hpi2gPK2L8u1
 rqby3Wz6JJim4JOb0UXEQBedNKgL+oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlkxaYgY8mSil0KBcsjbPyn9bEQ8GI9qfd/aA4XAzyM=;
 b=c4BIPP8IPLQleUoeujtz5aj95WLevZLgLVD4wlU60Dt8EArixQo0gZvmhw+rGpSIzQAecY
 wEt6njoyZdMecnCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlkxaYgY8mSil0KBcsjbPyn9bEQ8GI9qfd/aA4XAzyM=;
 b=rTfhPWLnIPgZmgE4Ri/VUSGJPp0yqEBrz9rMfQ20Q67FWkT3vr6mGn/fJgsjVW2m4IOTKi
 PL9Ai06nMY/hzQISmD5QU9RyHTPX78dAKvJr4EXo3WQ63wSN55sTMVJ7t2Hpi2gPK2L8u1
 rqby3Wz6JJim4JOb0UXEQBedNKgL+oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlkxaYgY8mSil0KBcsjbPyn9bEQ8GI9qfd/aA4XAzyM=;
 b=c4BIPP8IPLQleUoeujtz5aj95WLevZLgLVD4wlU60Dt8EArixQo0gZvmhw+rGpSIzQAecY
 wEt6njoyZdMecnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27C79139AB;
 Mon, 17 Jun 2024 18:58:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iCWnNzmHcGYJKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 18:58:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 11/16] migration: Add direct-io parameter
Date: Mon, 17 Jun 2024 15:57:26 -0300
Message-Id: <20240617185731.9725-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617185731.9725-1-farosas@suse.de>
References: <20240617185731.9725-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

This is currently only used with the mapped-ram migration that has a
clear window guaranteed to perform aligned writes.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/osdep.h           |  2 ++
 migration/migration-hmp-cmds.c | 11 +++++++++++
 migration/options.c            | 35 ++++++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 21 +++++++++++++++++---
 util/osdep.c                   |  9 +++++++++
 6 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index f61edcfdc2..191916f38e 100644
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
index 9f0e8029e0..7d608d26e1 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -351,6 +351,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
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
@@ -624,6 +631,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
index 5ab5b6d85d..645f55003d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -702,6 +702,25 @@ bool migrate_cpu_throttle_tailslow(void)
     return s->parameters.cpu_throttle_tailslow;
 }
 
+bool migrate_direct_io(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    /*
+     * O_DIRECT is only supported with mapped-ram and multifd.
+     *
+     * mapped-ram is needed because filesystems impose restrictions on
+     * O_DIRECT IO alignment (see MAPPED_RAM_FILE_OFFSET_ALIGNMENT).
+     *
+     * multifd is needed to keep the unaligned portion of the stream
+     * isolated to the main migration thread while multifd channels
+     * process the aligned data with O_DIRECT enabled.
+     */
+    return s->parameters.direct_io &&
+        s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM] &&
+        s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
+}
+
 uint64_t migrate_downtime_limit(void)
 {
     MigrationState *s = migrate_get_current();
@@ -905,6 +924,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->mode = s->parameters.mode;
     params->has_zero_page_detection = true;
     params->zero_page_detection = s->parameters.zero_page_detection;
+    params->has_direct_io = true;
+    params->direct_io = s->parameters.direct_io;
 
     return params;
 }
@@ -937,6 +958,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_vcpu_dirty_limit = true;
     params->has_mode = true;
     params->has_zero_page_detection = true;
+    params->has_direct_io = true;
 }
 
 /*
@@ -1110,6 +1132,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_direct_io && params->direct_io && !qemu_has_direct_io()) {
+        error_setg(errp, "No build-time support for direct-io");
+        return false;
+    }
+
     return true;
 }
 
@@ -1216,6 +1243,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_zero_page_detection) {
         dest->zero_page_detection = params->zero_page_detection;
     }
+
+    if (params->has_direct_io) {
+        dest->direct_io = params->direct_io;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1341,6 +1372,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
index 4b21cc2669..a2397026db 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -69,6 +69,7 @@ uint32_t migrate_checkpoint_delay(void);
 uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
 bool migrate_cpu_throttle_tailslow(void);
+bool migrate_direct_io(void);
 uint64_t migrate_downtime_limit(void);
 uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 470f746cc5..de6c8b0444 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -821,6 +821,10 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @direct-io: Open migration files with O_DIRECT when possible.  This
+#     only has effect if the @mapped-ram capability is enabled.
+#     (Since 9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -845,7 +849,8 @@
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
            'mode',
-           'zero-page-detection'] }
+           'zero-page-detection',
+           'direct-io'] }
 
 ##
 # @MigrateSetParameters:
@@ -991,6 +996,10 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @direct-io: Open migration files with O_DIRECT when possible.  This
+#     only has effect if the @mapped-ram capability is enabled.
+#     (Since 9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1030,7 +1039,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*direct-io': 'bool' } }
 
 ##
 # @migrate-set-parameters:
@@ -1190,6 +1200,10 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @direct-io: Open migration files with O_DIRECT when possible.  This
+#     only has effect if the @mapped-ram capability is enabled.
+#     (Since 9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1226,7 +1240,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*direct-io': 'bool' } }
 
 ##
 # @query-migrate-parameters:
diff --git a/util/osdep.c b/util/osdep.c
index 5bbfdfac7a..770369831b 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -282,6 +282,15 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
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


