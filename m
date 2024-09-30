Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44414CEBF73
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMvo-00045J-DJ; Mon, 30 Sep 2024 16:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1svMvn-00044a-3X
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 16:23:43 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1svMvk-0006vm-A2
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 16:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=p+NISuZrpNFaCkcIlqbVPEw1U9loKEq4pr26KoOj0EQ=; b=TnBCo6IBp/op66PZ
 gKpkVZ8Jenq58qg/fhAPgdjNyh73qji0zmYTdotF2gnM3z5Kl5O9KaVcr+0L+CgHRpI2rDV+54E1F
 +gef/lEQGcMF/7En0CsWDVNl5/IIH5zH7lSSeeQzHpKDf7qr774ffJDSoTpuNyYpbpCe8PkqhkAio
 0K13VV5+lY7zlA87Qo9MPR7pSQ/tqKSZLYtPJcrRCiCKhUdmwu00P0ItWw9GQ2hNAqXhQGxqXGOc/
 lOYCe5R+UCMchlCFbz0KsnLTghDzapNjmr1jxvo1DnCzXwv9SYW3VfxWW8IlFLOPYwPr30L3jEpqC
 aTkP/kcsvAheAbKMcw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1svMve-0084Zx-1e;
 Mon, 30 Sep 2024 20:23:34 +0000
Date: Mon, 30 Sep 2024 20:23:34 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 6/7] migration/postcopy: Use uffd helpers
Message-ID: <ZvsIxkKRvC8vN9ME@gallifrey>
References: <20240919134626.166183-1-dave@treblig.org>
 <20240919134626.166183-7-dave@treblig.org> <ZvsBPQzODYXJQ52L@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvsBPQzODYXJQ52L@x1n>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:22:52 up 145 days,  7:36,  1 user,  load average: 0.05, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Sep 19, 2024 at 02:46:25PM +0100, dave@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> > 
> > Use the uffd_copy_page, uffd_zero_page and uffd_wakeup helpers
> > rather than calling ioctl ourselves.
> > 
> > They return -errno on error, and print an error_report themselves.
> > I think this actually makes postcopy_place_page actually more
> > consistent in it's callers.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> > ---
> >  migration/postcopy-ram.c | 47 +++++++++++-----------------------------
> >  1 file changed, 13 insertions(+), 34 deletions(-)
> > 
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 1c374b7ea1..e2b318d3da 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -746,18 +746,9 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
> >                           RAMBlock *rb)
> >  {
> >      size_t pagesize = qemu_ram_pagesize(rb);
> > -    struct uffdio_range range;
> > -    int ret;
> >      trace_postcopy_wake_shared(client_addr, qemu_ram_get_idstr(rb));
> > -    range.start = ROUND_DOWN(client_addr, pagesize);
> > -    range.len = pagesize;
> > -    ret = ioctl(pcfd->fd, UFFDIO_WAKE, &range);
> > -    if (ret) {
> > -        error_report("%s: Failed to wake: %zx in %s (%s)",
> > -                     __func__, (size_t)client_addr, qemu_ram_get_idstr(rb),
> > -                     strerror(errno));
> > -    }
> > -    return ret;
> > +    return uffd_wakeup(pcfd->fd, (void *)ROUND_DOWN(client_addr, pagesize),
> > +                       pagesize);
> >  }
> 
> There's a build issue on i386:
> 
> ../migration/postcopy-ram.c: In function ‘postcopy_wake_shared’:
> ../migration/postcopy-ram.c:750:34: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   750 |     return uffd_wakeup(pcfd->fd, (void *)ROUND_DOWN(client_addr, pagesize),
>       |                                  ^
> 
> The plan is to squash below fix:

Thanks!

Dave

> =========8<===========
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 03a63ef5cd..83f6160a36 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> -@@ -747,7 +747,8 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
>  {
>      size_t pagesize = qemu_ram_pagesize(rb);
>      trace_postcopy_wake_shared(client_addr, qemu_ram_get_idstr(rb));
> -    return uffd_wakeup(pcfd->fd, (void *)ROUND_DOWN(client_addr, pagesize),
> +    return uffd_wakeup(pcfd->fd,
> +                       (void *)(uintptr_t)ROUND_DOWN(client_addr, pagesize),
>                         pagesize);
>  }
> =========8<===========
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

