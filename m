Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13834C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiMn-0005VV-Pw; Thu, 29 Feb 2024 10:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiMm-0005Uf-1Y
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:30:36 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiMk-0005vv-JP
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:30:35 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 03E4A1F7F7;
 Thu, 29 Feb 2024 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yei0QUkdknw0DkZwKKRyp+HpBHZX5C0CfiFOhKXCH40=;
 b=Ah1Gc1XPcuudv9QtDbr5LydolnwNaBgpfMC3XtGiA+E4fPxeUve3ZlPHeinnRz/1Ig/uz4
 YNAFIQEaPKq3Nggkzpjryf1u/em6kA+PswkVfFpn23d9HwmQHYAAHrEwLws4O2G7ztHYOv
 mpvj8MrjzcPwwjzNIrNmtWcMgBp9PPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yei0QUkdknw0DkZwKKRyp+HpBHZX5C0CfiFOhKXCH40=;
 b=wFg8q6JTaccfRwdUCppOxs0PngkEE7mWMhfgCITIOdZFo/bpRz9nZLxWUvee5UoV+SE4D0
 NUZyAbYwFGfT3EDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yei0QUkdknw0DkZwKKRyp+HpBHZX5C0CfiFOhKXCH40=;
 b=Ah1Gc1XPcuudv9QtDbr5LydolnwNaBgpfMC3XtGiA+E4fPxeUve3ZlPHeinnRz/1Ig/uz4
 YNAFIQEaPKq3Nggkzpjryf1u/em6kA+PswkVfFpn23d9HwmQHYAAHrEwLws4O2G7ztHYOv
 mpvj8MrjzcPwwjzNIrNmtWcMgBp9PPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yei0QUkdknw0DkZwKKRyp+HpBHZX5C0CfiFOhKXCH40=;
 b=wFg8q6JTaccfRwdUCppOxs0PngkEE7mWMhfgCITIOdZFo/bpRz9nZLxWUvee5UoV+SE4D0
 NUZyAbYwFGfT3EDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 600F113503;
 Thu, 29 Feb 2024 15:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aOsQChej4GU/MAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 15:30:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v6 05/23] io: fsync before closing a file channel
Date: Thu, 29 Feb 2024 12:29:59 -0300
Message-Id: <20240229153017.2221-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240229153017.2221-1-farosas@suse.de>
References: <20240229153017.2221-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.47 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.17)[96.01%]
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

Make sure the data is flushed to disk before closing file
channels. This is to ensure data is on disk and not lost in the event
of a host crash.

This is currently being implemented to affect the migration code when
migrating to a file, but all QIOChannelFile users should benefit from
the change.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 io/channel-file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io/channel-file.c b/io/channel-file.c
index a6ad7770c6..d4706fa592 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -242,6 +242,11 @@ static int qio_channel_file_close(QIOChannel *ioc,
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
 
+    if (qemu_fdatasync(fioc->fd) < 0) {
+        error_setg_errno(errp, errno,
+                         "Unable to synchronize file data with storage device");
+        return -1;
+    }
     if (qemu_close(fioc->fd) < 0) {
         error_setg_errno(errp, errno,
                          "Unable to close file");
-- 
2.35.3


