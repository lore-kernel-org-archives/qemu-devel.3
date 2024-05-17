Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFABC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 13:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7xE6-0006U9-NN; Fri, 17 May 2024 09:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1s7xE2-0006TY-02
 for qemu-devel@nongnu.org; Fri, 17 May 2024 09:02:18 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1s7xDy-000656-TB
 for qemu-devel@nongnu.org; Fri, 17 May 2024 09:02:17 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5727dc6d3edso4960604a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 06:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1715950931; x=1716555731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJDAl6y4Mz2BrWojAWtbkQd2mqHcv0DtypsvPHRPH0M=;
 b=GfSWPaTcvWP0+UpObEyvQbKNlV4b3e+BfEM1DzYS747Dn6JmDZKmhxRwXSrk1I2bKd
 xWSjXOHKUIxEu+CgVJStQgB8F2Tjeduf17SbCKiQJX0nVfq8fBs2xzdZp/71qPq4EtpD
 wGO39P+2wkBNoS1p7rFGG4blX9E3hj2UtjeBnUAzTRMWjIGTCsnga7tpq4wo4qKqNBGP
 7pN+OmnnpfvMdbDu47U/6hjMQ8CXwqDejiYGRoXfFbpZ0eDDERu4ohV4cztgKlnjzqGR
 POwArQ1AsscZi0zKXJSfR9t4megLuiAm0gWd0b3IrmOqF8/ZLykyOh+UZNq/DBfXbKVU
 KS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715950931; x=1716555731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJDAl6y4Mz2BrWojAWtbkQd2mqHcv0DtypsvPHRPH0M=;
 b=DMmb2CeEy0rSeCVk046yPBRsyXlMjk7t3zMFubMMgVG/C6T09SGSbKEL5M0o+/HdvW
 rOhxqwd0sPbdNI4OaPe7sUzETUH0rAP7ZMCF9UceWnZMV8I5tUU1snH7+aqXt79OKhH9
 o65gI6JKaKuFCZI7XcMvtmUzz3VYGm5PxwTnORDc5fplzhrg9iYv6IlOPU+XL4W5yS3o
 l3yAUyKIKnhdxCYk6lRUTtmo4JCI0Clbuq2A9FbJzmAolp1xWQBSMP8Mj9xX6yidfhnV
 TRGm3UvzLGdfn99xrPTyZ7YZg3yzDPecTnKcA0fWknavsgY2pwE+06ftAcBcX5vU5myT
 yBEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNHZOE0UcJRTHtpNgf1hCAK/ToWZennbkJ+m3gggkuD49kIQwTUL9tAMqiMdA9WsKCj7RP7p+vS4QS11KIQ18Vs9lK8o4=
X-Gm-Message-State: AOJu0YyH0KsP8DiLL3YTkk5mBQCTl8RHW+W/PqB+iQylxzaT4lk5kQ1e
 2DPALbgz+eqYFr5BKsMLv4eH337iDhMmYCXRVnFlijY1Qa0abDvfVru8ho7owzdh3dMJ90W4nOc
 SBh7jtKskUZSz7uI98JOLPBAYFOOpZTd5fmyFSQ==
X-Google-Smtp-Source: AGHT+IFhF0DpY79JBU572zGFB63YpHeRuDCMQssyM6yGYYvhPnGtkZc7p/mrg7pb5QP9mzu38lBSX5DHO1t79O4ZqJ4=
X-Received: by 2002:a17:907:20a2:b0:a59:efea:caba with SMTP id
 a640c23a62f3a-a5a2d65ed0bmr1453547766b.51.1715950931112; Fri, 17 May 2024
 06:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n> <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n> <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
In-Reply-To: <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Fri, 17 May 2024 15:01:59 +0200
Message-ID: <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Michael Galaxy <mgalaxy@akamai.com>, Peter Xu <peterx@redhat.com>, 
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>
Cc: Zheng Chuan <zhengchuan@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
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
 Pannengyuan <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::536;
 envelope-from=yu.zhang@ionos.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hello Michael and Peter,

Exactly, not so compelling, as I did it first only on servers widely
used for production in our data center. The network adapters are

Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5720
2-port Gigabit Ethernet PCIe
InfiniBand controller: Mellanox Technologies MT27800 Family [ConnectX-5]

