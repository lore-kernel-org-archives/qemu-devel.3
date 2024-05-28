Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4124EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 09:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBss7-0002ip-5O; Tue, 28 May 2024 05:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sBss4-0002iE-MJ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:11:52 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sBss2-0002CP-8n
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:11:52 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5296935252dso694656e87.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 02:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1716887507; x=1717492307; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8b1XVNPTN3AViNLqtsZ1RU+PWuuA/M6iRuFGZ4I739g=;
 b=Zp7OkI6zq9wzr/swPplsFXpnAK5r+fe4/g1o6ZvxeBJgktQirelmxEwg9bhLa3rs0v
 AZ+ECFIkl7aqXpMYxyt6tg/4KXUtXmbl9a2l539rllbuHYgD4gxy6naeehNeyZ880NkS
 ocJfXN4SbhD6xtE197TPi7px/n18w7hZvygqw9/ZVom/VRp1ceG5LJYCO+Aw/WPeohso
 r8R6vjU10hWVOapg/loQYwVwcLeXG4iUcShviqdITSTQ6mdFRJ7gQa5hmuPq9RQaguff
 gFhYtYW+GmxDmVFBlCsMaoChal89BtyEe9ncJCFh398wZfcx8qtaxoDXDfREMkSnTUMV
 /vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716887507; x=1717492307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8b1XVNPTN3AViNLqtsZ1RU+PWuuA/M6iRuFGZ4I739g=;
 b=b0p8cL9+iRFXo//U5k+bU8p1Di+MmnrVK0i4VFErbGXSNeN4uqjm2z2vC17TSs3ynk
 0MgxYYD7oRBokXDsxXMg+jnuT2pLKjJqgoIUkRVbLz2xOyPB8cE4YMP0++ezigfvFdSD
 F5Tn+oLXD8hYBiS7pE3ikiXnfFVKMyUCfAulnxNVa+p/dVyt818elRRJ3KPN6yL+KyZ9
 CaC7sv3XHu8zNPdM47DF5y73+YFo4TszZdya/r3V+x4xOBXDLZzHWlK6sUsdGRtrVxGx
 yvZNTBQNWtYQUdSV3cHWIFnPJgktdcvtvyHV1StSYCnXln9MHZnFTUjWoHvPjcOG14KM
 ULYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjO1saRQxLR+IFz+gU3hVKimDVqR+eedWwkYaLsTSr5tkDdiytskwKcMivtnFpHZpAoqWyH/gx6sDROxYWfxiGtxDu49A=
X-Gm-Message-State: AOJu0YxxfpsoPvG+i6F7/EAU58b7xTLFfBcZBkZD1a3i6VJFWBPXJ6sq
 xEQklhFTsn+OXT51uDOerGqaM87grk47tfAEmVJdb78isTywclYwSxhDMCq5E1w9B+djRRRv2qo
 g5q3OsjJdlcVGln7izDnkMmDbBqG+5n3a+4wbKg==
X-Google-Smtp-Source: AGHT+IHow/rrXPpnY6FyssuhZZq9j3N2/ZhTftNcERfAcxLJRIFCxgpyrhc36BjsrTKu5AWP4A40XFhzkgx4Nn0aDzQ=
X-Received: by 2002:a05:6512:3a93:b0:529:b3c9:7261 with SMTP id
 2adb3069b0e04-529b3c97397mr3151037e87.5.1716887506900; Tue, 28 May 2024
 02:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n> <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n> <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n> <2308a8b894244123b638038e40a33990@huawei.com>
In-Reply-To: <2308a8b894244123b638038e40a33990@huawei.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 28 May 2024 11:11:35 +0200
Message-ID: <CAMGffEmK5QNPisU8uM_GLzTtY8LgimOtyY+d3GJV-bLPH9-FqQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Peter Xu <peterx@redhat.com>, Yu Zhang <yu.zhang@ionos.com>, 
 Michael Galaxy <mgalaxy@akamai.com>, Elmar Gerdes <elmar.gerdes@ionos.com>, 
 zhengchuan <zhengchuan@huawei.com>,
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
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::135;
 envelope-from=jinpu.wang@ionos.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Hi Gonglei,

