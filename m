Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD743C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Qxb-0008IL-0K; Tue, 01 Sep 2026 12:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x1QxY-0008Ha-Am
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:03:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x1QxW-0001Uq-C6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:03:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-482e06fda73so8919f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1788278617; x=1788883417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+SG4rf34LIFkTsX94P+qqW5zlbLqFuIfbZtiTmVQLoQ=;
 b=IdUgFICwc1zekkA4efKqHHmR11RUHh1YILgrFnc4FCKuIVGsnPOw2uomHLHi13pUEk
 M1ac+drghNcqtn5gxi9LYM2n/Sc1ihEIHYGSuBNrrjkz3nhSs5LrV2omXCFTTNykjaSL
 rYnnW9ZxDsLLCXHuRMXAuM8zvAy4t0qVDnM4zEltakt4TyguGfZvtvAocT8iGAOr6eB0
 KG50og1gQINA/kmHGJDhWh2ep35egl6d6ZQDtRWsIKlp79jjbAPeEf9tsH6QKMJKrCiE
 OIqnlXUGluOMvkk1TftSlZ4crrp3uuXIPg72qJhKL1cUJdjoWfT9xFNadc4SNNFTyr6c
 brDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788278617; x=1788883417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+SG4rf34LIFkTsX94P+qqW5zlbLqFuIfbZtiTmVQLoQ=;
 b=hY59Pg0pMR23ngBNPwSyt/wz4ikh3ssEcYopDv6EqeaC8Yt2EfyFi9O0wbBZE//Olh
 lGKKvypn8zB+CMB07MLGuDrjZkSzZkVHKW7Pwhd+qwpjzKPwk8iFsGVVKyCMRee4HArn
 FOQzzwaGCqQJRBvnq2pEjWPpOBg2JS+AnE/WFdSQjgDNbyWMjrnMqOFNutHWI5dsjQbG
 p89fZQt3MRWatvMRIlQ96U/V2mCB5ZoM4RH+160M1Fx/IKEOkIylN1dKPDGq/bN6ZApb
 QB7jJ17BaWtXsAOhZYC2/gFyAaWU+dCGwBcJ4fLatx+M2UGpk6YMCbLIYLUulpw29/K5
 7DxA==
X-Gm-Message-State: AFuF++lX2JioOFZDZXCHPOtJXLTY1JMnGDK/p20D2DnakMQDh5xOXSEj
 KQWF0qYelU28AGWvr+bJRCdeqlvTPU9+iv2Eq87wZHj7v8vXeWMvARg6YHRhV6sQYO6ubtBmSAE
 sXay2mx0=
X-Gm-Gg: AR+sD11jtyvLfkm3cxhKRD+SEwNm0fqKa0+4irAIi3/tEklpxxOsHbuh+bquzYk96lj
 fkGQ8o621RBwY7CV9JIyU12h1RwmtyseNZEgbMak9dNFKRU1Omrr39XgeLhoNF9FhoonKEb+GRD
 gZdgm9lhTBdpCTNWploDQsQTBPnkksCh1z4c4XFdWcrRkV3F9i+vaVmuWmV4WKbDa6Y9USog3h3
 JVDnyT4n3ZtlopXHbKb1izSG8jy6GEKn/djcDhIrUOHW8M7wsMZAec86UfEs448cw2lF2oZKXhH
 8XJvg0wiT50BtnX9Ex45EFv7G8QItWt1BqjyJM149J7j24cizfyEGMHNe1Sm8mD4JwfSah7AChM
 Vq+ozJT5EzEJZnVMiygzejsGeUeB0l90f2BXGvQ9p4os5GMU7F9l+/kTMWrZ6/y7+fmvrNIFNxF
 QEzBJ+6ghi57z8LXGN5z3Dt3noE9SZCymfiElBtyRQ7qSczpd8kzBaCj69SKEX96INS21xDc6FN
 61dJzSpfbGezuJNapphWMisyQt/8y6hzJrL
X-Received: by 2002:a05:600c:80c2:b0:49c:ca33:9553 with SMTP id
 5b1f17b1804b1-49cca339575mr138484185e9.2.1788278616658; 
 Tue, 01 Sep 2026 09:03:36 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net
 ([2001:9e8:1471:a200:e095:5b15:7c12:5f73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce0b456sm87367435e9.2.2026.09.01.09.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 09:03:35 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, yanfei.xu@bytedance.com,
 Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 1/2] migration/rdma: send small control messages inline
Date: Tue,  1 Sep 2026 17:51:20 +0200
Message-ID: <20260901160333.29859-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901160333.29859-1-jinpu.wang@ionos.com>
References: <20260901160333.29859-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::42a;
 envelope-from=jinpu.wang@ionos.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Control-channel sends (registration requests, ram block replies, etc.)
are tiny, but the HCA still does a separate memory read to fetch them
before sending. Ask the QP for a little inline send space at creation
time, and use it whenever a message is small enough to fit, so the
HCA can just copy the bytes straight out of the work request instead.

Falls back to the old path if the provider grants less inline room
than we asked for, or none at all. No wire protocol change.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 migration/rdma.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index e976739fad3c..08f3b901be4a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -66,6 +66,14 @@ static inline uint64_t rdma_merge_max(void)
 #define RDMA_CONTROL_MAX_BUFFER (512 * 1024)
 #define RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE 4096
 
+/*
+ * Requested max_inline_data for the QP: enough for a control header
+ * plus the largest fixed-size control payload, so small control
+ * messages can be sent inline instead of via a separate HCA-side
+ * memory read.
+ */
+#define RDMA_CONTROL_MAX_INLINE_DATA 512
+
 #define RDMA_CONTROL_VERSION_CURRENT 1
 /*
  * Capabilities for negotiation.
@@ -329,6 +337,7 @@ typedef struct RDMAContext {
     struct ibv_context          *verbs;
     struct rdma_event_channel   *channel;
     struct ibv_qp *qp;                      /* queue pair */
+    uint32_t max_inline_data;               /* max size for inline sends */
     struct ibv_comp_channel *recv_comp_channel;  /* recv completion channel */
     struct ibv_comp_channel *send_comp_channel;  /* send completion channel */
     struct ibv_pd *pd;                      /* protection domain */
@@ -936,6 +945,14 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
     attr.cap.max_recv_wr = 3;
     attr.cap.max_send_sge = 1;
     attr.cap.max_recv_sge = 1;
+    /*
+     * Ask for enough inline data to cover a control header plus the
+     * largest fixed-size control payload (RDMARegister/RDMACompress),
+     * so those sends can skip a local memory read on the HCA.  The
+     * provider may grant less (or none); qemu_rdma_post_send_control()
+     * checks the actual granted size before using IBV_SEND_INLINE.
+     */
+    attr.cap.max_inline_data = RDMA_CONTROL_MAX_INLINE_DATA;
     attr.send_cq = rdma->send_cq;
     attr.recv_cq = rdma->recv_cq;
     attr.qp_type = IBV_QPT_RC;
@@ -945,6 +962,7 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
     }
 
     rdma->qp = rdma->cm_id->qp;
+    rdma->max_inline_data = attr.cap.max_inline_data;
     return 0;
 }
 
@@ -1447,6 +1465,10 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
                                    .num_sge = 1,
                                 };
 
+    if (sge.length <= rdma->max_inline_data) {
+        send_wr.send_flags |= IBV_SEND_INLINE;
+    }
+
     trace_rdma_post_send_control(control_desc(head->type));
 
     /*
-- 
2.43.0


