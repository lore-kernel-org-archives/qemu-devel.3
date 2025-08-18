Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB570CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 16:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo2cR-0003DA-Eo; Mon, 18 Aug 2025 12:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uo2cP-0003D2-Pv
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 12:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uo2cN-0001Me-LN
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 12:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755534112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flBuBHqYJQNjeJvymEHeyC0TJWhoy0+TyjHfkUpoPuk=;
 b=FUA+IqjJznDXdYih3f/eciwMA6zfo2m5h+hbTifksPWR1TaITzatR6eadjPxy+LCVMQ3C/
 rL7h1VqCTI//2nDvy32eaOsEBR6oQGuc4PY0wQxNfdlCf77vMr4VIWeH9lXQj88MwR1u8f
 C2vaXp6BM3qHQNLgNqyTcbdYit2JZns=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-zGueKa6kNjq5TEyJDF_rYQ-1; Mon, 18 Aug 2025 12:21:46 -0400
X-MC-Unique: zGueKa6kNjq5TEyJDF_rYQ-1
X-Mimecast-MFC-AGG-ID: zGueKa6kNjq5TEyJDF_rYQ_1755534105
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e87031ae4dso455512085a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 09:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755534105; x=1756138905;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=flBuBHqYJQNjeJvymEHeyC0TJWhoy0+TyjHfkUpoPuk=;
 b=vRBYJEOUV4pXS/nEO7QjJevi+BF6EQUwhnwhjItBgaOk9hy+ikkNlPJlzzr0CK+nIq
 vzoFWMhQ9PUpPpxQko2QhvuD42T/RjFy3uKLUV5xdv4ikUV+poc+yisn96Mslk2NdrsL
 ufR8bgQs+IfSCtzyx3FWOQYmYxH11tEGI5rwCssyVDhsrOhH/sMhgkscNcQv8ceE7TSZ
 SqIiTvpnXs+idruq5dv14QsDq/7MZIWnd8q+UX8vMDSbIG81nPWSnqoRj7ZwoCKrlEFM
 5pxkmky3GmHOscx26i6zzABWr4ofik9m36G06EEeF3wOB71CizBzY/bi2yIgLtG6YYlC
 Npvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV278qvZ9ltEaJpBZ15Eh5QVC0vTA/EGAlCryKHkJi27xMWpmBd1+Ptl2akEPBzdaeZKG9ecUpkwxTH@nongnu.org
X-Gm-Message-State: AOJu0YwsBE8iFzs33Kq3AMSAd7xdl3wFssLCeZLTJVKvBRAY3l4Pu8Zg
 ANVM0BCgIMESOH4TalByw8pueqr/zIcilGffHvQ+5sOPg6S3yMxovN8s6085YIqO49nRdKd8UBS
 yc91b38bUptzz1BBnaRcvVdLakg4zk1hD5PBc6yGbehR3ONuXXFLRvZMj
X-Gm-Gg: ASbGnctF0lzaDd4IRlXHu27N3/R43U3zy01ygBVTD6xWBX/tNA8ccOzH0Vf362y2INJ
 w1/8iQNNgEKuuVq2AJLN1pz+CUS24HfPoPpGbAcdIVESkmM1j8OK8JUYRqf0ewcbI7yxMPDjqdn
 qo9PrJJhZ91A2/KJonKGe+Xa3my2ctZNwBltAq2/BWKtP4UM/F8nNjzMVZxe0Ag0qj9A911wT1l
 nVYwpOcpwacDGLStBJS22K5nIMes4W/4q1+jMQvAso1OtpcfQLwq9S+8MMNuwzXG/iDK3zU6o3K
 LWT/mLJOZbMOCSjRoK6ddz4CT6U3FVqA
X-Received: by 2002:a05:620a:370d:b0:7e6:28d3:c4df with SMTP id
 af79cd13be357-7e87df87270mr1781390285a.14.1755534105307; 
 Mon, 18 Aug 2025 09:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1w3tbDUVxTu+2s+PA3V5m5UdmQ+InScX+eBsh3e6W5ywXwt9zq6uRB3JNYoWh5Bqy//Qefw==
