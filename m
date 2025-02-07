Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAABCC02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPLB-0001Vm-K2; Fri, 07 Feb 2025 09:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPLA-0001VZ-RZ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:28:20 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPL8-00006Q-IR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:28:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56AD02111F;
 Fri,  7 Feb 2025 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738938497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyfGXLCm+wkkzGdyntVYoc2+S3JM7lOCipiHbQwaNhQ=;
 b=HPzxVChply+fbck5bNHzJT8VcTFQoRVZC8M8n/ERUXLN3232pPBCfQpp3NMwkGBwiDsRQ8
 D/lnn8QX0ochCJ+9xhIQ+a/k6IL84/uWWfMiRy8NLisAYET/dQtVOy4XQOPgzZv8Hq8J3B
 LaON9+leKcEJ4mJ2bvgypjcRnJZVv8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738938497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyfGXLCm+wkkzGdyntVYoc2+S3JM7lOCipiHbQwaNhQ=;
 b=e9zhDs8EFPmZ3g4TfFu7LbIP3OyotYgHrX1ouKG5Tb4ZRUJg2p0I4mQhjA87wjuzD4M+oA
 Nt5JtbukQ/A/7oAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HPzxVChp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e9zhDs8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738938497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyfGXLCm+wkkzGdyntVYoc2+S3JM7lOCipiHbQwaNhQ=;
 b=HPzxVChply+fbck5bNHzJT8VcTFQoRVZC8M8n/ERUXLN3232pPBCfQpp3NMwkGBwiDsRQ8
 D/lnn8QX0ochCJ+9xhIQ+a/k6IL84/uWWfMiRy8NLisAYET/dQtVOy4XQOPgzZv8Hq8J3B
 LaON9+leKcEJ4mJ2bvgypjcRnJZVv8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738938497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyfGXLCm+wkkzGdyntVYoc2+S3JM7lOCipiHbQwaNhQ=;
 b=e9zhDs8EFPmZ3g4TfFu7LbIP3OyotYgHrX1ouKG5Tb4ZRUJg2p0I4mQhjA87wjuzD4M+oA
 Nt5JtbukQ/A/7oAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 060D2139CB;
 Fri,  7 Feb 2025 14:28:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ePlRLX0YpmcoOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 14:28:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: [RFC PATCH v2 6/8] io: Plumb read flags into qio_channel_read_all_eof
Date: Fri,  7 Feb 2025 11:27:56 -0300
Message-Id: <20250207142758.6936-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250207142758.6936-1-farosas@suse.de>
References: <20250207142758.6936-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 56AD02111F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,maciej.szmigiero.name,oracle.com,intel.com,gmail.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

We want to pass flags into qio_channel_tls_readv() but some functions
along the way don't take a flags argument. Plumb the flags through.

No functional change.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/remote/mpqemu-link.c       |  2 +-
 include/io/channel.h          |  6 ++++++
 io/channel.c                  | 13 +++++++++----
 migration/multifd.c           |  2 +-
 tools/i386/qemu-vmsr-helper.c |  3 ++-
 util/vhost-user-server.c      |  2 +-
 6 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/remote/mpqemu-link.c b/hw/remote/mpqemu-link.c
index e25f97680d..49885a1db6 100644
--- a/hw/remote/mpqemu-link.c
+++ b/hw/remote/mpqemu-link.c
@@ -110,7 +110,7 @@ static ssize_t mpqemu_read(QIOChannel *ioc, void *buf, size_t len, int **fds,
         bql_unlock();
     }
 
