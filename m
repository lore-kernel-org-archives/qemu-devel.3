Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEFCC5DF7F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3tM-0003yZ-TJ; Mon, 17 Aug 2026 16:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3tI-0003xB-6j
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3tG-0002qV-L2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sN6XjJf8SMea6atT3HTmTlXbirCpYZnWKPBQV4NeUL4=;
 b=EeoUiPPP67+cZS5W/J5Iy66gXfcfAkHTW/WESK9OveLKwOIevc8+79HS38BgglvHIcR6oZ
 yYICb2munb/hrNnB/pVU901g8K8fX0vwCqmLiRIRpNpRdT7K+kcosrUR3ZRsB38/udjS2P
 h1PDJmdjdGgL5w+E0U179VW7nemSCcs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-jkYLcalrMYeXOdsokR1t9w-1; Mon, 17 Aug 2026 16:24:48 -0400
X-MC-Unique: jkYLcalrMYeXOdsokR1t9w-1
X-Mimecast-MFC-AGG-ID: jkYLcalrMYeXOdsokR1t9w_1786998288
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso69793611cf.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998288; x=1787603088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sN6XjJf8SMea6atT3HTmTlXbirCpYZnWKPBQV4NeUL4=;
 b=gnPhPlRJlL4bATjBGuyF3Q5n1IEN8WInWyWfnzcaj6K4luK+q88rHCKxi3FXd5jlGd
 HML61hd8P+TDJYYOEE9VM0dcKwE44dZuzdV8PLOcjJxf+0mdnhqAcvDA9ja7Fm371E89
 3Jvscl3gxhGEJuwDIcwreEXUPEm89wEnUtWx4UbGomobK5HnU0yZmPNyyQXEvPXyNt51
 sZp2AtZ/Up6n3fG2edIIHYYwzyniqMsN705QedJ0iHRPIP3+TfJBlWc83IFnK5EFeAKM
 +VD7nnh4yKECZ84p2FV2fG5RVIwr/VyW9/6BBxAGcRT9w2gLWiWLwTdPWzKVWVl8a51U
 utrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998288; x=1787603088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sN6XjJf8SMea6atT3HTmTlXbirCpYZnWKPBQV4NeUL4=;
 b=TSWNSu6vl/ZwFXdd9c4pJuIxRuwStEdMBSk8pn+Qtp5cwEVvLtECp5NozfL+49QNDv
 TlpNR05oDrJ8epWr299vyIPulST3cJLrQoM5dt6JPn1MugEIfgjzYiAw9JvI9HI9zg8q
 Jqi0eqF4ywLMGIlCGWXj6bfCU4TWYle6ADqSoh14ibzX0Dh+rX0BER6yX3S1il01fq78
 Y2PIpO4iZG1FZbj9vyOBzxl++9ntqNfuNVgvY8TLRXoOh1uOQXEuPpsHmocge+VxxKxM
 HocJI1MNacS4KGIWlzjVLTRbRSU7Ryp83gtJ/a+XPnx+0oKPcS/QsnpH/7Sti20WwHPA
 1fzA==
X-Gm-Message-State: AOJu0YyEiDKcasgws0uWNpZKymdfN4cy2cc+dFOJZKjC4VCszBRuVb70
 V+s60c7K/J0WcYO+p15bY6vaVIJKsW+Q3slgS6UkRBEehZvf22LE9UcDdnHxJjb4INJJSWRVefq
 7ajIDYVrMAMJOdvKzhstKBJFkgb0GXugYquodZXxhhmFQco8zSnIyV/ILVSUGiSfDR99Z5300bt
 8c9hAHYUgRo87j0D/0ZBWU8MGTBbOohd15rnAozQ==
X-Gm-Gg: AR+sD10ax309Vlpo7H5g0vKKZza6Z64/uANG9gg/RkognUIDv3WJlZGIobGRs2zevzO
 QYZ7IleNdIcVo27pvrZtfpZoL7cTuDaikFYOMTot1s2MORPwxel6R/JjXrrZHp+bKBVmna3MCcY
 nuWc+AvjZ1rObWgz9C2DS0Yju3i5XoVr2eofVJEzyeFguw4iSrcVCbVuzVRNMQ6twTjeh3IBokS
 KysAM2VLT3nXyTTx95iJ+dBz3hRRafd4QeG1C8lwMzeBER0IIfv6r4hF2wgs8JVlEqL/3hqJD3K
 hp8Iu4SMsjhM9zzZkpfflxDOLfeu/KkTFw+Mz3clBwiXIyEeJD+fbojwkqeycNrLpg==
X-Received: by 2002:a05:622a:5c1a:b0:51c:1fa1:80da with SMTP id
 d75a77b69052e-52d854e54femr318430991cf.40.1786998287962; 
 Mon, 17 Aug 2026 13:24:47 -0700 (PDT)
X-Received: by 2002:a05:622a:5c1a:b0:51c:1fa1:80da with SMTP id
 d75a77b69052e-52d854e54femr318430271cf.40.1786998287399; 
 Mon, 17 Aug 2026 13:24:47 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 06/10] migration/rdma: Drop RDMARegister.key.chunk
Date: Mon, 17 Aug 2026 16:24:20 -0400
Message-ID: <20260817202424.2901438-7-peterx@redhat.com>
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

Not used anymore.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index c06395a51a..f64bcee418 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -415,10 +415,7 @@ static void network_to_control(RDMAControlHeader *control)
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
@@ -443,16 +440,16 @@ static void register_to_network(RDMAContext *rdma, RDMARegister *reg)
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
@@ -1833,7 +1830,7 @@ retry:
              * Otherwise, tell other side to register.
              */
             reg.current_index = current_index;
-            reg.key.current_addr = current_addr;
+            reg.current_addr = current_addr;
             reg.chunks = chunks;
 
             trace_rdma_write_one_sendreg(chunk, sge.length, current_index,
@@ -3375,7 +3372,7 @@ int rdma_registration_handle(QEMUFile *f)
                 reg_result = &results[count];
 
                 trace_rdma_registration_handle_register_loop(count,
-                         reg->current_index, reg->key.current_addr, reg->chunks);
+                         reg->current_index, reg->current_addr, reg->chunks);
 
                 if (reg->current_index >= rdma->local_ram_blocks.nb_blocks) {
                     error_report("rdma: 'register' bad block index %u (vs %d)",
@@ -3384,15 +3381,15 @@ int rdma_registration_handle(QEMUFile *f)
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


