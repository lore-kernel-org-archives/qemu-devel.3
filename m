Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71420D35666
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 02:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkvkG-0000bu-Fl; Tue, 27 Jan 2026 21:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vkvjn-0000Fa-0x
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 21:57:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vkvjk-0003rd-7O
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 21:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769569015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hk9efQ8jGlo2pVG4qdf6ynujAZXqo8LbhDqyky4B95k=;
 b=NYrx+Z+bw76vc7/MJ3isDKSrYkjQrTon9Em+xmyZZHiFCn6dnAqAXzz16lArGpoL0R4at6
 7Npi0YL4qGpK7DYLbbIOc3i526jgValfxK9ZC5O4rO6FwLYT98QmJrk7oS+EW6riHBUFq9
 U/BjQsVSzWLoMIln+4J/qLrvquMof48=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-UrqCoqWvMS-yHjhsNeQJ5Q-1; Tue, 27 Jan 2026 21:56:54 -0500
X-MC-Unique: UrqCoqWvMS-yHjhsNeQJ5Q-1
X-Mimecast-MFC-AGG-ID: UrqCoqWvMS-yHjhsNeQJ5Q_1769569013
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34ac819b2f2so5941023a91.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 18:56:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769569012; cv=none;
 d=google.com; s=arc-20240605;
 b=gO0C9f0bHLd+z/w8U2ow8SmUAMb/yl/dAdhs8yawRHRDUE4S/yAZE7oBj8tw5/H4iq
 1d8I6v1tDBlVzvnhWFFaQyzG20mp3JwjkNxFKqVbxo2BzzbrJD1JPaoIik7zrPVGmAr1
 Bcl4UUCUTOjh2o3fUv8u3jY+Ysz18Q2nxRDT6V6Hmr0RA7wfD3U5kcWL4RIKbGaA07aV
 EKQam7ocTgHJ1sGGHsiGmuP4+eo+REPyk+C3aDTW2c64rJWz4GrwX0dMseoD7B064+n0
 Zl0fMSCZqcqdpX/EUXwuxuSem+KQUt2ra40Xu0nC76TBJXlXDjEr2Q3DPaBqV6L99G4X
 c06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hk9efQ8jGlo2pVG4qdf6ynujAZXqo8LbhDqyky4B95k=;
 fh=Byx2AiliFS7tMt68AguwejjVsyGw7sfDoVii4PlN3UE=;
 b=RVROR3DP+SADIdBQO+p4fELOZ7CSsolaDNrk7x9v4fA5eMEIgWBCG9R4PK9UhkHCtc
 urpsixsjY49CYCOE8CZv6NEIH3NiIbKI9dPuRCNP9V7vaFmYB6euXIjn67rK+hRpG7Ih
 WPY7bvd7P+1UOdI0zbDllhW+SEB0N6RXZTtUlXB25FI5a1B7xBsZHK5aphn5bCDUeR/p
 fL65pbNCjrtCNtACwK21MzETN2MAr6R3Y0rcDlYbTzAlf3tFfw72aeDJJs7FZa7wyCQg
 qHYEBNheP0FA96G3Kd/hfYSTHwGdLx+ssARzPbTMwRdpB1i5Q7ThO0bgDKxeZki08jkL
 ZiPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769569012; x=1770173812; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk9efQ8jGlo2pVG4qdf6ynujAZXqo8LbhDqyky4B95k=;
 b=oChPwIt86wbbHoy32ysms7gOYuTskC1SKQNR3D8E0ug8eTXZKBVnWcmQoXhvLbDXWq
 qdLEbk/PuYiT7E9bt7swcPLnKdTPBD4EIqCCn/lIQExZPYh2BN986OPFsUdbLcGW9gli
 64pgtgna0Ikt1FmMBC1Jki1G2irliSkM83u0tgalvNsBRyy+gYzE4GLz6TYKSMEFdWhj
 BE4w8IBAVDMiHdcdJMqyI/8mFdQDXTronccYQx+vhRFb71SfRtyYkO2TeYExeQMdSYoE
 SVSunHVNitmuxF+wGKpLrxRvshV7bJs/+mllBGjB3UXxzFmKXMiKcg2/FdqRqCZbxzGq
 r09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769569012; x=1770173812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hk9efQ8jGlo2pVG4qdf6ynujAZXqo8LbhDqyky4B95k=;
 b=k4vuGFvOb4IpmtpgGaPk2AzzzzTa290CtDN5vCpvbg4khieRMFCqPmHVz483+Wp9v9
 b4w30CfYv/vEpaxanWgiC9IP6CDrgEm3QMyGVuQBMtVsTdAQUQJbc9YmqIr9l1P9XB8J
 98wtKHnCG5z3TcV5kbVCVBzAwC5bGkS6bHnjVkzaSc8B2rvvnz/3yoQHpxltMJ+q/TYi
 u8TW12HbTMK8Eg6ZOEO2iuGXA45ugFBY29L9jRJpbwZI6S0MwmH6bPi/sUK+bINFndMm
 KF3H9pCgA7R4CQMsKKqlDyv9oUDQDmJ9Ay9edPABCZYQizpbAtgJ1VwF78jnjNv7IO9A
 yZHw==
