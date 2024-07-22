Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A38C3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 18:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVxJy-0003Lf-04; Mon, 22 Jul 2024 13:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJw-0003FT-Ck
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:36 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJr-00037n-Nr
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:36 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 27B1021B6A;
 Mon, 22 Jul 2024 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cs55Q4tDVXnDLGxgGhNE0DNXcMeFtVN9CDpXBLNZuJg=;
 b=ZuhrJdS/OHUyd22bNFB2xETP3GlmVZDFcClhtTLAdzcaDycEBCaMYehn3JheJdjO3oe21P
 bAxhiFVUhY4xxeJfQOAhU3mMQuQibtRrw8I/D/6opTKfEHUG72vrTPPzyXmlHtsJaJvYnI
 AH+6+Jk7VL1a93/jqAqFi8NPsyEW4Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cs55Q4tDVXnDLGxgGhNE0DNXcMeFtVN9CDpXBLNZuJg=;
 b=UpKyL6vveLTgAXPcTb7k44bCmX+qBKih+7GTi8hZwBUfAXF83c1gLLHpEmoRs6JWlupiGp
 ntm+0ty9TCHTvXCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ZuhrJdS/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UpKyL6vv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cs55Q4tDVXnDLGxgGhNE0DNXcMeFtVN9CDpXBLNZuJg=;
 b=ZuhrJdS/OHUyd22bNFB2xETP3GlmVZDFcClhtTLAdzcaDycEBCaMYehn3JheJdjO3oe21P
 bAxhiFVUhY4xxeJfQOAhU3mMQuQibtRrw8I/D/6opTKfEHUG72vrTPPzyXmlHtsJaJvYnI
 AH+6+Jk7VL1a93/jqAqFi8NPsyEW4Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cs55Q4tDVXnDLGxgGhNE0DNXcMeFtVN9CDpXBLNZuJg=;
 b=UpKyL6vveLTgAXPcTb7k44bCmX+qBKih+7GTi8hZwBUfAXF83c1gLLHpEmoRs6JWlupiGp
 ntm+0ty9TCHTvXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2FA513996;
 Mon, 22 Jul 2024 17:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eKzGLQCenmYnCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 17:59:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH v2 7/9] migration/multifd: Isolate ram pages packet data
Date: Mon, 22 Jul 2024 14:59:12 -0300
Message-Id: <20240722175914.24022-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722175914.24022-1-farosas@suse.de>
References: <20240722175914.24022-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 27B1021B6A
X-Spamd-Result: default: False [-2.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

While we cannot yet disentangle the multifd packet from page data, we
can make the code a bit cleaner by setting the page-related fields in
a separate function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 97 ++++++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 36 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index fcdb12e04f..d25b8658b2 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -409,65 +409,62 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
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
     packet->pages_alloc = cpu_to_be32(pages->allocated);
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
+}
 
-    trace_multifd_send(p->id, packet_num, pages->normal_num, zero_num,
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
+    trace_multifd_send(p->id, packet_num,
+                       be32_to_cpu(packet->normal_pages),
+                       be32_to_cpu(packet->zero_pages),
                        p->flags, p->next_packet_size);
 }
 
-static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+static int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
 {
     MultiFDPacket_t *packet = p->packet;
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
@@ -496,15 +493,9 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
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
@@ -546,6 +537,40 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
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
+    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
+                       p->flags, p->next_packet_size);
+
+    return ret;
+}
+
 static bool multifd_send_should_exit(void)
 {
     return qatomic_read(&multifd_send_state->exiting);
-- 
2.35.3


