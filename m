Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D770BC0218D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 00:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcDFY-0000Xa-6L; Sun, 26 Jan 2025 19:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tcDFW-0000W2-22
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 19:45:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tcDFT-0005o6-VD
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 19:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737938705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+Zg3UIW2cgR/q9nEuJH6tx/9NGZJUFKUPYXA/4PGHA=;
 b=d0nAYDyygmQQLYmFhbpeEIBL9LsZkvET7DYYoRFQ3G4SAC5PTNefwP96WOZW4lA8pnmzj3
 Jp3YYfy3UxdzC6pvLYPwTizPg6vvOO8dv2JtRwtjBhfBsENLMrGEZWGi6KLFKq7IqVdmzz
 OItrmPY7b5HraH+OPiz92NCJbhpr6NI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-auOrXSvdNAO4zTMjzOX1Dg-1; Sun, 26 Jan 2025 19:45:03 -0500
X-MC-Unique: auOrXSvdNAO4zTMjzOX1Dg-1
X-Mimecast-MFC-AGG-ID: auOrXSvdNAO4zTMjzOX1Dg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ee8ced572eso7892002a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 16:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737938702; x=1738543502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+Zg3UIW2cgR/q9nEuJH6tx/9NGZJUFKUPYXA/4PGHA=;
 b=M21w+V0BjD70omOqdSGYwNkUgEeKi04QCmShXukKmbsZ4ssx55QjhN1Nb8iXRp4Icr
 ksuh1enNYFoW8UeTXzUyYAOpbLzjYv1THN/pCIc32bmm2vkPrHsPGePPMqQjUjqX8Jik
 d2m8kieQd8RJkH9oDDl3lE6WrN4ZnOiIksgwOuHDIteRVSamYyNe4g1dLvWG+lEtRLrm
 wf03aQy1SaAbIsiVzI1kywYrP6SSlMB/ZKYdi9PoN9ekyYqesCNYoRGi2+0qjtSzGF+c
 9uEMouG9lLZQF2YDfIYt8Eix1uPTMSRjeeKp8HNkvAQnyqKk6/5MKOFu4El3pR4pAMTg
 8qpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx69WpGswXQDPym+67Qm2vTHN9jLAtUuFuEwGvsJQsVmnE/WqPM8QeQJNZXm7qAxsfDEsGoTKy63bM@nongnu.org
X-Gm-Message-State: AOJu0YybYkIhQHnVkcOuowzEFSx3sf5X7BILIcHU8fbv7WhUjPjU0SRf
 gSgaw1os93RHEi4LgXAG0TLcFEt4pVLBaeMb0GRHFbIt5LDvO4NGI/fS7+DgEuMJST6biLHaLaF
 RggwZBdvkY2qEkrPUWHaEcD5nY9QQZbROZ46+r6/reCqxcssook9S7QMgyGRQeNgB/8OvN6mVTo
 tPum6jC92Iev0Z26rHWrO0OKgnmeU=
X-Gm-Gg: ASbGnct2ZZ3t8Z3QR0RBnHNbDb/FWpN+5K/rP6EQd+IbEikxot+Vbta27k9sQv+ozec
 tBHMzrLC6JJ+UYRy9tROnMKZn4/Fwh318afJItEClsqKzEHzlAnsnIy8U0Sd7eU+b
X-Received: by 2002:a05:6a00:21c8:b0:725:460e:6bc0 with SMTP id
 d2e1a72fcca58-72daf79f69cmr57609452b3a.0.1737938702480; 
 Sun, 26 Jan 2025 16:45:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHStArs4kQ8dHFkrInogUo18DP27IGkNBOphllmJ2vhfez9yp5wYorLEveVSYPsw2ivvgJoasnYiWOIbJ8C7ZE=
X-Received: by 2002:a05:6a00:21c8:b0:725:460e:6bc0 with SMTP id
 d2e1a72fcca58-72daf79f69cmr57609432b3a.0.1737938702021; Sun, 26 Jan 2025
 16:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
 <Z5OvXaUF6sdEQLgW@x1n>
 <CACGkMEtPvUZh-seF1oDLMOOSiJhdHZeywvk6vKZy+jhEY4AjCA@mail.gmail.com>
