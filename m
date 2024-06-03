Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54867C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9xQ-0005XW-KF; Mon, 03 Jun 2024 11:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sE9xO-0005Wo-Sz
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sE9xM-0004K4-NR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717429842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=amKfyN+EdUOF8URq8NqVNjEfwrN4/RYT0tsHbX3fAq8=;
 b=OF9mCfvZRkw/ZAFBu4zGDVqPloms8XZaki6qrVRP06HLH63IVjeCSxobZYJtpxEg1ZJ6nG
 gLtySKiZOZdC6tajnQZs2wOW+G8Px4Lc3L5FBV0n+IwUjqeqx6oJfIbNtt2b8EjJewRTh3
 ClIkd0KPyeYCmVSUPzNhVe5naHGVcek=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-G_1LOpwhN8SJu_zKtoFztg-1; Mon, 03 Jun 2024 11:50:41 -0400
X-MC-Unique: G_1LOpwhN8SJu_zKtoFztg-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6f8f23f5d67so268573a34.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717429840; x=1718034640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amKfyN+EdUOF8URq8NqVNjEfwrN4/RYT0tsHbX3fAq8=;
 b=v53tcNczt2VVPT/hSDZaBO7ZVjjF1ZUUL9WOOzvZQPEk7tjxKmwJUf+sbhzpXlbNjU
 0/vq7Q9X3Hpj8KIjwruX4Nm/HsOB7CKl88W7MoAQ7EHDYvKTVENiuoIvXjQp8qM8B2AM
 M7ttL2R3sm0SPxVTZ7ywjIhlu5sryiDxIpCoV0RFatcHJzEEKZCGLsTMO3kcj/2J5F9C
 el3KGfUNxzWd0xx4QpnFhfTpFO55f5KyYTZz9N9effcUpVcZ5Ch/qBlP8Muotp01R62Q
 YnTkoDc6sezwqyGufvMPQKv02rAO6H2mM4vPxjFJxBsnWw/Pmje3KtDdF/5wW/hLkPTa
 BI4Q==
X-Gm-Message-State: AOJu0YxHGNVhvGaHNcHGXqJLT++5DTxJnesQsfUTf6Lw5v3nkYUi+9Xv
 Sv6bW4bx9bcymLUuFHxZxhBKPA7w/wCNNkC4q3juHBDajKzAxl5trIbj7t7tI6EPF/uDL/SDaJT
 J/lS18Uu8pVGEzJ1k0ZdbJW5oZ7xoxi5mEORcz8OfcyEtqQBEjz7g
X-Received: by 2002:a05:6830:4604:b0:6f0:6420:35d6 with SMTP id
 46e09a7af769-6f911fb569dmr9844077a34.3.1717429840032; 
 Mon, 03 Jun 2024 08:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC6pybO5TNgXF7z7Dlb2sD2TzNBtfldrA9KgTSesxSOemDZ9o5EbF/Km1Q1d9N8VnyPUZu/w==
X-Received: by 2002:a05:6830:4604:b0:6f0:6420:35d6 with SMTP id
 46e09a7af769-6f911fb569dmr9844053a34.3.1717429839487; 
 Mon, 03 Jun 2024 08:50:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff23a1aacsm40629621cf.12.2024.06.03.08.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 08:50:38 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:50:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/4] tests/qtest/migration-test: Add a postcopy
 memfile test
Message-ID: <Zl3mTAuWPJoiWDK4@x1n>
References: <20240530095408.31608-1-npiggin@gmail.com>
 <20240530095408.31608-5-npiggin@gmail.com> <ZlnRy0PS17qa2aqb@x1n>
 <D1Q5KAF3ISC7.1TF9RGZVFDG7V@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D1Q5KAF3ISC7.1TF9RGZVFDG7V@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 03, 2024 at 04:02:42PM +1000, Nicholas Piggin wrote:
> On Fri May 31, 2024 at 11:34 PM AEST, Peter Xu wrote:
> > On Thu, May 30, 2024 at 07:54:07PM +1000, Nicholas Piggin wrote:
> > > Postcopy requires userfaultfd support, which requires tmpfs if a memory
> > > file is used.
> > > 
> > > This adds back support for /dev/shm memory files, but adds preallocation
> > > to skip environments where that mount is limited in size.
> > > 
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > Thanks for doing this regardless.
> >
> > > ---
> > >  tests/qtest/migration-test.c | 77 ++++++++++++++++++++++++++++++++----
> > >  1 file changed, 69 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > > index 86eace354e..5078033ded 100644
> > > --- a/tests/qtest/migration-test.c
> > > +++ b/tests/qtest/migration-test.c
> > > @@ -11,6 +11,7 @@
> > >   */
> > >  
> > >  #include "qemu/osdep.h"
> > > +#include "qemu/cutils.h"
> > >  
> > >  #include "libqtest.h"
> > >  #include "qapi/qmp/qdict.h"
> > > @@ -553,6 +554,7 @@ typedef struct {
> > >       */
> > >      bool hide_stderr;
> > >      bool use_memfile;
> > > +    bool use_shm_memfile;
> >
> > Nitpick: when having both, it's slightly confusing on the name, e.g. not
> > clear whether use_memfile needs to be set to true too if use_shm_memfile=true.
> >
> > Maybe "use_tmpfs_memfile" and "use_shm_memfile"?
> 
> Could be easy to confuse. It's not actually "tmpfs", it is the fs that
> is mounted on /tmp :) tmpfs *is* shmfs in Linux. The intention was just
> that if you don't specify then it's because you don't have a particular
> requirement other than enough space.

