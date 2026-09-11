Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF79C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9x-0003i2-8m; Fri, 11 Sep 2026 05:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9e-0003SP-VZ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9c-0008Cb-Pn
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3G43obeGkrZrvaSbMOJK2K6rTqOeLtl6zfRvJGCm6co=;
 b=YL5/kR0fhljGVBNkPiiDfsdYRU0rNam0Y6OEiyacVPsM2ThKNLVZ0NAyxriPge6STmv4yz
 iFxy9ZyFUZxn7P2KD5qlSJ/XvTaHby/CTK+C2kn0T8CsHtrAuPyDfIFbBRzvby9Agd+JT1
 4IDgrnpnCN5Qj7m6e03LvHhZ7J+Yppw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-AJngWoTdO1uy5ENCssypNw-1; Fri, 11 Sep 2026 05:02:38 -0400
X-MC-Unique: AJngWoTdO1uy5ENCssypNw-1
X-Mimecast-MFC-AGG-ID: AJngWoTdO1uy5ENCssypNw_1789117358
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482e05af072so558522f8f.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117358; x=1789722158; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3G43obeGkrZrvaSbMOJK2K6rTqOeLtl6zfRvJGCm6co=;
 b=Gpa9t7DK4ARUMwovIqLnoPZQoiR+3H3LCJvvVSYR58vXWmWBelhzdYdrbEsvTrnRGu
 Xpahq/4djeMWQWLc1VdPXsBpmb9nsLtFovllCpacCLNj1J5aJ/3uF4mHhYeUd+kQtavp
 cemRW9SzEZqFAvKoqoyDYuX0nEklVH9yX1gY4bLhrH6kB0oAo8rnqcILi3LbynO1NXnk
 DTtoukEO6aJhdlHUqLaC5bGkY+tv21H0c5K4NjBdG/mO8D9a1ExnVUdUyIdevUbqZMNj
 zCBYV6uunRmvZ/ACLfmdCY/DXnEgMt9HPB7W4V6ADJ/LGebypEvi3RbtldS4CeDcLTcI
 PsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117358; x=1789722158;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3G43obeGkrZrvaSbMOJK2K6rTqOeLtl6zfRvJGCm6co=;
 b=VHCWAWF3BOTB/IIHdkin/idUZNqSWaRNdky6TG/LbRS2HjTV2hw36PKaKkzc2WtOCC
 svLbIY3PhG/+olg0PB4SU3cKCoy86XydXey2kdf8a2P+rOVtXEU81ULm/9nc1L8q9EZR
 RqDzAIk/1KO5a2wrip68pNqds2DaAPaxoitOQTaaTAuBsP+XVSLocHqs5AAionLkMYtE
 Vqykn9S7yNwTx8J01BGBnhwldsR2p71uT/pMcbtFcCs6OE+FE6Rfah7ZcHaOhhRIjvRr
 HACu3RRbIaC7EZS6PHDSp3Lc5AYpvWgf3h+sit1v/qWvg1BtW3XoJSUkBbiPmhxFn7NE
 UIkQ==
X-Gm-Message-State: AFuF++nXjIiRTIiF8fyElLrOqkr0Xi8U+dVKON7OnW5FDstsgF3cCNjT
 e4fJSAvoIhI66+Q9b6jHtNaRLW4DlSa67dVMmnz1QG/xZqPUUYE6yc8cUVBrdUz20G3MXUz7+N2
 sgbLIMrdbzCJY3YmpX0xLFTJqzS1N3VjviYIohQ/G2OfeLVLSdhSjBQc5QVx70TBwBnO6WketD1
 FSN2oqoDdd9UJ7WrbdHTofthq2+5GbYxG92Q==
X-Gm-Gg: AYBFou0TNV4Xugw5uuaTfI58uJ1aBjL/z8n2H/kYEXlYxJjv2o/attDugW9F0uREbAR
 PNusYt4LCQCxcVQt54sqlkl1mB/wjCdF8fR9SUUmI2Fm0qv6pMgpZZwYmLidGOw6TB4xcIIE2Fz
 z8uPRPuvcv2naRbmHCxrRvJQtblUjdpJpg0T5mMaiYoy3AUyN2cMEC1fEw5LGaOqaBkUsl0AJWV
 sdEPtX5u6O2EZ1782bJSQK6ZnfDSrDtSKgB1EDStkHOqTBLZeduMeXrmz6BZK/kDofvKb2+oclQ
 a9kBY7sQOTqyZPpx2k6H3mTET3Rw4gy/Nr7thJryGnYY1iOto/4dKTI5lkznoZqAgTRAJKYU03H
 EGzCOh73ReLA01ua/Z67qrm0=
X-Received: by 2002:a05:6000:400d:b0:486:e1a0:4451 with SMTP id
 ffacd0b85a97d-486eb1d9caamr3521144f8f.24.1789117357522; 
 Fri, 11 Sep 2026 02:02:37 -0700 (PDT)
X-Received: by 2002:a05:6000:400d:b0:486:e1a0:4451 with SMTP id
 ffacd0b85a97d-486eb1d9caamr3521083f8f.24.1789117356899; 
 Fri, 11 Sep 2026 02:02:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35bed0sm4412415f8f.32.2026.09.11.02.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:36 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PULL v2 32/75] hw/virtio-blk: Complete zone-append cookies
Message-ID: <0e9e4f715aee501c7f87bf821a73a020c24c8640.1789117222.git.mst@redhat.com>
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


