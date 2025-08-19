Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAE9CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 07:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoGVJ-0001r9-SJ; Tue, 19 Aug 2025 03:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uoGVG-0001qT-56
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 03:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uoGVC-0005Z9-7l
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 03:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755587469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edX/q2IUy4kBZZpgrgMxLBqi9yg8QZ0gzoc4NpqGp2U=;
 b=gVE31RIyVdgERoYIpM+vG/c0B40lQ9V0AjxFHgsnj9XbGadDKccpbnUT4ReeDw7aRdxwvO
 iLstFrwlIjQF117sk+WTlWTNSL6hPG9ckc+PcDgiQbsxtj7X1Qsl4RBP9n7Gm4x+/+zOpf
 howtpCqS3X2hGX2WWqFcqp/LMnMMjNw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-Rlyh_CglP0iBteGtrMb-pw-1; Tue, 19 Aug 2025 03:11:07 -0400
X-MC-Unique: Rlyh_CglP0iBteGtrMb-pw-1
X-Mimecast-MFC-AGG-ID: Rlyh_CglP0iBteGtrMb-pw_1755587466
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3235e45b815so2371852a91.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 00:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755587466; x=1756192266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edX/q2IUy4kBZZpgrgMxLBqi9yg8QZ0gzoc4NpqGp2U=;
 b=mt/uNNMqeDXAtyzXpWMEklDhEaYd+6RoK3BAmiyhby6/WHgs5WVDf8vqxgh5XBYhhx
 m/KYcqo/oDVBr80EQQvHRGpN2wW3g5EgT76KRyhwF8EopVdZnPEg9KNZuASJXU/rL5G1
 Aqk2ORd4XkBJgIS3/QAdVjadOx7NyQclnTON4KDLVpD0e1PssYLOb0yPopA3dgJ1q6lU
 x89wl7Mi/dCoU4k2nHZ7AokXDpnBM813r2/gH97TNAd7VoMBNAb8rNYf/Q83p0Xju2BS
 O8YsO8sfFGP7r7qeQUiqZ+URJdn+ZqYo3GhZmkvpKTqmkMzwofqPvLcA32Ua+ASm+H0O
 1E9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY1MLi1qaH1O7E4hDKwm8bd/YVpCyqcKr/X54Ul05vqgzyxHKnvUKJuh+OsKp7WeYZp/aRV7KD2BKe@nongnu.org
X-Gm-Message-State: AOJu0YxWDCxGBBdOLB6JujsV/euekcKr7Q+4nQ8PnG08oP00Ku8bkHG5
 FqFEHhBq90/yEV3HKf+T9orifXh6O4FMc5MrzslLR0YpY/lacU348VySm+9B8YG3opXLmvu9uy4
 nRYJFkAUcJRfxbO/XzNDloV4lXNjkflL0v7BnyGLMCBQhtUYG70BCCPt4b9viN94N6nGweIEtDQ
 f05543EY1en1usHCjFznncmJ46M05guEU=
X-Gm-Gg: ASbGncsvIGpndYToZFxGfJd+HtBz85OumD8OyUG6n4k0pS0jTD24GisMvYC3yQelvab
 UM6Y/kHNvPyhV1rcvCH8W12siiEIQzf2yqLbMSTdBtAOxa3H2XvvF0uePbZUj9LX2RtgNXRP5bR
 4myEWiGtCwOnkaxRUHz86X
X-Received: by 2002:a17:90b:3ecb:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-3245e5924bemr2607882a91.12.1755587466241; 
 Tue, 19 Aug 2025 00:11:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNafbHN9sjw3TASuKduKDwND0bZ3c57wQ/DjDlhhiRdYYM4cG1Gn047lbSkmqqDOk3JW0wbbTorJPLhgzkKbc=
