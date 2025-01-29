Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F189C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXZ-0006GH-LV; Wed, 29 Jan 2025 11:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVX-0003HY-V9
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:52 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVU-0005I0-QU
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5703F1F365;
 Wed, 29 Jan 2025 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBNZtSiI+Z0X4jH0jdTf9Edwx+1OSMQPOSIcGOrxR9A=;
 b=jfVycR95vFsR/QMhhtZVUTwCZ0UNZtUE7vE5YS2R/nEv/Cdeg4fl0eSDtc8p9GASfgX6Gd
 8HeqgdWArGAOmaMEc9kRPmXKzcQgpcKhKiToMgipgIU7FUYaE8Q4Nbt4nK53cXVKyOGBBx
 mf7lFmmWVtDzzFPkHkZb04o05a3js3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBNZtSiI+Z0X4jH0jdTf9Edwx+1OSMQPOSIcGOrxR9A=;
 b=oqSVdwLgQtNTXoBhSgtnbTNxQKo6+gWcgC0kjGPaDb06hW7O2Cgx6izgFr1lU0XEDg8DoL
 E2TVGl9RaC3YCSBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jfVycR95;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oqSVdwLg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBNZtSiI+Z0X4jH0jdTf9Edwx+1OSMQPOSIcGOrxR9A=;
 b=jfVycR95vFsR/QMhhtZVUTwCZ0UNZtUE7vE5YS2R/nEv/Cdeg4fl0eSDtc8p9GASfgX6Gd
 8HeqgdWArGAOmaMEc9kRPmXKzcQgpcKhKiToMgipgIU7FUYaE8Q4Nbt4nK53cXVKyOGBBx
 mf7lFmmWVtDzzFPkHkZb04o05a3js3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBNZtSiI+Z0X4jH0jdTf9Edwx+1OSMQPOSIcGOrxR9A=;
 b=oqSVdwLgQtNTXoBhSgtnbTNxQKo6+gWcgC0kjGPaDb06hW7O2Cgx6izgFr1lU0XEDg8DoL
 E2TVGl9RaC3YCSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E478137DB;
 Wed, 29 Jan 2025 16:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4BQIMN1QmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 14/42] migration: SCM_RIGHTS for QEMUFile
