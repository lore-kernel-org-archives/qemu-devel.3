Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9C8D778AF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNEi-00023W-P0; Fri, 23 Jan 2026 14:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEh-00022X-6i
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:27 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEf-0003Uu-FT
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:26 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B9F1633863;
 Fri, 23 Jan 2026 19:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxddm5U6APu7XOwfsBVhki7+UpshfKnR0yF/8exGvAk=;
 b=fuMF/NMQkntSUOEBvQR2WUsH2Xk6Sh4Qgy5vbz5OgTwki1swuVy3U+qH05PDXrP73Ub54t
 ytffRDsF+BPz7R5c987yB4MLMOG8ISdANfJ1xsTKcnw3z4ntNTq6MGoMROFQUTfxW7jNZN
 S3cJvtLZ5jZOgslbCOzX4GyAfcsRAoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxddm5U6APu7XOwfsBVhki7+UpshfKnR0yF/8exGvAk=;
 b=G6Sl7wULl1cmgDCxHO1/OdInEDVNpzEZQ5nwalWuPhsBldymIJYe9Xixpf6dlsKDPpgljq
 w+uG8lf+OPWffgAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxddm5U6APu7XOwfsBVhki7+UpshfKnR0yF/8exGvAk=;
 b=fuMF/NMQkntSUOEBvQR2WUsH2Xk6Sh4Qgy5vbz5OgTwki1swuVy3U+qH05PDXrP73Ub54t
 ytffRDsF+BPz7R5c987yB4MLMOG8ISdANfJ1xsTKcnw3z4ntNTq6MGoMROFQUTfxW7jNZN
 S3cJvtLZ5jZOgslbCOzX4GyAfcsRAoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxddm5U6APu7XOwfsBVhki7+UpshfKnR0yF/8exGvAk=;
 b=G6Sl7wULl1cmgDCxHO1/OdInEDVNpzEZQ5nwalWuPhsBldymIJYe9Xixpf6dlsKDPpgljq
 w+uG8lf+OPWffgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EA891395E;
 Fri, 23 Jan 2026 19:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qNb7B9/Rc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 07/36] qemu-file: qemu_file_get_fd(): improve interface
Date: Fri, 23 Jan 2026 16:53:22 -0300
Message-ID: <20260123195352.12850-8-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Make it symmetrical with qemu_file_put_fd() and simplify callers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20260114064710.176268-6-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/qemu-file.c     |  9 ++++-----
 migration/qemu-file.h     |  2 +-
 migration/vmstate-types.c | 10 +---------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 8fdb6c87ea..9cf7dc3bd5 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -385,9 +385,8 @@ int qemu_file_put_fd(QEMUFile *f, int fd)
     return ret;
 }
 
-int qemu_file_get_fd(QEMUFile *f)
+int qemu_file_get_fd(QEMUFile *f, int *fd)
 {
-    int fd = -1;
     FdEntry *fde;
     Error *err = NULL;
     int service_byte;
@@ -410,12 +409,12 @@ int qemu_file_get_fd(QEMUFile *f)
         goto fail;
     }
 
-    fd = fde->fd;
+    *fd = fde->fd;
     QTAILQ_REMOVE(&f->fds, fde, entry);
     g_free(fde);
 
-    trace_qemu_file_get_fd(f->ioc->name, fd);
-    return fd;
+    trace_qemu_file_get_fd(f->ioc->name, *fd);
+    return 0;
 
 fail:
     error_report_err(error_copy(err));
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index c13c967167..a8e9bb2ccb 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -82,6 +82,6 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
 int qemu_file_put_fd(QEMUFile *f, int fd);
-int qemu_file_get_fd(QEMUFile *f);
+int qemu_file_get_fd(QEMUFile *f, int *fd);
 
 #endif
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index e34bf4486e..89cb211472 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -321,7 +321,6 @@ const VMStateInfo vmstate_info_uint64 = {
 static int get_fd(QEMUFile *f, void *pv, size_t size,
                   const VMStateField *field)
 {
-    int fd;
     int32_t *v = pv;
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
@@ -329,14 +328,7 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
 
-    fd = qemu_file_get_fd(f);
-    if (fd < 0) {
-        return -1;
-    }
-
-    *v = fd;
-
-    return 0;
+    return qemu_file_get_fd(f, v);
 }
 
 static int put_fd(QEMUFile *f, void *pv, size_t size,
-- 
2.51.0


