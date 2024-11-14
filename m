Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9B8D65C52
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 07:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBTtZ-0002ZD-Bq; Thu, 14 Nov 2024 02:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tBTtX-0002Yn-Ep
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 02:03:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tBTtV-0008WE-Qy
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 02:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731567824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MKjEWIv49YiVUGKgvU9+LPYIHabdsWhHuYx//9i8tOU=;
 b=AtfCjWAjeHTQRyDIU4ti4IEQyCMrUn4nAgI/jgFyPcC1IhbdFzuU/pVFqopjVTtDI5x+2C
 KKv3OuOQMBhZUcDvGA4vz612lgYReFp1T9SLiaXIwjEnZKsQ2ES4B8qYEEzUyMnSyM+PoX
 ZpxiJsdmtBtthdBDbNiTSvlgDRHLKhc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-k0drKLywPvCZJ_sr7fpQ9Q-1; Thu, 14 Nov 2024 01:58:19 -0500
X-MC-Unique: k0drKLywPvCZJ_sr7fpQ9Q-1
X-Mimecast-MFC-AGG-ID: k0drKLywPvCZJ_sr7fpQ9Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315e8e9b1cso1468165e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 22:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731567498; x=1732172298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKjEWIv49YiVUGKgvU9+LPYIHabdsWhHuYx//9i8tOU=;
 b=J2ZUNEPDPkv7WuzEbirWVavnw061FizTBPMrYX2Komlq4XvAOET3t+AbkeibcFpG+r
 dZXCejbx3THE4BOp8/dxo9YmfJFQN1caPk0QY3QxoMfUsAGCo/3ngJVSa8/Q+9j1M4Ot
 Ib+q8nYSCAAJlY8Yvc96iM8Av2jKdC6Sonpgya2i6jhq1DCohDRnNvzp0FelKlZjjFUa
 mo5TOEkQpFvRoHi7XnNZkpJ6+g0RxvOsaeU0S+f78c+3y8oZWHCV2ZePxJ2uunW7vS83
 8I/Weusr24Kfn3wRslfxwkFrVooNaf46WJPkIOxu6D/l5+ZtSfuLiH2xIXlXcLAvlU4z
 O1ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWxb22UWKDCvlI7i6WDLRSdUeIfrvynDUrATVDy7w+WW1Mhn6nSvoW/5xCyrE4JfnZbyxxE5T/nAFt@nongnu.org
X-Gm-Message-State: AOJu0YzNz2OGr5i5CAN221mdo4BE4RkAsUXKZQte/k2GRAzqP8kEaDco
 OskXqWE46YQgQ0jEBtcDg2vfD+bPirMQUebwyLoNeRVfzhzeDunr9drznpk1RDucIuBAe/+aNOX
 +GBAQcn9iJAv8vWO2PXi733LKUzTjmAxTa9s0OhfnGiUDUf67Qfsm
X-Received: by 2002:a05:600c:5101:b0:431:5226:1633 with SMTP id
 5b1f17b1804b1-432d974ad61mr16807015e9.6.1731567497845; 
 Wed, 13 Nov 2024 22:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlwERf0N1TMPc5hDpwZF73W3xu2aNcG0w2fQwMf6MNBRdXWEbiZ+BjiUjN2r7sv5DcmE/CPw==
X-Received: by 2002:a05:600c:5101:b0:431:5226:1633 with SMTP id
 5b1f17b1804b1-432d974ad61mr16806755e9.6.1731567497451; 
 Wed, 13 Nov 2024 22:58:17 -0800 (PST)
Received: from redhat.com ([2.55.171.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da298c97sm12521245e9.40.2024.11.13.22.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 22:58:16 -0800 (PST)
Date: Thu, 14 Nov 2024 01:58:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: eperezma@redhat.com, sgarzare@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [PATCH] vdpa: Support setting vring_base for packed svq
Message-ID: <20241114015754-mutt-send-email-mst@kernel.org>
References: <20241104162124.49867-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104162124.49867-1-sahilcdq@proton.me>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 04, 2024 at 09:51:24PM +0530, Sahil Siddiq wrote:
> Linux commit v5.14-rc1~30^2~8 enabled the vp_vdpa driver to set the
> vq state to the device's initial state. This works differently for
> split and packed vqs.
> 
> With shadow virtqueues enabled, vhost-vdpa sets the vring base using
> the VHOST_SET_VRING_BASE ioctl. The payload (vhost_vring_state)
> differs for split and packed vqs. The implementation in QEMU currently
> uses the payload required for split vqs (i.e., the num field of
> vhost_vring_state is set to 0). The kernel throws EOPNOTSUPP when this
> payload is used with packed vqs.
> 
> This patch sets the num field in the payload appropriately so vhost-vdpa
> (with the vp_vdpa driver) can use packed svqs.
> 
> Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05106.html
> Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat.com
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>

Looks like a feature, not a bugfix to me, so I guess - next release?

> ---
> QEMU currently does not support packed vhost shadow virtqueues. I am
> working on adding support for packed svqs [1]. The test environment
> that I am using [2] requires vhost-vdpa to use the relevant payload
> when setting vring base.
> 
> [1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue
> [2] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-got-hardware-part-2
> 
>  hw/virtio/vhost-vdpa.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12ed5..5f81945109 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1230,6 +1230,10 @@ static bool vhost_vdpa_svq_setup(struct vhost_dev *dev,
>      };
>      int r;
>  
> +    if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
> +        s.num = 0x80008000;
> +    }
> +
>      r = vhost_vdpa_set_dev_vring_base(dev, &s);
>      if (unlikely(r)) {
>          error_setg_errno(errp, -r, "Cannot set vring base");
> -- 
> 2.47.0


