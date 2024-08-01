Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A50C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZV28-0000Tg-NJ; Thu, 01 Aug 2024 08:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1u-0008TT-TX
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:40 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1s-0000pW-L6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B217021A07;
 Thu,  1 Aug 2024 12:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RO1ANbUWtLgMfI4xmyfLz/MPDC09eAq86YwDkWgYnU=;
 b=Ky/F2JMQexpKd9hcAJfLRz8q6WJoip3exznfucnVEekpEPSoNXShf19QYFV6RS8K9B+tJ2
 qpsx1FH9dR633hS3Q8tBfTjfzGxnfizAcc7nk3iI0kLsritvcSYkpiJKQvJEqUrXaK86Ih
 AW/wMllbp1/Hid4ZqErfwL6XGE0C0tA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RO1ANbUWtLgMfI4xmyfLz/MPDC09eAq86YwDkWgYnU=;
 b=a5PLUG8fPs+S9YTfH8BRYRXYbko3PMUX57cRzf8n3sLLPlP3DbxkSpoMOvDXj2pakAT20z
 4YvpeCMyjdukTmBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RO1ANbUWtLgMfI4xmyfLz/MPDC09eAq86YwDkWgYnU=;
 b=Ky/F2JMQexpKd9hcAJfLRz8q6WJoip3exznfucnVEekpEPSoNXShf19QYFV6RS8K9B+tJ2
 qpsx1FH9dR633hS3Q8tBfTjfzGxnfizAcc7nk3iI0kLsritvcSYkpiJKQvJEqUrXaK86Ih
 AW/wMllbp1/Hid4ZqErfwL6XGE0C0tA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RO1ANbUWtLgMfI4xmyfLz/MPDC09eAq86YwDkWgYnU=;
 b=a5PLUG8fPs+S9YTfH8BRYRXYbko3PMUX57cRzf8n3sLLPlP3DbxkSpoMOvDXj2pakAT20z
 4YvpeCMyjdukTmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C8F13946;
 Thu,  1 Aug 2024 12:35:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YBBfEhWBq2YEYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Aug 2024 12:35:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 09/14] migration/multifd: Isolate ram pages packet data
Date: Thu,  1 Aug 2024 09:35:11 -0300
Message-Id: <20240801123516.4498-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240801123516.4498-1-farosas@suse.de>
References: <20240801123516.4498-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

While we cannot yet disentangle the multifd packet from page data, we
can make the code a bit cleaner by setting the page-related fields in
a separate function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c    | 110 ++++++++++++++++++++++++-----------------
 migration/trace-events |   9 ++--
 2 files changed, 70 insertions(+), 49 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 739fc01cbe..7d946e6661 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -424,67 +424,65 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
     return msg.id;
 }
 
-void multifd_send_fill_packet(MultiFDSendParams *p)
+static void multifd_ram_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
     MultiFDPages_t *pages = &p->data->u.ram;
-    uint64_t packet_num;
     uint32_t zero_num = pages->num - pages->normal_num;
-    int i;
 
-    packet->flags = cpu_to_be32(p->flags);
     packet->pages_alloc = cpu_to_be32(multifd_ram_page_count());
     packet->normal_pages = cpu_to_be32(pages->normal_num);
     packet->zero_pages = cpu_to_be32(zero_num);
-    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
-
-    packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
-    packet->packet_num = cpu_to_be64(packet_num);
 
     if (pages->block) {
         strncpy(packet->ramblock, pages->block->idstr, 256);
     }
 
-    for (i = 0; i < pages->num; i++) {
+    for (int i = 0; i < pages->num; i++) {
         /* there are architectures where ram_addr_t is 32 bit */
         uint64_t temp = pages->offset[i];
 
         packet->offset[i] = cpu_to_be64(temp);
     }
 
-    p->packets_sent++;
     p->total_normal_pages += pages->normal_num;
     p->total_zero_pages += zero_num;
 
-    trace_multifd_send(p->id, packet_num, pages->normal_num, zero_num,
-                       p->flags, p->next_packet_size);
+    trace_multifd_send_ram_fill(p->id, p->total_normal_pages,
+                                p->total_zero_pages);
 }
 
