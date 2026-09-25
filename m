Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226DFC98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8S6-0007AE-00; Fri, 25 Sep 2026 12:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DQ-0007pU-PV
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:02 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DO-0005wF-7D
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:00 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so6339935e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351517; x=1790956317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BQTziWc8i9CyJZknsQwFL2OKVJrU1qwkxlEOdcl+8cU=;
 b=EGfr/On3A52ZGPgAAGoII/3WbCP4TPpZa4oEYgFvfPQFdP1UhzMX4XpUlmZTjRC+eW
 oyOaAinCE7+JJ+yWhpCM1FgvtKPWVuws+ZWrXtunQ7VC8YpvDBo/5bdl5zwBUCCr5lyb
 Za4T5teUr4Gy5LEdU0oI7bSJo0aZJe3o9A/tFdo8ycWOp6Su8rXK3UrItft5CV9cklsu
 vSp1FwonuAUnf4Bnxc2XDko5P2JzGFn3XwsVgC1fjWGk0VUf4OMZp0ic5lxVtY3ErStA
 281oYeAzDFx2/PcDNehYh68yr2+EaOTr9QLk7J3OUr2a+xVQW6lmW8ESGrPL6d6hQbFH
 WeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351517; x=1790956317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BQTziWc8i9CyJZknsQwFL2OKVJrU1qwkxlEOdcl+8cU=;
 b=LJLI0D9IBsqXquShVVoGw2eSc1O9BDxR/HNIQeVBzoPQM7X9t/NbpH2a3nBU9S5Vo2
 /4nnigXrT51JWr1mYOMQlHB9PMGHjjdo9vL5PIqcjy7DeWmzMuTmdGpqG1UWmLrLu4zg
 JEqpdT1syv5kW4w9aP0rGcC8oqyCp2jQ2NL/4Y3ROHxqvmIQPzZ8oxWyiVmWKTJ80GRq
 I/c7W6BlLIiRH0Kg57lC+TFAhPSUiLZNqlMPZFNaIxnrW4JEaZ7h+1n6Fl/6DtMyszKA
 HbHXsmxVHOxXIoV0r01/mDmQxO0qLyDrnAQvTRg32CBCKcpWcDSWWkSI00BYFxTwFPXT
 Tm6A==
X-Gm-Message-State: AFuF++lZv1DaayoK977G0rwV7xyeDBLgVQ9qpD5FlhyJBB8/xaoSHy1b
 uK2tfbPh2xuljnvMmBeOySKGbR7kDmr3GtFct9yyIDNl9RM9n4NRQC2CGDhkLTHs0HOAFuz38AK
 bXlbN8WLU6g==
X-Gm-Gg: AYBFou3NjzPTgS2C4X2WMGe48n2yUBL2zIdGq7mTbFNZ8S9XO7EA3BT0j8tInh7yGV0
 UyQkODy9rUyPRWGnejaGbLcxAm9LOT8CN40FSMry4iZGr/PFrw3ZwMKvmwhg1YlsOTHcXtWUV2c
 sIkvprAlVCb57OQgYZ0yw5i05HZVwLLKBFzb8WNMqNMkVLlMzF1RbD2PeqlvWvsGvFoDY1RUn1X
 G1L1+wo4xzczatTc6TNqbFDGK4nrY6DEIOgNkhG282qINf6CLfVE6w/P2uyWCk45fZXAjcu/fQO
 RebxfCDi0fjk48faCN+UafHoqvdWTj2wzqq4LTkpKcIXDv5IrsMzm/Kc5Z11gjqQfhHfPyDzJt6
 hVye4SfVvB/082a3HzuQ56cdbuvY3CyaPnI8rvyCz7j3HXoUQLCF4+nJ7hAP3ikNY66eAV+NyZT
 KhXH948ezFqqhkCfO3lr47B/xPxFMjUG3igxgjj/Rq74fKxIDX+Q5dP0aXYwuJG+rzhGl29KPLx
 81S2Xkr4Tss5xBxNbXpHR+BKSfWfjgVxZCtg6kmhQ==
X-Received: by 2002:a05:600c:4f10:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49fe66d09c5mr125779165e9.13.1790351516791; 
 Fri, 25 Sep 2026 08:51:56 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:51:56 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 01/13] migration/rdma: Add nb_sent send-queue-depth stats
Date: Fri, 25 Sep 2026 17:51:36 +0200
Message-ID: <20260925155149.843870-2-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:31::11;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:04:40 -0400
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

