Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764EDCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyVB-0004at-P7; Mon, 01 Sep 2025 02:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1usyV5-0004WX-Sp
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1usyUz-0005NM-8R
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756709915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmCYdcncJfYDmTRmMQRrrwAj1HsDD8rjoZ1tpmT0Md0=;
 b=aNPgQaRk/v/Bc49VFVZHSAZYQ90Z8IP4Q7pg0mRmabXYx7DyQVkzcXWDrHKwC+7Dmkc59B
 YNYiZUfI/CxMtMJDp6loBGjtqENXjug3aOSzjfH9TFZRgK8L1ePrnNg2o3Tiq/PBRxxncR
 xY/2yx/rdhJv/SMcCWo+YX5WLUZHtks=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-ruxps9cSNVe3wmqFfzdIzA-1; Mon, 01 Sep 2025 02:58:34 -0400
X-MC-Unique: ruxps9cSNVe3wmqFfzdIzA-1
X-Mimecast-MFC-AGG-ID: ruxps9cSNVe3wmqFfzdIzA_1756709913
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-329745d6b89so2575133a91.1
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709913; x=1757314713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmCYdcncJfYDmTRmMQRrrwAj1HsDD8rjoZ1tpmT0Md0=;
 b=IlkgtsVQu9d/mCa3LbCHO9OTvmmEckC3RwTFX/2dTvb4aNk/qIpy0bDs5mmEqVPxZJ
 cq60RqmXU9RgkiuflABjMn+N1qleqtYN117lcMeqq7qLWcD2Sal1o9rkqBw1DLVg2W+S
 ofP0Iyx0UESToJFPhcvEiNp8K75IpDFN0e2IIz8q8S8YRFV+fkHcdOBVFrMGC5/5N579
 q8cYHIEUme/t6T8mKpysRMSfBgTZh++lzC4ltHNd80AwQEOcOmuZ5HcpnpURu9hqBN1Q
 VxQVcboGKrsixZ7EyUzL4y08IL4ZmPI8Yc+YoS08mMVxGWGMA6maP0AVREdmQXrA4o3z
 XtxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk3j9iU9bkbrJS9Q8sSCWvfsV6O4fKje4mrYHweJlnrZD/QyOxDxgt5OXVyvJ7r2n19twO3EytYMaa@nongnu.org
X-Gm-Message-State: AOJu0YwFCYPIvGtWS7rKiSEnOoQp5O6zznacD4MRgarOYEy6ekS50Ujv
 PCVKd1Ig9bOWMdtNVzT8NTHxSi2zfwxYRFwsiF0iOTb7+rMXuA5zXBDbrbKV5ZVnDU4TR4NhR5Y
 mngx/gqPxfIvchBlhG4l4SnnN/rMAvtTnx5gi7iF+q1DBNZyizFxLsz57soJRvOQNr0Z9EZrRp6
 Pn9zln6V3ylY07nXp3v0hb0lnQg2DR/dA=
X-Gm-Gg: ASbGnctDk8+UncXI4rjFVnoNHCExa4AE1d+boLrxyD8pUGGayHDoHSY/Wj8/BbwGqbg
 cW/QkuKCsKSGWffZNaGpSwBX4TjPirhnB1etgfKfMHt7jlphf1AALdXrWUOTb3mfLok47Bbp/Vt
 KAcH1O5CUf76+3h3iWofU=
X-Received: by 2002:a17:90b:1c08:b0:327:d564:ccb0 with SMTP id
 98e67ed59e1d1-328156e1783mr9109116a91.26.1756709913031; 
 Sun, 31 Aug 2025 23:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1Xt/nh6ma4GjDB9VMnd93FGI+zQ9uhkADlQjDnkPH2XBmja21Jcq+VNhDNirxY5vZOv0Hozdm/0j4awL5Olo=
