Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01B5CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 03:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGqa7-0005Dd-4d; Wed, 05 Nov 2025 22:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vGqa5-0005DF-Gd
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 22:22:37 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vGqa3-0005Aq-OC
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 22:22:37 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so90932666b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 19:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762399353; x=1763004153; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJIH4GTj+IphAqTfdFNYa6VrzMoLdcLGUsSF9hSFVeU=;
 b=JMao7juVBn8tzwFsvYOHaPLgLk5d0Nbru5tg32HjcLzBZcrb54dFPbtDwSvuA1dbgu
 BDb5aOxUjgYjrwgNA7sRuKS27a6lCiiIOJsqCnnR5f0MDRNGueFA1772Pz2ahA4T9TZD
 8AJ7qoFw3XzQWyonfJJzM+JhfVZo7wlAtGy/Ycm3EfSiN5VrG20dxy78L3+hLHumZPdP
 mKErZoGuhV/49qZc9ziP2qqwMlIrxKzqQDlXOhQC0o+nTVF1VG/qkcUP7KQ6L5ZPim3K
 BJxBZJ6o/4sN9wel0FNJ/2T6/A3dGWeMONl9vUWkwMmw3827FzmQJ8Q3XqAHwXTB0LI5
 z8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762399353; x=1763004153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJIH4GTj+IphAqTfdFNYa6VrzMoLdcLGUsSF9hSFVeU=;
 b=LOex5sbm8Cr63GCPNTFIMLFfa6YF3n0J8ohp+bayBA3qDEoDQvl5SR295s9OhEj0vZ
 DkJoXG69t6JpnBFa23r8kJqMdVVczxMXrnlQ3NF53UjJEdRClxvuk0vxzcsm74TZT7mn
 F4lbiwaoUug3TI9TtAG/3UacCKE6VFzeVGFuFK60MIXQz6wdrgegbaPUpI6uFXXTPZsL
 EQdcL+8z+D1dkdrywkXNtg4KY/DMXRNLMLrvhSua9PQ3nRHnMjpigdsCrYjvrwoWeh7m
 XyQrss0DQmGKOsgbnzhXnxDUCwZYeCCDRADmAFwN27JGqmDEby1Dodbs7DoQbu+UwyC8
 Stbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7qgSioW+c58pqJCT5BDfhtYQ8lOgMNDpSwzDu9ao9zGNQ32loHLne0yXIrcLg41tvIDUDlMrNZw1Q@nongnu.org
X-Gm-Message-State: AOJu0Yz/5ancN/ZM8LZKEfdSR9FoxUW92M6ei6vH33vYWmxK9B4E3f0N
 fZN7bbWRTXUwtb0q2fjfETjzWQLBwVbvE+AStB7D2eoGOjXMEwCpOBEjCieUugEXzKyA26UwCUK
 VkrELSEP6R0U/5I5WzyYQwlMHoqrQIIU=
X-Gm-Gg: ASbGnctjyBCOzrvzJ0ZWwL1vK2jzyfHNdnwiIHy9ClVYw5WdWAo+4EWpSUoIesL0oNW
 WF2/3th+qove1UkJb+MqNHUycSzjlAsIKu4xjn2iME1JXyxhHrRrNP8T87mPQucerWd+3J1xKsz
 3u1x1DvrEsCn75+n9/C7aQX9TLDCcGeOVlyCTaE392f5UnJEZar2zRt5aTrGW9M/f1o8xRWox4Z
 DGoQpqoQXLK0FEWDG2KELEhDTx60Yl0LJaPdYTXQ6sVLM5dBucnKmG38iHpMw==
X-Google-Smtp-Source: AGHT+IF/f5vY3ucGvc8tJFNCBHzG8oOb4UiRRvFuz4m9Yb9zkiWqp/roWogywqL3y71MOjL41o2qW+YqPyL6PK9y2lo=
X-Received: by 2002:a17:907:9607:b0:b6d:671d:8814 with SMTP id
 a640c23a62f3a-b72895c5efcmr199465366b.27.1762399353023; Wed, 05 Nov 2025
 19:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20251104013606.1937764-1-lizhijian@fujitsu.com>
 <aQu6bDAA7hnIPg-y@x1.local> <b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.com>