-static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+void multifd_send_fill_packet(MultiFDSendParams *p)
+{
+    MultiFDPacket_t *packet = p->packet;
+    uint64_t packet_num;
+
+    memset(packet, 0, p->packet_len);
+
+    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
+    packet->version = cpu_to_be32(MULTIFD_VERSION);
+
+    packet->flags = cpu_to_be32(p->flags);
+    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
+
+    packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
+    packet->packet_num = cpu_to_be64(packet_num);
+
+    p->packets_sent++;
+
+    multifd_ram_fill_packet(p);
+
+    trace_multifd_send_fill(p->id, packet_num,
+                            p->flags, p->next_packet_size);
+}
+
+static int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
 {
     MultiFDPacket_t *packet = p->packet;
     uint32_t page_count = multifd_ram_page_count();
     uint32_t page_size = multifd_ram_page_size();
     int i;
 
-    packet->magic = be32_to_cpu(packet->magic);
-    if (packet->magic != MULTIFD_MAGIC) {
-        error_setg(errp, "multifd: received packet "
-                   "magic %x and expected magic %x",
-                   packet->magic, MULTIFD_MAGIC);
-        return -1;
-    }
-
-    packet->version = be32_to_cpu(packet->version);
-    if (packet->version != MULTIFD_VERSION) {
-        error_setg(errp, "multifd: received packet "
-                   "version %u and expected version %u",
-                   packet->version, MULTIFD_VERSION);
-        return -1;
-    }
-
-    p->flags = be32_to_cpu(packet->flags);
-
     packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
     /*
      * If we received a packet that is 100 times bigger than expected
@@ -513,15 +511,9 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
 
-    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
-    p->packet_num = be64_to_cpu(packet->packet_num);
-    p->packets_recved++;
     p->total_normal_pages += p->normal_num;
     p->total_zero_pages += p->zero_num;
 
-    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
-                       p->flags, p->next_packet_size);
-
     if (p->normal_num == 0 && p->zero_num == 0) {
         return 0;
     }
@@ -563,6 +555,40 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
+static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+{
+    MultiFDPacket_t *packet = p->packet;
+    int ret = 0;
+
+    packet->magic = be32_to_cpu(packet->magic);
+    if (packet->magic != MULTIFD_MAGIC) {
+        error_setg(errp, "multifd: received packet "
+                   "magic %x and expected magic %x",
+                   packet->magic, MULTIFD_MAGIC);
+        return -1;
+    }
+
+    packet->version = be32_to_cpu(packet->version);
+    if (packet->version != MULTIFD_VERSION) {
+        error_setg(errp, "multifd: received packet "
+                   "version %u and expected version %u",
+                   packet->version, MULTIFD_VERSION);
+        return -1;
+    }
+
+    p->flags = be32_to_cpu(packet->flags);
+    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
+    p->packet_num = be64_to_cpu(packet->packet_num);
+    p->packets_recved++;
+
+    ret = multifd_ram_unfill_packet(p, errp);
+
+    trace_multifd_recv_unfill(p->id, p->packet_num, p->flags,
+                              p->next_packet_size);
+
+    return ret;
+}
+
 static bool multifd_send_should_exit(void)
 {
     return qatomic_read(&multifd_send_state->exiting);
@@ -1036,8 +1062,7 @@ out:
 
     rcu_unregister_thread();
     migration_threads_remove(thread);
-    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages,
-                                  p->total_zero_pages);
+    trace_multifd_send_thread_end(p->id, p->packets_sent);
 
     return NULL;
 }
@@ -1207,8 +1232,6 @@ bool multifd_send_setup(void)
             p->packet_len = sizeof(MultiFDPacket_t)
                           + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
-            p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
-            p->packet->version = cpu_to_be32(MULTIFD_VERSION);
         }
         p->name = g_strdup_printf("mig/src/send_%d", i);
         p->write_flags = 0;
@@ -1554,7 +1577,6 @@ static void *multifd_recv_thread(void *opaque)
                 qemu_sem_wait(&p->sem_sync);
             }
         } else {
-            p->total_normal_pages += p->data->size / qemu_target_page_size();
             p->data->size = 0;
             /*
              * Order data->size update before clearing
@@ -1571,9 +1593,7 @@ static void *multifd_recv_thread(void *opaque)
     }
 
     rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->packets_recved,
-                                  p->total_normal_pages,
-                                  p->total_zero_pages);
+    trace_multifd_recv_thread_end(p->id, p->packets_recved);
 
     return NULL;
 }
diff --git a/migration/trace-events b/migration/trace-events
index 0b7c3324fb..c65902f042 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -128,21 +128,22 @@ postcopy_preempt_reset_channel(void) ""
 # multifd.c
 multifd_new_send_channel_async(uint8_t id) "channel %u"
 multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=%u err=%p"
-multifd_recv(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t zero, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
+multifd_recv_unfill(uint8_t id, uint64_t packet_num, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " flags 0x%x next packet size %u"
 multifd_recv_new_channel(uint8_t id) "channel %u"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %u"
 multifd_recv_sync_main_wait(uint8_t id) "iter %u"
 multifd_recv_terminate_threads(bool error) "error %d"
-multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %" PRIu64 " zero pages %" PRIu64
+multifd_recv_thread_end(uint8_t id, uint64_t packets) "channel %u packets %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%u"
-multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal_pages, uint32_t zero_pages, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
+multifd_send_fill(uint8_t id, uint64_t packet_num, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " flags 0x%x next packet size %u"
+multifd_send_ram_fill(uint8_t id, uint32_t normal, uint32_t zero) "channel %u normal pages %u zero pages %u"
 multifd_send_error(uint8_t id) "channel %u"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
 multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(void) ""
-multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64 " zero pages %"  PRIu64
+multifd_send_thread_end(uint8_t id, uint64_t packets) "channel %u packets %" PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
 multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
 multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
-- 
2.35.3


