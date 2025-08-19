Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B390CCA0EED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 07:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoGej-0003dd-LB; Tue, 19 Aug 2025 03:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uoGeh-0003dO-8v
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 03:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uoGee-0006jU-HT
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 03:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755588069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MHDUDI3E7tfLDztDjRyvWcgFW5rIBQmCR0B1Vgts0Q=;
 b=OiHLkstOHy37EP9SC7sCwNQMhFm5hWhbnBBb8G6vfAzh0oayggakz8jXiM0AGj2aNeMaxX
 U/GRqud7+F6Rk2TpRqy41jyw4BEkKVvsWuOxawEwI5nt0xwRYJUk3mCyqOp0mbTxCo/KU3
 lC4armK854hvL87nLzZeVRrgcdbYgLk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-8EGEa6GEPwaYZxzNwmoVgQ-1; Tue, 19 Aug 2025 03:21:07 -0400
X-MC-Unique: 8EGEa6GEPwaYZxzNwmoVgQ-1
X-Mimecast-MFC-AGG-ID: 8EGEa6GEPwaYZxzNwmoVgQ_1755588066
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-323266d8396so4604189a91.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 00:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755588066; x=1756192866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MHDUDI3E7tfLDztDjRyvWcgFW5rIBQmCR0B1Vgts0Q=;
 b=Ftlz82bNnXzkL2Za7npswt5U8dX0bTCNYAoZ4Z54X0kjEfgP+R/JG6H5kl3gJc4OoC
 F7id+WCwSp4hlPTs24KrBqACDiG74DNO0AZ07uFtD94IB0DpVGRTP+EP7wk9k28484Xx
 CI9X6hCgXM+j14XNypaVVAyJxs9MDfmFzXrd/xbOC45gKOJLAracL5gePFOinqREAEii
 S5t2f0DakRKI1Njr4R19FWCREn3qcOi3TTIJ00qXRklQhxrmqNiQYUX3gqUOSMIjOLGw
 YnqGAJm66hV7WDKRTGewu0rACH/aclaL3PpICv7bYBTuxLOLJZO5njacVMBHWycJwzsX
 Em8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFdgkSRduP5mEmXyufC5KchFY+DcZXOT9WtZq6yYDmIJwSOnUNLpyz1PGjJn/ZkbCAHpZG9eQIGV+M@nongnu.org
X-Gm-Message-State: AOJu0Yxo+LNNI26qu81Yi53i061u3Wa9Wau46/LzIL9NECs13bZ5VyLO
 4hh9xrzUeE2or0K/1lpqH7D3sbCJxxkpIf81pjZfSnSvNHW50Zegy3AXxHQnZeBwBm2S6EnzKlW
 bsMVNH+7Mjl6Xu2h4ZtbHYP7QtZwPtUFronJsOo6XzgEShFfiv43bVeJqrXbZYx5s0EUy/a0V/F
 I46E/RhM9PS14OxmlW7JmMUOTsn5RyyugnqAnMnfWCFA==
X-Gm-Gg: ASbGnctkIoMpLGkFuSMwJeFde1ez1BkiKG9hNkRXJ/zMn/oxukSS8+I6Sxh927R2s9a
 9EeceN8h+1yJi/fHA6cafi7Xf1HrEZtgY19tZQE7Tmk/UgP9OgqcquHjJ12h4Q6vHMNfxdPpT1K
 aEWoHW7F0/+JSJmBkM4/8k
X-Received: by 2002:a17:90b:3f4b:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-32476a480c6mr2161502a91.5.1755588065726; 
 Tue, 19 Aug 2025 00:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9xdVLHSMqhG/HgMU8vOf88MYRzPcfL4vyZHx9oC9L1ZJDuTfWeA83unGVcmPPvh+ye+At+mbXaQmNtEbHguk=
X-Received: by 2002:a17:90b:3f4b:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-32476a480c6mr2161464a91.5.1755588065086; Tue, 19 Aug 2025
 00:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local> <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
 <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
 <CAJaqyWfc3G5NLnxqXvZFxw2aRnVvOcZbLds5LHzcdoLjVGmOsw@mail.gmail.com>
 <c5b97e10-a8bb-4d59-b509-734eab7d5be3@oracle.com> <aKNTC_Q93ME1rgyI@x1.local>
In-Reply-To: <aKNTC_Q93ME1rgyI@x1.local>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 19 Aug 2025 09:20:28 +0200
X-Gm-Features: Ac12FXy7uCiG5uQwfrp9ROOELtnQnrIKUJdC8zrC-jSzS-QJj5Cdq-tJDonuyuM
Message-ID: <CAJaqyWcUdtW-k7dCsi+4Q66V+JzO4t6iQxYqJ_bOAYZ=yKkDaw@mail.gmail.com>
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Peter Xu <peterx@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 farosas@suse.de, 
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

