Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1E7D1A616
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBoM-0004Zf-BL; Fri, 09 Jan 2026 07:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBoI-00045O-46
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:46 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBoG-0007MI-14
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:45 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 85E91337BA;
 Fri,  9 Jan 2026 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dsS8vqKFkAf1sbThWipwqySx5momWhA0MEufMmchTQ=;
 b=LhULWgkzTpdK8b3cSwZv2fpg9U3ndf/d65CGh7gXJx/F6wRreR0VCTSiROJ8Q8pWkhiwTe
 Ds2oSgOECBGiEsblGrcTITZtvBXEx8TlBaQYApCN5JEhcEccTkSSwjr9zXB02rrKjKV1pu
 M8TuNJA2lvKHy5zlqUZ0AYnCMr19X8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dsS8vqKFkAf1sbThWipwqySx5momWhA0MEufMmchTQ=;
 b=Dui8vFRG7YK/exb5XDZiw5fIGeSjrYLufeICsMbbCTjwK1aPaagZ6qfmIv0q8Z8J7R4WVV
 8L1oACF7pU9s0UAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LhULWgkz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Dui8vFRG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dsS8vqKFkAf1sbThWipwqySx5momWhA0MEufMmchTQ=;
 b=LhULWgkzTpdK8b3cSwZv2fpg9U3ndf/d65CGh7gXJx/F6wRreR0VCTSiROJ8Q8pWkhiwTe
 Ds2oSgOECBGiEsblGrcTITZtvBXEx8TlBaQYApCN5JEhcEccTkSSwjr9zXB02rrKjKV1pu
 M8TuNJA2lvKHy5zlqUZ0AYnCMr19X8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dsS8vqKFkAf1sbThWipwqySx5momWhA0MEufMmchTQ=;
 b=Dui8vFRG7YK/exb5XDZiw5fIGeSjrYLufeICsMbbCTjwK1aPaagZ6qfmIv0q8Z8J7R4WVV
 8L1oACF7pU9s0UAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 387FE3EA63;
 Fri,  9 Jan 2026 12:41:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2O+FOW33YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:41:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 16/25] migration/channel: Rename migration_channel_connect
Date: Fri,  9 Jan 2026 09:40:32 -0300
Message-ID: <20260109124043.25019-17-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109124043.25019-1-farosas@suse.de>
References: <20260109124043.25019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 85E91337BA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Reviewed-by: Peter Xu <peterx@redhat.com>
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
index b8d757c17b..f41333adcc 100644
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
index b361e1c838..574bfec65c 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -28,7 +28,7 @@ typedef enum {
 
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


