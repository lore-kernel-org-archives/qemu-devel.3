Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F27FD5B872
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGdi-000368-N1; Mon, 15 Dec 2025 17:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdh-0002tj-0v
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:57 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdf-0002kh-21
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:56 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 25E0E33748;
 Mon, 15 Dec 2025 22:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nirVhd/ypAIBn1vzHwwG9vsWjnc9mkc05nhW4x74y4w=;
 b=LD4mksMmvDMdTXQSZgUomhg9AViUA9DwhgfsHK5LUFYNBQzEeTK1AtCJoDS/ufNhEdXIDs
 1lVWaMANeBRmRAZ3lpjycEPWFbfTYi6QSSJpTY19SStRxJrmkZBxdyCkPpyRSEckiTD/IL
 DJd/mtFfltgcB5Xf4K3sdOVBHlGzox4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nirVhd/ypAIBn1vzHwwG9vsWjnc9mkc05nhW4x74y4w=;
 b=sLds6KTmemnJaC/KVBFptk/l3B7BrT6dc/utJ09vxWnEPzY1P2e6oBD1Ubofn42+pS2RkW
 NEHcsMvZvDnQc8CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nirVhd/ypAIBn1vzHwwG9vsWjnc9mkc05nhW4x74y4w=;
 b=LD4mksMmvDMdTXQSZgUomhg9AViUA9DwhgfsHK5LUFYNBQzEeTK1AtCJoDS/ufNhEdXIDs
 1lVWaMANeBRmRAZ3lpjycEPWFbfTYi6QSSJpTY19SStRxJrmkZBxdyCkPpyRSEckiTD/IL
 DJd/mtFfltgcB5Xf4K3sdOVBHlGzox4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nirVhd/ypAIBn1vzHwwG9vsWjnc9mkc05nhW4x74y4w=;
 b=sLds6KTmemnJaC/KVBFptk/l3B7BrT6dc/utJ09vxWnEPzY1P2e6oBD1Ubofn42+pS2RkW
 NEHcsMvZvDnQc8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E1993EA63;
 Mon, 15 Dec 2025 22:01:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UO4xCEuFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 24/51] migration: Allow incoming cmdline to take config
Date: Mon, 15 Dec 2025 19:00:10 -0300
Message-ID: <20251215220041.12657-25-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.990];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
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

When -incoming "defer" is not used, the incoming migration is invoked
directly by the command line parsing code in vl.c. Allow the migration
config to be passed via the -incoming command line option so that
invocation of qmp_migrate_incoming() can receive it.

E.g.
-incoming '{"tls-creds": "tlscredsx509server0", "tls-hostname": "qemu.org"}'

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
This is useful for the tests. If we want to declare that
config-passing only works with -incoming defer, that's fine with me.
---
 system/vl.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 100 insertions(+), 12 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index d09dc9a61c..ac44933a11 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -169,6 +169,9 @@ static const char *mem_path;
 static const char *incoming;
 static const char *incoming_str[MIGRATION_CHANNEL_TYPE__MAX];
 static MigrationChannel *incoming_channels[MIGRATION_CHANNEL_TYPE__MAX];
+static MigrationParameters *migration_config;
+static Error *migration_channel_err;
+static Error *migration_config_err;
 static const char *loadvm;
 static const char *accelerators;
 static bool have_custom_ram_size;
@@ -1825,28 +1828,102 @@ static void object_option_add_visitor(Visitor *v)
     QTAILQ_INSERT_TAIL(&object_opts, opt, next);
 }
 
