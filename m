Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08784C61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEd9-00016l-4A; Wed, 26 Aug 2026 10:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEd7-00016V-Cw
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:29 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEd5-0001cB-Lh
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E09A211E3;
 Wed, 26 Aug 2026 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrepw8xFVIYK0eTpXHlcG4uSiRXY3zAh8X76xJ5QxIo=;
 b=wJ4IAraLNDqe3HIuDt6ldSRdBhN9f0UPPHwfwVWdeXTlcEnHoZVCFH1uP+XpWJOMPGVsWR
 LNl0K3mONOc+f+ujCI+FWo9+9fIIeUan59nOTqccqR9zLuAY8Ok/bgYnNQpReVQvW5JNOd
 HhjL/VWm/exbsxEjhzUbsGcS1+LRets=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrepw8xFVIYK0eTpXHlcG4uSiRXY3zAh8X76xJ5QxIo=;
 b=HLOKUoDhZNHeljJ5WiDrI31iswAwlFJFDpHNchJSKpAsin3emnETvjpvCPHDEh48IJW+1j
 ZRzkHbdvf2vFplCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrepw8xFVIYK0eTpXHlcG4uSiRXY3zAh8X76xJ5QxIo=;
 b=nqD6B3CvZU8s4QYHmBJjeUvwLFLg6UBWfG1A2sfe7YY3ABaAWrVvgrTP6ud4WTZ958zDal
 U89SC36puAuVdZSAJsfoivbn9/NOWU04iXRixFQV+gOTBYdmIzJWpMztVaPg8IWZ41J6jZ
 KicgmbNsrdG6UYCnJx4wnuFwz3p1GbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrepw8xFVIYK0eTpXHlcG4uSiRXY3zAh8X76xJ5QxIo=;
 b=gdFrLShieCl0ukoAwOP8C7v6mo3qjqCz1uVLTwGMrvcR3NlPmTt8AHSVmy2gNmCVPvappb
 p50cTt7CyIzXrMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DE4B13674;
 Wed, 26 Aug 2026 14:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6DztCzv4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 05/30] migration: Make qemu_get_buffer_at() thread-safe
Date: Wed, 26 Aug 2026 11:28:40 -0300
Message-ID: <20260826142905.2315503-6-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

From: Aadeshveer Singh <aadeshveer07@gmail.com>

Remove the internal QEMUFile error state modification from
qemu_get_buffer_at(). This function is called by two functions, both of
which already check for unexpected return values and handle their own
error reporting.

Removing this shared state modification makes qemu_get_buffer_at()
strictly thread-safe for concurrent disk reads, serving as a
preparatory change for the upcoming fast snapshot load feature.

Removed local error by passing errp to improve on error handling,
consequently also change caller to use error_prevent and not error_setg.

Set errp in case of f->last_error as function should set errp in case it
fails, and caller can simply use error_prepend without checking errp in
case of error.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/qemu-file.c | 11 +++++------
 migration/qemu-file.h |  4 ++--
 migration/ram.c       |  6 +++---
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index f30e13c66d7..7735e618549 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -550,17 +550,16 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
 }
 
 
-size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
-                          off_t pos)
+size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen, off_t pos,
+                          Error **errp)
 {
-    Error *err = NULL;
-
     if (f->last_error) {
+        error_setg(errp, "Cannot read from file: stream is in error state %d",
+                   f->last_error);
         return 0;
     }
 
-    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, &err) < 0) {
-        qemu_file_set_error_obj(f, -EIO, err);
+    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, errp) < 0) {
         return 0;
     }
 
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 8f824c124d8..966766788dd 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -76,8 +76,8 @@ void qemu_set_offset(QEMUFile *f, off_t off, int whence);
 off_t qemu_get_offset(QEMUFile *f);
 void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                         off_t pos);
-size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
-                          off_t pos);
+size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen, off_t pos,
+                          Error **errp);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
 int qemu_file_put_fd(QEMUFile *f, int fd);
diff --git a/migration/ram.c b/migration/ram.c
index 7fa4774246a..60ad4352150 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4133,7 +4133,7 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
                                               block->pages_offset + offset);
             } else {
                 read = qemu_get_buffer_at(f, host, size,
-                                          block->pages_offset + offset);
+                                          block->pages_offset + offset, errp);
             }
 
             if (!read) {
@@ -4202,8 +4202,8 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
     bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
 
     if (qemu_get_buffer_at(f, (uint8_t *)block->file_bmap, bitmap_size,
-                           header.bitmap_offset) != bitmap_size) {
-        error_setg(errp, "Error reading dirty bitmap");
+                           header.bitmap_offset, errp) != bitmap_size) {
+        error_prepend(errp, "Error reading dirty bitmap");
         return;
     }
 
-- 
2.53.0


