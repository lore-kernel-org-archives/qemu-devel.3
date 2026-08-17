Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9ADC5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3t6-0003sb-IU; Mon, 17 Aug 2026 16:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t4-0003s2-Gw
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t2-0002nx-Qe
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTUTn0RPHUSZXgvS7o8vUQppyBBgIvjMwn695xgcoWw=;
 b=dTL1Xjng3x4D3ewOquI7yHcdedifBIkp6EqPcnLd1IBiOhegmSYZDioaWxutcpuLEvLjG6
 02Da2DU5gezN69hjVFq11s6HNbvr/TqCbXB1MKB+nUABBriId6bggORnDTQckZDInX6xJd
 IFcxc5sV2kRzXGfhyrjm6PSOoLd0G6s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-a-HaiGmvOy-ruCjo1zjn-g-1; Mon, 17 Aug 2026 16:24:46 -0400
X-MC-Unique: a-HaiGmvOy-ruCjo1zjn-g-1
X-Mimecast-MFC-AGG-ID: a-HaiGmvOy-ruCjo1zjn-g_1786998286
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8eac2620cb0so37456136d6.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998286; x=1787603086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xTUTn0RPHUSZXgvS7o8vUQppyBBgIvjMwn695xgcoWw=;
 b=p1RL7TKK1TWIcaTME4MhOMVe22SDYpkv7NJRF6ZI1pTxzuXS6E0PDij+C+bunKUJrw
 He7e9reAKPns5GfVV4504qYXzhB/FixSnStmkyUbClWxXcdOI+I1ItYmo2ab0O/1P5jE
 k1q/lZyHUT8nOckmnLjAD2WuBG6SGEyGCIJVCFMNznaK3Yqddl1VwtBNi7NeAD6zLqIR
 LCBOQvhPQmqIjORQMZE3cKySbDQ7+laNQJMJSfihuIanSxwHuzqfq+2eME2zr6n/Mevh
 3eKu1QiBpmvy1ZmDkCYQi3s3U2cNPZbIM30BuiscHyUHHxoF07Yxgcfba4hI3a9FMO/X
 VBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998286; x=1787603086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xTUTn0RPHUSZXgvS7o8vUQppyBBgIvjMwn695xgcoWw=;
 b=qbtRkPCClwixz4WVaMkn0pgG0rZIHmbylHU4dBkPSmKfY5Nf7vNNzn4RfsqIpODVWG
 I9kDXoUl/ZJjYvmlYu+4zDZLl3LlvR27I8XG2mMGP6CjAS2umx2fC8hwGcDmPsGDUsk7
 XkUDHhC9s1HkUkZfOEwLvl293sNGNySYXeAqUTZmUSjfbyk4avtAhR0boTPczNtnqVLv
 O7nq1WY5EIfCFdzlQ4FT6bfJlDU4Oml3AsrZmTkg3hyeqn+C4W3wo//HbazyYp83Jq6L
 LBBKQgn0bTbX62cly9PAWqqHUEY9XTZv9AqU3Gk0Fa3cC1vZJxLhnzUI1bWqsHhsUPjc
 /hFg==
X-Gm-Message-State: AOJu0Yy1Sm638m67OvCvXrCbznOxmH5VWOgEAzg52xY8+vB3C7isLZOd
 s03pODoF8co4i+SRVu6saGZsISmqptOyUstNb7zups3QuCumQSCWbxIQJOvkYQbRVelL+wHhiVw
 jERPe4Qa108xmDGTQNFL6JBrogMpOLP390F8mcEU4RPu3R32Z+8A/4MSowhO+HVw+4i7HIRd6lB
 z8h6iL5re4YHXy+u0E6oN5UBty8trCGQUORLP6NQ==
X-Gm-Gg: AR+sD11T2k9+2P67FnnX26BD3hL7SstDkoMI4nmd+wlcR2JMW90tzhNOP/j5Ksi/1nz
 WSIpVW+vBWyVFgSnEVZCdhhA1Bg7sYM/QlQIgUf9Uv+u3eX8GrvP7LIgFbqVgl/YqM0JKCg0Z7a
 RjAakMNXrLv5yre8772BWjXV4C2wPX4agMSa2heQN27n++O2w+eDchu6woz0B6fxzYy9dn5L/pB
 8nEjcfF/qdQk6FxfbdRHdvVoCA6OQaLFM+us2MxNNkU+sCca1QiMConnzZgt4G1ZY0Ly4Bw44tg
 Dip7Kouduh1HQ333awGzOEkGrxvHdfe6F1mZu2IcITP1JltuUhJO9PVXBr1cc/6GcA==
X-Received: by 2002:a05:622a:c6:b0:51c:15bb:b4f2 with SMTP id
 d75a77b69052e-52d85501022mr268841631cf.27.1786998286108; 
 Mon, 17 Aug 2026 13:24:46 -0700 (PDT)
X-Received: by 2002:a05:622a:c6:b0:51c:15bb:b4f2 with SMTP id
 d75a77b69052e-52d85501022mr268841001cf.27.1786998285514; 
 Mon, 17 Aug 2026 13:24:45 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 05/10] migration/rdma: Drop RDMALocalBlock.unregister_bitmap
Date: Mon, 17 Aug 2026 16:24:19 -0400
Message-ID: <20260817202424.2901438-6-peterx@redhat.com>
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

Not used anymore.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 354935433c..c06395a51a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -198,7 +198,6 @@ typedef struct RDMALocalBlock {
     unsigned int   src_index;       /* (Only used on dest) */
     int            nb_chunks;
     unsigned long *transit_bitmap;
-    unsigned long *unregister_bitmap;
 } RDMALocalBlock;
 
 /*
@@ -578,8 +577,6 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
     block->nb_chunks = ram_chunk_index(host_addr, host_addr + length) + 1UL;
     block->transit_bitmap = bitmap_new(block->nb_chunks);
     bitmap_clear(block->transit_bitmap, 0, block->nb_chunks);
-    block->unregister_bitmap = bitmap_new(block->nb_chunks);
-    bitmap_clear(block->unregister_bitmap, 0, block->nb_chunks);
     block->remote_keys = g_new0(uint32_t, block->nb_chunks);
 
     if (rdma->blockmap) {
@@ -665,9 +662,6 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
     g_free(block->transit_bitmap);
     block->transit_bitmap = NULL;
 
-    g_free(block->unregister_bitmap);
-    block->unregister_bitmap = NULL;
-
     g_free(block->remote_keys);
     block->remote_keys = NULL;
 
-- 
2.54.0


