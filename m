Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFECEC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 15:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wneZN-0004th-0r; Sat, 25 Jul 2026 11:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wneZK-0004tF-3W
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 11:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wneZH-0008He-EN
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 11:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784994337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBIYQyzUG9woJnwzPWcWGy0j/H81GZyytPfOS8D1mY8=;
 b=bNsBCes0+Qh/caSRJM6NEd51WA8Pxkvrvz2wo2/NwrwhvVpXCsZ0Tdd/pkIjjC/ThssdTP
 YE2/m9ilkmeLgzm+B6toG4Bm7/YxuxMzXPNRZN34FMlig5XSucqYwohiQCO6oV31zx+kfL
 zXTVe//215Yb6ABbWjTabW9sO2l2v00=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-pcWYnT_fOrGHTjD8rrtxpQ-1; Sat, 25 Jul 2026 11:45:35 -0400
X-MC-Unique: pcWYnT_fOrGHTjD8rrtxpQ-1
X-Mimecast-MFC-AGG-ID: pcWYnT_fOrGHTjD8rrtxpQ_1784994335
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954dcd6131so13562785e9.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784994334; x=1785599134; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gBIYQyzUG9woJnwzPWcWGy0j/H81GZyytPfOS8D1mY8=;
 b=kFOmcyszHFAsFpCz0/nlQXIviJs/bvHjyLkJlBXrsj7bRNZGl17fLNmEzbCN17Sy2L
 0Go+6R7qrMVbWY3BS0IrnabNFIx6AQ3qOmOxV7UAPC6O1JZXOQldQeiyDEUW+iHpBj/+
 y+CAuNkMkduesXwlUgmpjybbba+6plXxACcOnpQvC9UAnKOmFCwlF1AhFYL6W/OHsZ2W
 +SLArMqf+OtfBhYSs9jx6QIrKWgcrvaRJUBbOQvbHUjCFcDRAdJuwipLfZ7yptZl65Gp
 hhDjo/6pICxU59VAiKBJcijpso2twDZOK8eSOdcKoFD7vOO5x7xGoCHHAwUsVNSDlaDX
 g3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784994334; x=1785599134;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gBIYQyzUG9woJnwzPWcWGy0j/H81GZyytPfOS8D1mY8=;
 b=M43n1LgXv8aNZjaHQFqCAOMVWx2uowyK229sQIPH10Jfa/NWzx7dagbcD0YeWxFdbe
 423Ho/BDBuc9F/PFirtVf/7Jq44cYJWktPQXpoaFTbSBwdlU5LkH9vTrNqtL4QS+L8fj
 eGY6n9jMIlyKD1OoPK3BSNEJWLINSR9omKRHuA3PtszXcTW7mTwvK62F38KkMlZfUJUH
 s9bkghFPtDGYBSO/4aDKSORGQuIXPu529fguAYin5c5AplEk0tvv4mxg2pYsZ7C50V0y
 HGnkhofnMX7jC+Txcl2Cwj3NKMhXGRx80wVbGieUo0kAc3CHiSgitMXRhIWzXvgAlZPG
 RKtA==
X-Gm-Message-State: AOJu0YxrcENbcQJ/3/zuA//+DTxgJIpnpWW1CD/UcqVGBlgt01HPjHqB
 KpBVUEEcA97v1lIGQ8O4h63O3ePgVRlE5ROD/CAys/gORyyFg2XZVm3xy7vju/rlefr311vJQhr
 N1jRfoAJI5YovBRc+PdtepCN2+57bjLD3+mS1rzsMlb+Z4an0zh090C0UsLu8wPWJ
X-Gm-Gg: AR+sD13McKrwd6E8kEyvb2PMmC12XS7AJfNqfDahuLKqDD+1SFMc2SZXVd5o/Lw3qTz
 vPupe30Rf7ntuonqyVUDLjguV0GAdg3vFqBWTGlP5Dz8knIG9YIhTAznylDm/s8TGkPrM24aHgy
 ZsQhRIJ3aZxYvSv6PApy5sNhSzW/0kPk8cweUXcGtxfQFxt1Gc5I+pL7RB2a9Da7YHO76WwuYMd
 enGOegNF8RvLw1wRJ8zK528IRAU+uZCI+XxAhU7pTYMSZvHQL/Hjx0/mn2pJTrDBZvt5YexLWS8
 VYatLHSnorXMIhsG7RbG9cwzHdwNqCi7aXfm/PDjBDP81747SnatOY0orBXS3SmODNaaykpdoXr
 jo/AI+nL8U7dhtiHt5Emo94q/07BaWuY=
