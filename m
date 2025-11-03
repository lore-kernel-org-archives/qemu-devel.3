Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10133CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG27E-0002OJ-7F; Mon, 03 Nov 2025 16:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vG279-0002Kb-7W
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vG26w-0003nf-Cg
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762205346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAlSa5qhaV6exgePgBkXoAfT2k/imPJhTos/JwYYN9k=;
 b=i9IhAOtgPXaVRkIgW5a8mZ9kI6/giBDGmMko1OafezVDWgiTl22Il8XgaDcM7cNfQ4hltV
 S5vwu8pyp8tBnWgRj5oPXJcKZMWvWr/5zx04gH8m0gf3nHl6kWSsciGqcPmZuWIDwFN26w
 bA82hQk2qtxgS9PIhP3SCEYtsMtI5TM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-UAymfMlkN7OTCGVSeZ74iA-1; Mon, 03 Nov 2025 16:29:03 -0500
X-MC-Unique: UAymfMlkN7OTCGVSeZ74iA-1
X-Mimecast-MFC-AGG-ID: UAymfMlkN7OTCGVSeZ74iA_1762205342
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4721b4f3afbso18214795e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762205342; x=1762810142; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HAlSa5qhaV6exgePgBkXoAfT2k/imPJhTos/JwYYN9k=;
 b=rQOGpOMpkAE9SJXmx6n7HEYU19cBr/fu/GgTxWVIZlSOI4UghxF99ow0LfN9oZmgq+
 6i2mCFWQRxlf3+vnwWbrDngIW57ELPEpMPZ6oYDOjB/braTBhp9LFbuoReTRaVgmQK8Y
 Km81nvQ1Q8TsHf4v2BuYGH7PMhIjh3Allxn0odQonuoyYE/QNl4QSCdvnJI4zUjV+5DH
 QKzxcBVAgmJFRmT5DcQ3DYf5yh3LxgJ+h4mz5JtkS8+q6AiMGzCcrG2reVxH01bWwGn4
 3s7MT6oT3Ib/YONNgHlmBuGyEQ2m43+a2FIO3hyz+deKicq5rzQcwic5EBsrFE7eWkf5
 ALhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762205342; x=1762810142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAlSa5qhaV6exgePgBkXoAfT2k/imPJhTos/JwYYN9k=;
 b=Lv14C7J0ey+mCIrMYHhsavqIh+iqdKaAPT26bkbbtVhg84g4e1egpociRyLELx6/jK
 7J0xgbSWwBIVbTy0YKL2nDou+nE+p77oJTLnJIZV4p0yKjnQZ9mWWeb0fMyPnlKJc53U
 oLiVeZaJX1xX6NVze85nlgg2gvtabOOiPumrhpcjki35oy+5yBKWpz1RH3wsovHQUDbs
 gDfJN6kfpUOr/sB25+6B3jXSh+QYpTAeAMeJKvlyQgeNIniJJ3D/AI6de9/ivyTE4Khe
 m54OhjY+Ip8Ayw6EhAZPfA9+F5x7g+oW/mz/Qh9l7CABn/dptEXI9OlaHXeYVZFBFz7u
 Ft3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcYzZvRd1WIqTXi34qCrs9XayjOt0kgZUsq1nvQ6uWJltDiUaW6xTPo74t+s6eleEC5I3k0yBAM1H7@nongnu.org
X-Gm-Message-State: AOJu0Yw6qux3dzBTMfPRSTIUiRf7eiI7qHaQo+NRL5qRVpE7I7Ay/SY3
 HdGyhOPJcssYvuvZCAIS11E/DH5Nj0qqCStE5WCNoCsN4etNZ4jH+QCZzphn3FoHGCNi9KqGzwG
 AEgNjefJquxAdEj8d25xAsptbNWX48OH3L9652I0m5BPRnE4SyRAP6+UA
X-Gm-Gg: ASbGncv9R6rL1zrtz07Nv6Jg64eEZ1T2R110VJ4SaH2oWzGEo8s/p9wLd6aGTHdmE50
 60SFdgISWND0H8Jdzn0DnBS1sHxR6Z+7qzV1XhRlqhmMSdXkcBIlQ1sDR2rLdnQoqc9V3sYtNJc
 kmY+ji6ZpXaNK/ytnBV52M2Hz//mQqFoZLm1IRO+lGVuYIUt4ibEkQ3SazUEoVD4EN0VRW6uQGH
 PrbDW07KSReCxlX97PmaK8dkjk95mKfvC0O5YW2yMNHkxkkNU3Wpj3IQYm9xBjSg8FduryX+nGN
 hB2kMCibJ0MpL/U/tXxKeNnI7u5xhzrzGFqr4TUyRNMm+k6AuqdU6mfE3imNnBs=