X-Gm-Message-State: AOJu0YxUaQB0dlABH9yeI5BkBCLt61YANLaQ5vGPaz92gqLhaWopvHxq
 OGGtZCTvLNfBhRTMSy+E2kCbBJHrRdQhzGlm87mz1zNRpLDK5ZErVElAqXx9Aaqe7ADiBXps5Fd
 PgT2+CZLv/E2qan4g4PkfE+SbiOA30Rfa8SiKLgHh4P+xJdE1sOGy9SZ0j5CI3lLVi9KDc3cU/z
 /JLlUljmkC045oyB8DChlMNUipDww94rVSaxny+svdXA==
X-Gm-Gg: AZuq6aL2BZjOkVTbGEbWdC2DkoW1QeO5B79ZGicrBClHiKiRjMbPkcIrawI24SKwTo2
 QQkyAIAg5aevefPJGn/E3k4ZwM0gS9ftmnG5doss2zJk6WRIvO9AeyCqEZH8vIeua/T0xsK5I7G
 XiB9cGFRPJCyY3yv7x5Pd6emGVwIAN34gAUPWfdmVrkCSqxlS1TS8b874SRXNnvV+i
X-Received: by 2002:a17:90b:5350:b0:34c:c866:81f2 with SMTP id
 98e67ed59e1d1-353feccaca0mr3557549a91.4.1769569012337; 
 Tue, 27 Jan 2026 18:56:52 -0800 (PST)
X-Received: by 2002:a17:90b:5350:b0:34c:c866:81f2 with SMTP id
 98e67ed59e1d1-353feccaca0mr3557522a91.4.1769569011651; Tue, 27 Jan 2026
 18:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127140316.4187221-5-jmarcin@redhat.com>
 <CACGkMEtO93AjdUMD7tGzyLH2Q-PVewxMgxxTgKBpnR-bTwOd9w@mail.gmail.com>
