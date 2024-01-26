Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B9AC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUYL-0006U4-08; Fri, 26 Jan 2024 17:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYI-0006TI-A8
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:19:58 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYG-00023B-2R
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:19:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4ED071FDB0;
 Fri, 26 Jan 2024 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrXV5ATjzsjMvodtkSPPDSKypd5rXkJOszl8AXD5kUU=;
 b=XhPXSKfoHV5McQImFKmu6TTp1TPkyazk/DIm46JgBemTa/poxusyPaNYcWNv0RRdKvTOAZ
 u/sDSwOyTQE6LQH5GRDjYB16tF6Pu9NCvUwEzOEY24zuaZ1eOjde8L+K/i/vyP5CIzvcv1
 6RLqJ/1DnF2wdJ5RMrY20Z/XLes9o04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrXV5ATjzsjMvodtkSPPDSKypd5rXkJOszl8AXD5kUU=;
 b=iUo+LQTj5MF0UJvK6j2Gm0PMEse1lJLX5YnZbk5i0A03sprXuRXxW+S6gqmP+tGzozOh34
 oWIjxLDGqbXBiNAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrXV5ATjzsjMvodtkSPPDSKypd5rXkJOszl8AXD5kUU=;
 b=XhPXSKfoHV5McQImFKmu6TTp1TPkyazk/DIm46JgBemTa/poxusyPaNYcWNv0RRdKvTOAZ
 u/sDSwOyTQE6LQH5GRDjYB16tF6Pu9NCvUwEzOEY24zuaZ1eOjde8L+K/i/vyP5CIzvcv1
 6RLqJ/1DnF2wdJ5RMrY20Z/XLes9o04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrXV5ATjzsjMvodtkSPPDSKypd5rXkJOszl8AXD5kUU=;
 b=iUo+LQTj5MF0UJvK6j2Gm0PMEse1lJLX5YnZbk5i0A03sprXuRXxW+S6gqmP+tGzozOh34
 oWIjxLDGqbXBiNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF5F013A22;
 Fri, 26 Jan 2024 22:19:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IPKEHQgwtGWScwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Jan 2024 22:19:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>,
 Yuan Liu <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH 3/5] migration/multifd: Add multifd_ops->send
Date: Fri, 26 Jan 2024 19:19:41 -0300
Message-Id: <20240126221943.26628-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240126221943.26628-1-farosas@suse.de>
References: <20240126221943.26628-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
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

The zero page feature is not supported by the compression methods. It
is exclusive to the socket migration. Add a 'send' hook so we can move
that complexity into a multifd_socket_send() function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zlib.c | 10 ++++++++++
 migration/multifd-zstd.c | 10 ++++++++++
 migration/multifd.c      | 18 ++----------------
 migration/multifd.h      |  1 +
 migration/socket.c       | 22 ++++++++++++++++++++++
 5 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index d89163e975..0859efa60f 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -174,6 +174,15 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
     return 0;
 }
 
+static int zlib_send(MultiFDSendParams *p, Error **errp)
+{
+    p->iov[0].iov_len = p->packet_len;
+    p->iov[0].iov_base = p->packet;
+
+    return qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
+                                       0, p->write_flags, errp);
+}
+
 /**
  * zlib_recv_setup: setup receive side
  *
@@ -312,6 +321,7 @@ static MultiFDMethods multifd_zlib_ops = {
     .send_setup = zlib_send_setup,
     .send_cleanup = zlib_send_cleanup,
     .send_prepare = zlib_send_prepare,
+    .send = zlib_send,
     .recv_setup = zlib_recv_setup,
     .recv_cleanup = zlib_recv_cleanup,
     .recv_pages = zlib_recv_pages
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index a90788540e..ca0fc79fdd 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -163,6 +163,15 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
     return 0;
 }
 
+static int zstd_send(MultiFDSendParams *p, Error **errp)
+{
+    p->iov[0].iov_len = p->packet_len;
+    p->iov[0].iov_base = p->packet;
+
+    return qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
+                                       0, p->write_flags, errp);
+}
+
 /**
  * zstd_recv_setup: setup receive side
  *
@@ -303,6 +312,7 @@ static MultiFDMethods multifd_zstd_ops = {
     .send_setup = zstd_send_setup,
     .send_cleanup = zstd_send_cleanup,
     .send_prepare = zstd_send_prepare,
+    .send = zstd_send,
     .recv_setup = zstd_recv_setup,
     .recv_cleanup = zstd_recv_cleanup,
     .recv_pages = zstd_recv_pages
diff --git a/migration/multifd.c b/migration/multifd.c
index d82775ade9..9f509699c2 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -604,22 +604,8 @@ static void *multifd_send_thread(void *opaque)
             trace_multifd_send(p->id, packet_num, p->normal_num, flags,
                                p->next_packet_size);
 
-            if (use_zero_copy_send) {
-                /* Send header first, without zerocopy */
-                ret = qio_channel_write_all(p->c, (void *)p->packet,
-                                            p->packet_len, &local_err);
-                if (ret != 0) {
-                    break;
-                }
-            } else {
-                /* Send header using the same writev call */
-                p->iov[0].iov_len = p->packet_len;
-                p->iov[0].iov_base = p->packet;
-            }
-
-            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
-                                              0, p->write_flags, &local_err);
-            if (ret != 0) {
+            ret = multifd_send_state->ops->send(p, &local_err);
+            if (ret) {
                 break;
             }
 
diff --git a/migration/multifd.h b/migration/multifd.h
index 6261002524..0c4cf2d315 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -196,6 +196,7 @@ typedef struct {
     void (*send_cleanup)(MultiFDSendParams *p, Error **errp);
     /* Prepare the send packet */
     int (*send_prepare)(MultiFDSendParams *p, Error **errp);
+    int (*send)(MultiFDSendParams *p, Error **errp);
     /* Setup for receiving side */
     int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
     /* Cleanup for receiving side */
diff --git a/migration/socket.c b/migration/socket.c
index 7e1371e598..608f30975e 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -228,6 +228,27 @@ static int multifd_socket_send_prepare(MultiFDSendParams *p, Error **errp)
     return 0;
 }
 
+static int multifd_socket_send(MultiFDSendParams *p, Error **errp)
+{
+    int ret;
+
+    if (migrate_zero_copy_send()) {
+        /* Send header first, without zerocopy */
+        ret = qio_channel_write_all(p->c, (void *)p->packet, p->packet_len,
+                                    errp);
+        if (ret) {
+            return ret;
+        }
+    } else {
+        /* Send header using the same writev call */
+        p->iov[0].iov_len = p->packet_len;
+        p->iov[0].iov_base = p->packet;
+    }
+
+    return qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
+                                       0, p->write_flags, errp);
+}
+
 static int multifd_socket_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
     return 0;
@@ -255,6 +276,7 @@ static int multifd_socket_recv_pages(MultiFDRecvParams *p, Error **errp)
 
 MultiFDMethods multifd_socket_ops = {
     .send_setup = multifd_socket_send_setup,
+    .send = multifd_socket_send,
     .send_cleanup = multifd_socket_send_cleanup,
     .send_prepare = multifd_socket_send_prepare,
     .recv_setup = multifd_socket_recv_setup,
-- 
2.35.3


