Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B56CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2H5-0002f3-Ay; Mon, 17 Nov 2025 11:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL2GX-0002Zj-5Q
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL2GU-0000ST-C5
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763397580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F+d8j+QZZaV9H08GO9/dgbRS42LH0lP+1m6sGsNTgNE=;
 b=ZfTtTniC6lljlM8G7z0dFflsXebV2ynLBvCgvL4oHWumw5kTj/MxotZCp/owomjNImbgCi
 GKtsiLnzLfF+pF9GhOLptnHksLGCdPNUEhrqx310bqdsdp/l8UDtKF8wFpQK6ZqJO7XpPK
 P39XAbYltYjTJtYmdDrKAIVawIAMV3k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-LhrcEGJaONqg85UA8A_Hsw-1; Mon, 17 Nov 2025 11:39:39 -0500
X-MC-Unique: LhrcEGJaONqg85UA8A_Hsw-1
X-Mimecast-MFC-AGG-ID: LhrcEGJaONqg85UA8A_Hsw_1763397578
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8804823b757so170138816d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763397578; x=1764002378; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F+d8j+QZZaV9H08GO9/dgbRS42LH0lP+1m6sGsNTgNE=;
 b=XZroGYPktsYGDSjTyanDLUUibokWilgP5sZDOseJUmK5zUNRDYOUKrXeP/EGh2HKS7
 uol6cmnYtucLJ8+YmRMUH91Td7hqqYYOSkij/52+xz8V/ZAijayi+5dS9B8sTfx4MZfc
 ZHsEZJlycNZrFYOYPFF2v6DlKu79h+OhzNmfU4/wgENgNPqA2vXJ/9S7c1zj96udOT3N
 mcqIqzrfRUYW/TshPdLVRl5JPEj/qgTGtUDO/t5nlvsEkcWsV0Nh3RIYhpy+YpiOdwco
 vozTf0XufudUnV3zscpfwF/CfaPYAfDGxDoCfsoZK6e8B0sWtL5T6DIMrhunsj9/YKIc
 ulow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763397578; x=1764002378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+d8j+QZZaV9H08GO9/dgbRS42LH0lP+1m6sGsNTgNE=;
 b=GhvSP5hOzg0Ehb605Z0EM1SouefWWOVwSTEZZ1hhZJZjymYyfrxu72AGEtE52cyoxv
 fUYMzH+erHZXcIEFriCSs4GLBGj/+/CSKFZpTfodelkbSky37nt8Rc0U2ej+Gcys2Dhg
 +Kedenwi2SNNFCoo1OY3to893m1a1dtOvYSkfiML8jDAGP/Hbe3EzwyGdR6pYXd67guh
 0tsAMtrgRxgx2yp6za7/z4UfEmcfHzpAPIsMuwsVUQE397TYljvc/Ob7dVtq9JYfQDlN
 WVZ76rxVW7sAQHN/JHOigAF7w+Zp2wjQm3HfButdmPQAHeJnzuFrInmG0uGYyQaufejU
 B6IQ==
X-Gm-Message-State: AOJu0Yw3Gk6AZMMDYGcq4VhCF7hMvSvk8H66EPf/VVsMd9ddRPQgHUof
 2uICENPUl03bOclNHOXFrmZNsaZWzDHRrlejlAuV253gKsHpGDEIwLv9lwG/efHa6fNDoIq6a1p
 6JKFq6qU6TN+WA9qzK0puPhcCnpFo0ampTTrO1kOs1peb2hppvuxDGXCY
X-Gm-Gg: ASbGncvDdhb0CRAGbO/kePqzUMpxkDBQMr9LxYSjHadA6HYO1450LKnLjycifUqZfut
 IymUrkmgtFHEB2jHhtjodQzByD/GCep12AnXQLp3QPLQacH0ZPnt4Jqgu+5UNzNJTm5o470+Lbn
 hYmJntxKKLtlLLj6Ced3tWQfnMvC8x5jVJJ2PrKVvKTTygsMcR3Oow9Sc+mPQJHFicMOkWpcsni
 dCowP33BpJjqX/vSekZSXPuh9Ef1fYtTbN36QzJvdDyG6T4wQ2iY4RaOEtlaSA8VKpdDhUUvjTA
 nl/BuFfde4HnaLc+pozOthwtVxE61LL+SyZ0Ip8UUXsyK4MTtjI/by5WhuS6OcLC/+T0tHT832j
 0fw==
