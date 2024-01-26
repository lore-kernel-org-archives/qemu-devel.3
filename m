Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2580BC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUYK-0006U0-GR; Fri, 26 Jan 2024 17:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYI-0006TJ-AM
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:19:58 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYF-00022y-MD
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:19:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A87D22017;
 Fri, 26 Jan 2024 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WssbIfwyN8IpqDjIcFkWahK+O2mHHBUXXNUIets/U2w=;
 b=FXxXdT+IJNsNlm3odupgH5KsfQzKPi8LtO66Tg+QxnBdVIx9T/s9usQF4SHUrs0fkeSLL+
 pM8m8y5bR/ca/uZ6ufDgPXoEFIk9EjIzbkfdcugWWNzzEm1wZTWgrIWd8p6jkFxUiqTaHJ
 1gary9WIHxrK1uTCeH4CxqgH60tg0XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WssbIfwyN8IpqDjIcFkWahK+O2mHHBUXXNUIets/U2w=;
 b=RzUmbkSsdd4BXbR+8DCe6+4JBxyIv6G6DXviKRtDS3mZbu5UgiO9UuWDEeQyCdHdIod4cQ
 5tPJyfpXlUQBX7BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WssbIfwyN8IpqDjIcFkWahK+O2mHHBUXXNUIets/U2w=;
 b=FXxXdT+IJNsNlm3odupgH5KsfQzKPi8LtO66Tg+QxnBdVIx9T/s9usQF4SHUrs0fkeSLL+
 pM8m8y5bR/ca/uZ6ufDgPXoEFIk9EjIzbkfdcugWWNzzEm1wZTWgrIWd8p6jkFxUiqTaHJ
 1gary9WIHxrK1uTCeH4CxqgH60tg0XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WssbIfwyN8IpqDjIcFkWahK+O2mHHBUXXNUIets/U2w=;
 b=RzUmbkSsdd4BXbR+8DCe6+4JBxyIv6G6DXviKRtDS3mZbu5UgiO9UuWDEeQyCdHdIod4cQ
 5tPJyfpXlUQBX7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E44513A25;
 Fri, 26 Jan 2024 22:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QCxNGQYwtGWScwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Jan 2024 22:19:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>,
 Yuan Liu <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH 2/5] migration/multifd: Move multifd_socket_ops to socket.c
Date: Fri, 26 Jan 2024 19:19:40 -0300
Message-Id: <20240126221943.26628-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240126221943.26628-1-farosas@suse.de>
References: <20240126221943.26628-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FXxXdT+I;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RzUmbkSs
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3A87D22017
X-Spamd-Bar: +
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

Code movement only.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 59 -------------------------------------------
 migration/multifd.h |  2 ++
 migration/socket.c  | 61 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 2968649500..d82775ade9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -45,65 +45,6 @@ typedef struct {
     uint64_t unused2[4];    /* Reserved for future use */
 } __attribute__((packed)) MultiFDInit_t;
 
-static int multifd_socket_send_setup(MultiFDSendParams *p, Error **errp)
-{
-    return 0;
-}
-
-static void multifd_socket_send_cleanup(MultiFDSendParams *p, Error **errp)
-{
-    return;
-}
-
-static int multifd_socket_send_prepare(MultiFDSendParams *p, Error **errp)
-{
-    MultiFDPages_t *pages = p->pages;
-
-    for (int i = 0; i < p->normal_num; i++) {
-        p->iov[p->iovs_num].iov_base = pages->block->host + p->normal[i];
-        p->iov[p->iovs_num].iov_len = p->page_size;
-        p->iovs_num++;
-    }
-
-    p->next_packet_size = p->normal_num * p->page_size;
-    p->flags |= MULTIFD_FLAG_NOCOMP;
-    return 0;
-}
-
-static int multifd_socket_recv_setup(MultiFDRecvParams *p, Error **errp)
-{
-    return 0;
-}
-
-static void multifd_socket_recv_cleanup(MultiFDRecvParams *p)
-{
-}
-
-static int multifd_socket_recv_pages(MultiFDRecvParams *p, Error **errp)
-{
-    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
-
-    if (flags != MULTIFD_FLAG_NOCOMP) {
-        error_setg(errp, "multifd %u: flags received %x flags expected %x",
-                   p->id, flags, MULTIFD_FLAG_NOCOMP);
-        return -1;
-    }
-    for (int i = 0; i < p->normal_num; i++) {
-        p->iov[i].iov_base = p->host + p->normal[i];
-        p->iov[i].iov_len = p->page_size;
-    }
-    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
-}
-
-static MultiFDMethods multifd_socket_ops = {
-    .send_setup = multifd_socket_send_setup,
-    .send_cleanup = multifd_socket_send_cleanup,
-    .send_prepare = multifd_socket_send_prepare,
-    .recv_setup = multifd_socket_recv_setup,
-    .recv_cleanup = multifd_socket_recv_cleanup,
-    .recv_pages = multifd_socket_recv_pages
-};
-
 static MultiFDMethods *multifd_compression_ops[MULTIFD_COMPRESSION__MAX] = {0};
 
 static MultiFDMethods *multifd_get_ops(void)
diff --git a/migration/multifd.h b/migration/multifd.h
index 4630baccd4..6261002524 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -204,6 +204,8 @@ typedef struct {
     int (*recv_pages)(MultiFDRecvParams *p, Error **errp);
 } MultiFDMethods;
 
+extern MultiFDMethods multifd_socket_ops;
+
 void multifd_register_compression(int method, MultiFDMethods *ops);
 
 #endif
diff --git a/migration/socket.c b/migration/socket.c
index 98e3ea1514..7e1371e598 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -16,12 +16,13 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-
+#include "exec/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "channel.h"
 #include "socket.h"
 #include "migration.h"
+#include "multifd.h"
 #include "qemu-file.h"
 #include "io/channel-socket.h"
 #include "io/net-listener.h"
@@ -202,3 +203,61 @@ void socket_start_incoming_migration(SocketAddress *saddr,
     }
 }
 
+static int multifd_socket_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    return 0;
+}
+
+static void multifd_socket_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    return;
+}
+
+static int multifd_socket_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    MultiFDPages_t *pages = p->pages;
+
+    for (int i = 0; i < p->normal_num; i++) {
+        p->iov[p->iovs_num].iov_base = pages->block->host + p->normal[i];
+        p->iov[p->iovs_num].iov_len = p->page_size;
+        p->iovs_num++;
+    }
+
+    p->next_packet_size = p->normal_num * p->page_size;
+    p->flags |= MULTIFD_FLAG_NOCOMP;
+    return 0;
+}
+
+static int multifd_socket_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    return 0;
+}
+
+static void multifd_socket_recv_cleanup(MultiFDRecvParams *p)
+{
+}
+
+static int multifd_socket_recv_pages(MultiFDRecvParams *p, Error **errp)
+{
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+
+    if (flags != MULTIFD_FLAG_NOCOMP) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_NOCOMP);
+        return -1;
+    }
+    for (int i = 0; i < p->normal_num; i++) {
+        p->iov[i].iov_base = p->host + p->normal[i];
+        p->iov[i].iov_len = p->page_size;
+    }
+    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
+}
+
+MultiFDMethods multifd_socket_ops = {
+    .send_setup = multifd_socket_send_setup,
+    .send_cleanup = multifd_socket_send_cleanup,
+    .send_prepare = multifd_socket_send_prepare,
+    .recv_setup = multifd_socket_recv_setup,
+    .recv_cleanup = multifd_socket_recv_cleanup,
+    .recv_pages = multifd_socket_recv_pages
+};
-- 
2.35.3


