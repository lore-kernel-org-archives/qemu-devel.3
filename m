Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07C2C3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 18:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVxJt-00032x-Ck; Mon, 22 Jul 2024 13:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJp-0002qW-Nm
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:29 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJm-00037E-Rz
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34AF021AE5;
 Mon, 22 Jul 2024 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oK5XkDoeInZOoB1Qlg91lWOBq6MpNV/Nl58Zm0hrvNo=;
 b=gFI4YJy22zfJ9JfTnICLDUm3H6AjqGYDTD9lviH1JU9BV7/vLuL4QJaLDhXrb/j744UerT
 FnGoy0mq0H+V9cQHvpYxLkuFG7DtLN082ydqplEWZtX/mK63/Ff6WJPwfB5EwM0cWzMLnE
 kR4OAY5BurRvP8uWZIBfgv6JC7+WQuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oK5XkDoeInZOoB1Qlg91lWOBq6MpNV/Nl58Zm0hrvNo=;
 b=2+7yX51mqTGoJ6Tv43ZUB8ZM6Y8o3ZRCI2sx0WOFUtncB2dht1tQLJo0KDsXDGDkIkKVsk
 mjYgOS1pyYc2+wCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gFI4YJy2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2+7yX51m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oK5XkDoeInZOoB1Qlg91lWOBq6MpNV/Nl58Zm0hrvNo=;
 b=gFI4YJy22zfJ9JfTnICLDUm3H6AjqGYDTD9lviH1JU9BV7/vLuL4QJaLDhXrb/j744UerT
 FnGoy0mq0H+V9cQHvpYxLkuFG7DtLN082ydqplEWZtX/mK63/Ff6WJPwfB5EwM0cWzMLnE
 kR4OAY5BurRvP8uWZIBfgv6JC7+WQuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oK5XkDoeInZOoB1Qlg91lWOBq6MpNV/Nl58Zm0hrvNo=;
 b=2+7yX51mqTGoJ6Tv43ZUB8ZM6Y8o3ZRCI2sx0WOFUtncB2dht1tQLJo0KDsXDGDkIkKVsk
 mjYgOS1pyYc2+wCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C02313996;
 Mon, 22 Jul 2024 17:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kAkNMfudnmYnCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 17:59:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH v2 4/9] migration/multifd: Make MultiFDPages_t:offset a
 flexible array member
Date: Mon, 22 Jul 2024 14:59:09 -0300
Message-Id: <20240722175914.24022-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722175914.24022-1-farosas@suse.de>
References: <20240722175914.24022-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.19 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 34AF021AE5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We're about to use MultiFDPages_t from inside the MultiFDSendData
payload union, which means we cannot have pointers to allocated data
inside the pages structure, otherwise we'd lose the reference to that
memory once another payload type touches the union. Move the offset
array into the end of the structure and turn it into a flexible array
member, so it is allocated along with the rest of MultiFDSendData in
the next patches.

Note that the ramblock pointer is still fine because the storage for
it is not owned by the migration code.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 21 ++++++---------------
 migration/multifd.h |  4 ++--
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 20a767157e..440319b361 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -389,22 +389,10 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
     return msg.id;
 }
 
-static MultiFDPages_t *multifd_pages_init(uint32_t n)
-{
-    MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
-
-    pages->allocated = n;
-    pages->offset = g_new0(ram_addr_t, n);
-
-    return pages;
-}
-
 static void multifd_pages_clear(MultiFDPages_t *pages)
 {
     multifd_pages_reset(pages);
     pages->allocated = 0;
-    g_free(pages->offset);
-    pages->offset = NULL;
     g_free(pages);
 }
 
@@ -1169,7 +1157,9 @@ bool multifd_send_setup(void)
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
-    multifd_send_state->pages = multifd_pages_init(page_count);
+    multifd_send_state->pages = g_malloc0(sizeof(MultiFDPages_t) +
+                                          page_count * sizeof(ram_addr_t));
+    multifd_send_state->pages->allocated = page_count;
     qemu_sem_init(&multifd_send_state->channels_created, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
@@ -1181,8 +1171,9 @@ bool multifd_send_setup(void)
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
-        p->pages = multifd_pages_init(page_count);
-
+        p->pages = g_malloc0(sizeof(MultiFDPages_t) +
+                             page_count * sizeof(ram_addr_t));
+        p->pages->allocated = page_count;
         if (use_packets) {
             p->packet_len = sizeof(MultiFDPacket_t)
                           + sizeof(uint64_t) * page_count;
diff --git a/migration/multifd.h b/migration/multifd.h
index c7b1ebe099..12d4247e23 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -78,9 +78,9 @@ typedef struct {
     uint32_t normal_num;
     /* number of allocated pages */
     uint32_t allocated;
+    RAMBlock *block;
     /* offset of each page */
-    ram_addr_t *offset;
-    RAMBlock *block;
+    ram_addr_t offset[];
 } MultiFDPages_t;
 
 struct MultiFDRecvData {
-- 
2.35.3


