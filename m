Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F13C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3tA-0003tt-Or; Mon, 17 Aug 2026 16:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t9-0003tF-4d
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t6-0002oZ-Ac
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+ci/QG3fZnrXPNd50j1trpSFb+2ZXVy1cWz8dr7lUk=;
 b=hPq+9jcXX7f0TPeHBC1YtVwLEj07sT6ZJGK5rV1nWo8HKZXZjmRGwBs4o1wer9NOcelk/g
 yaV6333+OrGUTgUXuir8VPjzOJBD5dDKnB8YFmrBQxUAVnJ4wLXoay/u9EvdlHFHwmeG1O
 0yEyQUR6wxHhfyS7l5ne1vb8/btUmUo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-wn20YGmmPQmvUUeEP5X3Mw-1; Mon, 17 Aug 2026 16:24:44 -0400
X-MC-Unique: wn20YGmmPQmvUUeEP5X3Mw-1
X-Mimecast-MFC-AGG-ID: wn20YGmmPQmvUUeEP5X3Mw_1786998284
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d33c89a29so48388921cf.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998284; x=1787603084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o+ci/QG3fZnrXPNd50j1trpSFb+2ZXVy1cWz8dr7lUk=;
 b=LNN0k+dnZM9WZVs3xtzRgv/9wdwue6UpIpAr1MVFWpMXXeneteaitpPEfRV0srwAFI
 QNwZ9IBHUj3Q4flgLA1NMPZnwta8qh5PPWRq4o309BQYC2kx+xmFR6rHmKZiiQ2u7ltm
 RyJdv2E4p4MZn+TuVXgO9LETGWyTJeaL8dEmqEJRIyQ7lhLfayAAVf+jMlbDGeXQb/kN
 5ayr9ARHa0ErH4FkRg/mPInDD5d2l31Z+z7yrkzfd9KeiLqj2kmsn0TClU//yavMSMgb
 unrXGRA+vbHSYnlX/mrJI4Ci2CUECgStjMLAb5aYArqtOG6UAS+i1yJiYz8yBd4a1nQZ
 vTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998284; x=1787603084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o+ci/QG3fZnrXPNd50j1trpSFb+2ZXVy1cWz8dr7lUk=;
 b=IlFB761J1EGONs//GzFAGvrLBftsp44dZyAqJCoZ4+oKt8RAOZtkTRh6EbN1MUCS8H
 Kt8OSG5PgcJJnsIR1N/swaXkFVoMpP1XZsPKVpgSqbIWCiK6M2mEtKaoAO2a2gFnQ4Zi
 NUvtCcZLytxHUHHJ/6TSAMPsOjFjtnndrvL3+m4BbihaJ7fc3XIsdotHFyh24z7VEbk7
 D8zcYpw+aCVD/qATqKupEePOJ8REZHvCluRZND4aKDR0rwV+Ytztn+hEEGbjxJsKjhW+
 bB3yTom/N6zMYG0pcMa7Mk8NyKit70wRh69jantq+t/Vg5Bu+coI6o/j5yB0/YGEM7YF
 ktOw==
X-Gm-Message-State: AOJu0Yw6bjsF3u9wvRzFa73Ub93TwSg9Tmwn/axnpIsy05JDQNWnDsgW
 HyTmYnoWeikkKpdAfbuUbLev+Df9leKAUzBmCNT2WI4w/SHtBxjhPcTNOdVhfkZ+1QTfmB3e7Yk
 YeuykBj1oollztp/OMHx6SeLrVvt/r2al4f30DF/43aM6zlBVouUbHLrZmI9TWlD6Rlk45LLbn8
 MqfNviXykyaMnnZDyrpZkTsZznzFBfoQeOg7wd6Q==
X-Gm-Gg: AR+sD12n2BZuZ3x4+oy7exWEozBRIUH+t0HqnNMAyk5E0lZ8KNNUZqHLtBbGXs9nWkx
 0NvQ0IGieu7snD9CI098P+Iz/upCS3c7BfWEjPmIhicNg1X4jC8xgHhT2kGn1NMqG0MiX0TWU/e
 4Ul4U3mio5GFdxt3K2NtWnn4Pu6x9G6Rne5+Odv9DXmBu96pE7Xs5bSJVVG0M1rC64FgVpsQ1CR
 oegFcB34/TLD/XAOuIpzPATakoK4KfBGE+zkOsrivxCHkQs8tK+zyMHb87LgBDOsqfYobk9R6v4
 m+E1/TtIEQbht3KVR1zK9NIr1dUHopp56g4dVUqZuAnIU96XhRqVaTTLTmgoPqIiww==