-static void incoming_option_parse(const char *str)
+/*
+ * Either "defer" or a proper uri, whether plain string or a json
+ * representation of MigrationChannel.
+ */
+static bool incoming_option_parse_channels(const char *str, Error **errp)
 {
     MigrationChannelType type = MIGRATION_CHANNEL_TYPE_MAIN;
-    MigrationChannel *channel;
+    MigrationChannel *channel = NULL;
     Visitor *v;
 
-    if (!strcmp(str, "defer")) {
-        channel = NULL;
-    } else if (migrate_is_uri(str)) {
+    if (g_str_equal(str, "defer")) {
+        incoming_str[type] = str;
+        return true;
+    }
+
+    if (migrate_is_uri(str)) {
         migrate_uri_parse(str, &channel, &error_fatal);
     } else {
         v = qobject_input_visitor_new_str(str, "channel-type", &error_fatal);
-        visit_type_MigrationChannel(v, NULL, &channel, &error_fatal);
+        if (v && !visit_type_MigrationChannel(v, NULL, &channel, errp)) {
+            visit_free(v);
+            return false;
+        }
         visit_free(v);
+    }
+
+    if (channel) {
         type = channel->channel_type;
+        /* New incoming spec replaces the previous */
+        qapi_free_MigrationChannel(incoming_channels[type]);
+        incoming_channels[type] = channel;
+        incoming_str[type] = str;
     }
 
-    /* New incoming spec replaces the previous */
-    qapi_free_MigrationChannel(incoming_channels[type]);
-    incoming_channels[type] = channel;
-    incoming_str[type] = str;
     incoming = incoming_str[MIGRATION_CHANNEL_TYPE_MAIN];
+    return true;
+}
+
+/*
+ * The migration configuration object in JSON form.
+ */
+static bool incoming_option_parse_config(const char *str, Error **errp)
+{
+    MigrationParameters *config = NULL;
+    Visitor *v;
+
+    v = qobject_input_visitor_new_str(str, "config", &error_fatal);
+    if (v && !visit_type_MigrationParameters(v, NULL, &config, errp)) {
+        visit_free(v);
+        return false;
+    }
+
+    if (config) {
+        /* later incoming configs replace the previous ones */
+        migration_config = config;
+    }
+
+    visit_free(v);
+    return true;
+}
+
+static void incoming_option_parse(const char *str)
+{
+    /*
+     * Independent Error objects because we don't know whether the
+     * input is meant to be the channels or the config. The parsing
+     * may fail for one and succeed for the other.
+     */
+    g_autoptr(Error) channel_err = NULL;
+    g_autoptr(Error) config_err = NULL;
+
+    /*
+     * Skip if there's already an error for a previous -incoming
+     * instance.
+     */
+    if (migration_channel_err || migration_config_err) {
+        return;
+    }
+
+    if (!migration_channel_err &&
+        incoming_option_parse_channels(str, &channel_err)) {
+        return;
+    }
+
+    if (!migration_config_err &&
+        incoming_option_parse_config(str, &config_err)) {
+        return;
+    }
+
+    if (channel_err) {
+        migration_channel_err = error_copy(channel_err);
+        error_prepend(&migration_channel_err, "-incoming %s: ", str);
+    } else if (config_err) {
+        migration_config_err = error_copy(config_err);
+        error_prepend(&migration_config_err, "-incoming %s: ", str);
+    }
 }
 
 static void object_option_parse(const char *str)
@@ -2537,6 +2614,16 @@ static void qemu_validate_options(const QDict *machine_opts)
         exit(EXIT_FAILURE);
     }
 
+    if (migration_channel_err && !incoming) {
+        error_report_err(migration_config_err);
+        exit(EXIT_FAILURE);
+    }
+
+    if (migration_config_err && !migration_config) {
+        error_report_err(migration_config_err);
+        exit(EXIT_FAILURE);
+    }
+
 #ifdef CONFIG_CURSES
     if (is_daemonized() && dpy.type == DISPLAY_TYPE_CURSES) {
         error_report("curses display cannot be used with -daemonize");
@@ -2824,13 +2911,14 @@ void qmp_x_exit_preconfig(Error **errp)
 
     if (incoming) {
         Error *local_err = NULL;
+
         if (strcmp(incoming, "defer") != 0) {
             g_autofree MigrationChannelList *channels =
                 g_new0(MigrationChannelList, 1);
 
             channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
-            qmp_migrate_incoming(NULL, true, channels, NULL, true, true,
-                                 &local_err);
+            qmp_migrate_incoming(NULL, true, channels, migration_config, true,
+                                 true, &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.51.0


