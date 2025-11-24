Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAD3CFD352
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 19:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNcEn-0004y0-O7; Mon, 24 Nov 2025 14:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNcEl-0004wT-Ry
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 14:28:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNcEj-0003SQ-4t
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 14:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764012512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rk5uReHwUkzKffnWrtraqagn7ItiMQqJ4fUaMlyphiw=;
 b=Hblk3TW5304SwxjUQw0LVpfX7K9TF2h+mOmejF51eSYHmTOiINHP9Iqe+zThr/j6kUGbDG
 l5VIWUD8klTaaCIV1WvMhlO5H90klo4NhuX2yREEN0pmBG9ZmeIldMOR8i899rMbzCkD/6
 l/VvKlM1HDEpKkQotOEJHzitrWjvpLM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-yvWiXWxFNqSWeVVk0J4RqA-1; Mon, 24 Nov 2025 14:28:30 -0500
X-MC-Unique: yvWiXWxFNqSWeVVk0J4RqA-1
X-Mimecast-MFC-AGG-ID: yvWiXWxFNqSWeVVk0J4RqA_1764012510
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8826a2b2d9aso135459216d6.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764012509; x=1764617309; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rk5uReHwUkzKffnWrtraqagn7ItiMQqJ4fUaMlyphiw=;
 b=Kp8gUyv0z9R5x9CX8blU7TmXnfnUj5IlQlNNH/P9o4MEWbV3fEg7wgjPSYM0tgjr0C
 O6fr6eDKwaZCgHLYlM5k8c7j5CEjvdLEdMoA+92kh1Ci3eX/BithrxS+cOuCRPVXKVI7
 WL6aUc6g2g5qRceAdtEofTIWv//xbPmnUOuM3ofBQv84q9AH4KKJ5Qbht8llph9BY4TT
 2n7wWoVz9Q0aAUf+fePSyn16kz9JauCvWAYX9EzQnIIuAnOkGRcINEsq/aj61gmTkmFn
 HKXoHgoeQSIhHcfiJaqz4fLIE2z+ci4xTCC6juDOtPUBUGmVHbEDwYQguuYhGQqZuVIi
 UL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764012509; x=1764617309;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rk5uReHwUkzKffnWrtraqagn7ItiMQqJ4fUaMlyphiw=;
 b=C2Pspp6MytUXuP2kdCu45jskpXUdNgBDJhKaJOR7LG1yo4JLsxDuJCYBUTYZRS3rOA
 r6M8w/9nXjs2St4CGS55MywZTXa1FtzjkOZkIhPNYlTdNktkwgna1+M6DQfCB4y41nGE
 kyovfFRQuJsWOAt9u2g3240dc5xIWQWs9abMSXsgfXBrFkrjgll9bhIjYubUBd866VN8
 Hf8DlMFH9i4NdMTKwBKX2s62KlL3nr972Ct93a9CvH/UvYUoDA5vbnNK8rTK7x1H2x0P
 aXwU/lO074cjPuaJr09w5OeCCzcUXWyu3UdkpJUtET/4HI2MzDxcQIxyBsrNZ0UCuUvQ
 RLDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDKrM6aMx4U5b9hkrhv8ya+GJ9ViKrctwTRB62mN1F2Xx5YlOzEeSaZbJ3HA1XG0ZEZ9og5YAsFoEd@nongnu.org
X-Gm-Message-State: AOJu0YzDwQTz+0Vxr1LMhz4BUIiyqshgVgvD8tmmWAyp7AHpaeeiTJn6
 4SadQKQhxdpyTHY9PR6VYNp8RE29eQIJ6VlxnH+jeJf0BDiD5w0P1OocVSs2OU1pFMoVc+JBmJj
 pqKsiyF/BHJ0zOba4QyzNfFuj2I/Gh1MYEKb7NvCX7V3Fe3INmL8MckPl
X-Gm-Gg: ASbGnctAZ8/Lvw5zHf666muBQPT0rDWJIewFpUQHmtorf0Pams4oZ+VFxXhFXiM+XEN
 GPlmM4EDsMQpxyeo9kuk7dICRjzBZUlVEqadd2KS7mWbLAj3JzCmIXkUdY8WAta7Q0nF7CyY087
 ntQL52RapVzB8lh9SEbaYiaOVIopxZlAzPQ/f6sG60bFrrZZuZv+4SiT1PgjtsaaqLgOfeZcw80
 /bd+jYE8i3Csy3Wvdyb2GIRQ5kHcFDu/3Wwu/gJMAFM8S0mpib7/ApBkyOJNZUzXasrQX2EGv18
 2KNYBM7BPX2e3UHijavZf+/y5ZpQfGhB3cglDVgxCLuhkQGmF7+nY3SggI1hk+rPb3YCwnaHz/c
 jUd0=
