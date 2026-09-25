Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D459CC98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8SM-0007ld-5X; Fri, 25 Sep 2026 12:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DX-0007r3-2i
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:07 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DV-0005xP-8l
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:06 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso5203835e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351524; x=1790956324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wz5J7BtRm96GQteyQTuXbDxbX79LxGun+611Yug+ddc=;
 b=PkfO7I6tfwUpTxeW3n2piAaWS9E78WbmL3PB+59bNV9m6LaLDMd5f7eZ/68lvNt1d4
 5zkcG59JebyEGMFGr16Y31zlKXUOehbmWFu4/tvZpi5//L8MxOQSSqwlZgkjBrkHfshD
 RV0QUXCsKybT1eSQkuuQWoUfJKsNP/38sR7ftGPG/iCrPXfY4zTE1cF4XdqKstEiUWTh
 IiGLPS/LsD9My037FO0s0IRJJzBqJ7eC+OTl/HqDSX4kQxMh6X5+qXHqCkJTMfCgpcVl
 b7gPsAT97vP0dIrL9PWERw+t86KnZ5cyRt9kBf1Ia50irxcrImcRWIUdceJpSCAnevbD
 8I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351524; x=1790956324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wz5J7BtRm96GQteyQTuXbDxbX79LxGun+611Yug+ddc=;
 b=bgDB+J1svLecYHwEeslbyLswrzQhWTPe5R+kY3UWfqTKWXii75GSm3EjD1TEeZA5Zo
 udu8yOVsIwkbqZ+PZ4Go6nXwTwdYqOY3sHHOw21umzZvHJY7yWPPOPWsZ/KgPntcpQGA
 gVJjOqewaDq3UfGTKPONGL3MgW0BjWMsW7in6ZjMz54q6wYNjBpOgmGwbm9a8q00bxeo
 9tJ9BPR71LKOMYmAdrrkxPpew36qxcqBNptfa9x7zFeu2hunjcJVy0hUJFxO2JNh+6AJ
 kYEq6RjIHr65Z1A7NQXWWGh6O9WrZMZvdCkqKGVY2pzBTQOVxKcamlluV0jhADs6egJn
 yqhQ==
X-Gm-Message-State: AFuF++kyRmFtiCrmFHmEjEau4xvuzBCH7igkNZvekPiVcrgDp8Q64Vt1
 3YO/cUoDoTbLJI1XMZGJBAe8v/C0PB9SGNVkTFjlp6/RXByPfwyVjq7iVylEg5TzMUc8Qz+IqmO
 QPzRBKvk3Aw==
X-Gm-Gg: AYBFou0UfXZmh9Z6Row0VYYY4B4hiY0UrH/dtVL2WT9J/FeTnh9NAamPfdsiQDvo4js
 bbNbwOJy6dvW4DpZaNAdMV3XkFYZX7yP45G/LofFAoh9vsQnUzp63192GHmYC4wVW5u6VlZncYg
 uj9/gPP805LTpP/cPhDCBE+pD4CGEk9CDBTF8oQ+O4WoNB8ZfuCnJpM8HWkr57WM6q2IxpI+fiw
 thQJYoRlgFlJ8aOfq6ojNpgQChlkO12HnaVwHckmuWPrg5Nf1JM7RUibE9SbErwtUFhiZLakFO0
 ToR1M2gR1GpLJ/6zlX6xr4sTMrV9Eq8i2DSIjPN+M3AshhjOw4hHDb+akHRByFLY+2Y+g0BKRzp
 c+IgyOt6alokgCEl/wfVCv+BaayXJLnpTzAAX9OLFpEwf/Cg4vScnJMwcnaQ9NQwnyk0jrfm0eg
 Yl8BnxpTKGeueSKzaqw6B9NtQgRRUm4+0jCJXmjuQSBxM8i6q6Mklqh2EsMX60yQQEtzCdELShE
 9tuUS4GR6qd4THpvvFzRdGLoecrvN4u9eHubHPzuA==
X-Received: by 2002:a05:600c:1d1c:b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-49ff06bcd5fmr50845065e9.8.1790351523927; 
 Fri, 25 Sep 2026 08:52:03 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:03 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 03/13] migration/rdma: Add send-ring lifecycle (no
 consumer thread yet)
Date: Fri, 25 Sep 2026 17:51:38 +0200
Message-ID: <20260925155149.843870-4-dmitrii.omelchenko@cloud.ionos.com>
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
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:04:57 -0400
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

