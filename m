Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84517CED273
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy44d-0001jk-FO; Tue, 08 Oct 2024 02:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sy44a-0001jC-3t
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 02:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sy44Y-0006VQ-GN
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 02:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728370312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/XAWt0895jl/66QC9384He5rounJue2EgEi+HUDNt0=;
 b=OUjMglicil455zR5diBhOjqqlO1FplfAo+bUJCWqqv0lvaQwUQ8CNBJ8NP/738kben+5Op
 RjrphJ+GAfiZcdF7HqTgiwFjgSrjiDj+P9+4kArakEfznnxcRKAuQ8WDiDQMhbd0prlqfq
 zeho5O1QeeVZMUvonjcKTPNLFZT/pq8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-HDykToLGP0m_XwfrbBT7OA-1; Tue, 08 Oct 2024 02:51:50 -0400
X-MC-Unique: HDykToLGP0m_XwfrbBT7OA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6dbbeee08f0so85656047b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 23:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370310; x=1728975110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/XAWt0895jl/66QC9384He5rounJue2EgEi+HUDNt0=;
 b=U9G5oam/lRNP38WSH5zMXfqPFn7yaQpPm90Y7+WAv2vTT2cmgdAV0Dgz6ZCjjoDQVc
 A09mIgsJzYnDQJAnfLnxBd0CxuXDDInodAgqTYjKWsL4z5eqJkLWGIlvTWnbiuYKa8m2
 HnJ/1aC7J7wo9HPntduJLFjhp3eZMVz/TGu/PF/RzJIdDKxO6EqTGiG+eEyUGfYgk0KZ
 lZDuvR+VFbWmaccnPffB0omztyFdaCIe+Qo4Yt0wS9Ds3t84fx0CvHNfSIoe9x6O87ho
 Jvh9+884uYMh9j+Rd1wLUWkp3sAr4DAyZSBxcGVp9zCtgBTaEeeTSmOt4qCUYOEBoTLl
 dYBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2XiWZWKCmtA9vL78OQ7O82C1yJMbjjG02oo2DmQOZRWm8RNlgGVq+WKyzRajMgoRgc0HVowYDouD2@nongnu.org
X-Gm-Message-State: AOJu0YyRal46QoWwXDr8u9k57Uq8X2LDIzlW3DgpL+f0riHF+gp+o6eW
 P6WQ4NeQ9Y3UqS/V+wB/EWVWmSP/kNpQ4QbvJ3zdlF3ZE6AManaoOnz5Jk3g8/EeBCTdvjeXXhB
 ZAOdJSk5h/EsuZyyDaHrAUaG7eYx1myKgRHpbocwBZ5t5mPx772yTS7D4wdwDXs94O935h+S6Pi
 TBoVtCB1O00E+AiUp+kWZTAcDEfR4=
X-Received: by 2002:a05:6902:987:b0:e28:e488:91b6 with SMTP id
 3f1490d57ef6-e28ea76b88bmr1775513276.15.1728370310083; 
 Mon, 07 Oct 2024 23:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKfx2x3dfBeUxOUYaYu8GNf7E+SnNttuT0BN6h2boKcITMoMhGIx+yVzA9e6fUzacBmzWuKmXzMQjka39+M0Q=
X-Received: by 2002:a05:6902:987:b0:e28:e488:91b6 with SMTP id
 3f1490d57ef6-e28ea76b88bmr1775505276.15.1728370309794; Mon, 07 Oct 2024
 23:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
 <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
 <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
 <a1711695-9d0c-44f4-b799-1879404581d9@oracle.com>
In-Reply-To: <a1711695-9d0c-44f4-b799-1879404581d9@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 8 Oct 2024 08:51:13 +0200
Message-ID: <CAJaqyWfYvD0nEYU9UgKzYgUo5JzuFu3PBKNEkDrM0BE0Ek5LfA@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, 
 leiyang@redhat.com, peterx@redhat.com, dtatulea@nvidia.com, 
 jasowang@redhat.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 8, 2024 at 2:14=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
>
> On 10/7/2024 6:51 AM, Eugenio Perez Martin wrote:
> > On Fri, Oct 4, 2024 at 8:48=E2=80=AFPM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
> >>
> >>
> >> On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
> >>> On Fri, Oct 4, 2024 at 2:45=E2=80=AFPM Jonah Palmer <jonah.palmer@ora=
cle.com> wrote:
> >>>> Implements the IOVA->GPA tree for handling mapping, unmapping, and
> >>>> translations for guest memory regions.
> >>>>
> >>>> When the guest has overlapping memory regions, an HVA to IOVA transl=
ation
> >>>> may return an incorrect IOVA when searching the IOVA->HVA tree. This=
 is
> >>>> due to one HVA range being contained (overlapping) in another HVA ra=
nge
> >>>> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use GPA=
s to
> >>>> translate and find the correct IOVA for guest memory regions.
> >>>>
> >>> Yes, this first patch is super close to what I meant, just one issue
> >>> and a pair of nits here and there.
> >>>
> >>> I'd leave the second patch as an optimization on top, if the numbers
> >>> prove that adding the code is worth it.
> >>>
> >> Ah okay, gotcha. I also wasn't sure if what you mentioned below on the
> >> previous series you also wanted implemented or if these would also be
> >> optimizations on top.
> >>
> >> [Adding code to the vhost_iova_tree layer for handling multiple buffer=
s
> >> returned from translation for the memory area where each iovec covers]=
:
> >> ----------------------------------------------------------------------=
-
> >> "Let's say that SVQ wants to translate the HVA range
> >> 0xfeda0000-0xfedd0000. So it makes available for the device two
> >> chained buffers: One with addr=3D0x1000 len=3D0x20000 and the other on=
e
> >> with addr=3D(0x20000c1000 len=3D0x10000).
> >>
> >> The VirtIO device should be able to translate these two buffers in
> >> isolation and chain them. Not optimal but it helps to keep QEMU source
> >> clean, as the device already must support it."
> >>
> > This is 100% in the device and QEMU is already able to split the
> > buffers that way, so we don't need any change in QEMU.
> Noted that if working with the full HVA tree directly, the internal iova
> tree linear iterator iova_tree_find_address_iterator() today doesn't
> guarantee the iova range returned can cover the entire length of the
> iov, so things could happen like that the aliased range with smaller
> size (than the requested) happens to be hit first in the linear search
> and be returned, the fragmentation of which can't be guarded against by
> the VirtIO device or the DMA API mentioned above.
>
> The second patch in this series kind of mitigated this side effect by
> sorting out the backing ram_block with the help of
> qemu_ram_block_from_host() in case of guest memory backed iov, so it
> doesn't really count on vhost_iova_gpa_tree_find_iova() to find the
> matching IOVA, but instead (somehow implicitly) avoids the fragmentation
> side effect as mentioned above would never happen. Not saying I like the
> way how it is implemented, but just wanted to point out the implication
> if the second patch has to be removed - either add special handling code
> to the iova-tree iterator sizing the range (same as how range selection
> based upon permission will be done), or add special code in SVQ layer to
> deal with fragmented IOVA ranges due to aliasing.
>

This special code in SVQ is already there. And it will be needed even
if we look for the buffers by GPA instead of by vaddr, the same way
virtqueue_map_desc needs to handle it even if it works with GPA.
Continuous GPA does not imply continuous vaddr.


