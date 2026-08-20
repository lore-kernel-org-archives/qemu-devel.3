Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5284C5DF8E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8zi-0000Qt-FZ; Thu, 20 Aug 2026 16:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zh-0000Ps-CV
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zf-0005Rl-Oq
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSVoCxz+TV8QgWwOuZmmqsA5tQRksceNAyieKAVfFUk=;
 b=B5QRTfEcA3WTz8O50d/JrTHhdeF/aGMgJ7WPnPLqgGZrAql4WX6IlDkmqhTFbBdsVUL2Km
 PXOsBbTRYOIkvTXNM1e9yFuWrad0ToZ7z4MtMDAWxrBb3Mq074QNVUPDDuJ5IAEGlNNF46
 cRz5bJpA2H9Ii1zHQRddpd0DhCiJeZQ=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-KZ_2vdJLPh2zZnvJxu7Bxw-1; Thu, 20 Aug 2026 16:03:55 -0400
X-MC-Unique: KZ_2vdJLPh2zZnvJxu7Bxw-1
X-Mimecast-MFC-AGG-ID: KZ_2vdJLPh2zZnvJxu7Bxw_1787256235
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-455ad408573so330848fac.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787256235; x=1787861035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PSVoCxz+TV8QgWwOuZmmqsA5tQRksceNAyieKAVfFUk=;
 b=ZYZycg2wQuVt+eo4+KZeOBWZbuVl0qlp7n8uR9AYJjrq8mmOJ4Q0rmb+1iA6MuihVk
 gj3VcIxImMDGAZ0Htvgc/A3dzP15vWwuHL2J2x6DfzzY2o6wlj3H0GTCdwV1PomA+P6c
 lv4UDMkEGpW4Td3R21S0yqmqTyL6CJS0EGjNrpbA6IzE1PkL7Ccdbha+yMEjrDyRtH3J
 t/1N0IohgpFP1EoGsqsJ1fsjCRi8H2CMS6JbzkPNc0RaCp2Q4pQhAuN6RxB6afuUb8U2
 2i1I+xVi74kxH1Ba66fC9abXJ4VuNyx4oTdAqmiBZjD9GWtcKgyWI6v4wepF/COiHBNp
 2UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256235; x=1787861035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PSVoCxz+TV8QgWwOuZmmqsA5tQRksceNAyieKAVfFUk=;
 b=ng+AzaF+L6FlsHf0NSGwqynEXOyt8E/1cju+qbbk63m9in5kiqj/Mx9AgJlFN5JG7g
 rX5kXcBGJl2BdEEqZ83ens893W9oXiIp5X8u9NTbPpk+lB4yikqe3HoBZSXR0gx1Wa07
 WxSuKKgYKnawL00/47df1mS6NqIz4/V4qcT0Zb+0AMWWf8GcRc8TBn8pItycnqUi25sp
 5cqmwoAlZq1xlzkrLNdxLtabqpM77jYx8ur9p+BFjV0iCMbngxtTYIIFRCvdngvTliNs
 zsPTffcY8oOiDRrg4K8ieLU6xcChr/jIVV4ayDBMxP9hEFW8SaP4c/zpvP6D/64jWQMM
 p/Xw==
X-Gm-Message-State: AOJu0YzUZh46wITstiDYdBaOy8U6tHorObGWT0prV+Cgi+TG82HlaEgw
 TE2YtufopNS+SehBB1gsb6R5KK+Gjs+ZLzpCfuCfnXI0294izJ7ysdGWPpH0T2gJTPuXGgxZJU/
 QGzhL31bl+LVO6MCSE2B7Sh/e6unMftxCZQGct3RPx6caeXjVEe5Aam8RBiur2WO7ZGmzqi63xO
 PI5hWMvTB/hLhXkTmX3y8huVqlaLYmcNFnrnhXdA==
X-Gm-Gg: AR+sD13+GcBvFtKo4uw7JxPDAiW8pJjKYYtLY03NS/vV8OfE6eT8+jhdFN0dhto+bAI
 ZXNHLH89Wc3xfgCgzB69Kne654RGBgv0U4bWOF4PW2oqLLkty62AB8ZrN26dKBe2MwoK8WtbHK7
 gBtXLLC10NV3GTNADTMPrYEfvJ8gGPU528sn+vvzjnnzB7PvynleXTS397GCPIF5UBLR+uWr/PI
 uVKeA2wb6lPoIduX71XM7MEXdaFxht/TTllfsXkmpTXhwxfJKbSED1rr+LiZMFbZG1kB/NvDBXk
 oO1CR5LYYsFpcaVrdDLd4luDcJXx5AsLCMVcpWvO2rOuqpsyUX1g3X15jUMCT+BDlp77pLjOldb
 f+IW9S6lfNST2Mt6ZE0+zhnJgKE6CwnJl4DpqO0wk8PRwzLvVXcvp5dmgJdo=
