Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E20C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjdc6-00006G-Qj; Mon, 11 Mar 2024 07:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1rjdc5-00005t-48
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:14:37 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1rjdc2-0002fK-22
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:14:36 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a45f257b81fso325961666b.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 04:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1710155670; x=1710760470; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0jl//txZHXm3OVJ5i2uBXEaRNUf/z4I+WlJoPzQYQ4=;
 b=HVaYGIfS/uxdWzMu7J1nKpwHSqKiTP4EIjCv2xzz4JC5xN08llVuPSM2gIjh3EwLLX
 Rp6hHmvIncgboUPySaDDyp4FWXI8y0NuUm5ODMJygKml8NvFD99tn5ZkqZcJvUVXQIIN
 PTEZLn82NJiOs5DoreQwN6vmfDq3PP/vrHzQFqpl+bTc21XJHJ5L7pgekfj8QtE6xWeR
 LbM8m2tmQM/kxLSu1sqQFF8DbYiIVJ8XULw827lbymP3HEziFI9RpAzP3vO2BUpNLwkn
 LuRkK+7WvrcxyRvheN2ILuybaRfpAc7/JoEscoxyDMn8/mOKVuY7dfCPyYqbIWY/IY5B
 QMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710155670; x=1710760470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0jl//txZHXm3OVJ5i2uBXEaRNUf/z4I+WlJoPzQYQ4=;
 b=vMBvMf2yAyO8/YPKNLneBn6feeVCu+tqE5K5deNUo1obnFBpMxwGA6ujLqxUP83RWA
 e/ckaijAl1rWSP0qxf2lyCdGXEI+XLGOzWEBx+xcVHw4lq2gKSZkkXbP91g2IPcmregz
 33Qdo838MFaSIiFNiH5zb0hZJROcWT5wSnxRw4tKvY+MWM7zYcIegdKaXP0OSU0M9viy
 SJqCFy7eWvPIc+gTjST4fynS4uvDBqpBtUrkJOcA7ISwjdDlcvw+D2z9ZNKFVh4iJcag
 TVqt5MCSxrYyiYvomZtopZyGzQdIMjAoshh8tYvAbcspLchlf6UYAMQfMoz1clEjUgGA
 3pyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbMF12iSiNAEHYBo1zdN3NLur+Y2/eGY6QtwdSnOH2Fb5yIUkCElg3kEBYM2JQJuCc/kwJt1cGyxezkCEqG3BP5D1amBA=
X-Gm-Message-State: AOJu0YyDwI+KvXvwPilwexiOY3t/r095VVYEP7w6o+4Q2ZXlH4h0j4ip
 /YGsvMzkKyYGMRwBvvlS9E9E/wd8kbr3EvRs5TiWqnsRZLWB3Wwiu9NRNVPbD6SQDUScUvZGtYF
 U3hsIIQLA1M4C87wJG/wTeKj8Y0c0Csp5gnAAuw==
X-Google-Smtp-Source: AGHT+IHwvyumka3GqgjzraLY2jdm6YJO5mbxj1oa4+zXMgLjQfzD3XXBvQ26qirY8ZiyC+ROI5YiHZ6bG+6jQWO9cYY=
X-Received: by 2002:a17:907:6d1e:b0:a46:2232:1ae7 with SMTP id
 sa30-20020a1709076d1e00b00a4622321ae7mr2454361ejc.13.1710155669722; Mon, 11
 Mar 2024 04:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
 <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com>
 <Zek2UFoAyVrC7yh6@x1n>
 <CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com>
 <CAOQbQt0+UbfZNPrticjLD4X+S2KR4r+yWPATnhEhTRuxbwvGiQ@mail.gmail.com>
 <CAHEcVy78iCXVGmwr-2snpFwOyCxv3wxYrYJonK6nZF9UfbX_bw@mail.gmail.com>
In-Reply-To: <CAHEcVy78iCXVGmwr-2snpFwOyCxv3wxYrYJonK6nZF9UfbX_bw@mail.gmail.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Mon, 11 Mar 2024 12:14:18 +0100
Message-ID: <CAHEcVy7kun92b8drEdDZndcWBBT7uvjOpHfqvVbqP0MqvJO01w@mail.gmail.com>
Subject: Re: Problem with migration/rdma
To: Peter Xu <peterx@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Het Gala <het.gala@nutanix.com>, Fabiano Rosas <farosas@suse.de>, 
 qemu-devel <qemu-devel@nongnu.org>
