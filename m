Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225A7C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 03:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rky8C-00040E-Au; Thu, 14 Mar 2024 23:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rky7z-0003zG-Ru
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:21:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rky7m-0004IN-5K
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:21:03 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BBF1F21D93;
 Fri, 15 Mar 2024 03:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710472847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmlLzyqrfZPWaaTdawgpYY7pzIQgR8FqjE/xWFU8Qe4=;
 b=Ai/PQL6A0pAi7IIH3Sc59ZdcwbRjYj6I5RCHeIbvg0zFeoSlqqPrm8RuTQxB1xvLDMqKyz
 Q9c0SkxdRPeLtA17SXZuAG41JahnZD2kpfrY+vrEmR54mjTJqbO6X7uSarM7e5ZOYOYuu9
 0PXCPuOGuUU68xoIPvmmfJVKyOWoxPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710472847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmlLzyqrfZPWaaTdawgpYY7pzIQgR8FqjE/xWFU8Qe4=;
 b=T3cMslVqCvI/jlPvJTigwKJxuWDultsQWdUXdmRn+i5ASknwMkZICF1n+jFSrKtbWq6vyY
 yn4i718xAksTKTAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710472847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmlLzyqrfZPWaaTdawgpYY7pzIQgR8FqjE/xWFU8Qe4=;
 b=Ai/PQL6A0pAi7IIH3Sc59ZdcwbRjYj6I5RCHeIbvg0zFeoSlqqPrm8RuTQxB1xvLDMqKyz
 Q9c0SkxdRPeLtA17SXZuAG41JahnZD2kpfrY+vrEmR54mjTJqbO6X7uSarM7e5ZOYOYuu9
 0PXCPuOGuUU68xoIPvmmfJVKyOWoxPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710472847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmlLzyqrfZPWaaTdawgpYY7pzIQgR8FqjE/xWFU8Qe4=;
 b=T3cMslVqCvI/jlPvJTigwKJxuWDultsQWdUXdmRn+i5ASknwMkZICF1n+jFSrKtbWq6vyY
 yn4i718xAksTKTAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9515D1368C;
 Fri, 15 Mar 2024 03:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oKMEF46+82XZcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Mar 2024 03:20:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 2/3] migration/multifd: Duplicate the fd for the
 outgoing_args
Date: Fri, 15 Mar 2024 00:20:39 -0300
Message-Id: <20240315032040.7974-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240315032040.7974-1-farosas@suse.de>
References: <20240315032040.7974-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Ai/PQL6A";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T3cMslVq
X-Spamd-Result: default: False [3.03 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.46)[79.08%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BBF1F21D93
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We currently store the file descriptor used during the main outgoing
channel creation to use it again when creating the multifd
channels.

Since this fd is used for the first iochannel, there's risk that the
QIOChannel gets freed and the fd closed while outgoing_args.fd still
has it available. This could lead to an fd-reuse bug.

Duplicate the outgoing_args fd to avoid this issue.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/fd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index c07030f715..fe0d096abd 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -49,8 +49,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
 {
     QIOChannel *ioc;
     int fd = monitor_get_fd(monitor_cur(), fdname, errp);
-
-    outgoing_args.fd = -1;
+    int newfd;
 
     if (fd == -1) {
         return;
@@ -63,7 +62,17 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
         return;
     }
 
-    outgoing_args.fd = fd;
+    /*
+     * This is dup()ed just to avoid referencing an fd that might
+     * be already closed by the iochannel.
+     */
+    newfd = dup(fd);
+    if (newfd == -1) {
+        error_setg_errno(errp, errno, "Could not dup FD %d", fd);
+        object_unref(ioc);
+        return;
+    }
+    outgoing_args.fd = newfd;
 
     qio_channel_set_name(ioc, "migration-fd-outgoing");
     migration_channel_connect(s, ioc, NULL, NULL);
-- 
2.35.3