X-Received: by 2002:a17:90b:1c08:b0:327:d564:ccb0 with SMTP id
 98e67ed59e1d1-328156e1783mr9109082a91.26.1756709912456; Sun, 31 Aug 2025
 23:58:32 -0700 (PDT)
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
 <CAJaqyWc-vKsqs2boiktJn_cO3fSVk=-EfP3G8QN-z=n59VCoHA@mail.gmail.com>
 <4f067326-6c80-4768-886b-2b819e7184d3@oracle.com>
 <CAJaqyWcNdPyrAmRMBgdEk3o4AR1kK6ZiHWdY6q4MuwvGgjub8Q@mail.gmail.com>
 <f143a9a6-56b5-43a8-bced-bec7c7be8a2d@oracle.com>
In-Reply-To: <f143a9a6-56b5-43a8-bced-bec7c7be8a2d@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 1 Sep 2025 08:57:56 +0200
X-Gm-Features: Ac12FXzDqhfBK59sc6gn9Mrc5BiuSIZ95bFc_O_LHpMdsdq1q91OffvxUZdWMb4
Message-ID: <CAJaqyWdRgbuEgWA8OcCfvgJ_ZC-OKHg2oGkirXkfaG2QBankpQ@mail.gmail.com>
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, si-wei.liu@oracle.com, qemu-devel@nongnu.org,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com, 
 mst@redhat.com, boris.ostrovsky@oracle.com, 
 Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Wed, Aug 27, 2025 at 6:56=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 8/20/25 3:59 AM, Eugenio Perez Martin wrote:
> > On Tue, Aug 19, 2025 at 5:11=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >>
> >>
> >> On 8/19/25 3:10 AM, Eugenio Perez Martin wrote:
> >>> On Mon, Aug 18, 2025 at 4:46=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 8/18/25 2:51 AM, Eugenio Perez Martin wrote:
> >>>>> On Fri, Aug 15, 2025 at 4:50=E2=80=AFPM Jonah Palmer <jonah.palmer@=
oracle.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
> >>>>>>> On Wed, Aug 13, 2025 at 4:06=E2=80=AFPM Peter Xu <peterx@redhat.c=
om> wrote:
> >>>>>>>>
> >>>>>>>> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin w=
rote:
> >>>>>>>>> On Mon, Aug 11, 2025 at 11:56=E2=80=AFPM Peter Xu <peterx@redha=
t.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
> >>>>>>>>>>> This effort was started to reduce the guest visible downtime =
by
> >>>>>>>>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especi=
ally
> >>>>>>>>>>> vhost-vDPA.
> >>>>>>>>>>>
> >>>>>>>>>>> The downtime contributed by vhost-vDPA, for example, is not f=
rom having to
> >>>>>>>>>>> migrate a lot of state but rather expensive backend control-p=
lane latency
> >>>>>>>>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN f=
ilters, offload
> >>>>>>>>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC opera=
tions which
> >>>>>>>>>>> dominates its downtime.
> >>>>>>>>>>>
> >>>>>>>>>>> In other words, by migrating the state of virtio-net early (b=
efore the
> >>>>>>>>>>> stop-and-copy phase), we can also start staging backend confi=
gurations,
> >>>>>>>>>>> which is the main contributor of downtime when migrating a vh=
ost-vDPA
> >>>>>>>>>>> device.
> >>>>>>>>>>>
> >>>>>>>>>>> I apologize if this series gives the impression that we're mi=
grating a lot
> >>>>>>>>>>> of data here. It's more along the lines of moving control-pla=
ne latency out
> >>>>>>>>>>> of the stop-and-copy phase.
> >>>>>>>>>>
> >>>>>>>>>> I see, thanks.
> >>>>>>>>>>
> >>>>>>>>>> Please add these into the cover letter of the next post.  IMHO=
 it's
