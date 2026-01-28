Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C691D35696
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 09:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl1YG-0002zE-EB; Wed, 28 Jan 2026 04:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vl1YE-0002tN-4J
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 04:09:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vl1YB-0003iQ-3Q
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 04:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769591361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+PEfi1vIJm2ROoNpGn2uSJ8mS0ln64jpJd6rKMvyUtw=;
 b=XZS9BtvDBpLayIlkhIcHQ25uei9qlIHR6S9KYfes6fA8whqta2LRfotoi7fnXsAYqYFD6h
 B9flDvNvEjxgyjxXYTpQo1FN3DmBwEdYHZ2GjbpqZFy9/7cCCQmogU2+919x3ioTTOWgot
 kTuPU3rkRz7hnqCFpkMYddcwaArnXK0=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-s_62dA9FPgexU-zyxUlmGQ-1; Wed, 28 Jan 2026 04:08:11 -0500
X-MC-Unique: s_62dA9FPgexU-zyxUlmGQ-1
X-Mimecast-MFC-AGG-ID: s_62dA9FPgexU-zyxUlmGQ_1769591291
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-5f55092e3fdso2049084137.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 01:08:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769591291; cv=none;
 d=google.com; s=arc-20240605;
 b=FHROsoU++Tzg1NnR+HjrW35cpS6mdsR0ZtY2bi5VWfKrWmUn+WvQYTJGX0ZhU+iJkg
 l/HiBU823CCFzYhDiWtyaT9xvTCR1Bd7xb9dBnPnECKRKlZ2PoxqH0H8lXLoz7wHF98v
 1Tgxm66+qBNd30J+qsBWqzxlxTliEQIPjjoYx8CDZpvDwOY9fWcMuq+9rlm3Q8F+fWZl
 O93braOL5+vufftMNPXmkutXdiHg2xxnyXxOKi6pa9B/yKTRRwT42gHyq/drHT+8Rqmq
 SffA4ICuGOeLG4iOZZWzmFSHfsAiFemNmM/KdLGh9OU3B1eLOBg7FekjNh2fhDQYPTTV
 6l8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+PEfi1vIJm2ROoNpGn2uSJ8mS0ln64jpJd6rKMvyUtw=;
 fh=pjQucRGIpikXJiCo7YkCUF38/mei28bD/W173MxwHWY=;
 b=OMb8llSomXbdsGchyi6RALpS1xb4aCBFdQqv8sqesZ35qQi2utx8r8LRurDNO/5ZhO
 3BjJsKT/lX1PimPY/vj2g9Ly8q3al5OknW0NieucSFQ7sLz+D3hVrQ/du0IcCN59+ysg
 zVdLEfcGjnTJjPFzMWUnjP0OvOcQcGZ41OVobEccTkxojVmc28+hE7Y70nfY6BS0WkGA
 jyDDg50nSsbg6bmCVHrvSkbbq53fCBM+GHutv29/TWZ4bkRuJYAsQvMfIEBNe3a58riM
 OgIuZm9KEoTHFHz+0e3rbplrQaVnHBu055yA3HdbWueSAN8Z6o+fswTihmWkbx2q/YnE
 SwkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769591291; x=1770196091; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PEfi1vIJm2ROoNpGn2uSJ8mS0ln64jpJd6rKMvyUtw=;
 b=H1ar1QfeIUD7gQWJYmgnksVB3aSRBc8wkSPIueMgFAuLwKZDluIhhOE8HdZHJwalWk
 773QvCjcNjTFm5MxnR8IunBWHiKVzg1gsBLXGayR8G47IbxTlrc0m5SkurFfMZo4OxR5
 AAxFJnyXBl5b826T1LMsf7/e9XrE83WZwhuDHoNP4nEXN/7Jqc2ed1+KAQoXUS8Tg2zK
 +BmNbbqBwbd2RealzipkcvDk0qXbMiOC3uxFzCfa06CMTSkEUjbnO7oJwXAxJDKnIyE6
 VnsSKbIqnIlmLOn2glGKTKsfILsV02eI3qSpxJuGtQUlB+wmwP10MyqpCz2XNVY//AvV
 atpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769591291; x=1770196091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+PEfi1vIJm2ROoNpGn2uSJ8mS0ln64jpJd6rKMvyUtw=;
 b=VqWHyFOXqjZzY+HYng/u9ybIz5pdb2tY9jOELTFY4w+MEwESEcGs+ujhNXe0pq2+Sv
 wvWUqA2FHE1EqrPtMQp/rqQCkD9gPt4eHPa87m/SA25ktH/X3meR+REa4JAwcNbHGG98
 X4bCzVRruljBiahTdDbKLpKdGfQ7kkz62ErIiqFRHPVq7xmeSUklXm3NQkv4ja2qD+p2
 h4atBwJzBDhKzcskdCF8ulQeDZh2rXmo7adUXnOQGyc541jpdKBg0zc3RG1ullZ7poSs
 gvVRIZ1za9bLA6ArKZGIdI/3Gb6WHA73WKor0WDJv4SmsnlswcTwJp+yKmAZfVNlcLTL
 kEgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYZPP6FChO/T6tMaVfHozDbgU9GjHBxVrp/3Nu7s7PfNrpJ0estt5zQIRvX2WTxkigJsepCC9xbf2S@nongnu.org
