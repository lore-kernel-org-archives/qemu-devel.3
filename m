Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E541AC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADmK-0002hn-Hs; Thu, 23 May 2024 15:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlv-0002Gb-GI
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:39 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlt-0004LD-2Q
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D368220412;
 Thu, 23 May 2024 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjnxH7khDXmrflJOrKVMiCdjvXgeY6BwXBZDPxXoGaw=;
 b=g/9ZYB2QtEraUnqA+pfGWx0n5HhZMWF0ebivw5RKRWS3ZdrBRCqTP55e/xnuZExUo9Xmdk
 iZrS16H44a2SU5DMy3oMl9gmyh0mO3LQPhNkyZjFbe0f2veqRxwWJs5xpfiQhbGxFvc+Pz
 2IqKTWHn8AK1lpY8/ZOIGZKhQq3aPo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491195;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjnxH7khDXmrflJOrKVMiCdjvXgeY6BwXBZDPxXoGaw=;
 b=gaYFYbhX1BLt/DTndEKFkFGnJ0+YZQKdt0OKC9y0OcczkiKEmapjhWxiti6/nU58KCP1Lm
 gSgBRzD/c+R1xRBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjnxH7khDXmrflJOrKVMiCdjvXgeY6BwXBZDPxXoGaw=;
 b=g/9ZYB2QtEraUnqA+pfGWx0n5HhZMWF0ebivw5RKRWS3ZdrBRCqTP55e/xnuZExUo9Xmdk
 iZrS16H44a2SU5DMy3oMl9gmyh0mO3LQPhNkyZjFbe0f2veqRxwWJs5xpfiQhbGxFvc+Pz
 2IqKTWHn8AK1lpY8/ZOIGZKhQq3aPo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491195;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjnxH7khDXmrflJOrKVMiCdjvXgeY6BwXBZDPxXoGaw=;
 b=gaYFYbhX1BLt/DTndEKFkFGnJ0+YZQKdt0OKC9y0OcczkiKEmapjhWxiti6/nU58KCP1Lm
 gSgBRzD/c+R1xRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A65813A6B;
 Thu, 23 May 2024 19:06:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id APrUMLmTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v2 17/18] migration: Add direct-io helpers
Date: Thu, 23 May 2024 16:05:47 -0300
Message-Id: <20240523190548.23977-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

We support using O_DIRECT with multifd by isolating the main migration
channel which does unaligned IO from the multifd channels that do
aligned IO. When multifd is not enabled, we can still use O_DIRECT, if
we judiciously enable/disable the flag to avoid the unaligned IO.

Add helpers to enable/disable direct-io around the aligned parts.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 31 +++++++++++++++++++++++++++++++
 migration/migration.h |  2 ++
 migration/qemu-file.c | 29 +++++++++++++++++++++++++++++
 migration/qemu-file.h |  2 +-
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index e03c80b3aa..be128f95da 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -420,6 +420,37 @@ static void migrate_generate_event(int new_state)
     }
 }
 
+bool migration_direct_io_start(QEMUFile *file, Error **errp)
+{
+    if (!migrate_direct_io() || migrate_multifd()) {
+        return true;
+    }
+
+    /* flush any potentially unaligned IO before setting O_DIRECT */
+    qemu_fflush(file);
+
+    if (!qemu_file_set_direct_io(file, true)) {
+        error_setg(errp, "Failed to enable direct-io");
+        return false;
+    }
+
+    return true;
+}
+
+bool migration_direct_io_finish(QEMUFile *file, Error **errp)
+{
+    if (!migrate_direct_io() || migrate_multifd()) {
+        return true;
+    }
+
+    if (!qemu_file_set_direct_io(file, false)) {
+        error_setg(errp, "Failed to disable direct-io");
+        return false;
+    }
+
+    return true;
+}
+
 /*
  * Send a message on the return channel back to the source
  * of the migration.
diff --git a/migration/migration.h b/migration/migration.h
index 6af01362d4..4d808563b5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -536,4 +536,6 @@ int migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);
 
+bool migration_direct_io_start(QEMUFile *file, Error **errp);
+bool migration_direct_io_finish(QEMUFile *file, Error **errp);
 #endif
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 9ccbbb0099..4796be918f 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -52,6 +52,11 @@ struct QEMUFile {
 
     int last_error;
     Error *last_error_obj;
+    /*
+     * Whether O_DIRECT is in effect. Used to catch code attempting
+     * unaligned IO.
+     */
+    bool dio;
 };
 
 /*
@@ -281,6 +286,9 @@ int qemu_fflush(QEMUFile *f)
     }
     if (f->iovcnt > 0) {
         Error *local_error = NULL;
+
+        assert(!f->dio);
+
         if (qio_channel_writev_all(f->ioc,
                                    f->iov, f->iovcnt,
                                    &local_error) < 0) {
@@ -429,6 +437,8 @@ void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
         return;
     }
 
+    assert(!f->dio);
+
     add_to_iovec(f, buf, size, may_free);
 }
 
@@ -440,6 +450,8 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
         return;
     }
 
+    assert(!f->dio);
+
     while (size > 0) {
         l = IO_BUF_SIZE - f->buf_index;
         if (l > size) {
@@ -558,6 +570,8 @@ off_t qemu_get_offset(QEMUFile *f)
 
 void qemu_put_byte(QEMUFile *f, int v)
 {
+    assert(!f->dio);
+
     if (f->last_error) {
         return;
     }
@@ -865,3 +879,18 @@ int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size)
 
     return 0;
 }
+
+bool qemu_file_set_direct_io(QEMUFile *f, bool enabled)
+{
+    Error *local_err = NULL;
+
+    qio_channel_file_set_direct_io(f->ioc, enabled, &local_err);
+    if (local_err) {
+        qemu_file_set_error_obj(f, -EINVAL, local_err);
+        return false;
+    }
+
+    f->dio = enabled;
+
+    return true;
+}
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 11c2120edd..118853b21c 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -79,5 +79,5 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                           off_t pos);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
-
+bool qemu_file_set_direct_io(QEMUFile *f, bool enabled);
 #endif
-- 
2.35.3


