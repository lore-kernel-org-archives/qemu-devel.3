Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92242C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 04:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCB0a-00081W-ET; Wed, 29 May 2024 00:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sCB0W-00080i-F4
 for qemu-devel@nongnu.org; Wed, 29 May 2024 00:33:49 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sCB0U-0007SK-4n
 for qemu-devel@nongnu.org; Wed, 29 May 2024 00:33:48 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f463so808071a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 21:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1716957223; x=1717562023; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vgbrgm9oN3J4LdRd0FzNOIpeae3tCUcQtmI86SumNi8=;
 b=bHA0JbneClUo7IqCEUT42yISqzUhUVxsU0FRQmaiRCjqolKngW4jCVOQU9Qnr+ZzxF
 6SDqacVbijMKKnEECBzI37NNR0EXViWxlcqbHT/Hr1BUWLA5xLJxeajWA5ydjcWyz1Bp
 G2BibxQgVVZmhOPkbdYM7NA1+S/tnQOl1MgNK0RssCaRBIaU2BaYFgJXoSXYSNu6Rmt+
 A9KQlq3OkRVZmdI0y/1Z3Xotwu5sjLzP8BUUCiQRAVm5SCZqBrt/oBGOUZD6C2jHwxla
 oIYNf9BmTv+nZMDqRPWRW5YgRI8clTxCceQUcRqHMzNun4E49Dq/RVYWx9+tYB0Fwpym
 DZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716957223; x=1717562023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vgbrgm9oN3J4LdRd0FzNOIpeae3tCUcQtmI86SumNi8=;
 b=PFTd77NKsHkKZnfmQNcO0fgrOxDAwlqt+uAUqCXqJq+fZtFqEFpdqNlINE/mVUWcaE
 +TgBl+XsdYQK3QU+AqvtEQJ8VtV/9qhKi0RTGerbaAkA2ms6I50OeVwIKZB1Mz1RfYUE
 T20IVjHiN0M626hn1qoNw//LcXzhUUyx7g0pbaJO57FsDdka2ib2J6lsGHrbApapOlqi
 dbIeiOA15q93N6vSz0WfWbyNeZ0mHoBftRS1lzIe0ITtfmmtOrqQeiOvSf6HIUShUzGw
 L4kpAhoc67yN4zc6NNczYjfe1Puxbu4klpmavwR7ncrdOAhMdfGF3PH5TG/jaNIgvwns
 OaVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnxhcFny434PW6zzdnF2Lp+AX0ryHHOOEi2k/BknTN07opPkD0cKrrhgsf41Fpc0E5+rgUVRFfML31c8phVj9y/+pYSgk=
X-Gm-Message-State: AOJu0YymXD0P1ogmXz90W+eLFjaGmNSP5Pu/SaWCj20oV6y1zsyhzHc4
 POqEnhe5kj0q7oTIuLkyYHaJ27lGFdnrzMUyiuzGU1A+9/JCyslG7fZTT0xhXWm+0lvCl1wkJFM
 gkuQzKL2j6woFqfa6HC9C+aGdVhsIvyqH/ppbIg==
X-Google-Smtp-Source: AGHT+IGAryn3arceUC635cfwoAvOXPpWFnbmIdw+E8kjjK6Wq/qFCx+Tv9/wBRf6Jag06COBE4amUVuEf9vRktTeJ98=
X-Received: by 2002:a50:d49e:0:b0:578:5dc5:a4fb with SMTP id
 4fb4d7f45d1cf-5785dc5a6f2mr9117151a12.32.1716957223300; Tue, 28 May 2024
 21:33:43 -0700 (PDT)
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
In-Reply-To: <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 29 May 2024 06:33:32 +0200
Message-ID: <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
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

On Wed, May 29, 2024 at 4:43=E2=80=AFAM Gonglei (Arei) <arei.gonglei@huawei=
.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Tuesday, May 28, 2024 11:55 PM
> > > > > Exactly, not so compelling, as I did it first only on servers
> > > > > widely used for production in our data center. The network
> > > > > adapters are
> > > > >
> > > > > Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> > > > > BCM5720 2-port Gigabit Ethernet PCIe
> > > >
> > > > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks more
> > reasonable.
> > > >
> > > >
> > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda15
> > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > >
> > > > Appreciate a lot for everyone helping on the testings.
> > > >
> > > > > InfiniBand controller: Mellanox Technologies MT27800 Family
> > > > > [ConnectX-5]
> > > > >
> > > > > which doesn't meet our purpose. I can choose RDMA or TCP for VM
> > > > > migration. RDMA traffic is through InfiniBand and TCP through
> > > > > Ethernet on these two hosts. One is standby while the other is ac=
tive.
> > > > >
> > > > > Now I'll try on a server with more recent Ethernet and InfiniBand
> > > > > network adapters. One of them has:
> > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (rev 01)
> > > > >
> > > > > The comparison between RDMA and TCP on the same NIC could make
> > > > > more
> > > > sense.
> > > >
> > > > It looks to me NICs are powerful now, but again as I mentioned I
> > > > don't think it's a reason we need to deprecate rdma, especially if
> > > > QEMU's rdma migration has the chance to be refactored using rsocket=
.
> > > >
> > > > Is there anyone who started looking into that direction?  Would it
> > > > make sense we start some PoC now?
> > > >
> > >
> > > My team has finished the PoC refactoring which works well.
> > >
> > > Progress:
> > > 1.  Implement io/channel-rdma.c,
> > > 2.  Add unit test tests/unit/test-io-channel-rdma.c and verifying it
> > > is successful, 3.  Remove the original code from migration/rdma.c, 4.
> > > Rewrite the rdma_start_outgoing_migration and
> > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xxx function=
s
> > > from migration/ram.c. (to prevent RDMA live migration from polluting =
the
> > core logic of live migration), 6.  The soft-RoCE implemented by softwar=
e is
> > used to test the RDMA live migration. It's successful.
> > >
> > > We will be submit the patchset later.
> >
> > That's great news, thank you!
> >
> > --
> > Peter Xu
>
> For rdma programming, the current mainstream implementation is to use rdm=
a_cm to establish a connection, and then use verbs to transmit data.
>
> rdma_cm and ibverbs create two FDs respectively. The two FDs have differe=
nt responsibilities. rdma_cm fd is used to notify connection establishment =
events,
> and verbs fd is used to notify new CQEs. When poll/epoll monitoring is di=
rectly performed on the rdma_cm fd, only a pollin event can be monitored, w=
hich means
> that an rdma_cm event occurs. When the verbs fd is directly polled/epolle=
d, only the pollin event can be listened, which indicates that a new CQE is=
 generated.
>
> Rsocket is a sub-module attached to the rdma_cm library and provides rdma=
 calls that are completely similar to socket interfaces. However, this libr=
ary returns
> only the rdma_cm fd for listening to link setup-related events and does n=
ot expose the verbs fd (readable and writable events for listening to data)=
. Only the rpoll
> interface provided by the RSocket can be used to listen to related events=
. However, QEMU uses the ppoll interface to listen to the rdma_cm fd (gotte=
n by raccept API).
> And cannot listen to the verbs fd event. Only some hacking methods can be=
 used to address this problem.
>
> Do you guys have any ideas? Thanks.
+cc linux-rdma
+cc Sean



>
>
> Regards,
> -Gonglei

