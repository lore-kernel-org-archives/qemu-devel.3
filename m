Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EDBCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpf7-0006Im-01; Mon, 08 Apr 2024 10:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1rtpeq-0006I5-OV
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:07:39 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1rtpeo-0001DR-HB
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:07:36 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e477db7fbso2741029a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1712585251; x=1713190051; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+hGM87BtBvSpwNniHg0n6rNHcamqNzQ0ccQaSA8XBU=;
 b=E+EPLLxOc0M3TwJnKIj97HutyACU1TIX9y7w5+Z8XzPtPSkFEns4jgwZX5IArZsLqY
 ab4Xyq3GBbzYU/uvBq/0M1XL1jhJm34nee35bdH1sQpepOWqhK8E034EMB0S42W4nBwJ
 8UNrWLM93x1q5kxhED+5ITeC1neNhYr5hdHH6T2mjEWgRCJQR6dKw4Ex3GcH9aY1j5jq
 5ur3PW/fOuUqDl+0bn2qAS0bH8VdgielPZqtZu0eq9BweijT/v1ehlGqC8ohTvibHXW8
 uo+Tm34kxQ7ZWLpScTRUPW4/hW+SOk2lqrqFlVA6emdmF38w5vpPGgUW/7rqgtM9obcu
 dSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585251; x=1713190051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+hGM87BtBvSpwNniHg0n6rNHcamqNzQ0ccQaSA8XBU=;
 b=OKyDovwRHtWie8w81sM8Db8SPjOPEqBuyqXGb6HIOaXyr8RhVi7iXVJNcpP/AQHJQo
 np0T3aVEqPQIOQ0Oj0nFeRhiOXIMAxi/5MWpQVyBMP9UF/QO1OOMmBhKMkJp8vip7Kny
 B6St/IlttPsGFY8jjZFXi+48EcQTS+g1OdiZjM6jwySq0MLWKK3yCdxXCASUqlP2dm7H
 YlJV2jqw1RxevlWFRI8/djL3DmxkpzXA3rlRkspLzhfFQii0Hz0pQgkrzifSlrz88jAR
 WBaoUcaFSqQ93JZNPQwn4RRER36ay80fdCZL/4CeEBx8YAKzezogEEmdA56pTrWx4mT+
 jlvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmLv9sX8rb7eVuRWIexmKKEyGRY6A2vyYtYuDExho4g560EW0mibvDSpdL6OB0Zfc6Xk+sXJeADl3K+vDC1ZRjjCJUBIg=
X-Gm-Message-State: AOJu0Yw5dXQX9VB9GxVP1qn690B4xKPZ9SZYYbq8fXdLsdQNR4Pq3Nl0
 CXjCaw+CBGSFl2tRofvqSxOUjp3i8LlZtCpzAHfDGByqZ/FI2iYYIVx3GudEgt9mteqy5v7hW8J
 ZdYLh8fm6JaXqN//JiL8+XJLBzbZEDvrce8YMqw==
X-Google-Smtp-Source: AGHT+IE7rVdvFSHPykOhV+0zuFO68vddd8mXwvRIJhlWpMAH/r8b/Xoy5HMNmpzwBFtSuc8LL0+B521khUfIHx6Perc=
X-Received: by 2002:a50:955b:0:b0:56d:f979:8d82 with SMTP id
 v27-20020a50955b000000b0056df9798d82mr6093811eda.25.1712585250991; Mon, 08
 Apr 2024 07:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org>
 <87frwatp7n.fsf@suse.de> <ZgWGMmUTq0jqSUvr@x1n>
 <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
In-Reply-To: <Zgx3brrz8m0V7HS4@x1n>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 8 Apr 2024 16:07:20 +0200
Message-ID: <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Peter Xu <peterx@redhat.com>
Cc: Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, 
 Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, 
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com, 
 pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::531;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x531.google.com
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

Hi Peter,

On Tue, Apr 2, 2024 at 11:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Apr 01, 2024 at 11:26:25PM +0200, Yu Zhang wrote:
> > Hello Peter und Zhjian,
> >
> > Thank you so much for letting me know about this. I'm also a bit surpri=
sed at
> > the plan for deprecating the RDMA migration subsystem.
>
> It's not too late, since it looks like we do have users not yet notified
> from this, we'll redo the deprecation procedure even if it'll be the fina=
l
> plan, and it'll be 2 releases after this.
>
> >
> > > IMHO it's more important to know whether there are still users and wh=
ether
> > > they would still like to see it around.
> >
> > > I admit RDMA migration was lack of testing(unit/CI test), which led t=
o the a few
> > > obvious bugs being noticed too late.
> >
> > Yes, we are a user of this subsystem. I was unaware of the lack of test=
 coverage
> > for this part. As soon as 8.2 was released, I saw that many of the
> > migration test
> > cases failed and came to realize that there might be a bug between 8.1
> > and 8.2, but
> > was unable to confirm and report it quickly to you.
> >
> > The maintenance of this part could be too costly or difficult from
> > your point of view.
>
> It may or may not be too costly, it's just that we need real users of RDM=
A
> taking some care of it.  Having it broken easily for >1 releases definite=
ly
> is a sign of lack of users.  It is an implication to the community that w=
e
> should consider dropping some features so that we can get the best use of
> the community resources for the things that may have a broader audience.
>
> One thing majorly missing is a RDMA tester to guard all the merges to not
> break RDMA paths, hopefully in CI.  That should not rely on RDMA hardware=
s
> but just to sanity check the migration+rdma code running all fine.  RDMA
> taught us the lesson so we're requesting CI coverage for all other new
> features that will be merged at least for migration subsystem, so that we
> plan to not merge anything that is not covered by CI unless extremely
> necessary in the future.
>
> For sure CI is not the only missing part, but I'd say we should start wit=
h
> it, then someone should also take care of the code even if only in
> maintenance mode (no new feature to add on top).
>
> >
> > My concern is, this plan will forces a few QEMU users (not sure how
> > many) like us
> > either to stick to the RDMA migration by using an increasingly older
> > version of QEMU,
> > or to abandon the currently used RDMA migration.
>
> RDMA doesn't get new features anyway, if there's specific use case for RD=
MA
> migrations, would it work if such a scenario uses the old binary?  Is it
> possible to switch to the TCP protocol with some good NICs?
We have used rdma migration with HCA from Nvidia for years, our
experience is RDMA migration works better than tcp (over ipoib).

Switching back to TCP will lead us to the old problems which was
solved by RDMA migration.

>
> Per our best knowledge, RDMA users are rare, and please let anyone know i=
f
> you are aware of such users.  IIUC the major reason why RDMA stopped bein=
g
> the trend is because the network is not like ten years ago; I don't think=
 I
> have good knowledge in RDMA at all nor network, but my understanding is
> it's pretty easy to fetch modern NIC to outperform RDMAs, then it may mak=
e
> little sense to maintain multiple protocols, considering RDMA migration
> code is so special so that it has the most custom code comparing to other
> protocols.
+cc some guys from Huawei.

I'm surprised RDMA users are rare,  I guess maybe many are just
working with different code base.
>
> Thanks,
>
> --
> Peter Xu

Thx!
Jinpu Wang
>

