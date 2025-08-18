Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39929CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 06:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1untjb-0000U3-9L; Mon, 18 Aug 2025 02:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1untjU-0000Sv-Ch
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1untjQ-0002a5-9z
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755499953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gObsC1Epjom/aX/U9/ZtS9OPPg9usvJ3m2vdTBaIw6M=;
 b=EAxrQ17BmgIHty5Tpdrw0YxTp51id9Fn+wlSF5jXVhS8my0vdAadnhyhJMC+3CSL0omDy+
 wUld5WjDCZXYTLJ66wkoUSdjD6dn2CrAxkXdrLzb2fEU1oOdHyy5/jVoCUtjH0cN98ZaTH
 GDpaHdOcy6f4qHYBzgSg4pfr3CRrKD0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-RpyzIPi9Mjm5d6LIU5dC4A-1; Mon, 18 Aug 2025 02:52:31 -0400
X-MC-Unique: RpyzIPi9Mjm5d6LIU5dC4A-1
X-Mimecast-MFC-AGG-ID: RpyzIPi9Mjm5d6LIU5dC4A_1755499950
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-323266dcf3bso3406623a91.0
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 23:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755499950; x=1756104750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gObsC1Epjom/aX/U9/ZtS9OPPg9usvJ3m2vdTBaIw6M=;
 b=gKslFwAD6mB/FlzPOtv5Y7iokGvn3J1p3y3r6JsVh4d3QQrauiwzJjPuQxuTkefBuG
 Bm3PbY1gQ6OlFuKRB1fm2SImFeFFvLK8oXonbFaJ6llWZxtQqJWW6oaC+zaYabdfD/7k
 YEwrDoj3ctu88ajl3++6uUUiklVJ5j2zEZCXbjPCibgS8Po+qOD8nCf4FsUciYayj1Qy
 cHaKEecP9eTe0zuBBNQelcxQY7GtTFV3eMrh4AmKoXbCqTAM+9VsI7y3GGX8IpZGQ3Jz
 HKg2wSekLt00A6VSQROcpe169bgbIET11cNjBvMQUmQv+goysIeeBIxxUiKik6p31mUd
 BrZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOjniKYyJQ9KmEXiuDpgyphboriwG+Kc9uEl3ZJC4PTxOI2rtPRxf9kVs95KDb7iFOy1I+F7bWsLpY@nongnu.org
X-Gm-Message-State: AOJu0YyOtbOwA5MZLox2nv2H17UIRFeODEbzJt26hyy2pvXpxgRujaLj
 6naFaqw3mLtCSmQKzkNDGoyCVw9A/E5YopZ4up7tL1piHreGmhDwyESkNtuHjhk/Qd6ip5l+urI
 LUkSIOji9QMAWTpQqOgOYcdlAKxt0sEU10wVDIQOUOXSOYfng20dsZ8ldrV2gAjliWOt2pN0QjD
 i9YoSegqFChSXj/Ps1QCD+SZXtG2I9dLI=
X-Gm-Gg: ASbGncvt9jeAYRIjnK4OH3uFTJm7nilm/TOGjUNO/ji1MfiitTvJRJWDSxTDuMxWK0H
 ow9qV8JTwLXvBZOeMZUMuL0k4Ei2odNTymEbtwjYDLQW2mLInNr3tmYNbyWADNtZ9ZErv3IVO5Z
 f6Q0fvi7oGuk5i9bHb/aTV
X-Received: by 2002:a17:90b:3849:b0:31f:d0:95bc with SMTP id
 98e67ed59e1d1-323422386bbmr13927825a91.25.1755499950331; 
 Sun, 17 Aug 2025 23:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2iRAYni8QEdwk8dwL/rgGEiyoihU3+rcv+GMQJKzbzEk8vQzikJXXwgjT/qCn0qRd+xPdWFMB1nL/yDBAVa4=
X-Received: by 2002:a17:90b:3849:b0:31f:d0:95bc with SMTP id
 98e67ed59e1d1-323422386bbmr13927806a91.25.1755499949855; Sun, 17 Aug 2025
 23:52:29 -0700 (PDT)
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
In-Reply-To: <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 18 Aug 2025 08:51:52 +0200
X-Gm-Features: Ac12FXzui7Fy_TtEZQQz7UFdFm_zwBuR_6FVML6BBLgPeOQRQ20X0ZNd3WYvfUA
Message-ID: <CAJaqyWfc3G5NLnxqXvZFxw2aRnVvOcZbLds5LHzcdoLjVGmOsw@mail.gmail.com>
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
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Aug 15, 2025 at 4:50=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
> > On Wed, Aug 13, 2025 at 4:06=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> >>
> >> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
> >>> On Mon, Aug 11, 2025 at 11:56=E2=80=AFPM Peter Xu <peterx@redhat.com>=
 wrote:
