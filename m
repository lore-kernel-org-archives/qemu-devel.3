Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45108C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8ze-0000Kz-0c; Thu, 20 Aug 2026 16:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zc-0000Kk-BQ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8za-0005OD-Mm
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7e4UzT6JNFf1gbVzRxqbC6slkWmF8FAlkw0HoK6/8KI=;
 b=JX/0vE40YBclYkcPX1K+YCfiHarybLRTqo1dtfPB00OTtE/zED4QqrSpUn8HylM4aTFSII
 6aqT6Y+t6AMxvTQjf7+mhHOB1qqlxSWGzB1RQ65CWZLsXpZpJ4gBB3AKHIB4w6MTAnK6IP
 QwCXkL0qq2CZcvC5+HY5HgfJhnfiraU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-x0dBJUN9O96ly7h2zNqChA-1; Thu, 20 Aug 2026 16:04:00 -0400
X-MC-Unique: x0dBJUN9O96ly7h2zNqChA-1
X-Mimecast-MFC-AGG-ID: x0dBJUN9O96ly7h2zNqChA_1787256240
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6a17baa4d18so460567eaf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787256240; x=1787861040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7e4UzT6JNFf1gbVzRxqbC6slkWmF8FAlkw0HoK6/8KI=;
 b=DabS85nEe0ETAmt2WCT8702twtmMgFvA/T6v7Wt5nxGm8L76ZY9JdTbcNPKTyyAINA
 JerHLfTpOJt3hhKae/3wsS3t3+ENjz34aMs1GmXfpzk6cIOoRZTyPmKFWFtB7O1fL4J/
 283DztBu63N8nkXo585Lao13WtTU4bRhIAkrm49qS0vGghbxaDH7IIX9ZdF7OHzvvdKa
 GW/hEMRy8SVckekeowHYA5LlL1ama81XGnUOB9NCP52EACh7tRajhEdjxZmJ2GIxHqsS
 COUR8Z9mVGUlEm4mrlkM9b/GIMbNeMoc6Rhx9iN2ob34D4fpODMtpRVnpjF6aFZJHPBU
 rKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256240; x=1787861040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7e4UzT6JNFf1gbVzRxqbC6slkWmF8FAlkw0HoK6/8KI=;
 b=e/blM0W76jZvblHRZHehj4HXmCYAPNPiwOYOL4qGW8gRKBZkkD8/J3ErvKApBBOezx
 U6kb6RvIcTsR6KbeoczZKkkbhJbn+z1irOrqU3xxO5W6GZGCSwaiYj4kdYhj3ufh46Hn
 m1wB4SiNeDHqJ5Aty2JzdlEiniZl60bc2U256mbKjBDjlihV5cAXv6bR7N9oLBfH4VJ2
 yhheT3ZL2AHHVUvLU47AU+pNKs4DCfsHcaiEMqlGCfiZWa0OoRtwUbxKWRX5yjm1qflS
 lEUzRvp9hWgZclImbfdtjj5TMkCREFLpH7Gt342/mlvi4svbx6ZtM2Gd3gUziKLXXH/q
 egrQ==
X-Gm-Message-State: AOJu0YwPJOLb6AtJkTUP+Lh/U87Mjgxqn4z4Mgfm3li3FBVh2IKzOfiO
 lJ23NEY1GhpFJBYzykecuoW0Re+m4y68SNDuGLkbbz7+GJU9DlFdZ1HrWSYKnEe/2mFjmZWG2Ad
 ANQHXuvO8sUosK3cFBaGwGvUDfRM0WaiLvlztkO1p5boZE97lXr5lPeqir9Z5L7H0BLGh9cEiM5
 MDxp0C6n40f6wNdjgvtsitubP1arDAQroA0r2UjQ==
X-Gm-Gg: AR+sD12NSn2JMVvSiME5dvgKbgm6vCmKmQHhf8ce11dIg+bjuPuoIErcYf8LyPmwvHR
 O41toZri2zcDNLubMyTQAtHyE7CGte12Q8/gp3raRxJc9awc0ndvcmIMv2eQOEhRmJWa61bvyi0
 dZHLjQTaaooRCrYQd0RIJ6e2yT+S9t3anEHDXOOD9zg1tK2Pq5GnWSdyavXZXWQCvUAocnKCrYB
 3QNq8kbPTxBqNVz5hO8cGhm73RhoyQUyXiPMdZVLFB/jFcC5vZ+zXCs8Zr87tHvlzDxMpbw1bOW
 cV0ewhUK7379DxsJQdRufIoTg2pHwhpIFfwkjDumNJRSy8sJl2ln+llPeNX0GcRDMJA2x5uuwdX
 r7YDuRLsVHIlRu5qfrp/Y3EDn2sEHJ0i2UKXxRJsHsidfe3Vx1anhRN4RGNc=
X-Received: by 2002:a05:6820:2d05:b0:6ae:42c7:ef83 with SMTP id
 006d021491bc7-6b158fc84demr1665709eaf.0.1787256239720; 
 Thu, 20 Aug 2026 13:03:59 -0700 (PDT)
X-Received: by 2002:a05:6820:2d05:b0:6ae:42c7:ef83 with SMTP id
 006d021491bc7-6b158fc84demr1665632eaf.0.1787256239156; 
 Thu, 20 Aug 2026 13:03:59 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb2esm6181314eaf.10.2026.08.20.13.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:03:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Samuel Zhang <guoqing.zhang@amd.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v2 08/10] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST chunks
Date: Thu, 20 Aug 2026 16:03:20 -0400
Message-ID: <20260820200322.3321036-9-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820200322.3321036-1-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

The value received on wire for head.chunks when registering new RDMA
regions is not correctly checked.  Logically the value can still make
ram_chunk_start() (of ram_chunk_end()) to overflow, having a result pointer
very small, smaller than RDMALocalBlock.local_host_addr.

Add the sanity check.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4011
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index f7356e759f..cf6688a4bc 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3369,7 +3369,7 @@ int rdma_registration_handle(QEMUFile *f)
             }
 
             for (int count = 0; count < head.repeat; count++) {
-                uint64_t chunk;
+                uint64_t chunk, chunk_sum;
                 uint8_t *chunk_start, *chunk_end;
 
                 reg = &registers[count];
@@ -3399,6 +3399,14 @@ int rdma_registration_handle(QEMUFile *f)
                 chunk = ram_chunk_index(block->local_host_addr,
                                         (uint8_t *) host_addr);
                 chunk_start = ram_chunk_start(block, chunk);
+                if (uadd64_overflow(chunk, reg->chunks, &chunk_sum) ||
+                    chunk_sum >= block->nb_chunks) {
+                    error_report("%s: head.chunks contains illegal value"
+                                 " (chunk=%"PRIu64", chunks=%"PRIu64", "
+                                 "nb_chunks=%d)", __func__, chunk,
+                                 reg->chunks, block->nb_chunks);
+                    goto err;
+                }
                 chunk_end = ram_chunk_end(block, chunk + reg->chunks);
                 /* avoid "-Waddress-of-packed-member" warning */
                 uint32_t tmp_rkey = 0;
-- 
2.54.0


