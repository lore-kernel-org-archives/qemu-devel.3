Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDA6CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0yz3-0003wA-4h; Tue, 23 Sep 2025 05:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v0yz0-0003ux-L6
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v0yyk-0008OY-Fh
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758618383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7jMiyHHwtKmMvq0mk1wU4kw143HvrC1x6M6BtqO9KY=;
 b=EdQuKx6AIZabqP+kj0Pi2ORAcUHV0B32Q253Znf3qwNQw+X9VOKLRyFAjbMzBK4gKmz319
 S/kUinEfIWwmWJDxi5YKxv75W7ffbK0X2HXnRTv59i3dHUAnfjzd9C0sFcJ9m+Fq1GltIQ
 UedS5xaChuaWEs/dEEsn2F2sYeCVIK0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Kot6wcaPPP24zoOlVw4mJw-1; Tue, 23 Sep 2025 05:06:22 -0400
X-MC-Unique: Kot6wcaPPP24zoOlVw4mJw-1
X-Mimecast-MFC-AGG-ID: Kot6wcaPPP24zoOlVw4mJw_1758618381
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b98de0e34so45063185e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758618380; x=1759223180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7jMiyHHwtKmMvq0mk1wU4kw143HvrC1x6M6BtqO9KY=;
 b=jQxalIVSSp7ltjzJc5HzdD6WqhOMd5b2Dq3bdvHeAclbPx3D0BuHOEcygS2c5ahZgZ
 zR5pUpyWlN02GcKZl7dXSkEtf9im1JCduF92D0fXYUPwjrjpK3aAsSFJYKn05KsB96sh
 nVaK9YomCk2Uk19v2N24ST1fx4gZS1+bzfhnsn39To2VhvRhIm8mdVgOS1UMoDNP8OKI
 bnJ5xCaIBqh7E6zp4JQjsFANopvhlyH39D1z0zuQU9SOPpY/LF02PNZYzSE2jKIkzu6+
 k2DvpM8CuQV/J4KrHn4iUOhlVa2rcPWFDOJTWdXHZ7pUe/KaGA7AI0Ov8+HVweH3LVcr
 560w==
X-Gm-Message-State: AOJu0Yz1ISO0DnWKmbPd2W45Vm7FypPeP7MMjLbLvIIEs027oRxsFDzp
 R66fe0nHBsneqiyDI3hzHfiF6xcB0oNsyAQdebQzxqY0GhhghPNc5gEZygi3L/NXVEhCG79JcX5
 +Bb2TGPE0kYVSTvHqttDerGgN4MF5/2FJ2geQ8FWL8Cj4lNeyLy9wWzmil/W0HwnL
X-Gm-Gg: ASbGncv4qWHfId8YGqGmlvHk6sjtMw+XLV8NgwTmmIdbwDPVWvHaLhYHm5h6bReMTQW
 PVlHsnswBrUZR384McLmJhMFg47tiY7dHPytfJ3GfgGxecpRMF7zo2IuWpOnHzOFmsnV8Hf9UtA
 1jm/9o7GjunrxkUbLEp/Teb96OGokdRtF8yRPMyoTsGM2HHs45WA1/PNU8Z1BGviSxvtTxkwG5+
 iFhInvy8NACLVV8rhawO0k/yxOrTHvVvhYUzHnel76IxGF6fIEzv+QUn5f5WHd2PmDSK+C/aV9O
 dqzz9sYb4/7RYjbz2xTokAd0SuQzdyJL2ae0kxWhwA==
X-Received: by 2002:a05:600c:4fcb:b0:46e:1d8d:cfb6 with SMTP id
 5b1f17b1804b1-46e1dab52e2mr15204275e9.19.1758618380328; 
 Tue, 23 Sep 2025 02:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW+LIquqAZ9x+XCVHfS0Le+ZnA6l5GcyOU4RxQAR7WNpXuq9mwnt4UvpBRxqtfc3286d6M9g==
X-Received: by 2002:a05:600c:4fcb:b0:46e:1d8d:cfb6 with SMTP id
 5b1f17b1804b1-46e1dab52e2mr15203915e9.19.1758618379771; 
 Tue, 23 Sep 2025 02:06:19 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.70.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613dccb5e2sm272973145e9.17.2025.09.23.02.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 02:06:18 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:06:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Li Zhaoxin <lizhaoxin04@baidu.com>, Cindy Lu <lulu@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Gao Shiyuan <gaoshiyuan@baidu.com>
Subject: Re: [PATCH] vhost: Do not actively send a config interrupt
Message-ID: <7hklwelliflg7ridixhyiqsd3l5fmuscfai4c4xhtqswa53jn5@62k5iwtpouxc>
References: <19ac5fa24777515f9f0878e6874dc9f6edec45a3.1758552835.git.lizhaoxin04@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <19ac5fa24777515f9f0878e6874dc9f6edec45a3.1758552835.git.lizhaoxin04@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CCing Cindy since she introduced this code with commit
f9a09ca3ea ("vhost: add support for configure interrupt"), so she can 
help to review this, since I don't really get this change.

On Mon, Sep 22, 2025 at 11:19:32PM +0800, Li Zhaoxin wrote:
>From: lizhaoxin <lizhaoxin04@baidu.com>
>
>After the VM is suspended/resumed or live-migrated,
>we do not want the guest to output information such as
>the capacity of the block device, as this is noticeable to the tenant.
>Also, there is no need to immediately send a config notifier
>for the virtio device after vhost_dev_start.

Can you explain more clearly what your problem is and why this patch 
solves it?

Thanks,
Stefano

>
>Co-developed-by: Gao Shiyuan <gaoshiyuan@baidu.com>
>Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
>Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
>---
> hw/virtio/vhost.c | 7 +------
> 1 file changed, 1 insertion(+), 6 deletions(-)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 6557c58d12..1f8a495ef8 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1847,15 +1847,10 @@ static void vhost_stop_config_intr(struct vhost_dev *dev)
>
> static void vhost_start_config_intr(struct vhost_dev *dev)
> {
>-    int r;
>-
>     assert(dev->vhost_ops);
>     int fd = event_notifier_get_fd(&dev->vdev->config_notifier);
>     if (dev->vhost_ops->vhost_set_config_call) {
>-        r = dev->vhost_ops->vhost_set_config_call(dev, fd);
>-        if (!r) {
>-            event_notifier_set(&dev->vdev->config_notifier);
>-        }
>+        dev->vhost_ops->vhost_set_config_call(dev, fd);
>     }
> }
>
>-- 
>2.34.1
>


