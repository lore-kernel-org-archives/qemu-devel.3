Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F2DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 14:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvdX-0005CD-2s; Thu, 11 Apr 2024 10:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1ruvdV-0005Bf-8H
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:42:45 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1ruvdP-0003Nt-5C
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:42:44 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e6acb39d4so5366035a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1712846555; x=1713451355; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4shD10zRZcwjNa/95pykl9Qu4TmYKIURxORU2sAFcWk=;
 b=U70K3T6WllblihlaL3lnN/AtOJJzg2tdpHqQKk9ms6G963GhYYymwplPWFidhEq9zS
 GDXNuXpGiYhru74pe4di1fwMxmQGHXs3mU95m0mrODYds8PTTKlrjJJEbYkJsNSExR77
 HvkzZwBfZ90jzWfLPbTnPcFxu5BAl6PEtVOOTfXhAAdC55RYFxYK3ouaR6kdOs1u01jz
 XngZmeECmWQQkB3plWo2FIwXtgO8xac8QWmXNDUqQPRJl9jjFxREmNGGre2LVR1X3m/n
 Ih4rS5sqalbPO9HQ55+mX1Yxe5AHn2PELotZ84R8VkSVINBEfX6eJsBG5U6oGog4o8hK
 eJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712846555; x=1713451355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4shD10zRZcwjNa/95pykl9Qu4TmYKIURxORU2sAFcWk=;
 b=PZTDhRlNE936gihF6EsKgNdDWzGKeQoWgvH9VBSW8KBjV43Frgo0htHLvHX01PdqtG
 NbzWyQQW3pU/MUdHbdmP8079G+JpP3I1DrB497qAppDDwvEIYNWIy5Lx9Gz3dyNO3vSW
 RMWr/WEZHkBhK5s62hZ17yd90JIeoZUONuXxmAowZYMN1Ytd3zCJgsbiCgwAvo6EsKwC
 kTdH6rTRFUiblm033aIJZi6hpZ/0BELa89j0goZdaAuXmKEQKKTwUf5grDUhl3ORWD36
 ZA40xAl+ROfQrCvYUpOXtjCQtYsGKiVH6nacn0Wb0hlq1qT3xWS8mM3pNwtBx3hSUwCT
 ONmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgrdJREo+wYiUXVxpvCzuBVRPWy10N/mvAnvdMHm5ISaJ6+2jn0YfaHTs66EIxFCvwWm9sccF/uKIjYZLfVU+52LaEOdw=
X-Gm-Message-State: AOJu0YxWRNNBis9C16KcyA1nSehFVAK+Qmfvkxz5ObQRu0yJovK1Zme2
 HcYZhbwEMJ0jM9IhN0jLLo5bq5a2EQybvJYk4VEyEpfcMNUwXOX9a66bu+VbISk2J8LCu9/RFQo
 7ogDpiJJIa8kT7XJ/KBlXPvCDqap5+dI14VYvIw==
X-Google-Smtp-Source: AGHT+IHxua1I5T2LBtzrf7g5VnUa0dPC5Gpthf7n9U+Fpa7bhV7xXJQ0kNihQciYKiE/p99qLoCdN3T40xL/VqhPeSE=
X-Received: by 2002:a50:cc9d:0:b0:56e:2b31:b111 with SMTP id
 q29-20020a50cc9d000000b0056e2b31b111mr13278edi.7.1712846554971; Thu, 11 Apr
 2024 07:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <87frwatp7n.fsf@suse.de> <ZgWGMmUTq0jqSUvr@x1n>
 <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n>
In-Reply-To: <ZhWa0YeAb9ySVKD1@x1n>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 11 Apr 2024 16:42:23 +0200
Message-ID: <CAMGffEkPyByEdXpEuGfZsx-j91Wf9gLcGoEuDgdxutpOhpuOYQ@mail.gmail.com>
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
Received-SPF: permerror client-ip=2a00:1450:4864:20::534;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Peter,

