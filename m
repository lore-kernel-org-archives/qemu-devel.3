Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5987C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLkd-0006W4-LJ; Wed, 28 Feb 2024 10:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkb-0006Uu-VY
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:41 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLka-0004nT-3h
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E95AE225D6;
 Wed, 28 Feb 2024 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8ETURXN4D66D0HrOGgTSooAccnh4vOt0f/y/PDYZ9Q=;
 b=pAjSNGRfld7xMdAifz41NOAH3uJ1zpCnRQ3cjKEhAlO7ro9sSXnB6UAoiyGchkn0UNNq1Y
 7QlRxn6gL/3XcFS2Revxf08FVk3lCm3jTIez2BEQ5bFwSIve5kmFcOuBYT4qCPEqlpTQEq
 ro0gwCZkutiEJ5O76OWaLdboYeoHNIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133699;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8ETURXN4D66D0HrOGgTSooAccnh4vOt0f/y/PDYZ9Q=;
 b=R4G0+OYeZR6CZ96BoOOrtJO2wrPurCKBGsNqWdPbmKt133VmjlIRP75s0sL7GmIDHkEzXB
 FnjC8j0Exx6s8hCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8ETURXN4D66D0HrOGgTSooAccnh4vOt0f/y/PDYZ9Q=;
 b=l/H28TaVcguBefI1gvC0q6QOl4GqKerB8cxGWHoMUoV0XtMIU6iqW/uXgsYN58kCSKI+Lu
 VQcv7i129HTxRI61D7oiwuBKLHsTekZg5BcHazOsJLZ+T0lxGGE9AFZmk+kXIQ9/XwJIFJ
 T6xRe6zPIsMHYFEdx/oIbpb449GFqOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8ETURXN4D66D0HrOGgTSooAccnh4vOt0f/y/PDYZ9Q=;
 b=mZcPx7RPKyj8CmTomQ5mu2KosRTSxemYKemI3kLT2Pw4zTfiuZGN6/fxRNJff6maTIIeFl
 V0fNJUPplTRQLmCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18EC913A5D;
 Wed, 28 Feb 2024 15:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8PRjNIBP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:21:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v5 03/23] io: Add generic pwritev/preadv interface
Date: Wed, 28 Feb 2024 12:21:07 -0300
Message-Id: <20240228152127.18769-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Nikolay Borisov <nborisov@suse.com>

Introduce basic pwritev/preadv support in the generic channel layer.
Specific implementation will follow for the file channel as this is
required in order to support migration streams with fixed location of
each ram page.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/io/channel.h | 82 ++++++++++++++++++++++++++++++++++++++++++++
 io/channel.c         | 58 +++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index fcb19fd672..7986c49c71 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -131,6 +131,16 @@ struct QIOChannelClass {
                            Error **errp);
 
     /* Optional callbacks */
+    ssize_t (*io_pwritev)(QIOChannel *ioc,
+                          const struct iovec *iov,
+                          size_t niov,
+                          off_t offset,
+                          Error **errp);
+    ssize_t (*io_preadv)(QIOChannel *ioc,
+                         const struct iovec *iov,
+                         size_t niov,
+                         off_t offset,
+                         Error **errp);
     int (*io_shutdown)(QIOChannel *ioc,
                        QIOChannelShutdown how,
                        Error **errp);
@@ -529,6 +539,78 @@ void qio_channel_set_follow_coroutine_ctx(QIOChannel *ioc, bool enabled);
 int qio_channel_close(QIOChannel *ioc,
                       Error **errp);
 
+/**
+ * qio_channel_pwritev
+ * @ioc: the channel object
+ * @iov: the array of memory regions to write data from
+ * @niov: the length of the @iov array
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error. To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ * Behaves as qio_channel_writev_full, apart from not supporting
+ * sending of file handles as well as beginning the write at the
+ * passed @offset
+ *
+ */
+ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
+                            size_t niov, off_t offset, Error **errp);
+
+/**
+ * qio_channel_pwrite
+ * @ioc: the channel object
+ * @buf: the memory region to write data into
+ * @buflen: the number of bytes to @buf
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error. To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ */
+ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
+                           off_t offset, Error **errp);
+
+/**
+ * qio_channel_preadv
+ * @ioc: the channel object
+ * @iov: the array of memory regions to read data into
+ * @niov: the length of the @iov array
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error.  To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ * Behaves as qio_channel_readv_full, apart from not supporting
+ * receiving of file handles as well as beginning the read at the
+ * passed @offset
+ *
+ */
+ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
+                           size_t niov, off_t offset, Error **errp);
+
+/**
+ * qio_channel_pread
+ * @ioc: the channel object
+ * @buf: the memory region to write data into
+ * @buflen: the number of bytes to @buf
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error.  To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ */
+ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
+                          off_t offset, Error **errp);
+
 /**
  * qio_channel_shutdown:
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index 86c5834510..a1f12f8e90 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -454,6 +454,64 @@ GSource *qio_channel_add_watch_source(QIOChannel *ioc,
 }
 
 
+ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
+                            size_t niov, off_t offset, Error **errp)
+{
+    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+
+    if (!klass->io_pwritev) {
+        error_setg(errp, "Channel does not support pwritev");
+        return -1;
+    }
+
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_SEEKABLE)) {
+        error_setg_errno(errp, EINVAL, "Requested channel is not seekable");
+        return -1;
+    }
+
+    return klass->io_pwritev(ioc, iov, niov, offset, errp);
+}
+
+ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
+                           off_t offset, Error **errp)
+{
+    struct iovec iov = {
+        .iov_base = buf,
+        .iov_len = buflen
+    };
+
+    return qio_channel_pwritev(ioc, &iov, 1, offset, errp);
+}
+
+ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
+                           size_t niov, off_t offset, Error **errp)
+{
+    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+
+    if (!klass->io_preadv) {
+        error_setg(errp, "Channel does not support preadv");
+        return -1;
+    }
+
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_SEEKABLE)) {
+        error_setg_errno(errp, EINVAL, "Requested channel is not seekable");
+        return -1;
+    }
+
+    return klass->io_preadv(ioc, iov, niov, offset, errp);
+}
+
+ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
+                          off_t offset, Error **errp)
+{
+    struct iovec iov = {
+        .iov_base = buf,
+        .iov_len = buflen
+    };
+
+    return qio_channel_preadv(ioc, &iov, 1, offset, errp);
+}
+
 int qio_channel_shutdown(QIOChannel *ioc,
                          QIOChannelShutdown how,
                          Error **errp)
-- 
2.35.3


