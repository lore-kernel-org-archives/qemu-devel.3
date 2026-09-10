Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D050C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4myR-0001Xz-4e; Thu, 10 Sep 2026 18:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVV-0006Mb-9Z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lV7-0003gP-3p
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3G43obeGkrZrvaSbMOJK2K6rTqOeLtl6zfRvJGCm6co=;
 b=aYZN3ziRwwdZ4a9BnCKhKDPnmQq2N73eYqogDbV5iaWa7DeBfMzRVdezYVk5aw7oqQd9n5
 Bc1+f3NJ6HIokZgiY/DsUZbPJBQ39Cvnj0eo4kk+y9/VkzLkYMJ/tM5r361wMDPh/vIL1t
 red8qOTqo/c6v3knUwGlm2NXdhQHUCI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Xe2MbG3DP4SdOe3CfQbR9g-1; Thu, 10 Sep 2026 16:13:24 -0400
X-MC-Unique: Xe2MbG3DP4SdOe3CfQbR9g-1
X-Mimecast-MFC-AGG-ID: Xe2MbG3DP4SdOe3CfQbR9g_1789071203
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cd55ee2f7so1863605e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071203; x=1789676003; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3G43obeGkrZrvaSbMOJK2K6rTqOeLtl6zfRvJGCm6co=;
 b=eyDeUTJshDojg6g7gl2wpaqtjlqIQaV9EioaZyLM2bEOtyS1LmuhDdxb6A2OQ1945g
 dgfILB3n8tVhj8kKGxJ068MWHE62yeV+aZHxURSwlVoAbibOAiutlOisZgpj0y7naPGd
 Rcdg+hALp97pR52oPl6UVSmu+P1YfPZQ/tzzSnnADfUUoOsV0s/y333RCxE4AXLNNW7E
 JszJzKeutOK3WCZsD2yS/AWfW82lN86mtTxwblzu04xSiEk277MkZeP82MS9e2FJ6o71
 Xi5u3ZJusM4qd2TGvbuBa3K3wgQj+btYtXzXgJriyTE6ZKPDMREIzF33o+FyFFn1JVl5
 7JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071203; x=1789676003;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3G43obeGkrZrvaSbMOJK2K6rTqOeLtl6zfRvJGCm6co=;
 b=geXse2fyhY/0m1hWmKCB2Z3pRAnA2A5NoYj3nxGLgmPmTo4dr81s1oZMUK675BCpGn
 zFM4bx3etkw8enZPjUwrVzVmzpCbNxH8c2pCAx7OFkXTLHJjjEg1nP38ZuWGwgaZRCFn
 HwgrfsAH9PY4UHLmy/bXZdUCW4vu7tzON4IGCa2EZjEI6n0jYg1ZujmtRbshqzu9jGvt
 rr41c6yVfZ3FQMPSCMabtGDuloX/Crjx008kC0VZpvLpNLMOZ2SO81TZGsu4kvO5YJsg
 fGjC0JybU+MloWQ3VGNLW/1L55TVLfYG+0bGlZQB1BdU0sb/iRaFp1LrFUrHql5a0y/l
 47eg==
X-Gm-Message-State: AFuF++mgGOIicnIilOWh0Y7dVkP8KyTRSbdk/wDzpIIKDmGlsMdk/F4j
 oEiq9ccPP4vvVhXKob9d4L/xJtHUnYiOvO1JkmotSlkCfWCHABGIZMdCaebqjhc4c1iuNYpBmvU
 GX1RON5Ib49uKifnuTLLW8JDWQg1TB5FG22vKhXbcFQivWwnd0p4j90p/3KUmMJ0u73m5cKLdyd
 L2lIpRVnLLDakwlL9eNOnWp7HaCFURwt+GNg==
X-Gm-Gg: AYBFou3b1lDWDU8zyOp62sKcdlOCmeJbIbgyWfwTUplToR18Lj/yCy2ScWH5xMq804R
 5JC20xYCuU0pycXmOWaYG5JHdgIebsIZpOupqMx8MqUPx9dZ0oi1GThBV+HNMYDbdbFFk5cboDY
 ZTKnWBqxkaEDtgL5hXjpEQMD5Vbr/y9GD7YTlEVCzAJy/J87Ql+AuncL4E9gep5vgy9cCRw2+h3
 IrICm+PjQyR+PGIr6vnzSHV3OOFcroF8xG28HlyCmF3ppRkCfsLFnX8oHFJbWy/IQQYNvH6emh0
 ZBJDnzU/drbNNgXvaWvXuS0lGi3w2Q9Qf9y3dmxYlJpmikek0aD7BA5//mgwpD4961709EQTUfs
 wq5cmkOeuisvcFZ7ukc+0wUs=
X-Received: by 2002:a05:600c:860b:b0:49c:fa21:1c87 with SMTP id
 5b1f17b1804b1-49e619d1bddmr6851045e9.28.1789071202974; 
 Thu, 10 Sep 2026 13:13:22 -0700 (PDT)
X-Received: by 2002:a05:600c:860b:b0:49c:fa21:1c87 with SMTP id
 5b1f17b1804b1-49e619d1bddmr6850615e9.28.1789071202421; 
 Thu, 10 Sep 2026 13:13:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ac42b9sm17723175e9.6.2026.09.10.13.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:22 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 46/90] hw/virtio-blk: Complete zone-append cookies
Message-ID: <562021c4e4ca62f408728d814ce7290ba35b7e12.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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

virtio_blk_handle_zone_append() starts accounting via
block_acct_start(), but this is actually never completed.  Do so.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724152315.234183-3-hreitz@redhat.com>
---
 hw/block/virtio-blk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 4110380392..61c341ce2c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -755,7 +755,8 @@ static void virtio_blk_zone_append_complete(void *opaque, int ret)
 {
     ZoneCmdData *data = opaque;
     VirtIOBlockReq *req = data->req;
-    VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
+    VirtIOBlock *s = req->dev;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
     int64_t append_sector, n;
     uint8_t err_status = VIRTIO_BLK_S_OK;
 
@@ -778,6 +779,11 @@ static void virtio_blk_zone_append_complete(void *opaque, int ret)
 
 out:
     virtio_blk_req_complete(req, err_status);
+    if (err_status == VIRTIO_BLK_S_OK) {
+        block_acct_done(blk_get_stats(s->blk), &req->acct);
+    } else {
+        block_acct_failed(blk_get_stats(s->blk), &req->acct);
+    }
     g_free(req);
     g_free(data);
 }
-- 
MST