In-Reply-To: <CACGkMEtO93AjdUMD7tGzyLH2Q-PVewxMgxxTgKBpnR-bTwOd9w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jan 2026 10:56:39 +0800
X-Gm-Features: AZwV_Qi_UW3kZwGV-B24B8Lkp4dTEJenTeAJ2B4ayviwtpDlNiIg-EESjOz4ObM
Message-ID: <CACGkMEvCKSZY31H3_s1U1SKmFGW=pX60azcwUy0vrPR8yOakpQ@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Wed, Jan 28, 2026 at 10:55=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Jan 27, 2026 at 10:04=E2=80=AFPM Juraj Marcin <jmarcin@redhat.com=
> wrote:
> >
> > From: Juraj Marcin <jmarcin@redhat.com>
> >
> > During migration switchover both the source and the destination machine=
s
> > are paused (compute downtime). During this period network still routes
> > network packets to the source machine, as this is the last place where
> > the recipient MAC address has been seen. Once the destination side
> > starts and sends network announcement, all subsequent frames are routed
> > correctly. However, frames delivered to the source machine are never
> > processed and lost. This causes also a network downtime with roughly th=
e
> > same duration as compute downtime.
> >
> > This can cause problems not only for protocols that cannot handle packe=
t
> > loss, but can also introduce delays in protocols that can handle them.
> >
> > To resolve this, this feature instantiates a network filter for each
> > network backend present during migration setup on both migration sides.
> > On the source side, this filter caches all packets received from the
> > backend during switchover. Once the destination machine starts, all
> > cached packets are sent through the migration channel and the respectiv=
e
> > filter object on the destination side injects them to the NIC attached
> > to the backend.
> >
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  include/migration/vmstate.h |   6 +
> >  include/net/net.h           |   5 +
> >  migration/meson.build       |   1 +
> >  migration/migration.c       |  49 ++++++-
> >  migration/migration.h       |   2 +
> >  migration/netpass.c         | 246 ++++++++++++++++++++++++++++++++++++
> >  migration/netpass.h         |  14 ++
> >  migration/options.c         |  21 +++
> >  migration/options.h         |   1 +
> >  migration/savevm.c          |  37 ++++++
> >  migration/savevm.h          |   2 +
> >  migration/trace-events      |   9 ++
> >  net/net.c                   |  11 ++
> >  net/tap.c                   |  11 +-
> >  qapi/migration.json         |   7 +-
> >  15 files changed, 418 insertions(+), 4 deletions(-)
> >  create mode 100644 migration/netpass.c
> >  create mode 100644 migration/netpass.h
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 62d7e9fe38..7987e6c85a 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -200,6 +200,12 @@ typedef enum {
> >       * save_setup() in VMSD structures.
> >       */
> >      VMS_PHASE_EARLY_SETUP,
> > +    /*
> > +     * Specifies a netpass VMSD, these devices are copied right after =
the
> > +     * destination is started regardless of precopy/postcopy. Failure =
in this
> > +     * phase does not fail the migration in case of precopy.
> > +     */
> > +    VMS_PHASE_NETPASS,
> >  } VMStateSavePhase;
> >
> >  struct VMStateDescription {
> > diff --git a/include/net/net.h b/include/net/net.h
> > index 45bc86fc86..510908845b 100644
> > --- a/include/net/net.h
> > +++ b/include/net/net.h
> > @@ -82,6 +82,7 @@ typedef void (NetAnnounce)(NetClientState *);
> >  typedef bool (SetSteeringEBPF)(NetClientState *, int);
> >  typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error=
 **);
> >  typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
> > +typedef void (NetpassEnabledNotify)(NetClientState *nc, void *opaque);
> >
> >  typedef struct NetClientInfo {
> >      NetClientDriver type;
> > @@ -130,6 +131,9 @@ struct NetClientState {
> >      bool is_netdev;
> >      bool do_not_pad; /* do not pad to the minimum ethernet frame lengt=
h */
> >      bool is_datapath;
> > +    bool netpass_enabled;
> > +    NetpassEnabledNotify *netpass_enabled_notify;
> > +    void *netpass_enabled_notify_opaque;
> >      QTAILQ_HEAD(, NetFilterState) filters;
> >  };
> >
>
> Adding Cindy, Eugenio can Chen.
>
> I think we can simple reuse the existing filters:
>
> redirector: which can redirect traffic from the source to the
> destination via chardev
> buffer: which can hold the packets until the destination is released
>
> And let the libvirt install/uninstall those filters at the correct time.
>
> Which means:
>
> On the source: there would be a redirector that can be enabled when vm
> is paused, and it redirect the traffic to a socket/chardev
> On the destination: there would be a redirector as well as the buffer,
> redirector receives packets from the socket and send it to buffer,
> buffer will hold those packets until VM in the destination is resumed.
>
> The current filters need some tweaks (e.g letting filters (redirector)
> work when VM is paused). The advantages of this are:
>
> 1) reuse the existing filters
> 2) don't need to care about the vhost support on the source as vhost
> is disabled, for vDPA we can reuse shadow virtqueue
> 3) for the destination we can install a redirector to packet socket to
> let vhost works like socket -> redirector -> buffer -> redirector ->
> packet socket.

and 4) there's no need to touch migration code in Qemu.

Thanks

>
> Thanks


