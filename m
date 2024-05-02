Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2FFC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 20:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2cy4-000824-5O; Thu, 02 May 2024 16:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2cy3-00081m-1E
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:23:47 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2cy0-0002uy-Ne
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:23:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 519EB21A87;
 Thu,  2 May 2024 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714681423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fp9GPPV4rUXrvqa/pIoS6iQQWdWiRA25k6lJzRDlg0=;
 b=ri1whEQ6NZUWxvsJJ4/SF8/BPhqk3xvZi6LOWyskKARAPo1/fQ6maJEJ9V9rUNKNP/IWvZ
 LAOK0+DSGx5xiPjb+4jZ5Z9wrkplLRp+0lwLK+Ujp5id9lkQmUrS8BtpwIFiECH56gnXZg
 1quS9fkuEu8wK1x5mbgP5frw6Isr6wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714681423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fp9GPPV4rUXrvqa/pIoS6iQQWdWiRA25k6lJzRDlg0=;
 b=JTt+JbZ3S6TD1olRF+Cvt79JxPQhr9QOsi818WiT4+j+hYaoIOlwycB4ztngWSZ2mAcGL1
 ZHVE1j91UjKHvrBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ri1whEQ6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JTt+JbZ3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714681423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fp9GPPV4rUXrvqa/pIoS6iQQWdWiRA25k6lJzRDlg0=;
 b=ri1whEQ6NZUWxvsJJ4/SF8/BPhqk3xvZi6LOWyskKARAPo1/fQ6maJEJ9V9rUNKNP/IWvZ
 LAOK0+DSGx5xiPjb+4jZ5Z9wrkplLRp+0lwLK+Ujp5id9lkQmUrS8BtpwIFiECH56gnXZg
 1quS9fkuEu8wK1x5mbgP5frw6Isr6wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714681423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fp9GPPV4rUXrvqa/pIoS6iQQWdWiRA25k6lJzRDlg0=;
 b=JTt+JbZ3S6TD1olRF+Cvt79JxPQhr9QOsi818WiT4+j+hYaoIOlwycB4ztngWSZ2mAcGL1
 ZHVE1j91UjKHvrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E5F013957;
 Thu,  2 May 2024 20:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EOd+OU32M2ZZUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 May 2024 20:23:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 12/13] migration: Deprecate fd: for file migration
Date: Thu,  2 May 2024 17:23:15 -0300
Message-Id: <20240502202316.29924-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240502202316.29924-1-farosas@suse.de>
References: <20240502202316.29924-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 519EB21A87
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

The fd: URI can currently trigger two different types of migration, a
TCP migration using sockets and a file migration using a plain
file. This is in conflict with the recently introduced (8.2) QMP
migrate API that takes structured data as JSON-like format. We cannot
keep the same backend for both types of migration because with the new
API the code is more tightly coupled to the type of transport. This
means a TCP migration must use the 'socket' transport and a file
migration must use the 'file' transport.

If we keep allowing fd: when using a file, this creates an issue when
the user converts the old-style (fd:) to the new style ("transport":
"socket") invocation because the file descriptor in question has
previously been allowed to be either a plain file or a socket.

To avoid creating too much confusion, we can simply deprecate the fd:
+ file usage, which is thought to be rarely used currently and instead
establish a 1:1 correspondence between fd: URI and socket transport,
and file: URI and file transport.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst | 14 ++++++++++++++
 migration/fd.c            | 12 ++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0fb5c82640..813f7996fe 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -464,3 +464,17 @@ both, older and future versions of QEMU.
 The ``blacklist`` config file option has been renamed to ``block-rpcs``
 (to be in sync with the renaming of the corresponding command line
 option).
+
+Migration
+---------
+
+``fd:`` URI when used for file migration (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``fd:`` URI can currently provide a file descriptor that
+references either a socket or a plain file. These are two different
+types of migration. In order to reduce ambiguity, the ``fd:`` URI
+usage of providing a file descriptor to a plain file has been
+deprecated in favor of explicitly using the ``file:`` URI with the
+file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
+command documentation for details on the ``fdset`` usage.
diff --git a/migration/fd.c b/migration/fd.c
index 449adaa2de..aab5189eac 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -20,6 +20,8 @@
 #include "file.h"
 #include "migration.h"
 #include "monitor/monitor.h"
+#include "qemu/error-report.h"
+#include "qemu/sockets.h"
 #include "io/channel-util.h"
 #include "trace.h"
 
@@ -32,6 +34,11 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
         return;
     }
 
+    if (!fd_is_socket(fd)) {
+        warn_report("fd: migration to a file is deprecated."
+                    " Use file: instead.");
+    }
+
     trace_migration_fd_outgoing(fd);
     ioc = qio_channel_new_fd(fd, errp);
     if (!ioc) {
@@ -61,6 +68,11 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
         return;
     }
 
+    if (!fd_is_socket(fd)) {
+        warn_report("fd: migration to a file is deprecated."
+                    " Use file: instead.");
+    }
+
     trace_migration_fd_incoming(fd);
 
     ioc = qio_channel_new_fd(fd, errp);
-- 
2.35.3


