Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D006C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 00:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkXxu-0006Ld-Im; Tue, 18 Feb 2025 19:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tkXxr-0006L9-Af
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 19:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tkXxo-0001zU-Ut
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 19:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739924958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLu2KcGp+62rpmUN4cYlrtT6GKITS1Lw2WLVEwDjDlA=;
 b=bFKyK63b4AEDQ22DGUNk5n+FW9/3WD0u26LIUbLWcievL33HIJfIYwA8bZIW1u0dE/poF+
 ARLFmrm3kCbVUDSfUnFsJu0YLbNlBMAeUUWkOzpV3/kspd8x6hhOgPRNWBuV03KUJMiJBt
 mS0fcdDLgkV0gvKXfI5uL3o+HLMitrI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-_HKx8LaiPGCYBktJMrY8Ig-1; Tue, 18 Feb 2025 19:29:16 -0500
X-MC-Unique: _HKx8LaiPGCYBktJMrY8Ig-1
X-Mimecast-MFC-AGG-ID: _HKx8LaiPGCYBktJMrY8Ig_1739924956
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fc0bc05b36so19481057a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 16:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739924956; x=1740529756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLu2KcGp+62rpmUN4cYlrtT6GKITS1Lw2WLVEwDjDlA=;
 b=bMs3H7AdOXtFkRpMuch91eXPrSmu1lJBVqcl97YMtZTPTlGAxB/thyy/csMjpb7vf9
 lGphZfrzUByVxOexj7cA3lJ+9VV1InmfqP+GLJzu0GwKtYvoR6jc4+wVVoDlYKpCpjfY
 1S+tH15Qfi6R3bAbp//9LaHTrSmQCc2kwsB/Kb9z6Vs7pT8u9a5Yx3gP/Xi+kbf+xVUo
 WHcAcJEZWTaWuspOPpqBNXH7Sk5AvOwi0WxSZJng68Pp43T+N1Lx/KxBB7BsCutM/qlH
 MnuGFTNhE1bFP7Y8cbQFq63MTEZTa8E/Gt2STLI1QbWEPXFAwJg7JxGYt7n0BXJugOKL
 VnUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFpSZI9Az0KD1H9ewXcyO5qmO/8Ov4i7oK8mNIE3slfgEfqZxfqkdQ0rzt9HeLMbsBzPkmLGMkxySp@nongnu.org
X-Gm-Message-State: AOJu0YwhbVqyjY2Wyx71AsEV31xf2DPtnH/0RnFLfb/7HKgpVNvWqhOC
 GkbeGf+Yf3wByuNhi5n+oOV+jAXjXfXtImh75SQQSEQBA/hD5nNMNk/MEZFCDpO2ErhcuGGTTlV
 ns3/o60lu7eeZkb1TvmqqcXX2JyAxw6UhKkYzHZGI3MNDLiSVmEGUXxb13ng6U+R2WWklr8PTe2
 RGIXh+YhxywmgbewR31BZQpohMsPU=
X-Gm-Gg: ASbGnct+x1uPqZ4rF2cwviO5Q3P6KU/X8BDIHt3+IEKr6QJvy4l+rbNEk8TkYERD5gb
 eMxdteeGE2nveID/VaT+WBiTYegrDqjxhf968s294Mpn2FqR10XNaF73DuOh3WDI=
X-Received: by 2002:a17:90a:e7cc:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-2fc40c1d6e4mr22755830a91.5.1739924955675; 
 Tue, 18 Feb 2025 16:29:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFF0GaVunDcQ9BEOyzwFekZCnu6/Uy6Tm741KHh0pzZ9ccnqbqmuASdZRmFIMLCGeyjsQWFNOHdFIHAea/G78=
X-Received: by 2002:a17:90a:e7cc:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-2fc40c1d6e4mr22755792a91.5.1739924955179; Tue, 18 Feb 2025
 16:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20250211161923.1477960-1-kshk@linux.ibm.com>
 <bbee3d53-ac82-407b-91a5-b7e4c3f464bf@linaro.org>
 <23d119e5-ea42-4b0b-a491-0fb7b8c4dfb4@linux.ibm.com>
 <07a8be9a-d99e-4d02-b475-671435c11396@linaro.org>
 <90adacff-9409-44f2-9ae6-9e01c8dc6e5c@linux.ibm.com>
 <5e8b3f72-d29b-4b19-a00f-a1bd5125ec7c@linux.ibm.com>
 <644a3d77-3c95-4ca9-a453-933c74dbd40a@linaro.org>
In-Reply-To: <644a3d77-3c95-4ca9-a453-933c74dbd40a@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Feb 2025 08:29:03 +0800
X-Gm-Features: AWEUYZkQ--veAEIdKQ5nwu7O8O6f06mK4pa9n0q5Xa4tpLDDH4CY45E_3ZhSlM4
Message-ID: <CACGkMEtT=o=F_AbmeCqqhEQv7sOpFYePoV5mCcwdzvScX4DBZA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Allow vDPA to work on big-endian machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, mst@redhat.com,
 sgarzare@redhat.com, mjrosato@linux.ibm.com, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Laurent Vivier <lvivier@redhat.com>, Hanna Czenczek <hreitz@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 18, 2025 at 10:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Konstantin,