On Tue, Apr 9, 2024 at 9:47=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 09, 2024 at 09:32:46AM +0200, Jinpu Wang wrote:
> > Hi Peter,
> >
> > On Mon, Apr 8, 2024 at 6:18=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Mon, Apr 08, 2024 at 04:07:20PM +0200, Jinpu Wang wrote:
> > > > Hi Peter,
> > >
> > > Jinpu,
> > >
> > > Thanks for joining the discussion.
> > >
> > > >
> > > > On Tue, Apr 2, 2024 at 11:24=E2=80=AFPM Peter Xu <peterx@redhat.com=
> wrote:
> > > > >
> > > > > On Mon, Apr 01, 2024 at 11:26:25PM +0200, Yu Zhang wrote:
> > > > > > Hello Peter und Zhjian,
> > > > > >
> > > > > > Thank you so much for letting me know about this. I'm also a bi=
t surprised at
> > > > > > the plan for deprecating the RDMA migration subsystem.
> > > > >
> > > > > It's not too late, since it looks like we do have users not yet n=
otified
> > > > > from this, we'll redo the deprecation procedure even if it'll be =
the final
> > > > > plan, and it'll be 2 releases after this.
> > > > >
> > > > > >
> > > > > > > IMHO it's more important to know whether there are still user=
s and whether
> > > > > > > they would still like to see it around.
> > > > > >
> > > > > > > I admit RDMA migration was lack of testing(unit/CI test), whi=
ch led to the a few
> > > > > > > obvious bugs being noticed too late.
> > > > > >
> > > > > > Yes, we are a user of this subsystem. I was unaware of the lack=
 of test coverage
> > > > > > for this part. As soon as 8.2 was released, I saw that many of =
the
> > > > > > migration test
> > > > > > cases failed and came to realize that there might be a bug betw=
een 8.1
> > > > > > and 8.2, but
> > > > > > was unable to confirm and report it quickly to you.
> > > > > >
> > > > > > The maintenance of this part could be too costly or difficult f=
rom
> > > > > > your point of view.
> > > > >
> > > > > It may or may not be too costly, it's just that we need real user=
s of RDMA
> > > > > taking some care of it.  Having it broken easily for >1 releases =
definitely
> > > > > is a sign of lack of users.  It is an implication to the communit=
y that we
> > > > > should consider dropping some features so that we can get the bes=
t use of
> > > > > the community resources for the things that may have a broader au=
dience.
> > > > >
> > > > > One thing majorly missing is a RDMA tester to guard all the merge=
s to not
> > > > > break RDMA paths, hopefully in CI.  That should not rely on RDMA =
hardwares
> > > > > but just to sanity check the migration+rdma code running all fine=
.  RDMA
> > > > > taught us the lesson so we're requesting CI coverage for all othe=
r new
> > > > > features that will be merged at least for migration subsystem, so=
 that we
> > > > > plan to not merge anything that is not covered by CI unless extre=
mely
> > > > > necessary in the future.
> > > > >
> > > > > For sure CI is not the only missing part, but I'd say we should s=
tart with
> > > > > it, then someone should also take care of the code even if only i=
n
> > > > > maintenance mode (no new feature to add on top).
> > > > >
> > > > > >
> > > > > > My concern is, this plan will forces a few QEMU users (not sure=
 how
> > > > > > many) like us
> > > > > > either to stick to the RDMA migration by using an increasingly =
older
> > > > > > version of QEMU,
> > > > > > or to abandon the currently used RDMA migration.
> > > > >
> > > > > RDMA doesn't get new features anyway, if there's specific use cas=
e for RDMA
> > > > > migrations, would it work if such a scenario uses the old binary?=
  Is it
> > > > > possible to switch to the TCP protocol with some good NICs?
> > > > We have used rdma migration with HCA from Nvidia for years, our
> > > > experience is RDMA migration works better than tcp (over ipoib).
> > >
> > > Please bare with me, as I know little on rdma stuff.
> > >
> > > I'm actually pretty confused (and since a long time ago..) on why we =
need
> > > to operation with rdma contexts when ipoib seems to provide all the t=
cp
> > > layers.  I meant, can it work with the current "tcp:" protocol with i=
poib
> > > even if there's rdma/ib hardwares underneath?  Is it because of perfo=
rmance
> > > improvements so that we must use a separate path comparing to generic
> > > "tcp:" protocol here?
> > using rdma protocol with ib verbs , we can leverage the full benefit of=
 RDMA by