X-Received: by 2002:a05:600c:3b1f:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-477308a8988mr133004125e9.37.1762205342121; 
 Mon, 03 Nov 2025 13:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEa+5p39jhpRRZNPZTwip8o3SNwe6L9Vh/gYSpo8dXh0Mv238Fyj0yY+FeRJaBBdYzMAuyDww==
X-Received: by 2002:a05:600c:3b1f:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-477308a8988mr133003855e9.37.1762205341582; 
 Mon, 03 Nov 2025 13:29:01 -0800 (PST)
Received: from redhat.com ([31.187.78.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc18efbesm899298f8f.8.2025.11.03.13.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:29:01 -0800 (PST)
Date: Mon, 3 Nov 2025 16:28:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 22/23] vhost-user-blk: add some useful trace-points
Message-ID: <20251103162710-mutt-send-email-mst@kernel.org>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
 <20251015145808.1112843-23-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015145808.1112843-23-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 05:58:06PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
> ---
>  hw/block/trace-events     | 10 ++++++++++
>  hw/block/vhost-user-blk.c | 19 +++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index cc9a9f2460..dbaa5ca6cb 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -58,6 +58,16 @@ virtio_blk_handle_zone_mgmt(void *vdev, void *req, uint8_t op, int64_t sector, i
>  virtio_blk_handle_zone_reset_all(void *vdev, void *req, int64_t sector, int64_t len) "vdev %p req %p sector 0x%" PRIx64 " cap 0x%" PRIx64 ""
>  virtio_blk_handle_zone_append(void *vdev, void *req, int64_t sector) "vdev %p req %p, append sector 0x%" PRIx64 ""
>  
> +# vhost-user-blk.c
> +vhost_user_blk_start_in(void *vdev) "vdev %p"
> +vhost_user_blk_start_out(void *vdev) "vdev %p"
> +vhost_user_blk_stop_in(void *vdev) "vdev %p"
> +vhost_user_blk_stop_out(void *vdev) "vdev %p"
> +vhost_user_blk_connect_in(void *vdev) "vdev %p"
> +vhost_user_blk_connect_out(void *vdev) "vdev %p"
> +vhost_user_blk_device_realize_in(void *vdev) "vdev %p"
> +vhost_user_blk_device_realize_out(void *vdev) "vdev %p"
> +
>  # hd-geometry.c
>  hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p LCHS %d %d %d"
>  hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t secs, int trans) "blk %p CHS %u %u %u trans %d"
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index de7a810c93..a5daed4346 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -31,6 +31,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "system/system.h"
>  #include "system/runstate.h"
> +#include "trace.h"
>  
>  static const int user_feature_bits[] = {
>      VIRTIO_BLK_F_SIZE_MAX,
> @@ -137,6 +138,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>      int i, ret;
>  
> +    trace_vhost_user_blk_start_in(vdev);
> +
>      if (!k->set_guest_notifiers) {
>          error_setg(errp, "binding does not support guest notifiers");
>          return -ENOSYS;
> @@ -192,6 +195,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
>      }
>      s->started_vu = true;
>  
> +    trace_vhost_user_blk_start_out(vdev);
> +
>      return ret;
>  
>  err_guest_notifiers:
> @@ -212,6 +217,8 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      int ret;
>      bool force_stop = false;
>  
> +    trace_vhost_user_blk_stop_in(vdev);
> +
>      if (!s->started_vu) {
>          return 0;
>      }
> @@ -233,6 +240,9 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      }
>  
>      vhost_dev_disable_notifiers(&s->dev, vdev);
> +
> +    trace_vhost_user_blk_stop_out(vdev);
> +
>      return ret;
>  }
>  
> @@ -340,6 +350,8 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
>      VHostUserBlk *s = VHOST_USER_BLK(vdev);
>      int ret = 0;
>  
> +    trace_vhost_user_blk_connect_in(vdev);
> +
>      if (s->connected) {
>          return 0;
>      }
> @@ -365,6 +377,8 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
>          ret = vhost_user_blk_start(vdev, errp);
>      }
>  
> +    trace_vhost_user_blk_connect_out(vdev);
> +
>      return ret;
>  }
>  
> @@ -455,6 +469,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>      int retries;
>      int i, ret;
>  
> +    trace_vhost_user_blk_device_realize_in(vdev);
> +
>      if (!s->chardev.chr) {
>          error_setg(errp, "chardev is mandatory");
>          return;
> @@ -514,6 +530,9 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>      qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
>                               vhost_user_blk_event, NULL, (void *)dev,
>                               NULL, true);
> +
> +    trace_vhost_user_blk_device_realize_out(vdev);
> +
>      return;
>  
>  virtio_err:


Is it ok that on error there's an in trace but not an out trace?

> -- 
> 2.48.1


