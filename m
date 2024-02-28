Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D738C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLki-0006Wy-Qd; Wed, 28 Feb 2024 10:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkh-0006Wk-Pv
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:47 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkc-0004t6-Jg
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 398CD225B3;
 Wed, 28 Feb 2024 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZC9GGKiLiOlOghxD2kAzp04A9s2EovQY2cXlVK4HRas=;
 b=deK4rNea71zMKxziEXFJLZLQBiy77wQkqX1Fpg+FKzmFZp9K6/is9Cwpd6o6clO+HOfB+k
 mBgij/yIJV24VgpO5vCSwR3O1UmeY7fmZWACm7+HsjvE6Y6gxNa+muJqqvCh6P9NkCY0Q/
 X7p1w1XSUTOf0U2dJz6rjIaHdkhG110=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZC9GGKiLiOlOghxD2kAzp04A9s2EovQY2cXlVK4HRas=;
 b=4JoRM0s+iyPRbG3GOtDKE9VCw+kicIVCOVOV+HH/wxJACCMvwtTZ9Vy/r+UsJUjhFR6ShE
 g6Rsd7qo7jF22WCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZC9GGKiLiOlOghxD2kAzp04A9s2EovQY2cXlVK4HRas=;
 b=deK4rNea71zMKxziEXFJLZLQBiy77wQkqX1Fpg+FKzmFZp9K6/is9Cwpd6o6clO+HOfB+k
 mBgij/yIJV24VgpO5vCSwR3O1UmeY7fmZWACm7+HsjvE6Y6gxNa+muJqqvCh6P9NkCY0Q/
 X7p1w1XSUTOf0U2dJz6rjIaHdkhG110=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZC9GGKiLiOlOghxD2kAzp04A9s2EovQY2cXlVK4HRas=;
 b=4JoRM0s+iyPRbG3GOtDKE9VCw+kicIVCOVOV+HH/wxJACCMvwtTZ9Vy/r+UsJUjhFR6ShE
 g6Rsd7qo7jF22WCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 625C213A5D;
 Wed, 28 Feb 2024 15:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oIiVCoNP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:21:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v5 04/23] io: implement io_pwritev/preadv for QIOChannelFile
Date: Wed, 28 Feb 2024 12:21:08 -0300
Message-Id: <20240228152127.18769-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=deK4rNea;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4JoRM0s+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.33 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.82)[99.21%]
X-Rspamd-Queue-Id: 398CD225B3
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

The upcoming 'mapped-ram' feature will require qemu to write data to
(and restore from) specific offsets of the migration file.

Add a minimal implementation of pwritev/preadv and expose them via the
io_pwritev and io_preadv interfaces.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 io/channel-file.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/io/channel-file.c b/io/channel-file.c
index f91bf6db1c..a6ad7770c6 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -146,6 +146,58 @@ static ssize_t qio_channel_file_writev(QIOChannel *ioc,
     return ret;
 }
 
+#ifdef CONFIG_PREADV
+static ssize_t qio_channel_file_preadv(QIOChannel *ioc,
+                                       const struct iovec *iov,
+                                       size_t niov,
+                                       off_t offset,
+                                       Error **errp)
+{
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
+    ssize_t ret;
+
+ retry:
+    ret = preadv(fioc->fd, iov, niov, offset);
+    if (ret < 0) {
+        if (errno == EAGAIN) {
+            return QIO_CHANNEL_ERR_BLOCK;
+        }
+        if (errno == EINTR) {
+            goto retry;
+        }
+
+        error_setg_errno(errp, errno, "Unable to read from file");
+        return -1;
+    }
+
+    return ret;
+}
+
+static ssize_t qio_channel_file_pwritev(QIOChannel *ioc,
+                                        const struct iovec *iov,
+                                        size_t niov,
+                                        off_t offset,
+                                        Error **errp)
+{
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
+    ssize_t ret;
+
+ retry:
+    ret = pwritev(fioc->fd, iov, niov, offset);
+    if (ret <= 0) {
+        if (errno == EAGAIN) {
+            return QIO_CHANNEL_ERR_BLOCK;
+        }
+        if (errno == EINTR) {
+            goto retry;
+        }
+        error_setg_errno(errp, errno, "Unable to write to file");
+        return -1;
+    }
+    return ret;
+}
+#endif /* CONFIG_PREADV */
+
 static int qio_channel_file_set_blocking(QIOChannel *ioc,
                                          bool enabled,
                                          Error **errp)
@@ -231,6 +283,10 @@ static void qio_channel_file_class_init(ObjectClass *klass,
     ioc_klass->io_writev = qio_channel_file_writev;
     ioc_klass->io_readv = qio_channel_file_readv;
     ioc_klass->io_set_blocking = qio_channel_file_set_blocking;
+#ifdef CONFIG_PREADV
+    ioc_klass->io_pwritev = qio_channel_file_pwritev;
+    ioc_klass->io_preadv = qio_channel_file_preadv;
+#endif
     ioc_klass->io_seek = qio_channel_file_seek;
     ioc_klass->io_close = qio_channel_file_close;
     ioc_klass->io_create_watch = qio_channel_file_create_watch;
-- 
2.35.3