Cc: Jinpu Wang <jinpu.wang@ionos.com>,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>, 
 Elmar Gerdes <elmar.gerdes@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62e;
 envelope-from=yu.zhang@ionos.com; helo=mail-ej1-x62e.google.com
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

Hello Peter and Zhijian,

I created a MR in gitlab. You may have a look and let me know whether
it's fine for you.
    https://gitlab.com/qemu/qemu/-/merge_requests/4

Best regards,
Yu Zhang @ IONOS Compute Platform
11.03.2024

On Fri, Mar 8, 2024 at 10:13=E2=80=AFAM Yu Zhang <yu.zhang@ionos.com> wrote=
:
>
> Hallo Alexei,
>
> vielen Dank! Habe probiert, aber auch an Permission Problem gesto=C3=9Fen=
.
> Ich versuche, Google Application-specific password zu erstellen f=C3=BCr =
Zukunft.
>
> QEMU Upstream bietet diese L=C3=B6sung f=C3=BCr kleinen Patch an im Notfa=
ll.
> Sie werden es behanden.
>
> Viele Gr=C3=BC=C3=9Fe
> Yu
>
> On Fri, Mar 8, 2024 at 8:09=E2=80=AFAM Alexei Pastuchov
> <alexei.pastuchov@ionos.com> wrote:
> >
> > Hi Yu, I think you could create a pull request to the project
> > https://github.com/qemu/qemu for the purpose.
> > Best,
> > Alexei
> >
> > On Fri, Mar 8, 2024 at 7:28=E2=80=AFAM Yu Zhang <yu.zhang@ionos.com> wr=
ote:
> > >
> > > Hello Zhijian and Peter,
> > >
> > > Thank you so much for testing and confirming it.
> > > I created a patch in the email format, unfortunately got an issue for
> > > setting up the
> > > "Application-specific Password" in Gmail. It seems that in my gmail
> > > account there
> > > is no option at all for selecting "mail" before creating the
> > > application password.
> > >
> > > As it's tiny, I attached it in this email at this time (not elegant.)=
,
> > > so that it can get
> > > included before the soft freezing.
> > >
> > > Really sorry for this inconvenience.
> > > --------------
> > > From c9fb6a6debfbd5e103aa90f30e9a028316449104 Mon Sep 17 00:00:00 200=
1
> > > From: Yu Zhang <yu.zhang@ionos.com>
> > > Date: Wed, 6 Mar 2024 09:06:54 +0100
> > > Subject: [PATCH] migration/rdma: Fix a memory issue for migration
> > >
> > > In commit 3fa9642ff7 change was made to convert the RDMA backend to
> > > accept MigrateAddress struct. However, the assignment of "host" leads
> > > to data corruption on the target host and the failure of migration.
> > >
> > >     isock->host =3D rdma->host;
> > >
> > > By allocating the memory explicitly for it with g_strdup_printf(), th=
e
> > > issue is fixed and the migration doesn't fail any more.
> > >
> > > Fixes: 3fa9642ff7 ("migration: convert rdma backend to accept Migrate=
Address")
> > > Cc: qemu-stable <qemu-stable@nongnu.org>
> > > Cc: Li Zhijian <lizhijian@fujitsu.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Yu Zhang <yu.zhang@ionos.com>
> > > ---
> > >  migration/rdma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/migration/rdma.c b/migration/rdma.c
> > > index a355dcea89..d6abe718b5 100644
> > > --- a/migration/rdma.c
> > > +++ b/migration/rdma.c
> > > @@ -3357,7 +3357,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
> > >          goto err_rdma_dest_wait;
> > >      }
> > >
> > > -    isock->host =3D rdma->host;
> > > +    isock->host =3D g_strdup_printf("%s", rdma->host);
> > >      isock->port =3D g_strdup_printf("%d", rdma->port);
> > >
> > >      /*
> > > --
> > > 2.25.1
> > > --------------
> > >
> > > Best regards,
> > > Yu Zhang @ IONOS Compute Platform
> > > 08.03.2024
> > >
> > > On Thu, Mar 7, 2024 at 4:37=E2=80=AFAM Peter Xu <peterx@redhat.com> w=
rote:
> > > >
> > > > On Thu, Mar 07, 2024 at 02:41:37AM +0000, Zhijian Li (Fujitsu) via =
wrote:
> > > > > Yu,
> > > > >
> > > > >
> > > > > On 07/03/2024 00:30, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > > > Cc'ing RDMA migration reviewers/maintainers:
> > > > > >
> > > > > > $ ./scripts/get_maintainer.pl -f migration/rdma.c
> > > > > > Li Zhijian <lizhijian@fujitsu.com> (reviewer:RDMA Migration)
> > > > > > Peter Xu <peterx@redhat.com> (maintainer:Migration)
> > > > > > Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
> > > > > >
> > > > > > On 5/3/24 22:32, Yu Zhang wrote:
> > > > > >> Hello Het and all,
> > > > > >>
> > > > > >> while I was testing qemu-8.2, I saw a lot of our migration tes=
t cases failed.
> > > > > >> After debugging the commits of the 8.2 branch, I saw the issue=
 and mad a diff:
> > > > > >>
> > > > > >> diff --git a/migration/rdma.c b/migration/rdma.c
> > > > > >> index 6a29e53daf..f10d56f556 100644
> > > > > >> --- a/migration/rdma.c
> > > > > >> +++ b/migration/rdma.c
> > > > > >> @@ -3353,9 +3353,9 @@ static int qemu_rdma_accept(RDMAContext =
*rdma)
> > > > > >>           goto err_rdma_dest_wait;
> > > > > >>       }
> > > > > >>
> > > > > >> -    isock->host =3D rdma->host;
> > > > > >> +    isock->host =3D g_strdup_printf("%s", rdma->host);
> > > > > >>       isock->port =3D g_strdup_printf("%d", rdma->port);
> > > > >
> > > > >
> > > > > Thanks for your analysis.
> > > > >
> > > > > It will be great if you send this as a patch.
> > > > >
> > > > >
> > > > > isock is defined as a _autoptr VVV
> > > > > 3333 _autoptr(InetSocketAddress) isock =3D g_new0(InetSocketAddre=
ss, 1);
> > > > >
> > > > > I'm surprised that it seems the auto free scheme will free the me=
mber of isock as well
> > > > > see below valrind log. That will cause a double free.
> > > >
> > > > Right, all the QAPI-free is a deep one.  Thanks for checking this u=
p,
> > > > Zhijian.
> > > >
> > > > Yu, would you please send a formal patch (better before this week e=
nds) so
> > > > that I can include it for the last pull for 9.0 soft-freeze (March =
12th)?
> > > > As 8.2 affected, please also attach proper tags:
> > > >
> > > > Cc: qemu-stable <qemu-stable@nongnu.org>
> > > > Fixes: 3fa9642ff7 ("migration: convert rdma backend to accept Migra=
teAddress")
> > > >
> > > > >
> > > > > =3D=3D809138=3D=3D Invalid free() / delete / delete[] / realloc()
> > > > > =3D=3D809138=3D=3D    at 0x483A9F5: free (vg_replace_malloc.c:538=
)
> > > > > =3D=3D809138=3D=3D    by 0x598F70C: g_free (in /usr/lib64/libglib=
-2.0.so.0.6600.8)
> > > > > =3D=3D809138=3D=3D    by 0x79B6AD: qemu_rdma_cleanup (rdma.c:2432=
)
> > > > > =3D=3D809138=3D=3D    by 0x79CEE6: qio_channel_rdma_close_rcu (rd=
ma.c:3108)
> > > > > =3D=3D809138=3D=3D    by 0xC2E339: call_rcu_thread (rcu.c:301)
> > > > > =3D=3D809138=3D=3D    by 0xC2116A: qemu_thread_start (qemu-thread=
-posix.c:541)
> > > > > =3D=3D809138=3D=3D    by 0x72683F8: ??? (in /usr/lib64/libpthread=
-2.32.so)
> > > > > =3D=3D809138=3D=3D    by 0x73824C2: clone (in /usr/lib64/libc-2.3=
2.so)
> > > > > =3D=3D809138=3D=3D  Address 0x13daa070 is 0 bytes inside a block =
of size 14 free'd
> > > > > =3D=3D809138=3D=3D    at 0x483A9F5: free (vg_replace_malloc.c:538=
)
> > > > > =3D=3D809138=3D=3D    by 0x598F70C: g_free (in /usr/lib64/libglib=
-2.0.so.0.6600.8)
> > > > > =3D=3D809138=3D=3D    by 0xC058CF: qapi_dealloc_type_str (qapi-de=
alloc-visitor.c:68)
> > > > > =3D=3D809138=3D=3D    by 0xC09EF3: visit_type_str (qapi-visit-cor=
e.c:349)
> > > > > =3D=3D809138=3D=3D    by 0xBDDECC: visit_type_InetSocketAddressBa=
se_members (qapi-visit-sockets.c:29)
> > > > > =3D=3D809138=3D=3D    by 0xBDE055: visit_type_InetSocketAddress_m=
embers (qapi-visit-sockets.c:67)
> > > > > =3D=3D809138=3D=3D    by 0xBDE30D: visit_type_InetSocketAddress (=
qapi-visit-sockets.c:119)
> > > > > =3D=3D809138=3D=3D    by 0xBDDB38: qapi_free_InetSocketAddress (q=
api-types-sockets.c:51)
> > > > > =3D=3D809138=3D=3D    by 0x792351: glib_autoptr_clear_InetSocketA=
ddress (qapi-types-sockets.h:109)
> > > > > =3D=3D809138=3D=3D    by 0x79236F: glib_autoptr_cleanup_InetSocke=
tAddress (qapi-types-sockets.h:109)
> > > > > =3D=3D809138=3D=3D    by 0x79D956: qemu_rdma_accept (rdma.c:3341)
> > > > > =3D=3D809138=3D=3D    by 0x79F05A: rdma_accept_incoming_migration=
 (rdma.c:4041)
> > > > > =3D=3D809138=3D=3D  Block was alloc'd at
> > > > > =3D=3D809138=3D=3D    at 0x4839809: malloc (vg_replace_malloc.c:3=
07)
> > > > > =3D=3D809138=3D=3D    by 0x5992BB8: g_malloc (in /usr/lib64/libgl=
ib-2.0.so.0.6600.8)
> > > > > =3D=3D809138=3D=3D    by 0x59A7FE3: g_strdup (in /usr/lib64/libgl=
ib-2.0.so.0.6600.8)
> > > > > =3D=3D809138=3D=3D    by 0x79C2A8: qemu_rdma_data_init (rdma.c:27=
31)
> > > > > =3D=3D809138=3D=3D    by 0x79F183: rdma_start_incoming_migration =
(rdma.c:4081)
> > > > > =3D=3D809138=3D=3D    by 0x76F200: qemu_start_incoming_migration =
(migration.c:581)
> > > > > =3D=3D809138=3D=3D    by 0x77193A: qmp_migrate_incoming (migratio=
n.c:1735)
> > > > > =3D=3D809138=3D=3D    by 0x74B3D3: qmp_x_exit_preconfig (vl.c:271=
8)
> > > > > =3D=3D809138=3D=3D    by 0x74DB6F: qemu_init (vl.c:3753)
> > > > > =3D=3D809138=3D=3D    by 0xA14F3F: main (main.c:47)
> > > >
> > > > --
> > > > Peter Xu
> > > >
> >
> >
> >
> > --
> >
> > Alexei Pastuchov
> >
> > Senior Linux Systems Developer
> > Compute Platform Development Cloud
> >
> > IONOS SE | Revaler Str. 28-31 | 10245 Berlin | Deutschland
> > E-Mail: alexei.pastuchov@ionos.com | Web: www.ionos.de
> >
> > Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498
> >
> > Vorstand: H=C3=BCseyin Dogan, Claudia Frese, Arthur Mai, Dr. Markus Nog=
a,
> > Dr. Jens-Christian Reich, Britta Schmidt, Achim Wei=C3=9F
> > Aufsichtsratsvorsitzender: Sven Fritz
> >
> > Member of United Internet
> >
> > Diese E-Mail kann vertrauliche und/oder gesetzlich gesch=C3=BCtzte
> > Informationen enthalten. Wenn Sie nicht der bestimmungsgem=C3=A4=C3=9Fe=
 Adressat
> > sind oder diese E-Mail irrt=C3=BCmlich erhalten haben, unterrichten Sie
> > bitte den Absender und vernichten Sie diese E-Mail. Anderen als dem
> > bestimmungsgem=C3=A4=C3=9Fen Adressaten ist untersagt, diese E-Mail zu
> > speichern, weiterzuleiten oder ihren Inhalt auf welche Weise auch
> > immer zu verwenden.
> >
> > This e-mail may contain confidential and/or privileged information. If
> > you are not the intended recipient of this e-mail, you are hereby
> > notified that saving, distribution or use of the content of this
> > e-mail in any way is prohibited. If you have received this e-mail in
> > error, please notify the sender and delete the e-mail.

