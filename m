Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E544C5B557
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 14:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjK6Z-0002U9-7o; Wed, 28 Aug 2024 10:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjK6V-0002ND-Rv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:56:59 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjK6U-00027h-6M
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:56:59 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2510F1FC31;
 Wed, 28 Aug 2024 14:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724857016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UP+7srMjrosEIrUzHZWN1svuA5ODS+yKmeGwisfan0k=;
 b=BgEeMkYdU30qvRx84SJdLd/RJwW4AEFgG5xTHQIeT4LDXBhvcSC+t/dztJ74tb2FA8igOO
 3TMmXih+5TV+coiTQh4icL+K+yzUg6b6k/96LQwb0b3ia7IogyiNCXsCLZUjFYSW7x0kUq
 WMKoF0BLEinQAQ92LhsZ9dxze2dsETk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724857016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UP+7srMjrosEIrUzHZWN1svuA5ODS+yKmeGwisfan0k=;
 b=Sx0DOL9TrBgxHOqJjBoLdbbvTBTFZppUnq+Q4zXhXYZlBxHEU8C5sIOhL604Y2o9AVCrqX
 DaVyeA/CcYl+vSCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BgEeMkYd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Sx0DOL9T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724857016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UP+7srMjrosEIrUzHZWN1svuA5ODS+yKmeGwisfan0k=;
 b=BgEeMkYdU30qvRx84SJdLd/RJwW4AEFgG5xTHQIeT4LDXBhvcSC+t/dztJ74tb2FA8igOO
 3TMmXih+5TV+coiTQh4icL+K+yzUg6b6k/96LQwb0b3ia7IogyiNCXsCLZUjFYSW7x0kUq
 WMKoF0BLEinQAQ92LhsZ9dxze2dsETk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724857016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UP+7srMjrosEIrUzHZWN1svuA5ODS+yKmeGwisfan0k=;
 b=Sx0DOL9TrBgxHOqJjBoLdbbvTBTFZppUnq+Q4zXhXYZlBxHEU8C5sIOhL604Y2o9AVCrqX
 DaVyeA/CcYl+vSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1BAE1398F;
 Wed, 28 Aug 2024 14:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4J6ALbY6z2YnRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Aug 2024 14:56:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 1/4] migration/multifd: Stop changing the packet on recv
 side
Date: Wed, 28 Aug 2024 11:56:47 -0300
Message-Id: <20240828145650.15879-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240828145650.15879-1-farosas@suse.de>
References: <20240828145650.15879-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2510F1FC31
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
endianness. This is harmless, but ultimately not very clean.

Stop touching the received packet and do the necessary work using
stack variables instead.

While here tweak the error strings and fix the space before
semicolons. Also remove the "100 times bigger" comment because it's
just one possible explanation for a size mismatch and it doesn't even
match the code.

CC: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-nocomp.c | 29 ++++++++++++-----------------
 migration/multifd.c        | 20 +++++++++-----------
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index f294d1b0b2..07c63f4a72 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -220,33 +220,28 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
     MultiFDPacket_t *packet = p->packet;
     uint32_t page_count = multifd_ram_page_count();
     uint32_t page_size = multifd_ram_page_size();
+    uint32_t pages_per_packet = be32_to_cpu(packet->pages_alloc);
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