> > talking directly to NIC which bypasses the kernel overhead, less cpu
> > utilization and better performance.
> >
> > While IPoIB is more for compatibility to  applications using tcp, but
> > can't get full benefit of RDMA.  When you have mix generation of IB
> > devices, there are performance issue on IPoIB, we've seen 40G HCA can
> > only reach 2 Gb/s on IPoIB, but with raw RDMA can reach full line
> > speed.
> >
> > I just run a simple iperf3 test via ipoib and ib_send_bw on same hosts:
> >
> > iperf 3.9
> > Linux ps404a-3 5.15.137-pserver #5.15.137-6~deb11 SMP Thu Jan 4
> > 07:19:34 UTC 2024 x86_64
> > -----------------------------------------------------------
> > Server listening on 5201
> > -----------------------------------------------------------
> > Time: Tue, 09 Apr 2024 06:55:02 GMT
> > Accepted connection from 2a02:247f:401:4:2:0:b:3, port 41130
> >       Cookie: cer2hexlldrowclq6izh7gbg5toviffqbcwt
> >       TCP MSS: 0 (default)
> > [  5] local 2a02:247f:401:4:2:0:a:3 port 5201 connected to
> > 2a02:247f:401:4:2:0:b:3 port 41136
> > Starting Test: protocol: TCP, 1 streams, 131072 byte blocks, omitting
> > 0 seconds, 10 second test, tos 0
> > [ ID] Interval           Transfer     Bitrate
> > [  5]   0.00-1.00   sec  1.80 GBytes  15.5 Gbits/sec
> > [  5]   1.00-2.00   sec  1.85 GBytes  15.9 Gbits/sec
> > [  5]   2.00-3.00   sec  1.88 GBytes  16.2 Gbits/sec
> > [  5]   3.00-4.00   sec  1.87 GBytes  16.1 Gbits/sec
> > [  5]   4.00-5.00   sec  1.88 GBytes  16.2 Gbits/sec
> > [  5]   5.00-6.00   sec  1.93 GBytes  16.6 Gbits/sec
> > [  5]   6.00-7.00   sec  2.00 GBytes  17.2 Gbits/sec
> > [  5]   7.00-8.00   sec  1.93 GBytes  16.6 Gbits/sec
> > [  5]   8.00-9.00   sec  1.86 GBytes  16.0 Gbits/sec
> > [  5]   9.00-10.00  sec  1.95 GBytes  16.8 Gbits/sec
> > [  5]  10.00-10.04  sec  85.2 MBytes  17.3 Gbits/sec
> > - - - - - - - - - - - - - - - - - - - - - - - - -
> > Test Complete. Summary Results:
> > [ ID] Interval           Transfer     Bitrate
> > [  5] (sender statistics not available)
> > [  5]   0.00-10.04  sec  19.0 GBytes  16.3 Gbits/sec                  r=
eceiver
> > rcv_tcp_congestion cubic
> > iperf 3.9
> > Linux ps404a-3 5.15.137-pserver #5.15.137-6~deb11 SMP Thu Jan 4
> > 07:19:34 UTC 2024 x86_64
> > -----------------------------------------------------------
> > Server listening on 5201
> > -----------------------------------------------------------
> > ^Ciperf3: interrupt - the server has terminated
> > 1 jwang@ps404a-3.stg:~$ sudo ib_send_bw -F -a
> >
> > ************************************
> > * Waiting for client to connect... *
> > ************************************
> > -----------------------------------------------------------------------=
----------------
> >                     Send BW Test
> >  Dual-port       : OFF Device         : mlx5_0
> >  Number of qps   : 1 Transport type : IB
> >  Connection type : RC Using SRQ      : OFF
> >  PCIe relax order: ON
> >  ibv_wr* API     : ON
> >  RX depth        : 512
> >  CQ Moderation   : 100
> >  Mtu             : 4096[B]
> >  Link type       : IB
> >  Max inline data : 0[B]
> >  rdma_cm QPs : OFF
> >  Data ex. method : Ethernet
> > -----------------------------------------------------------------------=
----------------
> >  local address: LID 0x24 QPN 0x0174 PSN 0x300138
> >  remote address: LID 0x17 QPN 0x004a PSN 0xc54d6f
> > -----------------------------------------------------------------------=
----------------
> >  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgR=
ate[Mpps]
> >  2          1000             0.00               6.46       3.385977
> >  4          1000             0.00               10.38     2.721894
> >  8          1000             0.00               25.69     3.367830
> >  16         1000             0.00               41.46     2.716859
> >  32         1000             0.00               102.98    3.374577
> >  64         1000             0.00               206.12    3.377053
> >  128        1000             0.00               405.03    3.318007
> >  256        1000             0.00               821.52    3.364939
> >  512        1000             0.00               2150.78    4.404803
> >  1024       1000             0.00               4288.13    4.391044
> >  2048       1000             0.00               8518.25    4.361346
> >  4096       1000             0.00               11440.77    2.928836
> >  8192       1000             0.00               11526.45    1.475385
> >  16384      1000             0.00               11526.06    0.737668
> >  32768      1000             0.00               11524.86    0.368795
> >  65536      1000             0.00               11331.84    0.181309
> >  131072     1000             0.00               11524.75    0.092198
> >  262144     1000             0.00               11525.82    0.046103
> >  524288     1000             0.00               11524.70    0.023049
> >  1048576    1000             0.00               11510.84    0.011511
> >  2097152    1000             0.00               11524.58    0.005762
> >  4194304    1000             0.00               11514.26    0.002879
> >  8388608    1000             0.00               11511.01    0.001439
> > -----------------------------------------------------------------------=
----------------
> >
> > you can see with ipoib, it reaches 16 Gb/s using TCP, 1 streams,
> > 131072 byte blocks
> > with RDMA at 4k+ message size it reaches 100 Gb/s
>
> I get it now, thank you!
>
> >
> >
> > >
> > > >
> > > > Switching back to TCP will lead us to the old problems which was
> > > > solved by RDMA migration.
> > >
> > > Can you elaborate the problems, and why tcp won't work in this case? =
 They
> > > may not be directly relevant to the issue we're discussing, but I'm h=
appy
> > > to learn more.
> > >
> > > What is the NICs you were testing before?  Did the test carry out wit=
h
> > > things like modern ones (50Gbps-200Gbps NICs), or the test was done w=
hen
> > > these hardwares are not common?
> > We use Mellanox/NVidia IB HCA from 40 Gb/s to 200 Gb/s mixed
> > generation across globe.
> > >
> > > Per my recent knowledge on the new Intel hardwares, at least the ones=
 that
> > > support QPL, it's easy to achieve single core 50Gbps+.
> > In good case, I've also seen 50 Gbps + on Mellanox HCA.
>
> I see. Have you compared the HCAs v.s. the modern NICs?  Now NICs can
> achieve similar performance from their spec as I said; I am not sure how
> they perform in real life, but maybe worth trying.  I only tried 100G nic
> and I rem I can hit 70+Gbps with multifd migrations at peak bandwidth.
> Have you tried that before?
Yes, I recently tried 100 G Eth NIC, with only iperf not yet with qemu
migration.
yes, iperf can reach 90 Gbps with multiple streams.
>
> Note that here I didn't want to compare the performance between the two a=
nd
> find a winner.  The issue we're facing now is we have the RDMA migration
> now mostly having its own path all over the place, while the rest protoco=
ls
> (socket, fd, file, etc.) all share the rest.
>
> Then, _if_ modern NICs can work similarly v.s. rdma, I don't yet see a go=
od
> reason to keep it.  It could be that technology just improved so we can u=
se
> less code to do as good.  It's a good news to help QEMU evolve by droppin=
g
> unused code.
>
> For some details there on the rdma complications for migration:
>
>   (1) RDMA is the only protocol that doesn't yet support QIOChannel, whil=
e
>       migration uses QIOChannels mostly everywhere now.. e.g. in multifd,
>       it means it won't easily support any new things using QIOChannels.
>
>   (2) RDMA is the only protocol that mostly hard-coded everywhere in the
>       RAM migrations, polluting the core logic with much more code
>       internally to support this protocol.
>
> For (1), see migrate_fd_connect() from rdma_start_outgoing_migration().
> While the rest protocols all go via migration_channel_connect().
>
> For (2), see all the "rdma_*" functions in migration/ram.c, where I don't
> think it's common to a protocol - most of the rest protocols don't need
> those hard-coded stuff.  migration/rdma.c has 4000+ LOC for these stuff,
> while to do a not-so-fair comparison, migration/fd.c only has <100 LOC.
>
> Then, we found we don't even know who's using it.
>
> I hope I explained why people started this idea, and also why I think tha=
t
> makes sense at least to me.
Yes, I can understand rdma migration become more a burden for upstream
maintainers.
>
> > >
> > > https://lore.kernel.org/r/PH7PR11MB5941A91AC1E514BCC32896A6A3342@PH7P=
R11MB5941.namprd11.prod.outlook.com
> > >
> > > Quote from Yuan:
> > >
> > >   Yes, I use iperf3 to check the bandwidth for one core, the bandwith=
 is 60Gbps.
