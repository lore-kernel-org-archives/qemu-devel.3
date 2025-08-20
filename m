Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94862CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uodkH-0004AP-1L; Wed, 20 Aug 2025 04:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uodkB-00048d-To
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 04:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uodk6-0005kp-0u
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 04:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755676819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bY2nucKB88klRZpRVml9fDFbBTzbcGqopnve3SC+IuE=;
 b=BK3GP5fTbN/heCNBl97Kk69o4oLaRVRul5dQgse74ugIu4lmnui9cHpJYXAnD2b1nWpyIz
 wvZTZZg4Ht7rkqwy+mPCOcCbcCcnr5UrFaXjFOOpb7qr5cyTTx0C8qGdjIKH5g5+VgCnik
 5ueEuSqexVZVVbUqBZ9jQnuThwr9tdM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-zuuOh5B_NqW-n191KCgATg-1; Wed, 20 Aug 2025 04:00:16 -0400
X-MC-Unique: zuuOh5B_NqW-n191KCgATg-1
X-Mimecast-MFC-AGG-ID: zuuOh5B_NqW-n191KCgATg_1755676816
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-323267c0292so5912801a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 01:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755676815; x=1756281615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bY2nucKB88klRZpRVml9fDFbBTzbcGqopnve3SC+IuE=;
 b=YyJjKuH188g6DrEpca7vc05c5B91nSkACIHkju1i8Uiqf03awnr9jsf3Q1VAZk/IYF
 viKn9+gS84Fxr2D8Y7o833/kWX6wDKUYLekxu67a+Rn1P6gx1pYYWOH9rBl+qOup01id
 J125nsY9XRkbq6lwQKApbg1BzwPCldQlxdZ0EUXLNnGacyc4EpWc9pJTx4z9bUaV/Van
 maaV3ZuMmeC2fZ/9Xppi2euM2lb/dC9tVu6IE4BAUi4rzdcOOlxvgCWieeK0lPo0qCUr
 fyKcynjSzwIKgzh0i29EQrqIkWLdiJE7XZFi2ye7ziJJ09ELSfZYOZxvykWjqzAdpxm9
 ud4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYz7iafhE3NkjJumohzkZ3BPqn5JLDhbOaVfAH4Fm1ygSRKxgP8DtX+ihDmEyyAVkLIKhIPJteBjqG@nongnu.org
X-Gm-Message-State: AOJu0Yzp7dAZEvZ9zfunHNW+nTd1ZzAqkCU/NGlR3A0JFsY59qoOLTaT
 zyaiPDJhiEioVwfVKwxoNiG5LyjTC/nHHT4bR8jEHE7EnAyDAxrI8gKZXvxi0dv5YakCeAW52YP
 SIViBfkmlqFHfAImTW5/2Uau6Ex5Lo62zdse7gKPWMitZrZ/0Wi5REQ98muwFLg0xmjbD+DPf+8
 Z6gk4r6dyN0+4tRvaD/kZONTtM2GlLg5w=
X-Gm-Gg: ASbGnct/Rn3ZdIO+Imenluq1eAtSWRRVxe+AmVxXLY3mTkOm8z3SEt2RfkDozqPIKl/
 +4e1pM22PPFKUczCCj3EA+LyfGUQ5zQT8VGL9JWWUkw926p4ZBVP8eT8dq+udoe7J6w2Tr/VYve
 92Aidq+Va6021/ZGumWJU=
X-Received: by 2002:a17:90b:2888:b0:321:9536:4b69 with SMTP id
 98e67ed59e1d1-324e144792amr2977817a91.27.1755676815284; 
 Wed, 20 Aug 2025 01:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG51+Mjg7qW7ytVbcGOUY5JD9e9ANEJoqF1nttWDFTKD8xh7qdXdJlLPdc2+3fsfpgukXQiXrB8K5zQTu53vCU=
