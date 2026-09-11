Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C85C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAD-00041d-4g; Fri, 11 Sep 2026 05:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9n-0003ci-7U
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9k-0008EW-EY
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqIBh6wrg3/cCLBO/xish158SNEF5YQcKd9WgGS4UWY=;
 b=Y/w+J2SC8+1Za3bbARTXczzHINxDUxoLTKFoXes9rXHpj+AQ2o342PQp3tLlr36Txu8kkt
 E505uyOU1xsBbQQpA0KoJgK35byuuYZr6GS/jxnJbAXRv8tButYWHjYdc4WrySKe3//f/a
 0Rpi/iIDGfQeqHzt/EPFr4g2eygXNxs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-GfNpdgjuOFCRF-QXy_UYbQ-1; Fri, 11 Sep 2026 05:02:46 -0400
X-MC-Unique: GfNpdgjuOFCRF-QXy_UYbQ-1
X-Mimecast-MFC-AGG-ID: GfNpdgjuOFCRF-QXy_UYbQ_1789117365
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so6753705e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117365; x=1789722165; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wqIBh6wrg3/cCLBO/xish158SNEF5YQcKd9WgGS4UWY=;
 b=ZrTN0zAb/BYQX1KNzJ5jMkdZ4n4qiySEgqBuuSs+JGDSe835aqum8Ewq0kGY3FTQSL
 i7pkmSsMhjpeu4CTeaL6dWEiE2FbM09PIDvo6DUuS2105+229/eBGYgnypTy1aJ336Hy
 g8TRHVO0OqlEpm+wEkdSQTpgA943R2ZJxjZhMJRVs1+TTEAil68MWP4gCvLwdr+UWP5P
 0MDnRRyBKqhpFhY87uANXNLe4j05338rUXmrZJfgO71kgwiqx+s3yicvAhJ+84jyqQny
 4D6k7JmCHETVtGzkn5EypPWtvH+AWNUR/eibm04wM/KrcDUqUKMd4AFgIvMoZiwTHlIV
 /LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117365; x=1789722165;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wqIBh6wrg3/cCLBO/xish158SNEF5YQcKd9WgGS4UWY=;
 b=mwMod0EvYKXM3VISVLoqVoLsSvA4+8I4lje2LHPiFzs2seCjiLqtuJ6RVewxeZxqyB
 Mmj3cYFmy4BJp57V8xjzMAXoWJ0bqSf849HolaLgoxMwHSBDowrN1odxIafbP8s8a+KM
 U4B9RwRv2WkxbZc3zhZL4hTnUCcI5xA+Q3UHvVZllVNsb+XrxhUozPiGEbTJiF1T7u+3
 nf3G28a7J/BHEvkDIEu6hdQ4gAYSb3cHoGgtoIn2S/Iz5PGr2+KMzt44TM5FL9tfXcuw
 fRZwkVb+xnkZHwRxh3qSAfxVH5+sZyQm+bW1gMWA1jlZKYcD9e+UKBFMuFKLtn/MKbUG
 ceCw==
X-Gm-Message-State: AFuF++l1LEgsl+/IcREoai1Z7qE+WBu6fGkIkIZaDzyoh6lb7ZQjTzT5
 FNQ7qddXjgrOOjPZnZthcgiTqAOGr5Gv5MHkL5q54jx53MlCm6UBirZL4xEvszB70oQwlN7hVn6
 18Ge002D0Ef0+VGJnmWfumNvbR5W2RzFHZGOwk9ua4pGO/Z7tU+RooybdpNJF7trdSWhe3nRD7N
 58W646MQk7WQgjxNJiTzG6PmQ5r4Dl0vLhpQ==
X-Gm-Gg: AYBFou0SSz+hx978kE+mMzz/ArOmJeMPnVp2QBdoJLmSjGhzjxGclDxcM2OrPVbN8My
 H0/LEtd9YZoFdbUWlaD9XKqcEvZEKJN8OeBpnkRgrG21o4H5aJdH8fyUr40Ec/rjprPmWJRbfiD
 4bxY9NLrP1VcddzzQJp8tjt5wf3lbuVetXLJI+k/TwDlKAGom1Gozu/MG7Q69+7puMhQBgSdaIx
 ZrB6nB4cQMq1sx2vIv+JpfPsHhefdt+h9gP9Ul5wrSZj5qr4PckOsobfMkNKVrsF/Se/UUw5SgP
 p+YbWtSucJRpSiov4u3wK1Gxr7dmVxK+gcnvC8OSShKNFk2yibnvLmnXg+vqEgRU5y8V+KkyZbd
 d81wIKD+hx1WKx0wz6NQU/v8=
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6c:be0b with SMTP id
 5b1f17b1804b1-49e619bd068mr40685275e9.17.1789117365085; 
 Fri, 11 Sep 2026 02:02:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6c:be0b with SMTP id
 5b1f17b1804b1-49e619bd068mr40684385e9.17.1789117364446; 
 Fri, 11 Sep 2026 02:02:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm69473825e9.0.2026.09.11.02.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:44 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org
Subject: [PULL v2 35/75] hw/ide: Have ide_dma_cb() complete accounting
Message-ID: <578d59de7220df86e87a43fb1a435b3927aa27b4.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

ide_sector_start_dma() starts accounting for reading and writing, and
ide_dma_cb() is supposed to complete it, but currently does not always:
In one case, it just forgets it altogether, in the other, it uses
block_acct_invalid(), which should not be used after a cookie has
already been created.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724152315.234183-6-hreitz@redhat.com>
---
 hw/ide/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index ef573798d9..06e6bb6067 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -898,6 +898,7 @@ static void ide_dma_cb(void *opaque, int ret)
 
     if (ret == -EINVAL) {
         ide_dma_error(s);
+        block_acct_failed(blk_get_stats(s->blk), &s->acct);
         return;
     }
 
@@ -968,7 +969,7 @@ static void ide_dma_cb(void *opaque, int ret)
     if ((s->dma_cmd == IDE_DMA_READ || s->dma_cmd == IDE_DMA_WRITE) &&
         !ide_sect_range_ok(s, sector_num, n)) {
         ide_dma_error(s);
-        block_acct_invalid(blk_get_stats(s->blk), s->acct.type);
+        block_acct_failed(blk_get_stats(s->blk), &s->acct);
         return;
     }
 
-- 
MST


