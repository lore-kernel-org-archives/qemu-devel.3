Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DA5C35FE7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 06:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqo8t-0007sy-Kw; Wed, 18 Sep 2024 02:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sqo8s-0007sT-Ot
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 02:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sqo8q-0002dp-R9
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 02:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726640778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jahyJzntoDKRbNPrHGHtQFqIQ3hKj/ql5btj5ybK2DM=;
 b=jA2VmevLzpy15andaHW+eXUqI+bpd21GWGQq7rTiueCIFLCBK8vx1o7NXLQ8gXnvVBAgF/
 TonwV5JefO3lY64TZ5dtWXiVqpbHo9Px5U0pySfPcrWfSmgvb1ki3aQ9HEPJ2VvyQ1bREy
 wfu7blCc70z6LJ3to818HGQbeqr3eDY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-MBV1MCJ2M0SLRO3a1EFkzg-1; Wed, 18 Sep 2024 02:26:16 -0400
X-MC-Unique: MBV1MCJ2M0SLRO3a1EFkzg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2052e7836a0so66298825ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 23:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726640775; x=1727245575;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jahyJzntoDKRbNPrHGHtQFqIQ3hKj/ql5btj5ybK2DM=;
 b=UFsR1zjJ+trYUiw9kEl853jcUwi40HUbLZC9HSNdE6MWLrwpMaD8r5xfNxwGKtXDhw
 kekkokJe9sLqalnnTN+5gWQkj2ODU6pXU/Ov1nVs+4wFbooB3eniFfU5ziz9zwprAsUw
 l2DEN86u4Xx/uKp9qFa/0sXsLqE9+Axlsgni6sewXVJBH2xcGU6w44iTBTLDY9Nqi10w
 hC706IZTsk+LlkqiPcdJHNCKN63673tDW6eWp8/7Ej0lbne0eQS+iRleKps5JcsjSV3Z
 IvMQzduqK3cDPFcg1eKn636FTrXsW809Cw1E2T8WibM1Xo+e4gRvpPvO6IGn7B7dB76g
 mhOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKsyyWcFyuNlwYX1xDSJ661YWKJ6ul8C0gTsWEMp1gW2cxOTO3Mp4bmlhnQd2TYr2kkt+EhrTJWyCG@nongnu.org
X-Gm-Message-State: AOJu0YzmfKQUmexBUl5n/J0B1kK7QnLpTcJuFb7zmTfAxnI3n/R5lSec
 pCPK9PVEVYdBbPwd2Q69YeJo1oO3avGoQBdXj56HTR5y/FD1FCm1zsm+PknJ+xfpNgOSomNOT8G
 MxG06iyDAVpb3VN+e81N7EX0+2S8BEiDbXTTrr926sct4V70sXZPl
X-Received: by 2002:a17:902:ea08:b0:207:13a3:a896 with SMTP id
 d9443c01a7336-2076e3c43dfmr398369715ad.23.1726640774869; 
 Tue, 17 Sep 2024 23:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMgPMu057OZP7sWOGgYDVwJ25ej9QXDXpnX6py9Brk0RSTumPh1FyuVxkA4QOMNYhRe0VNXg==
X-Received: by 2002:a17:902:ea08:b0:207:13a3:a896 with SMTP id
 d9443c01a7336-2076e3c43dfmr398369405ad.23.1726640774341; 
 Tue, 17 Sep 2024 23:26:14 -0700 (PDT)
Received: from smtpclient.apple ([27.6.219.91])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946d2a79sm58709595ad.159.2024.09.17.23.26.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2024 23:26:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2] memory: notify hypervisor of all eventfds during
 listener (de)registration
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ZunRZ5yA6KaNtmEA@x1n>
Date: Wed, 18 Sep 2024 11:55:59 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E451F48-F86E-41DA-A8D6-6C5426116D84@redhat.com>
References: <20240910120100.9460-1-anisinha@redhat.com> <ZunRZ5yA6KaNtmEA@x1n>
To: Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 18 Sep 2024, at 12:28=E2=80=AFAM, Peter Xu <peterx@redhat.com> =
wrote:
>=20
> Hi, Ani,
>=20
> On Tue, Sep 10, 2024 at 05:31:00PM +0530, Ani Sinha wrote:
>> When a new listener for an address space is registered, the =
hypervisor must be
>> informed of all existing eventfds for that address space by calling
>> eventfd_add() for that listener. Similarly, when a listener is =
de-registered
>> from an address space, the hypervisor must be informed of all =
existing eventfds
>> for that address space with a call to eventfd_del().
>>=20
>> Same is also true for coalesced io. Send coalesced io add/del =
listener
>> notifications if any flatrage for the address space registered with =
the
>> listener intersects with any coalesced io range.
>>=20
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> This is only to make the API clean, as I see that only kvm uses either =
of
> the features (while kvm never registers during VM running).  Am I =
right?

Yes currently there is no use case for deregistering a listener and then =
re-registering. Hence there seems to be a gap in the implementation. I =
am working on something that would require de-register and re-register =
so we will need to fix this.

>=20
> I'd like to double check whether we need to copy stable, or whether =
there's
> a real bug.

I think this is not a stable material as up until now, people will not =
hit this gap in the implementation.

