Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44741D46BED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGU7-0003RS-15; Wed, 28 Jan 2026 20:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vlGU5-0003QZ-Jo
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:06:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vlGU3-0002xE-7s
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769648765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdbJKxF6w8uL9249oL61dAhjQ07+V6e73GKpbkewhV0=;
 b=Zc7dzciNB8wrKuBl5ROS5S39hv7tnyFSTj78wSz7pBq82hGKJN7QVxV6i30GJSYnFvCypf
 m0wjF89ghFGnSO5GUL96tCOIxeFO1NlcD/aftZVX8pjjv8/Z8RIhp4dxio1MXJfj9BVQ+q
 V7D++DfOxXQDb5YTj56Sb4Ns9E0ySQY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-FWCiHAhQM-yXz0TFH9pLhA-1; Wed, 28 Jan 2026 20:06:02 -0500
X-MC-Unique: FWCiHAhQM-yXz0TFH9pLhA-1
X-Mimecast-MFC-AGG-ID: FWCiHAhQM-yXz0TFH9pLhA_1769648761
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a0e952f153so9298105ad.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769648761; cv=none;
 d=google.com; s=arc-20240605;
 b=PQo2fsO8Lm4HAc6K2k1X7T4PE+8r/EB+wZhYdyKQaC2pgwLEFN1DAoqgHBO7Fmqyan
 FgOk/DfemTpnNrboDYVAM8dZWS4Tne9y3WPgwbxHLL06GXOf8IcHjZEQ8FUUUYYrOOWD
 07X7eHqeikR08DBIhazws1FuuSk1JCxN6aLyPlNmkTylVC/iC57QZwEEb07GZlNNS5bX
 yhFbcmREj3P40GI45pfkBvIF+Ug/7yLMprqhdmShao+Cce+HspLNv/zYZr6PXTxNYu86
 wJJv+PdnmA5WamjKZAO2RWV53iQ8NUNuODmdp2n/KBoU6MR2kAJP103Mh9GCWcEjavo3
 +bBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wdbJKxF6w8uL9249oL61dAhjQ07+V6e73GKpbkewhV0=;
 fh=Byx2AiliFS7tMt68AguwejjVsyGw7sfDoVii4PlN3UE=;
 b=QkZhhA5MoAPCFIIVoCiLZHbWDg48xYgO+bYlfUAXgnDKmGsRvcEkRlmrU8btpmU9yp
 tzWyElY6AgFDYGTnCyZVKeIJ6yKJuOh2yFV7Oz2AGcNY27yiXrh4OFLYeSl29JtrPPc7
 8fLHP67yUlBg452sd0ja22uyRGuGBJ+wGXxkgtAsI5ZD5IaWuQirF6o0eAYoqljHv5F9
 6Yth4WhMyiIOrrXVyHZT5nmLgAFqpqOI57HBdbIaPyyBDSVj3dEamNmLUENFqm/weLY4
 5qM2NZ57y8A3Zkd4s6XINxMyZy5YjFU85//sERdHYMDAWk8oL2IIeudZiyhFCn01ydsT
 EkZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769648761; x=1770253561; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdbJKxF6w8uL9249oL61dAhjQ07+V6e73GKpbkewhV0=;
 b=FKBEDz+rG2qOSMC4to9Sk1KNcbrFqU8WdzQtlSDONdtHDHE/GW6XxnyQvbapStBp+F
 dImDQd7Q1AReNnzYgqTzgDRnFSCgU9XX7RBQ/uVTEfUOMB7BvkeSu3PxlKl4c8qjlaX0
 2Wc9JMEudtgOsbfSq9u37ruMnMs8Ihwl56b98kaBbtSmvgj9oRmydm8PBdCZPCL4Tyzv
 B6Kj4yObxBzkq35cPnC4/t2+Th7OriEZmDzbMkspYpSJ0ZP30JJyFlS5j3kg85DoR1Mv
 ew2kR270g30dTX1etEhxNHb/BAvFqjlwuVwWMrd9/LiOqLl0RN7IE3t7ViQedJtpr0dy
 x+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769648761; x=1770253561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wdbJKxF6w8uL9249oL61dAhjQ07+V6e73GKpbkewhV0=;
 b=v90eDjcYaR0IjmthIHd3EennI8zqOVrhCVoVhV6IHA8pCG9x9kUan6j5XzqOHuX17h
 +tj7XkIx/zdr+moBXhMlGATzdbqAg/br0WMZJRO1PfmX67R6bZzoSZ3LNeCrUIF5RXdC
 O8goGVhLtz8AuvlQldd9ubjOnP4cW5cQ7UYoysjRfge983iyYuKjZAdC0sPTyJU4fD1G
 UBc6y+SEIan9Qb2+GcFg4+P5N15HxJlT+lRRF5GfMtZQZOkKXbwNxL+dqauMUJao5tGV
 4Lov6TyW0WDhH2J7+xgGTb1Ppa5fEWYMldtEWo3myQ31ybHSAwlkHErEp6/7l+9jL+Cc
 WdNw==
