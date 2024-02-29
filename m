Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBEDC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 19:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfmDn-0002Kw-3B; Thu, 29 Feb 2024 14:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <willy@infradead.org>)
 id 1rfmDg-0002Kc-MR
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:37:30 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <willy@infradead.org>)
 id 1rfmDe-0004GC-0a
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8uNmGuKJqG0ZLwvelugqTwty9eAp95ps/IXd1VUbjRE=; b=LfHiOuS377ugSXr21HSPLjoGds
 rRHRotHB6Z2K+UknnXnK+QSxqb+aTii8MgmSzXW1sRNBptAvRcgkCTNz6J+ZbnsCs2gOL69/7CQwh
 HbpeH4t5yDhGvqmnlTjCTBFsDyp9akGVrkIGj6y3BedRK3Vygt5msrjSPEYVN6VtIWpZchOzssQ/V
 WR1aOx0+dyY/SjdSpU3JUwI4U2i/3gjC67frvRbY1ZlyHhnna281LjFJ9s/SzckoOzX+rHWRnRD4q
 DbfpzdwBNaELy6OKw8HL8OqWb7AQNPVnsIkMg3yiwsLXR6E9Xx/G6dwkxCxOWFcKJ/oDRVozID8PI
 7uk/dp4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rfmDP-00000008qqb-3bC7;
 Thu, 29 Feb 2024 19:37:11 +0000
Date: Thu, 29 Feb 2024 19:37:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Greg Edwards <gedwards@ddn.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-ID: <ZeDc50LQSItEeXY8@casper.infradead.org>
References: <20230814144100.596749-1-willy@infradead.org>
 <170198306635.1954272.10907610290128291539.b4-ty@kernel.dk>
 <20240229182513.GA17355@bobdog.home.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229182513.GA17355@bobdog.home.arpa>
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=willy@infradead.org; helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Thu, Feb 29, 2024 at 11:25:13AM -0700, Greg Edwards wrote:
> > [1/1] block: Remove special-casing of compound pages
> >       commit: 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55
> 
> This commit results in a change of behavior for QEMU VMs backed by hugepages
> that open their VM disk image file with O_DIRECT (QEMU cache=none or
> cache.direct=on options).  When the VM shuts down and the QEMU process exits,
> one or two hugepages may fail to free correctly.  It appears to be a race, as
> it doesn't happen every time.

Hi Greg,

By sheer coincidence the very next email after this one was:

https://lore.kernel.org/linux-mm/86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com/T/#u

Can you try Tony's patch and see if it fixes your problem?
I haven't even begun to analyse either your email or his patch,
but there's a strong likelihood that they're the same thing.