In-Reply-To: <CACGkMEtPvUZh-seF1oDLMOOSiJhdHZeywvk6vKZy+jhEY4AjCA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Jan 2025 08:44:50 +0800
X-Gm-Features: AWEUYZnuIcr_99cZhbPem1BW5gmzgOa1huN-0-XNx9wLstIS-57ebf_bXOFBjwo
Message-ID: <CACGkMEsJXaPgHU0+YB+NKnDPoOg25RMNiWf-LCOqX1jP9REE8w@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
To: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, 
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Jan 26, 2025 at 3:56=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, Jan 25, 2025 at 12:42=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> >
> > Hello, Jason, Eric,
> >
> > On Fri, Jan 24, 2025 at 11:30:56AM +0800, Jason Wang wrote:
> > > It might be because neither virtio bus nor virtio-net provides a
> > > shutdown method.
> > >
> > > There used to be requests to provide those to unbreak the kexec.
> > >
> > > A quick try might be to provide a .driver.shutdown to
> > > virtio_net_driver structure and reset the device there as a start.
> >
> > I didn't check virtio driver path, but if that's missing it's reasonabl=
e to
> > support it indeed.
> >
> > OTOH, even with that, vhost can still hit such DMA issue if it's a
> > hard-reset, am I right?  IOW, when using QMP command "system-reset".  I=
f my
> > memory is correct, that's the problem I was working on the VFIO series,
> > rather than a clean reboot.  And that won't give guest driver chance to=
 run
> > anything, IIUC.
>
> Yes.
>
> >
> > I am wildly suspecting a VT-d write to GCMD to disable it can also appe=
ar
> > if there's a hard reset, then when bootloading the VM the bios (or what=
ever
> > firmware at early stage) may want to make sure the VT-d device is
> > completely off by writting to GCMD. But that's a pure guess.. and that =
may
> > or may not matter much on how we fix this problem.
> >
> > IOW, I suspect we need to fix both of them,
> >
> >   (a) for soft-reset, by making sure drivers properly quiesce DMAs
> >   proactively when VM gracefully shuts down.
> >
> >   (b) for hard-reset, by making sure QEMU reset in proper order.
> >
> > One thing to mention is for problem (b) VFIO used to have an extra
> > challenge on !FLR devices, I discussed it in patch 4's comment there.
> > Quotting from patch 4 of series:
> >
> > https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com
> >
> >      * (1) Device depth-first reset hierachy doesn't yet work for vIOMM=
Us
> >      *     (reference: resettable_cold_reset_fn())
> >      *
> >      *     Currently, vIOMMU devices are created as normal '-device'
> >      *     cmdlines.  It means in many ways it has the same attributes =
with
> >      *     most of the rest devices, even if the rest devices should
> >      *     logically be under control of the vIOMMU unit.
> >      *
> >      *     One side effect of it is vIOMMU devices will be currently pu=
t
> >      *     randomly under qdev tree hierarchy, which is the source of
> >      *     device reset ordering in current QEMU (depth-first traversal=
).
> >      *     It means vIOMMU now can be reset before some devices.  For f=
ully
> >      *     emulated devices that's not a problem, because the traversal
> >      *     holds BQL for the whole process.  However it is a problem if=
 DMA
> >      *     can happen without BQL, like VFIO, vDPA or remote device pro=
cess.
> >      *
> >      *     TODO: one ideal solution can be that we make vIOMMU the pare=
nt
> >      *     of the whole pci host bridge.  Hence vIOMMU can be reset aft=
er
> >      *     all the devices are reset and quiesced.
> >      *
> >      * (2) Some devices register its own reset functions
> >      *
> >      *     Even if above issue solved, if devices register its own rese=
t
> >      *     functions for some reason via QEMU reset hooks, vIOMMU can s=
till
> >      *     be reset before the device. One example is vfio_reset_handle=
r()
> >      *     where FLR is not supported on the device.
> >      *
> >      *     TODO: merge relevant reset functions into the device tree re=
set
> >      *     framework.
> >
> > So maybe vhost doesn't have problem (2) listed above, and maybe it mean=
s
> > it's still worthwhile thinking more about problem (1), which is to chan=
ge
> > the QOM tree to provide a correct topology representation when vIOMMU i=
s
> > present: so far it should be still a pretty much orphaned object there.=
. if
> > QEMU relies on QOM tree topology for reset order, we may need to move i=
t to
> > the right place sooner or later.
>
> Sounds like a non-trivial task, so for a hard reset, maybe we can
> proceed with Eric's proposal to deal with the reset before the device
> stops.

Btw, I actually meant to break the assumption that vhost needs to be
enabled/disabled after/before vIOMMU. This only works for virtio-net /
vhost. From the view of vhost, it would work similar to _F_LOG_ALL
(where there's no assumption on the order of enabling/disabling dirty
page tracking and device start/stop).

Thanks

>
> Thanks
>
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >


