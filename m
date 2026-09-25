Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76255C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8R0-000600-0C; Fri, 25 Sep 2026 12:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Da-0007sW-TS
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:10 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DZ-0005xq-6I
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:10 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48882c1f261so204211f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351528; x=1790956328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RpbJfFtFXtW5DVtUKxFYbq48SJgv8dFmBAbxHxL31/s=;
 b=NO43u7dqx5+MMu+oUdCpWXTFnrnql4KZLXB2Ns6gqlvO9afixA+i2j0rMmQqXHuzM0
 jGMhHLPcNlAILF1RwvENN2gX7ZFVZD1sD0Kz7WKs5KFgU/8hyh4WWQSCSVPxrtnRBBC7
 dzqmX2PONfifZrOJKUniIQUKA+1Y6Op7ukOptOlSMIz6l6daDnwqBeTtb5rK0LGWw+Up
 /Sh56rtImiSHhbhX/TNo6u94qe2ItikQ8/JNYgWFQru/yAVoSqqLh3yJY9Vi9yOC4llF
 +seOHKzTj6896TEfjs6Fj89qGrqOLxz+eQdak/783//E8xn6REqMhFKOZTfGQO2aTj0V
 X/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351528; x=1790956328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RpbJfFtFXtW5DVtUKxFYbq48SJgv8dFmBAbxHxL31/s=;
 b=t9HwT3v/isr26bf8haTbS+yPUI9sOgI2Q9zFim+Xmpf2PN+IM3J054MmPql2CF7gpY
 eBujblVD4aEUnivjFJiUUUAT4L6D4sKmuNMBkzQOXqTYs51KQVDbR8zxMr8008DVcy63
 GaaGQ5W26jMKdSzNzGAOm/bS8wxVGNhh5A7eCqY/sBSYB74ilKAVhCstq1aFW/ZiLSJ2
 aZTXpZhRrXHxhg4hxPSGhYViF123d/qlayHZc1mpT29RBDLm4PEN9hR34XIAsN1mFEvc
 GPy0YdxGl1tg6JJod39JsVRI5r9cn7hDqK/SVr+IgOy3vezbimDnEWLuUtxwEUg3cxOp
 4x+g==
X-Gm-Message-State: AFuF++nIe7Q8JweDzsBz3FG+b7IutGw5L8hcaBtp2mE7P3jaKXNIbGDc
 pGYOAeathY1EFDBtsjC5RpQq+wO1cc+h4Ub+danYQuL8mCY1p1BxIyFA5YpDpCrL4nCMDNiUvsP
 74CUMZBC5kQ==
X-Gm-Gg: AYBFou3kF9s6jepNyvzJQVRXnXupVmjS73hAlCpA9EaIGunfwgijG3afBhMTfQ4ZUxy
 0j9j4p7DB1aJxeLqUPc7cfHMIt4BhQ1JTK3Kse4/er9MUq54k8EQI1kebyHuixvkBjxYpuBaVQE
 GDoHqomCpvjrjAfiTh4NR8Sb+84sbmCYXRtR0hW5Ba8ZYQueBm7aVnOMozoM1gMURk+4NMQSj3/
 JjD56JPz17kmvqvqhcs00MpaumahVOxf75cG7OhWTQ5QonpHbzPRjExI5PwVevli3Mj975hHuFx
 wc489RQWo57ABXB2NjOtAlBvRdWwhifh4MjKA0DNP9Gv21wwdFgmXORAarfHghiukdP3Eki3P/E
 NHkt0AQQLDM4O6yai7NeaAQHsm57jxohfpVoMwpcIbU6k6p+SNzyqwSS3bHnRDK9wK5k+P3QxtD
 gSKpDbcrsDKdDH+uCHhLuI/6XO9UAZo6Z//6vHFV6nNSjJlckRQWRm3a4zZ+aCgpMyRJMDF8gl3
 4ZYfRJkA3Fjy549DvmU6SCi5fcM6S7+zVyvJDjvQGpUqGjNRjm9
X-Received: by 2002:a05:600c:4e8f:b0:49e:7c8c:bc77 with SMTP id
 5b1f17b1804b1-49fe66d062bmr110866185e9.7.1790351527744; 
 Fri, 25 Sep 2026 08:52:07 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:07 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 05/13] migration/rdma: Handle write/flush/reg-stop on the
 consumer
Date: Fri, 25 Sep 2026 17:51:40 +0200
Message-ID: <20260925155149.843870-6-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:30::f;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:04:59 -0400
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