X-Received: by 2002:ad4:5ecd:0:b0:87b:b773:fcb5 with SMTP id
 6a1803df08f44-8847c4c7c93mr166279566d6.16.1764012509485; 
 Mon, 24 Nov 2025 11:28:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5Ic6DzAPvAwyZUqmzJ5+rnBCaJIxb4TLWKRdcqT/+m6RJvxRPaZx1amVdoHKDnV8yrpAc/g==
X-Received: by 2002:ad4:5ecd:0:b0:87b:b773:fcb5 with SMTP id
 6a1803df08f44-8847c4c7c93mr166279166d6.16.1764012508938; 
 Mon, 24 Nov 2025 11:28:28 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e59ee34sm106967046d6.54.2025.11.24.11.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 11:28:28 -0800 (PST)
Date: Mon, 24 Nov 2025 14:28:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: Zhang Chen <zhangckid@gmail.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "zhanghailiang@xfusion.com" <zhanghailiang@xfusion.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] migration: Fix transition to COLO state from precopy
Message-ID: <aSSx28slqi1ywg2v@x1.local>
References: <20251104013606.1937764-1-lizhijian@fujitsu.com>
 <aQu6bDAA7hnIPg-y@x1.local>
 <b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.com>
 <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
 <20251124093857.1fa22ded@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251124093857.1fa22ded@penguin>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

On Mon, Nov 24, 2025 at 09:38:57AM +0100, Lukas Straub wrote:
> On Thu, 6 Nov 2025 11:21:56 +0800
> Zhang Chen <zhangckid@gmail.com> wrote:
> 
> > On Thu, Nov 6, 2025 at 9:10 AM Zhijian Li (Fujitsu)
> > <lizhijian@fujitsu.com> wrote:
> > >
> > >
> > >
> > > On 06/11/2025 04:58, Peter Xu wrote:  
> > > > On Tue, Nov 04, 2025 at 09:36:06AM +0800, Li Zhijian wrote:  
> > > >> Commit 4881411136 ("migration: Always set DEVICE state") set a new DEVICE
> > > >> state before completed during migration, which broke the original transition
> > > >> to COLO. The migration flow for precopy has changed to:
> > > >> active -> pre-switchover -> device -> completed.
> > > >>
> > > >> This patch updates the transition state to ensure that the Pre-COLO
> > > >> state corresponds to DEVICE state correctly.
> > > >>
> > > >> Fixes: 4881411136 ("migration: Always set DEVICE state")
> > > >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > > >> ---
> > > >> [...]
> > > >
> > > > Thanks a lot for fixing it, Zhijian.  It means I broke COLO already for
> > > > 10.0/10.1..
> > > >
> > > > Hailiang/Chen, do you still know anyone who is using COLO, especially in
> > > > enterprise?  I don't expect any individual using it.. It definitely
> > > > complicates migration logics all over the places.  Fabiano and I discussed
> > > > a few times on removing legacy code and COLO was always in the list.
> > > >
> > > > We used to discuss RDMA obsoletion too, that's when Huawei developers at
> > > > least tried to re-implement the whole RDMA using rsocket, that didn't land
> > > > only because of a perf regression.  Meanwhile, Zhijian also provided an
> > > > unit test, which we rely on recently to not break RDMA at the minimum.
> > > >
> > > > If we do not have known users, I sincerely want to discuss with you on
> > > > obsoletion and removal of COLO from qemu codebase.  Do you see feasible?
> > > >
> > > > Zhijian, do you have any input here?  
> > >
> > >
> > > If we don't have any known users, I personally have no objection to removing COLO.
> > >
> > >  From my previous understanding, its use cases are rather limited, and the checkpointing overhead is significant.
> > > Moreover, with the continuous development of Cloud Native over the past decade, service-based
> > > FT/HA solutions have become very mature, which shrinks the use cases for VM-based FT solutions even further.
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
> > [...]
> 
> Hello Everyone,
> 
> Thanks for bringing this to my attention.
> 
> I will write a migration unit-test and take maintainership of the colo
> components.

Thanks.  It'll be great to also double check colo docs (e.g. COLO-FT.txt)
is still the latest.  Another bonus if you could rewrite some into .rst and
put it under docs/devel/migration/ if that makes sense to you.

> 
> Peter, what is your plan with refactoring the migration code and where
> is the colo code blocking you?

No real blocker yet, it was a problem of extra complexity, and nobody that
I was aware of is using COLO in production or even experimental environment
before I know you're using it.  I'm actually curious what's the use case in
your setup, feel free to share more if possible.  I'd love to learn about it.

If you plan to maintain COLO, please feel free to review this series:

https://lore.kernel.org/r/20251022192612.2737648-1-peterx@redhat.com

> 
> I have quite a few cleanup patches lying around. Are you open to take
> these in advance before the next merge window opens?

Normally cleanup patches do not qualify into -rc category, but you can send
it out first and we can discuss in the thread on the target merge window.

Thanks,

-- 
Peter Xu


