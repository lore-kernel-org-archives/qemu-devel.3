Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF664C5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3tC-0003uU-Hd; Mon, 17 Aug 2026 16:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3tA-0003te-C8
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t8-0002ov-4t
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AxFMx68HiZkg/5ZsboY7tWGZAkM5LcruXgOrrhMnrcI=;
 b=AX973TBpeEh6WbgrYRGZlo1pcD/29jKciLRd4gPZumv8XnUtdANLBnCOFyMLcrgRpSW01Q
 k4m5gQ4j2nAU1y36Y1aT06Rvpq9zs9qdGW25AiFr0tFTQ2TLI3d1uyDDoqNb28hi3GHQyf
 ZWv/LILJhoOhy5RntwRBa/UZJZfM30g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-wb5LXDniPxuBh0DC6NDRWg-1; Mon, 17 Aug 2026 16:24:42 -0400
X-MC-Unique: wb5LXDniPxuBh0DC6NDRWg-1
X-Mimecast-MFC-AGG-ID: wb5LXDniPxuBh0DC6NDRWg_1786998281
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c07f25de2so31423691cf.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998281; x=1787603081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AxFMx68HiZkg/5ZsboY7tWGZAkM5LcruXgOrrhMnrcI=;
 b=c8uMwTS51rpGdf2bZmwBCIbxLeXsyBswHMy/kiNPXlJrIhGcPNYgx5Kr5nM6RiRJu+
 +m1OusR5UTc0qa8Ntc775VjXsQ7Sf50VXePj/P1nM5cl/xRdQMnbgtoAp7rA6JpreJBc
 eTctsBD4M5vktz6q0X3JcVSoSK8rohxEU9yl1bnnGG3falOU/wkmbgeIUfoB/wmMGaCL
 0pA7aouY/84vYIYf4z4vEpSGbEu9ak6aRJIFyrg0kHJ0oYBTjt+3u2a8t4wtz5GKoOmd
 vNf0bm0DcNtNB1Zulj6GFXrNms4uVjYejnHRNuvZFWMkME/YoCGR2X1edLZ1R3a8OREJ
 8auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998281; x=1787603081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AxFMx68HiZkg/5ZsboY7tWGZAkM5LcruXgOrrhMnrcI=;
 b=GW7ukiO3qv/YIulbkCXWfJGAvSTCiagPC7b/nRscoowD0CM2fdWy7nPKwBd9diFn/I
 HJWlxSMRRf4xmMjMmwd0COJIXuslaJfUyl6y/DLkz3OS9quEsgnys0SEHVdcLywCxKHK
 gk6k3EFAeRx2fO83tyAOblfTU1wMLLVUYd+LYEnpLfgCFPMjVn03M5FXg826QJnHeKWa
 j9eKj2hGw/tCaCYuHKjNtQA2xzgm/W4fRHdnQjhPFM3LinOFJneK5L4j1jraF3Gzl8vP
 EQA8XUhZ0Oy+VPT5d8P/hgbJkcmq15S3hYkLOOrvUkHOfmyMU0sFaiR2qiRxUFKAnRVU
 0/vQ==
X-Gm-Message-State: AOJu0Ywf7urQmH5/5Qvr41I173/Wyq3nErW0TRn1RGs8QjVXmn4MJcgH
 r0k/Tw342d/PYkiTvjjtExMqECVhk0N3gTqcBHWfkEBNmOsQVsjdkT9v/TJPD1DmUc4CibzE/Z5
 PGtur6s7ebwzp2UL87JWDjxMUvOGnvVAk4uB/aK4nyxInYXKjHd8FY9rpW6mEjlTLhF4KGJ3Ssb
 LjqpmcVgWkNzUAitiynKK9lLxesQtsYqcjTEaX8Q==
X-Gm-Gg: AR+sD10AtLdnaEBRi6fXjdoEfIVM+MBzOSxDI0Gg3Rle/2HhmCXFVXEeAyMsWUZ+V3q
 e87f5gQDh4LRIk+sHGoecx9j+R4y1tlGqBAdaMyUNzAsAWN+LF/iNeDCcUCx8ULaW8orwW3yHFv
 Wtph88YHTzHVrGe3z73jwRG40OYluA5u//71lGwdaB0BytRcK0ezffn/m6J/LFdRvMmnNATfA/M
 eWYuNULawmyPIu0ewf5QpEndrqAUOKfo9Dpb2CZKFwI6ZRGHhqeMy5sSDS8hvbdEUG22HaebGZm
 TsY60iUH3PPXZfPOiXfw0DPy92PZ7LMCu8SOsQzADz78tov4IX7lGG/vQTZZmCaopA==
X-Received: by 2002:a05:622a:4c15:b0:51c:805:1be3 with SMTP id
 d75a77b69052e-52d8556685bmr329388951cf.31.1786998281295; 
 Mon, 17 Aug 2026 13:24:41 -0700 (PDT)
X-Received: by 2002:a05:622a:4c15:b0:51c:805:1be3 with SMTP id
 d75a77b69052e-52d8556685bmr329388341cf.31.1786998280721; 
 Mon, 17 Aug 2026 13:24:40 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 02/10] migration/rdma: Remove unregister code
Date: Mon, 17 Aug 2026 16:24:16 -0400
Message-ID: <20260817202424.2901438-3-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817202424.2901438-1-peterx@redhat.com>
References: <20260817202424.2901438-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The unregister code was there since the first commit RDMA migration was
merged, but it was never functioning.  Remove the dead code.

Since the two control messages are the last ones, we don't even need to
worry about compatibility of legacy RDMA control commands, we can directly
remove the messages too.

As a side effect, this patch closes a report by removing the code
completely.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4003
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c       | 133 -----------------------------------------
 migration/trace-events |   7 ---
 2 files changed, 140 deletions(-)

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
index af0e784535..d1fe8f1382 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -244,10 +244,6 @@ qemu_rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const char *r
 qemu_rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
 qemu_rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending unregister chunk %" PRIu64 " at position %d"
 qemu_rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk %" PRIu64 " already in queue"
-qemu_rdma_unregister_waiting_inflight(uint64_t chunk) "Cannot unregister inflight chunk: %" PRIu64
-qemu_rdma_unregister_waiting_proc(uint64_t chunk, int pos) "Processing unregister for chunk: %" PRIu64 " at position %d"
-qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregister for chunk: %" PRIu64
-qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for chunk: %" PRIu64 " complete."
 qemu_rdma_write_flush(int sent) "sent total: %d"
 qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
 qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
@@ -266,9 +262,6 @@ rdma_registration_handle_ram_blocks_loop(const char *name, uint64_t offset, uint
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


