Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C54AC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADmQ-0003Ff-AA; Thu, 23 May 2024 15:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlu-0002GY-5h
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlq-0004KZ-Ua
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 882DE20410;
 Thu, 23 May 2024 19:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vl2VTZZ7htmokSj3DhF+Hd+04nY+uwgKE6y9zGEpmro=;
 b=SKqit/j3lG+8BaKprymQ99mprirziwP2Kal5VikfXG5957aT+1BEx8efYzaAt3dirmLNaU
 FT2m8zTgBtdWdhxw4FaC3JwFBkzx2GSC8xp5FTUFPEDNXepRONAm6orY7Aj7gCXXNMapdr
 zBN9nRFOOd89Smen8+K4AlIj5wKeE9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vl2VTZZ7htmokSj3DhF+Hd+04nY+uwgKE6y9zGEpmro=;
 b=9NOZV9IvsJdEGJbF0v2c4WgQVUg3Z7r3WX6UCgCV3XpfYg1zJ2Qr3H+aR6N9Hs+HifM6jp
 gmT3QsiD2Z42U4DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="SKqit/j3";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9NOZV9Iv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vl2VTZZ7htmokSj3DhF+Hd+04nY+uwgKE6y9zGEpmro=;
 b=SKqit/j3lG+8BaKprymQ99mprirziwP2Kal5VikfXG5957aT+1BEx8efYzaAt3dirmLNaU
 FT2m8zTgBtdWdhxw4FaC3JwFBkzx2GSC8xp5FTUFPEDNXepRONAm6orY7Aj7gCXXNMapdr
 zBN9nRFOOd89Smen8+K4AlIj5wKeE9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vl2VTZZ7htmokSj3DhF+Hd+04nY+uwgKE6y9zGEpmro=;
 b=9NOZV9IvsJdEGJbF0v2c4WgQVUg3Z7r3WX6UCgCV3XpfYg1zJ2Qr3H+aR6N9Hs+HifM6jp
 gmT3QsiD2Z42U4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B004F13A6B;
 Thu, 23 May 2024 19:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MOKiHbeTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v2 16/18] io/channel-file: Add direct-io support
Date: Thu, 23 May 2024 16:05:46 -0300
Message-Id: <20240523190548.23977-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 882DE20410
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Add support for setting/clearing the O_DIRECT flag on a file
descriptor. This will be used for enabling O_DIRECT in the main
migration channel when multifd is not in use.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/io/channel-file.h |  8 ++++++++
 io/channel-file.c         | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index d373a4e44d..ecb4450e8e 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -107,4 +107,12 @@ qio_channel_file_new_path(const char *path,
                           mode_t mode,
                           Error **errp);
 
+/**
+ * qio_channel_file_set_direct_io:
+ * @ioc: the QIOChannel object
+ * @enabled: the desired state of the O_DIRECT flag
+ * @errp: pointer to initialized error object
+ */
+void qio_channel_file_set_direct_io(QIOChannel *ioc, bool enabled,
+                                    Error **errp);
 #endif /* QIO_CHANNEL_FILE_H */
diff --git a/io/channel-file.c b/io/channel-file.c
index 2ea8d08360..a89cd3a6d5 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -231,6 +231,31 @@ static int qio_channel_file_set_blocking(QIOChannel *ioc,
 #endif
 }
 
+void qio_channel_file_set_direct_io(QIOChannel *ioc, bool enabled, Error **errp)
+{
+#ifdef O_DIRECT
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
+    int flags = fcntl(fioc->fd, F_GETFL);
+
+    if (flags == -1) {
+        error_setg_errno(errp, errno, "Unable to read file descriptor flags");
+        return;
+    }
+
+    if (enabled) {
+        flags |= O_DIRECT;
+    } else {
+        flags &= ~O_DIRECT;
+    }
+
+    if (fcntl(fioc->fd, F_SETFL, flags) == -1) {
+        error_setg_errno(errp, errno, "Unable to set file descriptor flags");
+        return;
+    }
+#else
+    error_setg(errp, "System does not support O_DIRECT");
+#endif
+}
 
 static off_t qio_channel_file_seek(QIOChannel *ioc,
                                    off_t offset,
-- 
2.35.3


