Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F1AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 12:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwi7k-0002jN-MO; Tue, 16 Apr 2024 08:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwi7g-0002hd-9I
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwi7e-0003ku-6r
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713271273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpfBvjoCo7IoM4URTtDGJAJLSyfQhTtzp4USQC9F16k=;
 b=MkB67pzOyiCBOM0rvFdOazpauELCHTiLkFzQyZmJP7XZy1X0qZpgcHBxk0cT4BzcdrGJPz
 LMSjHZILJyzpMEgeu57TAv4I+wYpGj1/PjbH5fprh6rjvaL6yx8NyaC70rCZcLIcJBk7SH
 vOJuilUxBzGiehvg516Y/ihyhl9YgNM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-nCrww_7LMD-DDNrdFyhdCg-1; Tue, 16 Apr 2024 08:41:10 -0400
X-MC-Unique: nCrww_7LMD-DDNrdFyhdCg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a51eb0c14c8so193276366b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 05:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713271269; x=1713876069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpfBvjoCo7IoM4URTtDGJAJLSyfQhTtzp4USQC9F16k=;
 b=rkFZETeM2FMMmnBxvYHCwqiKIz1LBYeDtVtICsBZCS21rkBWRpf3i1Ddk12Ll4HlvI
 JPXS6nG51x3amGxTVMHiR5LdIHMD1+Ly0pAxikTJmFMR4g9QPKHDIg7lyD12pOlmB6cc
 7jOpn/5h0d6pJyVV5dCFC2eeBhxSgDOX5eRTbuLIzeA0jKPux2TSb/r3YKu4WFTDF09r
 XrH2zYqkyq+rvJSvnCk+FsXpYZmlJGgX3bDy7EUKa6BG2tytLFcM9zYP02EhV/aUuWl/
 j630a4Wyk/ZAcxD4SyKBbsdRAJZp+dRcVDFUyMgw+VhmltbuXMfnb05XvERV4FlzMWIB
 wkQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQUH+E4k764kPXOUbFGglwfS2ObA3ZD1PMNFIOcahR3oUVQDre0Ot0y8NPplpBY1qqyj6fYjKxgs1YzWrGnJcJsUHtaUU=
X-Gm-Message-State: AOJu0Yw1t4eZstpkd/Qj+nOojWVw2F5SPLaYbOGtuJBeRhYp5kMB/vLa
 ysQtLKZwitC1n23koJLaFIVVGt33ZjjVjDfyelaAlGUPPBDmMr+/LNNRf+rfk3h2uXKNlE+BGyZ
 ki9ZAnLq4lp7uVv+ms6qYyY5aVk4mtr0cdP5Qfc3QYIvvnkPkoUKVdGZfbSdZCqmty+4ANaRKTG
 6KaU78Nz51rlt3V/5KMRVpgjE/zkY=
X-Received: by 2002:a17:906:794e:b0:a4e:904:3c7f with SMTP id
 l14-20020a170906794e00b00a4e09043c7fmr10574494ejo.50.1713271269135; 
 Tue, 16 Apr 2024 05:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEImgMk9xHxEGyUsk6Q3d6GW7JTm0zZEVf/R6qxLEOHu5uIZWq98d+uI+8J0CnlwlZSS/1HG/aGfyad/26FMS0=
X-Received: by 2002:a17:906:794e:b0:a4e:904:3c7f with SMTP id
 l14-20020a170906794e00b00a4e09043c7fmr10574484ejo.50.1713271268808; Tue, 16
 Apr 2024 05:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240416122919.597819-1-lulu@redhat.com>
 <CAFEAcA-PbZd9vjyux_HqDKf9y6PxgBXJ9W21zLheE0hJOrLEFw@mail.gmail.com>
In-Reply-To: <CAFEAcA-PbZd9vjyux_HqDKf9y6PxgBXJ9W21zLheE0hJOrLEFw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Apr 2024 20:40:31 +0800
Message-ID: <CACLfguXs-YkMBZK9cNkuaG9dQzvUDY-znMGQN6JL8VR8ci8yng@mail.gmail.com>
Subject: Re: [PATCH] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

On Tue, Apr 16, 2024 at 8:30=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 16 Apr 2024 at 13:29, Cindy Lu <lulu@redhat.com> wrote:
> >
> > In function kvm_virtio_pci_vector_use_one(), in the undo label,
> > the function will get the vector incorrectly while using
> > VIRTIO_CONFIG_IRQ_IDX
> > To fix this, we remove this label and simplify the failure process
> >
> > Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 19 +++----------------
> >  1 file changed, 3 insertions(+), 16 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index b138fa127a..565bdb0897 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -892,7 +892,7 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIP=
roxy *proxy, int queue_no)
> >      }
> >      ret =3D kvm_virtio_pci_vq_vector_use(proxy, vector);
> >      if (ret < 0) {
> > -        goto undo;
> > +        return ret;
> >      }
> >      /*
> >       * If guest supports masking, set up irqfd now.
> > @@ -902,25 +902,12 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPC=
IProxy *proxy, int queue_no)
> >          ret =3D kvm_virtio_pci_irqfd_use(proxy, n, vector);
> >          if (ret < 0) {
> >              kvm_virtio_pci_vq_vector_release(proxy, vector);
> > -            goto undo;
> > +            kvm_virtio_pci_irqfd_release(proxy, n, vector);
>
> Are you sure this is right? The kvm_virtio_pci_irqfd_use()
> just failed, so why do we need to call
> kvm_virtio_pci_irqfd_release() ?
>
> thanks
> -- PMM
>
This version should be correct.  when kvm_virtio_pci_irqfd_use() fail
we need to call kvm_virtio_pci_vq_vector_release() and
kvm_virtio_pci_irqfd_release()
but for kvm_virtio_pci_vq_vector_use fail we can simple return,

in old version there is a error in failure process.
while the kvm_virtio_pci_vq_vector_use fail it  call the
kvm_virtio_pci_irqfd_release,but at this time this is irqfd
is not using now

I have do the qtest and sanity test for this patch
Thanks
cindy


