Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D76C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpc-0003B0-3v; Wed, 08 May 2024 19:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpX-0002tm-Eq
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:36:11 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpU-0002TL-Ge
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:36:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35AD15D392;
 Wed,  8 May 2024 23:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bu8KuEGO9tZwmVBqA8ncjfkgnv45Vf4NF85Yzr2wLdo=;
 b=sE0J0NvgWCWTzdH2FZFYWeq4X7JbMla58eS8l2+xQXTclrQBpNWPkdiwB4DXFfD1u7izJE
 BeZTffT40VBcHqYA3QLDrbrOifjBNzzYO6Zp97MhuDEs1b6r3XlfWj0DVm3V+GVqo74KIt
 PfJoKCzPrZiQ8CztSypfOWTUQHxBLC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bu8KuEGO9tZwmVBqA8ncjfkgnv45Vf4NF85Yzr2wLdo=;
 b=oWg6dsCzy6tSKHia1FN9B3nHCGTZ97iYmDXPc8zDks4BnwdYiCzajgstMCaZk4snCcSA7M
 8Yn1LZLB3hrRbbDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bu8KuEGO9tZwmVBqA8ncjfkgnv45Vf4NF85Yzr2wLdo=;
 b=sE0J0NvgWCWTzdH2FZFYWeq4X7JbMla58eS8l2+xQXTclrQBpNWPkdiwB4DXFfD1u7izJE
 BeZTffT40VBcHqYA3QLDrbrOifjBNzzYO6Zp97MhuDEs1b6r3XlfWj0DVm3V+GVqo74KIt
 PfJoKCzPrZiQ8CztSypfOWTUQHxBLC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bu8KuEGO9tZwmVBqA8ncjfkgnv45Vf4NF85Yzr2wLdo=;
 b=oWg6dsCzy6tSKHia1FN9B3nHCGTZ97iYmDXPc8zDks4BnwdYiCzajgstMCaZk4snCcSA7M
 8Yn1LZLB3hrRbbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1048113A27;
 Wed,  8 May 2024 23:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MAU0MmUMPGZ7FQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 May 2024 23:36:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 12/13] migration: Deprecate fd: for file migration
Date: Wed,  8 May 2024 20:35:40 -0300
Message-Id: <20240508233541.2403-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508233541.2403-1-farosas@suse.de>
References: <20240508233541.2403-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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
index 64b8f838be..f5f111495b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -473,3 +473,17 @@ both, older and future versions of QEMU.
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


