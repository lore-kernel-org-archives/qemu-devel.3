Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92970C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiJu-0001VB-1Q; Mon, 08 Apr 2024 02:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtiJp-0001Ts-4f
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtiJn-0007Gu-Lc
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712557042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0lxsNjSGhFz9tWr4TeYcevlJ+IcLoxBbAFcL8ZPP2k4=;
 b=cWzWdI3+Y1zrHIIrJgXEN7pd0bOpqu1W5OUKJRaHIEND4plGwaHcOn07e8wR2BsuIwqfBw
 DvfirSopY7/2cYdOkxOISuftwyeZT0q8GyvxjK/KzJPxKCCwv5veGVZXzx0K0B90n+y9+i
 t4eD+yosxaQjIqRAt5X3zhu1Bn4JbDs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-m4bJGJlNNfyJyIXdSVIEuw-1; Mon, 08 Apr 2024 02:17:20 -0400
X-MC-Unique: m4bJGJlNNfyJyIXdSVIEuw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a517457163so538478a91.3
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712557039; x=1713161839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lxsNjSGhFz9tWr4TeYcevlJ+IcLoxBbAFcL8ZPP2k4=;
 b=tX4m+ckxIAjog8LPl8roKNMAIO5nUSbBTfWKF0OvzocvrG6zQqTSpXwhQJahZZBhkM
 L6YGOICVS2V2ihbRvb9JoInOB/XBgVSJbf3sKzFCiculjIr7QSweHYgh8MHNLspD+8B0
 lGKS+V3qpvSY4nuBXOCvQDvXLudl1eN5fJqu7DTqNL+rNFhZHGcpbZZCLmuSWFk29eTt
 4ud5zfljDZdvYjlMkWkZ/SKxk3emV93Y8SChrx7/hLXhpS/F+ZAAWPuv8nqkROv9+1Vx
 S0RFUDwBajrfhdp5nc2otsSy39VsLi09fKcCaT5oKTcrSBlSQtUHDPCksFaClLCihDyt
 aZfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWDksJ5cejW/b/uMQrND9KmHKWmvzHD1ZKNBMWnruPtZVH5BtW6sjbNM5JAiTSeES9VWbU8EU5r9xq1utpVpZAUjXiIX4=
X-Gm-Message-State: AOJu0YwAH5cixLqQkFe732bvDeftm+iRv3J7dX+7XynqeXfrwIQD6iKQ
 Gpp3FGNLRJdMtpEqow6/I/9zfCnfw7L2d/vAI8XsfK4gs4BWInS9OSSTOfgap+6uJshEmDTDtaD
 1NIZIsjZv9xrBIH1o76Wt/u6hJR4BNrd3173LHrnhLDKL9ec5eJLPRUJetf4UPISTXd+NIhqxTx
 DjJGfUdX2e1rARAFL0Tj4rc6dGaAo=
X-Received: by 2002:a17:90a:6883:b0:2a2:2654:9e95 with SMTP id
 a3-20020a17090a688300b002a226549e95mr6235344pjd.36.1712557039485; 
 Sun, 07 Apr 2024 23:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm55NaceoMljxe2MfFZbtbLQt+0GRKkozo5LUpWsvKFIRmjEown+k6+Za+I1WawMc+3K0ElCXU9D+pf1Tr4Tw=
X-Received: by 2002:a17:90a:6883:b0:2a2:2654:9e95 with SMTP id
 a3-20020a17090a688300b002a226549e95mr6235332pjd.36.1712557039133; Sun, 07 Apr
 2024 23:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240408060842.2012-1-yuxue.liu@jaguarmicro.com>
In-Reply-To: <20240408060842.2012-1-yuxue.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 14:17:07 +0800
Message-ID: <CACGkMEsrT4xxW-KzLm=rTqXf0P+u2=0fy03z3EsHZFEqQePjJg@mail.gmail.com>
Subject: Re: [PATCH] vhost: don't set vring call if no enabled msix
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: mst@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 8, 2024 at 2:09=E2=80=AFPM lyx634449800 <yuxue.liu@jaguarmicro.=
com> wrote:
>
> When conducting performance testing using testpmd in the guest os,
> it was observed that the performance was lower compared to the
> scenario of direct vfio-pci usage.
>
> In the virtual machine operating system, even if the virtio device
> does not use msix interrupts, vhost still sets vring call fd. This
> leads to unnecessary performance overhead. If the guest driver does
> not enable msix capability (e.g virtio-net pmd), we should also
> check and clear the vring call fd.
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>

Patch looks good, I would like to do the following tweaks:

1) explain what is not enough since commit:

commit 96a3d98d2cdbd897ff5ab33427aa4cfb94077665
Author: Jason Wang <jasowang@redhat.com>
Date:   Mon Aug 1 16:07:58 2016 +0800

    vhost: don't set vring call if no vector

2) tweak the title to "vhost: don't set vring call if guest notifiers
is not enabled" as it's not necessarily pci but also ccw.

Thanks

> ---
>  hw/virtio/vhost.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index f50180e60e..b972c84e67 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1266,13 +1266,15 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          vhost_virtqueue_mask(dev, vdev, idx, false);
>      }
>
> -    if (k->query_guest_notifiers &&
> -        k->query_guest_notifiers(qbus->parent) &&
> -        virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR) {
> -        file.fd =3D -1;
> -        r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
> -        if (r) {
> -            goto fail_vector;
> +    if (k->query_guest_notifiers) {
> +        if (!k->query_guest_notifiers(qbus->parent) ||
> +            (k->query_guest_notifiers(qbus->parent) &&
> +            virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR)) {
> +            file.fd =3D -1;
> +            r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
> +            if (r) {
> +                goto fail_vector;
> +            }
>          }
>      }
>
> --
> 2.43.0
>


