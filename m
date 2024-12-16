Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D01DE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 18:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNFvZ-0008HC-Bp; Mon, 16 Dec 2024 13:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNFvY-0008Go-15
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNFvW-0004vZ-7F
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734374081;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oX+PFfVLcwU8lvZn6CnKDr7lsXmRjQomzHtOPNjgCH8=;
 b=RuOmS/qljcfTLv/pEhnUkXMKORhBrArWOdA9zLzXiAHWFSGylAns1EqxbEXgrjImjtkC6Q
 ZgQJh0uOe1pl65jDi6vgro2SClibeZFK8fGOXkWwQJhNGXzi0gxt6q6gOxcnuA+CqmPL39
 26lYz9OdCq36lGYGBBoK79jgH98nNgM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-zg6r2p0pNgaAf8Ism7fi8A-1; Mon,
 16 Dec 2024 13:34:38 -0500
X-MC-Unique: zg6r2p0pNgaAf8Ism7fi8A-1
X-Mimecast-MFC-AGG-ID: zg6r2p0pNgaAf8Ism7fi8A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C53D11956052; Mon, 16 Dec 2024 18:34:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 503A31956086; Mon, 16 Dec 2024 18:34:33 +0000 (UTC)
Date: Mon, 16 Dec 2024 18:34:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 1/3] osdep: Add qemu_mkdir_with_parents()
Message-ID: <Z2BytXujGDCrydhK@redhat.com>
References: <20241216161413.1644171-1-peterx@redhat.com>
 <20241216161413.1644171-2-peterx@redhat.com>
 <CAFEAcA_u++fJudO1ca9q76NYWTg75PRGAEHBqDyjUDEnR5m8Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_u++fJudO1ca9q76NYWTg75PRGAEHBqDyjUDEnR5m8Cw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 16, 2024 at 04:56:33PM +0000, Peter Maydell wrote:
> On Mon, 16 Dec 2024 at 16:14, Peter Xu <peterx@redhat.com> wrote:
> >
> > QEMU uses g_mkdir_with_parents() a lot, especially in the case where the
> > failure case is ignored so an abort is expected when happened.
> >
> > Provide a helper qemu_mkdir_with_parents() to do that, and use it in the
> > two cases in qga/.  To be used in more places later.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qemu/osdep.h     | 7 +++++++
> >  qga/commands-posix-ssh.c | 8 ++------
> >  util/osdep.c             | 6 ++++++
> >  3 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index fdff07fd99..dc67fb2e5e 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -828,6 +828,13 @@ static inline int platform_does_not_support_system(const char *command)
> >  }
> >  #endif /* !HAVE_SYSTEM_FUNCTION */
> >
> > +/**
> > + * qemu_mkdir_with_parents:
> > + *
> > + * Create directories with parents.  Abort on failures.
> > + */
> > +void qemu_mkdir_with_parents(const char *dir, int mode);
> 
> Don't put new function prototypes into osdep.h, please.
> It is included by every single C file in the codebase.
> There is always somewhere better to put things.
> 
> QEMU shouldn't abort on things that are kind of expected
> OS errors like "couldn't create a directory", so I'm
> a bit dubious about this function.
> 
> The two use cases in this commit seem to be test code,
> so asserting is reasonable. But a "for test code only"
> function should go in a header file that's only included
> by test cases and the comment should be clear about that,
> and it shouldn't have a function name that implies
> "this is the normal way any code in QEMU might want
> to create directories".
> 
> For the qtest tests, I currently ignore Coverity
> reports in our test code unless it seems particularly
> worthwhile to fix them. This is especially true for
> complaints about unchecked return values and the like.
> 
> Even in a test case it is still not great to call
> g_assert(), because this makes the test binary crash,
> rather than reporting an error. The surrounding TAP
> protocol parsing code then doesn't report the test
> failure the way you might like.

I also think qemu_mkdir_with_parents is *worse* than the
current code. It saves 1 line in the test file, but hides
the fact that it asserts on failure which is an relevant
observation. If we really want to save that 1 line of code
then just condense it inplace

  g_assert(g_mkdir_with_parents(dir, mode) == 0);


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


