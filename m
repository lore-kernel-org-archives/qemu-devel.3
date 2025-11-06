Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC07CCFA0D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 03:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGqc7-0005n7-Gn; Wed, 05 Nov 2025 22:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vGqc6-0005mk-5J
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 22:24:42 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vGqc4-0000NX-9Y
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 22:24:41 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b71397df721so85152066b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 19:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762399479; x=1763004279; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgoU9sDGSZR4/SQJMiz/nPsbPORCwpHS5x9UIvmLjlI=;
 b=RLoluePomQ648Lsh3m2cUNMswedHVDlVwm7ZxvJx+0vOGarTtHCyEifut/KKqueO9/
 U0Pu0U7HSgXhi4YbAqpUVzVQ52a3qAUDSTbegR8r3slqQDU06FrGymq3/oOGzr3OlGCc
 3B+q+UrJOWOku0AJ7NaT1ll6bCehSk4Dgrv+g9WzW5zOWP/eZFnZNoHPaaKEnymjr3Lt
 IkmJP7ylpAN3fjMZN1yTFpI0O6MP9J5z7r4H8vQyTfwRZJBN136moBkpAVp6wOWuWy73
 6schski2D3ji5xgcuQ7GLm3fyeBm7DnudaJKNNf2Bjwd0RigC67kzLG2uBOi0wdfB0YY
 2bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762399479; x=1763004279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgoU9sDGSZR4/SQJMiz/nPsbPORCwpHS5x9UIvmLjlI=;
 b=vMbe9I2yX2ReBcGqlOgyvzB7RCv61hWNyEAmOZhj/3Bcl9Ooyv4Gra/iMQEoZZLeen
 ttMQczretSfrwcY9KwdGtK49SmNfXD4mdICVqpbXUjX4wGSpLKf1oh8HyaMKQkwvI3lS
 9zxWZ/74KBVdk1WDOrGdf68ICoHCv5qEIvNXc5wayVADuI94Sp59OYdmtnId6PBj+mFn
 KMl/q7+DlzqE0T64PGUfheewqPjQeQhKBP8WFZljmW4MhZQXeVl0G77R/7d5Frp3vYwn
 atNYQkfXhLeQdwWxSQUz3B+ciHdbykR47H/9PrPoXf9SQz7EcmRJio3wPKz9UfddRCDO
 U+Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSBOo6l/7ZWP7nSipijL/wGpQyLyoDdZr2Eu7BEMb4p5JEc9BDas4LlO/mfDvLjp/eLurPuIVKvwqa@nongnu.org
X-Gm-Message-State: AOJu0YyAUAKR8UD8oI4QmFgerkHWisNh2xHzuEfkm5SK7FS/NqNNJScW
 dz+URUp2I6Wai46xx7IZbQBlXXyLZbvlSXLBlsFpptOJ9SiXksm337Rrxh4/nsQCinwpbJXyAKV
 mtmI++inrAfgCaRutfROHsKJfXrmrJtg=
X-Gm-Gg: ASbGncvKq+LbIva/Z1sLa+/kGHsS3BeTqzpO6bMn7ITw0UYLD37et+FTBDsPdQYeRrS
 CGBKCFqqBkRKxqURQy8sbOBJacqxLut4K8XiIOP5KLrHkflVciRNp1wNDoWllEgUDlMWItYodUl
 cRJf1a7VeACYTyH8v8fuat30ZDkOEQ9mOo4ioSaa2vJfTiTcZzVWbhQz0fBGxfltwXS+k1Ev48J
 u8I5HQ1f7ApLE7HJHHDsezI9UXZFIkqXhs/xPloTEHojm+f8VzA4eZJ6rXdxQ==
X-Google-Smtp-Source: AGHT+IEpqDFL24diHoVgbz4Z+6wgRIrtrSPg8d3mRzIyJGTt5cir3j3A9PdGAe8GZytxDEo9plw3EglWr4I4LjRA1js=
X-Received: by 2002:a17:907:6e88:b0:b72:5983:db0f with SMTP id
 a640c23a62f3a-b726529e643mr524651066b.16.1762399478539; Wed, 05 Nov 2025
 19:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20251104013606.1937764-1-lizhijian@fujitsu.com>
 <aQu6bDAA7hnIPg-y@x1.local> <b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.com>
 <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
In-Reply-To: <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 6 Nov 2025 11:24:01 +0800
X-Gm-Features: AWmQ_bkrToLxq3SNMqyNqIFFhVVQ8BlP6nZOcxqG_abZKtcpI77p_lw1Dw0iOKM
Message-ID: <CAK3tnvJQcie33+XG1BaDUvEtVKhC_2Z7qoMn8NzhwwNXp4XHbQ@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix transition to COLO state from precopy
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Peter Xu <peterx@redhat.com>, 
 "zhanghailiang@xfusion.com" <zhanghailiang@xfusion.com>,
 "farosas@suse.de" <farosas@suse.de>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lukas Straub <lukasstraub2@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62a.google.com
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

