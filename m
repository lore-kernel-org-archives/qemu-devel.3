Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76859CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBs-00055k-Fr; Sun, 14 Jun 2026 15:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBq-0004oZ-Cd
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBo-000291-IB
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzSDXCMizU4TOWSVQ4fgeunoJ6amd5xM77Merhp11X8=;
 b=hhCLIHglBqDbUE4xecAlYdaBkNO8zTGV8noWX8qs7VQwSvls7CXaSDsTBh7PgtDYExu5gX
 MbTmHu2i5OQ1cAnb5HFoi5TKW0AOtgZ9prANjoLHssuI/l67t2qIoxLPo+YseC2G7Wilqq
 H+JujOZWSGd3OU5rWwfGuPFJ0Jx5J4s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-yeiHGq5UOBO3-0zVlTq9TQ-1; Sun, 14 Jun 2026 15:08:09 -0400
X-MC-Unique: yeiHGq5UOBO3-0zVlTq9TQ-1
X-Mimecast-MFC-AGG-ID: yeiHGq5UOBO3-0zVlTq9TQ_1781464089
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46067b07571so1600278f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464088; x=1782068888; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tzSDXCMizU4TOWSVQ4fgeunoJ6amd5xM77Merhp11X8=;
 b=c35O//bVLnMux1rzAiKo9mi8eOaL8Ns1vZyxZVKXI6ILWDG3/iAeRbbVjR5FXsJVw9
 lfu41o/XGWadV4+bOOn3WX1UW5qdIUB8jyldsWf+uu35nXlB4JlMuOqhUOHG4PV0RlEU
 vjRwpeBzExFly9z4hxsDJwm4GlLVpoVE52KcJtIC4srUSyd/16piyQzrkiZkx5xNttB4
 /IQXUS3mO2NPmfBtpuIX4Xju+K3qkY5yx4+vD9duTPpD6zIdMmYbNwGkPTmucg27t2Nl
 2I1Mm3ixolfyal6P3OrrLzrhz7Y4MpggzywfiyFJDYz6uQzZc1EGtfqm+d9/tohysxel
 YtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464088; x=1782068888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzSDXCMizU4TOWSVQ4fgeunoJ6amd5xM77Merhp11X8=;
 b=GVLXQOQOmV4GudlWr76nfb4T0/uivp9FESBqJzJxTLAdzIrumf/D/K2n88tRAUw9iP
 le2fOngAG9dTmWkUqECzCtOE7BjtUJ2pU92YWxNztRT+jQkQzLwIkuEEp4N7MzDpMtQ1
 EJp8t7KfVWotQ59UUxrKZepv5RtONoKm+qPcNndXRnOHRT+Y53t3JmtRFPjxyQcigID1
 z9fiPqA7QpqATt6VnUNKmVgiZL0pv9feF1TiIGTT6StrUJYZ/7LZ6420Hgg3njCw1Lw8
 L2OFZSh++QrPlBnKmg/+Hh9smB1nJFpADN3g3mbt4WnLrZ4fut4k/ATI1+WwG7kuXK1I
 RzFw==
X-Gm-Message-State: AOJu0YxuhVg70Dd64Rk/i/z7di6SpxT6ty385f+1oERs7kEz7v++RobW
 Zr5epLPpNokCD9B+B9Rx01t5qF42rwqNr66o+FXV4LIAQfw9L0UFZHUKJa+TErLZiV9JslVNO5Q
 x5l9JDaO0S8YpfVnodSshogPz7Ua14M4iKvjEqoOejKyBblNm+orkHE/rgTKurAZv57BCzNR3M4
 S08Uec7YD1c3ok+81//Zfl9chDbrpqyzXxMg==
X-Gm-Gg: Acq92OGvHyK0bn+i5JzTzrtqsMqwmGAX/yCZg0QNotnJC5r2jfrKtSPHQuOI2jWRgKc
 P93ZMIVjR0pJdjuhfV5Mqg/ye/95PZ0TH1xSv07b7kpUYal9BwTidJY9LKO61/pOLvboU+tpL7E
 6yrrBKUAKCOkCPpwgS9/JPOulPSV3Skowfe0wnH3xhGF8spEguVnMNDReUJ/e6zxqaGDEmOJV4X
 qaMTLKekOwTDTvGqijzi89jA5SgWOSjlUJhvJ7LGWVSSzyCq3PJSqjNieGoM7fsgeb0oSeMXVJz
 YFvaojacij+3DLAAV9aE8C4Q0Lk0q/HH4bH8z0MOM0533xLXKAxB+bOld36yghWlTjr3th+dxlB
 rRAxhbwKkFIZxdirmyIsp0k9HNiwaFfsSSUuhwu5sU60=
X-Received: by 2002:a05:6000:41e5:b0:45e:8edc:dacc with SMTP id
 ffacd0b85a97d-4606d03bf34mr13770230f8f.27.1781464088514; 
 Sun, 14 Jun 2026 12:08:08 -0700 (PDT)
X-Received: by 2002:a05:6000:41e5:b0:45e:8edc:dacc with SMTP id
 ffacd0b85a97d-4606d03bf34mr13770199f8f.27.1781464087891; 
 Sun, 14 Jun 2026 12:08:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm25989044f8f.34.2026.06.14.12.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:07 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 055/106] vhost: stop reusing vq->desc (and friends) to store
 physical address
Message-ID: <15bbdc0a7bc96933fbe2a913346ab03dbd4584e1.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Remove the hack of storing physical addresses in vq->desc/avail/used
pointers when IOMMU is present. Instead, handle this case directly in
vhost_virtqueue_set_addr() by checking for IOMMU presence.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260206095258.894504-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420202032.714884-8-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index cc083572f4..6bb6b07e19 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -518,9 +518,6 @@ static int vhost_vrings_map(struct vhost_dev *dev,
     }
 
     if (vhost_dev_has_iommu(dev)) {
-        vq->desc = (void *)(uintptr_t)vq->desc_phys;
-        vq->avail = (void *)(uintptr_t)vq->avail_phys;
-        vq->used = (void *)(uintptr_t)vq->used_phys;
         return 1;
     }
 
@@ -1104,7 +1101,7 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
     int r;
     memset(&addr, 0, sizeof(struct vhost_vring_addr));
 
-    if (phys) {
+    if (phys || vhost_dev_has_iommu(dev)) {
         addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
         addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
         addr.used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
-- 
MST


