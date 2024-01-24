Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9C1C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 17:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rShGV-00062c-TI; Wed, 24 Jan 2024 12:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rShGT-00062C-6N
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:42:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rShGQ-0002th-3j
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706118132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PPPCzX1tBZhG4bbQ6tGxzGwPiv3gl9MKYE5SKMxd9ro=;
 b=aY9e0FSSCeBVGY7MFrO9sdk5udFOuIWMC5r7VwhD/apO7Yv8u3o9GRKUY6661Q811IYCHB
 uiyXK7RkNitBIJKhaYJifx92yauNkRb9Sh/DWDuD+1kSurVyuXZSSsURpklGcokI9N3D9J
 k81iDazoFBJCx0zGSbmQsDMzesnPbCw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-nv2FeF9nOlW8NSUvFufVDw-1; Wed, 24 Jan 2024 12:42:08 -0500
X-MC-Unique: nv2FeF9nOlW8NSUvFufVDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63DB4862DC2;
 Wed, 24 Jan 2024 17:42:08 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6126D40C1430;
 Wed, 24 Jan 2024 17:42:07 +0000 (UTC)
Date: Wed, 24 Jan 2024 11:42:05 -0600
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Manolo de Medici <manolodemedici@gmail.com>, qemu-devel@nongnu.org, 
 bug-hurd@gnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: Re: [PATCH v2 1/4] Include new arbitrary limits if not already
 defined
Message-ID: <4tcv34s5agqik667co4zfknnrajrb6vx6rj6gw32pwydrnd2xp@xcq7nb37f5cq>
References: <CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv4yyOPBxVTW+OQ@mail.gmail.com>
 <CAFEAcA_BAz3SyqHLkU6YKedHvZTVUNsjy2tkxWJTBd9JZNgtnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_BAz3SyqHLkU6YKedHvZTVUNsjy2tkxWJTBd9JZNgtnA@mail.gmail.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 22, 2024 at 05:19:19PM +0000, Peter Maydell wrote:
> On Thu, 18 Jan 2024 at 16:03, Manolo de Medici <manolodemedici@gmail.com> wrote:
> >
> > qemu uses the PATH_MAX and IOV_MAX constants extensively
> > in the code. Define these constants to sensible values ourselves
> > if the system doesn't define them already.
> >
> > Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> > ---
> >  include/qemu/osdep.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 9a405bed89..9fb6ac5c64 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -363,6 +363,14 @@ void QEMU_ERROR("code path is reachable")
> >  #define TIME_MAX TYPE_MAXIMUM(time_t)
> >  #endif
> >
> > +#ifndef PATH_MAX
> > +#define PATH_MAX 1024
> > +#endif

POSIX requires that _XOPEN_PATH_MAX be defined as 1024, as a bare
minimum for any system implementing X/Open extensions to POSIX, so
this number is reasonable.  It is also small enough that most of our
uses where PATH_MAX is used for stack allocation (rather than heap
allocation) don't explode.  But the /reason/ that GNU Hurd refuses to
define PATH_MAX is /because/ it is an arbitrary limit, and GNU Hurd
goes out of its way to not impose such a small limit on the user.  The
intent is that portable code should be written to malloc() any path
operation in order to deal with ANY size file name thrown at the code,
rather than stack-allocate and risk truncation when the limits chosen
were too small for the user's desires.

I'm not opposed to this patch with a stronger commit message, but the
commit message would do well to show that an attempt was made to audit
all existing uses of PATH_MAX and why we still need them rather than
malloc()ing.  A stronger patch would be one that eliminates the use of
PATH_MAX from the code base, on the grounds that truly portable code
can handle all pathnames that the underlying system already has memory
on hand to throw at the program; note that I am /not/ insisting on
such a stronger code guarantee, but merely that we document our design
decision of why we are unable/unwilling to go that far if the stronger
guarantee turns out to be impractical.

> > +
> > +#ifndef IOV_MAX
> > +#define IOV_MAX 1024
> > +#endif

Here, POSIX only requires _XOPEN_IOV_MAX to be 16 (if you're going to
do sharded scatter-gather I/O, portable code has to cater to systems
that do not tolerate you trying to cram more than 16 shards into one
syscall).  Older Solaris actually had a limit this low, but I can
easily test that Linux has a limit of 1024, and a Google search seems
to concur that the various BSDs have also settled on 1024.  GNU Hurd
obviously supports more than 1024, but capping at this number is
reasonable.  Unlike eradicating PATH_MAX from the code base, this is
one that makes more sense to me to have in place; although it would
still be worth documenting that all known systems that qemu targets
(including GNU Hurd, if your intent is to make that such a system)
support 1024 rather than the smaller minimum of 16 that POSIX
mandates.

> > +
> >  /* Mac OSX has a <stdint.h> bug that incorrectly defines SIZE_MAX with
> >   * the wrong type. Our replacement isn't usable in preprocessor
> >   * expressions, but it is sufficient for our needs. */
> 
> Ccing some people who know more about portability concerns
> than I do...
> 
> thanks
> -- PMM
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


