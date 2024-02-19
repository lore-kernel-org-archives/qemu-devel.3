Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7522C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 09:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc0DP-0003HX-1T; Mon, 19 Feb 2024 04:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rc0DB-0003Gd-Nu
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rc0D9-00077O-BA
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708335918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7MDE8v1hXqpa/rufBEyf2sVdKd1bwrORrNs9PyZ5WGc=;
 b=c61FIUxW5cI1g/mYVJEGgTUkNyYUpRlE6MsmqlqQZOzftpNE0Bqw0p4ka68Lqa50XIfq5o
 xPF8jZ9vHjpybmjs/itjPKYcLBlSB98pFsRXy66w8ouMhW3mXxEWXUjhf/CeiRYyhSzFxh
 fNdiI68S32yNYSxPEUwuc7CmfCF4lZk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-uxdj0GRwNiauEkehSdTzsQ-1; Mon, 19 Feb 2024 04:45:16 -0500
X-MC-Unique: uxdj0GRwNiauEkehSdTzsQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-410727c32bdso20418775e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 01:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708335915; x=1708940715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MDE8v1hXqpa/rufBEyf2sVdKd1bwrORrNs9PyZ5WGc=;
 b=U01jtnuZioeMS8a+UpvrSO3f5drdm4ohXqBHgiP9umuej5+5uy1x1cZzS0ckNpWac4
 b5e7YHmUoTJ/U0wRrAemQ6hgaHOSHigLlXtn8TYuy+G4SYIXdr8+XlOMJuYVslnS3X2P
 ALl8hyKLKK+48h56KypQvSw4MZXuBCDpOTkW3QjhDP/r0L/Ewc6Qr1GuNXuEnSSm9bbe
 KeMWhoZ60xZSdv20hgBWsBvfyE48tE+Ye3jnc4LoAOq8/peHtLHk+PaTsF5aMFUiu5fp
 nMQsHLgd6XxOlQ8P3E4JunuKmGQIYOW17IWYZ4hSz0jkHVPOf0LWr76CYEfFNX9t/B8c
 HYyg==
X-Gm-Message-State: AOJu0YyCN5fFUUm4nE2MsIplZvEsF4ZNMa6HfzwIyDgVYm5/7OYf1n/v
 Y6vprQu3GX1lhS1SG8wgzyRpjq9dsPbPOnOggOuVFM8oxkplz74KiGyfdvBnYHceCvzlQfZTgSv
 FIE4tJLivfFMRXC5mwRZSnoe/FWkZTEO+GNqgTAggFaupOK20hoKB
X-Received: by 2002:a05:600c:1f89:b0:410:656c:d6d with SMTP id
 je9-20020a05600c1f8900b00410656c0d6dmr8743390wmb.18.1708335915102; 
 Mon, 19 Feb 2024 01:45:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGpL1HuiBQK5RoszyGR7Iyf+EDEvAfcxCPS5+QnDOiIW2/AYU9g6DEnF+tmz+hHxuifcPtgw==
X-Received: by 2002:a05:600c:1f89:b0:410:656c:d6d with SMTP id
 je9-20020a05600c1f8900b00410656c0d6dmr8743380wmb.18.1708335914811; 
 Mon, 19 Feb 2024 01:45:14 -0800 (PST)
Received: from redhat.com ([2.52.19.211]) by smtp.gmail.com with ESMTPSA id
 n6-20020a05600c3b8600b004126a6ee498sm258168wms.12.2024.02.19.01.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 01:45:13 -0800 (PST)
Date: Mon, 19 Feb 2024 04:45:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: qemu-devel@nongnu.org, vattunuru@marvell.com, jerinj@marvell.com,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER feature
 bits to vdpa_feature_bits
Message-ID: <20240219044352-mutt-send-email-mst@kernel.org>
References: <20240102111432.36817-1-schalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102111432.36817-1-schalla@marvell.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 02, 2024 at 04:44:32PM +0530, Srujana Challa wrote:
> Enables VIRTIO_F_NOTIFICATION_DATA and VIRTIO_F_IN_ORDER feature bits
> for vhost vdpa backend. Also adds code to consider all feature bits
> supported by vhost net client type for feature negotiation, so that
> vhost backend device supported features can be negotiated with guest.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
>  hw/net/vhost_net.c | 10 ++++++++++
>  net/vhost-vdpa.c   |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e8e1661646..65ae8bcece 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -117,6 +117,16 @@ static const int *vhost_net_get_feature_bits(struct vhost_net *net)
>  
>  uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
>  {
> +    const int *bit = vhost_net_get_feature_bits(net);
> +
> +    /*
> +     * Consider all feature bits for feature negotiation with vhost backend,
> +     * so that all backend device supported features can be negotiated.
> +     */
> +    while (*bit != VHOST_INVALID_FEATURE_BIT) {
> +        features |= (1ULL << *bit);
> +        bit++;
> +    }
>      return vhost_get_features(&net->dev, vhost_net_get_feature_bits(net),
>              features);
>  }

I don't think we should do this part. With vdpa QEMU is in control of
which features are exposed and that is intentional since features are
often tied to other behaviour.

> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 3726ee5d67..51334fcfe2 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -57,7 +57,9 @@ typedef struct VhostVDPAState {
>   */
>  const int vdpa_feature_bits[] = {
>      VIRTIO_F_ANY_LAYOUT,
> +    VIRTIO_F_IN_ORDER,
>      VIRTIO_F_IOMMU_PLATFORM,
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VIRTIO_F_NOTIFY_ON_EMPTY,
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_RING_RESET,
> -- 
> 2.25.1