> >>>>
> >>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
> >>>>> This effort was started to reduce the guest visible downtime by
> >>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especially
> >>>>> vhost-vDPA.
> >>>>>
> >>>>> The downtime contributed by vhost-vDPA, for example, is not from ha=
ving to
> >>>>> migrate a lot of state but rather expensive backend control-plane l=
atency
> >>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters=
, offload
> >>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC operations =
which
> >>>>> dominates its downtime.
> >>>>>
> >>>>> In other words, by migrating the state of virtio-net early (before =
the
> >>>>> stop-and-copy phase), we can also start staging backend configurati=
ons,
> >>>>> which is the main contributor of downtime when migrating a vhost-vD=
PA
> >>>>> device.
> >>>>>
> >>>>> I apologize if this series gives the impression that we're migratin=
g a lot
> >>>>> of data here. It's more along the lines of moving control-plane lat=
ency out
> >>>>> of the stop-and-copy phase.
> >>>>
> >>>> I see, thanks.
> >>>>
> >>>> Please add these into the cover letter of the next post.  IMHO it's
> >>>> extremely important information to explain the real goal of this wor=
k.  I
> >>>> bet it is not expected for most people when reading the current cove=
r
> >>>> letter.
> >>>>
> >>>> Then it could have nothing to do with iterative phase, am I right?
> >>>>
> >>>> What are the data needed for the dest QEMU to start staging backend
> >>>> configurations to the HWs underneath?  Does dest QEMU already have t=
hem in
> >>>> the cmdlines?
> >>>>
> >>>> Asking this because I want to know whether it can be done completely
> >>>> without src QEMU at all, e.g. when dest QEMU starts.
> >>>>
> >>>> If src QEMU's data is still needed, please also first consider provi=
ding
> >>>> such facility using an "early VMSD" if it is ever possible: feel fre=
e to
> >>>> refer to commit 3b95a71b22827d26178.
> >>>>
> >>>
> >>> While it works for this series, it does not allow to resend the state
> >>> when the src device changes. For example, if the number of virtqueues
> >>> is modified.
> >>
> >> Some explanation on "how sync number of vqueues helps downtime" would =
help.
> >> Not "it might preheat things", but exactly why, and how that differs w=
hen
> >> it's pure software, and when hardware will be involved.
> >>
> >
> > By nvidia engineers to configure vqs (number, size, RSS, etc) takes
> > about ~200ms:
> > https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8ebb97=
-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGaBlbX=
hcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA$
> >
> > Adding Dragos here in case he can provide more details. Maybe the
> > numbers have changed though.
> >
> > And I guess the difference with pure SW will always come down to PCI
> > communications, which assume it is slower than configuring the host SW
> > device in RAM or even CPU cache. But I admin that proper profiling is
> > needed before making those claims.
> >
> > Jonah, can you print the time it takes to configure the vDPA device
> > with traces vs the time it takes to enable the dataplane of the
> > device? So we can get an idea of how much time we save with this.
> >
>
> Let me know if this isn't what you're looking for.
>
> I'm assuming by "configuration time" you mean:
>   - Time from device startup (entry to vhost_vdpa_dev_start()) to right
>     before we start enabling the vrings (e.g.
>     VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
>
> And by "time taken to enable the dataplane" I'm assuming you mean:
>   - Time right before we start enabling the vrings (see above) to right
>     after we enable the last vring (at the end of
>     vhost_vdpa_net_cvq_load())
>
> Guest specs: 128G Mem, SVQ=3Don, CVQ=3Don, 8 queue pairs:
>
> -netdev type=3Dvhost-vdpa,vhostdev=3D$VHOST_VDPA_0,id=3Dvhost-vdpa0,
>          queues=3D8,x-svq=3Don
>
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,id=3Dvdpa0,bootindex=3D-1,
>          romfile=3D,page-per-vq=3Don,mac=3D$VF1_MAC,ctrl_vq=3Don,mq=3Don,
>          ctrl_vlan=3Doff,vectors=3D18,host_mtu=3D9000,
>          disable-legacy=3Don,disable-modern=3Doff
>
> ---
>
> Configuration time:    ~31s
> Dataplane enable time: ~0.14ms
>

I was vague, but yes, that's representative enough! It would be more
accurate if the configuration time ends by the time QEMU enables the
first queue of the dataplane though.

As Si-Wei mentions, is v->shared->listener_registered =3D=3D true at the
beginning of vhost_vdpa_dev_start?