X-Gm-Message-State: AOJu0Yyh8uFDQD8z4I4Os/LL7UTaFFCHi58K0v1hVvE2jUNcJA6HnPA2
 2vPfvbVjS2rYG8jrd9LZqGnc5B9Ai8ijKOKVOTcsfhW17xxDjkbdfWoGXMD4kLXBDcy6X/Uw+gW
 fcHGHpYb1JGCLQuyuhtId3eU8nylyPgFrXepw9yyReGd7c7zmEr0mf2p4irz4hCwLWDRBeCArCe
 J2SyZRCB6DIE+SOiGyU4OhT4mtjCAA6gU=
X-Gm-Gg: AZuq6aJPiX+rOcKmWXDPyB1VY0kt5oCZB1SFNOL32h3xypltFa3KPyAV/znXU7yeVKb
 3nkF4jK7oZ9j1wVhV7rJwtkfR1bn9sORENJlmpHYEOGuAff1JbozKursBopk5fl5e7F73nzTDDt
 2vqdgDTLs4oTnb7mzqPqiZodT+KBqG+XmmYiUCStXB70WrcJ2WVOcN6ESL+8xTxQNgrRU=
X-Received: by 2002:a05:6102:41a9:b0:5ef:b51c:e7fa with SMTP id
 ada2fe7eead31-5f723841a7bmr2007273137.16.1769591291271; 
 Wed, 28 Jan 2026 01:08:11 -0800 (PST)
X-Received: by 2002:a05:6102:41a9:b0:5ef:b51c:e7fa with SMTP id
 ada2fe7eead31-5f723841a7bmr2007265137.16.1769591290822; Wed, 28 Jan 2026
 01:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127140316.4187221-5-jmarcin@redhat.com>
 <CACGkMEtO93AjdUMD7tGzyLH2Q-PVewxMgxxTgKBpnR-bTwOd9w@mail.gmail.com>
 <CACGkMEvCKSZY31H3_s1U1SKmFGW=pX60azcwUy0vrPR8yOakpQ@mail.gmail.com>
In-Reply-To: <CACGkMEvCKSZY31H3_s1U1SKmFGW=pX60azcwUy0vrPR8yOakpQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 28 Jan 2026 17:07:29 +0800
X-Gm-Features: AZwV_QjV8nzOahn9TZBTyeqn9uBe1NuiDIJ9oyjEEdy2nbElXnmc4dD6zRwhUJQ
Message-ID: <CACLfguUZpT-3sj4C8G8e+LB5GHpBfE_HKLOhyZ9qYR8bgkTOCw@mail.gmail.com>
Subject: Re: [PATCH 4/4] migration: Pass network packets received during
 switchover to dest VM
