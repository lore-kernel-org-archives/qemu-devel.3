Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D2BC5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3tB-0003tz-89; Mon, 17 Aug 2026 16:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3tA-0003tg-F3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t8-0002ox-7N
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3ohXdIr8fhrUcLg1b1Cl433ZNfz2EPC8poOBiY/Wac=;
 b=hFZ0BPULkrOsMZPtXT/asct+UvMDRSyl1xFo2JcwptINEMeuiHePOV8rx3e7BB/Jbicl7f
 cLAIOzogY/pKrxcQqRGugFbxaaNiAt84GDV32kU9tKi/DTvmf3fl0RtevswY0GHR1BPWVT
 KGBh0KNWnlamextXDS1TUOIX5Qb/jYw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-YO1HpuwdObqz5RbGzXyrOQ-1; Mon, 17 Aug 2026 16:24:52 -0400
X-MC-Unique: YO1HpuwdObqz5RbGzXyrOQ-1
X-Mimecast-MFC-AGG-ID: YO1HpuwdObqz5RbGzXyrOQ_1786998291
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso69794281cf.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998291; x=1787603091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f3ohXdIr8fhrUcLg1b1Cl433ZNfz2EPC8poOBiY/Wac=;
 b=OZS+b/7UnlLt3nPZVUccNJXAJYOVwySLMhDVcHmXnV7yIqLuBcYGt2kkeKLB59tUke
 F8QFUoskrUwuh1Ltfub9W0cph4krArIsBZMKT8hQEHJgYOmA3sx1UzexzTx2c0VbinOH
 KTNHKrr/DiKmg6AzfidygMPSPOvRECkWorBTrymhSTSk6WMBGoPKHwXKu8U0QWeFFhtY
 7gBMZGUce6L/DCcskGADS0x/VzDfYtUQEOP4zOaoUJe7N/6ZjkcuHJxx5mQMvJMaUHvi
 BWaAqxsTL2NxAQjvbyry9CLPWseJ+wKv6DZqIKtzH07RkDNz0ek49PWLFiTDZtTmgY0B
 Fl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998291; x=1787603091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f3ohXdIr8fhrUcLg1b1Cl433ZNfz2EPC8poOBiY/Wac=;
 b=d4jzzJWQ8uysWyJF2WEkMeAuAkaH16so3vnG71qr/R6RBTiv366wGL9OkF2QK46/9V
 weQsWa4v4S2Mf88k97Mjoa0AZ8fJOjunAHqPHDgGnEkFrvaNbU/+qifc44qHUwPQMXGV
 2OrsDLWBW+GUMp2pbS3qPHfSapNycyVLGrr3JFXI0DXcUGFwQJkuxzy7L16FjufervoG
 rcPRDyiEb6iZoPJhV8yBeuuLY+4eKTWLCBaozz6IuaTk/3kX+UFwk2NhDi4ihbnRGhKZ
 29jUhs2znJtrpw/geXKtoI28RdQawsAC8W9qxoQvoHVCZT6QF9bYEk2yVuN+om5vFxpO
 dxFg==
X-Gm-Message-State: AOJu0YyD7hNrp6ZzYkobAAt/jUukmIo8RDG458bDbylu7VotSIpuCdY/
 t1aGM7+aaWJ449oFpMxpf0dFybHPLfTn8EbKNaz/WHB6O2QZ+w8ior+cHI7ALK2DadfCzds13JX
 gNhSiZNjXOOLRw2qNbRbZJtGOOaTd63kzJalqNMhgQBPg0YoDFgLQR1SboRibNFWFwB6cMBJTyi
 h/qmSueCnLlWp24P9UMxD9W1cA8YPSq7ImNzCPFw==
X-Gm-Gg: AR+sD101ytFUrgyhyxZPTQ0Sp7yqcrRH5mR10cRDcj+mVzghy+y7XVf7b2fqeDnYCuQ
 17Wd3ovm0ZXRJPgW/MZOBZgHEyEomTopBEsamPcqnUd/DJM8QAdxMoCxiZKGZoFAlm/2/BQV08T
 rgfMBrLsN5JdxTMuUPle/NG6A6jOCkP0Wg1CESOhFvQZu1YkEPar+nT3SoUwdAueVjB6zSsTnad
 QI+INK5HZykwknAvr8QACjIIRLjVZ1n/oBJHJHiG5T/eXk5XN5zi716IrRhZgIieExTvJqArMMk
 95zSDleX6w1hIq4SCtybaF4xMB78f71CoYrihm5F9R3+vEkmj3y/K92IFEDdPyzI0A==
X-Received: by 2002:ac8:58c1:0:b0:51c:2068:a9f8 with SMTP id
 d75a77b69052e-52d8530d77dmr261827051cf.5.1786998291317; 
 Mon, 17 Aug 2026 13:24:51 -0700 (PDT)
X-Received: by 2002:ac8:58c1:0:b0:51c:2068:a9f8 with SMTP id
 d75a77b69052e-52d8530d77dmr261826611cf.5.1786998290778; 
 Mon, 17 Aug 2026 13:24:50 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 08/10] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST chunks
Date: Mon, 17 Aug 2026 16:24:22 -0400
Message-ID: <20260817202424.2901438-9-peterx@redhat.com>
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

The value received on wire for head.chunks when registering new RDMA
regions is not correctly checked.  Logically the value can still make
ram_chunk_start() (of ram_chunk_end()) to overflow, having a result pointer
very small, smaller than RDMALocalBlock.local_host_addr.

Add the sanity check.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4011
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 5ce8b06818..bbbc40ea3b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3401,6 +3401,13 @@ int rdma_registration_handle(QEMUFile *f)
                 chunk = ram_chunk_index(block->local_host_addr,
                                         (uint8_t *) host_addr);
                 chunk_start = ram_chunk_start(block, chunk);
+                if (chunk + reg->chunks > block->nb_chunks) {
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


