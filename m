Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF726C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUYM-0006VO-G8; Fri, 26 Jan 2024 17:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYI-0006TH-AE
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:19:58 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYF-00022o-JW
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:19:58 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A03C21E19;
 Fri, 26 Jan 2024 22:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLj0d2ggXJhET2C/cGBlDaztn6eBWzQ6qnAVThFbbgU=;
 b=zEzPqECrNw2vT5RHltnvvSF/fd9GrVhwRXQFiKNez7kGDa9komtSo9wG7+P0/asCtiHI8S
 9lkPlQ4BZ2YsrJejumQvwE/2XPIV/mLrJ+FKr/1RHo9RJ94H5aqOPXtkpqcO/PVT1ukWDC
 g51FVWR6xlCai0Ms2rko0Sp0+cGEDXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLj0d2ggXJhET2C/cGBlDaztn6eBWzQ6qnAVThFbbgU=;
 b=behNosajZdoU4IdulD2U/i7t0VlIKPy6tprwTztuotrILKQE2YmlWby5UettUHAvD8ZDyZ
 8Vh+7OJwVx/FiUDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLj0d2ggXJhET2C/cGBlDaztn6eBWzQ6qnAVThFbbgU=;
 b=YfZEIj3Tn8VrYR+KLJsiXwkija3HbcaauGJFhKPBLcj//+5eDQToZb1Vjz9/qrSzyb2taF
 5TpKVv9SJvQxBYZGgu3Y+ht59NdrcTnWImfMU2yRWKF34aFi1xr0XEvIXqigQ1trklJTOQ
 3DDvOTcU0ZiDU5gDv6JAvcXOmC3DBsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLj0d2ggXJhET2C/cGBlDaztn6eBWzQ6qnAVThFbbgU=;
 b=cwSelqHCuyasE+bx7Z3ZqTuzAdARlxcdAdw0Nln+fPI8Zc5/c1+Rg5O8AId6mozz63pBF6
 noN87pzkDZr8DpBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A81513A22;
 Fri, 26 Jan 2024 22:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uGFKFAQwtGWScwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Jan 2024 22:19:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>,
 Yuan Liu <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH 1/5] migration/multifd: Separate compression ops from
 non-compression
Date: Fri, 26 Jan 2024 19:19:39 -0300
Message-Id: <20240126221943.26628-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240126221943.26628-1-farosas@suse.de>
References: <20240126221943.26628-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
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

For multifd we currently choose exclusively between migration using
compression or migration without compression. The compression method
is chosen via the multifd_compression parameter (none, zlib,
zstd). We've been using the 'none' value to mean the regular socket
migration.

Rename the 'multifd_ops' array to 'multifd_compression_ops' and move
the 'nocomp_multifd_ops' out of it. We don't need to have the
non-compression methods in an array because they are not registered
dynamically and cannot be compiled out like the compression code.

