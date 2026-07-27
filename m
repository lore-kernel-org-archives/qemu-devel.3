Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F642C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQt4-0001im-QR; Mon, 27 Jul 2026 15:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsU-0000lb-LV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsT-0000fw-2N
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdJn1rkxxE4Yq/DoPEG7mWd+n94EmQAMEDDDrQky7J8=;
 b=MRhNOjw7Lr53k53af5Oi1W5FiuycUuZ77U4an7Qx/Kd1EYAcMOTawhTNBioA3iwESaTmWX
 78+oX2oh6vMd1Em8b2yA4C7zm2Z5Vtk5tGXTIT6mseUhPM7OBD7MDCOZJAXUiVdGPUJ7P4
 N2wqvYgpwG6JafOKhSqouj7xBdICVqg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-0pa9BLCmMBaDzJoQkZ8AFQ-1; Mon, 27 Jul 2026 15:20:39 -0400
X-MC-Unique: 0pa9BLCmMBaDzJoQkZ8AFQ-1
X-Mimecast-MFC-AGG-ID: 0pa9BLCmMBaDzJoQkZ8AFQ_1785180038
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-472a798fc7cso2396422f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180038; x=1785784838; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EdJn1rkxxE4Yq/DoPEG7mWd+n94EmQAMEDDDrQky7J8=;
 b=ZbQCoMdh20Yrh9I6prMI8/FHR0pKdbVtZZjlxWRAT5U+Gm0d4vddJHYaUiWzh3st8s
 8PHOS9huj5P+hBJI5DSQnGUYJivgmOZjN8UMHUMI+lPo3nz/Oq96c/epUaXoyuM1r7ei
 XDwVhuObgHwqmjz1GHzo9+DpdUVEu1pDZ24vrfLO7yk59ko2qdl9rLKysdSXeoAcJjxn
 PZa78M7eQMwR1tdokkupinLiDgEMjmJoB3Rjo1I01oPI9OIFY6bE33DENR7lyl2v9MQY
 OHAYnbDh1TL+2MaB3D6T//3G7xu3sClR2HHxirTTGgllstCjiker4SAAJSDcZ+eOYFtc
 bxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180038; x=1785784838;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EdJn1rkxxE4Yq/DoPEG7mWd+n94EmQAMEDDDrQky7J8=;
 b=ZMb3JdeerisqcXMpTQhdwKrbSNHsHJN3DVDo5NRiDa5/QU/bNzCrU6pDZFYIc0Rh01
 +3HgGK/1NcSd+cKNqHaOQEWsPE1CSWtc1VeeCQCQIpJwQ6QVYF6THEuQyrwb6o6LsXKZ
 RvUgRNerICiXJkSXrEwtbUOswr6ppngVHuUC/iciLItNGkL7xrgRZOGEjdJ5R5N8FSDl
 QiJ1EzfrkWZ+7QToIDjBghdBq2SKCaAsA/FBgEh/g9mcNZBOJH/KIVo5Q3q5YzVW5LEi
 zHeEoJrKrGh7gWO5DqrBxpTCuX5wA19WXkF+YFqRckk2lVcJH+xh39HgoJGZ2LZ1KI28
 +Pmw==
X-Gm-Message-State: AOJu0YyWV6tYW7ty28H9HsGhAgVtN8hSb7tMk0tCW6/vMLXZvlSBfCa5
 x/TPFua2uwwJqfd8S/305Ryp10o4sgEs+WPYUZcRzaN5k+is2U/ZwQHngynB30T+LbHN9ioI1XS
 p2YH75fTO1rpt/SZWuNgO3fUe2fNyZaiYZlSH4jmDX+H/IeakfrrET9JLkptH53VKsKvbwhfZMz
 0X0OdzuEg8aL5uM2rQmO9zEf+otOqPgZbJnA==
X-Gm-Gg: AR+sD10JziAmvhHbx6G/b7+FHVn+3YCyOKWg/ZB3qLC4sTW67osMhXCU+xZwnINoGAl
 9vNZuq3vCKGqI91zSPjkq5wbfsaVNxfR+d0Zg3f4kgoroXs6u9qcapgdv7xAoaxSda/6znJrAuL
 GwFrUQSAt80YFcsUP7rC5pvGfvfRu2d1fXPXimN/wkQxUUab4whTnSp9FJy0vbkLdTu9+kVmjqY
 RfCCh40bzO4wxHFi1dDTaKJacR7MDbdWjCMrjRrMutL/fm4zDCYky8D5V3IPAJOuc+xGLNf42I6
 5RXRSOCdpziI9Psuvs1Hi9hL8pPhBoQT7VntWi3/P/HddYGK25F6kGIg6Oc52nA9nddFxXUE10O
 5yHhmTwtewzWy21GAG2DzjA==
X-Received: by 2002:a05:600c:4295:b0:495:7990:a1d0 with SMTP id
 5b1f17b1804b1-496b571a0c6mr80384985e9.19.1785180037795; 
 Mon, 27 Jul 2026 12:20:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4295:b0:495:7990:a1d0 with SMTP id
 5b1f17b1804b1-496b571a0c6mr80384665e9.19.1785180037255; 
 Mon, 27 Jul 2026 12:20:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44b84edsm22071515e9.5.2026.07.27.12.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:36 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 alxndr@bu.edu, Giovanni Vignone <gio@octane.security>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 27/30] hw/net/virtio-net: Protect from DMA re-entrancy bugs
Message-ID: <df12999cc81339ffb252875608919c72ccc37bcd.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

From: Laurent Vivier <lvivier@redhat.com>

Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
so the bus and device use the same guard. Otherwise the
DMA-reentrancy protection can be bypassed.

This update was missing in CVE-2024-3446 fix.

Fixes: CVE-2026-66022
Cc: qemu-stable@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: alxndr@bu.edu
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4073
Reported-by: Giovanni Vignone <gio@octane.security>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260723233555.2970619-1-lvivier@redhat.com>
---
 hw/net/virtio-net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7e0c984ec6..814b99a43d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3009,8 +3009,9 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
         n->vqs[index].tx_vq =
             virtio_add_queue(vdev, n->net_conf.tx_queue_size,
                              virtio_net_handle_tx_bh);
-        n->vqs[index].tx_bh = qemu_bh_new_guarded(virtio_net_tx_bh, &n->vqs[index],
-                                                  &DEVICE(vdev)->mem_reentrancy_guard);
+        n->vqs[index].tx_bh = virtio_bh_new_guarded(DEVICE(vdev),
+                                                    virtio_net_tx_bh,
+                                                    &n->vqs[index]);
     }
 
     n->vqs[index].tx_waiting = 0;
-- 
MST


