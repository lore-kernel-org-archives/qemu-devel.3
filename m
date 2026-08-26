Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA48FC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdN-0001Bn-3b; Wed, 26 Aug 2026 10:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdL-0001BB-GA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:43 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdJ-0001wy-NQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 453F421259;
 Wed, 26 Aug 2026 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SU6M+9tQ87hTQgwr6I/3+gapxDIcAIUfg8QtxVIi6v4=;
 b=Ge4uBZM05h0GEFhiW6eD2eb9/K4sSirNqkPGv4oRhsKkgALno+zSD+X6L3X5umqt06ks61
 dxuYXKrhg0i1qhRTkA1pefkdC8uJ9foCsDSF++rNIHK9mzQ6Mqd6GCzPK0wg3K1geGJ//r
 dZlyokPHBC0bUDDrlX/9+UXV52U6sRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SU6M+9tQ87hTQgwr6I/3+gapxDIcAIUfg8QtxVIi6v4=;
 b=F7FXOd0m6tSEOHpGnpcHWrPNoEUipj9VpzTgWgR4ykuZQ/hCowSZYdQGN8lTBQrq/hQrqq
 bpbytD3wZGlCSEAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tH0me2Ay;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Vm3KKz+q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SU6M+9tQ87hTQgwr6I/3+gapxDIcAIUfg8QtxVIi6v4=;
 b=tH0me2AyattKO9P1CaDP4UtnjbAWJBK5g+KuRUYjGNRAuJVesL2fBWTlJsE8sn5fvQKc6L
 q04ES01GrXUDHSyqw8EoaHzV9cP4saa0MIznjCxN3dHGKYwwT9cx4L12O8he1cP2OEwMJa
 SgrZeOaGlLDGo3sCmZsY5UgtsmnAep4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SU6M+9tQ87hTQgwr6I/3+gapxDIcAIUfg8QtxVIi6v4=;
 b=Vm3KKz+qXwRy2he5WPw/sZJzrPonmeLJYoGZErc6WmKKWimP4Jdf3KGcHLRvCxnb+/qAbI
 ROKDjjIGexsAzIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 556CD1364A;
 Wed, 26 Aug 2026 14:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OPr6CUv4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 17/30] migration/rdma: Drop RDMARegister.key.chunk
Date: Wed, 26 Aug 2026 11:28:52 -0300
Message-ID: <20260826142905.2315503-18-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.988]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,ionos.com:email,suse.de:email,suse.de:mid,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim,ionos.com:email];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 453F421259
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Xu <peterx@redhat.com>

Not used anymore.

Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index f9f39402568..683c24ba4dd 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -414,10 +414,7 @@ static void network_to_control(RDMAControlHeader *control)
  * the actual RDMA operation.
  */
 typedef struct QEMU_PACKED {
-    union QEMU_PACKED {
-        uint64_t current_addr;  /* offset into the ram_addr_t space */
-        uint64_t chunk;         /* chunk to lookup if unregistering */
-    } key;
+    uint64_t current_addr;  /* offset into the ram_addr_t space */
     uint32_t current_index; /* which ramblock the chunk belongs to */
     uint32_t padding;
     uint64_t chunks;            /* how many sequential chunks to register */
@@ -442,16 +439,16 @@ static void register_to_network(RDMAContext *rdma, RDMARegister *reg)
      * current_addr as passed in is an address in the local ram_addr_t
      * space, we need to translate this for the destination
      */
-    reg->key.current_addr -= local_block->offset;
-    reg->key.current_addr += rdma->dest_blocks[reg->current_index].offset;
-    reg->key.current_addr = htonll(reg->key.current_addr);
+    reg->current_addr -= local_block->offset;
+    reg->current_addr += rdma->dest_blocks[reg->current_index].offset;
+    reg->current_addr = htonll(reg->current_addr);
     reg->current_index = htonl(reg->current_index);
     reg->chunks = htonll(reg->chunks);
 }
 
 static void network_to_register(RDMARegister *reg)
 {
-    reg->key.current_addr = ntohll(reg->key.current_addr);
+    reg->current_addr = ntohll(reg->current_addr);
     reg->current_index = ntohl(reg->current_index);
     reg->chunks = ntohll(reg->chunks);
 }
@@ -1831,7 +1828,7 @@ retry:
              * Otherwise, tell other side to register.
              */
             reg.current_index = current_index;
-            reg.key.current_addr = current_addr;
+            reg.current_addr = current_addr;
             reg.chunks = chunks;
 
             trace_rdma_write_one_sendreg(chunk, sge.length, current_index,
@@ -3373,7 +3370,7 @@ int rdma_registration_handle(QEMUFile *f)
                 reg_result = &results[count];
 
                 trace_rdma_registration_handle_register_loop(count,
-                         reg->current_index, reg->key.current_addr, reg->chunks);
+                         reg->current_index, reg->current_addr, reg->chunks);
 
                 if (reg->current_index >= rdma->local_ram_blocks.nb_blocks) {
                     error_report("rdma: 'register' bad block index %u (vs %d)",
@@ -3382,15 +3379,15 @@ int rdma_registration_handle(QEMUFile *f)
                     goto err;
                 }
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
-                if (block->offset > reg->key.current_addr) {
+                if (block->offset > reg->current_addr) {
                     error_report("rdma: bad register address for block %s"
                         " offset: %" PRIx64 " current_addr: %" PRIx64,
                         block->block_name, block->offset,
-                        reg->key.current_addr);
+                        reg->current_addr);
                     goto err;
                 }
                 host_addr = (block->local_host_addr +
-                            (reg->key.current_addr - block->offset));
+                            (reg->current_addr - block->offset));
                 chunk = ram_chunk_index(block->local_host_addr,
                                         (uint8_t *) host_addr);
                 chunk_start = ram_chunk_start(block, chunk);
-- 
2.53.0


