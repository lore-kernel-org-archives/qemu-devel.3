Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977C4C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCVk-0000fD-Jy; Thu, 20 Mar 2025 05:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tvCVg-0000es-Ge
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:48:20 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tvCVe-0003Q7-DB
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Cc:
 Content-ID:Content-Description;
 bh=SOqY6v7vRCn9U52M1OYzWyNDDWpq2VNX+/KWioaOkEg=; b=TTMC3kTWswXOLo4nMokSktMQYZ
 e3FT6z9kHCStYFkSqlqbmjT0VABYsmXOZ/YOQCJcYKPrzz4BSvd2pvLJ8dqXtg2hfU3JISxB3W3JG
 ovSmi1E5423xTWmKFpRTMAf0LXOQkUwl+9CNcJgu8R813clYg8IcPa99zJBi+M2WWf0mdY/+S1Gzn
 y1s+ETEWRlWgrsWwcoQxu7g1wDKAo0eIn4mXchUZtabOWkAl/THZSKozobsqhxKX2Bl9RUqTSqk7S
 He9SppDsWlsm669+kcoNkyQ0V+ZTG/VUSC8002RrSGsC34YZ74KCW0nnHTJmNy+SiupdJlnxF8I4/
 79yXpKGvHCqUoNdN0NoR/LL5SdkN+9S0OeH9FHDDT/eGsbnfZyWDifqrNqHJS5z3y+Ji9NBzz2HKG
 ry4pdI860oum4l4HbUW/1dSuWZk1GJ3wPjcPNlhle3W5BukLEQE3XxzRbgO8r8ScjpHujiQ4JaTgG
 pnTvLTn17tuU+IClKHmSuj2mbGT+yiGqUwsdRsB7BOHL+6HPJ9CTR7TNRn9mJOutI1BgEGOoP+kBh
 cBPNDJ7GvvV2hZ8Z3SVy1r4OkW6H0owY7sB4IRIulwjpuD5aSbAkpysjXv/IFJlWCD5vX1j1x3cAh
 pTTMPRLIc4kUx2XbQSi9SW9mGDqpC29dg0ytZfFg0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: fix 'total_open_fd' decrementation
Date: Thu, 20 Mar 2025 10:48:11 +0100
Message-ID: <2166032.rzx9qK8laY@silver>
In-Reply-To: <20250319195251.10cd431d@bahia>
References: <E1tuqQb-004R61-AZ@kylie.crudebyte.com> <1820249.RkjqyYWvsj@silver>
 <20250319195251.10cd431d@bahia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wednesday, March 19, 2025 7:52:51 PM CET Greg Kurz wrote:
> On Wed, 19 Mar 2025 13:14:27 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > On Wednesday, March 19, 2025 11:08:58 AM CET Christian Schoenebeck wrote:
> > > According to 'man 2 close' errors returned by close() should only be used
> > > for either diagnostic purposes or for catching data loss due to a previous
> > > write error, as an error result of close() usually indicates a deferred
> > > error of a previous write operation.
> > > 
> > > Therefore not decrementing 'total_open_fd' on a close() error is wrong
> > > and would yield in a higher open file descriptor count than actually the
> > > case, leading to 9p server reclaiming open file descriptors too soon.
> > > 
> > > Based-on: <20250312152933.383967-7-groug@kaod.org>
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > ---
> > >  hw/9pfs/9p.c     | 14 ++++++++------
> > >  hw/9pfs/codir.c  |  3 ++-
> > >  hw/9pfs/cofile.c |  3 ++-
> > >  3 files changed, 12 insertions(+), 8 deletions(-)
[...]
> > > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > > index 2068a4779d..f1fd97c8a7 100644
> > > --- a/hw/9pfs/codir.c
> > > +++ b/hw/9pfs/codir.c
> > > @@ -353,7 +353,8 @@ int coroutine_fn v9fs_co_closedir(V9fsPDU *pdu, V9fsFidOpenState *fs)
> > >                  err = -errno;
> > >              }
> > >          });
> > > -    if (!err) {
> > > +    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
> > > +    if (!err || errno != EBADF) {
> > >          total_open_fd--;
> > >      }
> > >      return err;
> > 
> > Or, as EBADF is somewhat unexpected here (assuming v9fs_co_closedir() was
> > called by checking for a valid file handle), maybe it would make sense to log
> > this?
> > 
> 
> Getting EBADF could be the result of some unrelated code that closed
> the fd from another thread or the 9p code using some stale fid structure
> or some other serious bug. I'd personally g_assert().

Wouldn't that be too harsh? Killing QEMU should be last resort if continuing
to run resulted in a security threat or undefined behaviour. I'm not sure that
would apply here.

> >     if (unlikely(err && errno == EBADF)) {
> >         error_report("v9fs_co_closedir() failed with EBADF");  
> >     } else {
> >         total_open_fd--;
> >     }
> > 
> > In the sense, if EBADF happens here, it's an indication for a bug in 9p
> > server.



