Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB76BC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 07:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCDNS-0007FP-7X; Wed, 29 May 2024 03:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sCDNE-0007ES-7k
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:05:24 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sCDMy-0003PC-RC
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:05:24 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so2027319a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 00:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1716966307; x=1717571107; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22gZMj9Ngyl5QFYYx0ERdhbxSEHP/ywydalXgqeU78E=;
 b=jAta4MWOKSwo/7xHXmDYWkwRPYFENMk0YY2+zouIGbRd4AcXNVs6+pkudcEGDy2Y/l
 IBbUNkEajZekgSKylfvOZ01fUsWoT7vqFvCBbTG0q0REKlGOy+VPYFDRzBkbQeozXAGP
 4M1C4UT4QO/YYqfqOR1Uob7SRk3OnLCZEzpjPZI6jbzC6cbc1nklKZDXLtcwcsxRGtDj
 QtsiY4YbmFBNh9U9vd72/QkuqHer9qqqnsODkaN6/6GhhJyMvQdiuEGzWJh6dNAQB8av
 a/iIefWfGqwTGt/d9Z0tR066QnniZBWAclFwDnNqUB85UUK1kdDOrolgJseFbHM+UESP
 4OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716966307; x=1717571107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22gZMj9Ngyl5QFYYx0ERdhbxSEHP/ywydalXgqeU78E=;
 b=dfG9MUoK2n54Pv5cXxG2e7vJOvKER+Mk2Sc7Y+SZnKPoDZqjQJAJKCOmv8ZDkWmC65
 FqmiP3RuxlHlF8w1UAEF3C0f1qsMrS0UNCVJ0vt5kcpCu8jlZ5rbleAJXpfpEguYIwjH
 nN/vq0FikF9EGOH2Idn++xRil5nUspmZ7PK2B35196R4EqX+9sMpE3IGlaN2NCBwYcE5
 XkVHOQ8jNImeHxRghTVLNonoxb7LorVvHF4aM1A8mOHjssX0OY7fMmv4Hbw+indJf22Q
 kEa0KPWzlxJyxq1V2+srxrTbVE1KUkTOmSM28oWkWpl/rln8yKT5EEuw78+yShp8sat2
 fHVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViv38O19DvdwOOA9XUaH/s9F05CmTbsMDssK4/07IzoIu+lXfrq0gjI/U8RozLknxgSphb/CAqvDPiyfHJcKKtRN22P5c=
X-Gm-Message-State: AOJu0YydK4ihNf7TCfKxorGBZaZ+jzokvO3joib6+MUrO7LEIBxT3WY1
 WfhK88cvNoyvbe0trqoJAad2efjN8HcLEej23jvEgD8nUakshNS50aHQzMk/79Mn8CRSjNzEgBl
 wYZffDrJkygc05RD2LQ0J+ZB4jlFA3otJ7ofQ0w==
X-Google-Smtp-Source: AGHT+IH17d5G6ahvy7oU/fSrXyANl8v8lU70vG84e0bYEsVBUuxtJhA0Z+r05KIWT/GljKSJrG5pqgBNLjpiSt2Pibk=
X-Received: by 2002:a50:a402:0:b0:572:cfa4:3ccb with SMTP id
 4fb4d7f45d1cf-578519160c0mr8899917a12.8.1716966306728; Wed, 29 May 2024
 00:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n> <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n> <2308a8b894244123b638038e40a33990@huawei.com>
 <ZlX-Swq4Hi-0iHeh@x1n> <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
 <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
 <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
In-Reply-To: <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 29 May 2024 09:04:54 +0200
Message-ID: <CAMGffEnoZ980i_=KaxoBqkbsSNTfjBV6fTPM0XjDT5cLN2XAAA@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Greg Sword <gregsword0@gmail.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Peter Xu <peterx@redhat.com>, 
 Yu Zhang <yu.zhang@ionos.com>, Michael Galaxy <mgalaxy@akamai.com>, 
 Elmar Gerdes <elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Pannengyuan <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>, 
 Fabiano Rosas <farosas@suse.de>, RDMA mailing list <linux-rdma@vger.kernel.org>,
 shefty@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::534;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, May 29, 2024 at 8:08=E2=80=AFAM Greg Sword <gregsword0@gmail.com> w=