X-Gm-Message-State: AOJu0YxUFobYovxjH9fgDpkO/wgrw/LQMEZ9C0iZRIoiWuSvfaPv4qVJ
 jWGOidAF4HrU8kZl4H8gefcEKqXjsAI3+DyHcBRlLEbGHKBMui4+TnWEOUPVo5UqxtiH27WAN5Z
 ZVToYhJWkljZGPVk/tWnUcoxe1qPvlhLunevY284ZgUwnmPatw/d7b4Rjs9HvJvWZTNbCTst/nE
 odK4NTvHktZLSZEkfmkXc6luWIX7FaHmg=
X-Gm-Gg: AZuq6aKMTZKPN8c/oMxRW6iTOAaRDlV0IzDiJs6WZ8VWxG0o77n38NRZ9U5lvz1Yzxq
 fiL38aJVKbmZrNuR/pO+OHDU4Q83fLO82dMHNx32nECNMaKz9vNtavxxknudR09L6tRmUzGpsWN
 Vty2WNgORh6QYs1++pczNkcXx+ZagJqfmgi/CaYeLyP/p2R2k5/T0mJtkVM7rhhq1n
X-Received: by 2002:a17:903:37d0:b0:2a1:14dd:573 with SMTP id
 d9443c01a7336-2a870db415emr81973295ad.23.1769648761070; 
 Wed, 28 Jan 2026 17:06:01 -0800 (PST)
X-Received: by 2002:a17:903:37d0:b0:2a1:14dd:573 with SMTP id
 d9443c01a7336-2a870db415emr81972895ad.23.1769648760562; Wed, 28 Jan 2026
 17:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127140316.4187221-5-jmarcin@redhat.com>
 <CACGkMEtO93AjdUMD7tGzyLH2Q-PVewxMgxxTgKBpnR-bTwOd9w@mail.gmail.com>
 <fpo57gscqhtcpdomfrwadexd3ierhmax4dqflqzfsuazo2secu@2em7v5gw7vmr>
In-Reply-To: <fpo57gscqhtcpdomfrwadexd3ierhmax4dqflqzfsuazo2secu@2em7v5gw7vmr>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jan 2026 09:05:47 +0800
X-Gm-Features: AZwV_QijVtrnnLQ5798NVY6zzPCSm7dkevLSagzEROfiUDGXqRk3Yg_7IiIixK8
Message-ID: <CACGkMEsh8eLAeGcbitWrx-bAvx-Ek_-DNFtn9=k3JTcXfcZtTw@mail.gmail.com>
Subject: Re: [PATCH 4/4] migration: Pass network packets received during
 switchover to dest VM
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cindy Lu <lulu@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, eperezma <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 28, 2026 at 9:49=E2=80=AFPM Juraj Marcin <jmarcin@redhat.com> w=
rote:
>
> Hi Jason,
>
> On 2026-01-28 10:55, Jason Wang wrote:
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
>
> I tested the idea of filters for the forwarding using the existing
> filters first and it does work with mentioned tweaks, however this
> requires additional channel between chardevs attached to filters.

It requires some changes in the redirector. One of the major but
trivial changes is to make it work when the VM is paused.

>
> In my opinion it was better to reuse already existing migration channel,
> so there are no necessary changes in higher layers. Furthermore, by
> implementing this directly in QEMU, this feature can be used anywhere,
> even if libvirt is not used.

This requires more thought, leaving the policy to the upper may give
us flexibility.

>
> >
> > 1) reuse the existing filters
> > 2) don't need to care about the vhost support on the source as vhost
> > is disabled, for vDPA we can reuse shadow virtqueue
>
> Can you elaborate more on vhost being disabled? IUUC QEMU net filters
> don't support vhost=3Don, including the redirector filter.

We only need the filter work when vm is paused, in this case vhost is
disabled. We can use packet socket to read or inject packet to tap.

>
> > 3) for the destination we can install a redirector to packet socket to
> > let vhost works like socket -> redirector -> buffer -> redirector ->
> > packet socket.
> >
> > Thanks
> >
>

Thanks


