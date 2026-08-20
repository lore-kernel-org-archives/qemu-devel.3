Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D4DC5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8zA-0008Jg-Gd; Thu, 20 Aug 2026 16:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8z8-0008IX-Ps
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8z6-00053L-K2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXssvW0f/nZKgfGpqNRv4nCLIOwfmxQJyYdBljGzBvI=;
 b=hpiZkE/mi2j8MDJ6e6xKM4XElDMXLWD88xMv+nxSUFTv+kwssgwTm0+RNTVF8UeTGTHAih
 l8K7fqxOs4aItdCLIOB/BvcFx6PO800UsbMmcr0LpJXQBeutrW57tGp2HupusKIshOhwbC
 MHYxqX4aO+M3n6CUeI0C2wKtAG4epQ4=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-GIIrz19wPDGPaCzoFV5iJg-1; Thu, 20 Aug 2026 16:03:30 -0400
X-MC-Unique: GIIrz19wPDGPaCzoFV5iJg-1
X-Mimecast-MFC-AGG-ID: GIIrz19wPDGPaCzoFV5iJg_1787256210
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-4574f1cac98so302486fac.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787256210; x=1787861010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EXssvW0f/nZKgfGpqNRv4nCLIOwfmxQJyYdBljGzBvI=;
 b=IzpE4azhhnoqhBVKWDIXS9yTqABGJpoj8pJ6vvKAxN2DdPp7udR4HW7vBxMoNsiEgd
 OJ6EZa3qdjVVU1rPUHOJkbZAIH34C0zQrC/ozxM0Lt4eNI0dFddqaEymRZjdzk3SWU/o
 0TTPnuwxYIQOWsJ0zBdtxNbLmpryWfzzR2ZVSS2Wr/NJzBX5ebG0hnbXmhuZ0Zt4u1M6
 MkUD0VIRy6HTzg0wxISA3rNJW5E3qNTCUWgInrkxtfoZ+WqjDjdFMXaZxZxsxT3hifAZ
 0T2gJNaQAnRYz7XwrSYQ1zd2fkDcEOsgE6F9/roU1qzevS9/kh9K3UmPgGoVcHxSN8we
 uMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256210; x=1787861010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EXssvW0f/nZKgfGpqNRv4nCLIOwfmxQJyYdBljGzBvI=;
 b=FE4084gsPIeq4EFx3NGD86rZ9Nk1BnwcE1I7oUoBYeIwdE2G1D4RNnNzUivPHcdgWo
 mNgOVu5gTvTor1wzASlq/tbbIpqRXl53fryYb3aBVWEEWaevTBrxfzGkRSI9X8JnYFgd
 XPd8dY3rtwNPUMiARj/acjDp1zJt1WCGpOxvA459Q4tlvTJbMm2I/pDEwD1qV7TuSou+
 viyRkhNbrkTTxAyTRseV9ji9tj/qU/Cl+NHebccXQuvyW32bxW8kQcfB40TLVmMPfWmr
 1F+Qt9iMemE5hsgBZyQwgb5FpBwqlJ3Da1LD0DDab2WadmwAnKE3Ohtuuc2UxiswwSs7
 P7vQ==
X-Gm-Message-State: AOJu0YwNer0Ui9lT+xCCe6OOsTvog3tmkZbQrhDTJ6gEqzJqgYX3lftz
 PosUB2Xpvwab6MvnukN6KbNYRhytOQgWAdmWTC3Md+BP1GQjgJXSDNKDS5u371Sb/Sv5bH3Ydiv
 YdteHk2ttvyeZdvjfG81PbRLeFjemfYubnQL1kIG5AeSosxvMkvhYXL41QsGYYxjBJjrwfGctPG
 zYqKJxiUztUfLP4QRvtgFPenkEm1qRCP42SSQAxg==
X-Gm-Gg: AR+sD11+D7jpBOWaVJ+IrCPVxp3WH1HPCzOEAAteN70hLFf5cXyzymdkHNu9msy0TAx
 TmVVD3Qz4drKxYKFnBpYJtqpLeG8oRMNQLtDU5fucPTn9gee2DOBFofYN0D3xLP4FuAj5RioK/6
 jNl6tX0jCPecGZ07+T/+kzITepGKT3PxOf5Bu0dXcY7m3tmS6DiVNMwWwuFFxXjDkl3zvYjaq+R
 PVLkq8abFvp1rEg2pIJ5WzhlqRy0BtmSbbS/Qfvym3z3NEiJpwiTQ2Bo9A2CBYsfEuEEVAsiSnj
 5a8XJKa0ENmb8JZEVV6dy87Rm50Pv2X+s0MOAzwnozviW1VUC+sJttl1Pnk69DHUWd6bO3IMmok
 C1dCoU2ZNVdY4Y94D4Dig7BsVQyxe5XhyzJUIhjoR2QyLOiWvXoxIlIHNdn4=
X-Received: by 2002:a05:6820:1990:b0:6aa:e854:d05d with SMTP id
 006d021491bc7-6b15918ff0dmr1326719eaf.3.1787256209744; 
 Thu, 20 Aug 2026 13:03:29 -0700 (PDT)
X-Received: by 2002:a05:6820:1990:b0:6aa:e854:d05d with SMTP id
 006d021491bc7-6b15918ff0dmr1326605eaf.3.1787256209140; 
 Thu, 20 Aug 2026 13:03:29 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb2esm6181314eaf.10.2026.08.20.13.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:03:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Samuel Zhang <guoqing.zhang@amd.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v2 02/10] migration/rdma: Remove unregister code
Date: Thu, 20 Aug 2026 16:03:14 -0400
Message-ID: <20260820200322.3321036-3-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820200322.3321036-1-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 migration/rdma.c       | 133 -----------------------------------------
 migration/trace-events |   9 ---
 2 files changed, 142 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 62a509b236..eae4afd6df 100644
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
index 4ae1c226f9..6d70f8e8ca 100644
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
2.54.0