Date: Wed, 29 Jan 2025 13:00:31 -0300
Message-Id: <20250129160059.6987-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [5.36 / 50.00]; BAYES_SPAM(5.07)[99.91%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; BAD_REP_POLICIES(0.10)[];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 R_DKIM_ALLOW(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 oracle.com:email]
X-Spamd-Bar: +++++
X-Rspamd-Queue-Id: 5703F1F365
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

From: Steve Sistare <steven.sistare@oracle.com>

Define functions to put/get file descriptors to/from a QEMUFile, for qio
channels that support SCM_RIGHTS.  Maintain ordering such that
  put(A), put(fd), put(B)
followed by
  get(A), get(fd), get(B)
always succeeds.  Other get orderings may succeed but are not guaranteed.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-14-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/qemu-file.c  | 84 ++++++++++++++++++++++++++++++++++++++++--
 migration/qemu-file.h  |  2 +
 migration/trace-events |  2 +
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6d2f588bd..1303a5bf58 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -37,6 +37,11 @@
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
 
+typedef struct FdEntry {
+    QTAILQ_ENTRY(FdEntry) entry;
+    int fd;
+} FdEntry;
+
 struct QEMUFile {
     QIOChannel *ioc;
     bool is_writable;
@@ -51,6 +56,9 @@ struct QEMUFile {
 
     int last_error;
     Error *last_error_obj;
+
+    bool can_pass_fd;
+    QTAILQ_HEAD(, FdEntry) fds;
 };
 
 /*
@@ -109,6 +117,8 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
     object_ref(ioc);
     f->ioc = ioc;
     f->is_writable = is_writable;
+    f->can_pass_fd = qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS);
+    QTAILQ_INIT(&f->fds);
 
     return f;
 }
@@ -310,6 +320,10 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
     int len;
     int pending;
     Error *local_error = NULL;
+    g_autofree int *fds = NULL;
+    size_t nfd = 0;
+    int **pfds = f->can_pass_fd ? &fds : NULL;
+    size_t *pnfd = f->can_pass_fd ? &nfd : NULL;
 
     assert(!qemu_file_is_writable(f));
 
@@ -325,10 +339,9 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
     }
 
     do {
-        len = qio_channel_read(f->ioc,
-                               (char *)f->buf + pending,
-                               IO_BUF_SIZE - pending,
-                               &local_error);
+        struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
+        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
+                                     &local_error);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
             if (qemu_in_coroutine()) {
                 qio_channel_yield(f->ioc, G_IO_IN);
@@ -348,9 +361,66 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
         qemu_file_set_error_obj(f, len, local_error);
     }
 
+    for (int i = 0; i < nfd; i++) {
+        FdEntry *fde = g_new0(FdEntry, 1);
+        fde->fd = fds[i];
+        QTAILQ_INSERT_TAIL(&f->fds, fde, entry);
+    }
+
     return len;
 }
 
+int qemu_file_put_fd(QEMUFile *f, int fd)
+{
+    int ret = 0;
+    QIOChannel *ioc = qemu_file_get_ioc(f);
+    Error *err = NULL;
+    struct iovec iov = { (void *)" ", 1 };
+
+    /*
+     * Send a dummy byte so qemu_fill_buffer on the receiving side does not
+     * fail with a len=0 error.  Flush first to maintain ordering wrt other
+     * data.
+     */
+
+    qemu_fflush(f);
+    if (qio_channel_writev_full(ioc, &iov, 1, &fd, 1, 0, &err) < 1) {
+        error_report_err(error_copy(err));
+        qemu_file_set_error_obj(f, -EIO, err);
+        ret = -1;
+    }
+    trace_qemu_file_put_fd(f->ioc->name, fd, ret);
+    return ret;
+}
+
+int qemu_file_get_fd(QEMUFile *f)
+{
+    int fd = -1;
+    FdEntry *fde;
+
+    if (!f->can_pass_fd) {
+        Error *err = NULL;
+        error_setg(&err, "%s does not support fd passing", f->ioc->name);
+        error_report_err(error_copy(err));
+        qemu_file_set_error_obj(f, -EIO, err);
+        goto out;
+    }
+
+    /* Force the dummy byte and its fd passenger to appear. */
+    qemu_peek_byte(f, 0);
+
+    fde = QTAILQ_FIRST(&f->fds);
+    if (fde) {
+        qemu_get_byte(f);       /* Drop the dummy byte */
+        fd = fde->fd;
+        QTAILQ_REMOVE(&f->fds, fde, entry);
+        g_free(fde);
+    }
+out:
+    trace_qemu_file_get_fd(f->ioc->name, fd);
+    return fd;
+}
+
 /** Closes the file
  *
  * Returns negative error value if any error happened on previous operations or
@@ -361,11 +431,17 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
  */
 int qemu_fclose(QEMUFile *f)
 {
+    FdEntry *fde, *next;
     int ret = qemu_fflush(f);
     int ret2 = qio_channel_close(f->ioc, NULL);
     if (ret >= 0) {
         ret = ret2;
     }
+    QTAILQ_FOREACH_SAFE(fde, &f->fds, entry, next) {
+        warn_report("qemu_fclose: received fd %d was never claimed", fde->fd);
+        close(fde->fd);
+        g_free(fde);
+    }
     g_clear_pointer(&f->ioc, object_unref);
     error_free(f->last_error_obj);
     g_free(f);
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 11c2120edd..3e47a20621 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -79,5 +79,7 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                           off_t pos);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
+int qemu_file_put_fd(QEMUFile *f, int fd);
+int qemu_file_get_fd(QEMUFile *f);
 
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index 4e3061bc55..abd9cdf2a1 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -88,6 +88,8 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
 
 # qemu-file.c
 qemu_file_fclose(void) ""
+qemu_file_put_fd(const char *name, int fd, int ret) "ioc %s, fd %d -> status %d"
+qemu_file_get_fd(const char *name, int fd) "ioc %s -> fd %d"
 
 # ram.c
 get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
-- 
2.35.3


