Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB06AC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehdU-00058N-JD; Mon, 26 Feb 2024 15:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rehdL-000575-Ct
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:31:34 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rehdJ-0001m0-QU
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:31:31 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D85B51FD29;
 Mon, 26 Feb 2024 20:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708979488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fsTNSmlvw6Wc8XIGulbf+rzkCpKJFJ5TMcijkA4B4A=;
 b=q3b7HMZXp2+R6gunKMg2BQikvhf5Ux35Y8IQsGmc2OPNp71S4uV0txGOinepyEFo4ejrqw
 snBx6ZtyfF4q3pqZpAVGUH4LnRJtbB4halBczK0Xv0hEGLfyP7u11IEECZYumrbgdjw+Ik
 39KWys9nE9I5poOHKXvEgCSSSBsQ8+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708979488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fsTNSmlvw6Wc8XIGulbf+rzkCpKJFJ5TMcijkA4B4A=;
 b=VBL5eHjXUMmAGN6OlX8GVEb+1GSQ/Y4vXMtRGYcV64XDcJ9/LE2ch2ZXcOpNbMSU+edM60
 z3t/9XWVjoIRLKDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708979487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fsTNSmlvw6Wc8XIGulbf+rzkCpKJFJ5TMcijkA4B4A=;
 b=ImhJxcxzzBti2sWa7yKCrMlVLVT8VyKNQW0MIERZEnpeHQqX5eG04VdfY2vik8On9LrMli
 5GCCbZ2ajgsitd16SA0AKggwL6ZWAVYKkvSwh8CfXTPaopvqsnBIz9IZgvlnfNJWTulx+c
 /Ougc6lVMKPd6Z/USz6zImSsMLPAMlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708979487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fsTNSmlvw6Wc8XIGulbf+rzkCpKJFJ5TMcijkA4B4A=;
 b=dS3XbVFW0jz1MqDpkz4FxOTi6cXiKjKdR3EW6PVuSBUKqiuu5R0ZgQ+P/mH5LIuBgcqxjs
 STsExr/86aKfelDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B300513A3A;
 Mon, 26 Feb 2024 20:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sHFRHh713GWJSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Feb 2024 20:31:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/2] migration: Join the return path thread before releasing
 to_dst_file
Date: Mon, 26 Feb 2024 17:31:21 -0300
Message-Id: <20240226203122.22894-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240226203122.22894-1-farosas@suse.de>
References: <20240226203122.22894-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ImhJxcxz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dS3XbVFW
X-Spamd-Result: default: False [-3.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D85B51FD29
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The return path thread might hang at a blocking system call. Before
joining the thread we might need to issue a shutdown() on the socket
file descriptor to release it. To determine whether the shutdown() is
necessary we look at the QEMUFile error.

Make sure we only clean up the QEMUFile after the return path has been
waited for.

This fixes a hang when qemu_savevm_state_setup() produced an error
that was detected by migration_detect_error(). That skips
migration_completion() so close_return_path_on_source() would get
stuck waiting for the RP thread to terminate.

Reported-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cad..3161be7cde 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1326,6 +1326,8 @@ static void migrate_fd_cleanup(MigrationState *s)
 
     qemu_savevm_state_cleanup();
 
+    close_return_path_on_source(s);
+
     if (s->to_dst_file) {
         QEMUFile *tmp;
 
@@ -1350,12 +1352,6 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
 
-    /*
-     * We already cleaned up to_dst_file, so errors from the return
-     * path might be due to that, ignore them.
-     */
-    close_return_path_on_source(s);
-
     assert(!migration_is_active(s));
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
@@ -2874,6 +2870,13 @@ static MigThrError postcopy_pause(MigrationState *s)
     while (true) {
         QEMUFile *file;
 
+        /*
+         * We're already pausing, so ignore any errors on the return
+         * path and just wait for the thread to finish. It will be
+         * re-created when we resume.
+         */
+        close_return_path_on_source(s);
+
         /*
          * Current channel is possibly broken. Release it.  Note that this is
          * guaranteed even without lock because to_dst_file should only be
@@ -2893,13 +2896,6 @@ static MigThrError postcopy_pause(MigrationState *s)
         qemu_file_shutdown(file);
         qemu_fclose(file);
 
-        /*
-         * We're already pausing, so ignore any errors on the return
-         * path and just wait for the thread to finish. It will be
-         * re-created when we resume.
-         */
-        close_return_path_on_source(s);
-
         migrate_set_state(&s->state, s->state,
                           MIGRATION_STATUS_POSTCOPY_PAUSED);
 
-- 
2.35.3