To: Jason Wang <jasowang@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhang Chen <zhangckid@gmail.com>, eperezma <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 28, 2026 at 10:57=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Jan 28, 2026 at 10:55=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Jan 27, 2026 at 10:04=E2=80=AFPM Juraj Marcin <jmarcin@redhat.c=
om> wrote:
> > >
> > > From: Juraj Marcin <jmarcin@redhat.com>
> > >
> > > During migration switchover both the source and the destination machi=
nes
> > > are paused (compute downtime). During this period network still route=
s
> > > network packets to the source machine, as this is the last place wher=
e
> > > the recipient MAC address has been seen. Once the destination side
> > > starts and sends network announcement, all subsequent frames are rout=
ed
> > > correctly. However, frames delivered to the source machine are never
> > > processed and lost. This causes also a network downtime with roughly =
the
> > > same duration as compute downtime.
> > >
> > > This can cause problems not only for protocols that cannot handle pac=
ket
> > > loss, but can also introduce delays in protocols that can handle them=
.
> > >
> > > To resolve this, this feature instantiates a network filter for each
> > > network backend present during migration setup on both migration side=
s.
> > > On the source side, this filter caches all packets received from the
> > > backend during switchover. Once the destination machine starts, all
> > > cached packets are sent through the migration channel and the respect=
ive
> > > filter object on the destination side injects them to the NIC attache=
d
> > > to the backend.
> > >
> > > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > > ---
> > >  include/migration/vmstate.h |   6 +
> > >  include/net/net.h           |   5 +
> > >  migration/meson.build       |   1 +
> > >  migration/migration.c       |  49 ++++++-
> > >  migration/migration.h       |   2 +
> > >  migration/netpass.c         | 246 ++++++++++++++++++++++++++++++++++=
++
> > >  migration/netpass.h         |  14 ++
> > >  migration/options.c         |  21 +++
> > >  migration/options.h         |   1 +
> > >  migration/savevm.c          |  37 ++++++
> > >  migration/savevm.h          |   2 +
> > >  migration/trace-events      |   9 ++
> > >  net/net.c                   |  11 ++
> > >  net/tap.c                   |  11 +-
> > >  qapi/migration.json         |   7 +-
> > >  15 files changed, 418 insertions(+), 4 deletions(-)
> > >  create mode 100644 migration/netpass.c
> > >  create mode 100644 migration/netpass.h
> > >
> > > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.=
h
> > > index 62d7e9fe38..7987e6c85a 100644
> > > --- a/include/migration/vmstate.h
> > > +++ b/include/migration/vmstate.h
> > > @@ -200,6 +200,12 @@ typedef enum {
> > >       * save_setup() in VMSD structures.
> > >       */
> > >      VMS_PHASE_EARLY_SETUP,
> > > +    /*
> > > +     * Specifies a netpass VMSD, these devices are copied right afte=
r the
> > > +     * destination is started regardless of precopy/postcopy. Failur=
e in this
> > > +     * phase does not fail the migration in case of precopy.
> > > +     */
> > > +    VMS_PHASE_NETPASS,
> > >  } VMStateSavePhase;
> > >
> > >  struct VMStateDescription {
> > > diff --git a/include/net/net.h b/include/net/net.h
> > > index 45bc86fc86..510908845b 100644
> > > --- a/include/net/net.h
> > > +++ b/include/net/net.h
> > > @@ -82,6 +82,7 @@ typedef void (NetAnnounce)(NetClientState *);
> > >  typedef bool (SetSteeringEBPF)(NetClientState *, int);
> > >  typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Err=
or **);
> > >  typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
> > > +typedef void (NetpassEnabledNotify)(NetClientState *nc, void *opaque=
);
> > >
> > >  typedef struct NetClientInfo {
> > >      NetClientDriver type;
> > > @@ -130,6 +131,9 @@ struct NetClientState {
> > >      bool is_netdev;
> > >      bool do_not_pad; /* do not pad to the minimum ethernet frame len=
gth */
> > >      bool is_datapath;
> > > +    bool netpass_enabled;
> > > +    NetpassEnabledNotify *netpass_enabled_notify;
> > > +    void *netpass_enabled_notify_opaque;
> > >      QTAILQ_HEAD(, NetFilterState) filters;
> > >  };
> > >
> >
> > Adding Cindy, Eugenio can Chen.
> >
> > I think we can simple reuse the existing filters:
> >
> > redirector: which can redirect traffic from the source to the
> > destination via chardev
> > buffer: which can hold the packets until the destination is released
> >
> > And let the libvirt install/uninstall those filters at the correct time=
.
> >
> > Which means:
> >
> > On the source: there would be a redirector that can be enabled when vm
> > is paused, and it redirect the traffic to a socket/chardev
> > On the destination: there would be a redirector as well as the buffer,
> > redirector receives packets from the socket and send it to buffer,
> > buffer will hold those packets until VM in the destination is resumed.
> >
> > The current filters need some tweaks (e.g letting filters (redirector)
> > work when VM is paused). The advantages of this are:
> >
> > 1) reuse the existing filters
> > 2) don't need to care about the vhost support on the source as vhost
> > is disabled, for vDPA we can reuse shadow virtqueue
> > 3) for the destination we can install a redirector to packet socket to
> > let vhost works like socket -> redirector -> buffer -> redirector ->
> > packet socket.
Actually, I've already started working on this to support vhost. there
would be based on filter working as this explain and coding is on
going , hope we can have a draft for this soon
Thanks
Cindy
>
> and 4) there's no need to touch migration code in Qemu.
>
> Thanks
>
> >
> > Thanks
>