Track whole-migration counters for the RDMA send queue: peak nb_sent
(max outstanding writes), the number of posts, how many posts hit a
full send queue, and how many times the queue drained to zero.  Reset
at RAM_CONTROL_SETUP and dumped at RAM_CONTROL_FINISH; migration-thread
only, no locking.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c       | 60 ++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  1 +
 2 files changed, 61 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 444123cbca..50f5d7b839 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -302,6 +302,12 @@ typedef struct RDMAContext {
     /* number of outstanding writes */
     int nb_sent;
 
+    /* nb_sent statistics */
+    uint64_t nbsent_max;            /* peak outstanding writes */
+    uint64_t nbsent_posts;          /* posts (nb_sent++) */
+    uint64_t nbsent_full_hits;      /* posts that hit a full SQ */
+    uint64_t nbsent_zero_hits;      /* drains to zero */
+
     /* store info about current buffer so that we can
        merge it with future sends */
     uint64_t current_addr;
@@ -1164,6 +1170,11 @@ static uint64_t qemu_rdma_make_wrid(uint64_t wr_id, uint64_t index,
     return result;
 }
 
+/* nb_sent statistics counters */
+static void rdma_nbsent_inc(RDMAContext *rdma, uint64_t nb_sent);
+static void rdma_nbsent_full(RDMAContext *rdma);
+static void rdma_nbsent_zero(RDMAContext *rdma);
+
 /*
  * Consult the connection manager to see a work request
  * (of any kind) has completed.
@@ -1213,6 +1224,9 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
 
         if (rdma->nb_sent > 0) {
             rdma->nb_sent--;
+            if (rdma->nb_sent == 0) {
+                rdma_nbsent_zero(rdma);
+            }
         }
     } else {
         trace_rdma_poll_other(wr_id, rdma->nb_sent);
@@ -1438,6 +1452,7 @@ static bool qemu_rdma_post_send(RDMAContext *rdma,
     ret = ibv_post_send(rdma->qp, send_wr, &bad_wr);
     if (ret == ENOMEM && rdma->nb_sent) {
         trace_rdma_post_send_queue_full(send_wr->wr_id, rdma->nb_sent);
+        rdma_nbsent_full(rdma);
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
         if (ret < 0) {
             error_setg(errp, "rdma migration: failed to make room for %s",
@@ -1953,6 +1968,7 @@ static int qemu_rdma_write_flush(RDMAContext *rdma, Error **errp)
     if (ret == 0) {
         rdma->nb_sent++;
         trace_rdma_write_flush(rdma->nb_sent);
+        rdma_nbsent_inc(rdma, rdma->nb_sent);
     }
 
     rdma->current_length = 0;
@@ -2998,6 +3014,41 @@ err:
     return -1;
 }
 
+static void rdma_nbsent_inc(RDMAContext *rdma, uint64_t nb_sent)
+{
+    rdma->nbsent_posts++;
+    if (nb_sent > rdma->nbsent_max) {
+        rdma->nbsent_max = nb_sent;
+    }
+}
+
+static void rdma_nbsent_full(RDMAContext *rdma)
+{
+    rdma->nbsent_full_hits++;
+}
+
+static void rdma_nbsent_zero(RDMAContext *rdma)
+{
+    rdma->nbsent_zero_hits++;
+}
+
+static void rdma_stats_reset(RDMAContext *rdma)
+{
+    rdma->nbsent_max = 0;
+    rdma->nbsent_posts = 0;
+    rdma->nbsent_full_hits = 0;
+    rdma->nbsent_zero_hits = 0;
+}
+
+static void rdma_nbsent_stats_dump(RDMAContext *rdma)
+{
+    if (rdma->nbsent_posts == 0) {
+        return;
+    }
+    trace_rdma_nbsent_stats(rdma->nbsent_max, rdma->nbsent_posts,
+                            rdma->nbsent_full_hits, rdma->nbsent_zero_hits);
+}
+
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
@@ -3547,6 +3598,10 @@ int rdma_registration_start(QEMUFile *f, uint64_t flags)
         return -1;
     }
 
+    if (flags == RAM_CONTROL_SETUP) {
+        rdma_stats_reset(rdma);
+    }
+
     trace_rdma_registration_start(flags);
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
     return qemu_fflush(f);
@@ -3581,6 +3636,11 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
     }
 
     qemu_fflush(f);
+
+    if (flags == RAM_CONTROL_FINISH) {
+        rdma_nbsent_stats_dump(rdma);
+    }
+
     ret = qemu_rdma_write_flush(rdma, &err);
 
     if (ret < 0) {
diff --git a/migration/trace-events b/migration/trace-events
index db911fe6f2..f8ed6a7250 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -245,6 +245,7 @@ rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
 rdma_write_flush(int sent) "sent total: %d"
 rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
 rdma_post_send_queue_full(uint64_t wr_id, int sent) "send queue full, wr_id=%" PRIu64 ", outstanding writes=%d"
+rdma_nbsent_stats(uint64_t max, uint64_t posts, uint64_t full_hits, uint64_t zero_hits) "nb_sent max %" PRIu64 " posts %" PRIu64 " full-queue hits %" PRIu64 " drains to zero %" PRIu64
 rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
 rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
-- 
2.39.5