rote:
>
> On Wed, May 29, 2024 at 12:33=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com=
> wrote:
> >
> > On Wed, May 29, 2024 at 4:43=E2=80=AFAM Gonglei (Arei) <arei.gonglei@hu=
awei.com> wrote:
> > >
> > > Hi,
> > >
> > > > -----Original Message-----
> > > > From: Peter Xu [mailto:peterx@redhat.com]
> > > > Sent: Tuesday, May 28, 2024 11:55 PM
> > > > > > > Exactly, not so compelling, as I did it first only on servers
> > > > > > > widely used for production in our data center. The network
> > > > > > > adapters are
> > > > > > >
> > > > > > > Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> > > > > > > BCM5720 2-port Gigabit Ethernet PCIe
> > > > > >
> > > > > > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks mo=
re
> > > > reasonable.
> > > > > >
> > > > > >
> > > > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda1=
5
> > > > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > > > >
> > > > > > Appreciate a lot for everyone helping on the testings.
> > > > > >
> > > > > > > InfiniBand controller: Mellanox Technologies MT27800 Family
> > > > > > > [ConnectX-5]
> > > > > > >
> > > > > > > which doesn't meet our purpose. I can choose RDMA or TCP for =
VM
> > > > > > > migration. RDMA traffic is through InfiniBand and TCP through
> > > > > > > Ethernet on these two hosts. One is standby while the other i=
s active.
> > > > > > >
> > > > > > > Now I'll try on a server with more recent Ethernet and Infini=
Band
> > > > > > > network adapters. One of them has:
> > > > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (rev =
01)
> > > > > > >
> > > > > > > The comparison between RDMA and TCP on the same NIC could mak=
e
> > > > > > > more
> > > > > > sense.
> > > > > >
> > > > > > It looks to me NICs are powerful now, but again as I mentioned =
I
> > > > > > don't think it's a reason we need to deprecate rdma, especially=
 if
> > > > > > QEMU's rdma migration has the chance to be refactored using rso=
cket.
> > > > > >
> > > > > > Is there anyone who started looking into that direction?  Would=
 it
> > > > > > make sense we start some PoC now?
> > > > > >
> > > > >
> > > > > My team has finished the PoC refactoring which works well.
> > > > >
> > > > > Progress:
> > > > > 1.  Implement io/channel-rdma.c,
> > > > > 2.  Add unit test tests/unit/test-io-channel-rdma.c and verifying=
 it
> > > > > is successful, 3.  Remove the original code from migration/rdma.c=
, 4.
> > > > > Rewrite the rdma_start_outgoing_migration and
> > > > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xxx func=
tions
> > > > > from migration/ram.c. (to prevent RDMA live migration from pollut=
ing the
> > > > core logic of live migration), 6.  The soft-RoCE implemented by sof=
tware is
> > > > used to test the RDMA live migration. It's successful.
> > > > >
> > > > > We will be submit the patchset later.
> > > >
> > > > That's great news, thank you!
> > > >
> > > > --
> > > > Peter Xu
> > >
> > > For rdma programming, the current mainstream implementation is to use=
 rdma_cm to establish a connection, and then use verbs to transmit data.
> > >
> > > rdma_cm and ibverbs create two FDs respectively. The two FDs have dif=
ferent responsibilities. rdma_cm fd is used to notify connection establishm=
ent events,
> > > and verbs fd is used to notify new CQEs. When poll/epoll monitoring i=
s directly performed on the rdma_cm fd, only a pollin event can be monitore=
d, which means
> > > that an rdma_cm event occurs. When the verbs fd is directly polled/ep=
olled, only the pollin event can be listened, which indicates that a new CQ=
E is generated.
> > >
> > > Rsocket is a sub-module attached to the rdma_cm library and provides =
rdma calls that are completely similar to socket interfaces. However, this =
library returns
> > > only the rdma_cm fd for listening to link setup-related events and do=
es not expose the verbs fd (readable and writable events for listening to d=
ata). Only the rpoll
> > > interface provided by the RSocket can be used to listen to related ev=
ents. However, QEMU uses the ppoll interface to listen to the rdma_cm fd (g=
otten by raccept API).
> > > And cannot listen to the verbs fd event. Only some hacking methods ca=
n be used to address this problem.
> > >
> > > Do you guys have any ideas? Thanks.
> > +cc linux-rdma
>
> Why include rdma community?
rdma community has a lot people with experience in rdma/rsocket?
>
> > +cc Sean
> >
> >
> >
> > >
> > >
> > > Regards,
> > > -Gonglei
> >

