Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF72CA0EC4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 05:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um4Sm-0001Qz-GG; Wed, 13 Aug 2025 01:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1um4Sk-0001Pc-IQ
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 01:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1um4Sg-0003mw-1Z
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 01:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755064541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjqQs2AsOARtKdNaZ0RfCrCBBvpwLBEMnrTctguUF/Y=;
 b=Ekswwm60EY+1k1SIHdxnHhGhYjeOTgDawuIEyl5g4bnwoIJeknbbUEY5hdVn5/hM31euvy
 oxdIbwXX8Xkm+MFYxrmCGQypn02Oycxg2CFDWnxrn3jNMJZDUnel+q+leG3DCG1kxLZTVe
 r+mikogx02EwQvHbd2KcEP8LR3rA+yM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-BdiGPL-OOfS8VGKGLMHUjA-1; Wed, 13 Aug 2025 01:55:39 -0400
X-MC-Unique: BdiGPL-OOfS8VGKGLMHUjA-1
X-Mimecast-MFC-AGG-ID: BdiGPL-OOfS8VGKGLMHUjA_1755064538
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23fe26e5a33so94663375ad.3
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 22:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755064538; x=1755669338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjqQs2AsOARtKdNaZ0RfCrCBBvpwLBEMnrTctguUF/Y=;
 b=QcSQtGSB3bMgVDfm3/uVZ4UmjTxcTbs3NOtLXhOK2kjobTKhsdNgqraXWCGB7ny7zB
 gVzqcFortI+nUN2Z8MjtKyB7c4uUUfmWcCiyShKZA63myCxooo+KrR5uaTIXZXKSoud2
 XINXi5FIqHNG65kQsBgyazG8tmIo0157Pf2vetniW9srLmZZTem02pRiXi0hvvB6hAtJ
 GpdORdLAGL+HLGKw+UIs1OVcNwLY3zlGbRnI2XtLUEvEhZKMQeGejvfFqqoL8DyDOqYs
 YqMqhpiwUVKjd1mlQn0gXS4eFDaR3m2AEc/4Ju23LuSkfDbC7r+8MiQHnrIt7CB+6bCR
 EKdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI4leH/Pht9VvoSdmK5T+iUtdnD+ruLyDviZPgGXKIebFNbLNagV54OflD5wcjJeqeNQ+SKN2lJKqD@nongnu.org
X-Gm-Message-State: AOJu0Yxma/+UJMP3KQD8aJ3ECqXpGcF5BCfq7s6G08jEcZdSb5/TSVea
 t6LdeT0RFv35uSJne64OjRVxJ+IEVYrYTb731V1hFVjJ7jNXfC+BArEh5idtfVKtnk3vJ31z62f
 rVr0fwAbRNn5r1etUPaU1Vn18POx9VvLGDSqgjxy4BauixweFawjQVol2//Npmcjk5z21U4+qT4
 Mb2eopGL+ICCp8CdEC6BpxIOh+6JCYjE8=
X-Gm-Gg: ASbGncv+xDz4U8Fa6epkiF98WVfbSocSBRe0+TYvqvp2QFBPA0rfLNPbktp7uVs8DxX
 wFq6kLUKXHfckPt58hv/7WEb3H4uDTT/1OjGQTmBe2o7Ohx3cBcnxy2fF5DiWyLLi+UxL86I+A/
 R1ZGRzLLporW+MCTxXWzE=
X-Received: by 2002:a17:902:f611:b0:234:a139:11f0 with SMTP id
 d9443c01a7336-2430d0b2a80mr27380035ad.7.1755064538414; 
 Tue, 12 Aug 2025 22:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMWTqo6oS+jAMq93plCzQIEJZYNL2yyGfwXxDKaUvhx6I+H+C74sCSubQE3MQIEjWOeofeYzNIWs6CxuuE5tU=
X-Received: by 2002:a17:902:f611:b0:234:a139:11f0 with SMTP id
 d9443c01a7336-2430d0b2a80mr27379525ad.7.1755064537586; Tue, 12 Aug 2025
 22:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1753297661.git.pabeni@redhat.com>
 <8e8a91adcbf4e37c7a5e086780e1000d3b3298d3.1753297661.git.pabeni@redhat.com>
 <de3c69a8-d874-44a3-bd47-91b6b298e184@rsg.ci.i.u-tokyo.ac.jp>
 <7c7c3f2c-e643-46ad-810c-aefdd486ad78@redhat.com>
 <8e3c5aa3-3180-4df2-b378-18e3e91d3f80@rsg.ci.i.u-tokyo.ac.jp>
 <CACGkMEse8cM8=8y4JwBdVQi23buz1OCzhQmVxvsRJGdQ9tgaWA@mail.gmail.com>
 <73f8b2dc-d5ad-43b7-834f-6322bfe617af@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <73f8b2dc-d5ad-43b7-834f-6322bfe617af@rsg.ci.i.u-tokyo.ac.jp>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Aug 2025 13:55:25 +0800
