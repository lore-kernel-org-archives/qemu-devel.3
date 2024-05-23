Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B21C25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADlv-0002G9-Hj; Thu, 23 May 2024 15:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlp-0002Ek-44
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:34 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlb-0004JP-RY
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C1E722B79;
 Thu, 23 May 2024 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Pp89Cnn3FmnMv8zeYpnAlQzcELRXERoRwrQNWr+s7A=;
 b=zkoIySyhgtL8/x9NZcIqlYwb2U5XcBmG/J0gSP9NPuofAgYN1mVV4PB4KD15rgMnUCfSKp
 fYD0hXap9Zqvgic2u0MlIPW7V55/wSEW2Gaza8E31nWqZGYJ0r9JwNq/QZNwWtnWEDjwk0
 il0dc6yUmUBs31eGYCxnpc6HcvsCAr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Pp89Cnn3FmnMv8zeYpnAlQzcELRXERoRwrQNWr+s7A=;
 b=9qZleLagIKj7W3mZTX3KeeZsYi7pBVe9tyJJwFEItcXiYl/Ez82VjQLYaKl24Ff0ksvTaO
 A1DkXW/S3uhTSUDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zkoIySyh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9qZleLag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Pp89Cnn3FmnMv8zeYpnAlQzcELRXERoRwrQNWr+s7A=;
 b=zkoIySyhgtL8/x9NZcIqlYwb2U5XcBmG/J0gSP9NPuofAgYN1mVV4PB4KD15rgMnUCfSKp
 fYD0hXap9Zqvgic2u0MlIPW7V55/wSEW2Gaza8E31nWqZGYJ0r9JwNq/QZNwWtnWEDjwk0
 il0dc6yUmUBs31eGYCxnpc6HcvsCAr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Pp89Cnn3FmnMv8zeYpnAlQzcELRXERoRwrQNWr+s7A=;
 b=9qZleLagIKj7W3mZTX3KeeZsYi7pBVe9tyJJwFEItcXiYl/Ez82VjQLYaKl24Ff0ksvTaO
 A1DkXW/S3uhTSUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C57A13A6B;
 Thu, 23 May 2024 19:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iP8OBaiTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 10/18] migration: Add direct-io parameter
Date: Thu, 23 May 2024 16:05:40 -0300
Message-Id: <20240523190548.23977-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5C1E722B79
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 migration/options.c            | 28 ++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 21 ++++++++++++++++++---
 util/osdep.c                   |  9 +++++++++
 6 files changed, 69 insertions(+), 3 deletions(-)

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
index 5ab5b6d85d..6f614761b8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -702,6 +702,18 @@ bool migrate_cpu_throttle_tailslow(void)
     return s->parameters.cpu_throttle_tailslow;
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
+    return s->parameters.direct_io;
+}
+
 uint64_t migrate_downtime_limit(void)
 {
     MigrationState *s = migrate_get_current();
@@ -905,6 +917,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->mode = s->parameters.mode;
     params->has_zero_page_detection = true;
     params->zero_page_detection = s->parameters.zero_page_detection;
+    params->has_direct_io = true;
+    params->direct_io = s->parameters.direct_io;
 
     return params;
 }
@@ -937,6 +951,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_vcpu_dirty_limit = true;
     params->has_mode = true;
     params->has_zero_page_detection = true;
+    params->has_direct_io = true;
 }
 
 /*
@@ -1110,6 +1125,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_direct_io && params->direct_io && !qemu_has_direct_io()) {
+        error_setg(errp, "No build-time support for direct-io");
+        return false;
+    }
+
     return true;
 }
 
@@ -1216,6 +1236,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_zero_page_detection) {
         dest->zero_page_detection = params->zero_page_detection;
     }
+
+    if (params->has_direct_io) {
+        dest->direct_io = params->direct_io;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1341,6 +1365,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
index a351fd3714..7efbaf1e25 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -812,6 +812,10 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @direct-io: Open migration files with O_DIRECT when possible.  This
+#     only has effect if the @mapped-ram capability is enabled. (since
+#     9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -836,7 +840,8 @@
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
            'mode',
-           'zero-page-detection'] }
+           'zero-page-detection',
+           'direct-io'] }
 
 ##
 # @MigrateSetParameters:
@@ -982,6 +987,10 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @direct-io: Open migration files with O_DIRECT when possible.  This
+#     only has effect if the @mapped-ram capability is enabled. (since
+#     9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1021,7 +1030,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*direct-io': 'bool' } }
 
 ##
 # @migrate-set-parameters:
@@ -1181,6 +1191,10 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @direct-io: Open migration files with O_DIRECT when possible.  This
+#     only has effect if the @mapped-ram capability is enabled. (since
+#     9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1217,7 +1231,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*direct-io': 'bool' } }
 
 ##
 # @query-migrate-parameters:
diff --git a/util/osdep.c b/util/osdep.c
index 0cb8f98bf6..4900251d2e 100644
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


