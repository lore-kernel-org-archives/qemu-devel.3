Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED191C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82T-0006jB-QZ; Fri, 25 Sep 2026 11:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82S-0006iS-Hh
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:40 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82Q-0004cR-NR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:40 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 43E0B1F7D3;
 Fri, 25 Sep 2026 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJ1m1CY+5yotCAkfbobTcXoVHjPVSpp0h7o/ODhYa3w=;
 b=DSzxsDdJX3/H7ZeVYpDulQIT80FPCKmJNuKjhwFJmWtTvZtykQAogHXtNL9MdXPLGtw3pL
 +GptUrcDRL7oPtsQNEGsjwE6bE+HJRqHkO3GZgBc6CEevzDyF0bHmMNRsHTE9pdYSUIyjq
 upKNeblDB4jgSEWuC2DnkBbg08oahmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJ1m1CY+5yotCAkfbobTcXoVHjPVSpp0h7o/ODhYa3w=;
 b=lxJ3uf/vEh2xfSXpdZZ5qitLqMmPwR9jaKIjc0o0VKLN01weOhGstaRaZeOFoPr+udTc3Q
 zUFpzu86zMtnwdAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hKjeRZbG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=937MJ+mg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJ1m1CY+5yotCAkfbobTcXoVHjPVSpp0h7o/ODhYa3w=;
 b=hKjeRZbGogME7/CQBZdw6I88HScnoM/NVuL0ShtjPgaBgvo7FsUfUbdG6BGnYaHzGxTczH
 Hn6Q1igsBHuJckmtq+Idtil7FnLa64NNGdQvubGq6R2JIRckV7T32CRY3eceqP37nI58/4
 Xc4AFI6gtSLRPXTFn/IbJX14md1zmwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJ1m1CY+5yotCAkfbobTcXoVHjPVSpp0h7o/ODhYa3w=;
 b=937MJ+mgBdzfumeoHbJk6eqByqAh4qWwjOBK7m1DVcSxPV3KtQ3H8UhPqcimEpgFQH65Iq
 NY9xhN3jokSasIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 091C21333B;
 Fri, 25 Sep 2026 15:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T11
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 10/19] migration/rdma: Allow multiple in-flight writes per chunk
Date: Fri, 25 Sep 2026 12:40:01 -0300
Message-ID: <20260925154010.599247-11-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43E0B1F7D3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ionos.com:email,bytedance.com:email,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Yanfei Xu <yanfei.xu@bytedance.com>

qemu_rdma_write_one() waits for an earlier write that shares the same
registration chunk, even when the dirty ranges do not overlap.  This
serializes sparse writes and leaves send queue capacity unused.

RAM round notifiers now provide the completion barrier before a newer
page version can be sent, and the obsolete unregister path no longer
requires per-chunk serialization.  Remove the wait.  The global nb_sent
count continues to manage CQ and send queue resources.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c       | 19 +------------------
 migration/trace-events |  1 -
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 7d220acef8..da5dff2f9b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1769,7 +1769,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
 {
     struct ibv_sge sge;
     struct ibv_send_wr send_wr = { 0 };
-    int reg_result_idx, ret, count = 0;
+    int reg_result_idx, ret;
     uint64_t chunk, chunks;
     uint64_t chunk_size = migrate_rdma_chunk_size();
     uint8_t *chunk_start, *chunk_end;
@@ -1800,23 +1800,6 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
 
     chunk_end = ram_chunk_end(block, chunk + chunks);
 
-
-    while (test_bit(chunk, block->transit_bitmap)) {
-        (void)count;
-        trace_rdma_write_one_block(count++, current_index, chunk,
-                sge.addr, length, rdma->nb_sent, block->nb_chunks);
-
-        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
-
-        if (ret < 0) {
-            error_setg(errp, "Failed to Wait for previous write to complete "
-                    "block %d chunk %" PRIu64
-                    " current %" PRIu64 " len %" PRIu64 " %d",
-                    current_index, chunk, sge.addr, length, rdma->nb_sent);
-            return -1;
-        }
-    }
-
     if (!rdma->pin_all) {
         if (!block->remote_keys[chunk]) {
             /*
diff --git a/migration/trace-events b/migration/trace-events
index 2ee2c8f212..00ac737aa9 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -243,7 +243,6 @@ rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging memory
 rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const char *res) "Try to advise block %s prefetch at %" PRIu32 "@0x%" PRIx64 ": %s"
 rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
 rdma_write_flush(int sent) "sent total: %d"
-rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
 rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
 rdma_post_send_queue_full(uint64_t wr_id, int sent) "send queue full, wr_id=%" PRIu64 ", outstanding writes=%d"
 rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
-- 
2.53.0


