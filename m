Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A05C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 19:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sifmy-00006y-8P; Mon, 26 Aug 2024 15:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmv-0008Lo-2U
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:54:05 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmr-0002Ff-Up
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:54:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A589A21AE0;
 Mon, 26 Aug 2024 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6Qz4GSqPbQs71uA2rNf8+Khxz2lDz4ZGpmmrlJWLQs=;
 b=Szl81JdkVZMEdKcohTabdoPP47WX4979NCL6o3Eh2kYVeH3ls7PaEiqm1wNBnvoG1dBQIp
 kPM+j06bk6N8pS7tvKEYBpwXzjaBQhwTxvFnTsZijuAAsf6w/2rvUpAaO+TnDA6vw1JKwh
 fUcggoXsi+EQuX7At1zL3got/PUrECA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6Qz4GSqPbQs71uA2rNf8+Khxz2lDz4ZGpmmrlJWLQs=;
 b=5ija/8WwnQJXgrfhTypi4zb5Ftm2+clSpivMCPRcQZWcPhNm+hRs1Gu4hL6WsHFceoeqBH
 39KIkIrbPeHOKDAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6Qz4GSqPbQs71uA2rNf8+Khxz2lDz4ZGpmmrlJWLQs=;
 b=Szl81JdkVZMEdKcohTabdoPP47WX4979NCL6o3Eh2kYVeH3ls7PaEiqm1wNBnvoG1dBQIp
 kPM+j06bk6N8pS7tvKEYBpwXzjaBQhwTxvFnTsZijuAAsf6w/2rvUpAaO+TnDA6vw1JKwh
 fUcggoXsi+EQuX7At1zL3got/PUrECA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6Qz4GSqPbQs71uA2rNf8+Khxz2lDz4ZGpmmrlJWLQs=;
 b=5ija/8WwnQJXgrfhTypi4zb5Ftm2+clSpivMCPRcQZWcPhNm+hRs1Gu4hL6WsHFceoeqBH
 39KIkIrbPeHOKDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 427901398D;
 Mon, 26 Aug 2024 19:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iPOfAlfdzGY5PQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Aug 2024 19:53:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 18/18] migration/multifd: Stop changing the packet on recv
 side
Date: Mon, 26 Aug 2024 16:53:22 -0300
Message-Id: <20240826195322.16532-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240826195322.16532-1-farosas@suse.de>
References: <20240826195322.16532-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

As observed by Philippe, the multifd_ram_unfill_packet() function
currently leaves the MultiFDPacket structure with mixed
endianness. This is harmless, but ultimately not very clean. Aside
from that, the packet is also written to on the recv side to ensure
the ramblock name is null-terminated.

Stop touching the received packet and do the necessary work using
stack variables instead.

While here tweak the error strings and fix the space before
semicolons. Also remove the "100 times bigger" comment because it's
just one possible explanation for a size mismatch and it doesn't even
match the code.

CC: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-nocomp.c | 38 ++++++++++++++++----------------------
 migration/multifd.c        | 18 ++++++++----------
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index f294d1b0b2..0cbf1b88e1 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -220,33 +220,29 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
     MultiFDPacket_t *packet = p->packet;
     uint32_t page_count = multifd_ram_page_count();
     uint32_t page_size = multifd_ram_page_size();
+    uint32_t pages_per_packet = be32_to_cpu(packet->pages_alloc);
+    const char *ramblock_name;
     int i;
 
-    packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
-    /*
-     * If we received a packet that is 100 times bigger than expected
-     * just stop migration.  It is a magic number.
-     */
-    if (packet->pages_alloc > page_count) {
-        error_setg(errp, "multifd: received packet "
-                   "with size %u and expected a size of %u",
-                   packet->pages_alloc, page_count) ;
+    if (pages_per_packet > page_count) {
+        error_setg(errp, "multifd: received packet with %u pages, expected %u",
+                   pages_per_packet, page_count);
         return -1;
     }
 
     p->normal_num = be32_to_cpu(packet->normal_pages);
-    if (p->normal_num > packet->pages_alloc) {
-        error_setg(errp, "multifd: received packet "
-                   "with %u normal pages and expected maximum pages are %u",
-                   p->normal_num, packet->pages_alloc) ;
+    if (p->normal_num > pages_per_packet) {
+        error_setg(errp, "multifd: received packet with %u non-zero pages, "
+                   "which exceeds maximum expected pages %u",
+                   p->normal_num, pages_per_packet);
         return -1;
     }
 
     p->zero_num = be32_to_cpu(packet->zero_pages);
-    if (p->zero_num > packet->pages_alloc - p->normal_num) {
-        error_setg(errp, "multifd: received packet "
-                   "with %u zero pages and expected maximum zero pages are %u",
-                   p->zero_num, packet->pages_alloc - p->normal_num) ;
+    if (p->zero_num > pages_per_packet - p->normal_num) {
+        error_setg(errp,
+                   "multifd: received packet with %u zero pages, expected maximum %u",
+                   p->zero_num, pages_per_packet - p->normal_num);
         return -1;
     }
 
@@ -254,12 +250,10 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
         return 0;
     }
 
-    /* make sure that ramblock is 0 terminated */
-    packet->ramblock[255] = 0;
-    p->block = qemu_ram_block_by_name(packet->ramblock);
+    ramblock_name = g_strndup(packet->ramblock, 255);
+    p->block = qemu_ram_block_by_name(ramblock_name);
     if (!p->block) {
-        error_setg(errp, "multifd: unknown ram block %s",
-                   packet->ramblock);
+        error_setg(errp, "multifd: unknown ram block %s", ramblock_name);
         return -1;
     }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index b89715fdc2..256ecdea56 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -231,21 +231,19 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
 {
     MultiFDPacket_t *packet = p->packet;
+    uint32_t magic = be32_to_cpu(packet->magic);
+    uint32_t version = be32_to_cpu(packet->version);
     int ret = 0;
 
-    packet->magic = be32_to_cpu(packet->magic);
-    if (packet->magic != MULTIFD_MAGIC) {
-        error_setg(errp, "multifd: received packet "
-                   "magic %x and expected magic %x",
-                   packet->magic, MULTIFD_MAGIC);
+    if (magic != MULTIFD_MAGIC) {
+        error_setg(errp, "multifd: received packet magic %x, expected %x",
+                   magic, MULTIFD_MAGIC);
         return -1;
     }
 
-    packet->version = be32_to_cpu(packet->version);
-    if (packet->version != MULTIFD_VERSION) {
-        error_setg(errp, "multifd: received packet "
-                   "version %u and expected version %u",
-                   packet->version, MULTIFD_VERSION);
+    if (version != MULTIFD_VERSION) {
+        error_setg(errp, "multifd: received packet version %u, expected %u",
+                   version, MULTIFD_VERSION);
         return -1;
     }
 
-- 
2.35.3