X-Received: by 2002:a05:6820:1793:b0:6b1:59e8:6e63 with SMTP id
 006d021491bc7-6b159e87650mr1060008eaf.22.1787256234704; 
 Thu, 20 Aug 2026 13:03:54 -0700 (PDT)
X-Received: by 2002:a05:6820:1793:b0:6b1:59e8:6e63 with SMTP id
 006d021491bc7-6b159e87650mr1059433eaf.22.1787256231209; 
 Thu, 20 Aug 2026 13:03:51 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb2esm6181314eaf.10.2026.08.20.13.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:03:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Samuel Zhang <guoqing.zhang@amd.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v2 06/10] migration/rdma: Drop RDMARegister.key.chunk
Date: Thu, 20 Aug 2026 16:03:18 -0400
Message-ID: <20260820200322.3321036-7-peterx@redhat.com>
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

Not used anymore.

Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index f9f3940256..683c24ba4d 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -414,10 +414,7 @@ static void network_to_control(RDMAControlHeader *control)
  * the actual RDMA operation.
  */
 typedef struct QEMU_PACKED {
-    union QEMU_PACKED {
-        uint64_t current_addr;  /* offset into the ram_addr_t space */
-        uint64_t chunk;         /* chunk to lookup if unregistering */
-    } key;
+    uint64_t current_addr;  /* offset into the ram_addr_t space */
     uint32_t current_index; /* which ramblock the chunk belongs to */
     uint32_t padding;
     uint64_t chunks;            /* how many sequential chunks to register */
@@ -442,16 +439,16 @@ static void register_to_network(RDMAContext *rdma, RDMARegister *reg)
      * current_addr as passed in is an address in the local ram_addr_t
      * space, we need to translate this for the destination
      */
-    reg->key.current_addr -= local_block->offset;
-    reg->key.current_addr += rdma->dest_blocks[reg->current_index].offset;
-    reg->key.current_addr = htonll(reg->key.current_addr);
+    reg->current_addr -= local_block->offset;
+    reg->current_addr += rdma->dest_blocks[reg->current_index].offset;
+    reg->current_addr = htonll(reg->current_addr);
     reg->current_index = htonl(reg->current_index);
     reg->chunks = htonll(reg->chunks);
 }
 
 static void network_to_register(RDMARegister *reg)
 {
-    reg->key.current_addr = ntohll(reg->key.current_addr);
+    reg->current_addr = ntohll(reg->current_addr);
     reg->current_index = ntohl(reg->current_index);
     reg->chunks = ntohll(reg->chunks);
 }
@@ -1831,7 +1828,7 @@ retry:
              * Otherwise, tell other side to register.
              */
             reg.current_index = current_index;
-            reg.key.current_addr = current_addr;
+            reg.current_addr = current_addr;
             reg.chunks = chunks;
 
             trace_rdma_write_one_sendreg(chunk, sge.length, current_index,
@@ -3373,7 +3370,7 @@ int rdma_registration_handle(QEMUFile *f)
                 reg_result = &results[count];
 
                 trace_rdma_registration_handle_register_loop(count,
-                         reg->current_index, reg->key.current_addr, reg->chunks);
+                         reg->current_index, reg->current_addr, reg->chunks);
 
                 if (reg->current_index >= rdma->local_ram_blocks.nb_blocks) {
                     error_report("rdma: 'register' bad block index %u (vs %d)",
@@ -3382,15 +3379,15 @@ int rdma_registration_handle(QEMUFile *f)
                     goto err;
                 }
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
-                if (block->offset > reg->key.current_addr) {
+                if (block->offset > reg->current_addr) {
                     error_report("rdma: bad register address for block %s"
                         " offset: %" PRIx64 " current_addr: %" PRIx64,
                         block->block_name, block->offset,
-                        reg->key.current_addr);
+                        reg->current_addr);
                     goto err;
                 }
                 host_addr = (block->local_host_addr +
-                            (reg->key.current_addr - block->offset));
+                            (reg->current_addr - block->offset));
                 chunk = ram_chunk_index(block->local_host_addr,
                                         (uint8_t *) host_addr);
                 chunk_start = ram_chunk_start(block, chunk);
-- 
2.54.0