X-Received: by 2002:a17:90b:3ecb:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-3245e5924bemr2607841a91.12.1755587465677; Tue, 19 Aug 2025
 00:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com> <aJOCiUPp0dckmgAn@x1.local>
 <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com> <aJTU641465aGKWRU@x1.local>
 <0cf99747-443e-4a29-a0da-64012548a994@oracle.com> <aJnydjxFzKwVzi7Y@x1.local>
 <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com> <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
 <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
 <CAJaqyWfc3G5NLnxqXvZFxw2aRnVvOcZbLds5LHzcdoLjVGmOsw@mail.gmail.com>
 <c5b97e10-a8bb-4d59-b509-734eab7d5be3@oracle.com>
In-Reply-To: <c5b97e10-a8bb-4d59-b509-734eab7d5be3@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 19 Aug 2025 09:10:29 +0200
X-Gm-Features: Ac12FXz19iMm6gHAuQ0wzCajOMtfNs9Pvdc6PPktYsR-mp2a999GP83CcmPaKis
Message-ID: <CAJaqyWc-vKsqs2boiktJn_cO3fSVk=-EfP3G8QN-z=n59VCoHA@mail.gmail.com>
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de, 
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, 
 Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Mon, Aug 18, 2025 at 4:46=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 8/18/25 2:51 AM, Eugenio Perez Martin wrote:
> > On Fri, Aug 15, 2025 at 4:50=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >>
> >>
> >> On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
> >>> On Wed, Aug 13, 2025 at 4:06=E2=80=AFPM Peter Xu <peterx@redhat.com> =
wrote:
> >>>>
> >>>> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote=
:
> >>>>> On Mon, Aug 11, 2025 at 11:56=E2=80=AFPM Peter Xu <peterx@redhat.co=
m> wrote:
> >>>>>>
> >>>>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
> >>>>>>> This effort was started to reduce the guest visible downtime by
> >>>>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especially
> >>>>>>> vhost-vDPA.
> >>>>>>>
> >>>>>>> The downtime contributed by vhost-vDPA, for example, is not from =
having to
> >>>>>>> migrate a lot of state but rather expensive backend control-plane=
 latency
> >>>>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filte=
rs, offload
> >>>>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC operation=
s which
> >>>>>>> dominates its downtime.
> >>>>>>>
> >>>>>>> In other words, by migrating the state of virtio-net early (befor=
e the
> >>>>>>> stop-and-copy phase), we can also start staging backend configura=
tions,
> >>>>>>> which is the main contributor of downtime when migrating a vhost-=
vDPA
> >>>>>>> device.
> >>>>>>>
> >>>>>>> I apologize if this series gives the impression that we're migrat=
ing a lot
> >>>>>>> of data here. It's more along the lines of moving control-plane l=
atency out
> >>>>>>> of the stop-and-copy phase.
> >>>>>>
> >>>>>> I see, thanks.
> >>>>>>
> >>>>>> Please add these into the cover letter of the next post.  IMHO it'=
s
> >>>>>> extremely important information to explain the real goal of this w=
ork.  I
> >>>>>> bet it is not expected for most people when reading the current co=
ver
> >>>>>> letter.
> >>>>>>
> >>>>>> Then it could have nothing to do with iterative phase, am I right?
> >>>>>>
> >>>>>> What are the data needed for the dest QEMU to start staging backen=
d
> >>>>>> configurations to the HWs underneath?  Does dest QEMU already have=
 them in
> >>>>>> the cmdlines?
> >>>>>>
> >>>>>> Asking this because I want to know whether it can be done complete=
ly
> >>>>>> without src QEMU at all, e.g. when dest QEMU starts.
> >>>>>>
> >>>>>> If src QEMU's data is still needed, please also first consider pro=
viding
> >>>>>> such facility using an "early VMSD" if it is ever possible: feel f=
ree to
> >>>>>> refer to commit 3b95a71b22827d26178.
> >>>>>>
> >>>>>
> >>>>> While it works for this series, it does not allow to resend the sta=
te
> >>>>> when the src device changes. For example, if the number of virtqueu=
es
> >>>>> is modified.
> >>>>
> >>>> Some explanation on "how sync number of vqueues helps downtime" woul=
d help.
> >>>> Not "it might preheat things", but exactly why, and how that differs=
 when
