Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5D6C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 02:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDxsd-0000zj-0o; Sun, 02 Jun 2024 22:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sDxsa-0000te-GC
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 22:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sDxZf-0004vx-9o
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 22:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717382244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXkJ6a26FL9O4rW4Q4H2yTH0zpT7k29h5h7l+WbSVAY=;
 b=J9T+dGMQytCcKCiFhO/PtlwVkH9li3bvGeFq8SQgA3ai0Awg/9znlAEfl36ukhtCTJBZSK
 jbhBw9eu37HHzag8e/GEcy/qZI45GIJFHPeqtPgYhJV7tIOrKXocIvbcxqVgmCQoR0m+sX
 VZa9fb/O6p3ld2vbIdwNjGK1Hmj5e0Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-a-qohe0NNniZcPALz-fhKQ-1; Sun, 02 Jun 2024 22:37:23 -0400
X-MC-Unique: a-qohe0NNniZcPALz-fhKQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35e4b4e0260so1116513f8f.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 19:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717382242; x=1717987042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXkJ6a26FL9O4rW4Q4H2yTH0zpT7k29h5h7l+WbSVAY=;
 b=tMIg9M2Cq3GIyUHbUOsBkf6mNrXWrblTyQ9xbUvR3SpO2u3mFb1DTmZwW/igQ+V4V1
 fiAFpxSURNHhB1/mqWT7bq9tuJlNVJqUWEtzzfJ+H0PMt4yEyg7TSBEZC3C7kLTgKuJQ
 C+GQSc1gzOfNwJYQOV9dgeILoZ3cGQlzHvXFaJ/VKj48LQ0i5NrN7nQXOSesyYibiLiL
 NOqhaDeJ3Q/v6u96KucbkAuZmLY75PgiMVGgkC3S4IvGnGrjOulqQQIvQkTTS4XWIzaD
 CkyDUl+3U7dSP770e/Y+AiVyAUJvAhnUOjC0k1oeC6f5Zz1uD3FT/SeUs/aO1yuxXM7L
 Cu/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGStstEh6QMQTY1QC2vOrJOkqjIj7FCYGxVybR9en2SblDUDgIkOEvaoh/ujiff4abq13JVqE2k+et9bZwODIgHhOlY5w=
X-Gm-Message-State: AOJu0YwAcTh5xMBWXYGYWG7dgdldBKVSsLahYqS02a/dLKJZq/u+1BI7
 9nqnZqAh+2LBBU0ZHXeZFDbcVv/89E3FIwiTcLV492hvvtY3c8paRBH6uYYG0Io1hhG1PsrVWHW
 qUGHfNIrCU0eRsnPkL3zZsBhr6mQKSeLebPCAGjwdOh22Pq9p5VqBEt8E8FULUgVEBGdpVNEq7S
 TaZDcbPS8dRUy0IJn5nAGroAike5M=
X-Received: by 2002:adf:fe4b:0:b0:354:f218:9661 with SMTP id
 ffacd0b85a97d-35e0f254fe4mr6322304f8f.14.1717382242098; 
 Sun, 02 Jun 2024 19:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoY1lDzfIiUZzi4NfH3m/2/nDfxj0KQygOIQT2F+ssNMGp159CKiFHJyT/PfA62LzFn6dFSAH5D/K/ibNxHoQ=
X-Received: by 2002:adf:fe4b:0:b0:354:f218:9661 with SMTP id
 ffacd0b85a97d-35e0f254fe4mr6322295f8f.14.1717382241670; Sun, 02 Jun 2024
 19:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240522051042.985825-1-lulu@redhat.com>
 <954a3d28-839a-4e62-b843-51d67f818396@proxmox.com>
In-Reply-To: <954a3d28-839a-4e62-b843-51d67f818396@proxmox.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 3 Jun 2024 10:36:43 +0800
Message-ID: <CACLfguXrW-Fvjj83g5u6sT5YMdg3tHeagihNaBVLk03iVokEFg@mail.gmail.com>
Subject: Re: [PATCH] virtio-pci: Fix the use of an uninitialized irqfd.
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 29, 2024 at 9:54=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Hi,
>
> Am 22.05.24 um 07:10 schrieb Cindy Lu:
> > The crash was reported in MAC OS and NixOS, here is the link for this b=
ug
> > https://gitlab.com/qemu-project/qemu/-/issues/2334
> > https://gitlab.com/qemu-project/qemu/-/issues/2321
> >
> > The root cause is that the function virtio_pci_set_guest_notifiers() on=
ly
> > initializes the irqfd when the use_guest_notifier_mask and guest_notifi=
er_mask
> > are set.
>
> Sorry, I'm just trying to understand the fix and I'm probably missing
> something, but in virtio_pci_set_guest_notifiers() there is:
>
> >     bool with_irqfd =3D msix_enabled(&proxy->pci_dev) &&
> >         kvm_msi_via_irqfd_enabled();
>
> and then:
>
> >     if ((with_irqfd ||
> >          (vdev->use_guest_notifier_mask && k->guest_notifier_mask)) &&
> >         assign) {
> >         if (with_irqfd) {
> >             proxy->vector_irqfd =3D
> >                 g_malloc0(sizeof(*proxy->vector_irqfd) *
> >                           msix_nr_vectors_allocated(&proxy->pci_dev));
> >             r =3D kvm_virtio_pci_vector_vq_use(proxy, nvqs);
>
> Meaning proxy->vector_irqfd is allocated when with_irqfd is true (even
> if vdev->use_guest_notifier_mask && k->guest_notifier_mask is false).
>
> > However, this check is missing in virtio_pci_set_vector().
> > So the fix is to add this check.
> >
> > This fix is verified in vyatta,MacOS,NixOS,fedora system.
> >
> > The bt tree for this bug is:
> > Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> > kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c=
:817
> > 817       if (irqfd->users =3D=3D 0) {
>
> The crash happens because the irqfd is NULL/invalid here, right?
>
> proxy->vector_irqfd =3D NULL happens when virtio_pci_set_guest_notifiers(=
)
> is called with assign=3Dfalse or for an unsuccessful call to
> virtio_pci_set_guest_notifiers() with assign=3Dtrue.
>
> AFAIU, the issue is that virtio_pci_set_vector() is called between a
> call to virtio_pci_set_guest_notifiers() with assign=3Dfalse and a
> successful virtio_pci_set_guest_notifiers() with assign=3Dtrue (or before
> the first such call).
>
> So I'm trying to understand why adding the check for
> vdev->use_guest_notifier_mask && k->guest_notifier_mask is sufficient to
> fix the issue. Thanks!
>
> Best Regards,
> Fiona
>
Thanks, Fiona. You are correct. I have rechecked the call trace, and
it seems that the virtio_pci_set_guest_notifiers was not called at all
for this device. I mistook the calling for another device with the
calling for this one.
I will send a new version
Thanks
Cindy
>