X-Received: by 2002:ad4:5f06:0:b0:880:5249:be4b with SMTP id
 6a1803df08f44-88290e3f067mr187468856d6.12.1763397578384; 
 Mon, 17 Nov 2025 08:39:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFogpbKV2bT5OoKLMehYL0xI95V9BSdITocXCSjto3tFQHX2GPrCOueuowA+Tof4ILjLn6SQA==
X-Received: by 2002:ad4:5f06:0:b0:880:5249:be4b with SMTP id
 6a1803df08f44-88290e3f067mr187468116d6.12.1763397577803; 
 Mon, 17 Nov 2025 08:39:37 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8828655e55bsm94838736d6.43.2025.11.17.08.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 08:39:37 -0800 (PST)
Date: Mon, 17 Nov 2025 11:39:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
Message-ID: <aRtPxYIgf55p7e5O@x1.local>
References: <aQu2_izqViAbJ3A9@x1.local>
 <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
 <aQ0Ys09WtlSPoapm@x1.local>
 <5279f15f-bf46-438e-9c1f-0873b08b59e7@rsg.ci.i.u-tokyo.ac.jp>
 <aQ37hd0fVJltYtt-@x1.local>
 <5002e5b4-0493-4dff-af11-402cebecbcc2@rsg.ci.i.u-tokyo.ac.jp>
 <aRYPXh_9m5ZvTi2w@x1.local>
 <ded7ef38-8c99-4d37-87b2-2f5ba1dc93fc@rsg.ci.i.u-tokyo.ac.jp>
 <aRdLFwxzJwjsXFpY@x1.local>
 <a8c03d1e-a3f4-40de-a633-7b15ec2288e3@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8c03d1e-a3f4-40de-a633-7b15ec2288e3@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sat, Nov 15, 2025 at 10:58:11AM +0900, Akihiko Odaki wrote:
> On 2025/11/15 0:30, Peter Xu wrote:
> > On Fri, Nov 14, 2025 at 10:24:40AM +0900, Akihiko Odaki wrote:
> > > However it creates another problem. Think of the following sequence:
> > > 
> > > call_rcu_thread()              |
> > >                                 | call_rcu1()
> > >                                 |  qatomic_fetch_inc(&rcu_call_count)
> > >                                 |  qemu_sem_post(&sync_event)
> > >                                 |
> > >   qatomic_read(&rcu_call_count) |
> > >   enter_qs(false)               |
> > >    wait_for_readers(false)      |
> > >     qemu_sem_timedwait(         |
> > >      &sync_event, 10)           |
> > > 
> > > qemu_sem_timedwait() incorrectly interrupts the RCU thread and enters the
> > > force quiescent state.
> > 
> > First thing to mention is, IIUC above can't happen because if
> > call_rcu_thread() is already waked up and reaching enter_qs(), then there
> > should have been, for example, a prior call_rcu1() that incremented
> > rcu_call_count and posted to sync_event, hence rcu_call_count cannot be 0
> > anymore in the call_rcu1() above, because the sub happens later:
> > 
> > call_rcu_thread:
> >          ... sees rcu_call_count > 0, quit loop ...
> >          ...
> >          enter_qs(sleep);
> >          qatomic_sub(&rcu_call_count, n); <-------------------------
> >          ...
> > 
> > That means the concurrent call_rcu1() above will not post sem anymore
> > because it will only post it if rcu_call_count==0.
> Below is an extended version of the sequence:
> 
> call_rcu_thread()                |
>  qatomic_sub(&rcu_call_count, n) |
>  (sets rcu_call_count to 0)      |
>                                  | call_rcu1()
>                                  |  qatomic_fetch_inc(&rcu_call_count)
>                                  |  qemu_sem_post(&sync_event)
>  qatomic_read(&rcu_call_count)   |
>  enter_qs(false)                 |
>   wait_for_readers(false)        |
>   qemu_sem_timedwait(            |
>    &sync_event, 10)              |
> 
> Note that there may not be a qemu_sem_wait(&sync_event) call between
> qatomic_sub(&rcu_call_count, n) and qatomic_read(&rcu_call_count).

