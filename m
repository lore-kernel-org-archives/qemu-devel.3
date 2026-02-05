Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07179E9128C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnuV4-0002hW-Fr; Thu, 05 Feb 2026 03:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnuV2-0002gx-5n
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:14:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnuUz-0003dp-KV
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770279239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pklfpZw5TAHQL53MnvXN+f+tIm2U0o3ItTdoFnjIA4g=;
 b=FBIfMQ8V8O930j0eC8RNcLqF5TDzU8ooBHSLu0GKqJbI/a80X+d/AW3dYm49z7SqzXDnFL
 SZ4dj9vlbWPo/76JPxbX8kBlkbc5BuLYT1l/jl69Y2yXSAIjDfE/C6LyxhIR847hR5hEWH
 AoHjXdLBE//0OudOWTd6qiL2mx/2grM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-9GmqoGiHOpavZoVzBfu--A-1; Thu, 05 Feb 2026 03:13:58 -0500
X-MC-Unique: 9GmqoGiHOpavZoVzBfu--A-1
X-Mimecast-MFC-AGG-ID: 9GmqoGiHOpavZoVzBfu--A_1770279237
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48079ae1001so5071415e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 00:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770279237; x=1770884037; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pklfpZw5TAHQL53MnvXN+f+tIm2U0o3ItTdoFnjIA4g=;
 b=T3vf+kepvIfJxQBqlJJrfpuv1WouavHTN/xItgi5mI9+EbuQvXufgHTl2zlqRb2bCS
 MVcvUgpKZg1OGlRfWlBzW1h/+EWK5+5MU2ZvkD1pv5mUroTrF2SOSD3Xz4V23INZYSL5
 2uziY84hsIcxbFUHadr0KQWrVszGEE1BpsxO5XB3/ni1P6LtBnWlPO0eUhVnDPUm7/qT
 5KBzxTrD2vFrkLSItCYfO21lSba0QS0xcbu5m06uRhJDuXYGLFEVlIDlsYE9pVJHeTAX
 MFt5ia7iRBz9MIHb+8v9ooiFo43ObOVGWlu0kqLOmdvVmClUnYt59014YCQpMVpOBFF0
 ACxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770279237; x=1770884037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pklfpZw5TAHQL53MnvXN+f+tIm2U0o3ItTdoFnjIA4g=;
 b=AfHUjZ99ysUVRNu5vVmsuEjb2ZMyHC1mrYUPRaJJhMDg2cQ60fcktdbGs0pDMT9vou
 dKva1d8hxKmQDkkLWw5nN8ZqlJR5fZYKqJbVE6m+McMB9KMKl6iSFXDjMp/owi3z7u6d
 q7suL5WuLJPLmuYqEbLIqApvY1QiYSACd6HJpOJLTQufh2WBY+JPCGXqwAtgHhfa2pNo
 3jeIl88Kz3Xz4CoFI1a1jHOPF0Zd3jkcezLkQf5euezfsT+vzTb9vOU8i/U4RFlUiRd6
 v8cSkbyg7dTh8EBGKFwPeZsclCYYrf6ZYqtW2nSqf8dMoN8/cWxNLVsXqC9FeHwNXZkg
 fuxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX30A5oVvjLyqjEya6zzUszOI7GrFIMaRCjsa9cpFb1LygjC8pXRXLAyNqOwJCUX0jR51LERet4LbEV@nongnu.org
X-Gm-Message-State: AOJu0YxmyQYIOX1rMT9MVpU8QnEs9CH6APEg4poC0G0AmubAe71dzuzV
 YZcFl5XJn/1+oEva3K1oanXJoQd3AGI3XDhVF4i1RHg+dS6hD2HYlnQpq7yQ/3c0zRUYCrzBbpL
 6IzId+Pal0j8Fxe5p0muFxIT2O3xqSokB40Nuu+HWqWzh851Z4p4Gjfe+
