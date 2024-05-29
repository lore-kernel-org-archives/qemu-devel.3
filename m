Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB881C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 09:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCFRO-0006fQ-6Y; Wed, 29 May 2024 05:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sCFRM-0006fE-Ue
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:17:48 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sCFRK-0004Rb-J0
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:17:48 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6268034cf8so82730666b.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1716974263; x=1717579063; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SU3m5vxu3rbmfROVAzPs883xqmmfLXiDDF3GK+pTdyg=;
 b=UCNIV/Y0RhvvPylgQuEtKYDqhF7zdsIgQpztDMfzvcqFvaFuOTqoX6bHWNrvfBNlOp
 RKoHIniEc1cgirsKc8VeQWOxCMSCT55504akZPRdKjz3aKlv7UbogSiYGokVxwV+tkDh
 l+svjarxMT7v69G7H2jYw2g6/YzfQfkb+78NtX0Flad6ZPeMf5T/PCGhvDLFxnE2HH+S
 9wMXqg34p8mUwENzoIBqU/9K02FxJcDITl77f+W2GAUvduKGe+N5ec8lZwSA2Ruyiy0N
 xQQBC5zdPutZTYenFDgSi4p4X6c4dyOsXV0vH2SrhlehWFxTTVhIVvgu6Bm/wqwY9TEk
 9ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716974263; x=1717579063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SU3m5vxu3rbmfROVAzPs883xqmmfLXiDDF3GK+pTdyg=;
 b=HNN1CsH7shMs5euHIrCun5FqkEEc1hqDN28nK0QKL2xPJOa98u+vHXfRciZKfCsyjl
 23iYQfmDXFF0mO8qZXOTPDd8ZDbLC6BJEiL7GLNTDwF9tPlO7wYhflfQrneMMP3D/Oh8
 9RMBPrSPdL76/hjal39ozmsG4O6A70kUYr2lddLnEeCTrn06r1NllzuZNjaQK6/Ou2Ji
 z+vcTztWnGNQ8C0ToS88n9MfcO/gxUYnS+C2cCdnUA1rHPIEim1CLxACiSnDivRUhf3t
 m5612q1r5o1SDydrqVFLk2RWwk8R+SHHXAbzAOOr/xyXZ1mlvOLnJ5wMc/vRIrnF0ltO
 qmOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEzf1wG0fnzoIDr0vjNxL9O+ArNAAyAuFuHeGbCOt4KymAlAoGAT2Qtw+BG/ufC+kehoMSRQORxR2n9F6ZfFv9gzabAvU=
X-Gm-Message-State: AOJu0YxKnoFR1i+KI9Dsgqxca3YqkvXRrCo+XxtJ+3W8rn8wdIrQBMYj
 28ksZvhWmuo0f88cxL43a9dRzl/7RxCwRaPPT1qHkm7fXFkZlm2Lxtaxwb6BayGS2YbcgQPavQL
 FeQefUpX9FDYSZKMHJ1TGFmbykcBjzChUJ/BtLw==
X-Google-Smtp-Source: AGHT+IHOEdJAj5z5kfkYTgPocxN+HTeCtwYAW44s6OSN3sMCcl7pCatWHNyHFNi0MnzCboTZWq9fFOiVksluTzgOuZk=
X-Received: by 2002:a50:d755:0:b0:578:6198:d6fc with SMTP id
 4fb4d7f45d1cf-5786198d81emr10903456a12.18.1716974262618; Wed, 29 May 2024
 02:17:42 -0700 (PDT)
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
 <e0fa7fc42118407f8731c34f8c192fda@huawei.com>
In-Reply-To: <e0fa7fc42118407f8731c34f8c192fda@huawei.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 29 May 2024 11:17:31 +0200
Message-ID: <CAMGffEna=8vNm89SkzRknLb7irTit0dBeciuC+_KMp+4U0PtQw@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Greg Sword <gregsword0@gmail.com>, Peter Xu <peterx@redhat.com>, 
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
 "shefty@nvidia.com" <shefty@nvidia.com>, Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62b;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x62b.google.com
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