X-Received: by 2002:a05:622a:164f:b0:52d:7b88:dbdd with SMTP id
 d75a77b69052e-52dbd7419c9mr37588041cf.31.1786998283252; 
 Mon, 17 Aug 2026 13:24:43 -0700 (PDT)
X-Received: by 2002:a05:622a:164f:b0:52d:7b88:dbdd with SMTP id
 d75a77b69052e-52dbd7419c9mr37587221cf.31.1786998282541; 
 Mon, 17 Aug 2026 13:24:42 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 03/10] migration/rdma: Stick with rdma_ prefix for all
 tracepoints
Date: Mon, 17 Aug 2026 16:24:17 -0400
Message-ID: <20260817202424.2901438-4-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817202424.2901438-1-peterx@redhat.com>
References: <20260817202424.2901438-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

There're a bunch of RDMA tracepoints that are prefixed with "rdma_*", most
of the rest with "qemu_rdma_*".  Align them up.  The "qemu_" prefix isn't
helping.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c       | 76 +++++++++++++++++++++---------------------
 migration/trace-events | 76 +++++++++++++++++++++---------------------
 2 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index eae4afd6df..ffae0a887f 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -631,7 +631,7 @@ static void qemu_rdma_init_ram_blocks(RDMAContext *rdma)
     memset(local, 0, sizeof *local);
     ret = foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
     assert(!ret);
-    trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
+    trace_rdma_init_ram_blocks(local->nb_blocks);
     rdma->dest_blocks = g_new0(RDMADestBlock,
                                rdma->local_ram_blocks.nb_blocks);
     local->init = true;
@@ -734,11 +734,11 @@ static void qemu_rdma_dump_id(const char *who, struct ibv_context *verbs)
     struct ibv_port_attr port;
 
     if (ibv_query_port(verbs, 1, &port)) {
-        trace_qemu_rdma_dump_id_failed(who);
+        trace_rdma_dump_id_failed(who);
         return;
     }
 
-    trace_qemu_rdma_dump_id(who,
+    trace_rdma_dump_id(who,
                 verbs->device->name,
                 verbs->device->dev_name,
                 verbs->device->dev_path,
@@ -759,7 +759,7 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
     char dgid[33];
     inet_ntop(AF_INET6, &id->route.addr.addr.ibaddr.sgid, sgid, sizeof sgid);
     inet_ntop(AF_INET6, &id->route.addr.addr.ibaddr.dgid, dgid, sizeof dgid);
-    trace_qemu_rdma_dump_gid(who, sgid, dgid);
+    trace_rdma_dump_gid(who, sgid, dgid);
 }
 
 /*
@@ -809,7 +809,7 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
-        trace_qemu_rdma_resolve_host_trying(rdma->host, ip);
+        trace_rdma_resolve_host_trying(rdma->host, ip);
 
         ret = rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
                 RDMA_RESOLVE_TIMEOUT_MS);
@@ -998,7 +998,7 @@ static void qemu_rdma_advise_prefetch_mr(struct ibv_pd *pd, uint64_t addr,
     ret = ibv_advise_mr(pd, advice,
                         IBV_ADVISE_MR_FLAG_FLUSH, &sg_list, 1);
     /* ignore the error */
-    trace_qemu_rdma_advise_mr(name, len, addr, strerror(ret));
+    trace_rdma_advise_mr(name, len, addr, strerror(ret));
 #endif
 }
 
@@ -1029,7 +1029,7 @@ static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma, Error **errp)
                     ibv_reg_mr(rdma->pd,
                                local->block[i].local_host_addr,
                                local->block[i].length, access);