-    ret = qio_channel_readv_full_all_eof(ioc, &iov, 1, fds, nfds, errp);
+    ret = qio_channel_readv_full_all_eof(ioc, &iov, 1, fds, nfds, 0, errp);
 
     if (drop_bql && !iothread && !qemu_in_coroutine()) {
         bql_lock();
diff --git a/include/io/channel.h b/include/io/channel.h
index bdf0bca92a..6110f0ffe9 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -298,6 +298,7 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
  * @ioc: the channel object
  * @iov: the array of memory regions to read data into
  * @niov: the length of the @iov array
+ * @flags: read flags (QIO_CHANNEL_READ_FLAG_*)
  * @errp: pointer to a NULL-initialized error object
  *
  * Read data from the IO channel, storing it in the
@@ -321,6 +322,7 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
 int coroutine_mixed_fn qio_channel_readv_all_eof(QIOChannel *ioc,
                                                  const struct iovec *iov,
                                                  size_t niov,
+                                                 int flags,
                                                  Error **errp);
 
 /**
@@ -442,6 +444,7 @@ ssize_t qio_channel_write(QIOChannel *ioc,
  * @ioc: the channel object
  * @buf: the memory region to read data into
  * @buflen: the number of bytes to @buf
+ * @flags: read flags (QIO_CHANNEL_READ_FLAG_*)
  * @errp: pointer to a NULL-initialized error object
  *
  * Reads @buflen bytes into @buf, possibly blocking or (if the
@@ -457,6 +460,7 @@ ssize_t qio_channel_write(QIOChannel *ioc,
 int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
                                                 char *buf,
                                                 size_t buflen,
+                                                int flags,
                                                 Error **errp);
 
 /**
@@ -885,6 +889,7 @@ void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
  * @niov: the length of the @iov array
  * @fds: an array of file handles to read
  * @nfds: number of file handles in @fds
+ * @flags: read flags (QIO_CHANNEL_READ_FLAG_*)
  * @errp: pointer to a NULL-initialized error object
  *
  *
@@ -903,6 +908,7 @@ int coroutine_mixed_fn qio_channel_readv_full_all_eof(QIOChannel *ioc,
                                                       const struct iovec *iov,
                                                       size_t niov,
                                                       int **fds, size_t *nfds,
+                                                      int flags,
                                                       Error **errp);
 
 /**
diff --git a/io/channel.c b/io/channel.c
index e3f17c24a0..61e09202f1 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -113,9 +113,11 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
 int coroutine_mixed_fn qio_channel_readv_all_eof(QIOChannel *ioc,
                                                  const struct iovec *iov,
                                                  size_t niov,
+                                                 int flags,
                                                  Error **errp)
 {
-    return qio_channel_readv_full_all_eof(ioc, iov, niov, NULL, NULL, errp);
+    return qio_channel_readv_full_all_eof(ioc, iov, niov, NULL, NULL, flags,
+                                          errp);
 }
 
 int coroutine_mixed_fn qio_channel_readv_all(QIOChannel *ioc,
@@ -130,6 +132,7 @@ int coroutine_mixed_fn qio_channel_readv_full_all_eof(QIOChannel *ioc,
                                                       const struct iovec *iov,
                                                       size_t niov,
                                                       int **fds, size_t *nfds,
+                                                      int flags,
                                                       Error **errp)
 {
     int ret = -1;
@@ -155,7 +158,7 @@ int coroutine_mixed_fn qio_channel_readv_full_all_eof(QIOChannel *ioc,
     while ((nlocal_iov > 0) || local_fds) {
         ssize_t len;
         len = qio_channel_readv_full(ioc, local_iov, nlocal_iov, local_fds,
-                                     local_nfds, 0, errp);
+                                     local_nfds, flags, errp);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
             if (qemu_in_coroutine()) {
                 qio_channel_yield(ioc, G_IO_IN);
@@ -222,7 +225,8 @@ int coroutine_mixed_fn qio_channel_readv_full_all(QIOChannel *ioc,
                                                   int **fds, size_t *nfds,
                                                   Error **errp)
 {
-    int ret = qio_channel_readv_full_all_eof(ioc, iov, niov, fds, nfds, errp);
+    int ret = qio_channel_readv_full_all_eof(ioc, iov, niov, fds, nfds, 0,
+                                             errp);
 
     if (ret == 0) {
         error_setg(errp, "Unexpected end-of-file before all data were read");
@@ -329,10 +333,11 @@ ssize_t qio_channel_write(QIOChannel *ioc,
 int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
                                                 char *buf,
                                                 size_t buflen,
+                                                int flags,
                                                 Error **errp)
 {
     struct iovec iov = { .iov_base = buf, .iov_len = buflen };
-    return qio_channel_readv_all_eof(ioc, &iov, 1, errp);
+    return qio_channel_readv_all_eof(ioc, &iov, 1, flags, errp);
 }
 
 
diff --git a/migration/multifd.c b/migration/multifd.c
index b57cad3bb1..b4f82b0893 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1166,7 +1166,7 @@ static void *multifd_recv_thread(void *opaque)
             }
 
             ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
-                                           p->packet_len, &local_err);
+                                           p->packet_len, 0, &local_err);
             if (!ret) {
                 /* EOF */
                 assert(!local_err);
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index a35dcb88a3..2a9f1825b7 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -237,7 +237,8 @@ static void coroutine_fn vh_co_entry(void *opaque)
          * Only RAPL MSR in rapl-msr-index.h is allowed
          */
         r = qio_channel_read_all_eof(QIO_CHANNEL(client->ioc),
-                                     (char *) &request, sizeof(request), &local_err);
+                                     (char *) &request, sizeof(request), 0,
+                                     &local_err);
         if (r <= 0) {
             break;
         }
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index b19229074a..7006328b2e 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -190,7 +190,7 @@ vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
         .iov_len = vmsg->size,
     };
     if (vmsg->size) {
-        rc = qio_channel_readv_all_eof(ioc, &iov_payload, 1, &local_err);
+        rc = qio_channel_readv_all_eof(ioc, &iov_payload, 1, 0, &local_err);
         if (rc != 1) {
             if (local_err) {
                 error_report_err(local_err);
-- 
2.35.3