X-Received: by 2002:a17:90b:2888:b0:321:9536:4b69 with SMTP id
 98e67ed59e1d1-324e144792amr2977776a91.27.1755676814701; Wed, 20 Aug 2025
 01:00:14 -0700 (PDT)
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
In-Reply-To: <4f067326-6c80-4768-886b-2b819e7184d3@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Aug 2025 09:59:38 +0200
X-Gm-Features: Ac12FXw_ZWi0T19hsvXpTlnnPVzTe-Zq8N1EBG4EkgyMviQhWOK9NUtfg_HOSRA
Message-ID: <CAJaqyWcNdPyrAmRMBgdEk3o4AR1kK6ZiHWdY6q4MuwvGgjub8Q@mail.gmail.com>
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de, 
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, 
 Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Tue, Aug 19, 2025 at 5:11=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 8/19/25 3:10 AM, Eugenio Perez Martin wrote:
> > On Mon, Aug 18, 2025 at 4:46=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >>
> >>
> >> On 8/18/25 2:51 AM, Eugenio Perez Martin wrote:
> >>> On Fri, Aug 15, 2025 at 4:50=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
> >>>>> On Wed, Aug 13, 2025 at 4:06=E2=80=AFPM Peter Xu <peterx@redhat.com=
> wrote:
> >>>>>>
> >>>>>> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wro=
te:
> >>>>>>> On Mon, Aug 11, 2025 at 11:56=E2=80=AFPM Peter Xu <peterx@redhat.=
com> wrote:
> >>>>>>>>
> >>>>>>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
> >>>>>>>>> This effort was started to reduce the guest visible downtime by
> >>>>>>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especial=
ly
> >>>>>>>>> vhost-vDPA.
> >>>>>>>>>
> >>>>>>>>> The downtime contributed by vhost-vDPA, for example, is not fro=
m having to
> >>>>>>>>> migrate a lot of state but rather expensive backend control-pla=
ne latency
> >>>>>>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN fil=
ters, offload
> >>>>>>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC operati=
ons which
> >>>>>>>>> dominates its downtime.
> >>>>>>>>>
> >>>>>>>>> In other words, by migrating the state of virtio-net early (bef=
ore the
> >>>>>>>>> stop-and-copy phase), we can also start staging backend configu=
rations,
> >>>>>>>>> which is the main contributor of downtime when migrating a vhos=
t-vDPA
> >>>>>>>>> device.
> >>>>>>>>>
> >>>>>>>>> I apologize if this series gives the impression that we're migr=
ating a lot
> >>>>>>>>> of data here. It's more along the lines of moving control-plane=
 latency out
> >>>>>>>>> of the stop-and-copy phase.
> >>>>>>>>
> >>>>>>>> I see, thanks.
> >>>>>>>>
> >>>>>>>> Please add these into the cover letter of the next post.  IMHO i=
t's
> >>>>>>>> extremely important information to explain the real goal of this=
 work.  I
> >>>>>>>> bet it is not expected for most people when reading the current =
cover
> >>>>>>>> letter.
> >>>>>>>>
> >>>>>>>> Then it could have nothing to do with iterative phase, am I righ=
t?
> >>>>>>>>
> >>>>>>>> What are the data needed for the dest QEMU to start staging back=
end
> >>>>>>>> configurations to the HWs underneath?  Does dest QEMU already ha=
ve them in
> >>>>>>>> the cmdlines?
> >>>>>>>>
> >>>>>>>> Asking this because I want to know whether it can be done comple=
tely
> >>>>>>>> without src QEMU at all, e.g. when dest QEMU starts.
> >>>>>>>>
> >>>>>>>> If src QEMU's data is still needed, please also first consider p=
roviding
> >>>>>>>> such facility using an "early VMSD" if it is ever possible: feel=
 free to