X-Received: by 2002:a05:620a:370d:b0:7e6:28d3:c4df with SMTP id
 af79cd13be357-7e87df87270mr1781382785a.14.1755534104584; 
 Mon, 18 Aug 2025 09:21:44 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e19210esm623636885a.47.2025.08.18.09.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:21:43 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:21:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, Dragos Tatulea DE <dtatulea@nvidia.com>
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
Message-ID: <aKNTC_Q93ME1rgyI@x1.local>
References: <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local>
 <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
 <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
 <CAJaqyWfc3G5NLnxqXvZFxw2aRnVvOcZbLds5LHzcdoLjVGmOsw@mail.gmail.com>
 <c5b97e10-a8bb-4d59-b509-734eab7d5be3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5b97e10-a8bb-4d59-b509-734eab7d5be3@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Aug 18, 2025 at 10:46:00AM -0400, Jonah Palmer wrote:
> 
> 
> On 8/18/25 2:51 AM, Eugenio Perez Martin wrote:
> > On Fri, Aug 15, 2025 at 4:50 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
> > > 
> > > 
> > > 
> > > On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
> > > > On Wed, Aug 13, 2025 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > 
> > > > > On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
> > > > > > On Mon, Aug 11, 2025 at 11:56 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > > > 
> > > > > > > On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
> > > > > > > > This effort was started to reduce the guest visible downtime by
> > > > > > > > virtio-net/vhost-net/vhost-vDPA during live migration, especially
> > > > > > > > vhost-vDPA.
> > > > > > > > 
> > > > > > > > The downtime contributed by vhost-vDPA, for example, is not from having to
> > > > > > > > migrate a lot of state but rather expensive backend control-plane latency
> > > > > > > > like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
> > > > > > > > settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
> > > > > > > > dominates its downtime.
> > > > > > > > 
> > > > > > > > In other words, by migrating the state of virtio-net early (before the
> > > > > > > > stop-and-copy phase), we can also start staging backend configurations,
> > > > > > > > which is the main contributor of downtime when migrating a vhost-vDPA
> > > > > > > > device.
> > > > > > > > 
> > > > > > > > I apologize if this series gives the impression that we're migrating a lot
> > > > > > > > of data here. It's more along the lines of moving control-plane latency out
> > > > > > > > of the stop-and-copy phase.
> > > > > > > 
> > > > > > > I see, thanks.
> > > > > > > 
> > > > > > > Please add these into the cover letter of the next post.  IMHO it's
> > > > > > > extremely important information to explain the real goal of this work.  I
> > > > > > > bet it is not expected for most people when reading the current cover
> > > > > > > letter.
> > > > > > > 
> > > > > > > Then it could have nothing to do with iterative phase, am I right?
> > > > > > > 
> > > > > > > What are the data needed for the dest QEMU to start staging backend
> > > > > > > configurations to the HWs underneath?  Does dest QEMU already have them in
> > > > > > > the cmdlines?
> > > > > > > 
> > > > > > > Asking this because I want to know whether it can be done completely
> > > > > > > without src QEMU at all, e.g. when dest QEMU starts.
> > > > > > > 
> > > > > > > If src QEMU's data is still needed, please also first consider providing
> > > > > > > such facility using an "early VMSD" if it is ever possible: feel free to
> > > > > > > refer to commit 3b95a71b22827d26178.
> > > > > > > 
> > > > > > 
> > > > > > While it works for this series, it does not allow to resend the state
> > > > > > when the src device changes. For example, if the number of virtqueues
> > > > > > is modified.
> > > > > 
> > > > > Some explanation on "how sync number of vqueues helps downtime" would help.
> > > > > Not "it might preheat things", but exactly why, and how that differs when
> > > > > it's pure software, and when hardware will be involved.
> > > > > 
> > > > 
> > > > By nvidia engineers to configure vqs (number, size, RSS, etc) takes
> > > > about ~200ms:
> > > > https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGaBlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA$
> > > > 
> > > > Adding Dragos here in case he can provide more details. Maybe the
> > > > numbers have changed though.
> > > > 
> > > > And I guess the difference with pure SW will always come down to PCI
> > > > communications, which assume it is slower than configuring the host SW
> > > > device in RAM or even CPU cache. But I admin that proper profiling is
> > > > needed before making those claims.
> > > > 
> > > > Jonah, can you print the time it takes to configure the vDPA device
> > > > with traces vs the time it takes to enable the dataplane of the
> > > > device? So we can get an idea of how much time we save with this.
> > > > 
> > > 
> > > Let me know if this isn't what you're looking for.
> > > 
> > > I'm assuming by "configuration time" you mean:
> > >    - Time from device startup (entry to vhost_vdpa_dev_start()) to right
> > >      before we start enabling the vrings (e.g.
> > >      VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
> > > 
> > > And by "time taken to enable the dataplane" I'm assuming you mean:
> > >    - Time right before we start enabling the vrings (see above) to right
> > >      after we enable the last vring (at the end of
> > >      vhost_vdpa_net_cvq_load())
> > > 
> > > Guest specs: 128G Mem, SVQ=on, CVQ=on, 8 queue pairs:
> > > 
> > > -netdev type=vhost-vdpa,vhostdev=$VHOST_VDPA_0,id=vhost-vdpa0,
> > >           queues=8,x-svq=on
> > > 
> > > -device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,bootindex=-1,
> > >           romfile=,page-per-vq=on,mac=$VF1_MAC,ctrl_vq=on,mq=on,
> > >           ctrl_vlan=off,vectors=18,host_mtu=9000,
> > >           disable-legacy=on,disable-modern=off
> > > 
> > > ---
> > > 
> > > Configuration time:    ~31s
> > > Dataplane enable time: ~0.14ms
> > > 
> > 
> > I was vague, but yes, that's representative enough! It would be more
> > accurate if the configuration time ends by the time QEMU enables the
> > first queue of the dataplane though.
> > 
> > As Si-Wei mentions, is v->shared->listener_registered == true at the
> > beginning of vhost_vdpa_dev_start?
> > 
> 
> Ah, I also realized that Qemu I was using for measurements was using a
> version before the listener_registered member was introduced.
> 
> I retested with the latest changes in Qemu and set x-svq=off, e.g.: guest
> specs: 128G Mem, SVQ=off, CVQ=on, 8 queue pairs. I ran testing 3 times for
> measurements.
> 
> v->shared->listener_registered == false at the beginning of
> vhost_vdpa_dev_start().
> 
> ---
> 
> Configuration time: Time from first entry into vhost_vdpa_dev_start() to
> right after Qemu enables the first VQ.
>  - 26.947s, 26.606s, 27.326s

It's surprising to know it takes 20+ seconds for one device to load.

Sorry I'm not familiar with CVQ, please bare with me on my ignorance: how
much CVQ=on contributes to this?  Is page pinning involved here?  Is 128GB
using small pages only?

It looks to me there can still be many things that vDPA will face similar
challenges that VFIO already had.  For example, there's current work
optimizing pinning for VFIO here:

https://lore.kernel.org/all/20250814064714.56485-1-lizhe.67@bytedance.com/

For the long term, not sure if (for either VFIO or vDPA, or similar devices
that needs guest pinning) it would make more sense to start using 1G huge
pages just for the sake of fast pinning.

PFNMAP in VFIO already works with 1G pfnmaps with commit eb996eec783c.
Logically if we could use 1G pages (e.g. on x86_64) for guest, then pinning
/ unpinning can also be easily batched, and DMA pinning should be much
faster.  The same logic may also apply to vDPA if it works the similar way.

The work above was still generic, but I mentioned the idea of optimizing
for 1G huge pages here:

https://lore.kernel.org/all/aC3z_gUxJbY1_JP7@x1.local/#t

Above is just FYI.. definitely not an request to work on that.  So if we
can better split the issue into smaller but multiple scope of works it
would be nicer.  The "iterable migratable virtio-net" might just hide too
many things under the hood.

> 
> Enable dataplane: Time from right after first VQ is enabled to right after
> the last VQ is enabled.
>  - 0.081ms, 0.081ms, 0.079ms
> 

The other thing that might worth mention.. from migration perspective, VFIO
used to introduce one feature called switchover-ack:

# @switchover-ack: If enabled, migration will not stop the source VM
#     and complete the migration until an ACK is received from the
#     destination that it's OK to do so.  Exactly when this ACK is
#     sent depends on the migrated devices that use this feature.  For
#     example, a device can use it to make sure some of its data is
#     sent and loaded in the destination before doing switchover.
#     This can reduce downtime if devices that support this capability
#     are present.  'return-path' capability must be enabled to use
#     it.  (since 8.1)

If above 20+ seconds are not avoidable, not sure if virtio-net would like
to opt-in in this feature too, so that switchover won't happen too soon
during an pre-mature preheat, so that won't be accounted into downtime.

Again, just FYI. I'm not sure if it's applicable.

Thanks,

-- 
Peter Xu


