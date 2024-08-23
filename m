Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6335CC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYGM-0000io-OW; Fri, 23 Aug 2024 13:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYG6-0008Bx-DA
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:34 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYG4-0008Vm-Jd
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CBAC226EE;
 Fri, 23 Aug 2024 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeaBwbDiSXENz05d2J/GRTpI45LS1NNJQYVejZDr0Jw=;
 b=hXMF9+d2weawGnOCR7HJ4r6oJSvg7B//SoDs99clX3i6664CyW5J8vm+chDbfZkp7C8pjz
 qZGuqUGl45IpkOr0kR/Rzvopb/cvz65nCqLeEuODPAn3H19Fs0FbcDue0YRaZNmVvDO9Xf
 dobbO9bri7nOqdrWeGqIFbbniV0afJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeaBwbDiSXENz05d2J/GRTpI45LS1NNJQYVejZDr0Jw=;
 b=n0fQKc0JgTepuSDLQimDMiH3N2EijdzLXFwLYpiV/mOsrDfr79Ad7KCi/bJxrbSZFgK+tx
 TVg1SSxK9uA66UCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hXMF9+d2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n0fQKc0J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeaBwbDiSXENz05d2J/GRTpI45LS1NNJQYVejZDr0Jw=;
 b=hXMF9+d2weawGnOCR7HJ4r6oJSvg7B//SoDs99clX3i6664CyW5J8vm+chDbfZkp7C8pjz
 qZGuqUGl45IpkOr0kR/Rzvopb/cvz65nCqLeEuODPAn3H19Fs0FbcDue0YRaZNmVvDO9Xf
 dobbO9bri7nOqdrWeGqIFbbniV0afJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeaBwbDiSXENz05d2J/GRTpI45LS1NNJQYVejZDr0Jw=;
 b=n0fQKc0JgTepuSDLQimDMiH3N2EijdzLXFwLYpiV/mOsrDfr79Ad7KCi/bJxrbSZFgK+tx
 TVg1SSxK9uA66UCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24B551333E;
 Fri, 23 Aug 2024 17:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qP0TN1HJyGb2LwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Aug 2024 17:39:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 10/16] migration/multifd: Isolate ram pages packet data
Date: Fri, 23 Aug 2024 14:39:05 -0300
Message-Id: <20240823173911.6712-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240823173911.6712-1-farosas@suse.de>
References: <20240823173911.6712-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CBAC226EE
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

While we cannot yet disentangle the multifd packet from page data, we
can make the code a bit cleaner by setting the page-related fields in
a separate function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c    | 99 +++++++++++++++++++++++++-----------------
 migration/trace-events |  5 ++-
 2 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index df8dfcc98f..d64fcdf4ac 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -424,65 +424,61 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
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
 
+    trace_multifd_send_ram_fill(p->id, pages->normal_num, zero_num);
+}
+
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
     p->packets_sent++;
 
-    trace_multifd_send(p->id, packet_num, pages->normal_num, zero_num,
-                       p->flags, p->next_packet_size);
+    multifd_ram_fill_packet(p);
+
+    trace_multifd_send_fill(p->id, packet_num,
+                            p->flags, p->next_packet_size);
 }
 
-static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
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
@@ -511,13 +507,6 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
 
-    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
-    p->packet_num = be64_to_cpu(packet->packet_num);
-    p->packets_recved++;
-
-    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
-                       p->flags, p->next_packet_size);
-
     if (p->normal_num == 0 && p->zero_num == 0) {
         return 0;
     }
@@ -559,6 +548,40 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
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
@@ -1203,8 +1226,6 @@ bool multifd_send_setup(void)
             p->packet_len = sizeof(MultiFDPacket_t)
                           + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
-            p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
-            p->packet->version = cpu_to_be32(MULTIFD_VERSION);
         }
         p->name = g_strdup_printf("mig/src/send_%d", i);
         p->write_flags = 0;
diff --git a/migration/trace-events b/migration/trace-events
index 0887cef912..c65902f042 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -128,7 +128,7 @@ postcopy_preempt_reset_channel(void) ""
 # multifd.c
 multifd_new_send_channel_async(uint8_t id) "channel %u"
 multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=%u err=%p"
-multifd_recv(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t zero, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
+multifd_recv_unfill(uint8_t id, uint64_t packet_num, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " flags 0x%x next packet size %u"
 multifd_recv_new_channel(uint8_t id) "channel %u"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %u"
@@ -136,7 +136,8 @@ multifd_recv_sync_main_wait(uint8_t id) "iter %u"
 multifd_recv_terminate_threads(bool error) "error %d"
 multifd_recv_thread_end(uint8_t id, uint64_t packets) "channel %u packets %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%u"
-multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal_pages, uint32_t zero_pages, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
+multifd_send_fill(uint8_t id, uint64_t packet_num, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " flags 0x%x next packet size %u"
+multifd_send_ram_fill(uint8_t id, uint32_t normal, uint32_t zero) "channel %u normal pages %u zero pages %u"
 multifd_send_error(uint8_t id) "channel %u"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
-- 
2.35.3


