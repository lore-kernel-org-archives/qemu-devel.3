Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBB6C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduM0-00069s-3P; Tue, 13 Aug 2024 12:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sf@sfritsch.de>)
 id 1sduLy-00067Z-I6; Tue, 13 Aug 2024 12:26:34 -0400
Received: from manul.sfritsch.de ([2a01:4f8:262:44c1:112::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sf@sfritsch.de>)
 id 1sduLw-0005oI-HY; Tue, 13 Aug 2024 12:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sfritsch.de
 ; s=rsa-1;
 h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
 Subject:cc:To:From:Date:From:Reply-To:Subject:Content-Transfer-Encoding:
 Content-ID:Content-Description:X-Debbugs-Cc;
 bh=/ZXBZUq8jl0T9j0gjDaG6rbtKLw6BULbvCmFE7lWCvE=; t=1723566389; x=1724430389; 
 b=wV4iwoZuirSh6FljgvkAzPxly+NjrxZnr+UGp5QzqKxL/feJElunpjtL/7zdluMyJkL6yl3XoV/
 phxdMdOY68kJSrkfUYVwIh8YalMmT5be2Y6/2kwrl9QAd8EVJqypM/lObK2k/GkIAhJ8SsbA63ivq
 8fC64o1rmf5mgtqqE0CKQ0eGV7jBjkCer20LJOTboHygkuD78fZ+rLr74lEGFcOwsLnlmLpybuwy+
 v789k4HEH5qLBCyILILv7xJqPosE09uY+ezYqihAe3sg9HleihtAP6eJk5aYNUu1Rzu1PYrhSG2SU
 8clMODb0yyjD3eyUgWUPIWU9+En2B6/rcqfQ==;
Date: Tue, 13 Aug 2024 18:26:18 +0200 (CEST)
From: Stefan Fritsch <sf@sfritsch.de>
To: John Snow <jsnow@redhat.com>
cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH] dma-helpers: Fix iovec alignment
In-Reply-To: <CAFn=p-Y1sAXfzx6cWEgeYyMyG3yn1vEpDmV2K8qWtLx4otm4tw@mail.gmail.com>
Message-ID: <ab701661-f83c-260e-942a-1d4655554a38@sfritsch.de>
References: <20240412080617.1299883-1-sf@sfritsch.de>
 <dnqsifhslb7mtidrzadsz6254ykmb4bjz2cenzryonz7wbjz4g@vj56wcuwgx25>
 <1eaf1f92-10f3-0270-a1b4-e95801c367dc@sfritsch.de>
 <CAFn=p-Y1sAXfzx6cWEgeYyMyG3yn1vEpDmV2K8qWtLx4otm4tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-913674176-325546100-1723566378=:1449550"
Received-SPF: pass client-ip=2a01:4f8:262:44c1:112::2;
 envelope-from=sf@sfritsch.de; helo=manul.sfritsch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---913674176-325546100-1723566378=:1449550
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 12 Aug 2024, John Snow wrote:

> On Tue, Apr 16, 2024 at 7:54 AM Stefan Fritsch <sf@sfritsch.de> wrote:
> 
> > adding John Snow to CC because he investigated this in 2020.
> >
> > On Fri, 12 Apr 2024, Eric Blake wrote:
> >
> > > On Fri, Apr 12, 2024 at 10:06:17AM +0200, Stefan Fritsch wrote:
> > > > Commit 99868af3d0 changed the hardcoded constant BDRV_SECTOR_SIZE to a
> > > > dynamic field 'align' but introduced a bug. qemu_iovec_discard_back()
> > > > is now passed the wanted iov length instead of the actually required
> > > > amount that should be removed from the end of the iov.
> > > >
> > > > The bug can likely only be hit in uncommon configurations, e.g. with
> > > > icount enabled or when reading from disk directly to device memory.
> > > >
> > > > Fixes: 99868af3d0a75cf6 ("dma-helpers: explicitly pass alignment into
> > DMA helpers")
> > > > Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> > > > ---
> > > >  system/dma-helpers.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > Wow, that bug has been latent for a while (2016, v2.8.0).  As such, I
> > > don't think it's worth holding up 9.0 for, but it is definitely worth
> > > cc'ing qemu-stable (done now).
> >
> > we had some more internal discussions and did some more googling, and it
> > turns out that this is actually part of a known issue:
> >
> > https://lists.nongnu.org/archive/html/qemu-block/2020-07/msg01866.html
> > https://gitlab.com/qemu-project/qemu/-/issues/259
> >
> > In the above mail to qemu-block, John Snow listed 4 problems in the code
> > but my patch only fixes the first one. Considering that the code may also
> > write data to the wrong place (problem 2), I wonder if an assert in the
> > same place would be better until the underlying issues have been fixed?
> >
> 
> Whew, it's been such a long time since I've looked at this, I barely
> remember. I think my email now knows more about the problem than *I*
> currently do. I'm glad I wrote it ...
> 
> I do not currently know what happens if you fix the first issue but not the
> other four; I don't know if it gets passably "less broken" or if it causes
> other bigger issues... and I don't have the bandwidth to test that out
> currently, my apologies.
> 
> If there's a renewed interest in fixing this, I can try to start ramping
> back up on it, but I have a few other projects to finish first, but
> possibly I could discuss this at KVM Forum to help delineate the work into
> manageable chunks.

We came across this while chasing another bug, which turned out to be in 
other unrelated code. I also don't know if fixing this first of several 
issues improves the situation for people running an affected 
configuration. We only use qemu configurations where the broken code path 
is not hit. So, I am not sure this can be called renewed interest in 
fixing the issue. But if this is committed, I think there should be at 
least a comment pointing to the other issues.

Cheers,
Stefan
---913674176-325546100-1723566378=:1449550--