Ah sorry, yeah I meant use_tmp_memfile..

> 
> > >      /* only launch the target process */
> > >      bool only_target;
> > >      /* Use dirty ring if true; dirty logging otherwise */
> > > @@ -739,7 +741,62 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> > >          ignore_stderr = "";
> > >      }
> > >  
> > > -    if (args->use_memfile) {
> > > +    if (!qtest_has_machine(machine_alias)) {
> > > +        g_autofree char *msg = g_strdup_printf("machine %s not supported",
> > > +                                               machine_alias);
> > > +        g_test_skip(msg);
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (args->use_shm_memfile) {
> > > +#if defined(__NR_userfaultfd) && defined(__linux__)
> >
> > IIUC we only need defined(__linux__) as there's nothing to do with uffd yet?
> 
> I thought it was polite since it uses a few other Linux (or at least
> POSIX) calls directly rather than go via the abstraction layer. Probably
> it would never happen that something defines __NR_userfaultfd that does
> not also have open and fallocate, but no harm?

It's about when there're shmem tests added without postcopy, we may want
the host to run these tests even if that host doesn't support userfault
syscall.

$ grep -iE "(SHMEM|USERFAULTFD)=" .config
CONFIG_SHMEM=y
CONFIG_USERFAULTFD=y

So I want to make sure the test runs the right thing always, irrelevant of
which arch it ran on, or kernel config.

I agree that's not a huge deal, but still I wanted to remove the
collreation that userfault and shmem is closely related - they're just
totally irrelevant to me, e.g., we can have shmem test/hostconfig without
userfault, we can also have userfault test/hostconfig without shmem.

> 
> > > +        int fd;
> > > +        uint64_t size;
> > > +
> > > +        if (getenv("GITLAB_CI")) {
> > > +            /*
> > > +             * Gitlab runners are limited to 64MB shm size and despite
> > > +             * pre-allocation there is concern that concurrent tests
> > > +             * could result in nondeterministic failures. Until all shm
> > > +             * usage in all CI tests is found to fail gracefully on
> > > +             * ENOSPC, it is safer to avoid large allocations for now.
> > > +             *
> > > +             * https://lore.kernel.org/qemu-devel/875xuwg4mx.fsf@suse.de/
> > > +             */
> > > +            g_test_skip("shm tests are not supported in Gitlab CI environment");
> > > +            return -1;
> > > +        }
> >
> > I'm not sure whether this is Fabiano's intention.  I'm wondering whether we
> > can drop this and just let it still run there.
> >
> > Other tests not detecting avaiablility of shmem looks like a separate issue
> > to be fixed to me, regardless of this.
> >
> > My wild guess is since we're doing memory_size+64K below then if test won't
> > fail others won't either, as normally the shmem quota should normally be
> > power of 2 anyway.. then it should always fit another few MBs if this one.
> > While this test is ready to fail gracefully now.
> 
> Well if CI runners got upgraded to 256MB shm space under us, we might
> start to succeed? I _think_ fallocate on tmpfs should be relatively

Yep, and IMHO that's also why I think we can start trying this even on
GITLAB_CI if it can support it.

> atomic in that it doesn't try to allocate space if the fs was too small,
> but at least naive implementations can do it too, so I didn't want to
> rely on it.
> 
> I'm fine to do what you and Fabiano prefer. If we commit this then later
> remove this hunk, it would be easy to revert if it started to show up
> fails. OTOH not too hard to add it in later either.

The question is why it can fail even with fallocate() around.  I just don't
see how it can fail besides either succeed or skip.

Maybe I missed something alone the lines.. though.

The other test (e.g. ivshmem) can fail, but those can fail with/without
the change here.  That's also why I think we need to fix them separately,
rather than trying to detect GITLAB_CI only because we know they _might_ be
running concurrently - if all tests have protection over shmem allocation
then IIUC we shouldn't fail anymore, but only success/skip.

I agree this doesn't look good at all, as it's not predictable on what test
will be covered in a CI run.. but again IMHO that's yet another separate
issue on how we can make CI support enough shmem usages.

Thanks,

-- 
Peter Xu