>=20
>> ---
>> system/memory.c | 77 =
+++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 77 insertions(+)
>>=20
>> changelog:
>> v2: tags added, indentation fixed, commit log fixed, code cleanup.
>>=20
>> diff --git a/system/memory.c b/system/memory.c
>> index 5e6eb459d5..8379e086fb 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -941,6 +941,38 @@ static void =
flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
>>     }
>> }
>>=20
>> +static void
>> +flat_range_coalesced_io_notify_listener_add_del(FlatRange *fr,
>> +                                                MemoryRegionSection =
*mrs,
>> +                                                MemoryListener =
*listener,
>> +                                                AddressSpace *as, =
bool add)
>> +{
>> +    CoalescedMemoryRange *cmr;
>> +    MemoryRegion *mr =3D fr->mr;
>> +    AddrRange tmp;
>> +
>> +    QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
>> +        tmp =3D addrrange_shift(cmr->addr,
>> +                              int128_sub(fr->addr.start,
>> +                                         =
int128_make64(fr->offset_in_region)));
>> +
>> +        if (!addrrange_intersects(tmp, fr->addr)) {
>> +            return;
>> +        }
>> +        tmp =3D addrrange_intersection(tmp, fr->addr);
>> +
>> +        if (add) {
>=20
> Do we need to check ->coalesced_io_add !=3D NULL here?  I wonder =
whether this
> could crash if some dynamic listener got inserted (with coalesced list
> non-empty).
>=20
>> +            listener->coalesced_io_add(listener, mrs,
>> +                                       int128_get64(tmp.start),
>> +                                       int128_get64(tmp.size));
>> +        } else {
>> +            listener->coalesced_io_del(listener, mrs,
>=20
> Same.
>=20
>> +                                       int128_get64(tmp.start),
>> +                                       int128_get64(tmp.size));
>> +        }
>> +    }
>> +}
>> +
>> static void address_space_update_topology_pass(AddressSpace *as,
>>                                                const FlatView =
*old_view,
>>                                                const FlatView =
*new_view,
>> @@ -3015,8 +3047,10 @@ void memory_global_dirty_log_stop(unsigned int =
flags)
>> static void listener_add_address_space(MemoryListener *listener,
>>                                        AddressSpace *as)
>> {
>> +    unsigned i;
>>     FlatView *view;
>>     FlatRange *fr;
>> +    MemoryRegionIoeventfd *fd;
>>=20
>>     if (listener->begin) {
>>         listener->begin(listener);
>> @@ -3041,10 +3075,31 @@ static void =
listener_add_address_space(MemoryListener *listener,
>>         if (listener->region_add) {
>>             listener->region_add(listener, &section);
>>         }
>> +
>> +        /* send coalesced io add notifications */
>> +        flat_range_coalesced_io_notify_listener_add_del(fr, =
&section,
>> +                                                        listener, =
as, true);
>> +
>>         if (fr->dirty_log_mask && listener->log_start) {
>>             listener->log_start(listener, &section, 0, =
fr->dirty_log_mask);
>>         }
>>     }
>> +
>> +    /*
>> +     * register all eventfds for this address space for the newly =
registered
>> +     * listener.
>> +     */
>> +    for (i =3D 0; i < as->ioeventfd_nb; i++) {
>> +        fd =3D &as->ioeventfds[i];
>> +        MemoryRegionSection section =3D (MemoryRegionSection) {
>> +            .fv =3D address_space_to_flatview(as),
>=20
> Nitpick: I don't think it'll be anything different if we hold BQL =
anyway,
> but.. might be good to use "view" directly here, as we're holding a
> refcount there via address_space_get_flatview().
>=20
> While it's not crystal clear otherwise (when without knowing BQL held) =
that
> address_space_to_flatview() will return the same flatview.
>=20
>> +            .offset_within_address_space =3D =
int128_get64(fd->addr.start),
>> +            .size =3D fd->addr.size,
>> +        };
>> +        listener->eventfd_add(listener, &section,
>> +                              fd->match_data, fd->data, fd->e);
>=20
> Check ->eventfd_add !=3D NULL?
>=20
>> +    }
>> +
>>     if (listener->commit) {
>>         listener->commit(listener);
>>     }
>> @@ -3054,8 +3109,10 @@ static void =
listener_add_address_space(MemoryListener *listener,
>> static void listener_del_address_space(MemoryListener *listener,
>>                                        AddressSpace *as)
>> {
>> +    unsigned i;
>>     FlatView *view;
>>     FlatRange *fr;
>> +    MemoryRegionIoeventfd *fd;
>>=20
>>     if (listener->begin) {
>>         listener->begin(listener);
>> @@ -3067,10 +3124,30 @@ static void =
listener_del_address_space(MemoryListener *listener,
>>         if (fr->dirty_log_mask && listener->log_stop) {
>>             listener->log_stop(listener, &section, =
fr->dirty_log_mask, 0);
>>         }
>> +
>> +        /* send coalesced io del notifications */
>> +        flat_range_coalesced_io_notify_listener_add_del(fr, =
&section,
>> +                                                        listener, =
as, false);
>>         if (listener->region_del) {
>>             listener->region_del(listener, &section);
>>         }
>>     }
>> +
>> +    /*
>> +     * de-register all eventfds for this address space for the =
current
>> +     * listener.
>> +     */
>> +    for (i =3D 0; i < as->ioeventfd_nb; i++) {
>> +        fd =3D &as->ioeventfds[i];
>> +        MemoryRegionSection section =3D (MemoryRegionSection) {
>> +            .fv =3D address_space_to_flatview(as),
>=20
> Same.
>=20
>> +            .offset_within_address_space =3D =
int128_get64(fd->addr.start),
>> +            .size =3D fd->addr.size,
>> +        };
>> +        listener->eventfd_del(listener, &section,
>> +                              fd->match_data, fd->data, fd->e);
>=20
> Check eventfd_del !=3D NULL?
>=20
> Thanks,

All of the above suggestions are great. I will fix them in a re-spin. =
Thanks Peter.

>=20
>> +    }
>> +
>>     if (listener->commit) {
>>         listener->commit(listener);
>>     }
>> --=20
>> 2.42.0
>>=20
>=20
> --=20
> Peter Xu



