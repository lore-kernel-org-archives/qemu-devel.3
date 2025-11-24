Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D4CCFD2F6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 01:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNLpQ-0007i6-C8; Sun, 23 Nov 2025 20:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vNLp5-0007eG-Sz
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 20:57:02 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vNLp2-0004qK-Ih
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 20:56:58 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b728a43e410so695035066b.1
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 17:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763949414; x=1764554214; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tutQ53CJ+xIMHhMir04pSJ8/pZ84/JutQX7x3ZRu1uE=;
 b=ZRj9hDRjb33DYAIuKjrgZqXph5ssnmX8brFbOkj2tvrpzB8mwPrjIZOPRty/5MA/xZ
 RdCyZKeuRAwyY+sxYlBC5pCPxzC/hUC50h3WKNrJG6M+VAFVkWimF+IwVlccu6zX//qG
 YvqDah+reGKdVN8rcUEQ4sZFCR7THPl148yBYW0dWVKSn2YsSpliscZNUuiAgoLLjZIa
 V5SZ/Mak95luIt/Pz3M099lOeX6T+HkSY3r7h2e7gisxlweMGgFaAnh4z3l70NZUJ/qw
 z+F+oMyTffZY1O2xJk+3iMTy0vk1fbqEr8CFopmwuwONMC2TbN2LkOj8c04L1XUc8oWG
 8pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763949414; x=1764554214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tutQ53CJ+xIMHhMir04pSJ8/pZ84/JutQX7x3ZRu1uE=;
 b=mh2qul87tUQKCI6FVv2bYyOTwcS3/ZzMULlSJWCXa2sV0p8cCNkYYwGZ+A+Hl9Wi0y
 wkaSKvcxMpB94Xavv69a/MvVue7291A1txmu7AgtoTYkUVn4NUQUAf5vwdw91Y2h0bFb
 g7PSYVuMxljlRJFO08WnbS6h5qi1C355bmPm+Jhexn5piWcGjXOS9+BxuTGMHpKkCC0Y
 ZIK2BhCwz+w0v0rNqDjrTwfNXf3yXHabX6GAxjoDDYGeyJWB6CI39lmNhmIhNdqOP+3u
 u9WolRbtP86aetoqTYS5E2tv1804uJGxNeFnf394FOqeZF6JYiMy3tZkUMvWjvnKEFt5
 sTeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJJ3z+HsXIiIegFxQJxVx/o0FLVKzAUXq/09rb/ViiF1bMb5a/ILEXBoBC1WUTUrYElTlInyVX0AG8@nongnu.org
X-Gm-Message-State: AOJu0YznQqalnppENbBqq/QAzg0AYKFXD2z5u8yvOhr29ViznPE3bb5E
 60jpeEDnAC9p6UDFsuoK1GmQbwePqDx/ogkZ0RKeCHKKGtd0qvdqm7v62qhf1iOibEg/nw4Cd9Q
 ijLfbGW8lmNfXHYpe4fQ4Doj5rSkRucI=
X-Gm-Gg: ASbGncsrB/wo5R9bh0GvPWZ+dEVXHbkQ8i7+QqxzS9RJqOq82zDDDDAfBMPerkoAFn1
 zdwK21ufcbfW+fXxm6vbwMicFKMARXIJCLLIaF5Ysr4WbPY6p43xf/h+PPSROez5/tgnWoTNUzy
 L8hKQz9x8RVW22uGqvgRcGTCCMt1beB6but8+MJk8SMOnN14sXEiH0k6aACTDCF6MRnXolQrapV
 5HRUSeZk0AwoSx1Gyhm5YXgLF3RxR8Vi1u1QTRYCaza6hS05erviSoTkdAMOa7sZbzuijuf
X-Google-Smtp-Source: AGHT+IHKRKSMyDbBmFzPNm3kO/96h4+xdesAj1+Zxr0oZFwjDftjm4/YBT6pWWMMga31CK2uulOzoJ5Kz4FpROP+RXY=
X-Received: by 2002:a17:907:a0d:b0:b70:be0b:6ba8 with SMTP id
 a640c23a62f3a-b76719d9598mr1025267866b.61.1763949414152; Sun, 23 Nov 2025
 17:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20251104013606.1937764-1-lizhijian@fujitsu.com>
 <aQu6bDAA7hnIPg-y@x1.local> <b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.com>
 <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
 <CACGkMEv=VGG0jvUGBM84=Fzn8hPk9PMVDmTk9vvFWVuk1q8BsQ@mail.gmail.com>
In-Reply-To: <CACGkMEv=VGG0jvUGBM84=Fzn8hPk9PMVDmTk9vvFWVuk1q8BsQ@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 24 Nov 2025 09:56:17 +0800
X-Gm-Features: AWmQ_blv8appMLSCN4hBRJ5Q8FigZI2YEWz0sIjNhvOlx2o7DqxNCMGVxsfShBs
Message-ID: <CAK3tnv+XCxRm3GiyQgMY6zLey_OYA=O-P0Ex1ik1FUrL_v-p5Q@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix transition to COLO state from precopy
To: Jason Wang <jasowang@redhat.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, 
 "zhanghailiang@xfusion.com" <zhanghailiang@xfusion.com>,
 "farosas@suse.de" <farosas@suse.de>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lukas Straub <lukasstraub2@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 24, 2025 at 8:35=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Nov 6, 2025 at 11:23=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> =
