Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3488BC3A59D
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 04:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtK0w-000117-Qy; Sun, 07 Apr 2024 00:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtK0u-00010g-GV
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 00:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtK0s-0003P5-IX
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 00:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712463613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwcKKPnkneUZTJOiWwOouMOiA//SXIdaTi6Dk+EY5po=;
 b=Y2d+pmEwNFu2MB5wL193Asy+5BsLNN+HqqVVun4dFms+wXBTmFniGHKf1m3L+8HW0TZ1Cx
 6ZVHCGDFQsIg7mhP4srjDoMcxPD3om80KBuEKyuxLz1HQWqesTfpAK8xh+H4w7VmEBFiQ1
 fLSwUdk3Thwo/wRsv6dIYv+fwTZ9gLw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-dCUemFgGPX2NkumSZ0io7A-1; Sun, 07 Apr 2024 00:20:09 -0400
X-MC-Unique: dCUemFgGPX2NkumSZ0io7A-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29bf071cc04so3188646a91.0
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 21:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712463609; x=1713068409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwcKKPnkneUZTJOiWwOouMOiA//SXIdaTi6Dk+EY5po=;
 b=YD3mvtyOYQ2k+mIC/sFiL1QOdyZkrinPP1iA0waWvF3a7WtVzRirPYGvJjBMNA7M3e
 1zVuJUDkSOJ9tfIKmB83ijg0u75pmGmy/e5SWI/r3tZmAySREvVIWv1uK8Y9BPZkl0iV
 5w/AjwPxbknRZfQWyDGfR7J3U3g6gHb2qomGV1R+2dyxotE8mxbT+vYIJvXcv2rvid1Q
 UQfmnDW/gDl63is5A3P6yoq0SazSDUmuRO3yMWOknsrj0DQGg8Eqq1gN+IaI5Dylr9gU
 WQMuIv2GckSqYjvzxnxBjWB9/5TwZZ72Jn4UmuO00Us8LN12yQRY0vHtaXZ2O6t7LDWm
 aVpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVjKdBL1rrcqWrjj3Z/G11c3dOlbXkt+eFxyR71xBog/CdrbUWMcpKpRbc7mKa2yST3sXdz6437PrEFX7V3Rtf9kIWsIM=
X-Gm-Message-State: AOJu0YwZs9U6bkZOmMFZYdc+y1q6V8ctKU9zVuqqTHym/RukSIoZMUAD
 /3rnGubWmVCMP5ZaE6tpym83VFltNdxmPUZhtB74j/TdRSKmFoWFNrI9bgd6QyY2anYjZ7EReZV
 oKTD1u+UCtvuoGgOmPXTq3itaFSiR+bW4nvM8RCmaX78BGW3E/gmwdoLGJYCX7WrW4yo8VcNA5J
 i442D4+TA2EDheFTxcWpbXdVwvBgw=
X-Received: by 2002:a17:903:2351:b0:1e2:6b8d:cdd8 with SMTP id
 c17-20020a170903235100b001e26b8dcdd8mr6231572plh.37.1712463608894; 
 Sat, 06 Apr 2024 21:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoifhaLcCHNlO4LC3eWONQMUCoOXi7XNZ4WGBcobtPlb4hvMYJpQQ8NEJkrkyZGCUd8wt48e4H3ZHM181HwpA=
X-Received: by 2002:a17:903:2351:b0:1e2:6b8d:cdd8 with SMTP id
 c17-20020a170903235100b001e26b8dcdd8mr6231560plh.37.1712463608592; Sat, 06
 Apr 2024 21:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240402150218.270587-1-lulu@redhat.com>
 <20240402150218.270587-2-lulu@redhat.com>
In-Reply-To: <20240402150218.270587-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 7 Apr 2024 12:19:57 +0800
Message-ID: <CACGkMEuQc+e+JOnScUdJckP1yb1Ushu9E0VEQKhwdn26W422bw@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-pci: Fix the crash when the vector changes
 back from VIRTIO_NO_VECTOR
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 2, 2024 at 11:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> When the guest calls virtio_stop and then virtio_reset,

