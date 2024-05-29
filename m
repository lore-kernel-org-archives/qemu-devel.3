Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37A3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 09:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCFr2-0004QW-Fq; Wed, 29 May 2024 05:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sCFr1-0004QF-BT
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:44:19 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1sCFqy-0000Aw-5q
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:44:19 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57864327f6eso1180407a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1716975854; x=1717580654; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jb1IjI18UL4aUBD1jLfaFAS6MnMgb6ZWdkJngXHDUCc=;
 b=DfBjDWpZ5h1oVJySdEwcqKLNQ4VmsNC0vRA7S/Y9POQIrJ9u2pniLLhmU0xgU07nGX
 B+aSgkWhQOGH0YpbYqZ4txMWoj+aeJJzvxVIvKmQLdmu9dXd/YNG/Ah7LB4MB8wu2+Zv
 FbFopSF9Qj66ADKMuL+Ki9v8hqIQgeQgieTkgpd4KyDCNLjkxCRf7ykxg1q5w2+hCH+c
 2Xh+z4Ptjt/aSmI6ROKAxhaSaOpzkf2VGOkU4HrASsEqVxrVBPAJWaEKBWT8blWz/VBP
 j5IlB43AZPhCWMhmkQYTmLfCmjJbabrGw4x+mULqUwSBjRDRqPNnh7dSXTVYpMwRKTJJ
 6gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716975854; x=1717580654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jb1IjI18UL4aUBD1jLfaFAS6MnMgb6ZWdkJngXHDUCc=;
 b=QdoHPrbEZvnNM5UtHgUbhp0+JOUM2xpNqMzeALDVWrO3UBW+ic+gl5+L26kEclYlHn
 kHpz+sD30T40qpmNpjHwlRAle/KX8yXHhyG23XsqfJTc+k22E3sxHcGHzRpDBuSQn3O4
 bH6HWnPjmUufAd6PK339BiV6FqNV3Jm6X/fNehaubMIbLh1TNb5JuR8qQgJfsXk5EMaR
 hEvsSg0Aco2WURjVe1ZmOGMBE+z1Vx0WswnTbRiYFpzqzgo3d1wR1k7V0qlUBPVMmAgH
 ZGRxeRkhZLP+NA3Z+ANNf8uaLTIuqLSXGk3wWYZJKJm+4WmyxLIQgzz4LKM3wF/5KJqb
 JnMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2JznUvcMWX0DNojefLm3Ba0Hu1xQTiMJ/90ZOXthd2hkdn9yN1bLk2Y26fZqPY9I51xMR07BIn1rF359z20pfuoErJ9U=
X-Gm-Message-State: AOJu0YztrNkslHjx+/lGqgVZZVXuuiCxVz4tWx+52KwA1xSmBufh+ME/
 yQga+vrCuKUp+NXZRLnrQs/BVTHdwlnO2pWX9Gb9Tm5sS7xcVtCS8WIPanRNBa4u2NTDiGo9XnS
 AGIIggWoKDOAiHoJ5hA4RLGNkAV3eLfoZqcWEOg==
X-Google-Smtp-Source: AGHT+IEdmDgVPXBx1LhIoIFcbdoXla4D69wXqjpgiHoQlAfMpkF9MXDei8YACNh/cDtcHndeDGel571T3dSvYZH87/E=
X-Received: by 2002:a50:8d4e:0:b0:579:c37c:1b36 with SMTP id
 4fb4d7f45d1cf-57a04013b81mr1223315a12.17.1716975853938; Wed, 29 May 2024
 02:44:13 -0700 (PDT)
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
 <CAMGffEna=8vNm89SkzRknLb7irTit0dBeciuC+_KMp+4U0PtQw@mail.gmail.com>
 <3b1b7dfa099c4f1db2e869ced1f6f19a@huawei.com>
In-Reply-To: <3b1b7dfa099c4f1db2e869ced1f6f19a@huawei.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 29 May 2024 11:44:02 +0200
Message-ID: <CAMGffE=J9DhY6tVFuG=CYe86dModixCqfhSo5g0xbqzOmeKahA@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000dccac30619949735"
Received-SPF: permerror client-ip=2a00:1450:4864:20::52a;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

