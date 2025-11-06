Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99203CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 22:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH898-0004Ir-L6; Thu, 06 Nov 2025 17:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vH897-0004Ij-3t
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 17:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vH893-00056r-US
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 17:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762466871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+lStRZOSEGIQeQZq0lNXs1m/GHJ3wuMMnjlL1pw2ss=;
 b=BNWzK3mYMRzYONqw9pNRlA4Lza7mRQTmgIX/YVWPdU44mZqZEM2vQ+KAI9kQBufudh6O9v
 yobi6PXsptPlh8ZIjvEYeGj6nZq5ruhXUmqtmFSj4Kixk51jKSdCkBshNA5RufrPZ3/zSL
 UqC0OLh1K3PrgkffDihE0WwCjW7NYd8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-gNC8uUL6P7uYHhsH_2PqvA-1; Thu, 06 Nov 2025 17:07:50 -0500
X-MC-Unique: gNC8uUL6P7uYHhsH_2PqvA-1
X-Mimecast-MFC-AGG-ID: gNC8uUL6P7uYHhsH_2PqvA_1762466870
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2194e266aso40745485a.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 14:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762466870; x=1763071670; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s+lStRZOSEGIQeQZq0lNXs1m/GHJ3wuMMnjlL1pw2ss=;
 b=UkBzCvNb1wBivrOoEvth5qMxhiCrOlJP1IAGIKRRoGRY542TDp5/XWen5ElgDUOBVV
 1H3gWEUZrlo9huMemWn7vcSWvTBNWZzN7euKs55CsTs+iGSH6ySGcUEmJET4nOf2Oa0/
 MUW0vSxKjtUQjOPj4gE3ecRL9YFmLKliJmxyEkPkef1FtgljK6IjtPln+4aswp2Vb3i9
 xyQO5KOCAf5SdadJunNUEMgp9b1ukUwT1wk2MGll80fSHSpHwPLzbPSx1TmxPSB5iu6Y
 zB1a8OiFCJEMQlcpR2r+TrwndQFrc4j26jE09na8uZ9klBuvsYEiqRQlYJl2reZwfvW8
 Nltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762466870; x=1763071670;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s+lStRZOSEGIQeQZq0lNXs1m/GHJ3wuMMnjlL1pw2ss=;
 b=ArVDcZGASMxUL+KGjPZSysZk9IQcCuiMQa+4R5lGZ/LYQHM5vCFGZcCcRk9d01QsSG
 birK1/6WSejApgpbh/HAuNd3u8uvlinBXaSPrD97Dd2SXj6jJC/HeyLv5P+EwM2QTfVl
 MdgyvsQky0F+hF0f2P/0c2sLquQQeT3Eq/H8IwCrCCeA0E4QfVjoYgCipTjoW6cj6a0h
 DFOfxjv23MTzv5KI4vLP71xt2Y8zJ5mEh64kW5IRaP2vUuzIVoe/qTzQz8F4cWJDEcp2
 iZha1HZN18EFQ8xDf5J+e+XE8kdT4kk+ciQIaRdhKv7FMNMf+W2deUF6aY4he0skymRg
 KpiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJXrHNtkssZq0byUQUX8HJsfwihUhhRR1FWA5apuy8wFeA1pMksd86Tt6UTxFK5CI/fhin+JZARnRX@nongnu.org
X-Gm-Message-State: AOJu0Yy89M96WEOjpSgvE8JXpq48C7ZgMzc5NLBoPPC90XvRssMI8/7e
 qd2SNa++APou1TzMvOCP6N/ryIQpr88Pyj5Xgia9rKK8MfTlKwrj/v0QwH+Qx4tUXmXAuqEHxht
 1P++r+rKJEEjLq94sNEFk4s32VakSMWB3shLhwGiMQA0wV4Mk9geczy9X
X-Gm-Gg: ASbGncsHHu9fHVVCply/G62bY+uKKzzBT/1nia5AA09ubFI9ZEyY/ezMDWV4JF5d/l8
 a4dmGQSo6XkFrWLcogD7/ExUyHnX79BW5MvAoE4RN8X4/1iqtockophNWQoIT/wC9Ac0+WwflSh
 0BsvflE7cqrAJKEjZgq/t4BL03UF/cTlM7EaM6NLl9OHxGKyzB0y3W1onJJlwv4r/nVVaTQvIE9
 4Wou3QSSr+86pY08HKErxEuLp2TXtvyaMCEY7CNBIHnBueOnfmJnkFa1u+Hjc6cdzrDnALzFQLo
 iXL3aUaQF4wClOnxlkPLdhatnf3jk2Wr4ZbAONyUem+BaOJYBugiE/4TTh4kaKpECv0=