X-Gm-Gg: AZuq6aJ089B/aAU4uO+QkfZjdtvrU0yK6kxZa03+bBGOfCezfI+rqEu12lrQgaH93e9
 RrpTnvtTES+TYQPM1lNCSgPybxMtXCdMi3mkCsKhezsZf3f82GQozjeCI4dwxAZQecJ4az8GQQz
 grSyZ5vEtfQxHE5+EgUEvuELeqbEU1gYhyqI6IU1IiRq80pYbomOXVCOdn9b5kGDPJVCogs1mvL
 cKbwJcnWTJT+sfhu8O9lh6DxlqgXwWPhYvfEba+IlhztYNq/nDKjFAK/nwaQRpIzleOSpmX0o7N
 iy43tiAUvxmFXD4clD3/dEd/yrWR3fG35xvBQsdrebL11I15PEcAqFY1cqbFobDpBUU1mLHIhZP
 qPK/IAfrRxv03uz0jpPqL86qi8krb6eI61g==
X-Received: by 2002:a05:600c:8b0f:b0:482:dbd7:a1c1 with SMTP id
 5b1f17b1804b1-4830e99c380mr71303875e9.34.1770279236995; 
 Thu, 05 Feb 2026 00:13:56 -0800 (PST)
X-Received: by 2002:a05:600c:8b0f:b0:482:dbd7:a1c1 with SMTP id
 5b1f17b1804b1-4830e99c380mr71303625e9.34.1770279236542; 
 Thu, 05 Feb 2026 00:13:56 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436180640f2sm11172237f8f.39.2026.02.05.00.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 00:13:56 -0800 (PST)
Date: Thu, 5 Feb 2026 03:13:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
Subject: Re: [PATCH] vhost-user: pass GPA instead of UVA
Message-ID: <20260205031227-mutt-send-email-mst@kernel.org>
References: <20260204092339.211650-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204092339.211650-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 04, 2026 at 12:23:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Unlike the kernel, vhost-user backend knows nothing about QEMUs
> userspace addresses. We can pass GPA instead and nothing changes.
> 
> The benefit: open the doors for further implementation of local
> migration (live-update) with passing open vhost-releated FDs
> through UNIX domain socket. This way the connection with backend
> kept live and untouched.
> 
> Without this change, we'll have to communicate with backend to
> inform it about UVA addresses change, but better is simply use
> more stable GPA numbers, like it's done for VDPA.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost-user.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 63fa9a1b4b..f379408c95 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -386,6 +386,24 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
>      CharFrontend *chr = u->user->chr;
>      int ret, size = VHOST_USER_HDR_SIZE + msg->hdr.size;
>  
> +    if (msg->hdr.request == VHOST_USER_REM_MEM_REG ||
> +        msg->hdr.request == VHOST_USER_ADD_MEM_REG) {
> +
> +        /*
> +         * In QEMU we pass guest physical addresses to vhost-user server
> +         * instead of QEMUs virtual address. Server have no option to
> +         * distinguesh,

what does this mean? "Servers don't really care"?

> but we get a benefit: guest physical address is
> +         * stable during migration, and we don't have to reset memory
> +         * regions.

curious if PA 0 is valid on some systems (as opposed to VA).


> +         *
> +         * Look also at vhost_user_vq_get_addr(): like in VDPA, we pass
> +         * physical addresses instead of user.
> +         */
> +
> +        msg->payload.mem_reg.region.userspace_addr =
> +            msg->payload.mem_reg.region.guest_phys_addr;
> +    }
> +
>      /*
>       * Some devices, like virtio-scsi, are implemented as a single vhost_dev,
>       * while others, like virtio-net, contain multiple vhost_devs. For
> @@ -3021,6 +3039,17 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
>      return 0;
>  }
>  
> +static int vhost_user_vq_get_addr(struct vhost_dev *dev,
> +                                  struct vhost_vring_addr *addr,
> +                                  struct vhost_virtqueue *vq)
> +{
> +    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
> +    addr->desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
> +    addr->avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
> +    addr->used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
> +    return 0;
> +}
> +
>  const VhostOps user_ops = {
>          .backend_type = VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init = vhost_user_backend_init,
> @@ -3059,4 +3088,5 @@ const VhostOps user_ops = {
>          .vhost_supports_device_state = vhost_user_supports_device_state,
>          .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
>          .vhost_check_device_state = vhost_user_check_device_state,
> +        .vhost_vq_get_addr = vhost_user_vq_get_addr,
>  };
> -- 
> 2.52.0