On Tue, May 28, 2024 at 11:06=E2=80=AFAM Gonglei (Arei) <arei.gonglei@huawe=
i.com> wrote:
>
> Hi Peter,
>
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Wednesday, May 22, 2024 6:15 AM
> > To: Yu Zhang <yu.zhang@ionos.com>
> > Cc: Michael Galaxy <mgalaxy@akamai.com>; Jinpu Wang
> > <jinpu.wang@ionos.com>; Elmar Gerdes <elmar.gerdes@ionos.com>;
> > zhengchuan <zhengchuan@huawei.com>; Gonglei (Arei)
> > <arei.gonglei@huawei.com>; Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>;
> > Markus Armbruster <armbru@redhat.com>; Zhijian Li (Fujitsu)
> > <lizhijian@fujitsu.com>; qemu-devel@nongnu.org; Yuval Shaia
> > <yuval.shaia.ml@gmail.com>; Kevin Wolf <kwolf@redhat.com>; Prasanna
> > Kumar Kalever <prasanna.kalever@redhat.com>; Cornelia Huck
> > <cohuck@redhat.com>; Michael Roth <michael.roth@amd.com>; Prasanna
> > Kumar Kalever <prasanna4324@gmail.com>; Paolo Bonzini
> > <pbonzini@redhat.com>; qemu-block@nongnu.org; devel@lists.libvirt.org;
> > Hanna Reitz <hreitz@redhat.com>; Michael S. Tsirkin <mst@redhat.com>;
> > Thomas Huth <thuth@redhat.com>; Eric Blake <eblake@redhat.com>; Song
> > Gao <gaosong@loongson.cn>; Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com>; Alex Benn=C3=A9e <alex.bennee@linaro.org=
>;
> > Wainer dos Santos Moschetta <wainersm@redhat.com>; Beraldo Leal
> > <bleal@redhat.com>; Pannengyuan <pannengyuan@huawei.com>;
> > Xiexiangyou <xiexiangyou@huawei.com>; Fabiano Rosas <farosas@suse.de>
> > Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol han=
dling
> >
> > On Fri, May 17, 2024 at 03:01:59PM +0200, Yu Zhang wrote:
> > > Hello Michael and Peter,
> >
> > Hi,
> >
> > >
> > > Exactly, not so compelling, as I did it first only on servers widely
> > > used for production in our data center. The network adapters are
> > >
> > > Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5720
> > > 2-port Gigabit Ethernet PCIe
> >
> > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks more reaso=
nable.
> >
> > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda15
> > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> >
> > Appreciate a lot for everyone helping on the testings.
> >
> > > InfiniBand controller: Mellanox Technologies MT27800 Family
> > > [ConnectX-5]
> > >
> > > which doesn't meet our purpose. I can choose RDMA or TCP for VM
> > > migration. RDMA traffic is through InfiniBand and TCP through Etherne=
t
> > > on these two hosts. One is standby while the other is active.
> > >
> > > Now I'll try on a server with more recent Ethernet and InfiniBand
> > > network adapters. One of them has:
> > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (rev 01)
> > >
> > > The comparison between RDMA and TCP on the same NIC could make more
> > sense.
> >
> > It looks to me NICs are powerful now, but again as I mentioned I don't =
think it's
> > a reason we need to deprecate rdma, especially if QEMU's rdma migration=
 has
> > the chance to be refactored using rsocket.
> >
> > Is there anyone who started looking into that direction?  Would it make=
 sense
> > we start some PoC now?
> >
>
> My team has finished the PoC refactoring which works well.
>
> Progress:
> 1.  Implement io/channel-rdma.c,
> 2.  Add unit test tests/unit/test-io-channel-rdma.c and verifying it is s=
uccessful,
> 3.  Remove the original code from migration/rdma.c,
> 4.  Rewrite the rdma_start_outgoing_migration and rdma_start_incoming_mig=
ration logic,
> 5.  Remove all rdma_xxx functions from migration/ram.c. (to prevent RDMA =
live migration from polluting the core logic of live migration),
> 6.  The soft-RoCE implemented by software is used to test the RDMA live m=
igration. It's successful.
>
> We will be submit the patchset later.
>
Thanks for working on this PoC, and sharing progress on this, we are
looking forward for the patchset.

>
> Regards,
> -Gonglei
Regards!
Jinpu
>
> > Thanks,
> >
> > --
> > Peter Xu
>