--000000000000dccac30619949735
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:35=E2=80=AFAM Gonglei (Arei) <arei.gonglei@huawe=
i.com>
wrote:

>
>
> > -----Original Message-----
> > From: Jinpu Wang [mailto:jinpu.wang@ionos.com]
> > Sent: Wednesday, May 29, 2024 5:18 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: Greg Sword <gregsword0@gmail.com>; Peter Xu <peterx@redhat.com>;
> > Yu Zhang <yu.zhang@ionos.com>; Michael Galaxy <mgalaxy@akamai.com>;
> > Elmar Gerdes <elmar.gerdes@ionos.com>; zhengchuan
> > <zhengchuan@huawei.com>; Daniel P. Berrang=C3=A9 <berrange@redhat.com>;
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
> > Xiexiangyou <xiexiangyou@huawei.com>; Fabiano Rosas <farosas@suse.de>;
> > RDMA mailing list <linux-rdma@vger.kernel.org>; shefty@nvidia.com; Hari=
s
> > Iqbal <haris.iqbal@ionos.com>
> > Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol
> handling
> >
> > Hi Gonglei,
> >
> > On Wed, May 29, 2024 at 10:31=E2=80=AFAM Gonglei (Arei) <arei.gonglei@h=
uawei.com
> >
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg Sword [mailto:gregsword0@gmail.com]
> > > > Sent: Wednesday, May 29, 2024 2:06 PM
> > > > To: Jinpu Wang <jinpu.wang@ionos.com>
> > > > Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol
> > > > handling
> > > >
> > > > On Wed, May 29, 2024 at 12:33=E2=80=AFPM Jinpu Wang <jinpu.wang@ion=
os.com>
> > > > wrote:
> > > > >
> > > > > On Wed, May 29, 2024 at 4:43=E2=80=AFAM Gonglei (Arei)
> > > > > <arei.gonglei@huawei.com>
> > > > wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Peter Xu [mailto:peterx@redhat.com]
> > > > > > > Sent: Tuesday, May 28, 2024 11:55 PM
> > > > > > > > > > Exactly, not so compelling, as I did it first only on
> > > > > > > > > > servers widely used for production in our data center.
> > > > > > > > > > The network adapters are
> > > > > > > > > >
> > > > > > > > > > Ethernet controller: Broadcom Inc. and subsidiaries
> > > > > > > > > > NetXtreme
> > > > > > > > > > BCM5720 2-port Gigabit Ethernet PCIe
> > > > > > > > >
> > > > > > > > > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6
> > > > > > > > > looks more
> > > > > > > reasonable.
> > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > >
> > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda
> > > > > > > 15
> > > > > > > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > > > > > > >
> > > > > > > > > Appreciate a lot for everyone helping on the testings.
> > > > > > > > >
> > > > > > > > > > InfiniBand controller: Mellanox Technologies MT27800
> > > > > > > > > > Family [ConnectX-5]
> > > > > > > > > >
> > > > > > > > > > which doesn't meet our purpose. I can choose RDMA or TC=
P
> > > > > > > > > > for VM migration. RDMA traffic is through InfiniBand an=
d
> > > > > > > > > > TCP through Ethernet on these two hosts. One is standby
> > > > > > > > > > while the other
> > > > is active.
> > > > > > > > > >
> > > > > > > > > > Now I'll try on a server with more recent Ethernet and
> > > > > > > > > > InfiniBand network adapters. One of them has:
> > > > > > > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
> > > > > > > > > > (rev
> > > > > > > > > > 01)
> > > > > > > > > >
> > > > > > > > > > The comparison between RDMA and TCP on the same NIC
> > > > > > > > > > could make more
> > > > > > > > > sense.
> > > > > > > > >
> > > > > > > > > It looks to me NICs are powerful now, but again as I
> > > > > > > > > mentioned I don't think it's a reason we need to deprecat=
e
> > > > > > > > > rdma, especially if QEMU's rdma migration has the chance
> > > > > > > > > to be refactored
> > > > using rsocket.
> > > > > > > > >
> > > > > > > > > Is there anyone who started looking into that direction?
> > > > > > > > > Would it make sense we start some PoC now?
> > > > > > > > >
> > > > > > > >
> > > > > > > > My team has finished the PoC refactoring which works well.
> > > > > > > >
> > > > > > > > Progress:
> > > > > > > > 1.  Implement io/channel-rdma.c, 2.  Add unit test
> > > > > > > > tests/unit/test-io-channel-rdma.c and verifying it is
> > > > > > > > successful, 3.  Remove the original code from
> migration/rdma.c, 4.
> > > > > > > > Rewrite the rdma_start_outgoing_migration and
> > > > > > > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xx=
x
> > > > > > > > functions from migration/ram.c. (to prevent RDMA live
> > > > > > > > migration from polluting the
> > > > > > > core logic of live migration), 6.  The soft-RoCE implemented
> > > > > > > by software is used to test the RDMA live migration. It's
> successful.
> > > > > > > >
> > > > > > > > We will be submit the patchset later.
> > > > > > >
> > > > > > > That's great news, thank you!
> > > > > > >
> > > > > > > --
> > > > > > > Peter Xu
> > > > > >
> > > > > > For rdma programming, the current mainstream implementation is
> > > > > > to use
> > > > rdma_cm to establish a connection, and then use verbs to transmit
> data.
> > > > > >
> > > > > > rdma_cm and ibverbs create two FDs respectively. The two FDs
> > > > > > have different responsibilities. rdma_cm fd is used to notify
> > > > > > connection establishment events, and verbs fd is used to notify
> > > > > > new CQEs. When
> > > > poll/epoll monitoring is directly performed on the rdma_cm fd, only
> > > > a pollin event can be monitored, which means that an rdma_cm event
> > > > occurs. When the verbs fd is directly polled/epolled, only the
> > > > pollin event can be listened, which indicates that a new CQE is
> generated.
> > > > > >
> > > > > > Rsocket is a sub-module attached to the rdma_cm library and
> > > > > > provides rdma calls that are completely similar to socket
> interfaces.
> > > > > > However, this library returns only the rdma_cm fd for listening
> > > > > > to link
> > > > setup-related events and does not expose the verbs fd (readable and
> > > > writable events for listening to data). Only the rpoll interface
> > > > provided by the RSocket can be used to listen to related events.
> > > > However, QEMU uses the ppoll interface to listen to the rdma_cm fd
> > (gotten by raccept API).
> > > > > > And cannot listen to the verbs fd event.
> > I'm confused, the rs_poll_arm
> > :
> https://github.com/linux-rdma/rdma-core/blob/master/librdmacm/rsocket.c#
> > L3290
> > For STREAM, rpoll setup fd for both cq fd and cm fd.
> >
> > > > > >
> > > > > > Do you guys have any ideas? Thanks.
> > > > > +cc linux-rdma
> > > >
> > > > Why include rdma community?
> > > >
> > >
> > > Can rdma/rsocket provide an API to expose the verbs fd?
> > Why do we need verbs fd? looks rsocket during rsend/rrecv is handling
> the new
> > completion if any via rs_get_comp
> >
> Actually I said the reason in the previous mail. Listing some header in
> librdmacm.
>
> /* verbs.h */
> struct ibv_comp_channel {
>         struct ibv_context     *context;
>         int                     fd;
>         int                     refcnt;
> };
>
> /* rdma_cma.h */
> struct rdma_event_channel {
>         int                     fd;
> };
>
> /* rdma_cma.h */
> struct rdma_cm_id {
>         struct ibv_context      *verbs;
>         struct rdma_event_channel *channel;   //=3D=3D> it can be gotten =
by
> rsocket.h
>         void                    *context;
>         struct ibv_qp           *qp;
>         struct rdma_route        route;
>         enum rdma_port_space     ps;
>         uint8_t                  port_num;
>         struct rdma_cm_event    *event;
>         struct ibv_comp_channel *send_cq_channel;  // =3D=3D> can't be go=
tten
> so that Qemu can't read the CQE dat
>
ok, but the send_cq_channel is set the same as recv_cq_channel:
https://github.com/linux-rdma/rdma-core/blob/master/librdmacm/rsocket.c#L85=
5
and also use the same recv_cq as send_cq.


>         struct ibv_cq           *send_cq;
>         struct ibv_comp_channel *recv_cq_channel;
>         struct ibv_cq           *recv_cq;
>         struct ibv_srq          *srq;
>         struct ibv_pd           *pd;
>         enum ibv_qp_type        qp_type;
> };
>
> /* rsocket.h */
> int raccept(int socket, struct sockaddr *addr, socklen_t *addrlen);
> int rpoll(struct pollfd *fds, nfds_t nfds, int timeout);
>
>
> > Another question to my mind is Daniel suggested a bit different way of
> using
> > rsocket: https://lore.kernel.org/qemu-devel/ZjtOreamN8xF9FDE@redhat.com=
/
> > Have you considered that?
> >
> We do use 'rsocket' APIs to refactor the RDMA code in QEMU and encounter
> the issue.
>
>
> Regards,
> -Gonglei
>
>

