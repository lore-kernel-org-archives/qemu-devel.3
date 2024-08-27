Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542F8C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0HP-0002xI-8q; Tue, 27 Aug 2024 13:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sj0HK-0002fw-Uq
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:46:51 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sj0HH-0000XT-8K
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:46:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0171E1FB81;
 Tue, 27 Aug 2024 17:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724780805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzCeGtRbezUjLGJZc+QAUD21UhGgHQUi03XhHq3S/9s=;
 b=iAAL+JVfpB2QkKrOKGpY3+R4TJt0rCzTQk0Rf3a5A3kRgOK+BR7oVbL+Tse9i9oLzXEvEc
 uqc2ewoqbaHynaq52/PJmqUJ816fR3jO+geg09j6C8mms+DpP6TdoQlbkqTJQxLEz0PJz2
 qoFjczfuxFXsFL89bMKqmCrVAOpPWJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724780805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzCeGtRbezUjLGJZc+QAUD21UhGgHQUi03XhHq3S/9s=;
 b=T8DF/w0M123ptnZZXfVK1dQ1kIV/ROaT0JDw7bJkwsGhLlS2uNmLTQzL8lhgeE1KToenV4
 Mfnq8ZJu7FZSceBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724780805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzCeGtRbezUjLGJZc+QAUD21UhGgHQUi03XhHq3S/9s=;
 b=iAAL+JVfpB2QkKrOKGpY3+R4TJt0rCzTQk0Rf3a5A3kRgOK+BR7oVbL+Tse9i9oLzXEvEc
 uqc2ewoqbaHynaq52/PJmqUJ816fR3jO+geg09j6C8mms+DpP6TdoQlbkqTJQxLEz0PJz2
 qoFjczfuxFXsFL89bMKqmCrVAOpPWJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724780805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzCeGtRbezUjLGJZc+QAUD21UhGgHQUi03XhHq3S/9s=;
 b=T8DF/w0M123ptnZZXfVK1dQ1kIV/ROaT0JDw7bJkwsGhLlS2uNmLTQzL8lhgeE1KToenV4
 Mfnq8ZJu7FZSceBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9705813A20;
 Tue, 27 Aug 2024 17:46:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OKpgFwMRzma+UAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Aug 2024 17:46:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 18/19] migration/multifd: Stop changing the packet on recv
 side
Date: Tue, 27 Aug 2024 14:46:05 -0300
Message-Id: <20240827174606.10352-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240827174606.10352-1-farosas@suse.de>
References: <20240827174606.10352-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLi88zywfsch9p6i3rre3533b9)];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, linaro.org:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 migration/multifd-nocomp.c | 40 ++++++++++++++++----------------------
 migration/multifd.c        | 20 +++++++++----------
 2 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index f294d1b0b2..a759470c9c 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -217,36 +217,32 @@ void multifd_ram_fill_packet(MultiFDSendParams *p)
 
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
 {
-    MultiFDPacket_t *packet = p->packet;
+    const MultiFDPacket_t *packet = p->packet;
     uint32_t page_count = multifd_ram_page_count();
     uint32_t page_size = multifd_ram_page_size();
+    uint32_t pages_per_packet = be32_to_cpu(packet->pages_alloc);
+    g_autofree const char *ramblock_name = NULL;
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
index b89715fdc2..2a8cd9174c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -230,22 +230,20 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
 {
-    MultiFDPacket_t *packet = p->packet;
+    const MultiFDPacket_t *packet = p->packet;
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


