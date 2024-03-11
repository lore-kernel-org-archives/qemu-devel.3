Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF6BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 23:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjp9u-0007y7-Ef; Mon, 11 Mar 2024 19:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjp9p-0007xm-I3
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 19:34:14 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjp9n-0003MN-UB
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 19:34:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B694D5CD44;
 Mon, 11 Mar 2024 23:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710200048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDPRMrNkuLByuTPoBFeGZ6rQXVXqUChcsg87De8wo7I=;
 b=F62hWxjc5y6/Nxi9rqoN2vvVuCcN7ynnxeuCnpZwUzEPzhR1coz0cbC1ywKQwc8nEmI3ef
 PmyR5Ui4mSAUNsFdIUCzfvTFaV4TLFJalU/SHIqRNzZ34QWZNJ1cjYAAAZ2AFgMdY2G5g7
 nkjZGl4YJXMiaDZOu/NqrW6/1xUe5fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710200048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDPRMrNkuLByuTPoBFeGZ6rQXVXqUChcsg87De8wo7I=;
 b=l+i66OJq+zPpGAnagwB2WLN2yHfHksiP4UIctMDK45gMegOMHBGIo6UPx44Qi5utyCDJ9b
 Ta4ZZaoZQITpf9CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710200048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDPRMrNkuLByuTPoBFeGZ6rQXVXqUChcsg87De8wo7I=;
 b=F62hWxjc5y6/Nxi9rqoN2vvVuCcN7ynnxeuCnpZwUzEPzhR1coz0cbC1ywKQwc8nEmI3ef
 PmyR5Ui4mSAUNsFdIUCzfvTFaV4TLFJalU/SHIqRNzZ34QWZNJ1cjYAAAZ2AFgMdY2G5g7
 nkjZGl4YJXMiaDZOu/NqrW6/1xUe5fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710200048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDPRMrNkuLByuTPoBFeGZ6rQXVXqUChcsg87De8wo7I=;
 b=l+i66OJq+zPpGAnagwB2WLN2yHfHksiP4UIctMDK45gMegOMHBGIo6UPx44Qi5utyCDJ9b
 Ta4ZZaoZQITpf9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0D3B13695;
 Mon, 11 Mar 2024 23:34:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IIG9KO6U72VSEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Mar 2024 23:34:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/2] io: Introduce qio_channel_file_new_dupfd
Date: Mon, 11 Mar 2024 20:33:34 -0300
Message-Id: <20240311233335.17299-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240311233335.17299-1-farosas@suse.de>
References: <20240311233335.17299-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.87 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.57)[92.20%]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Add a new helper function for creating a QIOChannelFile channel with a
duplicated file descriptor. This saves the calling code from having to
do error checking on the dup() call.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/io/channel-file.h | 18 ++++++++++++++++++
 io/channel-file.c         | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index 50e8eb1138..d373a4e44d 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -68,6 +68,24 @@ struct QIOChannelFile {
 QIOChannelFile *
 qio_channel_file_new_fd(int fd);
 
+/**
+ * qio_channel_file_new_dupfd:
+ * @fd: the file descriptor
+ * @errp: pointer to initialized error object
+ *
+ * Create a new IO channel object for a file represented by the @fd
+ * parameter. Like qio_channel_file_new_fd(), but the @fd is first
+ * duplicated with dup().
+ *
+ * The channel will own the duplicated file descriptor and will take
+ * responsibility for closing it, the original FD is owned by the
+ * caller.
+ *
+ * Returns: the new channel object
+ */
+QIOChannelFile *
+qio_channel_file_new_dupfd(int fd, Error **errp);
+
 /**
  * qio_channel_file_new_path:
  * @path: the file path
diff --git a/io/channel-file.c b/io/channel-file.c
index d4706fa592..cbdd03bf21 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -45,6 +45,18 @@ qio_channel_file_new_fd(int fd)
     return ioc;
 }
 
+QIOChannelFile *
+qio_channel_file_new_dupfd(int fd, Error **errp)
+{
+    int newfd = dup(fd);
+
+    if (newfd < 0) {
+        error_setg_errno(errp, errno, "Could not dup FD %d", fd);
+        return NULL;
+    }
+
+    return qio_channel_file_new_fd(newfd);
+}
 
 QIOChannelFile *
 qio_channel_file_new_path(const char *path,
-- 
2.35.3


