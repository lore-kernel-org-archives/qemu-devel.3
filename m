Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F42C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 17:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhYpL-0004fk-Op; Tue, 05 Mar 2024 12:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhYpK-0004ex-6k
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:43:42 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhYpI-0004LG-Ae
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:43:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B5AE16BBE6;
 Tue,  5 Mar 2024 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709660616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=10sf+pzvpDFF3nm4+2qVEGkaUvB2zPvR8DHbb6hDMN8=;
 b=EcPVCWL2uchVM6asm9OaLwEYeQMIlJzq0yA+2e9ww+HKMm11RQuiG+lwg8wjgyBA5rCma7
 VSzZ9aMATZsIZcztE1WxnP4PO87rBJN/uJOQgdn487AscozYP5NUond04E+qDYuAyhsZgE
 sh2b2AZ7qQPMrPMc9TSzpU9eYOC3AW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709660616;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=10sf+pzvpDFF3nm4+2qVEGkaUvB2zPvR8DHbb6hDMN8=;
 b=JnXmZboz5a75UdVHe0nHPj44e7xAiI6l9+tnsdn7vvYSTla5aTNYMIzGF+9RYeCEfvPWBz
 haCJ7/OUu+TZepAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709660616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=10sf+pzvpDFF3nm4+2qVEGkaUvB2zPvR8DHbb6hDMN8=;
 b=EcPVCWL2uchVM6asm9OaLwEYeQMIlJzq0yA+2e9ww+HKMm11RQuiG+lwg8wjgyBA5rCma7
 VSzZ9aMATZsIZcztE1WxnP4PO87rBJN/uJOQgdn487AscozYP5NUond04E+qDYuAyhsZgE
 sh2b2AZ7qQPMrPMc9TSzpU9eYOC3AW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709660616;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=10sf+pzvpDFF3nm4+2qVEGkaUvB2zPvR8DHbb6hDMN8=;
 b=JnXmZboz5a75UdVHe0nHPj44e7xAiI6l9+tnsdn7vvYSTla5aTNYMIzGF+9RYeCEfvPWBz
 haCJ7/OUu+TZepAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83B5E13A5B;
 Tue,  5 Mar 2024 17:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kYfEEMdZ52VSEwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Mar 2024 17:43:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	peterx@redhat.com
Subject: [PATCH] migration/multifd: Don't fsync when closing QIOChannelFile
Date: Tue,  5 Mar 2024 14:43:32 -0300
Message-Id: <20240305174332.2553-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EcPVCWL2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JnXmZboz
X-Spamd-Result: default: False [-1.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; DWL_DNSWL_HI(-3.50)[suse.de:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B5AE16BBE6
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

Commit bc38feddeb ("io: fsync before closing a file channel") added a
fsync/fdatasync at the closing point of the QIOChannelFile to ensure
integrity of the migration stream in case of QEMU crash.

The decision to do the sync at qio_channel_close() was not the best
since that function runs in the main thread and the fsync can cause
QEMU to hang for several minutes, depending on the migration size and
disk speed.

To fix the hang, remove the fsync from qio_channel_file_close().

At this moment, the migration code is the only user of the fsync and
we're taking the tradeoff of not having a sync at all, leaving the
responsibility to the upper layers.

Fixes: bc38feddeb ("io: fsync before closing a file channel")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/main.rst |  3 ++-
 io/channel-file.c             |  5 -----
 migration/multifd.c           | 13 -------------
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 8024275d6d..54385a23e5 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -44,7 +44,8 @@ over any transport.
 - file migration: do the migration using a file that is passed to QEMU
   by path. A file offset option is supported to allow a management
   application to add its own metadata to the start of the file without
-  QEMU interference.
+  QEMU interference. Note that QEMU does not flush cached file
+  data/metadata at the end of migration.
 
 In addition, support is included for migration using RDMA, which
 transports the page data using ``RDMA``, where the hardware takes care of
diff --git a/io/channel-file.c b/io/channel-file.c
index d4706fa592..a6ad7770c6 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -242,11 +242,6 @@ static int qio_channel_file_close(QIOChannel *ioc,
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
 
-    if (qemu_fdatasync(fioc->fd) < 0) {
-        error_setg_errno(errp, errno,
-                         "Unable to synchronize file data with storage device");
-        return -1;
-    }
     if (qemu_close(fioc->fd) < 0) {
         error_setg_errno(errp, errno,
                          "Unable to close file");
diff --git a/migration/multifd.c b/migration/multifd.c
index d4a44da559..2edcd5104e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -709,19 +709,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 {
     if (p->c) {
         migration_ioc_unregister_yank(p->c);
-        /*
-         * An explicit close() on the channel here is normally not
-         * required, but can be helpful for "file:" iochannels, where it
-         * will include fdatasync() to make sure the data is flushed to the
-         * disk backend.
-         *
-         * The object_unref() cannot guarantee that because: (1) finalize()
-         * of the iochannel is only triggered on the last reference, and
-         * it's not guaranteed that we always hold the last refcount when
-         * reaching here, and, (2) even if finalize() is invoked, it only
-         * does a close(fd) without data flush.
-         */
-        qio_channel_close(p->c, &error_abort);
         object_unref(OBJECT(p->c));
         p->c = NULL;
     }
-- 
2.35.3


