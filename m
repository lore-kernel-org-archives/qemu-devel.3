Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07909C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoV-0003BH-G8; Tue, 20 Feb 2024 17:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoM-00033V-9q
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:02 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoK-0006Jz-Fx
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:02 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AD0622260;
 Tue, 20 Feb 2024 22:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8ETURXN4D66D0HrOGgTSooAccnh4vOt0f/y/PDYZ9Q=;
 b=GqoGqajP0rsr0wHxU6KRCTqedFBj5HT+idQNmE2RyaJIpjwTEVKmJ5s8eNzp+qrK7ukP2M
 lFY4oA8HGZmFMwXp+rN2/FckuKKMfv+JaHJI+mdJYKdyAfp2Topnkj3dgIjhx78IJF9Gbs
 QPxwOGrd8Taqfdl3CxF42ys0vlMCJJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8ETURXN4D66D0HrOGgTSooAccnh4vOt0f/y/PDYZ9Q=;
 b=mGr17hZPRwP8dlkELO3/1xnyipTzMAX9JWjEh2+tAV9XB/Q0MVcEUFtjRkegpG0MBam8+5
 SPI4RbaphUKxjdCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8ETURXN4D66D0HrOGgTSooAccnh4vOt0f/y/PDYZ9Q=;
 b=GqoGqajP0rsr0wHxU6KRCTqedFBj5HT+idQNmE2RyaJIpjwTEVKmJ5s8eNzp+qrK7ukP2M
 lFY4oA8HGZmFMwXp+rN2/FckuKKMfv+JaHJI+mdJYKdyAfp2Topnkj3dgIjhx78IJF9Gbs
 QPxwOGrd8Taqfdl3CxF42ys0vlMCJJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8ETURXN4D66D0HrOGgTSooAccnh4vOt0f/y/PDYZ9Q=;
 b=mGr17hZPRwP8dlkELO3/1xnyipTzMAX9JWjEh2+tAV9XB/Q0MVcEUFtjRkegpG0MBam8+5
 SPI4RbaphUKxjdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53937139D0;
 Tue, 20 Feb 2024 22:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id INv9BrUq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:41:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 07/34] io: Add generic pwritev/preadv interface
Date: Tue, 20 Feb 2024 19:41:11 -0300
Message-Id: <20240220224138.24759-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GqoGqajP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mGr17hZP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 2AD0622260
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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