In-Reply-To: <b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 6 Nov 2025 11:21:56 +0800
X-Gm-Features: AWmQ_bnnvvXj6qHts1Cz0yLc_umbceXjZf42b3piYvJXBtmYYpVEwZCOXn_jqWs
Message-ID: <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix transition to COLO state from precopy
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Peter Xu <peterx@redhat.com>, 
 "zhanghailiang@xfusion.com" <zhanghailiang@xfusion.com>,
 "farosas@suse.de" <farosas@suse.de>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lukas Straub <lukasstraub2@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62c.google.com
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

On Thu, Nov 6, 2025 at 9:10=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
>
>
> On 06/11/2025 04:58, Peter Xu wrote:
> > On Tue, Nov 04, 2025 at 09:36:06AM +0800, Li Zhijian wrote:
> >> Commit 4881411136 ("migration: Always set DEVICE state") set a new DEV=
ICE
> >> state before completed during migration, which broke the original tran=
sition
> >> to COLO. The migration flow for precopy has changed to:
> >> active -> pre-switchover -> device -> completed.
> >>
> >> This patch updates the transition state to ensure that the Pre-COLO
> >> state corresponds to DEVICE state correctly.
> >>
> >> Fixes: 4881411136 ("migration: Always set DEVICE state")
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >>   migration/migration.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index a63b46bbef..6ec7f3cec8 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -3095,9 +3095,9 @@ static void migration_completion(MigrationState =
*s)
> >>           goto fail;
> >>       }
> >>
> >> -    if (migrate_colo() && s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
> >> +    if (migrate_colo() && s->state =3D=3D MIGRATION_STATUS_DEVICE) {
> >>           /* COLO does not support postcopy */
> >> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> >> +        migrate_set_state(&s->state, MIGRATION_STATUS_DEVICE,
> >>                             MIGRATION_STATUS_COLO);
> >>       } else {
> >>           migration_completion_end(s);
> >
> > Thanks a lot for fixing it, Zhijian.  It means I broke COLO already for
> > 10.0/10.1..
> >
> > Hailiang/Chen, do you still know anyone who is using COLO, especially i=
n
> > enterprise?  I don't expect any individual using it.. It definitely
> > complicates migration logics all over the places.  Fabiano and I discus=
sed
> > a few times on removing legacy code and COLO was always in the list.
> >
> > We used to discuss RDMA obsoletion too, that's when Huawei developers a=
t
> > least tried to re-implement the whole RDMA using rsocket, that didn't l=
and
> > only because of a perf regression.  Meanwhile, Zhijian also provided an
> > unit test, which we rely on recently to not break RDMA at the minimum.
> >
> > If we do not have known users, I sincerely want to discuss with you on
> > obsoletion and removal of COLO from qemu codebase.  Do you see feasible=
?
> >
> > Zhijian, do you have any input here?
>
>
> If we don't have any known users, I personally have no objection to remov=
ing COLO.
>
>  From my previous understanding, its use cases are rather limited, and th=
e checkpointing overhead is significant.
> Moreover, with the continuous development of Cloud Native over the past d=
ecade, service-based
> FT/HA solutions have become very mature, which shrinks the use cases for =
VM-based FT solutions even further.
>
> I think it's worth keeping if we have:
>
> - Active users who depend on it.
> - A unit test for the COLO framework.
>
> Thanks
> Zhijian
>
>

Add CC Lukas.

From technical point, I agree Zhijian's comments. We can probably do
this gradually.
In my side, I know some local companies build thier HA/FT product based on =
COLO.
In this case, I think most of them already forked QEMU upstream code
to a private repo for internal mantained.
It may caused some upgrade issues in the future.

And another part is Lukas covered pacemaker project integrated COLO,
and I don't know users status for pacemaker.
Maybe Lukas can input some comments?

For the implementation, COLO not only have migration part of code(it
is the core of COLO), it also including network and block replication
for co-working.
If we remove migration related code need to consider how to handle
other parts, network maybe change to general QEMU netfilter?  block
replication ?

For the COLO framework unit test,  I think it need to add some "#if
defined(qtest)" in migration code for testing(COLO proxy/netfilter
already have independent qtest).

Thanks
Chen





>
> >
> > Thanks,
> >