Guests could not call those functions directly, it is triggered by for
example writing to some of the registers like reset or others.

> the vector will change
> to VIRTIO_NO_VECTOR and the IRQFD for this vector will be released. After=
 that
> If you want to change the vector back,

What do you mean by "change the vector back"? Something like

assign VIRTIO_MSI_NO_VECTOR to vector 0
assign X to vector 0

And I guess what you meant is to configure the vector after DRIVER_OK.


> it will cause a crash.
>
> To fix this, we need to call the function "kvm_virtio_pci_vector_use_one(=
)"
> when the vector changes back from VIRTIO_NO_VECTOR
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index e433879542..45f3ab38c3 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -874,12 +874,14 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy *=
proxy, int queue_no,
>      return 0;
>  }
>
> -static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queu=
e_no)
> +static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queu=
e_no,
> +                                         bool recovery)
>  {
>      unsigned int vector;
>      int ret;
>      EventNotifier *n;
>      PCIDevice *dev =3D &proxy->pci_dev;
> +    VirtIOIRQFD *irqfd;
>      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
>      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>
> @@ -890,10 +892,21 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIP=
roxy *proxy, int queue_no)
>      if (vector >=3D msix_nr_vectors_allocated(dev)) {
>          return 0;
>      }
> +    /*
> +     * if this is recovery and irqfd still in use, means the irqfd was n=
ot
> +     * release before and don't need to set up again
> +     */
> +    if (recovery) {
> +        irqfd =3D &proxy->vector_irqfd[vector];
> +        if (irqfd->users !=3D 0) {
> +            return 0;
> +        }
> +    }
>      ret =3D kvm_virtio_pci_vq_vector_use(proxy, vector);
>      if (ret < 0) {
>          goto undo;
>      }
> +
>      /*
>       * If guest supports masking, set up irqfd now.
>       * Otherwise, delay until unmasked in the frontend.
> @@ -932,14 +945,14 @@ static int kvm_virtio_pci_vector_vq_use(VirtIOPCIPr=
oxy *proxy, int nvqs)
>          if (!virtio_queue_get_num(vdev, queue_no)) {
>              return -1;
>          }
> -        ret =3D kvm_virtio_pci_vector_use_one(proxy, queue_no);
> +        ret =3D kvm_virtio_pci_vector_use_one(proxy, queue_no, false);
>      }
>      return ret;
>  }
>
>  static int kvm_virtio_pci_vector_config_use(VirtIOPCIProxy *proxy)
>  {
> -    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX);
> +    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX, f=
alse);
>  }
>
>  static void kvm_virtio_pci_vector_release_one(VirtIOPCIProxy *proxy,
> @@ -1570,7 +1583,13 @@ static void virtio_pci_common_write(void *opaque, =
hwaddr addr,
>          } else {
>              val =3D VIRTIO_NO_VECTOR;
>          }
> +        vector =3D vdev->config_vector;
>          vdev->config_vector =3D val;
> +        /*check if the vector need to recovery*/
> +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_VECT=
OR) &&
> +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +            kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX, =
true);
> +        }

This looks too tricky.

Think hard of this. I think it's better to split this into two parts:

1) a series that disables config irqfd for vhost-net, this series
needs to be backported to -stable which needs to be conservative. It
looks more like your V1, but let's add a boolean for pci proxy.
2) a series that deal with the msix vector configuration after
driver_ok, we probably need some refactoring to do per vq use instead
of the current loop in DRIVER_OK

Does this make sense?

Thanks

>          break;
>      case VIRTIO_PCI_COMMON_STATUS:
>          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> @@ -1611,6 +1630,12 @@ static void virtio_pci_common_write(void *opaque, =
hwaddr addr,
>              val =3D VIRTIO_NO_VECTOR;
>          }
>          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> +
> +        /*check if the vector need to recovery*/
> +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_VECT=
OR) &&
> +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +            kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel, true);
> +        }
>          break;
>      case VIRTIO_PCI_COMMON_Q_ENABLE:
>          if (val =3D=3D 1) {
> --
> 2.43.0
>