Yes, with a semaphore this may happen.

It may also happen that the sem keeps accumulating like this (for example,
wait_for_readers() may always see a lot of callbacks registered that is
more than RCU_CALL_MIN_SIZE), so it can be even more than 2.  Then when the
RCU callback storm finishes, call_rcu_thread() may see that >2 sem counter
and loop over in reading rcu_call_count a few times seeing zeros.

I think it's fine because rcu thread only runs slightly faster on recycling
in extreme rare cases like this, or a few more loops also only in extreme
corner cases (as I mentioned before, I was trying to ask whether high
frequency RCU free matters to us, that's why I was trying to count it in a
VM lifespan).  Hence IMHO it's not an error either, but a benign false
positive.

> 
> > 
> > Besides, IMHO replacing the event with sem shouldn't change similar
> > behavior comparing to when using events.  Because any spot that can post()
> > concurrently can also does qemu_event_set() concurrently... after all, we
> > only have a few spots resettting the event in the original patch, after the
> > reset a concurrent qemu_event_set() will re-activate it.
> 
> The sequence I showed is handled properly with properly placed
> qemu_event_reset():
> 
> call_rcu_thread()                |
>  qatomic_sub(&rcu_call_count, n) |
>  (sets rcu_call_count to 0)      |
>                                  | call_rcu1()
>                                  |  qatomic_fetch_inc(&rcu_call_count)
>                                  |  qemu_event_set(&sync_event)
>  qatomic_read(&rcu_call_count)   |
>  qemu_event_reset(&sync_event)   |
>  enter_qs(false)                 |
>   wait_for_readers(false)        |
>    qemu_sem_timedwait(           |
>     &sync_event, 10)             |
> 
> Note that a concurrent qemu_event_set() after resetting the event can only
> triggered with force_rcu(), which is intended to interrupt
> wait_for_readers().

I see your point here.  I agree I can't think of any way to trigger false
positives like when sem is used.

> 
> > 
> > Sem does introduce possible false positives on events, but as I was trying
> > to justify, a generic VM boots and shutdown should need less than 1000 rcu
> > calls, so worst case is we loop read rcu_call_count 1000 times... I also
> > didn't measure how many of such call_rcu1() will see N>0 so they'll not
> > post() to sem at all, I believe it'll be common.  So the perf overhead
> > should really be rare, IMHO.
> > 
> > Note that I was not requesting you to replace this event to sem before
> > merging.  Frankly, I think your work is good enough to land.
> > 
> > However I still want to discuss a sem replacement, not only because this is
> > the best place to discuss it (after all, force rcu starts to introduce a
> > genuine second user of the event besides call_rcu1, hence the "being able
> > to remember more than 1" will start to make more sense than avoid resets),
> > it looks also cleaner to remove some new code force rcu adds.
> 
> How do "being able to remember more than 1" help?

It helps to avoid resets and make the code easier to follow.

The current rcu code, especially after your series lands, will have quite
some (1) more deliberate event reset needed, and (2) ordering constraints
between any of: event waits, event resets, reading "force" var, reading
"rcu_call_count" var, etc.  These things need very careful attention,
missing or making it wrong any spot may introduce hard to debug functional
issues.

The sem proposal was almost about trying to remove almost all of those
complexities.

But I agree the drawback is sem may introduce false positives like above,
so at least it's not an ideal proposal.  It's just that as mentioned it
should be all safe and fine IMHO, unless we care about high freq rcu frees.
As I said, I don't have a strong opinion. I'll leave that to you to decide.

Thanks,

-- 
Peter Xu


