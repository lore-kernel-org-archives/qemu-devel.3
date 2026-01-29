Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457D6D6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUZK-00082f-Nz; Thu, 29 Jan 2026 11:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vlUYu-00080u-2T
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:08:07 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vlUYr-0005lo-AD
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:08:03 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b86ed375d37so165445266b.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:08:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769702879; cv=none;
 d=google.com; s=arc-20240605;
 b=NGxyOLCsawJ/hZ/5ynfzGbm/eAcVtSjL4xG61Qi/eSqV7hjkNTEAgr89JR9gXbvcCi
 om0yYlA6/J/X7wYDkNn/klrvj378j+Xxj2gZb1jXZD7HfDNmGYvtbQuRrA3yuApUjSiQ
 9zaPA5R/xG6AbWDjPNE8uthAG9jCgImaJWEKBrJT6atELn/h159MjD4qGE5k6A6uj0DB
 K52PPutY55RJ4ZcX4If6FBlcX42InKC+U9pZXh2OW3muwz0FYbuf6jaKHtg+kGKWwTO/
 iBTTkolhsWoJ48cLk8ewMTn7+SDmp5W7JNoIrIR3tvWIFLhrJ0D/Oh0qRlill5qT4CR2
 UESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ubO353VrK03mwgeRuiFAyDJQ5LeVR8CK3RRfmgIQfaI=;
 fh=qgMSDp1GIKp4D6vsPjQ29xEx89U6W5DcqQ9El26JEOU=;
 b=jZj+UVoY1kUQ/5JZL5IzUPpad6/vDgGPBmYylM7Qx/seTu2sPffTb3fP8HFuH/a4Kv
 K21bZjA3knKTISW/nO6rYz2KEBwGph8cdYeXXS0pvfodbSuJOCAfs/htgVSgewlsx11Q
 y+P6rZTJCvIKfp7wu9cXH31gA5foABwkudRzoT3RH+w/D/8HNWC2RSb//5cBPOko+BKM
 PDpCS/pyPAi2cTBgHGwfMipVglKdFVcbH5Pl833Eq3JXH6Lnmk+Huo55o7mwWy5u0Mef
 6rdS3ImKL9A9QD6J6roV6P3ZEIY//YvsqjWHtIp9rH0+y9b6ePzquiHCAA8awdD8FZzz
 BfQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769702879; x=1770307679; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubO353VrK03mwgeRuiFAyDJQ5LeVR8CK3RRfmgIQfaI=;
 b=EbQ1qXvLTw6yt+kgsTyCePqvZ5xJ07HQu7pgpJv7sc8jtisb49tLxzL/H4+DXPUzOe
 0JEOQAK0ieCzc6sfDVD8Bk4x6abDD+NfUZ60DNjv2qdkNyQNT5i5f358WkZ2cfUHwrkU
 t5LpyUOwkn090YqTpu4XdG4NvwY8CZcxFmv5tIGumm9Tu/aFTWB9/fN/6ma4dSBO/nB0
 DHZLd0oYYpQRJHrGbeXR5ThSfOENR6j35hbtXFbnyf+6fLKEWKZ1PoZ3WXG5Lv/CEjfW
 HVPg7juZJBs9GJzaXNlSO6DoVub9oRZGk8BSQxgJnP1tWTUF6pvwn+oliTUDsvD7p7XA
 L78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702879; x=1770307679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ubO353VrK03mwgeRuiFAyDJQ5LeVR8CK3RRfmgIQfaI=;
 b=K61qft2eCIN1FZBrucKroP7/XbPJtVY22SdKSzZaRg7xcgxkPjdoqosmNIAA6Xu4Bo
 Va+nGDDgV35Z8mWmT4QkoNYXZsUEfcSLcewUATyJl3AKLHxTc+cUXFnXc7eec0HWOkJH
 CJyZLo+hjbeNjokVuralq1TWbzuDbZSRITJlo7fnAmVWVmq2VEGuyx99lOBt1PL7o/6Z
 ciOxBUYTW0CMK7pldM4GMCrx3sWYdEQH2ufcU0nxQ/iA914EPCENsjXYGckuDyGn/f+m
 K0go9oOaWdhCwbw++sPaPCyI3R9Hzq3sxpkEH6HnAVB1A6aPXow3waeIaNfLNGO8f9k8
 2TWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzfck6F+EkGe+YoxWuMFZeKANWxzEVqvk3L65nsm3cF1BeAMDt04EQpBdfgeD7BJCBDhR/UbP2c3e2@nongnu.org
X-Gm-Message-State: AOJu0YwWtepCqNbbrP7Da3jJLgorjn9lJnPguyt6nOqcZhM9h6iyNLzJ
 ijwf3+ZPa0huhhPno9Fbg0mgYn+P6wK+i1JqS/c+f2h+5GVLZK1I7s7uavdRuW43uitV6ymBlD1
 p5OZoDxQ8x8a6fETnz92VsXk5IOv1oSI=
