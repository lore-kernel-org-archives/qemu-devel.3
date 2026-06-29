Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3111C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we8kk-0003Bj-3s; Mon, 29 Jun 2026 05:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1we8kh-0003BL-Jp
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1we8ke-0005Nz-Jo
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782727081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ninfz6lvAJqQy4VgE3w1sHoX0+ZFrradoZpn/C/NBzg=;
 b=aOVL96Kh3Ww9fv0THEqWC0niIsmLgpZUw2gGOPLCSs9igJ71lhct8I0M6AFBtvvE7eypmb
 Ys1aosdqHAlaVp8cQhlxJCmZX2j5zJG6rvMJ87AdxSszUu5JRHltT2ME7u9Oa8Vu1mPGY1
 NlGJuy8YedRYxjyASLUzgSjL5LZLC2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-EqoqhvgZOPKfPjQU1UQ0LQ-1; Mon, 29 Jun 2026 05:58:00 -0400
X-MC-Unique: EqoqhvgZOPKfPjQU1UQ0LQ-1
X-Mimecast-MFC-AGG-ID: EqoqhvgZOPKfPjQU1UQ0LQ_1782727079
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-473f4a48e9aso347707f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782727079; x=1783331879; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ninfz6lvAJqQy4VgE3w1sHoX0+ZFrradoZpn/C/NBzg=;
 b=VpH9lePaMdkxXniq7KZX3VdKnG+vQRSSny7wSFrQDbAj7WjjJp+dyusYxsaXHI8Dbj
 cWdimQTmC8DWrr3X7lZ5p6MKUhGR4AKJJtt8TiF5Jrkua78nejZJ+FiZgnTCDoHrYaNo
 WWpOhnYflyCakvL5YD6CVBxLVeKva1kZdhtRNTl71PEvamcupwGflp2BUboZeXpHgD/T
 6oGqtP+Dl5NEGZGMDhPqnmwm1kd5dWXcP1wvlqLytj9kdRFJHZe0vV/NXYKot675BEgk
 wYd1+Nx7LsbVEpKN8sfM3rGcXdRSaN510rkteVZpXDuO5AzhdBxW6EZxyFmb7npwWAOU
 uQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782727079; x=1783331879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ninfz6lvAJqQy4VgE3w1sHoX0+ZFrradoZpn/C/NBzg=;
 b=WWSov170ahcGuOTvoB8cCZQyDIEGNJNXU/a7zf3F/pFAOaHQYlb5raYkk4wuhtHqCJ
 ioxn2uYpHb3bOZewf+OK/gxp0BT6kQr5O4Z1Dg1Vo/D5BwhQ54EYMh3gQsMk/TmBG7EG
 4C4rGuCjNJTyT0WNKjgNdH9315YDnieduMc8/CMqsM+SG7AL/L2FKpPAhSwUBCe5pjNk
 T12yRBwzYuKtYIf0fegHMA3Y20ABrtKMeVbMmWr8b08vL4Cz6HADDIPGBZrtQWI6a3Tl
 4RZYvy54ElSSO44z2oCtR5csmw4kdMjPiI0j9gymc5Hxnoz1kUl9XEV4kHKMieBznW9M
 7DyA==
X-Gm-Message-State: AOJu0YylARw4ACP3o6u78qQpxTwrZwUdDYlwXy8d9m+6ZHKMzTpRpxVq
 1W9ojj7FThNZg1UXyTPslTR0f4Z0fs3L7d62biM6+GeUHjyBAuBShlmIH6FeH2ysgtD6dwmpCvB
 dSd1zTCoWSXFfTi8xXxjqTixj0Bl9bsmNmoDiSQ+vxSK39a0nnL4wpita