> >>>>>>>>>> extremely important information to explain the real goal of th=
is work.  I
> >>>>>>>>>> bet it is not expected for most people when reading the curren=
t cover
> >>>>>>>>>> letter.
> >>>>>>>>>>
> >>>>>>>>>> Then it could have nothing to do with iterative phase, am I ri=
ght?
> >>>>>>>>>>
> >>>>>>>>>> What are the data needed for the dest QEMU to start staging ba=
ckend
> >>>>>>>>>> configurations to the HWs underneath?  Does dest QEMU already =
have them in
> >>>>>>>>>> the cmdlines?
> >>>>>>>>>>
> >>>>>>>>>> Asking this because I want to know whether it can be done comp=
letely
> >>>>>>>>>> without src QEMU at all, e.g. when dest QEMU starts.
> >>>>>>>>>>
> >>>>>>>>>> If src QEMU's data is still needed, please also first consider=
 providing
> >>>>>>>>>> such facility using an "early VMSD" if it is ever possible: fe=
el free to
> >>>>>>>>>> refer to commit 3b95a71b22827d26178.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> While it works for this series, it does not allow to resend the=
 state
> >>>>>>>>> when the src device changes. For example, if the number of virt=
queues
> >>>>>>>>> is modified.
> >>>>>>>>
> >>>>>>>> Some explanation on "how sync number of vqueues helps downtime" =
would help.
> >>>>>>>> Not "it might preheat things", but exactly why, and how that dif=
fers when
> >>>>>>>> it's pure software, and when hardware will be involved.
> >>>>>>>>
> >>>>>>>
> >>>>>>> By nvidia engineers to configure vqs (number, size, RSS, etc) tak=
es
> >>>>>>> about ~200ms:
> >>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c=
8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7s=
GaBlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2=
pA$
> >>>>>>>
> >>>>>>> Adding Dragos here in case he can provide more details. Maybe the
> >>>>>>> numbers have changed though.
> >>>>>>>
> >>>>>>> And I guess the difference with pure SW will always come down to =
PCI
> >>>>>>> communications, which assume it is slower than configuring the ho=
st SW
> >>>>>>> device in RAM or even CPU cache. But I admin that proper profilin=
g is
> >>>>>>> needed before making those claims.
> >>>>>>>
> >>>>>>> Jonah, can you print the time it takes to configure the vDPA devi=
ce
> >>>>>>> with traces vs the time it takes to enable the dataplane of the
> >>>>>>> device? So we can get an idea of how much time we save with this.
> >>>>>>>
> >>>>>>
> >>>>>> Let me know if this isn't what you're looking for.
> >>>>>>
> >>>>>> I'm assuming by "configuration time" you mean:
> >>>>>>      - Time from device startup (entry to vhost_vdpa_dev_start()) =
to right
> >>>>>>        before we start enabling the vrings (e.g.
> >>>>>>        VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
> >>>>>>
> >>>>>> And by "time taken to enable the dataplane" I'm assuming you mean:
> >>>>>>      - Time right before we start enabling the vrings (see above) =
to right
> >>>>>>        after we enable the last vring (at the end of
> >>>>>>        vhost_vdpa_net_cvq_load())
> >>>>>>
> >>>>>> Guest specs: 128G Mem, SVQ=3Don, CVQ=3Don, 8 queue pairs:
> >>>>>>
> >>>>>> -netdev type=3Dvhost-vdpa,vhostdev=3D$VHOST_VDPA_0,id=3Dvhost-vdpa=
0,
> >>>>>>             queues=3D8,x-svq=3Don
> >>>>>>
> >>>>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,id=3Dvdpa0,bootindex=
=3D-1,
> >>>>>>             romfile=3D,page-per-vq=3Don,mac=3D$VF1_MAC,ctrl_vq=3Do=
n,mq=3Don,
> >>>>>>             ctrl_vlan=3Doff,vectors=3D18,host_mtu=3D9000,
> >>>>>>             disable-legacy=3Don,disable-modern=3Doff
> >>>>>>
> >>>>>> ---
> >>>>>>
> >>>>>> Configuration time:    ~31s
> >>>>>> Dataplane enable time: ~0.14ms
> >>>>>>
> >>>>>
> >>>>> I was vague, but yes, that's representative enough! It would be mor=
e
> >>>>> accurate if the configuration time ends by the time QEMU enables th=
e
> >>>>> first queue of the dataplane though.
> >>>>>
> >>>>> As Si-Wei mentions, is v->shared->listener_registered =3D=3D true a=
t the
> >>>>> beginning of vhost_vdpa_dev_start?
> >>>>>
> >>>>
> >>>> Ah, I also realized that Qemu I was using for measurements was using=
 a
> >>>> version before the listener_registered member was introduced.
> >>>>
> >>>> I retested with the latest changes in Qemu and set x-svq=3Doff, e.g.=
:
> >>>> guest specs: 128G Mem, SVQ=3Doff, CVQ=3Don, 8 queue pairs. I ran tes=
ting 3
> >>>> times for measurements.
> >>>>
> >>>> v->shared->listener_registered =3D=3D false at the beginning of
> >>>> vhost_vdpa_dev_start().
> >>>>
> >>>
> >>> Let's move out the effect of the mem pinning from the downtime by
> >>> registering the listener before the migration. Can you check why is i=
t
> >>> not registered at vhost_vdpa_set_owner?
> >>>
> >>
> >> Sorry I was profiling improperly. The listener is registered at
> >> vhost_vdpa_set_owner initially and v->shared->listener_registered is s=
et
> >> to true, but once we reach the first vhost_vdpa_dev_start call, it sho=
ws
> >> as false and is re-registered later in the function.
> >>
> >> Should we always expect listener_registered =3D=3D true at every
> >> vhost_vdpa_dev_start call during startup?
> >
> > Yes, that leaves all the memory pinning time out of the downtime.
> >
> >> This is what I traced during
> >> startup of a single guest (no migration).
> >
> > We can trace the destination's QEMU to be more accurate, but probably
> > it makes no difference.
> >
> >> Tracepoint is right at the
> >> start of the vhost_vdpa_dev_start function:
> >>
> >> vhost_vdpa_set_owner() - register memory listener
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started=
 =3D 1
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started=
 =3D 0
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started=
 =3D 1
> >
> > This is surprising. Can you trace how listener_registered goes to 0 aga=
in?
> >
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started=
 =3D 1
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started=
 =3D 1
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started=
 =3D 1
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started=
 =3D 1
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started=
 =3D 1
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started=
 =3D 1
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started=
 =3D 1
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started=
 =3D 1
> >> ...
> >> * VQs are now being enabled *
> >>
> >> I'm also seeing that when the guest is being shutdown,
> >> dev->vhost_ops->vhost_get_vring_base() is failing in
> >> do_vhost_virtqueue_stop():
> >>
> >> ...
> >> [  114.718429] systemd-shutdown[1]: Syncing filesystems and block devi=
ces.
> >> [  114.719255] systemd-shutdown[1]: Powering off.
> >> [  114.719916] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >> [  114.724826] ACPI: PM: Preparing to enter system sleep state S5
> >> [  114.725593] reboot: Power down
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started=
 =3D 0
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started=
 =3D 0
> >> qemu-system-x86_64: vhost VQ 2 ring restore failed: -1: Operation not
> >> permitted (1)
> >> qemu-system-x86_64: vhost VQ 3 ring restore failed: -1: Operation not
> >> permitted (1)
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started=
 =3D 0
> >> qemu-system-x86_64: vhost VQ 4 ring restore failed: -1: Operation not
> >> permitted (1)
> >> qemu-system-x86_64: vhost VQ 5 ring restore failed: -1: Operation not
> >> permitted (1)
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started=
 =3D 0
> >> qemu-system-x86_64: vhost VQ 6 ring restore failed: -1: Operation not
> >> permitted (1)
> >> qemu-system-x86_64: vhost VQ 7 ring restore failed: -1: Operation not
> >> permitted (1)
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started=
 =3D 0
> >> qemu-system-x86_64: vhost VQ 8 ring restore failed: -1: Operation not
> >> permitted (1)
> >> qemu-system-x86_64: vhost VQ 9 ring restore failed: -1: Operation not
> >> permitted (1)
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started=
 =3D 0
> >> qemu-system-x86_64: vhost VQ 10 ring restore failed: -1: Operation not
> >> permitted (1)
> >> qemu-system-x86_64: vhost VQ 11 ring restore failed: -1: Operation not
> >> permitted (1)
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started=
 =3D 0
> >> qemu-system-x86_64: vhost VQ 12 ring restore failed: -1: Operation not
> >> permitted (1)
> >> qemu-system-x86_64: vhost VQ 13 ring restore failed: -1: Operation not
> >> permitted (1)
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started=
 =3D 0
> >> qemu-system-x86_64: vhost VQ 14 ring restore failed: -1: Operation not
> >> permitted (1)
> >> qemu-system-x86_64: vhost VQ 15 ring restore failed: -1: Operation not
> >> permitted (1)
> >> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started=
 =3D 0
> >>
> >> However when x-svq=3Don, I don't see these errors on shutdown.
> >>
> >
> > SVQ can mask this error as it does not need to forward the ring
> > restore message to the device. It can just start with 0 and convert
> > indexes.
> >
> > Let's focus on listened_registered first :).
> >
> >>>> ---
> >>>>
> >>>> Configuration time: Time from first entry into vhost_vdpa_dev_start(=
) to
> >>>> right after Qemu enables the first VQ.
> >>>>     - 26.947s, 26.606s, 27.326s
> >>>>
> >>>> Enable dataplane: Time from right after first VQ is enabled to right
> >>>> after the last VQ is enabled.
> >>>>     - 0.081ms, 0.081ms, 0.079ms
> >>>>
> >>>
> >>
> >
>
> I looked into this a bit more and realized I was being naive thinking
> that the vhost-vDPA device startup path of a single VM would be the same
> as that on a destination VM during live migration. This is **not** the
> case and I apologize for the confusion I caused.
>
> What I described and profiled above is indeed true for the startup of a
> single VM / source VM with a vhost-vDPA device. However, this is not
> true on the destination side and its configuration time is drastically
> different.
>
> Under the same specs, but now with a live migration performed between a
> source and destination VM (128G Mem, SVQ=3Doff, CVQ=3Don, 8 queue pairs),
> and using the same tracepoints to find the configuration time and enable
> dataplane time, these are the measurements I found for the **destination
> VM**:
>
> Configuration time: Time from first entry into vhost_vdpa_dev_start to
> right after Qemu enables the first VQ.
>     - 268.603ms, 241.515ms, 249.007ms
>
> Enable dataplane time: Time from right after the first VQ is enabled to
> right after the last VQ is enabled.
>     - 0.072ms, 0.071ms, 0.070ms
>
> ---
>
> For those curious, using the same printouts as I did above, this is what
> it actually looks like on the destination side:
>
> * Destination VM is started *
>
> vhost_vdpa_set_owner() - register memory listener
> vhost_vdpa_reset_device() - unregistering listener
>
> * Start live migration on source VM *
> (qemu) migrate unix:/tmp/lm.sock
> ...
>
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1
> vhost_vdpa_dev_start() - register listener
>

That's weird, can you check why the memory listener is not registered
at vhost_vdpa_set_owner? Or, if it is registered, why is it not
registered by the time vhost_vdpa_dev_start is called? This changes
the downtime a lot, more than half of the time is spent on this. So it
is worth fixing it before continuing.

> And this is very different than the churning we saw in my previous email
> that happens on the source / single guest VM with vhost-vDPA and its
> startup path.
>
> ---
>
> Again, apologies on the confusion this caused. This was my fault for not
> being more careful.
>

No worries!


