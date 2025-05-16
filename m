Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D495C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 01:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFk81-0005zj-PD; Thu, 15 May 2025 21:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFk7w-0005oO-Bv
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFk7u-0003YD-GM
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747359878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfJhjE1tDyAxNNCYTErsFmWI2derrob/VNlfQEb6xoA=;
 b=EhykDS2Aa69aRuy9eqaXIZbDmKI6AEELbhsjvtYDu5Jz99oPy3beizgAczLgERfw9ug7BB
 gBhLaTholF74f9h0G8qrAA90o/l/UCRhYPb8gb7qm3mGYnV3p5Ny/154pYzTv2QOCWN4l6
 szOCwATMlo4U9yv11mtrl/KOzcEKcyQ=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-rk8zpKPOM-e2JtZ7y7TXiQ-1; Thu, 15 May 2025 21:44:36 -0400
X-MC-Unique: rk8zpKPOM-e2JtZ7y7TXiQ-1
X-Mimecast-MFC-AGG-ID: rk8zpKPOM-e2JtZ7y7TXiQ_1747359876
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-52af93cb7daso1401928e0c.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 18:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747359876; x=1747964676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfJhjE1tDyAxNNCYTErsFmWI2derrob/VNlfQEb6xoA=;
 b=Vw+OZtgO3WurtUzqxT1YMKfIptdA4nucV240SY3zef7mA8xmdwRbeRs6Fjz8JdlNJ8
 DZJJj/1irVtLq6PNnH4GZFCFClZpgnIYfDfMFO+lDq69wpBd/XV1gtTFDTSrQ1EM8ZWH
 z+Adyv3gAgyUdn8toGTjEIeLDUUtQlKrLpqQBN8iDnCxLuly67rMCAWjd2NVjn+e+Fk+
 ZlduZHf8k2iDpnZv44Et2acu0PwraMWALhugawk4dKhuOBZu0VQNpOHiw7aHnlBT9Rpq
 gc32FASMT2Pmlj165b6OlvuDqte7mBcIonByjDt2sPTZPhipbqsi8nR4KPW7cx7iPjos
 wJFQ==
X-Gm-Message-State: AOJu0YxDYrxf+Dz7S86/frjJyUjnPIDT5kEQhaTbvosZeo3s7rOBrjcS
 C593xBuvgYaOeu3BZAJUBay5CTcM9wHlI9k13pc5V4P2cg+pFve7m64yOsb/AjUbI6gaW13T0c7
 7Pd0QDk8rGa9MI0pgWKzbfpsW9j4X8v93sTx53dNgKdrmShZ7nZLsvqLweOdNbtvYCJbB+i6Qzl
 Yc6X2jzZl3BC0qykD5WCEzmQYaXbwr3Dc=
X-Gm-Gg: ASbGncsVf/B9SyAEuTEB9uRD7HAdMRh+ns0fARFK/7+/07Hp4zUNU8FgGr1i/30Y92I
 2/cVuvJD/Nevy2VqtQt5VYaxVb+gv2LBYDLAImWjC1wmWon9/vny34xR60eYCScWDmgbIUw==
X-Received: by 2002:a05:6102:370a:b0:4da:d874:d30d with SMTP id
 ada2fe7eead31-4dfa6bf6221mr2820775137.17.1747359876166; 
 Thu, 15 May 2025 18:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiHyaJfVlOZmFRmjguvyinhrzv2Zejiz9+nk5cd+KMvlPyxG0T/TNgsxP3p8A+iy1fe2BXTvwqmERe2XBYlCo=
X-Received: by 2002:a05:6102:370a:b0:4da:d874:d30d with SMTP id
 ada2fe7eead31-4dfa6bf6221mr2820768137.17.1747359875736; Thu, 15 May 2025
 18:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
 <CACGkMEt7xoX-HvV1mOo=zqpyV0se2ELBMvNV-uGpKUZPQ-PB2A@mail.gmail.com>
 <f3d10b18-9755-46af-9623-fb0ed7d99c51@daynix.com>
In-Reply-To: <f3d10b18-9755-46af-9623-fb0ed7d99c51@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:44:23 +0800
X-Gm-Features: AX0GCFs_DZHOPJ4mHsDvoisTHR6YJ4hkV6WRI_dbI6tZ2iIo45ycTUSa7lhKlaI
Message-ID: <CACGkMEu_hyc-mP4zk9kJprCpFQbVzO0D2SEMy9eid5TmUH7Uaw@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Add queues for RSS during migration
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 14, 2025 at 2:58=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/05/14 14:05, 'Jason Wang' via devel wrote:
> > On Sat, May 10, 2025 at 3:24=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
> >> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
> >> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
> >> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_featur=
es
> >> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
> >> VIRTIO_NET_F_MQ uses bit 22.
> >>
> >> Instead of inferring the required number of queues from
> >> vdev->guest_features, use the number loaded from the vm state.
> >>
> >> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizi=
ng")
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   include/hw/virtio/virtio.h |  2 +-
> >>   hw/net/virtio-net.c        | 11 ++++-------
> >>   hw/virtio/virtio.c         | 14 +++++++-------
> >>   3 files changed, 12 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >> index 638691028050..af52580c1e63 100644
> >> --- a/include/hw/virtio/virtio.h
> >> +++ b/include/hw/virtio/virtio.h
> >> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
> >>       int (*start_ioeventfd)(VirtIODevice *vdev);
> >>       void (*stop_ioeventfd)(VirtIODevice *vdev);
> >>       /* Called before loading queues. Useful to add queues before loa=
ding. */
> >> -    int (*pre_load_queues)(VirtIODevice *vdev);
> >> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
> >
> > This turns out to be tricky as it has a lot of assumptions as
> > described in the changelog (e.g only lower 32bit of guest_features is
> > correct etc when calling this function).
>
> The problem is that I missed the following comment in
> hw/virtio/virtio.c:
>      /*
>       * Temporarily set guest_features low bits - needed by
>       * virtio net load code testing for VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
>       * VIRTIO_NET_F_GUEST_ANNOUNCE and VIRTIO_NET_F_CTRL_VQ.
>       *
>       * Note: devices should always test host features in future - don't
> create
>       * new dependencies like this.
>       */
>      vdev->guest_features =3D features;
>
> This problem is specific to guest_features so avoiding it should give us
> a reliable solution.

I meant not all the states were fully loaded for pre_load_queues(),
this seems another trick besides the above one. We should seek a way
to do it in post_load() or at least document the assumptions.

>
> >
> > Looking at the commit that introduces this which is 9379ea9db3c that sa=
ys:
> >
> > """
> > Otherwise the loaded queues will not have handlers and elements
> > in them will not be processed.
> > """
> >
> > I fail to remember what it means or what happens if we don't do 9379ea9=
db3c.
>
> The packets and control commands in the queues except the first queue
> will not be processed because they do not have handle_output set.

I don't understand here, the VM is not resumed in this case. Or what
issue did you see here?

Thanks

>
> Regards,
> Akihiko Odaki
>