> >>>>>>>> refer to commit 3b95a71b22827d26178.
> >>>>>>>>
> >>>>>>>
> >>>>>>> While it works for this series, it does not allow to resend the s=
tate
> >>>>>>> when the src device changes. For example, if the number of virtqu=
eues
> >>>>>>> is modified.
> >>>>>>
> >>>>>> Some explanation on "how sync number of vqueues helps downtime" wo=
uld help.
> >>>>>> Not "it might preheat things", but exactly why, and how that diffe=
rs when
> >>>>>> it's pure software, and when hardware will be involved.
> >>>>>>
> >>>>>
> >>>>> By nvidia engineers to configure vqs (number, size, RSS, etc) takes
> >>>>> about ~200ms:
> >>>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8e=
bb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGa=
BlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA=
$
> >>>>>
> >>>>> Adding Dragos here in case he can provide more details. Maybe the
> >>>>> numbers have changed though.
> >>>>>
> >>>>> And I guess the difference with pure SW will always come down to PC=
I
> >>>>> communications, which assume it is slower than configuring the host=
 SW
> >>>>> device in RAM or even CPU cache. But I admin that proper profiling =
is
> >>>>> needed before making those claims.
> >>>>>
> >>>>> Jonah, can you print the time it takes to configure the vDPA device
> >>>>> with traces vs the time it takes to enable the dataplane of the
> >>>>> device? So we can get an idea of how much time we save with this.
> >>>>>
> >>>>
> >>>> Let me know if this isn't what you're looking for.
> >>>>
> >>>> I'm assuming by "configuration time" you mean:
> >>>>     - Time from device startup (entry to vhost_vdpa_dev_start()) to =
right
> >>>>       before we start enabling the vrings (e.g.
> >>>>       VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
> >>>>
> >>>> And by "time taken to enable the dataplane" I'm assuming you mean:
> >>>>     - Time right before we start enabling the vrings (see above) to =
right
> >>>>       after we enable the last vring (at the end of
> >>>>       vhost_vdpa_net_cvq_load())
> >>>>
> >>>> Guest specs: 128G Mem, SVQ=3Don, CVQ=3Don, 8 queue pairs:
> >>>>
> >>>> -netdev type=3Dvhost-vdpa,vhostdev=3D$VHOST_VDPA_0,id=3Dvhost-vdpa0,
> >>>>            queues=3D8,x-svq=3Don
> >>>>
> >>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,id=3Dvdpa0,bootindex=3D-=
1,
> >>>>            romfile=3D,page-per-vq=3Don,mac=3D$VF1_MAC,ctrl_vq=3Don,m=
q=3Don,
> >>>>            ctrl_vlan=3Doff,vectors=3D18,host_mtu=3D9000,
> >>>>            disable-legacy=3Don,disable-modern=3Doff
> >>>>
> >>>> ---
> >>>>
> >>>> Configuration time:    ~31s
> >>>> Dataplane enable time: ~0.14ms
> >>>>
> >>>
> >>> I was vague, but yes, that's representative enough! It would be more
> >>> accurate if the configuration time ends by the time QEMU enables the
> >>> first queue of the dataplane though.
> >>>
> >>> As Si-Wei mentions, is v->shared->listener_registered =3D=3D true at =
the
> >>> beginning of vhost_vdpa_dev_start?
> >>>
> >>
> >> Ah, I also realized that Qemu I was using for measurements was using a
> >> version before the listener_registered member was introduced.
> >>
> >> I retested with the latest changes in Qemu and set x-svq=3Doff, e.g.:
> >> guest specs: 128G Mem, SVQ=3Doff, CVQ=3Don, 8 queue pairs. I ran testi=
ng 3
> >> times for measurements.
> >>
> >> v->shared->listener_registered =3D=3D false at the beginning of
> >> vhost_vdpa_dev_start().
> >>
> >
> > Let's move out the effect of the mem pinning from the downtime by
> > registering the listener before the migration. Can you check why is it
> > not registered at vhost_vdpa_set_owner?
> >
>
> Sorry I was profiling improperly. The listener is registered at
> vhost_vdpa_set_owner initially and v->shared->listener_registered is set
> to true, but once we reach the first vhost_vdpa_dev_start call, it shows
> as false and is re-registered later in the function.
>
> Should we always expect listener_registered =3D=3D true at every
> vhost_vdpa_dev_start call during startup?

Yes, that leaves all the memory pinning time out of the downtime.

> This is what I traced during
> startup of a single guest (no migration).

We can trace the destination's QEMU to be more accurate, but probably
it makes no difference.

> Tracepoint is right at the
> start of the vhost_vdpa_dev_start function:
>
> vhost_vdpa_set_owner() - register memory listener
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started =
=3D 0
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 0, started =
=3D 1

This is surprising. Can you trace how listener_registered goes to 0 again?

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
> ...
> * VQs are now being enabled *
>
> I'm also seeing that when the guest is being shutdown,
> dev->vhost_ops->vhost_get_vring_base() is failing in
> do_vhost_virtqueue_stop():
>
> ...
> [  114.718429] systemd-shutdown[1]: Syncing filesystems and block devices=
.
> [  114.719255] systemd-shutdown[1]: Powering off.
> [  114.719916] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [  114.724826] ACPI: PM: Preparing to enter system sleep state S5
> [  114.725593] reboot: Power down
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started =
=3D 0
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started =
=3D 0
> qemu-system-x86_64: vhost VQ 2 ring restore failed: -1: Operation not
> permitted (1)
> qemu-system-x86_64: vhost VQ 3 ring restore failed: -1: Operation not
> permitted (1)
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started =
=3D 0
> qemu-system-x86_64: vhost VQ 4 ring restore failed: -1: Operation not
> permitted (1)
> qemu-system-x86_64: vhost VQ 5 ring restore failed: -1: Operation not
> permitted (1)
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started =
=3D 0
> qemu-system-x86_64: vhost VQ 6 ring restore failed: -1: Operation not
> permitted (1)
> qemu-system-x86_64: vhost VQ 7 ring restore failed: -1: Operation not
> permitted (1)
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started =
=3D 0
> qemu-system-x86_64: vhost VQ 8 ring restore failed: -1: Operation not
> permitted (1)
> qemu-system-x86_64: vhost VQ 9 ring restore failed: -1: Operation not
> permitted (1)
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started =
=3D 0
> qemu-system-x86_64: vhost VQ 10 ring restore failed: -1: Operation not
> permitted (1)
> qemu-system-x86_64: vhost VQ 11 ring restore failed: -1: Operation not
> permitted (1)
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started =
=3D 0
> qemu-system-x86_64: vhost VQ 12 ring restore failed: -1: Operation not
> permitted (1)
> qemu-system-x86_64: vhost VQ 13 ring restore failed: -1: Operation not
> permitted (1)
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started =
=3D 0
> qemu-system-x86_64: vhost VQ 14 ring restore failed: -1: Operation not
> permitted (1)
> qemu-system-x86_64: vhost VQ 15 ring restore failed: -1: Operation not
> permitted (1)
> vhost_vdpa_dev_start() - v->shared->listener_registered =3D 1, started =
=3D 0
>
> However when x-svq=3Don, I don't see these errors on shutdown.
>

SVQ can mask this error as it does not need to forward the ring
restore message to the device. It can just start with 0 and convert
indexes.

Let's focus on listened_registered first :).

> >> ---
> >>
> >> Configuration time: Time from first entry into vhost_vdpa_dev_start() =
to
> >> right after Qemu enables the first VQ.
> >>    - 26.947s, 26.606s, 27.326s
> >>
> >> Enable dataplane: Time from right after first VQ is enabled to right
> >> after the last VQ is enabled.
> >>    - 0.081ms, 0.081ms, 0.079ms
> >>
> >
>