Rename the 'nocomp' functions to 'multifd_socket' and remove the
comments which are useless IMHO. Next patch moves the functions into a
socket specific file.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zlib.c |   2 +-
 migration/multifd-zstd.c |   2 +-
 migration/multifd.c      | 109 +++++++++++----------------------------
 migration/multifd.h      |   3 +-
 4 files changed, 34 insertions(+), 82 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 37ce48621e..d89163e975 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -319,7 +319,7 @@ static MultiFDMethods multifd_zlib_ops = {
 
 static void multifd_zlib_register(void)
 {
-    multifd_register_ops(MULTIFD_COMPRESSION_ZLIB, &multifd_zlib_ops);
+    multifd_register_compression(MULTIFD_COMPRESSION_ZLIB, &multifd_zlib_ops);
 }
 
 migration_init(multifd_zlib_register);
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index b471daadcd..a90788540e 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -310,7 +310,7 @@ static MultiFDMethods multifd_zstd_ops = {
 
 static void multifd_zstd_register(void)
 {
-    multifd_register_ops(MULTIFD_COMPRESSION_ZSTD, &multifd_zstd_ops);
+    multifd_register_compression(MULTIFD_COMPRESSION_ZSTD, &multifd_zstd_ops);
 }
 
 migration_init(multifd_zstd_register);
diff --git a/migration/multifd.c b/migration/multifd.c
index 25cbc6dc6b..2968649500 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -45,48 +45,17 @@ typedef struct {
     uint64_t unused2[4];    /* Reserved for future use */
 } __attribute__((packed)) MultiFDInit_t;
 
-/* Multifd without compression */
-
-/**
- * nocomp_send_setup: setup send side
- *
- * For no compression this function does nothing.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
+static int multifd_socket_send_setup(MultiFDSendParams *p, Error **errp)
 {
     return 0;
 }
 
-/**
- * nocomp_send_cleanup: cleanup send side
- *
- * For no compression this function does nothing.
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
+static void multifd_socket_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
     return;
 }
 
-/**
- * nocomp_send_prepare: prepare date to be able to send
- *
- * For no compression we just have to calculate the size of the
- * packet.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
+static int multifd_socket_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     MultiFDPages_t *pages = p->pages;
 
@@ -101,43 +70,16 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
     return 0;
 }
 
-/**
- * nocomp_recv_setup: setup receive side
- *
- * For no compression this function does nothing.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
+static int multifd_socket_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
     return 0;
 }
 
-/**
- * nocomp_recv_cleanup: setup receive side
- *
- * For no compression this function does nothing.
- *
- * @p: Params for the channel that we are using
- */
-static void nocomp_recv_cleanup(MultiFDRecvParams *p)
+static void multifd_socket_recv_cleanup(MultiFDRecvParams *p)
 {
 }
 
-/**
- * nocomp_recv_pages: read the data from the channel into actual pages
- *
- * For no compression we just need to read things into the correct place.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int nocomp_recv_pages(MultiFDRecvParams *p, Error **errp)
+static int multifd_socket_recv_pages(MultiFDRecvParams *p, Error **errp)
 {
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
 
@@ -153,23 +95,34 @@ static int nocomp_recv_pages(MultiFDRecvParams *p, Error **errp)
     return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
 }
 
-static MultiFDMethods multifd_nocomp_ops = {
-    .send_setup = nocomp_send_setup,
-    .send_cleanup = nocomp_send_cleanup,
-    .send_prepare = nocomp_send_prepare,
-    .recv_setup = nocomp_recv_setup,
-    .recv_cleanup = nocomp_recv_cleanup,
-    .recv_pages = nocomp_recv_pages
+static MultiFDMethods multifd_socket_ops = {
+    .send_setup = multifd_socket_send_setup,
+    .send_cleanup = multifd_socket_send_cleanup,
+    .send_prepare = multifd_socket_send_prepare,
+    .recv_setup = multifd_socket_recv_setup,
+    .recv_cleanup = multifd_socket_recv_cleanup,
+    .recv_pages = multifd_socket_recv_pages
 };
 
-static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
-    [MULTIFD_COMPRESSION_NONE] = &multifd_nocomp_ops,
-};
+static MultiFDMethods *multifd_compression_ops[MULTIFD_COMPRESSION__MAX] = {0};
+
+static MultiFDMethods *multifd_get_ops(void)
+{
+    MultiFDCompression comp = migrate_multifd_compression();
+
+    assert(comp < MULTIFD_COMPRESSION__MAX);
+
+    if (comp != MULTIFD_COMPRESSION_NONE) {
+        return multifd_compression_ops[comp];
+    }
+
+    return &multifd_socket_ops;
+}
 
-void multifd_register_ops(int method, MultiFDMethods *ops)
+void multifd_register_compression(int method, MultiFDMethods *ops)
 {
     assert(0 < method && method < MULTIFD_COMPRESSION__MAX);
-    multifd_ops[method] = ops;
+    multifd_compression_ops[method] = ops;
 }
 
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
@@ -915,7 +868,7 @@ int multifd_save_setup(Error **errp)
     multifd_send_state->pages = multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
-    multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
+    multifd_send_state->ops = multifd_get_ops();
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -1171,7 +1124,7 @@ int multifd_load_setup(Error **errp)
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     qatomic_set(&multifd_recv_state->count, 0);
     qemu_sem_init(&multifd_recv_state->sem_sync, 0);
-    multifd_recv_state->ops = multifd_ops[migrate_multifd_compression()];
+    multifd_recv_state->ops = multifd_get_ops();
 
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
diff --git a/migration/multifd.h b/migration/multifd.h
index 35d11f103c..4630baccd4 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -204,7 +204,6 @@ typedef struct {
     int (*recv_pages)(MultiFDRecvParams *p, Error **errp);
 } MultiFDMethods;
 
-void multifd_register_ops(int method, MultiFDMethods *ops);
+void multifd_register_compression(int method, MultiFDMethods *ops);
 
 #endif
-
-- 
2.35.3


