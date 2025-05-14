Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A8EC3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFZL-0005FL-0s; Wed, 14 May 2025 13:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFFYx-0003Sg-Pj
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFFYv-0007uo-QE
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747242393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHNSNpFZB1uDYuYk8HfJiD+fOf1uFZNIYlJqMQJjafo=;
 b=G0D7N5206F+8bPK5OAhd25CBm8rRicR5oE7Cnz7BWt9ZPf/rGjPRdK0BcFRLWeL/81ikC1
 5G0yNIivjkWgACmZGLmMhZP80qWSjHF2LK517GQqRPFwiDeqDgutTYG32O4ZOzGATW0Gh9
 /henW8Mkzc6FbzFmq4sKzXIJ6nfwaMY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-io1dYanJPp-0CM6En4JCog-1; Wed, 14 May 2025 13:06:31 -0400
X-MC-Unique: io1dYanJPp-0CM6En4JCog-1
X-Mimecast-MFC-AGG-ID: io1dYanJPp-0CM6En4JCog_1747242391
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c791987cf6so1396088085a.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 10:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747242391; x=1747847191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHNSNpFZB1uDYuYk8HfJiD+fOf1uFZNIYlJqMQJjafo=;
 b=YuqLu7m0mYg3lGzYNO9/uZ6eXFUJ7HSsGRsjzhZdOEupfQJiVzJHhaPllMtM2iXWvb
 z2Kf/r0+fEwMZ4Te0f210cwfAlYo2Ff/7bylP15JNhmCoSmnWE/Iv54jMs4PMf4DAcGI
 skP14Hg0kY9Ebb671TUohddLtt2paznS9aB86MAN+jHKiV3OcDDJQuJSlFK+gbWqNitX
 KL2krxczrZW3/2RO9QbRF4Erie0TVt5wb3ToOO+zoPi821+RFvMTYZwBQ1h7PbeYL0tJ
 d+RM/FksNICm9DRbifE87m4M2CA0UsT7YJ57JU1Io73++nQnMJeaNhOO4b7Emq+G/03m
 Z9yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfBkEbl/wf5R2jiUJnPlJLXafgHUl7hfKa1kiIZQAYWcu7fLGpB+PFpeBhMEIsL/av3//8j2RgQYTj@nongnu.org
X-Gm-Message-State: AOJu0YwDxBuog5NggiqPPQX0dJa5K0KWRw64CojyvffXJFJFFgnj2/MC
 ySp/K53xIT6VPttz/g2LCxroRvTcZEc4OTJe35VKAe5/Oa8ePy2VQMBv1qV1g/42EQxG4mOFBiY
 Tow1kgRUjsiEB1M4TUKwGUlw7ZWSoqcVaqSx2Cde+PyFDDHEKMwNt
X-Gm-Gg: ASbGncuU3fdv8YaLdiPNQxNST/m7hev2THBETh/ySnsNzMToY0kHsrYZFI3n2PT/F2Q
 EUPjTqJeE3yIvfxq9l0CF5hQkRL1gsGH1Q/vXzugcS6hnsIbbr3lk228c6K40aOj9nzhaoiMORS
 7dZ4qJK+osaYfHt7RbdZKlN1A74IuX0LQp684GGOdZVObbvmvO7XdndAUhkTi/c11dvXQ+BxeNc
 pf7QG/MbMgX8dMrKmqBdPCqU+yW3w/kSUuLOVL8PFNHYwsL/rZfgt+XS/ZvZWjuHQkmaUYfrPKI
 hz8=
X-Received: by 2002:a05:620a:198d:b0:7ca:cd16:8fcc with SMTP id
 af79cd13be357-7cd287c497dmr506179585a.2.1747242391254; 
 Wed, 14 May 2025 10:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8s0QrijsfAb609mqG/dAYm7f4TUZrLJO7WCOC25C8moeSyHFeACwNgAoi0ol5i1Wp21/jxA==
X-Received: by 2002:a05:620a:198d:b0:7ca:cd16:8fcc with SMTP id
 af79cd13be357-7cd287c497dmr506174685a.2.1747242390793; 
 Wed, 14 May 2025 10:06:30 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00f6384asm874051785a.39.2025.05.14.10.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 10:06:30 -0700 (PDT)