X-Gm-Features: Ac12FXyKTyrL_PSA-pUjz3hNkcxglZRRqMNsYefOdKovHTosAnIe1ny8Mi690F4
Message-ID: <CACGkMEuP10o6dBGpyrNuLamKmd+OLiadp2TQKSkdG-Zr-2kk0A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 07/14] virtio-pci: implement support for extended
 features
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Aug 12, 2025 at 4:03=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/08/12 13:01, Jason Wang wrote:
> > On Fri, Aug 8, 2025 at 12:55=E2=80=AFPM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2025/08/08 5:18, Paolo Abeni wrote:
> >>> On 7/26/25 1:52 PM, Akihiko Odaki wrote:
> >>>> On 2025/07/24 4:31, Paolo Abeni wrote:
> >>>>> @@ -1477,6 +1509,13 @@ int virtio_pci_add_shm_cap(VirtIOPCIProxy *p=
roxy,
> >>>>>         return virtio_pci_add_mem_cap(proxy, &cap.cap);
> >>>>>     }
> >>>>>
> >>>>> +static int virtio_pci_select_max(const VirtIODevice *vdev)
> >>>>> +{
> >>>>> +    return virtio_features_use_ex(vdev->host_features_ex) ?
> >>>>> +           VIRTIO_FEATURES_NU32S :
> >>>>> +           2;
> >>>>
> >>>> This function could be simplified by replacing VIRTIO_FEATURES_NU32S
> >>>> without any functional difference:
> >
> > Did you mean using VIRTIO_FEATURES_NU32S instead?
> >
> >>>>
> >>>> 1. For writes: virtio_set_features_ex() already ignores extended
> >>>> features when !virtio_features_use_ex(vdev->host_features_ex)
> >>>> 2. For reads: When !virtio_features_use_ex(vdev->host_features_ex), =
the
> >>>> upper bits of host_features_ex are zero, and guest_features upper bi=
ts
> >>>> remain zero (since they can't be set per point 1)
> >
> > I think it depends on the compatibility work which hasn't been done in
> > this series.
> >
> >>>>
> >>>> So the conditional logic is redundant here.
> >
> > See below
> >
> >>>
> >>> This is to satisfy a request from Jason:
> >>>
> >>> https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05291.html
> >>> https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05423.html
> >>>
> >>> I agree there will not be functional differences always accessing the
> >>> full space, but the guest could still be able to notice, i.e. the
> >>> extended space will be zeroed on read with that patched qemu and
> >>> untouched by the current code and this patch. To be on the safe side =
I
> >>> think it would be better to avoid such difference, as suggested by Ja=
son.
> >>>
> >>> Does the above make sense to you?
> >>
> >> By functional, I meant the functionality of QEMU, visible to the guest=
,
> >> rather than the whole system including the guest, visible to the end
> >> user. The guest cannot notice the difference because the extended spac=
e
> >> is zero on read even without the conditional, which is described as
> >> point 2 in the previous email.
> >
> > I'm not sure I understand this correctly. But it doesn't harm here cons=
ider:
> >
> > 1) it's the entry point from the guest, checking and failing early is
> > better than depending on the low layer functions
> > 2) we have checks in several layers (both virtio-pci and virtio core).
> >
> > And it looks like a must for at least GF:
> >
> >      case VIRTIO_PCI_COMMON_GF:
> >          if (proxy->gfselect < virtio_pci_select_max(vdev)) {
> >              uint64_t features[VIRTIO_FEATURES_NU64S];
> >              int i;
> >
> >              proxy->guest_features[proxy->gfselect] =3D val;
>
> I missed proxy->guest_features. Indeed it makes a difference.
>
> Now I have another concern with virtio_pci_select_max(). If the feature
> set grows again, virtio_pci_select_max() will return the grown size for
> the devices that have [127:64] bits, which will be a breaking change. In
> this sense, VIRTIO_FEATURES_NU32S, which will grow along with the
> feature set, is not appropriate here.

Things will be fine if we do the compatibility work correctly, so host
"host_features_ex_ex" won't contain anything for the legacy machine
types.

But I'm not sure it's worth worrying about it now considering we take
years to reach 64.

>
> Hardcoding 4 ensures such a breaking change will not happen at least.
>
> Perhaps QEMU_BUILD_BUG_ON() may be placed here to tell it needs to be
> updated when the feature set grows, but I don't require that since there
> is QEMU_BUILD_BUG_ON() before vmstate_virtio_pci_modern_state_sub. It
> may be a good idea to move this function somewhere close to
> QEMU_BUILD_BUG_ON().
>
> Alternatively the function may compute the value to return by finding
> the last non-zero element in vdev->host_features_ex and multiplying by
> 2. It will probably work even if the feature set grows again in the futur=
e.
>
> Regards,
> Akihiko Odaki

Thanks

>


