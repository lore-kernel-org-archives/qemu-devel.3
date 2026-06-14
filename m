Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793F5CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBN-0002vK-G2; Sun, 14 Jun 2026 15:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBM-0002nO-Go
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBK-00021u-M5
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wven1IZ1pJBmkOs/LOXOpmRVZifqPAgbVO1O49C6M1A=;
 b=AMB+Hf68SvWsoDq/HC6jX+ZbwftSASKdmnGZ0s044TbXjIXmcptCOpDZI8AEqp1OchfE5P
 Ldb0SwdiuWQLUOF6Mw6S2DfF2uVdt16R2AT/AUIBygZkjdJOXNudsZeNc7YZ+jWluTd/Z6
 3dPXGay1ODMANp1Pvg1A0/b7vshRILI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-YFnj7G9cMqeAfka6dL9wxQ-1; Sun, 14 Jun 2026 15:07:40 -0400
X-MC-Unique: YFnj7G9cMqeAfka6dL9wxQ-1
X-Mimecast-MFC-AGG-ID: YFnj7G9cMqeAfka6dL9wxQ_1781464059
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so25301895e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464059; x=1782068859; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wven1IZ1pJBmkOs/LOXOpmRVZifqPAgbVO1O49C6M1A=;
 b=ZtZAN1Z1qLx9WoixIpmVlMfU0bz2OYTb8TdYAWGE3WYvh3JKLN7gmAt6PHebyJay/2
 yf+Hmd0Mhkcv5aw/7v1QrV89wCGE2XZhk8LUeYx41pInABxfvCPIBwolE2kCiBVz5DT9
 s6zETgiwtCyhy50QlBdjzXZBRcOySi04j05DJkacTjA2BMxFGohM8FubNEMKNgcVUGKz
 ZGNXZ/PixJI6vkoC/0zUNkg3dMWLdO3s68xSxSZjhkli/Vn0GV7SbH0V18S7wyzDGrmg
 lwPX2K2a6D2Fb3IEWuqpyrVumUjPasC7LDe4Ro1GLg653W9BmfQfts411SC9cT7/xlXF
 NPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464059; x=1782068859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wven1IZ1pJBmkOs/LOXOpmRVZifqPAgbVO1O49C6M1A=;
 b=l36nWg0QcSsv9vy01f+ngJhc69F+vPlpnrgpnBdPhp3S/O+we+oRP+N4YXWw8PSkvM
 cYpL6fQ9wXpCvByWMwcFHMe1wVQ5pT5DQuojE4VG3I6OG39q6aJslw1WWUg5lmvmDXPk
 Qk39iPNOf8q8HK0hsa6VaITPsKHcQq1jgIcU/VnaFwQ9sQZY9WSfbFcJZlClX0kd7D4B
 +GnGE4+T8QW4ILTmfmh0fKupA1jcDEoYWwwIO2aTeN+L4+LFy9d0UHba/BBEsZrQvOiq
 DWrhN35mcNWHTgaMf0p+iqVMUiAHM2p4IQZv+TMvKwTwYeymbrpWVydxqvCGozSY8qX4
 QewQ==
X-Gm-Message-State: AOJu0YzC1D34XoyG6ip+i+KeDDinyaZN0TkLWh+2sWAWQo+idZlM2bZe
 2uYq/biz7U58h3oiz3pUGiXHCyetj+HSRUPfsEA3EdpvDCE1cxARllJPlfCNe6alccYCCVIV/jc
 lz2hlGkxLA0/lKWdGfDxTJPt/qHTy6qbxEHZi44I0wZpX9SAPm/I3/SThrCWnUQ4/FG5jPc0rls
 y3SlRt3zbvE9S+W4cMVwJ2DzECNZQHa0vGFQ==
X-Gm-Gg: Acq92OH1v3oEooYSBdTn/52DcZECy8IydoCTkVCVfhdkuWwyAGZBTYUGTj3QAP7/Jii
 5SWo4cEQBvLeNqEjJWjrck4mGB0El+02100lJ4dHFGpvwrJUQOXNRHtvedMxH2GEFr+Pe2hyeAT
 I2WnORpuBoitbbz67xid1neEF1t6IXM+ac2Dv7MZG8YcUW7o7F8KeFRQeCeZpunkHnVSCQlI2Ln
 ezycvlEklgmvZRScgvq1GZcj+1nh/i/8kdWfdeMKWmOVB6a2J/lBlwoH9GrLggsQGkoKeWfuFmf
 ZEovEZQ9mAnkgSUG9Qagv/l2gmL6/dFgnMdsFmbzr9E85f2yZkQkLD0gNIEW+0EToA0MwpUPNdF
 h2NWFZGgGyOQfnWIqKYfQJ5lv6qN2ngaBjwyfRNi/TV4=
X-Received: by 2002:a05:600c:1d99:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-49220061e5bmr92733675e9.13.1781464058758; 
 Sun, 14 Jun 2026 12:07:38 -0700 (PDT)
X-Received: by 2002:a05:600c:1d99:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-49220061e5bmr92733305e9.13.1781464058161; 
 Sun, 14 Jun 2026 12:07:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203d2449sm168720315e9.14.2026.06.14.12.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:37 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 042/106] vhost: simplify vhost_dev_init() error-path
Message-ID: <ef817ddfd90f158b9769baaadbdb9fb2a52d3018.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

No reason to rollback setting up busyloop timeout on failure.
We don't do such rollback for other things we setup in backend.
Also, look at vhost_net_init() in hw/net/vhost_net.c: we may fail
after successfully called vhost_dev_init(), and in this case we'll
just call vhost_dev_cleanup(), which doesn't rollback busyloop
timeout.

So, let's keep it simple.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-17-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c71b18cfc8..7f370f393e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1624,7 +1624,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                                                      busyloop_timeout);
             if (r < 0) {
                 error_setg_errno(errp, -r, "Failed to set busyloop timeout");
-                goto fail_busyloop;
+                goto fail;
             }
         }
     }
@@ -1664,7 +1664,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     if (hdev->migration_blocker != NULL) {
         r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
         if (r < 0) {
-            goto fail_busyloop;
+            goto fail;
         }
     }
 
@@ -1696,17 +1696,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    " than current number of used (%d) and reserved (%d)"
                    " memory slots for memory devices.", limit, used, reserved);
         r = -EINVAL;
-        goto fail_busyloop;
+        goto fail;
     }
 
     return 0;
 
-fail_busyloop:
-    if (busyloop_timeout) {
-        while (--i >= 0) {
-            vhost_virtqueue_set_busyloop_timeout(hdev, hdev->vq_index + i, 0);
-        }
-    }
 fail:
     hdev->nvqs = n_initialized_vqs;
     vhost_dev_cleanup(hdev);
-- 
MST