--000000000000dccac30619949735
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 29, 2024 at 11:35=E2=80=
=AFAM Gonglei (Arei) &lt;<a href=3D"mailto:arei.gonglei@huawei.com">arei.go=
nglei@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Jinpu Wang [mailto:<a href=3D"mailto:jinpu.wang@ionos.com" targe=
t=3D"_blank">jinpu.wang@ionos.com</a>]<br>
&gt; Sent: Wednesday, May 29, 2024 5:18 PM<br>
&gt; To: Gonglei (Arei) &lt;<a href=3D"mailto:arei.gonglei@huawei.com" targ=
et=3D"_blank">arei.gonglei@huawei.com</a>&gt;<br>
&gt; Cc: Greg Sword &lt;<a href=3D"mailto:gregsword0@gmail.com" target=3D"_=
blank">gregsword0@gmail.com</a>&gt;; Peter Xu &lt;<a href=3D"mailto:peterx@=
redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt;;<br>
&gt; Yu Zhang &lt;<a href=3D"mailto:yu.zhang@ionos.com" target=3D"_blank">y=
u.zhang@ionos.com</a>&gt;; Michael Galaxy &lt;<a href=3D"mailto:mgalaxy@aka=
mai.com" target=3D"_blank">mgalaxy@akamai.com</a>&gt;;<br>
&gt; Elmar Gerdes &lt;<a href=3D"mailto:elmar.gerdes@ionos.com" target=3D"_=
blank">elmar.gerdes@ionos.com</a>&gt;; zhengchuan<br>
&gt; &lt;<a href=3D"mailto:zhengchuan@huawei.com" target=3D"_blank">zhengch=
uan@huawei.com</a>&gt;; Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berra=
nge@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;;<br>
&gt; Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_=
blank">armbru@redhat.com</a>&gt;; Zhijian Li (Fujitsu)<br>
&gt; &lt;<a href=3D"mailto:lizhijian@fujitsu.com" target=3D"_blank">lizhiji=
an@fujitsu.com</a>&gt;; <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"=
_blank">qemu-devel@nongnu.org</a>; Yuval Shaia<br>
&gt; &lt;<a href=3D"mailto:yuval.shaia.ml@gmail.com" target=3D"_blank">yuva=
l.shaia.ml@gmail.com</a>&gt;; Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat=
.com" target=3D"_blank">kwolf@redhat.com</a>&gt;; Prasanna<br>
&gt; Kumar Kalever &lt;<a href=3D"mailto:prasanna.kalever@redhat.com" targe=
t=3D"_blank">prasanna.kalever@redhat.com</a>&gt;; Cornelia Huck<br>
&gt; &lt;<a href=3D"mailto:cohuck@redhat.com" target=3D"_blank">cohuck@redh=
at.com</a>&gt;; Michael Roth &lt;<a href=3D"mailto:michael.roth@amd.com" ta=
rget=3D"_blank">michael.roth@amd.com</a>&gt;; Prasanna<br>
&gt; Kumar Kalever &lt;<a href=3D"mailto:prasanna4324@gmail.com" target=3D"=
_blank">prasanna4324@gmail.com</a>&gt;; Paolo Bonzini<br>
&gt; &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@=
redhat.com</a>&gt;; <a href=3D"mailto:qemu-block@nongnu.org" target=3D"_bla=
nk">qemu-block@nongnu.org</a>; <a href=3D"mailto:devel@lists.libvirt.org" t=
arget=3D"_blank">devel@lists.libvirt.org</a>;<br>
&gt; Hanna Reitz &lt;<a href=3D"mailto:hreitz@redhat.com" target=3D"_blank"=
>hreitz@redhat.com</a>&gt;; Michael S. Tsirkin &lt;<a href=3D"mailto:mst@re=
dhat.com" target=3D"_blank">mst@redhat.com</a>&gt;;<br>
&gt; Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blank">=
thuth@redhat.com</a>&gt;; Eric Blake &lt;<a href=3D"mailto:eblake@redhat.co=
m" target=3D"_blank">eblake@redhat.com</a>&gt;; Song<br>
&gt; Gao &lt;<a href=3D"mailto:gaosong@loongson.cn" target=3D"_blank">gaoso=
ng@loongson.cn</a>&gt;; Marc-Andr=C3=A9 Lureau<br>
&gt; &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">m=
arcandre.lureau@redhat.com</a>&gt;; Alex Benn=C3=A9e &lt;<a href=3D"mailto:=
alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;;<b=
r>
&gt; Wainer dos Santos Moschetta &lt;<a href=3D"mailto:wainersm@redhat.com"=
 target=3D"_blank">wainersm@redhat.com</a>&gt;; Beraldo Leal<br>
