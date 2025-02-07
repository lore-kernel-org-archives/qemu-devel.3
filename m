Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF57CC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 19:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgUQd-0003D3-C1; Fri, 07 Feb 2025 14:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgUQa-0003CD-BR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:54:16 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgUQY-0000NI-Bk
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:54:15 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 097411F452;
 Fri,  7 Feb 2025 19:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738958053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRsRX3Mj1GVAMbNt2PVEx+jFR98P0uMWXn3sVIy+E6o=;
 b=eNyliNS72qaaTTzZfGReBsI8e9b6yn3Q7OAxJjZm+VPEqdk0DZrI/U7QeJaD2X/MWJb9Lq
 WFikSUhldhV9zAuiX1sYNgbrg8IcCBDsvXqkUk73JiKjKUY/c299F+cQpQjY/6YOONU+ZU
 CxuTT1eCIdOsqsfp+Ubny55qnOBZZOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738958053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRsRX3Mj1GVAMbNt2PVEx+jFR98P0uMWXn3sVIy+E6o=;
 b=xOqUpMf1hNUkCx1ewHJ5U8khQg+Kdwnv3IlgfDKEMPz9xrrTJ7RL1elkuxpEkRz4vkTUPY
 UeProDptuL/fJQBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eNyliNS7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xOqUpMf1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738958053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRsRX3Mj1GVAMbNt2PVEx+jFR98P0uMWXn3sVIy+E6o=;
 b=eNyliNS72qaaTTzZfGReBsI8e9b6yn3Q7OAxJjZm+VPEqdk0DZrI/U7QeJaD2X/MWJb9Lq
 WFikSUhldhV9zAuiX1sYNgbrg8IcCBDsvXqkUk73JiKjKUY/c299F+cQpQjY/6YOONU+ZU
 CxuTT1eCIdOsqsfp+Ubny55qnOBZZOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738958053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRsRX3Mj1GVAMbNt2PVEx+jFR98P0uMWXn3sVIy+E6o=;
 b=xOqUpMf1hNUkCx1ewHJ5U8khQg+Kdwnv3IlgfDKEMPz9xrrTJ7RL1elkuxpEkRz4vkTUPY
 UeProDptuL/fJQBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D59A913694;
 Fri,  7 Feb 2025 19:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +KgNJOJkpme1GQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 19:54:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [RFC PATCH v3 4/8] io: Add flags argument to
 qio_channel_readv_full_all_eof
Date: Fri,  7 Feb 2025 16:53:55 -0300
Message-Id: <20250207195359.17443-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250207195359.17443-1-farosas@suse.de>
References: <20250207195359.17443-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 097411F452
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

We want to pass flags into qio_channel_tls_readv() but
qio_channel_readv_full_all_eof() doesn't take a flags argument.

No functional change.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/remote/mpqemu-link.c | 2 +-
 include/io/channel.h    | 2 ++
 io/channel.c            | 9 ++++++---
 3 files changed, 9 insertions(+), 4 deletions(-)

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
index bdf0bca92a..58940eead5 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -885,6 +885,7 @@ void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
  * @niov: the length of the @iov array
  * @fds: an array of file handles to read
  * @nfds: number of file handles in @fds
+ * @flags: read flags (QIO_CHANNEL_READ_FLAG_*)
  * @errp: pointer to a NULL-initialized error object
  *
  *
@@ -903,6 +904,7 @@ int coroutine_mixed_fn qio_channel_readv_full_all_eof(QIOChannel *ioc,
                                                       const struct iovec *iov,
                                                       size_t niov,
                                                       int **fds, size_t *nfds,
+                                                      int flags,
                                                       Error **errp);
 
 /**
diff --git a/io/channel.c b/io/channel.c
index e3f17c24a0..ebd9322765 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -115,7 +115,8 @@ int coroutine_mixed_fn qio_channel_readv_all_eof(QIOChannel *ioc,
                                                  size_t niov,
                                                  Error **errp)
 {
-    return qio_channel_readv_full_all_eof(ioc, iov, niov, NULL, NULL, errp);
+    return qio_channel_readv_full_all_eof(ioc, iov, niov, NULL, NULL, 0,
+                                          errp);
 }
 
 int coroutine_mixed_fn qio_channel_readv_all(QIOChannel *ioc,
@@ -130,6 +131,7 @@ int coroutine_mixed_fn qio_channel_readv_full_all_eof(QIOChannel *ioc,
                                                       const struct iovec *iov,
                                                       size_t niov,
                                                       int **fds, size_t *nfds,
+                                                      int flags,
                                                       Error **errp)
 {
     int ret = -1;
@@ -155,7 +157,7 @@ int coroutine_mixed_fn qio_channel_readv_full_all_eof(QIOChannel *ioc,
     while ((nlocal_iov > 0) || local_fds) {
         ssize_t len;
         len = qio_channel_readv_full(ioc, local_iov, nlocal_iov, local_fds,
-                                     local_nfds, 0, errp);
+                                     local_nfds, flags, errp);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
             if (qemu_in_coroutine()) {
                 qio_channel_yield(ioc, G_IO_IN);
@@ -222,7 +224,8 @@ int coroutine_mixed_fn qio_channel_readv_full_all(QIOChannel *ioc,
                                                   int **fds, size_t *nfds,
                                                   Error **errp)
 {
-    int ret = qio_channel_readv_full_all_eof(ioc, iov, niov, fds, nfds, errp);
+    int ret = qio_channel_readv_full_all_eof(ioc, iov, niov, fds, nfds, 0,
+                                             errp);
 
     if (ret == 0) {
         error_setg(errp, "Unexpected end-of-file before all data were read");
-- 
2.35.3


