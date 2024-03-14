Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA21C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 03:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkbi9-000374-Ea; Wed, 13 Mar 2024 23:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkbi7-000362-Gh
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkbi5-0005Rs-Vh
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710386688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8l6GDiQ30I+perZVPKckMJTL3NiBCH47KmE/HyWeOhg=;
 b=FYX/z4v7YUbKa9pfM6bxTANhS7tvyj43RXwT2IrQIJ0v5fRbNd9yr2D8ORNkqZ5gzYHQgS
 0Yq1HNPgN9tqc8Ys4OjOQYkoxQlcHJg4gs9/RoTNHPGC/KCZZVuyNR6HRqgOwGhMdQlGn9
 wPy+yQDVW/gwQGxxSzSPaz43FFtFyOg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-7VEor4CsOh2b3_K_g8zbGw-1; Wed, 13 Mar 2024 23:24:46 -0400
X-MC-Unique: 7VEor4CsOh2b3_K_g8zbGw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-299c5a61099so481818a91.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 20:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710386685; x=1710991485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8l6GDiQ30I+perZVPKckMJTL3NiBCH47KmE/HyWeOhg=;
 b=hz8OP9NSh/oBtyemhrOwAHBy9ZJ2SHZbil+ra1jVQwokEHNsjptUBleGkKQs5rvgYK
 k1gVq93b9ySDLzlQAhWwC+8aUX+kEU9iWT6YEn4FpBxTbNVe3brAXfn2BmIsFIB/A5js
 iuzdFwH6p72QXJo2VixoGAsOn9sdFUcnQF0TUbWw+vHefFxVJqfUj83b7MbHYZH6zvVn
 khUpGrLNiLjbzZDZFqH/Zg7wSv8y7rz/SKt+C0bwZpgYaOD2sI4uGf2k2awshUSXyjjK
 STpPVPQuYJFF7vF+w73M0K42sJPo/+cVgnfjDLeN0hGkF0Qdp1WwcKjbI7ICaTn7b7We
 +J3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX383xy1zGecFvNvd6OM4lPpV2rMwkWgvkDghghJKRj3qZU4BZvwJAMPDvkBT0UMfBVzHVbXXI8Xgxr44z+52qexpZ+lNw=
X-Gm-Message-State: AOJu0YyOb2Wt5pKCv8P9yqyX3cxXVMYMq9lBa0oUzoSrn2hktqVVjbLl
 7yf3hv+J4mcyIX7te3vVEEW7uRBHzdXxYxfUjgrRUGAdvHxKusAiSxvxqDlN6oZmzeeLI0JWNCd
 xp8WY7f0tQ7/ipZ3+rGGQ18tYlUtfyEZLmgYetygr/ZyLPcWSGLMGdT9vOhwiUzm1ItDO93sYaF
 CKVs2zgGEK3IA9Eh4/Jc/IP80ZAp4=
X-Received: by 2002:a05:6a21:78a7:b0:1a3:260a:aad5 with SMTP id
 bf39-20020a056a2178a700b001a3260aaad5mr1008326pzc.3.1710386685221; 
 Wed, 13 Mar 2024 20:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu3BBVHW7Zcct6ivl/fXRSf/vLfnJaXljhkMkmh5iNRTdDb4rh4obSXYHIhpQ2Oc0IMsU4AosXeInqRXCdAAU=
X-Received: by 2002:a05:6a21:78a7:b0:1a3:260a:aad5 with SMTP id
 bf39-20020a056a2178a700b001a3260aaad5mr1008313pzc.3.1710386684925; Wed, 13
 Mar 2024 20:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240221073802.2888022-1-chenh@yusur.tech>
 <d9e4f3b4-9c2e-466c-b5f4-3387ce88c6b9@t-8ch.de>
 <20240313155136-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240313155136-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Mar 2024 11:24:33 +0800
Message-ID: <CACGkMEtSSb-9PsmQKPA4i-UWVJJ4ZVog8rt+1PKoqE+ABhpRTA@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio: Add support for VDPA network simulation devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
 Hao Chen <chenh@yusur.tech>, qemu-devel@nongnu.org, cohuck@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 14, 2024 at 3:52=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Mar 13, 2024 at 07:51:08PM +0100, Thomas Wei=C3=9Fschuh wrote:
> > On 2024-02-21 15:38:02+0800, Hao Chen wrote:
> > > This patch adds support for VDPA network simulation devices.
> > > The device is developed based on virtio-net and tap backend,
> > > and supports hardware live migration function.
> > >
> > > For more details, please refer to "docs/system/devices/vdpa-net.rst"
> > >
> > > Signed-off-by: Hao Chen <chenh@yusur.tech>
> > > ---
> > >  MAINTAINERS                                 |   5 +
> > >  docs/system/device-emulation.rst            |   1 +
> > >  docs/system/devices/vdpa-net.rst            | 121 +++++++++++++
> > >  hw/net/virtio-net.c                         |  16 ++
> > >  hw/virtio/virtio-pci.c                      | 189 ++++++++++++++++++=
+-

I think those modifications should belong to a separate file as it
might conflict with virito features in the future.

> > >  hw/virtio/virtio.c                          |  39 ++++
> > >  include/hw/virtio/virtio-pci.h              |   5 +
> > >  include/hw/virtio/virtio.h                  |  19 ++
> > >  include/standard-headers/linux/virtio_pci.h |   7 +
> > >  9 files changed, 399 insertions(+), 3 deletions(-)
> > >  create mode 100644 docs/system/devices/vdpa-net.rst
> >
> > [..]
> >
> > > diff --git a/include/standard-headers/linux/virtio_pci.h b/include/st=
andard-headers/linux/virtio_pci.h
> > > index b7fdfd0668..fb5391cef6 100644
> > > --- a/include/standard-headers/linux/virtio_pci.h
> > > +++ b/include/standard-headers/linux/virtio_pci.h
> > > @@ -216,6 +216,13 @@ struct virtio_pci_cfg_cap {
> > >  #define VIRTIO_PCI_COMMON_Q_NDATA  56
> > >  #define VIRTIO_PCI_COMMON_Q_RESET  58
> > >
> > > +#define LM_LOGGING_CTRL                 0
> > > +#define LM_BASE_ADDR_LOW                4
> > > +#define LM_BASE_ADDR_HIGH               8
> > > +#define LM_END_ADDR_LOW                 12
> > > +#define LM_END_ADDR_HIGH                16
> > > +#define LM_VRING_STATE_OFFSET           0x20
> >
> > These changes are not in upstream Linux and will be undone by
> > ./scripts/update-linux-headers.sh.
> >
> > Are they intentionally in this header?
>
>
> Good point. Pls move.

Right and this part, it's not a part of standard virtio.

Thanks

>
> > > +
> > >  #endif /* VIRTIO_PCI_NO_MODERN */
> > >
> > >  #endif
>