X-Received: by 2002:a05:620a:28cd:b0:8a1:90c7:bd98 with SMTP id
 af79cd13be357-8b24528e911mr175558585a.28.1762466869643; 
 Thu, 06 Nov 2025 14:07:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERuYfPSSeafbsSg+/KhHTOIzeDq27VALsFfHv9HCj4eIIqUGWfVXGWWGdvPg2bQADwxPWGwA==
X-Received: by 2002:a05:620a:28cd:b0:8a1:90c7:bd98 with SMTP id
 af79cd13be357-8b24528e911mr175554485a.28.1762466869007; 
 Thu, 06 Nov 2025 14:07:49 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b23582762asm275750685a.51.2025.11.06.14.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 14:07:48 -0800 (PST)
Date: Thu, 6 Nov 2025 17:07:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "zhanghailiang@xfusion.com" <zhanghailiang@xfusion.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lukas Straub <lukasstraub2@web.de>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] migration: Fix transition to COLO state from precopy
Message-ID: <aQ0cMhod-MC0gGL0@x1.local>
References: <20251104013606.1937764-1-lizhijian@fujitsu.com>
 <aQu6bDAA7hnIPg-y@x1.local>
 <b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.com>
 <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 06, 2025 at 11:21:56AM +0800, Zhang Chen wrote:
> On Thu, Nov 6, 2025 at 9:10 AM Zhijian Li (Fujitsu)
> <lizhijian@fujitsu.com> wrote:
> >
> >
> >
> > On 06/11/2025 04:58, Peter Xu wrote:
> > > On Tue, Nov 04, 2025 at 09:36:06AM +0800, Li Zhijian wrote:
> > >> Commit 4881411136 ("migration: Always set DEVICE state") set a new DEVICE
> > >> state before completed during migration, which broke the original transition
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
> > >> @@ -3095,9 +3095,9 @@ static void migration_completion(MigrationState *s)
> > >>           goto fail;
> > >>       }
> > >>
> > >> -    if (migrate_colo() && s->state == MIGRATION_STATUS_ACTIVE) {
> > >> +    if (migrate_colo() && s->state == MIGRATION_STATUS_DEVICE) {
> > >>           /* COLO does not support postcopy */
> > >> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> > >> +        migrate_set_state(&s->state, MIGRATION_STATUS_DEVICE,
> > >>                             MIGRATION_STATUS_COLO);
> > >>       } else {
> > >>           migration_completion_end(s);
> > >
> > > Thanks a lot for fixing it, Zhijian.  It means I broke COLO already for
> > > 10.0/10.1..
> > >
> > > Hailiang/Chen, do you still know anyone who is using COLO, especially in
> > > enterprise?  I don't expect any individual using it.. It definitely
> > > complicates migration logics all over the places.  Fabiano and I discussed
> > > a few times on removing legacy code and COLO was always in the list.
> > >
> > > We used to discuss RDMA obsoletion too, that's when Huawei developers at
> > > least tried to re-implement the whole RDMA using rsocket, that didn't land
> > > only because of a perf regression.  Meanwhile, Zhijian also provided an
> > > unit test, which we rely on recently to not break RDMA at the minimum.
> > >
> > > If we do not have known users, I sincerely want to discuss with you on
> > > obsoletion and removal of COLO from qemu codebase.  Do you see feasible?
> > >
> > > Zhijian, do you have any input here?
> >
> >
> > If we don't have any known users, I personally have no objection to removing COLO.
> >
> >  From my previous understanding, its use cases are rather limited, and the checkpointing overhead is significant.
> > Moreover, with the continuous development of Cloud Native over the past decade, service-based
> > FT/HA solutions have become very mature, which shrinks the use cases for VM-based FT solutions even further.
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

Thanks both for the inputs so far.

> In my side, I know some local companies build thier HA/FT product based on COLO.
> In this case, I think most of them already forked QEMU upstream code
> to a private repo for internal mantained.
> It may caused some upgrade issues in the future.

If this might be an issue to them, please share this discussion with them,
and see whether they want to get involved (if that may make their workflow
easier).  In general, whoever still rebases to upstream (even if with low
freq) should always benefit from some involvement upstream to not get
things totally out of control in their production systems.

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

This is a great question.  We can talk about that when an deprecation
decision will be made.  IMHO you guys know better than me, so suggestions
will be welcomed.

From migration POV, we don't necessary need to remove anything outside
migration; removing COLO inside migration itself will be a great offload of
our maintenance burden on its own.  But I still would definitely like to
sync with other subsystems if we decide that.. let me copy Jason already
just for awareness.  I should have already done that but I forgot, sorry.

> 
> For the COLO framework unit test,  I think it need to add some "#if
> defined(qtest)" in migration code for testing(COLO proxy/netfilter
> already have independent qtest).

Another question to be answered only after we have an initial decision to
keep COLO in this case.  So we can focus on answering the 1st question on
whether we should deprecate COLO.

Thanks,

-- 
Peter Xu