On Mon, Aug 18, 2025 at 6:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Aug 18, 2025 at 10:46:00AM -0400, Jonah Palmer wrote:
> >
> >
> > On 8/18/25 2:51 AM, Eugenio Perez Martin wrote:
> > > On Fri, Aug 15, 2025 at 4:50=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> > > >
> > > >
> > > >
> > > > On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
> > > > > On Wed, Aug 13, 2025 at 4:06=E2=80=AFPM Peter Xu <peterx@redhat.c=
om> wrote:
> > > > > >
> > > > > > On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > On Mon, Aug 11, 2025 at 11:56=E2=80=AFPM Peter Xu <peterx@red=
hat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrot=
e:
> > > > > > > > > This effort was started to reduce the guest visible downt=
ime by
> > > > > > > > > virtio-net/vhost-net/vhost-vDPA during live migration, es=
pecially
> > > > > > > > > vhost-vDPA.
> > > > > > > > >
> > > > > > > > > The downtime contributed by vhost-vDPA, for example, is n=
ot from having to
> > > > > > > > > migrate a lot of state but rather expensive backend contr=
ol-plane latency
> > > > > > > > > like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VL=
AN filters, offload
> > > > > > > > > settings, MTU, etc.). Doing this requires kernel/HW NIC o=
perations which
> > > > > > > > > dominates its downtime.
> > > > > > > > >
> > > > > > > > > In other words, by migrating the state of virtio-net earl=
y (before the
> > > > > > > > > stop-and-copy phase), we can also start staging backend c=
onfigurations,
> > > > > > > > > which is the main contributor of downtime when migrating =
a vhost-vDPA
> > > > > > > > > device.
> > > > > > > > >
> > > > > > > > > I apologize if this series gives the impression that we'r=
e migrating a lot
> > > > > > > > > of data here. It's more along the lines of moving control=
-plane latency out
> > > > > > > > > of the stop-and-copy phase.
> > > > > > > >
> > > > > > > > I see, thanks.
> > > > > > > >
> > > > > > > > Please add these into the cover letter of the next post.  I=
MHO it's
> > > > > > > > extremely important information to explain the real goal of=
 this work.  I
> > > > > > > > bet it is not expected for most people when reading the cur=
rent cover
> > > > > > > > letter.
> > > > > > > >
> > > > > > > > Then it could have nothing to do with iterative phase, am I=
 right?
> > > > > > > >
> > > > > > > > What are the data needed for the dest QEMU to start staging=
 backend
> > > > > > > > configurations to the HWs underneath?  Does dest QEMU alrea=
dy have them in
> > > > > > > > the cmdlines?
> > > > > > > >
> > > > > > > > Asking this because I want to know whether it can be done c=
ompletely
> > > > > > > > without src QEMU at all, e.g. when dest QEMU starts.
> > > > > > > >
> > > > > > > > If src QEMU's data is still needed, please also first consi=
der providing
> > > > > > > > such facility using an "early VMSD" if it is ever possible:=
 feel free to
> > > > > > > > refer to commit 3b95a71b22827d26178.
> > > > > > > >
> > > > > > >
> > > > > > > While it works for this series, it does not allow to resend t=
he state
> > > > > > > when the src device changes. For example, if the number of vi=
rtqueues
> > > > > > > is modified.
> > > > > >
> > > > > > Some explanation on "how sync number of vqueues helps downtime"=
 would help.