> > >   [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > >   [  5]   0.00-1.00   sec  7.00 GBytes  60.1 Gbits/sec    0   2.87 MB=
ytes
> > >   [  5]   1.00-2.00   sec  7.05 GBytes  60.6 Gbits/sec    0   2.87 Mb=
ytes
> > >
> > >   And in the live migration test, a multifd thread's CPU utilization =
is almost 100%
> > >
> > > It boils down to what old problems were there with tcp first, though.
> > Yeah, this is the key reason we use RDMA. (low cpu ulitization and
> > better performance)
> > >
> > > >
> > > > >
> > > > > Per our best knowledge, RDMA users are rare, and please let anyon=
e know if
> > > > > you are aware of such users.  IIUC the major reason why RDMA stop=
ped being
> > > > > the trend is because the network is not like ten years ago; I don=
't think I
> > > > > have good knowledge in RDMA at all nor network, but my understand=
ing is
> > > > > it's pretty easy to fetch modern NIC to outperform RDMAs, then it=
 may make
> > > > > little sense to maintain multiple protocols, considering RDMA mig=
ration
> > > > > code is so special so that it has the most custom code comparing =
to other
> > > > > protocols.
> > > > +cc some guys from Huawei.
> > > >
> > > > I'm surprised RDMA users are rare,  I guess maybe many are just
> > > > working with different code base.
> > >
> > > Yes, please cc whoever might be interested (or surprised.. :) to know=
 this,
> > > and let's be open to all possibilities.
> > >
> > > I don't think it makes sense if there're a lot of users of a feature =
then
> > > we deprecate that without a good reason.  However there's always the
> > > resource limitation issue we're facing, so it could still have the
> > > possibility that this gets deprecated if nobody is working on our ups=
tream
> > > branch. Say, if people use private branches anyway to support rdma wi=
thout
> > > collaborating upstream, keeping such feature upstream then may not ma=
ke
> > > much sense either, unless there's some way to collaborate.  We'll see=
.
> >
> > Is there document/link about the unittest/CI for migration tests, Why
> > are those tests missing?
> > Is it hard or very special to set up an environment for that? maybe we
> > can help in this regards.
>
> See tests/qtest/migration-test.c.  We put most of our migration tests
> there and that's covered in CI.
Yu is looking into that see if we can run the CI on our side.
>
> I think one major issue is CI systems don't normally have rdma devices.
> Can rdma migration test be carried out without a real hardware?
As Zhijian mentioned we can use the SoftRoCE (rxe)
>
> > >
> > > It seems there can still be people joining this discussion.  I'll hol=
d off
> > > a bit on merging this patch to provide enough window for anyone to ch=
im in.
> >
> > Thx for discussion and understanding.
>
> Thanks for all these inputs so far.  These can help us make a wiser and
> clearer step no matter which way we choose.
>
> --
> Peter Xu
>
Thx!

