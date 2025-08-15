Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A71CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 14:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umvI8-0002i8-ER; Fri, 15 Aug 2025 10:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1umvI6-0002he-70
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1umvI3-0003WE-3v
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755267615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QM/tQMvYHGUE2Y+OAGzgMBB1ya3yJ0TE4nrWjwQ17+M=;
 b=CkQcKeAc7oV8o7M0z2wl6X32QmrtPMESWjd43D52ao/HWLlDi+MtMjUXZIkjxe5t1lxjT+
 kUvBPlnJu9TEee+WSIgWtdAbz29CBEQ6VN8jKBJeq9g4MD6lad1K1AOQmMlX4IDpsye1HM
 RD21Pn78FMIvwUhNgyPRqITAF+jQBdU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-XPDaUGmPPeGbpcnaUR1p3Q-1; Fri, 15 Aug 2025 10:20:13 -0400
X-MC-Unique: XPDaUGmPPeGbpcnaUR1p3Q-1
X-Mimecast-MFC-AGG-ID: XPDaUGmPPeGbpcnaUR1p3Q_1755267612
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3e5700a5525so4696775ab.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 07:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755267612; x=1755872412;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QM/tQMvYHGUE2Y+OAGzgMBB1ya3yJ0TE4nrWjwQ17+M=;
 b=nQ/uStiLAH4cZJDJvLkwfsKbNJPqUzF/xlZUwu5TYCiRstT9DSHgVmu4edIFJfaP1Z
 wI/HlKVdoyb+YBnxvd7d4Ws+8xEIutIh//eWLDpvlOSFPRKAJZSIBVyConHJOozi5ITB
 afbSvm/pc6uxP8UDj6Qa9Spam99XZ0VvezCgAYocg6KZOYpI1/tFfduhodkw7xG8Wkxx
 zXnWcVxBJxc3A11WihNIybjo6bZangj5mp/dOn3YMJ4RaIVhEPlSaXue5L9UA7uYAK+d
 T+XxVlUZl1JV9jqzanS+ftAAZNQ/VOJq4X4IkvwZKFkhAtaaG4prFPoLwMmVEdjp+93/
 vdkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZBiKv6cq0ba0zan3Hd/CzOgo0EHDJ9+bIot8L7rjUsHFCXYBrWCwNQTPBt4SEObX8YGbbft6FWu18@nongnu.org
X-Gm-Message-State: AOJu0Yxjnxshes7y51Lo11m2sYh/lRidZT7O0NI6W3zD4mxpXedt+3q4
 GfA34r/Q4D9kCfsXE6ByELXzHZ88K3H3RxjgIXZg8+UK05fPXWSPormejKQvt3m1sSv6wt0hw9W
 0tCfssz5pFx+ZJmzQp73JQPa0GRFPu643yvoTBVw2mcDrFaXlao/5wx82
X-Gm-Gg: ASbGncvMiUTmW01IfLDFBGt+vKqlO/CN7rGIBmq0ExqThRitURjafrEBD/LPmyn3eYc
 LkF3bOZVizTqQZVR2GFSvxfamnUjSHPSnJQhQ0hPDeO9yBR6qSIFXdDRGcuJnI1NAnlzsatMYUz
 I3y4XemUxRUJdS3XANCuyQ6QlT3yffXIgfN60rkCiLNM/54na76rLzkszeFggKWbeOx+oe2NCbC
 6BVYWM3NHStpJb3mE497PBlEMFebFMc/JQAsWWQZ9UZvoTAbsxUN69pxxOLQFrXKpmVGKAj7iLB
 YOp0uXMSBthrXOL6q32QTZQJVFLy4U83Ep5VmoBy5FQ=
X-Received: by 2002:a05:6e02:1521:b0:3e5:2c5e:e6ce with SMTP id
 e9e14a558f8ab-3e57e76c57amr11204615ab.0.1755267612443; 
 Fri, 15 Aug 2025 07:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBzRp69BMd8deXc7/if3U5IoaLJ+gJ/ojggEXmj0ju3NrzdWh9uCY7GZ4bkaZz8k4MnqMVuA==
X-Received: by 2002:a05:6e02:1521:b0:3e5:2c5e:e6ce with SMTP id
 e9e14a558f8ab-3e57e76c57amr11204445ab.0.1755267611977; 
 Fri, 15 Aug 2025 07:20:11 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50c9477f434sm436521173.13.2025.08.15.07.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 07:20:11 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:20:09 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] vfio: Report an error when the 'dma_max_mappings' limit
 is reached
Message-ID: <20250815082009.2ed1d2a0.alex.williamson@redhat.com>
In-Reply-To: <70d6d913-239d-42a4-8a88-a492bf5e569f@intel.com>
References: <20250814153419.1643897-1-clg@redhat.com>
 <70d6d913-239d-42a4-8a88-a492bf5e569f@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 15 Aug 2025 18:49:22 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 2025/8/14 23:34, C=C3=A9dric Le Goater wrote:
> > The VFIO IOMMU Type1 kernel driver enforces a default IOMMU mapping
> > limit of 65535, which is configurable via the 'dma_max_mappings' =20
>=20
> @Alex, I've a long standing question, could you share why 65535 is the
> magic number? :)

640^Hk is enough for anyone, right? ;)

We added this in response to a security issue where a user could
allocate an unlimited number of vfio_dma objects and, iirc, the thought
was that 64k entries was an absurdly high number for all typical cases
where we're making relatively few, relatively static DMA mappings,
which is effectively what the type1 interface is designed for.  It
would be insanely inefficient to map the entire VM with 4K pages with
type1, right?!  Enter confidential device assignment...

It's still a bad idea to use type1 this way, I'm just waiting for the
reports of slow VM startup with large memory VMs, however we might be
able to mitigate the security issue if we allocated the vfio_dma
objects with GFP_KERNEL_ACCOUNT.  However, I think we also compounded
the problem in QEMU when looking for the number of available mapping
entries it assumes 64k if the limit capability isn't found, rather than
unlimited.  So to unwind ourselves out of this jam, we might choose to
report UINT32_MAX and some additional mechanism to report unlimited, or
let QEMU fix itself, or we just advise that type1 is a bad interface
for this and needing to adjust the limit is an indication or that and
such use cases should migrate to better interfaces in IOMMUFD.  Thanks,

Alex

> > module parameter. When this limit is reached, QEMU issues a warning
> > and fails the mapping operation, but allows the VM to continue
> > running, potentially causing issues later. This scenario occurs with
> > SEV-SNP guests, which must update all IOMMU mappings during
> > initialization.
> >=20
> > To address this, update vfio_ram_discard_register_listener() to accept
> > an 'Error **' parameter and propagate the error to the caller. This
> > change will halt the VM immediately, at init time, with the same error
> > message.
> >=20
> > Additionally, the same behavior will be enforced at runtime. While
> > this might be considered too brutal, the rarity of this case and the
> > planned removal of the dma_max_mappings module parameter make it a
> > reasonable approach.
> >=20
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> > ---
> >   hw/vfio/listener.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-) =20
>=20
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>=20
> > diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> > index 184c15e05fcb388cf0848e97e1eb283f17a50ad4..bc40ec8613c71a12b8c0dfd=
ea497a14a446ac1fd 100644
> > --- a/hw/vfio/listener.c
> > +++ b/hw/vfio/listener.c
> > @@ -250,8 +250,9 @@ int vfio_ram_discard_notify_populate(RamDiscardList=
ener *rdl,
> >       return 0;
> >   }
> >  =20
> > -static void vfio_ram_discard_register_listener(VFIOContainerBase *bcon=
tainer,
> > -                                               MemoryRegionSection *se=
ction)
> > +static bool vfio_ram_discard_register_listener(VFIOContainerBase *bcon=
tainer,
> > +                              I'd prefer a replacement but I will acce=
pt a refund if you're not able to provide a compatible item.               =
   MemoryRegionSection *section,
> > +                                               Error **errp)
> >   {
> >       RamDiscardManager *rdm =3D memory_region_get_ram_discard_manager(=
section->mr);
> >       int target_page_size =3D qemu_target_page_size();
> > @@ -316,13 +317,15 @@ static void vfio_ram_discard_register_listener(VF=
IOContainerBase *bcontainer,
> >  =20
> >           if (vrdl_mappings + max_memslots - vrdl_count >
> >               bcontainer->dma_max_mappings) {
> > -            warn_report("%s: possibly running out of DMA mappings. E.g=
., try"
> > +            error_setg(errp, "%s: possibly running out of DMA mappings=
. E.g., try"
> >                           " increasing the 'block-size' of virtio-mem d=
evies."
> >                           " Maximum possible DMA mappings: %d, Maximum =
possible"
> >                           " memslots: %d", __func__, bcontainer->dma_ma=
x_mappings,
> >                           max_memslots);
> > +            return false;
> >           }
> >       }
> > +    return true;
> >   }
> >  =20
> >   static void vfio_ram_discard_unregister_listener(VFIOContainerBase *b=
container,
> > @@ -576,7 +579,9 @@ void vfio_container_region_add(VFIOContainerBase *b=
container,
> >        */
> >       if (memory_region_has_ram_discard_manager(section->mr)) {
> >           if (!cpr_remap) {
> > -            vfio_ram_discard_register_listener(bcontainer, section);
> > +            if (!vfio_ram_discard_register_listener(bcontainer, sectio=
n, &err)) {
> > +                goto fail;
> > +            }
> >           } else if (!vfio_cpr_ram_discard_replay_populated(bcontainer,
> >                                                              section)) {
> >               error_setg(&err, =20
>=20


