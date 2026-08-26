Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6F9C61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdI-00019m-5Y; Wed, 26 Aug 2026 10:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdH-00019X-1G
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:39 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdE-0001px-PK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22BFB211C4;
 Wed, 26 Aug 2026 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5oqjmmi8+oxWLJMCwx89ZO5MoyymFjRNHN3YwHmaE8=;
 b=xFz/S35vhM3d8UFHgm2DPMOjLAUlCwy6xpW3YqJL4MUceMFzcQCADngi//L/9/r9Mp/mFg
 /YcM3UWb9ZcQ3ifa6BRVXm4bNIBjN2mLQjbvEVVJ/Shhvl42LBrhEOE63+M6Ckuwit9Nuo
 1ZzZe+71Z0uTM2PJ3i5cUPe60u/8fLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5oqjmmi8+oxWLJMCwx89ZO5MoyymFjRNHN3YwHmaE8=;
 b=hdtkxuIjbL9+RtspcTo+pTovRzEsVObbLmz2QEi/VupyRfjnvDPbhHW3n5JXcCjjBtXeik
 GnH26zZCIjMw39Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MIMXgmaA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LfMiuARa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5oqjmmi8+oxWLJMCwx89ZO5MoyymFjRNHN3YwHmaE8=;
 b=MIMXgmaAtjE4i1ZF5l6V6xVbMCWX0g/Jr4flLCSG2/yrCaxwHFrQInNxr7IPp8MPZ/Rq6L
 fkEv7Deu8NjNO4rZvKEu8mWp5mAAA9vyvPwOQeQ5O61yEG4hdbjy48TdYs5kN+v8b3qLRE
 7LgHIyztp1mGSR/qTbDQuQMm0BuLvm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5oqjmmi8+oxWLJMCwx89ZO5MoyymFjRNHN3YwHmaE8=;
 b=LfMiuARaBbyH1b7EYsbeYnNGTAvJ/PNkMsAymbU51bOyrk08o9E0zBxJ+Sbiu9hz952yro
 5SFaxR1bZmqzZZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32FD913675;
 Wed, 26 Aug 2026 14:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eA+GAUb4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 13/30] migration/rdma: Remove unregister code
Date: Wed, 26 Aug 2026 11:28:48 -0300
Message-ID: <20260826142905.2315503-14-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 22BFB211C4
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.979]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim,gitlab.com:url];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

The unregister code was there since the first commit RDMA migration was
merged, but it was never functioning.  Remove the dead code.

Since the two control messages are the last ones, we don't even need to
worry about compatibility of legacy RDMA control commands, we can directly
remove the messages too.

As a side effect, this patch closes a report by removing the code
completely.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4003
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c       | 133 -----------------------------------------
 migration/trace-events |   9 ---
 2 files changed, 142 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 62a509b2362..eae4afd6df0 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -142,8 +142,6 @@ enum {
     RDMA_CONTROL_REGISTER_REQUEST,    /* dynamic page registration */
     RDMA_CONTROL_REGISTER_RESULT,     /* key to use after registration */
     RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finished */
-    RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration */
-    RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
     RDMA_CONTROL_NUM,
 };
 
@@ -232,8 +230,6 @@ static const char *control_desc(unsigned int rdma_control)
         [RDMA_CONTROL_REGISTER_REQUEST] = "REGISTER REQUEST",
         [RDMA_CONTROL_REGISTER_RESULT] = "REGISTER RESULT",
         [RDMA_CONTROL_REGISTER_FINISHED] = "REGISTER FINISHED",
-        [RDMA_CONTROL_UNREGISTER_REQUEST] = "UNREGISTER REQUEST",
-        [RDMA_CONTROL_UNREGISTER_FINISHED] = "UNREGISTER FINISHED",
     };
 
     if (rdma_control >= RDMA_CONTROL_NUM) {
@@ -370,9 +366,6 @@ typedef struct RDMAContext {
     int total_registrations;
     int total_writes;
 
-    int unregister_current, unregister_next;
-    uint64_t unregistrations[RDMA_SIGNALED_SEND_MAX];
-
     GHashTable *blockmap;
 
     /* the RDMAContext for return path */
@@ -1186,91 +1179,6 @@ static int qemu_rdma_reg_control(RDMAContext *rdma, int idx)
     return -1;
 }
 
-/*
- * Perform a non-optimized memory unregistration after every transfer
- * for demonstration purposes, only if pin-all is not requested.
- *
- * Potential optimizations:
- * 1. Start a new thread to run this function continuously
-        - for bit clearing
-        - and for receipt of unregister messages
- * 2. Use an LRU.
- * 3. Use workload hints.
- */
-static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
-{
-    Error *err = NULL;
-
-    while (rdma->unregistrations[rdma->unregister_current]) {
-        int ret;
-        uint64_t wr_id = rdma->unregistrations[rdma->unregister_current];
-        uint64_t chunk =
-            (wr_id & RDMA_WRID_CHUNK_MASK) >> RDMA_WRID_CHUNK_SHIFT;
-        uint64_t index =
-            (wr_id & RDMA_WRID_BLOCK_MASK) >> RDMA_WRID_BLOCK_SHIFT;
-        RDMALocalBlock *block =
-            &(rdma->local_ram_blocks.block[index]);
-        RDMARegister reg = { .current_index = index };
-        RDMAControlHeader resp = { .type = RDMA_CONTROL_UNREGISTER_FINISHED,
-                                 };
-        RDMAControlHeader head = { .len = sizeof(RDMARegister),
-                                   .type = RDMA_CONTROL_UNREGISTER_REQUEST,
-                                   .repeat = 1,
-                                 };
-
-        trace_qemu_rdma_unregister_waiting_proc(chunk,
-                                                rdma->unregister_current);
-
-        rdma->unregistrations[rdma->unregister_current] = 0;
-        rdma->unregister_current++;
-
-        if (rdma->unregister_current == RDMA_SIGNALED_SEND_MAX) {
-            rdma->unregister_current = 0;
-        }
-
-
-        /*
-         * Unregistration is speculative (because migration is single-threaded
-         * and we cannot break the protocol's inifinband message ordering).
-         * Thus, if the memory is currently being used for transmission,
-         * then abort the attempt to unregister and try again
-         * later the next time a completion is received for this memory.
-         */
-        clear_bit(chunk, block->unregister_bitmap);
-
-        if (test_bit(chunk, block->transit_bitmap)) {
-            trace_qemu_rdma_unregister_waiting_inflight(chunk);
-            continue;
-        }
-
-        trace_qemu_rdma_unregister_waiting_send(chunk);
-
-        ret = ibv_dereg_mr(block->pmr[chunk]);
-        block->pmr[chunk] = NULL;
-        block->remote_keys[chunk] = 0;
-
-        if (ret != 0) {
-            error_report("unregistration chunk failed: %s",
-                         strerror(ret));
-            return -1;
-        }
-        rdma->total_registrations--;
-
-        reg.key.chunk = chunk;
-        register_to_network(rdma, &reg);
-        ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
-                                      &resp, NULL, NULL, &err);
-        if (ret < 0) {
-            error_report_err(err);
-            return -1;
-        }
-
-        trace_qemu_rdma_unregister_waiting_complete(chunk);
-    }
-
-    return 0;
-}
-
 static uint64_t qemu_rdma_make_wrid(uint64_t wr_id, uint64_t index,
                                          uint64_t chunk)
 {
@@ -2757,8 +2665,6 @@ static int qemu_rdma_drain_cq(RDMAContext *rdma)
         }
     }
 
-    qemu_rdma_unregister_waiting(rdma);
-
     return 0;
 }
 
@@ -3336,10 +3242,6 @@ int rdma_registration_handle(QEMUFile *f)
                                .type = RDMA_CONTROL_REGISTER_RESULT,
                                .repeat = 0,
                              };