Introduce the producer side of the SPSC send ring: rdma_consumer_start
allocates the ring at registration setup, rdma_consumer_stop frees it at
cleanup, plus ring_push/ring_wake_consumer.  No thread runs yet and the
existing send path is unchanged.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index e4ede950de..2d4807c6b8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1214,6 +1214,9 @@ static void rdma_nbsent_inc(RDMAContext *rdma, uint64_t nb_sent);
 static void rdma_nbsent_full(RDMAContext *rdma);
 static void rdma_nbsent_zero(RDMAContext *rdma);
 
+static void rdma_consumer_start(RDMAContext *rdma);
+static void rdma_consumer_stop(RDMAContext *rdma);
+
 /*
  * Consult the connection manager to see a work request
  * (of any kind) has completed.
@@ -2108,6 +2111,9 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
 {
     Error *err = NULL;
 
+    /* Free the send ring before touching the QP. */
+    rdma_consumer_stop(rdma);
+
     if (rdma->cm_id && rdma->connected) {
         if ((rdma->errored ||
              migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) &&
@@ -2753,6 +2759,91 @@ struct RDMASendRing {
     uint64_t idle_max_ns;        /* longest consumer wait on an empty ring */
 };
 
+static bool ring_full(RDMASendRing *r)
+{
+    return (r->head - qatomic_load_acquire(&r->tail)) >= RDMA_SEND_RING_SIZE;
+}
+
+/* Producer -> wake the consumer if it is idle on an empty ring. */
+static void ring_wake_consumer(RDMASendRing *r)
+{
+    smp_mb();   /* order the *_waiting load below vs the sleeper's store */
+    if (qatomic_read(&r->consumer_waiting)) {
+        qemu_mutex_lock(&r->wait_lock);
+        qemu_cond_signal(&r->not_empty);
+        qemu_mutex_unlock(&r->wait_lock);
+    }
+}
+
+static int ring_push(RDMAContext *rdma, const RDMACmd *cmd)
+{
+    RDMASendRing *r = rdma->send_ring;
+
+    assert(r);
+
+    if (ring_full(r)) {
+        qemu_mutex_lock(&r->wait_lock);
+        r->producer_waiting = true;
+        smp_mb();                       /* pair with ring_wake_producer() */
+        while (ring_full(r) && !r->abort) {
+            qemu_cond_wait(&r->not_full, &r->wait_lock);
+        }
+        r->producer_waiting = false;
+        qemu_mutex_unlock(&r->wait_lock);
+    }
+    if (qatomic_read(&r->abort)) {
+        return -1;
+    }
+    r->ring[r->head & RDMA_SEND_RING_MASK] = *cmd;
+    qatomic_store_release(&r->head, r->head + 1);   /* publish payload+slot */
+    ring_wake_consumer(r);
+    return 0;
+}
+
+/*
+ * Producer: allocate the send ring once (idempotent).  The consumer
+ * thread that drains it is created in a later change.
+ */
+static void rdma_consumer_start(RDMAContext *rdma)
+{
+    RDMASendRing *r;
+
+    if (rdma->consumer_started) {
+        return;
+    }
+    r = g_new0(RDMASendRing, 1);
+    qemu_mutex_init(&r->wait_lock);
+    qemu_cond_init(&r->not_full);
+    qemu_cond_init(&r->not_empty);
+    qemu_cond_init(&r->barrier_cv);
+    rdma->send_ring = r;
+    rdma->pend_block = -1;        /* no pending WRITE span yet */
+    /* Producer-only flag (migration thread + cleanup, never concurrent). */
+    rdma->consumer_started = true;
+}
+
+/* Producer: tear down the send ring. */
+static void rdma_consumer_stop(RDMAContext *rdma)
+{
+    RDMASendRing *r = rdma->send_ring;
+    RDMACmd cmd = { .type = RDMA_CMD_FINISH };
+
+    if (!rdma->consumer_started) {
+        return;
+    }
+    /* Ask the consumer to drain and exit; if it already aborted, just join. */
+    if (!qatomic_read(&r->abort)) {
+        ring_push(rdma, &cmd);
+    }
+    qemu_mutex_destroy(&r->wait_lock);
+    qemu_cond_destroy(&r->not_full);
+    qemu_cond_destroy(&r->not_empty);
+    qemu_cond_destroy(&r->barrier_cv);
+    g_free(r);
+    rdma->send_ring = NULL;
+    rdma->consumer_started = false;
+}
+
 static int qio_channel_rdma_set_blocking(QIOChannel *ioc,
                                          bool blocking,
                                          Error **errp)
@@ -3810,6 +3901,11 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
         goto err;
     }
 
+    if (flags == RAM_CONTROL_SETUP) {
+        /* Setup complete: allocate the send ring (consumer added later). */
+        rdma_consumer_start(rdma);
+    }
+
     return 0;
 err:
     rdma->errored = true;
-- 
2.39.5