On Thu, Nov 6, 2025 at 11:21=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> On Thu, Nov 6, 2025 at 9:10=E2=80=AFAM Zhijian Li (Fujitsu)
> <lizhijian@fujitsu.com> wrote:
> >
> >
> >
> > On 06/11/2025 04:58, Peter Xu wrote:
> > > On Tue, Nov 04, 2025 at 09:36:06AM +0800, Li Zhijian wrote:
> > >> Commit 4881411136 ("migration: Always set DEVICE state") set a new D=
EVICE
> > >> state before completed during migration, which broke the original tr=
ansition
> > >> to COLO. The migration flow for precopy has changed to:
> > >> active -> pre-switchover -> device -> completed.
> > >>
> > >> This patch updates the transition state to ensure that the Pre-COLO
> > >> state corresponds to DEVICE state correctly.
> > >>
> > >> Fixes: 4881411136 ("migration: Always set DEVICE state")
> > >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > >> ---
> > >>   migration/migration.c | 4 ++--
> > >>   1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/migration/migration.c b/migration/migration.c
> > >> index a63b46bbef..6ec7f3cec8 100644
> > >> --- a/migration/migration.c
> > >> +++ b/migration/migration.c
> > >> @@ -3095,9 +3095,9 @@ static void migration_completion(MigrationStat=
e *s)
> > >>           goto fail;
> > >>       }
> > >>
> > >> -    if (migrate_colo() && s->state =3D=3D MIGRATION_STATUS_ACTIVE) =
{
> > >> +    if (migrate_colo() && s->state =3D=3D MIGRATION_STATUS_DEVICE) =
{
> > >>           /* COLO does not support postcopy */
> > >> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> > >> +        migrate_set_state(&s->state, MIGRATION_STATUS_DEVICE,
> > >>                             MIGRATION_STATUS_COLO);
> > >>       } else {
> > >>           migration_completion_end(s);
> > >
> > > Thanks a lot for fixing it, Zhijian.  It means I broke COLO already f=
or
> > > 10.0/10.1..
> > >
> > > Hailiang/Chen, do you still know anyone who is using COLO, especially=
 in
> > > enterprise?  I don't expect any individual using it.. It definitely
> > > complicates migration logics all over the places.  Fabiano and I disc=
ussed
> > > a few times on removing legacy code and COLO was always in the list.
> > >
> > > We used to discuss RDMA obsoletion too, that's when Huawei developers=
 at
> > > least tried to re-implement the whole RDMA using rsocket, that didn't=
 land
> > > only because of a perf regression.  Meanwhile, Zhijian also provided =
an
> > > unit test, which we rely on recently to not break RDMA at the minimum=
.
> > >
> > > If we do not have known users, I sincerely want to discuss with you o=
n
> > > obsoletion and removal of COLO from qemu codebase.  Do you see feasib=
le?
> > >
> > > Zhijian, do you have any input here?
> >
> >
> > If we don't have any known users, I personally have no objection to rem=
oving COLO.
> >
> >  From my previous understanding, its use cases are rather limited, and =
the checkpointing overhead is significant.
> > Moreover, with the continuous development of Cloud Native over the past=
 decade, service-based
> > FT/HA solutions have become very mature, which shrinks the use cases fo=
r VM-based FT solutions even further.
> >
> > I think it's worth keeping if we have:
> >
> > - Active users who depend on it.
> > - A unit test for the COLO framework.
> >
> > Thanks
> > Zhijian
> >
> >
>
> Add CC Lukas.
>
> From technical point, I agree Zhijian's comments. We can probably do
> this gradually.
> In my side, I know some local companies build thier HA/FT product based o=
n COLO.
> In this case, I think most of them already forked QEMU upstream code
> to a private repo for internal mantained.
> It may caused some upgrade issues in the future.
>
> And another part is Lukas covered pacemaker project integrated COLO,
> and I don't know users status for pacemaker.
> Maybe Lukas can input some comments?
>
> For the implementation, COLO not only have migration part of code(it
> is the core of COLO), it also including network and block replication
> for co-working.
> If we remove migration related code need to consider how to handle
> other parts, network maybe change to general QEMU netfilter?  block
> replication ?
>
> For the COLO framework unit test,  I think it need to add some "#if
> defined(qtest)" in migration code for testing(COLO proxy/netfilter
> already have independent qtest).
>
> Thanks
> Chen
>
>

Add pacemaker/corosync related details for COLO:
https://wiki.qemu.org/Features/COLO/Managed_HOWTO


>
>
>
> >
> > >
> > > Thanks,
> > >