> >>>> it's pure software, and when hardware will be involved.
> >>>>
> >>>
> >>> By nvidia engineers to configure vqs (number, size, RSS, etc) takes
> >>> about ~200ms:
> >>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8ebb=
97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGaBl=
bXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA$
> >>>
> >>> Adding Dragos here in case he can provide more details. Maybe the
> >>> numbers have changed though.
> >>>
> >>> And I guess the difference with pure SW will always come down to PCI
> >>> communications, which assume it is slower than configuring the host S=
W
> >>> device in RAM or even CPU cache. But I admin that proper profiling is
> >>> needed before making those claims.
> >>>
> >>> Jonah, can you print the time it takes to configure the vDPA device
> >>> with traces vs the time it takes to enable the dataplane of the
> >>> device? So we can get an idea of how much time we save with this.
> >>>
> >>
> >> Let me know if this isn't what you're looking for.
> >>
> >> I'm assuming by "configuration time" you mean:
> >>    - Time from device startup (entry to vhost_vdpa_dev_start()) to rig=
ht
> >>      before we start enabling the vrings (e.g.
> >>      VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
> >>
> >> And by "time taken to enable the dataplane" I'm assuming you mean:
> >>    - Time right before we start enabling the vrings (see above) to rig=
ht
> >>      after we enable the last vring (at the end of
> >>      vhost_vdpa_net_cvq_load())
> >>
> >> Guest specs: 128G Mem, SVQ=3Don, CVQ=3Don, 8 queue pairs:
> >>
> >> -netdev type=3Dvhost-vdpa,vhostdev=3D$VHOST_VDPA_0,id=3Dvhost-vdpa0,
> >>           queues=3D8,x-svq=3Don
> >>
> >> -device virtio-net-pci,netdev=3Dvhost-vdpa0,id=3Dvdpa0,bootindex=3D-1,
> >>           romfile=3D,page-per-vq=3Don,mac=3D$VF1_MAC,ctrl_vq=3Don,mq=
=3Don,
> >>           ctrl_vlan=3Doff,vectors=3D18,host_mtu=3D9000,
> >>           disable-legacy=3Don,disable-modern=3Doff
> >>
> >> ---
> >>
> >> Configuration time:    ~31s
> >> Dataplane enable time: ~0.14ms
> >>
> >
> > I was vague, but yes, that's representative enough! It would be more
> > accurate if the configuration time ends by the time QEMU enables the
> > first queue of the dataplane though.
> >
> > As Si-Wei mentions, is v->shared->listener_registered =3D=3D true at th=
e
> > beginning of vhost_vdpa_dev_start?
> >
>
> Ah, I also realized that Qemu I was using for measurements was using a
> version before the listener_registered member was introduced.
>
> I retested with the latest changes in Qemu and set x-svq=3Doff, e.g.:
> guest specs: 128G Mem, SVQ=3Doff, CVQ=3Don, 8 queue pairs. I ran testing =
3
> times for measurements.
>
> v->shared->listener_registered =3D=3D false at the beginning of
> vhost_vdpa_dev_start().
>

Let's move out the effect of the mem pinning from the downtime by
registering the listener before the migration. Can you check why is it
not registered at vhost_vdpa_set_owner?

> ---
>
> Configuration time: Time from first entry into vhost_vdpa_dev_start() to
> right after Qemu enables the first VQ.
>   - 26.947s, 26.606s, 27.326s
>
> Enable dataplane: Time from right after first VQ is enabled to right
> after the last VQ is enabled.
>   - 0.081ms, 0.081ms, 0.079ms
>