wrote:
> >
> > On Thu, Nov 6, 2025 at 9:10=E2=80=AFAM Zhijian Li (Fujitsu)
> > <lizhijian@fujitsu.com> wrote:
> > >
> > >
> > >
> > > On 06/11/2025 04:58, Peter Xu wrote:
> > > > On Tue, Nov 04, 2025 at 09:36:06AM +0800, Li Zhijian wrote:
> > > >> Commit 4881411136 ("migration: Always set DEVICE state") set a new=
 DEVICE
> > > >> state before completed during migration, which broke the original =
transition
> > > >> to COLO. The migration flow for precopy has changed to:
> > > >> active -> pre-switchover -> device -> completed.
> > > >>
> > > >> This patch updates the transition state to ensure that the Pre-COL=
O
> > > >> state corresponds to DEVICE state correctly.
> > > >>
> > > >> Fixes: 4881411136 ("migration: Always set DEVICE state")
> > > >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > > >> ---
> > > >>   migration/migration.c | 4 ++--
> > > >>   1 file changed, 2 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/migration/migration.c b/migration/migration.c
> > > >> index a63b46bbef..6ec7f3cec8 100644
> > > >> --- a/migration/migration.c
> > > >> +++ b/migration/migration.c
> > > >> @@ -3095,9 +3095,9 @@ static void migration_completion(MigrationSt=
ate *s)
> > > >>           goto fail;
> > > >>       }
> > > >>
> > > >> -    if (migrate_colo() && s->state =3D=3D MIGRATION_STATUS_ACTIVE=
) {
> > > >> +    if (migrate_colo() && s->state =3D=3D MIGRATION_STATUS_DEVICE=
) {
> > > >>           /* COLO does not support postcopy */
> > > >> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> > > >> +        migrate_set_state(&s->state, MIGRATION_STATUS_DEVICE,
> > > >>                             MIGRATION_STATUS_COLO);
> > > >>       } else {
> > > >>           migration_completion_end(s);
> > > >
> > > > Thanks a lot for fixing it, Zhijian.  It means I broke COLO already=
 for
> > > > 10.0/10.1..
> > > >
> > > > Hailiang/Chen, do you still know anyone who is using COLO, especial=
ly in
> > > > enterprise?  I don't expect any individual using it.. It definitely
> > > > complicates migration logics all over the places.  Fabiano and I di=
scussed
> > > > a few times on removing legacy code and COLO was always in the list=
.
> > > >
> > > > We used to discuss RDMA obsoletion too, that's when Huawei develope=
rs at
> > > > least tried to re-implement the whole RDMA using rsocket, that didn=
't land
> > > > only because of a perf regression.  Meanwhile, Zhijian also provide=
d an
> > > > unit test, which we rely on recently to not break RDMA at the minim=
um.
> > > >
> > > > If we do not have known users, I sincerely want to discuss with you=
 on
> > > > obsoletion and removal of COLO from qemu codebase.  Do you see feas=
ible?
> > > >
> > > > Zhijian, do you have any input here?
> > >
> > >
> > > If we don't have any known users, I personally have no objection to r=
emoving COLO.
> > >
> > >  From my previous understanding, its use cases are rather limited, an=
d the checkpointing overhead is significant.
> > > Moreover, with the continuous development of Cloud Native over the pa=
st decade, service-based
> > > FT/HA solutions have become very mature, which shrinks the use cases =
for VM-based FT solutions even further.
> > >
> > > I think it's worth keeping if we have:
> > >
> > > - Active users who depend on it.
> > > - A unit test for the COLO framework.
> > >
> > > Thanks
> > > Zhijian
> > >
> > >
> >
> > Add CC Lukas.
> >
> > From technical point, I agree Zhijian's comments. We can probably do
> > this gradually.
> > In my side, I know some local companies build thier HA/FT product based=
 on COLO.
> > In this case, I think most of them already forked QEMU upstream code
> > to a private repo for internal mantained.
> > It may caused some upgrade issues in the future.
> >
> > And another part is Lukas covered pacemaker project integrated COLO,
> > and I don't know users status for pacemaker.
> > Maybe Lukas can input some comments?
> >
> > For the implementation, COLO not only have migration part of code(it
> > is the core of COLO), it also including network and block replication
> > for co-working.
> > If we remove migration related code need to consider how to handle
> > other parts, network maybe change to general QEMU netfilter?  block
> > replication ?
>
> SInce netfiler code was mostly decoupled with COLO, I think we can
> keep them. Or just deprecate colo-compare.
>

If the deprecation decision is made, I will send patch to deprecate
colo-compare related code.
It is OK for me.

Thanks
Chen

> Thanks
>
> >
> > For the COLO framework unit test,  I think it need to add some "#if
> > defined(qtest)" in migration code for testing(COLO proxy/netfilter
> > already have independent qtest).
> >
> > Thanks
> > Chen
> >
> >
> >
> >
> >
> > >
> > > >
> > > > Thanks,
> > > >
> >
>

