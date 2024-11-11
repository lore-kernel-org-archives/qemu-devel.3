Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4F1D12D5C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 01:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAJOL-0006Do-1h; Sun, 10 Nov 2024 20:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tAJOJ-0006Da-99
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 20:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tAJOH-0000zX-64
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 20:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731289130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzgEwngfxgr3iUKki2HQVMhWJtN0VqqiYJlZZldaBlw=;
 b=MCFBhjjB6OuS3V6FuEoLcMsn/WgqeL5ko8LX1hCvaphTVJ7eYA3RnI83waQESd9Z74cMUy
 sXUXj9UA6gvT2P/gsKKdIZlk/vPA9JhsqRUo+GPVLorY+wvE0EOxdWdVxfrTQv+QWynHpH
 +sn2pQ4mbGKkw8VKE5ar4wpH4XE6XrY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-tUSSfS_HPOuj1HLJSJWdYQ-1; Sun, 10 Nov 2024 20:38:48 -0500
X-MC-Unique: tUSSfS_HPOuj1HLJSJWdYQ-1
X-Mimecast-MFC-AGG-ID: tUSSfS_HPOuj1HLJSJWdYQ
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e2c07adf0aso3888143a91.3
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 17:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731289127; x=1731893927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HzgEwngfxgr3iUKki2HQVMhWJtN0VqqiYJlZZldaBlw=;
 b=UVVePH4w5NQT79YpO5fAWJp7rrtY6DodlfXt/7eU1Q+XtgA8ztkN10SBMEQ0Jt+21x
 fFVaX205A/4w71F6wQiaZHOJYKnmYzrlWM+xNi7QiCgWcYT/FnQpkKF2fJaiwdjZWHK0
 9+rNHcElP/8YaHdJGf+yQ4EQhOJPBVC8hC2ZkDnZbiUmU3wZpBYT++jIl0LUPqR0IPK0
 VyewrizCZZiijFwghHk7KqorNHF9UdzafG7VNG0O62R92piQo3YbiclZ4KEopJgoGN/d
 gQ6fic95VecGDGwb6FwXRcC10OzGKhRf3vtcunTvZDewPM9zELFLnJR52ZN9eLk/EvQ4
 cskw==
X-Gm-Message-State: AOJu0Yx6e9MG27feNM7FzQfMH4JYmGby3QQLCtCpDVYpGolbR2HVR6NA
 AWT2uaGHlwlhrw2flivIrAPAmUY5FyNxZ+6WHvclw2LbxyBX5wm9SCshJmN13SbmRBEvp+QbD4D
 ytgxY3FaK+SltP6ZZTmWDngQzMekuqWbDXa8FDcTXhuYnwNc1taRdPYy2Ahh1ZLQRTYGiv8dbHo
 zrp/koh+aI8EUwU6Eif8dBcKDXyiA=
X-Received: by 2002:a17:90b:180a:b0:2e2:bb32:73e0 with SMTP id
 98e67ed59e1d1-2e9b171ef7bmr14096420a91.12.1731289127427; 
 Sun, 10 Nov 2024 17:38:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVdRFAfo/PmsqjYGdGPdvb16Z1Fs9gVSAt79x85g5L9lYUOudFiA8hwgfFXtNHG46AXdTZGhrqmIwpEpbX5mk=
X-Received: by 2002:a17:90b:180a:b0:2e2:bb32:73e0 with SMTP id
 98e67ed59e1d1-2e9b171ef7bmr14096397a91.12.1731289126956; Sun, 10 Nov 2024
 17:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20241107113247.46532-1-ppandit@redhat.com>
In-Reply-To: <20241107113247.46532-1-ppandit@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:38:35 +0800
Message-ID: <CACGkMEu+8fWoSSCdHwVYV9UpqN8FS4f0jVRA0x9CiPhNEKrx=g@mail.gmail.com>
Subject: Re: [PATCH v1] vhost: fail device start if iotlb update fails
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 eperezma@redhat.com, mst@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Prasad:

On Thu, Nov 7, 2024 at 7:33=E2=80=AFPM Prasad Pandit <ppandit@redhat.com> w=
rote:
>
> From: Prasad Pandit <pjp@fedoraproject.org>
>
> While starting a vhost device, updating iotlb entries
> via 'vhost_device_iotlb_miss' may return an error.
>
>   qemu-kvm: vhost_device_iotlb_miss:
>     700871,700871: Fail to update device iotlb

Actually, such updating is a workaround for vhost-net kernel to run.

I wonder what kind of issue would we get if we don't do this?

Thanks

>
> Fail device start when such an error occurs.
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  hw/virtio/vhost.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> v1:
>  - Remove VHOST_OPS_DEBUG call.
>  - Call vhost_set_iotlb_callback and vhost_dev_start with 'false' argumen=
t.
>
> v0:
>  - https://lore.kernel.org/qemu-devel/20241105060053.61973-1-ppandit@redh=
at.com/
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 76f9b2aaad..c40f48ac4d 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2095,11 +2095,22 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtI=
ODevice *vdev, bool vrings)
>           * vhost-kernel code requires for this.*/
>          for (i =3D 0; i < hdev->nvqs; ++i) {
>              struct vhost_virtqueue *vq =3D hdev->vqs + i;
> -            vhost_device_iotlb_miss(hdev, vq->used_phys, true);
> +            r =3D vhost_device_iotlb_miss(hdev, vq->used_phys, true);
> +            if (r) {
> +                goto fail_iotlb;
> +            }
>          }
>      }
>      vhost_start_config_intr(hdev);
>      return 0;
> +fail_iotlb:
> +    if (vhost_dev_has_iommu(hdev) &&
> +        hdev->vhost_ops->vhost_set_iotlb_callback) {
> +        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
> +    }
> +    if (hdev->vhost_ops->vhost_dev_start) {
> +        hdev->vhost_ops->vhost_dev_start(hdev, false);
> +    }
>  fail_start:
>      if (vrings) {
>          vhost_dev_set_vring_enable(hdev, false);
> --
> 2.47.0
>