which doesn't meet our purpose. I can choose RDMA or TCP for VM
migration. RDMA traffic is through InfiniBand and TCP through Ethernet
on these two hosts. One is standby while the other is active.

Now I'll try on a server with more recent Ethernet and InfiniBand
network adapters. One of them has:
BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (rev 01)

The comparison between RDMA and TCP on the same NIC could make more sense.

Best regards,
Yu Zhang @ IONOS Cloud







On Thu, May 16, 2024 at 7:30=E2=80=AFPM Michael Galaxy <mgalaxy@akamai.com>=
 wrote:
>
> These are very compelling results, no?
>
> (40gbps cards, right? Are the cards active/active? or active/standby?)
>
> - Michael
>
> On 5/14/24 10:19, Yu Zhang wrote:
> > Hello Peter and all,
> >
> > I did a comparison of the VM live-migration speeds between RDMA and
> > TCP/IP on our servers
> > and plotted the results to get an initial impression. Unfortunately,
> > the Ethernet NICs are not the
> > recent ones, therefore, it may not make much sense. I can do it on
> > servers with more recent Ethernet
> > NICs and keep you updated.
> >
> > It seems that the benefits of RDMA becomes obviously when the VM has
> > large memory and is
> > running memory-intensive workload.
> >
> > Best regards,
> > Yu Zhang @ IONOS Cloud
> >
> > On Thu, May 9, 2024 at 4:14=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> >> On Thu, May 09, 2024 at 04:58:34PM +0800, Zheng Chuan via wrote:
> >>> That's a good news to see the socket abstraction for RDMA!
> >>> When I was developed the series above, the most pain is the RDMA migr=
ation has no QIOChannel abstraction and i need to take a 'fake channel'
> >>> for it which is awkward in code implementation.
> >>> So, as far as I know, we can do this by
> >>> i. the first thing is that we need to evaluate the rsocket is good en=
ough to satisfy our QIOChannel fundamental abstraction
> >>> ii. if it works right, then we will continue to see if it can give us=
 opportunity to hide the detail of rdma protocol
> >>>      into rsocket by remove most of code in rdma.c and also some hack=
 in migration main process.
> >>> iii. implement the advanced features like multi-fd and multi-uri for =
rdma migration.
> >>>
> >>> Since I am not familiar with rsocket, I need some times to look at it=
 and do some quick verify with rdma migration based on rsocket.
> >>> But, yes, I am willing to involved in this refactor work and to see i=
f we can make this migration feature more better:=EF=BC=89
> >> Based on what we have now, it looks like we'd better halt the deprecat=
ion
> >> process a bit, so I think we shouldn't need to rush it at least in 9.1
> >> then, and we'll need to see how it goes on the refactoring.
> >>
> >> It'll be perfect if rsocket works, otherwise supporting multifd with l=
ittle
> >> overhead / exported APIs would also be a good thing in general with
> >> whatever approach.  And obviously all based on the facts that we can g=
et
> >> resources from companies to support this feature first.
> >>
> >> Note that so far nobody yet compared with rdma v.s. nic perf, so I hop=
e if
> >> any of us can provide some test results please do so.  Many people are
> >> saying RDMA is better, but I yet didn't see any numbers comparing it w=
ith
> >> modern TCP networks.  I don't want to have old impressions floating ar=
ound
> >> even if things might have changed..  When we have consolidated results=
, we
> >> should share them out and also reflect that in QEMU's migration docs w=
hen a
> >> rdma document page is ready.
> >>
> >> Chuan, please check the whole thread discussion, it may help to unders=
tand
> >> what we are looking for on rdma migrations [1].  Meanwhile please feel=
 free
> >> to sync with Jinpu's team and see how to move forward with such a proj=
ect.
> >>
> >> [1] https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/87f=
rwatp7n.fsf@suse.de/__;!!GjvTz_vk!QnXDo1zSlYecz7JvJky4SOQ9I8V5MoGHbINdAQAzM=
JQ_yYg_8_BSUXz9kjvbSgFefhG0wi1j38KaC3g$
> >>
> >> Thanks,
> >>
> >> --
> >> Peter Xu
> >>