Extend rdma_consumer_dispatch to run the real send work off the ring:
RDMA_CMD_WRITE posts one chunk via qemu_rdma_write_chunk, RDMA_CMD_FLUSH
drains the CQ, and RDMA_CMD_REG_STOP sends REGISTER_FINISHED (draining
and dumping stats first on FINISH).  The thread acks barrier commands
via ring_barrier_complete.  The producer still drives the old inline
path, so the ring still carries only FINISH.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index c3070b7a92..d11f6e0da8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1216,6 +1216,7 @@ static void rdma_nbsent_zero(RDMAContext *rdma);
 
 static void rdma_consumer_start(RDMAContext *rdma);
 static void rdma_consumer_stop(RDMAContext *rdma);
+static void rdma_nbsent_stats_dump(RDMAContext *rdma);
 
 /*
  * Consult the connection manager to see a work request
@@ -1986,6 +1987,33 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
     return 0;
 }
 
+/* Consumer: write one whole chunk */
+static int qemu_rdma_write_chunk(RDMAContext *rdma, uint32_t block_index,
+                                 uint32_t chunk_index, Error **errp)
+{
+    RDMALocalBlock *block = &rdma->local_ram_blocks.block[block_index];
+    uint64_t chunk_off = (uint64_t)chunk_index * migrate_rdma_chunk_size();
+    uint64_t len = block->length - chunk_off;
+    int ret;
+
+    if (len > migrate_rdma_chunk_size()) {
+        len = migrate_rdma_chunk_size();
+    }
+
+    /* write_one wants current_addr in ram_addr_t space (block->offset based) */
+    ret = qemu_rdma_write_one(rdma, block_index, block->offset + chunk_off,
+                              len, errp);
+    if (ret < 0) {
+        return -1;
+    }
+    if (ret == 0) {
+        rdma->nb_sent++;
+        trace_rdma_write_flush(rdma->nb_sent);
+        rdma_nbsent_inc(rdma, rdma->nb_sent);
+    }
+    return 0;
+}
+
 /*
  * Push out any unwritten RDMA operations.
  *
@@ -2846,6 +2874,13 @@ static void ring_advance_tail(RDMASendRing *r)
     ring_wake_producer(r);
 }
 
+/* Consumer: publish barrier completion. */
+static void ring_barrier_complete(RDMASendRing *r, unsigned seq)
+{
+    qatomic_store_release(&r->barrier_done_seq, seq);
+    ring_wake_producer(r);
+}
+
 /* Consumer: sleep until the ring is non-empty or aborted. */
 static void ring_idle_wait(RDMASendRing *r)
 {
@@ -2859,6 +2894,23 @@ static void ring_idle_wait(RDMASendRing *r)
     qemu_mutex_unlock(&r->wait_lock);
 }
 
+/* Consumer: send REGISTER_FINISHED; for FINISH drain and dump stats first. */
+static int rdma_consumer_reg_stop(RDMAContext *rdma, uint64_t flags,
+                                  Error **errp)
+{
+    RDMAControlHeader head = { .len = 0,
+                               .type = RDMA_CONTROL_REGISTER_FINISHED,
+                               .repeat = 1 };
+
+    if (flags == RAM_CONTROL_FINISH) {
+        if (qemu_rdma_drain_cq(rdma, errp) < 0) {
+            return -1;
+        }
+        rdma_nbsent_stats_dump(rdma);
+    }
+    return qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL, errp);
+}
+
 static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
                                   bool *stop)
 {
@@ -2866,6 +2918,16 @@ static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
     int ret = 0;
 
     switch (cmd->type) {
+    case RDMA_CMD_WRITE:
+        ret = qemu_rdma_write_chunk(rdma, cmd->block_index,
+                                    cmd->chunk_index, &err);
+        break;
+    case RDMA_CMD_FLUSH:
+        ret = qemu_rdma_drain_cq(rdma, &err);
+        break;
+    case RDMA_CMD_REG_STOP:
+        ret = rdma_consumer_reg_stop(rdma, cmd->flags, &err);
+        break;
     case RDMA_CMD_FINISH:
         ret = qemu_rdma_drain_cq(rdma, &err);
         *stop = true;
@@ -2895,6 +2957,9 @@ static void *rdma_consumer_thread(void *opaque)
                 ring_set_abort(rdma);
                 break;
             }
+            if (cmd.seq) {
+                ring_barrier_complete(r, cmd.seq);
+            }
             ring_advance_tail(r);
             continue;
         }
-- 
2.39.5


