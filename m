Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FB9C79FB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpwA-00084X-1y; Mon, 05 Jan 2026 14:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvn-0007u8-QG
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:56 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvj-0005ZB-7I
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:53 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 387E35BCD2;
 Mon,  5 Jan 2026 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLtXDI7GnrfzOzRlHIYSqjzBTx7GbuX/+8/Dgt7pp70=;
 b=f8j36FE11fNrh+hbeEfylHc5x8pyENNv2xSwjVGLhRt5I0F6hoN7/UYb9gnHzKc6E3dZtJ
 NAmVRLN2/H6/DO8S5Ypwjw1PzkULcVl/E7v58ECgyh7G9QIzOMfXjMep7bBvZxWE31koxJ
 oIvrU5M0Wt6T/kdK/gg8rqZlHOIIc2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLtXDI7GnrfzOzRlHIYSqjzBTx7GbuX/+8/Dgt7pp70=;
 b=DD4LeWSkRMvCnwsfkAYZoUiqjh4xoOPHZ5PqwfSpboEXcTzGKofOsGNv4g15JLB5iX9zJb
 vkqJd9RdyiPmVWDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLtXDI7GnrfzOzRlHIYSqjzBTx7GbuX/+8/Dgt7pp70=;
 b=f8j36FE11fNrh+hbeEfylHc5x8pyENNv2xSwjVGLhRt5I0F6hoN7/UYb9gnHzKc6E3dZtJ
 NAmVRLN2/H6/DO8S5Ypwjw1PzkULcVl/E7v58ECgyh7G9QIzOMfXjMep7bBvZxWE31koxJ
 oIvrU5M0Wt6T/kdK/gg8rqZlHOIIc2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLtXDI7GnrfzOzRlHIYSqjzBTx7GbuX/+8/Dgt7pp70=;
 b=DD4LeWSkRMvCnwsfkAYZoUiqjh4xoOPHZ5PqwfSpboEXcTzGKofOsGNv4g15JLB5iX9zJb
 vkqJd9RdyiPmVWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E87B213964;
 Mon,  5 Jan 2026 19:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YKVOKeYLXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:07:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 16/25] migration/channel: Rename migration_channel_connect
Date: Mon,  5 Jan 2026 16:06:33 -0300
Message-ID: <20260105190644.14072-17-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105190644.14072-1-farosas@suse.de>
References: <20260105190644.14072-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.984];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Rename migration_channel_connect to indicate this is the source
side. Future patches will do similar changes to the incoming side and
this will avoid inconsistencies in naming.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c | 9 +--------
 migration/channel.h | 2 +-
 migration/exec.c    | 2 +-
 migration/fd.c      | 2 +-
 migration/file.c    | 2 +-
 migration/socket.c  | 2 +-
 migration/tls.c     | 2 +-
 7 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index f1c1341a3e..94dea03812 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -61,14 +61,7 @@ out:
     }
 }
 
-
-/**
- * @migration_channel_connect - Create new outgoing migration channel
- *
- * @s: Current migration state
- * @ioc: Channel to which we are connecting
- */
-void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
+void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
 {
     trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
 
diff --git a/migration/channel.h b/migration/channel.h
index b45e909597..0e189c4325 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -28,7 +28,7 @@ enum {
 
 void migration_channel_process_incoming(QIOChannel *ioc);
 
-void migration_channel_connect(MigrationState *s, QIOChannel *ioc);
+void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc);
 
 int migration_channel_read_peek(QIOChannel *ioc,
                                 const char *buf,
diff --git a/migration/exec.c b/migration/exec.c
index d83a07435a..d1629944dc 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -55,7 +55,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
     }
 
     qio_channel_set_name(ioc, "migration-exec-outgoing");
-    migration_channel_connect(s, ioc);
+    migration_channel_connect_outgoing(s, ioc);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/fd.c b/migration/fd.c
index 0144a70742..150b236fbf 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -70,7 +70,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
     }
 
     qio_channel_set_name(ioc, "migration-fd-outgoing");
-    migration_channel_connect(s, ioc);
+    migration_channel_connect_outgoing(s, ioc);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/file.c b/migration/file.c
index 7bb9c1c79f..935402f36b 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -122,7 +122,7 @@ void file_start_outgoing_migration(MigrationState *s,
         return;
     }
     qio_channel_set_name(ioc, "migration-file-outgoing");
-    migration_channel_connect(s, ioc);
+    migration_channel_connect_outgoing(s, ioc);
 }
 
 static gboolean file_accept_incoming_migration(QIOChannel *ioc,
diff --git a/migration/socket.c b/migration/socket.c
index 298bac30cc..611915f84d 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -73,7 +73,7 @@ static void socket_outgoing_migration(QIOTask *task,
     }
 
     trace_migration_socket_outgoing_connected();
-    migration_channel_connect(data->s, sioc);
+    migration_channel_connect_outgoing(data->s, sioc);
     return;
 err:
     trace_migration_socket_outgoing_error(error_get_pretty(err));
diff --git a/migration/tls.c b/migration/tls.c
index 837b08294f..89ba52de02 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -114,7 +114,7 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
     }
 
     trace_migration_tls_outgoing_handshake_complete();
-    migration_channel_connect(s, ioc);
+    migration_channel_connect_outgoing(s, ioc);
 }
 
 QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
-- 
2.51.0


