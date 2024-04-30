Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788CBC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oTG-0007ck-5h; Tue, 30 Apr 2024 10:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1oTD-0007Zk-Cx
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:35 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1oTB-0000DK-JR
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:35 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B30231F7E1;
 Tue, 30 Apr 2024 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714487311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR4PsYLBqiMcIWpbzGk7GF4VXSqRCHlV+CLogrxVL+s=;
 b=pb8i5EqkNXktwrnSlSA7mXYglLCpHnXNpq+lRiEflaBKE0qNvsBPN9ZXV46egakPJ5z3kk
 XD2acEKdg0nk/z4mE+U8RPAp7g8ixS9+Rtkv3otRjukGKnmUT6uwEnC0DqR4krob9iu2n8
 0d5R3xNxcUuSye/RkNb2Gqdr6uvxuHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714487311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR4PsYLBqiMcIWpbzGk7GF4VXSqRCHlV+CLogrxVL+s=;
 b=1Ia+djh2qrn/Pxw/afiPLM0DI2wat0uY/i9w1aSDFot4azHTh5Y8s+ihAV3NK9s/DkPrKa
 //q8H4022lVrRABw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pb8i5Eqk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1Ia+djh2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714487311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR4PsYLBqiMcIWpbzGk7GF4VXSqRCHlV+CLogrxVL+s=;
 b=pb8i5EqkNXktwrnSlSA7mXYglLCpHnXNpq+lRiEflaBKE0qNvsBPN9ZXV46egakPJ5z3kk
 XD2acEKdg0nk/z4mE+U8RPAp7g8ixS9+Rtkv3otRjukGKnmUT6uwEnC0DqR4krob9iu2n8
 0d5R3xNxcUuSye/RkNb2Gqdr6uvxuHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714487311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR4PsYLBqiMcIWpbzGk7GF4VXSqRCHlV+CLogrxVL+s=;
 b=1Ia+djh2qrn/Pxw/afiPLM0DI2wat0uY/i9w1aSDFot4azHTh5Y8s+ihAV3NK9s/DkPrKa
 //q8H4022lVrRABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54DAF133A7;
 Tue, 30 Apr 2024 14:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aBhaBw4AMWZjSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Apr 2024 14:28:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org
Subject: [PATCH v3 6/6] migration: Deprecate fd: for file migration
Date: Tue, 30 Apr 2024 11:27:37 -0300
Message-Id: <20240430142737.29066-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240430142737.29066-1-farosas@suse.de>
References: <20240430142737.29066-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B30231F7E1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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