&gt; &lt;<a href=3D"mailto:bleal@redhat.com" target=3D"_blank">bleal@redhat=
.com</a>&gt;; Pannengyuan &lt;<a href=3D"mailto:pannengyuan@huawei.com" tar=
get=3D"_blank">pannengyuan@huawei.com</a>&gt;;<br>
&gt; Xiexiangyou &lt;<a href=3D"mailto:xiexiangyou@huawei.com" target=3D"_b=
lank">xiexiangyou@huawei.com</a>&gt;; Fabiano Rosas &lt;<a href=3D"mailto:f=
arosas@suse.de" target=3D"_blank">farosas@suse.de</a>&gt;;<br>
&gt; RDMA mailing list &lt;<a href=3D"mailto:linux-rdma@vger.kernel.org" ta=
rget=3D"_blank">linux-rdma@vger.kernel.org</a>&gt;; <a href=3D"mailto:sheft=
y@nvidia.com" target=3D"_blank">shefty@nvidia.com</a>; Haris<br>
&gt; Iqbal &lt;<a href=3D"mailto:haris.iqbal@ionos.com" target=3D"_blank">h=
aris.iqbal@ionos.com</a>&gt;<br>
&gt; Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol ha=
ndling<br>
&gt; <br>
&gt; Hi Gonglei,<br>
&gt; <br>
&gt; On Wed, May 29, 2024 at 10:31=E2=80=AFAM Gonglei (Arei) &lt;<a href=3D=
"mailto:arei.gonglei@huawei.com" target=3D"_blank">arei.gonglei@huawei.com<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; From: Greg Sword [mailto:<a href=3D"mailto:gregsword0@gmail.=
com" target=3D"_blank">gregsword0@gmail.com</a>]<br>
&gt; &gt; &gt; Sent: Wednesday, May 29, 2024 2:06 PM<br>
&gt; &gt; &gt; To: Jinpu Wang &lt;<a href=3D"mailto:jinpu.wang@ionos.com" t=
arget=3D"_blank">jinpu.wang@ionos.com</a>&gt;<br>
&gt; &gt; &gt; Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA p=
rotocol<br>
&gt; &gt; &gt; handling<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, May 29, 2024 at 12:33=E2=80=AFPM Jinpu Wang &lt;<a h=
ref=3D"mailto:jinpu.wang@ionos.com" target=3D"_blank">jinpu.wang@ionos.com<=
/a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Wed, May 29, 2024 at 4:43=E2=80=AFAM Gonglei (Arei)<=
br>
&gt; &gt; &gt; &gt; &lt;<a href=3D"mailto:arei.gonglei@huawei.com" target=
=3D"_blank">arei.gonglei@huawei.com</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; &gt; &gt; &gt; From: Peter Xu [mailto:<a href=3D"mailto:pete=
rx@redhat.com" target=3D"_blank">peterx@redhat.com</a>]<br>
&gt; &gt; &gt; &gt; &gt; &gt; Sent: Tuesday, May 28, 2024 11:55 PM<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Exactly, not so compelling, as=
 I did it first only on<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; servers widely used for produc=
tion in our data center.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; The network adapters are<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Ethernet controller: Broadcom =
Inc. and subsidiaries<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; NetXtreme<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; BCM5720 2-port Gigabit Etherne=
t PCIe<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Hmm... I definitely thinks Jinpu&#3=
9;s Mellanox ConnectX-6<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; looks more<br>
&gt; &gt; &gt; &gt; &gt; &gt; reasonable.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdy=
emg0Zda" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/qemu-=
devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda</a><br>
&gt; &gt; &gt; &gt; &gt; &gt; 15<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <a href=3D"http://wVAqk81vXtKzx-LfJ=
Q@mail.gmail.com/" rel=3D"noreferrer" target=3D"_blank">wVAqk81vXtKzx-LfJQ@=
mail.gmail.com/</a><br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Appreciate a lot for everyone helpi=
ng on the testings.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; InfiniBand controller: Mellano=
x Technologies MT27800<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Family [ConnectX-5]<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; which doesn&#39;t meet our pur=
pose. I can choose RDMA or TCP<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; for VM migration. RDMA traffic=
 is through InfiniBand and<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; TCP through Ethernet on these =
two hosts. One is standby<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; while the other<br>
&gt; &gt; &gt; is active.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Now I&#39;ll try on a server w=
ith more recent Ethernet and<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; InfiniBand network adapters. O=
ne of them has:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; BCM57414 NetXtreme-E 10Gb/25Gb=
 RDMA Ethernet Controller<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; (rev<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; 01)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; The comparison between RDMA an=
d TCP on the same NIC<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; could make more<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; sense.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; It looks to me NICs are powerful no=
w, but again as I<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; mentioned I don&#39;t think it&#39;=
s a reason we need to deprecate<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; rdma, especially if QEMU&#39;s rdma=
 migration has the chance<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; to be refactored<br>
&gt; &gt; &gt; using rsocket.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Is there anyone who started looking=
 into that direction?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Would it make sense we start some P=
oC now?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; My team has finished the PoC refactoring=
 which works well.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Progress:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; 1.=C2=A0 Implement io/channel-rdma.c, 2.=
=C2=A0 Add unit test<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; tests/unit/test-io-channel-rdma.c and ve=
rifying it is<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; successful, 3.=C2=A0 Remove the original=
 code from migration/rdma.c, 4.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Rewrite the rdma_start_outgoing_migratio=
n and<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; rdma_start_incoming_migration logic, 5.=
=C2=A0 Remove all rdma_xxx<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; functions from migration/ram.c. (to prev=
ent RDMA live<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; migration from polluting the<br>
&gt; &gt; &gt; &gt; &gt; &gt; core logic of live migration), 6.=C2=A0 The s=
oft-RoCE implemented<br>
&gt; &gt; &gt; &gt; &gt; &gt; by software is used to test the RDMA live mig=
ration. It&#39;s successful.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; We will be submit the patchset later.<br=
>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; That&#39;s great news, thank you!<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; &gt; &gt; Peter Xu<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; For rdma programming, the current mainstream imple=
mentation is<br>
&gt; &gt; &gt; &gt; &gt; to use<br>
&gt; &gt; &gt; rdma_cm to establish a connection, and then use verbs to tra=
nsmit data.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; rdma_cm and ibverbs create two FDs respectively. T=
he two FDs<br>
&gt; &gt; &gt; &gt; &gt; have different responsibilities. rdma_cm fd is use=
d to notify<br>
&gt; &gt; &gt; &gt; &gt; connection establishment events, and verbs fd is u=
sed to notify<br>
&gt; &gt; &gt; &gt; &gt; new CQEs. When<br>
&gt; &gt; &gt; poll/epoll monitoring is directly performed on the rdma_cm f=
d, only<br>
&gt; &gt; &gt; a pollin event can be monitored, which means that an rdma_cm=
 event<br>
&gt; &gt; &gt; occurs. When the verbs fd is directly polled/epolled, only t=
he<br>
&gt; &gt; &gt; pollin event can be listened, which indicates that a new CQE=
 is generated.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Rsocket is a sub-module attached to the rdma_cm li=
brary and<br>
&gt; &gt; &gt; &gt; &gt; provides rdma calls that are completely similar to=
 socket interfaces.<br>
&gt; &gt; &gt; &gt; &gt; However, this library returns only the rdma_cm fd =
for listening<br>
&gt; &gt; &gt; &gt; &gt; to link<br>
&gt; &gt; &gt; setup-related events and does not expose the verbs fd (reada=
ble and<br>
&gt; &gt; &gt; writable events for listening to data). Only the rpoll inter=
face<br>
&gt; &gt; &gt; provided by the RSocket can be used to listen to related eve=
nts.<br>
&gt; &gt; &gt; However, QEMU uses the ppoll interface to listen to the rdma=
_cm fd<br>
&gt; (gotten by raccept API).<br>
&gt; &gt; &gt; &gt; &gt; And cannot listen to the verbs fd event.<br>
&gt; I&#39;m confused, the rs_poll_arm<br>
&gt; :<a href=3D"https://github.com/linux-rdma/rdma-core/blob/master/librdm=
acm/rsocket.c#" rel=3D"noreferrer" target=3D"_blank">https://github.com/lin=
ux-rdma/rdma-core/blob/master/librdmacm/rsocket.c#</a><br>
&gt; L3290<br>
&gt; For STREAM, rpoll setup fd for both cq fd and cm fd.<br>
&gt; <br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Do you guys have any ideas? Thanks.<br>
&gt; &gt; &gt; &gt; +cc linux-rdma<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Why include rdma community?<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Can rdma/rsocket provide an API to expose the verbs fd?<br>
&gt; Why do we need verbs fd? looks rsocket during rsend/rrecv is handling =
the new<br>
&gt; completion if any via rs_get_comp<br>
&gt; <br>
Actually I said the reason in the previous mail. Listing some header in lib=
rdmacm.<br>
<br>
/* verbs.h */<br>
struct ibv_comp_channel {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_context=C2=A0 =C2=A0 =C2=A0*context;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0refcnt;<br>
};<br>
<br>
/* rdma_cma.h */<br>
struct rdma_event_channel {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd;<br>
};<br>
<br>
/* rdma_cma.h */<br>
struct rdma_cm_id {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_context=C2=A0 =C2=A0 =C2=A0 *verbs;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rdma_event_channel *channel;=C2=A0 =C2=
=A0//=3D=3D&gt; it can be gotten by rsocket.h<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *context;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_qp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*qp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rdma_route=C2=A0 =C2=A0 =C2=A0 =C2=A0 ro=
ute;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum rdma_port_space=C2=A0 =C2=A0 =C2=A0ps;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 port_num;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rdma_cm_event=C2=A0 =C2=A0 *event;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_comp_channel *send_cq_channel;=C2=A0=
 // =3D=3D&gt; can&#39;t be gotten so that Qemu can&#39;t read the CQE dat<=
br></blockquote><div>ok, but the send_cq_channel is set the same as recv_cq=
_channel:=C2=A0<a href=3D"https://github.com/linux-rdma/rdma-core/blob/mast=
er/librdmacm/rsocket.c#L855">https://github.com/linux-rdma/rdma-core/blob/m=
aster/librdmacm/rsocket.c#L855</a></div><div>and also use the same recv_cq =
as send_cq.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_cq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*send_cq;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_comp_channel *recv_cq_channel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_cq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*recv_cq;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_srq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *srq;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_pd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*pd;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum ibv_qp_type=C2=A0 =C2=A0 =C2=A0 =C2=A0 qp_=
type;<br>
};<br>
<br>
/* rsocket.h */<br>
int raccept(int socket, struct sockaddr *addr, socklen_t *addrlen);<br>
int rpoll(struct pollfd *fds, nfds_t nfds, int timeout);<br>
<br>
<br>
&gt; Another question to my mind is Daniel suggested a bit different way of=
 using<br>
&gt; rsocket: <a href=3D"https://lore.kernel.org/qemu-devel/ZjtOreamN8xF9FD=
E@redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org=
/qemu-devel/ZjtOreamN8xF9FDE@redhat.com/</a><br>
&gt; Have you considered that?<br>
&gt; <br>
We do use &#39;rsocket&#39; APIs to refactor the RDMA code in QEMU and enco=
unter the issue.<br>
<br>
<br>
Regards,<br>
-Gonglei<br>
<br>
</blockquote></div></div>

--000000000000dccac30619949735--

