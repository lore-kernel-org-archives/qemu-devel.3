Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025A3CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAEa-0001nN-1m; Wed, 29 Apr 2026 15:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIAEY-0001mR-Gr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:06 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIAEW-0000Nh-GQ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:06 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16F656A81A;
 Wed, 29 Apr 2026 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777489557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Q11033ixT9HAxDsw1JBkEAYwLqftpwNv4tC1cNzWxc=;
 b=fWoIChkEdsZIGGjQyYF+d9cMjEAw+7I6okZFA8A2NMBuYbyusXkNOURG5VsSii5DZIUc1v
 0FH935L9kyl1hhU/ImlfwhIDQrgZAPWKfYj8baVg+rRYLWZ4R6K9GMhIm7wuy33anU4qYQ
 G9r4x58wZGRV8uel4sETiF2qzp7uwJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777489557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Q11033ixT9HAxDsw1JBkEAYwLqftpwNv4tC1cNzWxc=;
 b=lIOiwFlEO/SIqa/N/BLmB4/Dxsb+Mk8mzZbhahih0SC6pgzlyq7FBqGxDh+qex8A1egxxj
 rJNK2Zqs6J6PToCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fWoIChkE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lIOiwFlE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777489557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Q11033ixT9HAxDsw1JBkEAYwLqftpwNv4tC1cNzWxc=;
 b=fWoIChkEdsZIGGjQyYF+d9cMjEAw+7I6okZFA8A2NMBuYbyusXkNOURG5VsSii5DZIUc1v
 0FH935L9kyl1hhU/ImlfwhIDQrgZAPWKfYj8baVg+rRYLWZ4R6K9GMhIm7wuy33anU4qYQ
 G9r4x58wZGRV8uel4sETiF2qzp7uwJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777489557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Q11033ixT9HAxDsw1JBkEAYwLqftpwNv4tC1cNzWxc=;
 b=lIOiwFlEO/SIqa/N/BLmB4/Dxsb+Mk8mzZbhahih0SC6pgzlyq7FBqGxDh+qex8A1egxxj
 rJNK2Zqs6J6PToCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3317593B1;
 Wed, 29 Apr 2026 19:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MMhBIJNW8mm/eQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 19:05:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, marcandre.lureau@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 2/5] tests/qtest/dbus-vmstate: Mute Glib complaints about
 g_unsetenv thread-safety
Date: Wed, 29 Apr 2026 16:05:47 -0300
Message-ID: <20260429190550.20122-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429190550.20122-1-farosas@suse.de>
References: <20260429190550.20122-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,gnome.org:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 16F656A81A
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

TLDR: GLib is bugged, the dbus-vmstate-test spams debug messages
unconditionally. Mute them.

GLib is trying to protect against the lack of thread-safety of
setenv/unsetsenv functions by warning when those functions were
invoked after a thread has been started.
https://gitlab.gnome.org/GNOME/glib/issues/715

Unfortunately:
1) GLib itself starts a thread pool via _g_dbus_initialize when
working around a bug in its type dependency chain. This happens in
many places, but the test triggers it via
g_dbus_address_get_for_bus_sync.
https://bugzilla.gnome.org/show_bug.cgi?id=627724

2) GLib itself calls g_unsetenv after the test calls g_test_dbus_up.

3) The debug message at g_unsetenv is issued to the G_LOG_DOMAIN
defined while compiling the library, i.e "GLib", but this domain is
never initialized, so the log functions go into a fallback chain that
results in ignoring the G_MESSAGES_DEBUG environment variable, causing
the debug messages to not be suppressed when they should.

Mute the messages by implementing a handler for G_LOG_LEVEL_DEBUG
in the "GLib" log domain and honoring G_MESSAGES_DEBUG.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/dbus-vmstate-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 90c050b448..51c5fdb995 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -357,12 +357,33 @@ test_dbus_vmstate_missing_dst(char *name, MigrateCommon *args)
     g_test_trap_assert_passed();
 }
 
+static void log_func(const gchar *log_domain, GLogLevelFlags log_level,
+                     const gchar *message, gpointer user_data)
+{
+    const gchar *domains;
+
+    assert(log_level & G_LOG_LEVEL_DEBUG);
+
+    domains = getenv("G_MESSAGES_DEBUG");
+    if (!domains || (!strstr(domains, "GLib") && !strstr(domains, "all"))) {
+        return;
+    }
+    g_log_default_handler("GLib", G_LOG_LEVEL_DEBUG, message, NULL);
+}
+
 int
 main(int argc, char **argv)
 {
     GError *err = NULL;
     int ret;
 
+    /*
+     * GLib currently emits debug messages that ignore
+     * G_MESSAGES_DEBUG. Set a custom log handler to work around the
+     * issue.
+     */
+    g_log_set_handler("GLib", G_LOG_LEVEL_DEBUG, log_func, NULL);
+
     g_test_init(&argc, &argv, NULL);
 
     workdir = g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
-- 
2.51.0


