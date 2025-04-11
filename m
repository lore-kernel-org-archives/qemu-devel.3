Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4444BC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3JqF-0003xk-OU; Fri, 11 Apr 2025 15:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3JqC-0003wr-Po
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:04 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3JqA-0005ym-Q4
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E27EF21197;
 Fri, 11 Apr 2025 19:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdWkTrqphcjVjsPPDRqSv5Jp27YEDItKik/C/U4rk+M=;
 b=aevb3CS5uG38mFQJseB5TPIDmS7EqQ6JGoqbs5LFm3kG9jJHzGMVfEsSr1Ww6hQhshENzN
 +akle7p1hh+wlvrgS+iZcCF1Sa/Ne5dYREF7gH8vyX3NrDlmNj9oH81P4iSVIdpicQVupe
 p9CW7Z4qPUWNe5iSLxldBW6I5ZnVp6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398892;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdWkTrqphcjVjsPPDRqSv5Jp27YEDItKik/C/U4rk+M=;
 b=OE8e05W8uHPZyJxQNJ9XOrAXS1JVKxNzBzwe2OW5iRKYtwddJKcwIUS8nnpVMsMvs/B1Kw
 P2FGbNRCKTyHU7Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pzFyWFW0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o+uSWmNH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdWkTrqphcjVjsPPDRqSv5Jp27YEDItKik/C/U4rk+M=;
 b=pzFyWFW0Wkq8SqPYFMNbYlFiMEoN4IhuPjvrthOoHnuybavDC3gvP0y5nDw1HgvhdrNGl6
 Ia7Gd95rlLiVWajPDM3AjEi9xAZTh5bVoCYQ5YaNXE7JSzMc9DQm6ueMtHjUPUC4ZS4QUl
 b+d9V7JIUbbqrsifn5RlIOn9+EYCa7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdWkTrqphcjVjsPPDRqSv5Jp27YEDItKik/C/U4rk+M=;
 b=o+uSWmNHWCkOkYBqnAcev2cdYtYKUEgnc5+WhPjDXnqiQamLudwwCXTqu46rmMDyyo0zPs
 9udt4CigZlxXSEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 667C313886;
 Fri, 11 Apr 2025 19:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +Nc5Cipq+We5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 19:14:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 02/13] migration: Normalize tls arguments
Date: Fri, 11 Apr 2025 16:14:32 -0300
Message-Id: <20250411191443.22565-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250411191443.22565-1-farosas@suse.de>
References: <20250411191443.22565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E27EF21197
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

The tls_creds, tls_authz and tls_hostname arguments are strings that
can be set by the user. They are allowed to be either a valid string,
an empty string or NULL. The values "" and NULL are effectively
treated the same by the code, but this is not entirely clear because
the handling is not uniform.

Make the 3 variables be handled the same and at the same place in
options.c. Note that this affects only the internal usage of the
variables.

(migrate_tls() had to be moved to be able to use migrate_tls_creds())

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 81 ++++++++++++++++++++++++---------------------
 migration/tls.c     |  2 +-
 2 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index cb8eec218f..7cd465ca94 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -379,13 +379,6 @@ bool migrate_rdma(void)
     return s->rdma_migration;
 }
 
-bool migrate_tls(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->parameters.tls_creds && *s->parameters.tls_creds;
-}
-
 typedef enum WriteTrackingSupport {
     WT_SUPPORT_UNKNOWN = 0,
     WT_SUPPORT_ABSENT,
@@ -814,21 +807,41 @@ const char *migrate_tls_authz(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_authz;
+    if (s->parameters.tls_authz &&
+        *s->parameters.tls_authz) {
+        return s->parameters.tls_authz;
+    }
+
+    return NULL;
 }
 
 const char *migrate_tls_creds(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_creds;
+    if (s->parameters.tls_creds &&
+        *s->parameters.tls_creds) {
+        return s->parameters.tls_creds;
+    }
+
+    return NULL;
 }
 
 const char *migrate_tls_hostname(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_hostname;
+    if (s->parameters.tls_hostname &&
+        *s->parameters.tls_hostname) {
+        return s->parameters.tls_hostname;
+    }
+
+    return NULL;
+}
+
+bool migrate_tls(void)
+{
+    return !!migrate_tls_creds();
 }
 
 uint64_t migrate_vcpu_dirty_limit_period(void)
@@ -883,8 +896,10 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
     params->has_cpu_throttle_tailslow = true;
     params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
-    params->tls_creds = g_strdup(s->parameters.tls_creds);
-    params->tls_hostname = g_strdup(s->parameters.tls_hostname);
+    params->tls_creds = g_strdup(s->parameters.tls_creds ?
+                                 s->parameters.tls_creds : "");
+    params->tls_hostname = g_strdup(s->parameters.tls_hostname ?
+                                    s->parameters.tls_hostname : "");
     params->tls_authz = g_strdup(s->parameters.tls_authz ?
                                  s->parameters.tls_authz : "");
     params->has_max_bandwidth = true;
@@ -945,6 +960,7 @@ void migrate_params_init(MigrationParameters *params)
 {
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
+    params->tls_authz = g_strdup("");
 
     /* Set has_* up only for parameter checks */
     params->has_throttle_trigger_threshold = true;
@@ -1184,18 +1200,27 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     }
 
     if (params->tls_creds) {
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        dest->tls_creds = params->tls_creds->u.s;
+        if (params->tls_creds->type == QTYPE_QNULL) {
+            dest->tls_creds = NULL;
+        } else {
+            dest->tls_creds = params->tls_creds->u.s;
+        }
     }
 
     if (params->tls_hostname) {
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        dest->tls_hostname = params->tls_hostname->u.s;
+        if (params->tls_hostname->type == QTYPE_QNULL) {
+            dest->tls_hostname = NULL;
+        } else {
+            dest->tls_hostname = params->tls_hostname->u.s;
+        }
     }
 
     if (params->tls_authz) {
-        assert(params->tls_authz->type == QTYPE_QSTRING);
-        dest->tls_authz = params->tls_authz->u.s;
+        if (params->tls_authz->type == QTYPE_QNULL) {
+            dest->tls_authz = NULL;
+        } else {
+            dest->tls_authz = params->tls_authz->u.s;
+        }
     }
 
     if (params->has_max_bandwidth) {
@@ -1413,26 +1438,6 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
 {
     MigrationParameters tmp;
 
-    /* TODO Rewrite "" to null instead for all three tls_* parameters */
-    if (params->tls_creds
-        && params->tls_creds->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_creds->u.n);
-        params->tls_creds->type = QTYPE_QSTRING;
-        params->tls_creds->u.s = strdup("");
-    }
-    if (params->tls_hostname
-        && params->tls_hostname->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_hostname->u.n);
-        params->tls_hostname->type = QTYPE_QSTRING;
-        params->tls_hostname->u.s = strdup("");
-    }
-    if (params->tls_authz
-        && params->tls_authz->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_authz->u.n);
-        params->tls_authz->type = QTYPE_QSTRING;
-        params->tls_authz->u.s = strdup("");
-    }
-
     migrate_params_test_apply(params, &tmp);
 
     if (!migrate_params_check(&tmp, errp)) {
diff --git a/migration/tls.c b/migration/tls.c
index 5cbf952383..8a89d3f767 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -126,7 +126,7 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
     }
 
     const char *tls_hostname = migrate_tls_hostname();
-    if (tls_hostname && *tls_hostname) {
+    if (tls_hostname) {
         hostname = tls_hostname;
     }
 
-- 
2.35.3