X-Gm-Gg: AfdE7cmg0y/pP/Dei1qUZ9P3vcEGD4FJGc4j+IKv5432VWlDTIlHDAfkRrzHPRbEkNB
 Cwbke0JhYzKOG1QAR4HwjAUcbtR0fJHA4tR9+FBqY/Z5OcqyD7PGs88CZq1F8RPRhtQbcyo/hRa
 e6JoXdSdziNvjXRU46Lm+PBpTESy26/h1nhgE8JbvF5JrsehpuvzCJPMUZmkvAAqaS25DmpcONV
 MHp8jMk4DhiLe4QGToscmr/NsayMwqZXdu3FHohchQHpkTcgQzlEhlE0M+fhaOzi+O1cRn/UrUf
 DPlSxS3f8UB8g088SRqwfeDc5vvBhGGlzC4rCyJC0WAXnSJrW/v+dYJdvOyVIbuEmoFV8Ho1sFy
 Y0JTJ8DErBEstfU1F0qGXpXFGxvgQ1KQi
X-Received: by 2002:a05:6000:40c8:b0:473:1ccc:15b9 with SMTP id
 ffacd0b85a97d-4731ccc16dbmr6179811f8f.1.1782727078693; 
 Mon, 29 Jun 2026 02:57:58 -0700 (PDT)
X-Received: by 2002:a05:6000:40c8:b0:473:1ccc:15b9 with SMTP id
 ffacd0b85a97d-4731ccc16dbmr6179769f8f.1.1782727078155; 
 Mon, 29 Jun 2026 02:57:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f8d6f10absm42034529f8f.5.2026.06.29.02.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 02:57:57 -0700 (PDT)
Date: Mon, 29 Jun 2026 05:57:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 2/2] vhost-user-base: clean up vhost_dev on realize failure
Message-ID: <20260629055709-mutt-send-email-mst@kernel.org>
References: <20260629092619.2607275-1-zhaoguohan@kylinos.cn>
 <20260629092619.2607275-2-zhaoguohan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629092619.2607275-2-zhaoguohan@kylinos.cn>
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

On Mon, Jun 29, 2026 at 05:26:19PM +0800, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> vhost-user-base queries the backend shared memory configuration after
> vhost_dev_init() succeeds. If that query fails, or if the shared memory
> configuration fails validation, realization jumps to the error path
> without cleaning up the initialized vhost_dev.
> 
> Track whether vhost_dev_init() succeeded and call vhost_dev_cleanup()
> from the error path in that case. Keep a copy of vhost_dev.vqs so the
> allocation can still be freed after vhost_dev_cleanup() clears struct
> vhost_dev.
> 
> Fixes: 6608dca74ecf (vhost-user-device: Add shared memory BAR)
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>  hw/virtio/vhost-user-base.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 6ac523f9ebef..000e91d50331 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -287,6 +287,8 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VHostUserBase *vub = VHOST_USER_BASE(dev);
>      uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> +    struct vhost_virtqueue *vhost_vqs = NULL;
> +    bool vhost_dev_initialized = false;
>      int i, ret, nregions, regions_processed = 0;
>  
>      if (!vub->chardev.chr) {
> @@ -338,6 +340,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
>  
>      vub->vhost_dev.nvqs = vub->num_vqs;
>      vub->vhost_dev.vqs = g_new0(struct vhost_virtqueue, vub->vhost_dev.nvqs);
> +    vhost_vqs = vub->vhost_dev.vqs;
>  
>      /* connect to backend */
>      ret = vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
> @@ -346,6 +349,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
>      if (ret < 0) {
>          goto err;
>      }
> +    vhost_dev_initialized = true;
>  
>      ret = vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost_dev,
>                                                             &nregions,
> @@ -386,6 +390,10 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
>                               dev, NULL, true);
>      return;
>  err:
> +    if (vhost_dev_initialized) {
> +        vhost_dev_cleanup(&vub->vhost_dev);
> +    }
> +    g_free(vhost_vqs);
>      do_vhost_user_cleanup(vdev, vub);
>  }

Pls just add another label.


> -- 
> 2.43.0