Date: Wed, 14 May 2025 13:06:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 01/10] futex: Check value after qemu_futex_wait()
Message-ID: <aCTNkxN9HMJ5FvR-@x1.local>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-1-f7f69247d303@daynix.com>
 <aCNZk73GuEaU-gcK@x1.local>
 <b1b6574c-1ddb-4129-8a68-fe88f93caecd@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1b6574c-1ddb-4129-8a68-fe88f93caecd@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 14, 2025 at 04:34:33PM +0900, Akihiko Odaki wrote:
> On 2025/05/13 23:39, 'Peter Xu' via devel wrote:
> > On Sun, May 11, 2025 at 03:08:18PM +0900, Akihiko Odaki wrote:
> > > futex(2) - Linux manual page
> > > https://man7.org/linux/man-pages/man2/futex.2.html
> > > > Note that a wake-up can also be caused by common futex usage patterns
> > > > in unrelated code that happened to have previously used the futex
> > > > word's memory location (e.g., typical futex-based implementations of
> > > > Pthreads mutexes can cause this under some conditions).  Therefore,
> > > > callers should always conservatively assume that a return value of 0
> > > > can mean a spurious wake-up, and use the futex word's value (i.e.,
> > > > the user-space synchronization scheme) to decide whether to continue
> > > > to block or not.
> > 
> > I'm just curious - do you know when this will happen?
> > 
> > AFAIU, QEMU uses futex always on private mappings, internally futex does
> > use (mm, HVA) tuple to index a futex, afaict.  Hence, I don't see how it
> > can get spurious wakeups..  And _if_ it happens, since mm pointer can't
> > change it must mean the HVA of the futex word is reused, it sounds like an
> > UAF user bug to me instead.

[1]

> > 
> > I checked the man-pages git repo, this line was introduced in:
> > 
> > https://github.com/mkerrisk/man-pages/commit/4b35dc5dabcf356ce6dcb1f949f7b00e76c7587d
> > 
> > I also didn't see details yet in commit message on why that paragraph was
> > added.
> > 
> > And..
> > 
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   include/qemu/futex.h              |  9 +++++++++
> > >   tests/unit/test-aio-multithread.c |  4 +++-
> > >   util/qemu-thread-posix.c          | 28 ++++++++++++++++------------
> > >   3 files changed, 28 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/include/qemu/futex.h b/include/qemu/futex.h
> > > index 91ae88966e12..f57774005330 100644
> > > --- a/include/qemu/futex.h
> > > +++ b/include/qemu/futex.h
> > > @@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)
> > >       qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
> > >   }
> > > +/*
> > > + * Note that a wake-up can also be caused by common futex usage patterns in
> > > + * unrelated code that happened to have previously used the futex word's
> > > + * memory location (e.g., typical futex-based implementations of Pthreads
> > > + * mutexes can cause this under some conditions).  Therefore, callers should
> > 
> > .. another thing that was unclear to me is, here it's mentioning "typical
> > futex-based implementations of pthreads mutexes..", but here
> > qemu_futex_wait() is using raw futex without any pthread impl.  Does it
> > also mean that this may not be applicable to whatever might cause a
> > spurious wakeup?
> 
> No. The man-page mentions "unrelated code that happened to have previously
> used the futex word's memory location", so it doesn't matter whether we use
> pthread here.
> 
> libpthread and even this QemuEvent follows the "common futex usage" so we
> should do what is written in the man page.
> 
> Unfortunately the man page does not describe the "common futex usage
> pattern". It looks like as follows:
> 
> Assume there are two threads, one atomic variable, and one futex.
> 
> Thread A does the following:
> A1. Read the atomic variable.
> A2. Go A5 if the atomic variable is zero.
> A3. Wait using the futex.
> A4. Go A1.
> A5. Free the atomic variable and the futex.
> 
> Thread B does the following:
> B1. Set the atomic variable to zero.
> B2. Wake up using the futex.
> 
> In this example, the execution may happen in the following order:
> B1 -> A1 -> A2 -> A5 -> B2
> 
> Here, B2 will cause a spurious wake up of QemuEvent if the freed memory gets
> reused for QemuEvent.

This is true.

Said that, if to follow my previous statement at [1] above, here I think A5
is the UAF bug I mentioned, trying to free the lock object with existing
user (Thread B) accessing the object.

IMHO, the userapp should make sure the object will never be freed if
there's any possible user of it, and that includes a waker like Thread B.

For futex, the futex word (which is the important bit here relevant to
possible spurious wakeups) is part of the lock object, hence if the lock
object isn't freed too early it won't ever get reused, and then there
should have no chance of spurious wakeups in the futex context.

Thanks,

-- 
Peter Xu


