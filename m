Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D293C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 11:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwh6k-0003Gi-O7; Tue, 16 Apr 2024 07:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sf@sfritsch.de>)
 id 1rwh6i-0003Fx-52; Tue, 16 Apr 2024 07:36:12 -0400
Received: from manul.sfritsch.de ([2a01:4f8:262:44c1:112::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sf@sfritsch.de>)
 id 1rwh6f-0000Ey-C6; Tue, 16 Apr 2024 07:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sfritsch.de
 ; s=rsa-1;
 h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
 Subject:cc:To:From:Date:From:Reply-To:Subject:Content-Transfer-Encoding:
 Content-ID:Content-Description:X-Debbugs-Cc;
 bh=I8JZSlmsSgkrpqmg+8gfsX1319gZHtNd8RIuFWZj0W0=; t=1713267366; x=1714131366; 
 b=Hcz42YrCCgiA20UJ+w2HrmV6Hly2uOSF7OwbZZGEvNWlGDheQqMS5Ct4QwKvZiuo3+UoaNA3aL9
 7sgTvxD6cK761q7oSbfh3Fs7wq27h+wak79GFk+1In+F7w8r1VXutgc5n92N8uP+nv3szRCpXe3wS
 vl0iU8GHH/q7My9paOwjQBwfZyUM3URb8F0wxH29Nah83a80WfZHKN6dY94USTkTjzh7TtpwOxhEv
 y6OtCOrNzOzZUH4ITdGGnDAMjRD9siIGalk466LVJ95hPH5gbtBRqYvmXJuHDRhX1nx4ExO2jtKJG
 UwbmKXZ+3uUuuzx5SfXpfrCyNOSG/9iY7aHQ==;
Date: Tue, 16 Apr 2024 13:36:03 +0200 (CEST)
From: Stefan Fritsch <sf@sfritsch.de>
To: Eric Blake <eblake@redhat.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] dma-helpers: Fix iovec alignment
In-Reply-To: <dnqsifhslb7mtidrzadsz6254ykmb4bjz2cenzryonz7wbjz4g@vj56wcuwgx25>
Message-ID: <1eaf1f92-10f3-0270-a1b4-e95801c367dc@sfritsch.de>
References: <20240412080617.1299883-1-sf@sfritsch.de>
 <dnqsifhslb7mtidrzadsz6254ykmb4bjz2cenzryonz7wbjz4g@vj56wcuwgx25>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2a01:4f8:262:44c1:112::2;
 envelope-from=sf@sfritsch.de; helo=manul.sfritsch.de
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

adding John Snow to CC because he investigated this in 2020.

On Fri, 12 Apr 2024, Eric Blake wrote:

> On Fri, Apr 12, 2024 at 10:06:17AM +0200, Stefan Fritsch wrote:
> > Commit 99868af3d0 changed the hardcoded constant BDRV_SECTOR_SIZE to a
> > dynamic field 'align' but introduced a bug. qemu_iovec_discard_back()
> > is now passed the wanted iov length instead of the actually required
> > amount that should be removed from the end of the iov.
> > 
> > The bug can likely only be hit in uncommon configurations, e.g. with
> > icount enabled or when reading from disk directly to device memory.
> > 
> > Fixes: 99868af3d0a75cf6 ("dma-helpers: explicitly pass alignment into DMA helpers")
> > Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> > ---
> >  system/dma-helpers.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Wow, that bug has been latent for a while (2016, v2.8.0).  As such, I
> don't think it's worth holding up 9.0 for, but it is definitely worth
> cc'ing qemu-stable (done now).

we had some more internal discussions and did some more googling, and it 
turns out that this is actually part of a known issue:

https://lists.nongnu.org/archive/html/qemu-block/2020-07/msg01866.html
https://gitlab.com/qemu-project/qemu/-/issues/259

In the above mail to qemu-block, John Snow listed 4 problems in the code 
but my patch only fixes the first one. Considering that the code may also 
write data to the wrong place (problem 2), I wonder if an assert in the 
same place would be better until the underlying issues have been fixed?


> > 
> > diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> > index 9b221cf94e..c9677fd39b 100644
> > --- a/system/dma-helpers.c
> > +++ b/system/dma-helpers.c
> > @@ -174,8 +174,7 @@ static void dma_blk_cb(void *opaque, int ret)
> >      }
> >  
> >      if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
> > -        qemu_iovec_discard_back(&dbs->iov,
> > -                                QEMU_ALIGN_DOWN(dbs->iov.size, dbs->align));
> > +        qemu_iovec_discard_back(&dbs->iov, dbs->iov.size % dbs->align);
> 
> Before the regression, it was:
> 
> -    if (dbs->iov.size & ~BDRV_SECTOR_MASK) {
> -        qemu_iovec_discard_back(&dbs->iov, dbs->iov.size & ~BDRV_SECTOR_MASK);
> +    if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
> +        qemu_iovec_discard_back(&dbs->iov,
> 
> If dbs->align is always a power of two, we can use '& (dbs->align -
> 1)' to avoid a hardware division, to match the original code; bug
> QEMU_IS_ALIGNED does not require a power of two, so your choice of '%
> dbs->align' seems reasonable.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> 

