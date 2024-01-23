Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6543C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 17:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSKRM-0002zD-SK; Tue, 23 Jan 2024 12:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rSKRK-0002yZ-3Z
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rSKRG-000399-Ee
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706030392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u7hvPek1raSD7sO49CsvivAir8mmbU4BfW3hsGgkRWg=;
 b=MALUOAiBZXDBUhHSvdRbRDsyPl2sY+8KnaeoomIJW70yEsJL5REhMqmsK1k2e8WQsCOVj2
 q1tp/dvlJFeNheqfNBzm5BhG63agr3DpiROp/SSv5tt8HNuJhyoPY63fdsuzBLHLqgmRzp
 nbl5NLWoZoejbgC7gaRgRd7ZmoN42IA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-_TyjZprAMWeboh-NKK6P5A-1; Tue, 23 Jan 2024 12:19:45 -0500
X-MC-Unique: _TyjZprAMWeboh-NKK6P5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D382588D068;
 Tue, 23 Jan 2024 17:19:31 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E44B240C106C;
 Tue, 23 Jan 2024 17:19:30 +0000 (UTC)
Date: Tue, 23 Jan 2024 18:19:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Manolo de Medici <manolodemedici@gmail.com>, qemu-devel@nongnu.org,
 bug-hurd@gnu.org, Qemu-block <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 2/4] Avoid conflicting types for 'copy_file_range'
Message-ID: <Za_1ISw879Aw5bFj@redhat.com>
References: <CAHP40mnyxgmwY39jKMHsZCrCXdozNwFO+RDTYMPUhfkGu_pfFQ@mail.gmail.com>
 <CAFEAcA-9LS2hP=Ju6K_wWdhFWVrwhYinSaq6P0s5xmcE6pDtKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-9LS2hP=Ju6K_wWdhFWVrwhYinSaq6P0s5xmcE6pDtKw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 22.01.2024 um 18:04 hat Peter Maydell geschrieben:
> (Cc'ing the block folks)
> 
> On Thu, 18 Jan 2024 at 16:03, Manolo de Medici <manolodemedici@gmail.com> wrote:
> >
> > Compilation fails on systems where copy_file_range is already defined as a
> > stub.
> 
> What do you mean by "stub" here ? If the system headers define
> a prototype for the function, I would have expected the
> meson check to set HAVE_COPY_FILE_RANGE, and then this
> function doesn't get defined at all. That is, the prototype
> mismatch shouldn't matter because if the prototype exists we
> use the libc function, and if it doesn't then we use our version.
> 
> > The prototype of copy_file_range in glibc returns an ssize_t, not an off_t.
> >
> > The function currently only exists on linux and freebsd, and in both cases
> > the return type is ssize_t
> >
> > Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> > ---
> >  block/file-posix.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 35684f7e21..f744b35642 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -2000,12 +2000,13 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
> >  }
> >
> >  #ifndef HAVE_COPY_FILE_RANGE
> > -static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> > -                             off_t *out_off, size_t len, unsigned int flags)
> > +ssize_t copy_file_range (int infd, off_t *pinoff,
> > +                         int outfd, off_t *poutoff,
> > +                         size_t length, unsigned int flags)
> 
> No space after "copy_file_range". No need to rename all the
> arguments either.
> 
> >  {
> >  #ifdef __NR_copy_file_range
> > -    return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
> > -                   out_off, len, flags);
> > +    return (ssize_t)syscall(__NR_copy_file_range, infd, pinoff, outfd,
> > +                            poutoff, length, flags);
> 
> Don't need a cast here, because returning the value will
> automatically cast it to the right thing.
> 
> >  #else
> >      errno = ENOSYS;
> >      return -1;
> 
> These changes aren't wrong, but as noted above I'm surprised that
> the Hurd gets into this code at all.

Yes, I think we didn't expect that HAVE_COPY_FILE_RANGE would not be
defined in some cases even if copy_file_range() exists in the libc.

> Note for Kevin: shouldn't this direct use of syscall() have
> some sort of OS-specific guard on it? There's nothing that
> says that a non-Linux host OS has to have the same set of
> arguments to an __NR_copy_file_range syscall. If this
> fallback is a Linux-ism we should guard it appropriately.

Yes, I think this should be #if defined(__linux__) &&
defined(__NR_copy_file_range).

> For that matter, at what point can we just remove the fallback
> entirely? copy_file_range() went into Linux in 4.5, apparently,
> which is now nearly 8 years old. Maybe all our supported
> hosts now have a new enough kernel and we can drop this
> somewhat ugly syscall() wrapper...

The kernel doesn't really matter here, but the libc. Apparently
copy_file_range() was added in glibc 2.27 in 2018. If we want to remove
the wrapper, we'd have to check if all currently supported distributions
have a new enough glibc.

Kevin