On Wed, May 29, 2024 at 10:31=E2=80=AFAM Gonglei (Arei) <arei.gonglei@huawe=
i.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Greg Sword [mailto:gregsword0@gmail.com]
> > Sent: Wednesday, May 29, 2024 2:06 PM
> > To: Jinpu Wang <jinpu.wang@ionos.com>
> > Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol han=
dling
> >
> > On Wed, May 29, 2024 at 12:33=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.c=
om>
> > wrote:
> > >
> > > On Wed, May 29, 2024 at 4:43=E2=80=AFAM Gonglei (Arei) <arei.gonglei@=
huawei.com>
> > wrote:
> > > >
> > > > Hi,
> > > >
> > > > > -----Original Message-----
> > > > > From: Peter Xu [mailto:peterx@redhat.com]
> > > > > Sent: Tuesday, May 28, 2024 11:55 PM
> > > > > > > > Exactly, not so compelling, as I did it first only on
> > > > > > > > servers widely used for production in our data center. The
> > > > > > > > network adapters are
> > > > > > > >
> > > > > > > > Ethernet controller: Broadcom Inc. and subsidiaries
> > > > > > > > NetXtreme
> > > > > > > > BCM5720 2-port Gigabit Ethernet PCIe
> > > > > > >
> > > > > > > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks
> > > > > > > more
> > > > > reasonable.
> > > > > > >
> > > > > > >
> > > > >
> > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda
> > > > > 15
> > > > > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > > > > >
> > > > > > > Appreciate a lot for everyone helping on the testings.
> > > > > > >
> > > > > > > > InfiniBand controller: Mellanox Technologies MT27800 Family
> > > > > > > > [ConnectX-5]
> > > > > > > >
> > > > > > > > which doesn't meet our purpose. I can choose RDMA or TCP fo=
r
> > > > > > > > VM migration. RDMA traffic is through InfiniBand and TCP
> > > > > > > > through Ethernet on these two hosts. One is standby while t=
he other
> > is active.
> > > > > > > >
> > > > > > > > Now I'll try on a server with more recent Ethernet and
> > > > > > > > InfiniBand network adapters. One of them has:
> > > > > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (re=
v
> > > > > > > > 01)
> > > > > > > >
> > > > > > > > The comparison between RDMA and TCP on the same NIC could
> > > > > > > > make more
> > > > > > > sense.
> > > > > > >
> > > > > > > It looks to me NICs are powerful now, but again as I mentione=
d
> > > > > > > I don't think it's a reason we need to deprecate rdma,
> > > > > > > especially if QEMU's rdma migration has the chance to be refa=
ctored
> > using rsocket.
> > > > > > >
> > > > > > > Is there anyone who started looking into that direction?
> > > > > > > Would it make sense we start some PoC now?
> > > > > > >
> > > > > >
> > > > > > My team has finished the PoC refactoring which works well.
> > > > > >
> > > > > > Progress:
> > > > > > 1.  Implement io/channel-rdma.c, 2.  Add unit test
> > > > > > tests/unit/test-io-channel-rdma.c and verifying it is
> > > > > > successful, 3.  Remove the original code from migration/rdma.c,=
 4.
> > > > > > Rewrite the rdma_start_outgoing_migration and
> > > > > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xxx
> > > > > > functions from migration/ram.c. (to prevent RDMA live migration
> > > > > > from polluting the
> > > > > core logic of live migration), 6.  The soft-RoCE implemented by
> > > > > software is used to test the RDMA live migration. It's successful=
.
> > > > > >
> > > > > > We will be submit the patchset later.
> > > > >
> > > > > That's great news, thank you!
> > > > >
> > > > > --
> > > > > Peter Xu
> > > >
> > > > For rdma programming, the current mainstream implementation is to u=
se
> > rdma_cm to establish a connection, and then use verbs to transmit data.
> > > >
> > > > rdma_cm and ibverbs create two FDs respectively. The two FDs have
> > > > different responsibilities. rdma_cm fd is used to notify connection
> > > > establishment events, and verbs fd is used to notify new CQEs. When
> > poll/epoll monitoring is directly performed on the rdma_cm fd, only a p=
ollin
> > event can be monitored, which means that an rdma_cm event occurs. When
> > the verbs fd is directly polled/epolled, only the pollin event can be l=
istened,
> > which indicates that a new CQE is generated.
> > > >
> > > > Rsocket is a sub-module attached to the rdma_cm library and provide=
s
> > > > rdma calls that are completely similar to socket interfaces.
> > > > However, this library returns only the rdma_cm fd for listening to =
link
> > setup-related events and does not expose the verbs fd (readable and wri=
table
> > events for listening to data). Only the rpoll interface provided by the=
 RSocket
> > can be used to listen to related events. However, QEMU uses the ppoll
> > interface to listen to the rdma_cm fd (gotten by raccept API).
> > > > And cannot listen to the verbs fd event.
I'm confused, the rs_poll_arm
:https://github.com/linux-rdma/rdma-core/blob/master/librdmacm/rsocket.c#L3=
290
For STREAM, rpoll setup fd for both cq fd and cm fd.

> > > >
> > > > Do you guys have any ideas? Thanks.
> > > +cc linux-rdma
> >
> > Why include rdma community?
> >
>
> Can rdma/rsocket provide an API to expose the verbs fd?
Why do we need verbs fd? looks rsocket during rsend/rrecv is handling
the new completion if any via rs_get_comp

Another question to my mind is Daniel suggested a bit different way of
using rsocket: https://lore.kernel.org/qemu-devel/ZjtOreamN8xF9FDE@redhat.c=
om/
Have you considered that?

Thx!
Jinpu




>
>
> Regards,
> -Gonglei
>
> > > +cc Sean
> > >
> > >
> > >
> > > >
> > > >
> > > > Regards,
> > > > -Gonglei
> > >