-    RDMAControlHeader unreg_resp = { .len = 0,
-                               .type = RDMA_CONTROL_UNREGISTER_FINISHED,
-                               .repeat = 0,
-                             };
     RDMAControlHeader blocks = { .type = RDMA_CONTROL_RAM_BLOCKS_RESULT,
                                  .repeat = 1 };
     QIOChannelRDMA *rioc;
@@ -3552,41 +3454,6 @@ int rdma_registration_handle(QEMUFile *f)
             ret = qemu_rdma_post_send_control(rdma,
                             (uint8_t *) results, &reg_resp, &err);
 
-            if (ret < 0) {
-                error_report_err(err);
-                goto err;
-            }
-            break;
-        case RDMA_CONTROL_UNREGISTER_REQUEST:
-            trace_rdma_registration_handle_unregister(head.repeat);
-            unreg_resp.repeat = head.repeat;
-            registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
-
-            for (int count = 0; count < head.repeat; count++) {
-                reg = &registers[count];
-                network_to_register(reg);
-
-                trace_rdma_registration_handle_unregister_loop(count,
-                           reg->current_index, reg->key.chunk);
-
-                block = &(rdma->local_ram_blocks.block[reg->current_index]);
-
-                ret = ibv_dereg_mr(block->pmr[reg->key.chunk]);
-                block->pmr[reg->key.chunk] = NULL;
-
-                if (ret != 0) {
-                    error_report("rdma unregistration chunk failed: %s",
-                                 strerror(errno));
-                    goto err;
-                }
-
-                rdma->total_registrations--;
-
-                trace_rdma_registration_handle_unregister_success(reg->key.chunk);
-            }
-
-            ret = qemu_rdma_post_send_control(rdma, NULL, &unreg_resp, &err);
-
             if (ret < 0) {
                 error_report_err(err);
                 goto err;
diff --git a/migration/trace-events b/migration/trace-events
index 4ae1c226f90..6d70f8e8cad 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -242,12 +242,6 @@ qemu_rdma_register_and_get_keys(uint64_t len, void *start) "Registering %" PRIu6
 qemu_rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging memory region: %s"
 qemu_rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const char *res) "Try to advise block %s prefetch at %" PRIu32 "@0x%" PRIx64 ": %s"
 qemu_rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
-qemu_rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending unregister chunk %" PRIu64 " at position %d"
-qemu_rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk %" PRIu64 " already in queue"
-qemu_rdma_unregister_waiting_inflight(uint64_t chunk) "Cannot unregister inflight chunk: %" PRIu64
-qemu_rdma_unregister_waiting_proc(uint64_t chunk, int pos) "Processing unregister for chunk: %" PRIu64 " at position %d"
-qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregister for chunk: %" PRIu64
-qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for chunk: %" PRIu64 " complete."
 qemu_rdma_write_flush(int sent) "sent total: %d"
 qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
 qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
@@ -266,9 +260,6 @@ rdma_registration_handle_ram_blocks_loop(const char *name, uint64_t offset, uint
 rdma_registration_handle_register(int requests) "%d requests"
 rdma_registration_handle_register_loop(int req, int index, uint64_t addr, uint64_t chunks) "Registration request (%d): index %d, current_addr %" PRIu64 " chunks: %" PRIu64
 rdma_registration_handle_register_rkey(int rkey) "0x%x"
-rdma_registration_handle_unregister(int requests) "%d requests"
-rdma_registration_handle_unregister_loop(int count, int index, uint64_t chunk) "Unregistration request (%d): index %d, chunk %" PRIu64
-rdma_registration_handle_unregister_success(uint64_t chunk) "%" PRIu64
 rdma_registration_handle_wait(void) ""
 rdma_registration_start(uint64_t flags) "%" PRIu64
 rdma_registration_stop(uint64_t flags) "%" PRIu64
-- 
2.53.0