X-Gm-Gg: AZuq6aJypcRgBxHwN/afaD1VWIgHq8468gx4QqEwJG3OtYJfm1SYSYrkaVBJPkuhUdX
 9NAYOx4F8UK942xwGrK86lXaae5nPEAcFEalgMoTNhpPtt3wei3NhxYnTwrv3024SQ1+SEmX3cW
 OCokGvQwW+YfSObTqLTW6j530PsOcT+i5MVq7OGFlptfo74zj3ghV7e798Pc3SICxZKOTOjcCon
 v5ywFWuczPENZ/PDmu6B8FPUfv1GFRk6/DKtfUHpItvVvoh7Ss+RRx1ofJtG9JDErk3qT10
X-Received: by 2002:a17:907:3f9e:b0:b8a:fa35:989f with SMTP id
 a640c23a62f3a-b8dab3048d3mr594891366b.38.1769702878711; Thu, 29 Jan 2026
 08:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127140316.4187221-5-jmarcin@redhat.com>
 <CACGkMEtO93AjdUMD7tGzyLH2Q-PVewxMgxxTgKBpnR-bTwOd9w@mail.gmail.com>
 <fpo57gscqhtcpdomfrwadexd3ierhmax4dqflqzfsuazo2secu@2em7v5gw7vmr>
 <CACGkMEsh8eLAeGcbitWrx-bAvx-Ek_-DNFtn9=k3JTcXfcZtTw@mail.gmail.com>
In-Reply-To: <CACGkMEsh8eLAeGcbitWrx-bAvx-Ek_-DNFtn9=k3JTcXfcZtTw@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 30 Jan 2026 00:07:18 +0800
X-Gm-Features: AZwV_QgkmByuMPYON6vFJQPoU85-W1gUiR4mRnejliHry337GPfKyoE3bNh3FOo
Message-ID: <CAK3tnv+R0Y92rnhBXgWyfJpQZML0zK02Uk-x97Lb71ZH7Yq9=Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] migration: Pass network packets received during
 switchover to dest VM
To: Jason Wang <jasowang@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cindy Lu <lulu@redhat.com>, eperezma <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 29, 2026 at 9:06=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jan 28, 2026 at 9:49=E2=80=AFPM Juraj Marcin <jmarcin@redhat.com>=
 wrote:
> >
> > Hi Jason,
> >
> > On 2026-01-28 10:55, Jason Wang wrote:
> > > On Tue, Jan 27, 2026 at 10:04=E2=80=AFPM Juraj Marcin <jmarcin@redhat=
.com> wrote:
> > > >
> > > > From: Juraj Marcin <jmarcin@redhat.com>
> > > >
> > > > During migration switchover both the source and the destination mac=
hines
> > > > are paused (compute downtime). During this period network still rou=
tes
> > > > network packets to the source machine, as this is the last place wh=
ere
> > > > the recipient MAC address has been seen. Once the destination side
> > > > starts and sends network announcement, all subsequent frames are ro=
uted
> > > > correctly. However, frames delivered to the source machine are neve=
r
> > > > processed and lost. This causes also a network downtime with roughl=
y the
> > > > same duration as compute downtime.
> > > >
> > > > This can cause problems not only for protocols that cannot handle p=
acket
> > > > loss, but can also introduce delays in protocols that can handle th=
em.
> > > >
> > > > To resolve this, this feature instantiates a network filter for eac=
h
> > > > network backend present during migration setup on both migration si=
des.
> > > > On the source side, this filter caches all packets received from th=
e
> > > > backend during switchover. Once the destination machine starts, all
> > > > cached packets are sent through the migration channel and the respe=
ctive
> > > > filter object on the destination side injects them to the NIC attac=
hed
> > > > to the backend.
> > > >
> > > > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > > > ---
> > > >  include/migration/vmstate.h |   6 +
> > > >  include/net/net.h           |   5 +
> > > >  migration/meson.build       |   1 +
> > > >  migration/migration.c       |  49 ++++++-
> > > >  migration/migration.h       |   2 +
> > > >  migration/netpass.c         | 246 ++++++++++++++++++++++++++++++++=
++++
> > > >  migration/netpass.h         |  14 ++
> > > >  migration/options.c         |  21 +++
> > > >  migration/options.h         |   1 +
> > > >  migration/savevm.c          |  37 ++++++
> > > >  migration/savevm.h          |   2 +
> > > >  migration/trace-events      |   9 ++
> > > >  net/net.c                   |  11 ++
> > > >  net/tap.c                   |  11 +-
> > > >  qapi/migration.json         |   7 +-
> > > >  15 files changed, 418 insertions(+), 4 deletions(-)
> > > >  create mode 100644 migration/netpass.c
> > > >  create mode 100644 migration/netpass.h
> > > >
> > > > diff --git a/include/migration/vmstate.h b/include/migration/vmstat=
e.h
> > > > index 62d7e9fe38..7987e6c85a 100644
> > > > --- a/include/migration/vmstate.h
> > > > +++ b/include/migration/vmstate.h
> > > > @@ -200,6 +200,12 @@ typedef enum {
> > > >       * save_setup() in VMSD structures.
> > > >       */
> > > >      VMS_PHASE_EARLY_SETUP,
> > > > +    /*
> > > > +     * Specifies a netpass VMSD, these devices are copied right af=
ter the
> > > > +     * destination is started regardless of precopy/postcopy. Fail=
ure in this
> > > > +     * phase does not fail the migration in case of precopy.
> > > > +     */
> > > > +    VMS_PHASE_NETPASS,
> > > >  } VMStateSavePhase;
> > > >
> > > >  struct VMStateDescription {
> > > > diff --git a/include/net/net.h b/include/net/net.h
> > > > index 45bc86fc86..510908845b 100644
> > > > --- a/include/net/net.h
> > > > +++ b/include/net/net.h
> > > > @@ -82,6 +82,7 @@ typedef void (NetAnnounce)(NetClientState *);
> > > >  typedef bool (SetSteeringEBPF)(NetClientState *, int);
> > > >  typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, E=
rror **);
> > > >  typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
> > > > +typedef void (NetpassEnabledNotify)(NetClientState *nc, void *opaq=
ue);
> > > >
> > > >  typedef struct NetClientInfo {
> > > >      NetClientDriver type;
> > > > @@ -130,6 +131,9 @@ struct NetClientState {
> > > >      bool is_netdev;
> > > >      bool do_not_pad; /* do not pad to the minimum ethernet frame l=
ength */
> > > >      bool is_datapath;
> > > > +    bool netpass_enabled;
> > > > +    NetpassEnabledNotify *netpass_enabled_notify;
> > > > +    void *netpass_enabled_notify_opaque;
> > > >      QTAILQ_HEAD(, NetFilterState) filters;
> > > >  };
> > > >
> > >
> > > Adding Cindy, Eugenio can Chen.
> > >
> > > I think we can simple reuse the existing filters:
> > >
> > > redirector: which can redirect traffic from the source to the
> > > destination via chardev
> > > buffer: which can hold the packets until the destination is released
> > >
> > > And let the libvirt install/uninstall those filters at the correct ti=
me.
> > >
> > > Which means:
> > >
> > > On the source: there would be a redirector that can be enabled when v=
m
> > > is paused, and it redirect the traffic to a socket/chardev
> > > On the destination: there would be a redirector as well as the buffer=
,
> > > redirector receives packets from the socket and send it to buffer,
> > > buffer will hold those packets until VM in the destination is resumed=
.
> > >
> > > The current filters need some tweaks (e.g letting filters (redirector=
)
> > > work when VM is paused). The advantages of this are:
> >
> > I tested the idea of filters for the forwarding using the existing
> > filters first and it does work with mentioned tweaks, however this
> > requires additional channel between chardevs attached to filters.
>
> It requires some changes in the redirector. One of the major but
> trivial changes is to make it work when the VM is paused.

Actually, current netfilter doesn't depend on the running or paused
state of the virtual machine. It just handle packet in qemu side.

>
> >
> > In my opinion it was better to reuse already existing migration channel=
,
> > so there are no necessary changes in higher layers. Furthermore, by
> > implementing this directly in QEMU, this feature can be used anywhere,
> > even if libvirt is not used.
>
> This requires more thought, leaving the policy to the upper may give
> us flexibility.

Agree, the use cases for this series is very similar to COLO project.
https://wiki.qemu.org/Features/COLO

We handled network related issue by introduce the qemu network filters.
It's even possible to transparently modify TCP packet headers without
the virtual machine being aware of it.
https://github.com/qemu/qemu/blob/master/docs/colo-proxy.txt

>
> >
> > >
> > > 1) reuse the existing filters
> > > 2) don't need to care about the vhost support on the source as vhost
> > > is disabled, for vDPA we can reuse shadow virtqueue
> >
> > Can you elaborate more on vhost being disabled? IUUC QEMU net filters
> > don't support vhost=3Don, including the redirector filter.
>
> We only need the filter work when vm is paused, in this case vhost is
> disabled. We can use packet socket to read or inject packet to tap.

Agree, COLO proxy use the filter-redirctor inject network packet to dest VM=
.
By the way, COLO is a HA/FT project in QEMU, based on our previous practica=
l
experience, the VM stop time will handled by netfilter and TCP/IP retransmi=
ssion
mechanism, for the stateless protocol like UDP, the application will
handle it by default.
The only difference with COLO is the normal live migration need
filter-buffer in dest side.
And the filter-buffer and VM paused time can also cause problems with
network transmission.
Another issue is when VM paused time became longer, filter-redirector
still running,
but the source side QEMU read packet from tap device path need to be
double checked.
You can know how the multiple network filters co-work in the COLO-proxy doc=
s.

Thanks
Chen

>
> >
> > > 3) for the destination we can install a redirector to packet socket t=
o
> > > let vhost works like socket -> redirector -> buffer -> redirector ->
> > > packet socket.
> > >
> > > Thanks
> > >
> >
>
> Thanks
>