-                trace_qemu_rdma_register_odp_mr(local->block[i].block_name);
+                trace_rdma_register_odp_mr(local->block[i].block_name);
 
                 if (local->block[i].mr) {
                     qemu_rdma_advise_prefetch_mr(rdma->pd,
@@ -1125,7 +1125,7 @@ static int qemu_rdma_register_and_get_keys(RDMAContext *rdma,
         int access = rkey ? IBV_ACCESS_LOCAL_WRITE | IBV_ACCESS_REMOTE_WRITE :
                      0;
 
-        trace_qemu_rdma_register_and_get_keys(len, chunk_start);
+        trace_rdma_register_and_get_keys(len, chunk_start);
 
         block->pmr[chunk] = ibv_reg_mr(rdma->pd, chunk_start, len, access);
         /*
@@ -1139,7 +1139,7 @@ static int qemu_rdma_register_and_get_keys(RDMAContext *rdma,
             access |= IBV_ACCESS_ON_DEMAND;
             /* register ODP mr */
             block->pmr[chunk] = ibv_reg_mr(rdma->pd, chunk_start, len, access);
-            trace_qemu_rdma_register_odp_mr(block->block_name);
+            trace_rdma_register_odp_mr(block->block_name);
 
             if (block->pmr[chunk]) {
                 qemu_rdma_advise_prefetch_mr(rdma->pd, (uintptr_t)chunk_start,
@@ -1221,7 +1221,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
 
     if (rdma->control_ready_expected &&
         (wr_id >= RDMA_WRID_RECV_CONTROL)) {
-        trace_qemu_rdma_poll_recv(wr_id - RDMA_WRID_RECV_CONTROL, wr_id,
+        trace_rdma_poll_recv(wr_id - RDMA_WRID_RECV_CONTROL, wr_id,
                                   rdma->nb_sent);
         rdma->control_ready_expected = 0;
     }
@@ -1233,7 +1233,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
             (wc.wr_id & RDMA_WRID_BLOCK_MASK) >> RDMA_WRID_BLOCK_SHIFT;
         RDMALocalBlock *block = &(rdma->local_ram_blocks.block[index]);
 
-        trace_qemu_rdma_poll_write(wr_id, rdma->nb_sent,
+        trace_rdma_poll_write(wr_id, rdma->nb_sent,
                                    index, chunk, block->local_host_addr,
                                    (void *)(uintptr_t)block->remote_host_addr);
 
@@ -1243,7 +1243,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
             rdma->nb_sent--;
         }
     } else {
-        trace_qemu_rdma_poll_other(wr_id, rdma->nb_sent);
+        trace_rdma_poll_other(wr_id, rdma->nb_sent);
     }
 
     *wr_id_out = wc.wr_id;
@@ -1378,7 +1378,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
             break;
         }
         if (wr_id != wrid_requested) {
-            trace_qemu_rdma_block_for_wrid_miss(wrid_requested, wr_id);
+            trace_rdma_block_for_wrid_miss(wrid_requested, wr_id);
         }
     }
 
@@ -1415,7 +1415,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
                 break;
             }
             if (wr_id != wrid_requested) {
-                trace_qemu_rdma_block_for_wrid_miss(wrid_requested, wr_id);
+                trace_rdma_block_for_wrid_miss(wrid_requested, wr_id);
             }
         }
 
@@ -1463,7 +1463,7 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
                                    .num_sge = 1,
                                 };
 
-    trace_qemu_rdma_post_send_control(control_desc(head->type));
+    trace_rdma_post_send_control(control_desc(head->type));
 
     /*
      * We don't actually need to do a memcpy() in here if we used
@@ -1546,10 +1546,10 @@ static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
     network_to_control((void *) rdma->wr_data[idx].control);
     memcpy(head, rdma->wr_data[idx].control, sizeof(RDMAControlHeader));
 
-    trace_qemu_rdma_exchange_get_response_start(control_desc(expecting));
+    trace_rdma_exchange_get_response_start(control_desc(expecting));
 
     if (expecting == RDMA_CONTROL_NONE) {
-        trace_qemu_rdma_exchange_get_response_none(control_desc(head->type),
+        trace_rdma_exchange_get_response_none(control_desc(head->type),
                                              head->type);
     } else if (head->type != expecting || head->type == RDMA_CONTROL_ERROR) {
         error_setg(errp, "Was expecting a %s (%d) control message"
@@ -1659,14 +1659,14 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      */
     if (resp) {
         if (callback) {
-            trace_qemu_rdma_exchange_send_issue_callback();
+            trace_rdma_exchange_send_issue_callback();
             ret = callback(rdma, errp);
             if (ret < 0) {
                 return -1;
             }
         }
 
-        trace_qemu_rdma_exchange_send_waiting(control_desc(resp->type));
+        trace_rdma_exchange_send_waiting(control_desc(resp->type));
         ret = qemu_rdma_exchange_get_response(rdma, resp,
                                               resp->type, RDMA_WRID_DATA,
                                               errp);
@@ -1679,7 +1679,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
         if (resp_idx) {
             *resp_idx = RDMA_WRID_DATA;
         }
-        trace_qemu_rdma_exchange_send_received(control_desc(resp->type));
+        trace_rdma_exchange_send_received(control_desc(resp->type));
     }
 
     rdma->control_ready_expected = 1;
