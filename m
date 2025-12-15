Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288C2D5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGeo-00068t-9N; Mon, 15 Dec 2025 17:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeO-0005EF-4g
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:40 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeM-0002vR-E2
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3154833742;
 Mon, 15 Dec 2025 22:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGtMleKybG0aL/ZIRF6KJDcnH5VwbKFjmAT93TCm7Jk=;
 b=pHrL77m60SoJag4CsWPea0RcLa0U05NOvjRLh7z/a1mG4DVuk5YraDXdkt86cERjxmtZ5d
 7lhpniCbBy1YjuLIdeqZS8i+6MggSKwehxMX1fvnbqF97pRuTA3PyIkypbESwpG2yTWDxe
 Q/HQyCjL+Psg7pzQTjZZW4iGf/8fEzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGtMleKybG0aL/ZIRF6KJDcnH5VwbKFjmAT93TCm7Jk=;
 b=scb1jzfH740qFn5LjoVknoVS2peo6cMVbbPVV2w6vvGsbQV4lWlt1XVx343/VDFjJERcSQ
 Ti+0mzVL/bofezDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pHrL77m6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=scb1jzfH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGtMleKybG0aL/ZIRF6KJDcnH5VwbKFjmAT93TCm7Jk=;
 b=pHrL77m60SoJag4CsWPea0RcLa0U05NOvjRLh7z/a1mG4DVuk5YraDXdkt86cERjxmtZ5d
 7lhpniCbBy1YjuLIdeqZS8i+6MggSKwehxMX1fvnbqF97pRuTA3PyIkypbESwpG2yTWDxe
 Q/HQyCjL+Psg7pzQTjZZW4iGf/8fEzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGtMleKybG0aL/ZIRF6KJDcnH5VwbKFjmAT93TCm7Jk=;
 b=scb1jzfH740qFn5LjoVknoVS2peo6cMVbbPVV2w6vvGsbQV4lWlt1XVx343/VDFjJERcSQ
 Ti+0mzVL/bofezDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E21063EA65;
 Mon, 15 Dec 2025 22:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iOO4IWKFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 33/51] tests/qtest/migration: Adapt the incoming cmdline
 for config passing
Date: Mon, 15 Dec 2025 19:00:19 -0300
Message-ID: <20251215220041.12657-34-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3154833742
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Allow the -incoming command line option to pass the config object in
json format. Regardless of whether config passing via -incoming will
be a supported interface, we need for some tests to work with the
config.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index df42a8a2c6..ebd41d3c9f 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -324,6 +324,7 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
     g_autofree gchar *arch_opts = NULL;
     gchar *cmd_source = NULL;
     gchar *cmd_target = NULL;
+    g_autofree gchar *config_opts = NULL;
     const gchar *ignore_stderr;
     g_autofree char *mem_object = NULL;
     const char *kvm_opts = NULL;
@@ -428,17 +429,23 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
      */
     events = args->defer_target_connect ? "-global migration.x-events=on" : "";
 
+    if (args->config) {
+        GString *json = qobject_to_json(QOBJECT(args->config));
+        config_opts = g_strdup_printf("-incoming '%s'", json->str);
+    }
+
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
                                  "%s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
-                                 "%s %s %s %s",
+                                 "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_backend, tmpfs,
                                  args->incoming_defer ? "defer" : uri,
+                                 config_opts ? config_opts : "",
                                  events,
                                  arch_opts ? arch_opts : "",
                                  args->opts_target ? args->opts_target : "",
@@ -503,9 +510,11 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
     src_state.suspend_me = args->suspend_me;
 
+    args->config = config_load(args->config);
     if (migrate_args(&cmd_source, &cmd_target, uri, args)) {
         return -1;
     }
+    config_put(args->config);
 
     if (!args->only_target) {
         *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
-- 
2.51.0