>
> (Cc'ing more developers)
>
> On 18/2/25 14:27, Konstantin Shkolnyy wrote:
> > On 2/12/2025 14:01, Konstantin Shkolnyy wrote:
> >> On 2/12/2025 12:07, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> On 12/2/25 18:24, Konstantin Shkolnyy wrote:
> >>>> On 2/12/2025 08:52, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> On 11/2/25 17:19, Konstantin Shkolnyy wrote:
> >>>>>> Add .set_vnet_le() function that always returns success, assuming
> >>>>>> that
> >>>>>> vDPA h/w always implements LE data format. Otherwise, QEMU
> >>>>>> disables vDPA and
> >>>>>> outputs the message:
> >>>>>> "backend does not support LE vnet headers; falling back on
> >>>>>> userspace virtio"
> >>>>>>
> >>>>>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> >>>>>> ---
> >>>>>>   net/vhost-vdpa.c | 6 ++++++
> >>>>>>   1 file changed, 6 insertions(+)
> >>>>>>
> >>>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >>>>>> index 231b45246c..7219aa2eee 100644
> >>>>>> --- a/net/vhost-vdpa.c
> >>>>>> +++ b/net/vhost-vdpa.c
> >>>>>> @@ -270,6 +270,11 @@ static bool vhost_vdpa_has_ufo(NetClientState
> >>>>>> *nc)
> >>>>>>   }
> >>>>>> +static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool is_le)
> >>>>>> +{
> >>>>>> +    return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>>   static bool vhost_vdpa_check_peer_type(NetClientState *nc,
> >>>>>> ObjectClass *oc,
> >>>>>>                                          Error **errp)
> >>>>>>   {
> >>>>>> @@ -437,6 +442,7 @@ static NetClientInfo net_vhost_vdpa_info =3D {
> >>>>>>           .cleanup =3D vhost_vdpa_cleanup,
> >>>>>>           .has_vnet_hdr =3D vhost_vdpa_has_vnet_hdr,
> >>>>>>           .has_ufo =3D vhost_vdpa_has_ufo,
> >>>>>> +        .set_vnet_le =3D vhost_vdpa_set_vnet_le,
> >>>>>
> >>>>> Dubious mismatch with set_vnet_be handler.
> >>>>
> >>>> I'm not sure what you are suggesting...
> >>>
> >>> Implement set_vnet_le for parity?
> >>
> >> To my (very limited) knowledge, kernel's vhost_vdpa that QEMU talks to
> >> doesn't have an API to "change h/w endianness". If so,
> >> vDPA's .set_vnet_le/be(), as well as qemu_set_vnet_le/be() have very
> >> limited choices. qemu_set_vnet_le/be() behavior with vDPA was to
> >> simply assume that h/w endianness by default matches host's. This
> >> assumption is valid for other types of "NetClients" which are
> >> implemented in s/w. However, I suspect, vDPA h/w might all be going to
> >> be LE, to match virtio 1.0. Such is the NIC I'm dealing with.
> >>
> >> My patch is only fixing a specific use case. Perhaps, for a complete
> >> fix, qemu_set_vnet_be() also shouldn't unconditionally return success
> >> on big endian machines, but always call .set_vnet_be() so that vDPA
> >> could fail it? But then it would start calling .set_vnet_be() on other
> >> "NetClients" where it didn't before.
> >>
> >> That's why I don't want to just add a .set_vnet_be(), before someone
> >> here even confirms that vDPA h/w is indeed assumed LE, and, hence,
> >> what the right path is to a complete solution...

Note that modern (VERION_1) virtio/vDPA device assumes LE.
Transitional devices need to support "native endian" which requires
the interface like what you suggest here when guest and host endian
are different.

But we need to confirm with the vDPA vendors to know if their device
is modern only or transitional.

E.g by looking at mlx5_vdpa drivers, it seems to support big endian:

/* TODO: cross-endian support */
static inline bool mlx5_vdpa_is_little_endian(struct mlx5_vdpa_dev *mvdev)
{
        return virtio_legacy_is_little_endian() ||
                (mvdev->actual_features & BIT_ULL(VIRTIO_F_VERSION_1));
}

But it needs to judge the endian according to what userspace tells us
(as the "TODO"), we probably need to invent new vDPA ioctls for that
besides the Qemu modifications.

Adding Dragos for more thought here.

Thanks

> >>
> >> int qemu_set_vnet_be(NetClientState *nc, bool is_be)
> >> {
> >> #if HOST_BIG_ENDIAN
> >>      return 0;
> >> #else
> >>      if (!nc || !nc->info->set_vnet_be)
> >>          return -ENOSYS;
> >>
> >>      return nc->info->set_vnet_be(nc, is_be);
> >> #endif
> >> }
> >>
> >
> > Does anyone have any answers/suggestions?
> >
>
> Since you mentioned "vDPA h/w always implements LE data format",
> I'd expect virtio_is_big_endian(vdev) always return FALSE, and
> thus this to be safe:
>
>   static int vhost_vdpa_set_vnet_be(NetClientState *nc, bool is_le)
>   {
>       g_assert_not_reached();
>   }
>
> But I don't know much about vDPA, so I won't object to your patch.
>
> Regards,
>
> Phil.
>