X-Received: by 2002:a05:600c:3b27:b0:495:3c6d:f294 with SMTP id
 5b1f17b1804b1-496b5717d1bmr30977335e9.23.1784994334256; 
 Sat, 25 Jul 2026 08:45:34 -0700 (PDT)
X-Received: by 2002:a05:600c:3b27:b0:495:3c6d:f294 with SMTP id
 5b1f17b1804b1-496b5717d1bmr30977065e9.23.1784994333693; 
 Sat, 25 Jul 2026 08:45:33 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b499cc49sm86454365e9.9.2026.07.25.08.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 08:45:32 -0700 (PDT)
Date: Sat, 25 Jul 2026 11:45:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-user-gpu: fix integer overflow in buffer allocation
Message-ID: <20260725114028-mutt-send-email-mst@kernel.org>
References: <20260710134720.2317856-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710134720.2317856-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

On Fri, Jul 10, 2026 at 05:47:19PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> A malicious guest can trigger a heap buffer overflow in the
> vhost-user-gpu backend by sending a VIRTIO_GPU_CMD_RESOURCE_CREATE_2D
> with large width and height values (e.g. 65537x65537). The allocation
> size width * height * 4 silently wraps in uint32_t arithmetic,
> resulting in a much smaller allocation than expected. Subsequent
> VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D writes past the heap buffer.
> 
> The in-tree virtio-gpu device (hw/display/virtio-gpu.c) already handles
> this via calc_image_hostmem() with uint64_t arithmetic and an overflow
> check. Apply the same approach to the vhost-user-gpu contrib backend:
> 
> - Add an overflow check in vugbm_buffer_create() rejecting dimensions
>   where width * height * 4 exceeds UINT32_MAX
> - Promote the size arithmetic to uint64_t in mem_alloc_bo() and
>   udmabuf_get_size()
> - Check the return value of vugbm_buffer_create() in
>   vg_resource_create_2d(), which was previously ignored
> 
> Fixes: CVE-2026-15264
> Reported-by: "Vulnerability Report" <vr@darknavy.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3940
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-gpu/vhost-user-gpu.c |  8 +++++++-
>  contrib/vhost-user-gpu/vugbm.c          | 11 +++++++++--
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
> index bb41758e345..ee9858c397c 100644
> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> @@ -388,7 +388,13 @@ vg_resource_create_2d(VuGpu *g,
>          cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>          return;
>      }
> -    vugbm_buffer_create(&res->buffer, &g->gdev, c2d.width, c2d.height);
> +    if (!vugbm_buffer_create(&res->buffer, &g->gdev, c2d.width, c2d.height)) {
> +        g_critical("%s: buffer creation failed %d %d %d",
> +                   __func__, c2d.resource_id, c2d.width, c2d.height);
> +        g_free(res);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
>      res->image = pixman_image_create_bits(pformat,
>                                            c2d.width,
>                                            c2d.height,
> diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vugbm.c
> index 503d0a4566f..710d5452977 100644
> --- a/contrib/vhost-user-gpu/vugbm.c
> +++ b/contrib/vhost-user-gpu/vugbm.c
> @@ -13,7 +13,7 @@
>  static bool
>  mem_alloc_bo(struct vugbm_buffer *buf)
>  {
> -    buf->mmap = g_malloc(buf->width * buf->height * 4);
> +    buf->mmap = g_malloc((uint64_t)buf->width * buf->height * 4);
>      buf->stride = buf->width * 4;
>      return true;
>  }


I apologise but we are still allocating up to 2Gbytes is that really
sane? Isn't there a limit on these things? Like the size of the screen?

And width * 4 can still wrap around and then will it really behave
correctly?



> @@ -53,7 +53,8 @@ struct udmabuf_create {
>  static size_t
>  udmabuf_get_size(struct vugbm_buffer *buf)
>  {
> -    return ROUND_UP(buf->width * buf->height * 4, qemu_real_host_page_size());
> +    return ROUND_UP((uint64_t)buf->width * buf->height * 4,
> +                    qemu_real_host_page_size());
>  }
>  
>  static bool
> @@ -293,6 +294,12 @@ bool
>  vugbm_buffer_create(struct vugbm_buffer *buffer, struct vugbm_device *dev,
>                      uint32_t width, uint32_t height)
>  {
> +    uint64_t size = (uint64_t)width * height * 4;
> +    if (size > UINT32_MAX) {
> +        g_warning("buffer dimensions too large: %ux%u", width, height);
> +        return false;
> +    }
> +
>      buffer->dev = dev;
>      buffer->width = width;
>      buffer->height = height;
> -- 
> 2.55.0


