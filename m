Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6457FCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 00:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNKYu-0006Zn-Sq; Sun, 23 Nov 2025 19:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vNKYi-0006Nc-O4
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 19:36:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vNKYf-0005MM-NX
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 19:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763944556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsmrrTddx9iPVe3ejt9KEBxuWR+3Ez3TNdhOxVkljXA=;
 b=gU8OeKt2lIApL3R3EeWBvIbhz5JAGoqHMksXG6pN9UOYbPrd6frVBWzR2748jKU1zqYrjy
 CW1KFJtZ5VCdNjoTPVp2ffMgKrDhzyv1hGjixIFhzNzn2pmuGzFmhMDBRP9WW0K0Ah/6SN
 y4f5UodOy+AVfoDLCV79NdT4Xw5JUhc=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-ZmOjAzfGN16kmORe_ES0sg-1; Sun, 23 Nov 2025 19:35:54 -0500
X-MC-Unique: ZmOjAzfGN16kmORe_ES0sg-1
X-Mimecast-MFC-AGG-ID: ZmOjAzfGN16kmORe_ES0sg_1763944554
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9371e5b4a4fso7360441241.3
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 16:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763944554; x=1764549354; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsmrrTddx9iPVe3ejt9KEBxuWR+3Ez3TNdhOxVkljXA=;
 b=r3rGOa3fGd51YIwKQqIvvaLegSLuxh93NJaxm/xVHCWLG9TZU1o48KyeFZ8smjwlgk
 sLpOo5HgkJTj/weGycMOpddzi6uVfa/wFGHiqqZHh6ZFEN2zXY8zls8k2YWeFZginMHU
 5fTztWUiKcyqCADK5DQxaQXnpDQWOK8bviJmd1CpSO2SOItyr1fqt8jp3ZzhnWSAjWki
 dNqpmmS+06Gj7HUCUSwJDbIlM+5KI7PJ8qQ6phzaj6nx2oUh/VVa9reYfaa5tX/u5FIG
 1PTlfSkqm6oipR5vvndsCPFaaDiL7Ra9I6pTHw2vLTbI1RPbFrAS9WvI555YW5nXVVEG
 ZCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763944554; x=1764549354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nsmrrTddx9iPVe3ejt9KEBxuWR+3Ez3TNdhOxVkljXA=;
 b=LM8LJi/zFy+esHpTKPyrHUTAgKFDBwZVcHyyqjXB1Hse5srof4DVmtjnRCS5A1S/Pr
 SyawxbjH5I7owUnrb0Tf+Mqgm1IwQqgMuKKqP2tnvs5i0Fy+1aJYOs1IZmKPXlMNMgfj
 wzLURr2lvYglPf3M1tTBX41Veg0PZupWNMZznTXAL5EpeJi6AMOs1cE7Optk/thMuJKK
 /WvccoZlLmEptz7FhHo+nlD4l4blIRGpG3EFM0klVPuzwn4kL7Qoh92Y8PVDCxzAhqcc
 IWxvZyf5NzmLSCM7U32uBZF7IrBFYuBSBcD2d19ai8JQ2ZtgSpkh43o0bHjvbqWSdTJf
 QDNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0gEEKzircGwQtzllcu03TTObI596xSsQIYsuIk+yHAaYgH9B2fq2+3jg90CGpZkF+LHNwe7VwwfNT@nongnu.org
X-Gm-Message-State: AOJu0Yw7FiyBV3Ol/e3o0RzsZBvYwLSTK5k7Ff/LAEE5BeIm3Q/koUCt
 IzoFk8VHDHzvFb1486W4oZcsEBfT0HPiFo5p3pRyaKmiyrLXjH5WJvU1Fhnpw4MmVz49TO+QVg3
 sWzVr8XmewHM4BFgazm42CU9PJ7golQaGCOa+orO8pKJ45lnFTBSjhA4KQP8YUv8IFTmGzCMsb5
 ISyfsICL9YKstOub+TFwBACELlizgX4Pk=
X-Gm-Gg: ASbGnctvUGmOd/nfzuFHMhxgio8FaAGorybCNngnp2YxvSo3UZ19nKBoxFh3as7Ft6Y
 2Qg/2HE05UusuxtfxQOK0ftv9+4tDaok34XPII+JezlBUY3uLxfUA7EsBlDBX+RlLT/BteKSu8j
 lYwqbd60yUZ6g2tlzkxuEc9pqWy5BYLTKlySHZY0XjPeQ6OUaQKEY90pB48Tm9iHQgkBo=
X-Received: by 2002:a05:6102:3f4d:b0:5db:25b5:9b4f with SMTP id
 ada2fe7eead31-5e1de396e6amr3312358137.26.1763944554239; 
 Sun, 23 Nov 2025 16:35:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGARlDNUR3koKxmgAwuRHBjZFH0k5XI3SmfHBY8SgqBtJvallLGxUqYKRalZhphSXneKRt9xDqjFaPqYUHYgms=
X-Received: by 2002:a05:6102:3f4d:b0:5db:25b5:9b4f with SMTP id
 ada2fe7eead31-5e1de396e6amr3312350137.26.1763944553842; Sun, 23 Nov 2025
 16:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20251104013606.1937764-1-lizhijian@fujitsu.com>
 <aQu6bDAA7hnIPg-y@x1.local> <b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.com>
 <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
In-Reply-To: <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Nov 2025 08:35:40 +0800
X-Gm-Features: AWmQ_bnWUJPMheNeienFL_h6FAS5g7XjvF1sHBYrZ9w3UrZ5XL10bHDuI0Gu8nI
Message-ID: <CACGkMEv=VGG0jvUGBM84=Fzn8hPk9PMVDmTk9vvFWVuk1q8BsQ@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix transition to COLO state from precopy
To: Zhang Chen <zhangckid@gmail.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, 
 "zhanghailiang@xfusion.com" <zhanghailiang@xfusion.com>,
 "farosas@suse.de" <farosas@suse.de>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lukas Straub <lukasstraub2@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 6, 2025 at 11:23=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> wr=
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

SInce netfiler code was mostly decoupled with COLO, I think we can
keep them. Or just deprecate colo-compare.

Thanks

>
> For the COLO framework unit test,  I think it need to add some "#if
> defined(qtest)" in migration code for testing(COLO proxy/netfilter
> already have independent qtest).
>
> Thanks
> Chen
>
>
>
>
>
> >
> > >
> > > Thanks,
> > >
>


