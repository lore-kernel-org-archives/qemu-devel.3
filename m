Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD29CC48285
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUYL-0006Ub-HN; Fri, 26 Jan 2024 17:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYJ-0006To-Mb
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:19:59 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYH-000255-U6
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:19:59 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E53521E8C;
 Fri, 26 Jan 2024 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weoGmuMmeEmjz6+XoAkNw0Ykac9ldZ1plj3K+C6V79Q=;
 b=2Nap9DlCSpyUpcNtA890L+XDR5Ktksqu0VPpRmqHim0oWxaPKa9Nes7VkqUbTREnUj7hbM
 KVD1LT0L3H3y19nHoh1X655HkLDkOQSdFdWhDsQBMr8n50nq7eTK9zKixvZhgdb1itQbP4
 88Tln+hlBfhsZckrY5rGWVkuKxia8gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weoGmuMmeEmjz6+XoAkNw0Ykac9ldZ1plj3K+C6V79Q=;
 b=zRygeCR+4xTGuJ82nKK5yhIPFUhJXKk3a6dtt8Jn6jgmVdt52OBb9egrum3d0T5OZTYRH2
 /BShtXY/h8Pmq9Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weoGmuMmeEmjz6+XoAkNw0Ykac9ldZ1plj3K+C6V79Q=;
 b=2Nap9DlCSpyUpcNtA890L+XDR5Ktksqu0VPpRmqHim0oWxaPKa9Nes7VkqUbTREnUj7hbM
 KVD1LT0L3H3y19nHoh1X655HkLDkOQSdFdWhDsQBMr8n50nq7eTK9zKixvZhgdb1itQbP4
 88Tln+hlBfhsZckrY5rGWVkuKxia8gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weoGmuMmeEmjz6+XoAkNw0Ykac9ldZ1plj3K+C6V79Q=;
 b=zRygeCR+4xTGuJ82nKK5yhIPFUhJXKk3a6dtt8Jn6jgmVdt52OBb9egrum3d0T5OZTYRH2
 /BShtXY/h8Pmq9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E2113A22;
 Fri, 26 Jan 2024 22:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CHcTIgowtGWScwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Jan 2024 22:19:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>,
 Yuan Liu <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH 4/5] migration/multifd: Simplify zero copy send
Date: Fri, 26 Jan 2024 19:19:42 -0300
Message-Id: <20240126221943.26628-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240126221943.26628-1-farosas@suse.de>
References: <20240126221943.26628-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2Nap9DlC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zRygeCR+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 5E53521E8C
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

During the multifd send phase, the multifd packet header is included
as the first element of the iovec, except in the special case of a
socket migration with zero copy enabled. In that case the packet
header is sent separately. To avoid the first position of the iovec
being empty, we play with the p->iovs_num value to make sure
send_prepare() fills the iovec from the correct position depending on
whether the header is at the first position or not.

This is confusing at first sight and could be made simpler if we
always put the header at the first position in the iovec and advance
the iovec pointer when sending with zero copy. That way we can keep
that logic restricted to the socket code.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zlib.c |  3 ---
 migration/multifd-zstd.c |  3 ---
 migration/multifd.c      | 11 +++++------
 migration/socket.c       | 19 +++++++++++--------
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 0859efa60f..af6ef96670 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -176,9 +176,6 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
 
 static int zlib_send(MultiFDSendParams *p, Error **errp)
 {
-    p->iov[0].iov_len = p->packet_len;
-    p->iov[0].iov_base = p->packet;
-
     return qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
                                        0, p->write_flags, errp);
 }
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index ca0fc79fdd..6d533eaa54 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -165,9 +165,6 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
 
 static int zstd_send(MultiFDSendParams *p, Error **errp)
 {
-    p->iov[0].iov_len = p->packet_len;
-    p->iov[0].iov_base = p->packet;
-
     return qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
                                        0, p->write_flags, errp);
 }
diff --git a/migration/multifd.c b/migration/multifd.c
index 9f509699c2..358a4dbf8f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -171,6 +171,9 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
 
         packet->offset[i] = cpu_to_be64(temp);
     }
+
+    p->iov[0].iov_len = p->packet_len;
+    p->iov[0].iov_base = p->packet;
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -546,7 +549,6 @@ static void *multifd_send_thread(void *opaque)
     MigrationThread *thread = NULL;
     Error *local_err = NULL;
     int ret = 0;
-    bool use_zero_copy_send = migrate_zero_copy_send();
 
     thread = migration_threads_add(p->name, qemu_get_thread_id());
 
@@ -574,11 +576,8 @@ static void *multifd_send_thread(void *opaque)
             uint32_t flags;
             p->normal_num = 0;
 
-            if (use_zero_copy_send) {
-                p->iovs_num = 0;
-            } else {
-                p->iovs_num = 1;
-            }
+            /* The header is always added to the vector */
+            p->iovs_num = 1;
 
             for (int i = 0; i < p->pages->num; i++) {
                 p->normal[p->normal_num] = p->pages->offset[i];
diff --git a/migration/socket.c b/migration/socket.c
index 608f30975e..af22ff7cc4 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -16,6 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/iov.h"
 #include "exec/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -230,22 +231,24 @@ static int multifd_socket_send_prepare(MultiFDSendParams *p, Error **errp)
 
 static int multifd_socket_send(MultiFDSendParams *p, Error **errp)
 {
+    struct iovec *iov = p->iov;
     int ret;
 
     if (migrate_zero_copy_send()) {
-        /* Send header first, without zerocopy */
-        ret = qio_channel_write_all(p->c, (void *)p->packet, p->packet_len,
-                                    errp);
+        /*
+         * The first iovec element is always the header. Sent it first
+         * without zerocopy.
+         */
+        ret = qio_channel_writev_all(p->c, iov, 1, errp);
         if (ret) {
             return ret;
         }
-    } else {
-        /* Send header using the same writev call */
-        p->iov[0].iov_len = p->packet_len;
-        p->iov[0].iov_base = p->packet;
+
+        /* header sent, discard it */
+        iov_discard_front(&iov, &p->iovs_num, iov[0].iov_len);
     }
 
-    return qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
+    return qio_channel_writev_full_all(p->c, iov, p->iovs_num, NULL,
                                        0, p->write_flags, errp);
 }
 
-- 
2.35.3