@@ -1782,7 +1782,7 @@ retry:
         }
     }
 
-    trace_qemu_rdma_write_one_top(chunks + 1,
+    trace_rdma_write_one_top(chunks + 1,
                                   (chunks + 1) * chunk_size / 1024 / 1024);
 
     chunk_end = ram_chunk_end(block, chunk + chunks);
@@ -1790,7 +1790,7 @@ retry:
 
     while (test_bit(chunk, block->transit_bitmap)) {
         (void)count;
-        trace_qemu_rdma_write_one_block(count++, current_index, chunk,
+        trace_rdma_write_one_block(count++, current_index, chunk,
                 sge.addr, length, rdma->nb_sent, block->nb_chunks);
 
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
@@ -1823,7 +1823,7 @@ retry:
                 head.len = sizeof(comp);
                 head.type = RDMA_CONTROL_COMPRESS;
 
-                trace_qemu_rdma_write_one_zero(chunk, sge.length,
+                trace_rdma_write_one_zero(chunk, sge.length,
                                                current_index, current_addr);
 
                 compress_to_network(rdma, &comp);
@@ -1860,7 +1860,7 @@ retry:
             }
             reg.chunks = chunks;
 
-            trace_qemu_rdma_write_one_sendreg(chunk, sge.length, current_index,
+            trace_rdma_write_one_sendreg(chunk, sge.length, current_index,
                                               current_addr);
 
             register_to_network(rdma, &reg);
@@ -1883,7 +1883,7 @@ retry:
 
             network_to_result(reg_result);
 
-            trace_qemu_rdma_write_one_recvregres(block->remote_keys[chunk],
+            trace_rdma_write_one_recvregres(block->remote_keys[chunk],
                                                  reg_result->rkey, chunk);
 
             block->remote_keys[chunk] = reg_result->rkey;
@@ -1926,7 +1926,7 @@ retry:
     send_wr.wr.rdma.remote_addr = block->remote_host_addr +
                                 (current_addr - block->offset);
 
-    trace_qemu_rdma_write_one_post(chunk, sge.addr, send_wr.wr.rdma.remote_addr,
+    trace_rdma_write_one_post(chunk, sge.addr, send_wr.wr.rdma.remote_addr,
                                    sge.length);
 
     /*
@@ -1936,7 +1936,7 @@ retry:
     ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
 
     if (ret == ENOMEM) {
-        trace_qemu_rdma_write_one_queue_full();
+        trace_rdma_write_one_queue_full();
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
         if (ret < 0) {
             error_setg(errp, "rdma migration: failed to make "
@@ -1993,7 +1993,7 @@ static int qemu_rdma_write_flush(RDMAContext *rdma, Error **errp)
 
     if (ret == 0) {
         rdma->nb_sent++;
-        trace_qemu_rdma_write_flush(rdma->nb_sent);
+        trace_rdma_write_flush(rdma->nb_sent);
     }
 
     rdma->current_length = 0;
@@ -2109,7 +2109,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
         }
 
         rdma_disconnect(rdma->cm_id);
-        trace_qemu_rdma_cleanup_disconnect();
+        trace_rdma_cleanup_disconnect();
         rdma->connected = false;
     }
 
@@ -2292,7 +2292,7 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
      * on the source first requested the capability.
      */
     if (rdma->pin_all) {
-        trace_qemu_rdma_connect_pin_all_requested();
+        trace_rdma_connect_pin_all_requested();
         cap.flags |= RDMA_CAPABILITY_PIN_ALL;
     }
 
@@ -2343,7 +2343,7 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
         rdma->pin_all = false;
     }
 
-    trace_qemu_rdma_connect_pin_all_outcome(rdma->pin_all);
+    trace_rdma_connect_pin_all_outcome(rdma->pin_all);
 
     rdma_ack_cm_event(cm_event);
 
@@ -2412,7 +2412,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
-        trace_qemu_rdma_dest_init_trying(rdma->host, ip);
+        trace_rdma_dest_init_trying(rdma->host, ip);
         ret = rdma_bind_addr(listen_id, e->ai_dst_addr);
         if (ret < 0) {
             continue;
@@ -2547,7 +2547,7 @@ static size_t qemu_rdma_fill(RDMAContext *rdma, uint8_t *buf,
     size_t len = 0;
 
     if (rdma->wr_data[idx].control_len) {
-        trace_qemu_rdma_fill(rdma->wr_data[idx].control_len, size);
+        trace_rdma_fill(rdma->wr_data[idx].control_len, size);
 
         len = MIN(size, rdma->wr_data[idx].control_len);
         memcpy(buf, rdma->wr_data[idx].control_curr, len);
@@ -2859,7 +2859,7 @@ static int qio_channel_rdma_close(QIOChannel *ioc,
     RDMAContext *rdmain, *rdmaout;
     struct rdma_close_rcu *rcu = g_new(struct rdma_close_rcu, 1);
 
-    trace_qemu_rdma_close();
+    trace_rdma_close();
 
     rdmain = rioc->rdmain;
     if (rdmain) {
@@ -3132,11 +3132,11 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     rdma_ack_cm_event(cm_event);
 
-    trace_qemu_rdma_accept_pin_state(rdma->pin_all);
+    trace_rdma_accept_pin_state(rdma->pin_all);
 
     caps_to_network(&cap);
 
-    trace_qemu_rdma_accept_pin_verbsc(verbs);
+    trace_rdma_accept_pin_verbsc(verbs);
 
     if (!rdma->verbs) {
         rdma->verbs = verbs;
@@ -3727,13 +3727,13 @@ static void rdma_accept_incoming_migration(void *opaque)
     RDMAContext *rdma = opaque;
     QIOChannel *ioc;
 
-    trace_qemu_rdma_accept_incoming_migration();
+    trace_rdma_accept_incoming_migration();
     if (qemu_rdma_accept(rdma) < 0) {
         error_report("RDMA ERROR: Migration initialization failed");
         return;
     }
 
-    trace_qemu_rdma_accept_incoming_migration_accepted();
+    trace_rdma_accept_incoming_migration_accepted();
 
     if (rdma->is_return_path) {
         return;
diff --git a/migration/trace-events b/migration/trace-events
index d1fe8f1382..d0ad736c8c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -214,44 +214,44 @@ migrate_global_state_post_load(const char *state) "loaded state: %s"
 migrate_global_state_pre_save(const char *state) "saved state: %s"
 
 # rdma.c
-qemu_rdma_accept_incoming_migration(void) ""
-qemu_rdma_accept_incoming_migration_accepted(void) ""
-qemu_rdma_accept_pin_state(bool pin) "%d"
-qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
-qemu_rdma_block_for_wrid_miss(uint64_t wcomp, uint64_t req) "A Wanted wrid %" PRIu64 " but got %" PRIu64
-qemu_rdma_cleanup_disconnect(void) ""
-qemu_rdma_close(void) ""
-qemu_rdma_connect_pin_all_requested(void) ""
-qemu_rdma_connect_pin_all_outcome(bool pin) "%d"
-qemu_rdma_dest_init_trying(const char *host, const char *ip) "%s => %s"
-qemu_rdma_dump_id_failed(const char *who) "%s RDMA Device opened, but can't query port information"
-qemu_rdma_dump_id(const char *who, const char *name, const char *dev_name, const char *dev_path, const char *ibdev_path, int transport, const char *transport_name) "%s RDMA Device opened: kernel name %s uverbs device name %s, infiniband_verbs class device path %s, infiniband class device path %s, transport: (%d) %s"
-qemu_rdma_dump_gid(const char *who, const char *src, const char *dst) "%s Source GID: %s, Dest GID: %s"
-qemu_rdma_exchange_get_response_start(const char *desc) "CONTROL: %s receiving..."
-qemu_rdma_exchange_get_response_none(const char *desc, int type) "Surprise: got %s (%d)"
-qemu_rdma_exchange_send_issue_callback(void) ""
-qemu_rdma_exchange_send_waiting(const char *desc) "Waiting for response %s"
-qemu_rdma_exchange_send_received(const char *desc) "Response %s received."
-qemu_rdma_fill(size_t control_len, size_t size) "RDMA %zd of %zd bytes already in buffer"
-qemu_rdma_init_ram_blocks(int blocks) "Allocated %d local ram block structures"
-qemu_rdma_poll_recv(uint64_t comp, int64_t id, int sent) "completion %" PRIu64 " received (%" PRId64 ") left %d"
-qemu_rdma_poll_write(uint64_t comp, int left, uint64_t block, uint64_t chunk, void *local, void *remote) "completions %" PRIu64 " left %d, block %" PRIu64 ", chunk: %" PRIu64 " %p %p"
-qemu_rdma_poll_other(uint64_t comp, int left) "other completion %" PRIu64 " received left %d"
-qemu_rdma_post_send_control(const char *desc) "CONTROL: sending %s.."
-qemu_rdma_register_and_get_keys(uint64_t len, void *start) "Registering %" PRIu64 " bytes @ %p"
-qemu_rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging memory region: %s"
-qemu_rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const char *res) "Try to advise block %s prefetch at %" PRIu32 "@0x%" PRIx64 ": %s"
-qemu_rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
-qemu_rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending unregister chunk %" PRIu64 " at position %d"
-qemu_rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk %" PRIu64 " already in queue"
-qemu_rdma_write_flush(int sent) "sent total: %d"
-qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
-qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
-qemu_rdma_write_one_queue_full(void) ""
-qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
-qemu_rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
-qemu_rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
-qemu_rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t offset) "Entire chunk is zero, sending compress: %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
+rdma_accept_incoming_migration(void) ""
+rdma_accept_incoming_migration_accepted(void) ""
+rdma_accept_pin_state(bool pin) "%d"
+rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
+rdma_block_for_wrid_miss(uint64_t wcomp, uint64_t req) "A Wanted wrid %" PRIu64 " but got %" PRIu64
+rdma_cleanup_disconnect(void) ""
+rdma_close(void) ""
+rdma_connect_pin_all_requested(void) ""
+rdma_connect_pin_all_outcome(bool pin) "%d"
+rdma_dest_init_trying(const char *host, const char *ip) "%s => %s"
+rdma_dump_id_failed(const char *who) "%s RDMA Device opened, but can't query port information"
+rdma_dump_id(const char *who, const char *name, const char *dev_name, const char *dev_path, const char *ibdev_path, int transport, const char *transport_name) "%s RDMA Device opened: kernel name %s uverbs device name %s, infiniband_verbs class device path %s, infiniband class device path %s, transport: (%d) %s"
+rdma_dump_gid(const char *who, const char *src, const char *dst) "%s Source GID: %s, Dest GID: %s"
+rdma_exchange_get_response_start(const char *desc) "CONTROL: %s receiving..."
+rdma_exchange_get_response_none(const char *desc, int type) "Surprise: got %s (%d)"
+rdma_exchange_send_issue_callback(void) ""
+rdma_exchange_send_waiting(const char *desc) "Waiting for response %s"
+rdma_exchange_send_received(const char *desc) "Response %s received."
+rdma_fill(size_t control_len, size_t size) "RDMA %zd of %zd bytes already in buffer"
+rdma_init_ram_blocks(int blocks) "Allocated %d local ram block structures"
+rdma_poll_recv(uint64_t comp, int64_t id, int sent) "completion %" PRIu64 " received (%" PRId64 ") left %d"
+rdma_poll_write(uint64_t comp, int left, uint64_t block, uint64_t chunk, void *local, void *remote) "completions %" PRIu64 " left %d, block %" PRIu64 ", chunk: %" PRIu64 " %p %p"
+rdma_poll_other(uint64_t comp, int left) "other completion %" PRIu64 " received left %d"
+rdma_post_send_control(const char *desc) "CONTROL: sending %s.."
+rdma_register_and_get_keys(uint64_t len, void *start) "Registering %" PRIu64 " bytes @ %p"
+rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging memory region: %s"
+rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const char *res) "Try to advise block %s prefetch at %" PRIu32 "@0x%" PRIx64 ": %s"
+rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
+rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending unregister chunk %" PRIu64 " at position %d"
+rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk %" PRIu64 " already in queue"
+rdma_write_flush(int sent) "sent total: %d"
+rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
+rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
+rdma_write_one_queue_full(void) ""
+rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
+rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
+rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
+rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t offset) "Entire chunk is zero, sending compress: %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 rdma_add_block(const char *block_name, int block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Added Block: '%s':%d, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" PRIu64 " chunks %d"
 rdma_block_notification_handle(const char *name, int index) "%s at %d"
 rdma_delete_block(void *block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Deleted Block: %p, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" PRIu64 " chunks %d"
-- 
2.54.0