> > > > > > Not "it might preheat things", but exactly why, and how that di=
ffers when
> > > > > > it's pure software, and when hardware will be involved.
> > > > > >
> > > > >
> > > > > By nvidia engineers to configure vqs (number, size, RSS, etc) tak=
es
> > > > > about ~200ms:
> > > > > https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c=
8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7s=
GaBlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2=
pA$
> > > > >
> > > > > Adding Dragos here in case he can provide more details. Maybe the
> > > > > numbers have changed though.
> > > > >
> > > > > And I guess the difference with pure SW will always come down to =
PCI
> > > > > communications, which assume it is slower than configuring the ho=
st SW
> > > > > device in RAM or even CPU cache. But I admin that proper profilin=
g is
> > > > > needed before making those claims.
> > > > >
> > > > > Jonah, can you print the time it takes to configure the vDPA devi=
ce
> > > > > with traces vs the time it takes to enable the dataplane of the
> > > > > device? So we can get an idea of how much time we save with this.
> > > > >
> > > >
> > > > Let me know if this isn't what you're looking for.
> > > >
> > > > I'm assuming by "configuration time" you mean:
> > > >    - Time from device startup (entry to vhost_vdpa_dev_start()) to =
right
> > > >      before we start enabling the vrings (e.g.
> > > >      VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
> > > >
> > > > And by "time taken to enable the dataplane" I'm assuming you mean:
> > > >    - Time right before we start enabling the vrings (see above) to =
right
> > > >      after we enable the last vring (at the end of
> > > >      vhost_vdpa_net_cvq_load())
> > > >
> > > > Guest specs: 128G Mem, SVQ=3Don, CVQ=3Don, 8 queue pairs:
> > > >
> > > > -netdev type=3Dvhost-vdpa,vhostdev=3D$VHOST_VDPA_0,id=3Dvhost-vdpa0=
,
> > > >           queues=3D8,x-svq=3Don
> > > >
> > > > -device virtio-net-pci,netdev=3Dvhost-vdpa0,id=3Dvdpa0,bootindex=3D=
-1,
> > > >           romfile=3D,page-per-vq=3Don,mac=3D$VF1_MAC,ctrl_vq=3Don,m=
q=3Don,
> > > >           ctrl_vlan=3Doff,vectors=3D18,host_mtu=3D9000,
> > > >           disable-legacy=3Don,disable-modern=3Doff
> > > >
> > > > ---
> > > >
> > > > Configuration time:    ~31s
> > > > Dataplane enable time: ~0.14ms
> > > >
> > >
> > > I was vague, but yes, that's representative enough! It would be more
> > > accurate if the configuration time ends by the time QEMU enables the
> > > first queue of the dataplane though.
> > >
> > > As Si-Wei mentions, is v->shared->listener_registered =3D=3D true at =
the
> > > beginning of vhost_vdpa_dev_start?
> > >
> >
> > Ah, I also realized that Qemu I was using for measurements was using a
> > version before the listener_registered member was introduced.
> >
> > I retested with the latest changes in Qemu and set x-svq=3Doff, e.g.: g=
uest
> > specs: 128G Mem, SVQ=3Doff, CVQ=3Don, 8 queue pairs. I ran testing 3 ti=
mes for
> > measurements.
> >
> > v->shared->listener_registered =3D=3D false at the beginning of
> > vhost_vdpa_dev_start().
> >
> > ---
> >
> > Configuration time: Time from first entry into vhost_vdpa_dev_start() t=
o
> > right after Qemu enables the first VQ.
> >  - 26.947s, 26.606s, 27.326s
>
> It's surprising to know it takes 20+ seconds for one device to load.
>
> Sorry I'm not familiar with CVQ, please bare with me on my ignorance: how
> much CVQ=3Don contributes to this?  Is page pinning involved here?  Is 12=
8GB
> using small pages only?
>

CVQ=3Don is just enabled so we can enable multiqueue, as the HW device
configuration time seems ~linear with this.

> It looks to me there can still be many things that vDPA will face similar
> challenges that VFIO already had.  For example, there's current work
> optimizing pinning for VFIO here:
>
> https://lore.kernel.org/all/20250814064714.56485-1-lizhe.67@bytedance.com=
/
>
> For the long term, not sure if (for either VFIO or vDPA, or similar devic=
es
> that needs guest pinning) it would make more sense to start using 1G huge
> pages just for the sake of fast pinning.
>
> PFNMAP in VFIO already works with 1G pfnmaps with commit eb996eec783c.
> Logically if we could use 1G pages (e.g. on x86_64) for guest, then pinni=
ng
> / unpinning can also be easily batched, and DMA pinning should be much
> faster.  The same logic may also apply to vDPA if it works the similar wa=
y.
>
> The work above was still generic, but I mentioned the idea of optimizing
> for 1G huge pages here:
>
> https://lore.kernel.org/all/aC3z_gUxJbY1_JP7@x1.local/#t
>
> Above is just FYI.. definitely not an request to work on that.  So if we
> can better split the issue into smaller but multiple scope of works it
> would be nicer.

I agree. QEMU master is already able to do the memory pinning before
the downtime, so let's profile that way.

> The "iterable migratable virtio-net" might just hide too
> many things under the hood.
>
> >
> > Enable dataplane: Time from right after first VQ is enabled to right af=
ter
> > the last VQ is enabled.
> >  - 0.081ms, 0.081ms, 0.079ms
> >
>
> The other thing that might worth mention.. from migration perspective, VF=
IO
> used to introduce one feature called switchover-ack:
>
> # @switchover-ack: If enabled, migration will not stop the source VM
> #     and complete the migration until an ACK is received from the
> #     destination that it's OK to do so.  Exactly when this ACK is
> #     sent depends on the migrated devices that use this feature.  For
> #     example, a device can use it to make sure some of its data is
> #     sent and loaded in the destination before doing switchover.
> #     This can reduce downtime if devices that support this capability
> #     are present.  'return-path' capability must be enabled to use
> #     it.  (since 8.1)
>
> If above 20+ seconds are not avoidable, not sure if virtio-net would like
> to opt-in in this feature too, so that switchover won't happen too soon
> during an pre-mature preheat, so that won't be accounted into downtime.
>
> Again, just FYI. I'm not sure if it's applicable.
>

Yes it is, my first versions used it :). As you said, maybe we need to
use it here so it is worth it to not miss it!


