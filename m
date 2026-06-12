Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99CACD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY1Vq-0004fm-Ul; Fri, 12 Jun 2026 09:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wY1Vp-0004fS-Hb; Fri, 12 Jun 2026 09:01:29 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wY1Vo-0000Be-13; Fri, 12 Jun 2026 09:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=vJ45C6il/cedgVfjU5hfc9yXy0yB7Im6Pxt+DCwc6YI=; b=fjxWhK7VnxhpVStUcPyAFBiqsR
 NKBbgPXlcr4jMbO0kY2EzsszO5Y7DKCkmzvPGV4GZ1TG97OlKAC4sFyyqMaQWlwx2hbq0mdx7bea7
 9c6fzQc5Y0LfK/TOBIS4EeohJdOzohRdkzuUuZmztFeEDbQ9h1z+/vqUzckO7N+xLuR6fJkyVQSqA
 zwNHiUru6CH3yY16+0tdu8AJxmRj2oHSRzKtxUuoCDMw+kI9tZnU8lk++gbMWnNjD+c/C02gMn0F9
 bxHEUSXoZlB05MojWtcTwfvZT4YRd8qhpKouI1Z4qzp8rQBHp0VsgVgXF8gU3j5iVdCWreblAJUMy
 LhYqaKtjtN8/SzJmvsL0/o7T8T6RmT1/EaytOIL9FDYBlnindJi287C5BWFJZudAyKkwfLshLLhoz
 kI1bHMb3bnmGnRMcnHRxrSDSCD1HY3WGcF9drmBJAvyCZuWNI0liT+ZERGAELIAeHq8LDHK63Lw8Q
 eyWQTBhYOoMIDPHaihTWXCy0kepDwxPO6CLKw+/FqH8hpW3RPGRi78pP0cqSGpQtGCZj46g8XjK6U
 GdaiJkKWuCcSSDPzZehdAOg/JUZvdZ7hTmrgMXPWrT35CuUJD/H84OOaWGYr7ggwDqQqN4qEWitYd
 /ATEegw4grMssfXxhLlczLVPDIlX47ysosOBq769A=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Feifan Qian <bea1e@proton.me>, Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 8/8] hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
Date: Fri, 12 Jun 2026 15:01:24 +0200
Message-ID: <1958510.tdWV9SEqCh@weasel>
In-Reply-To: <alpine.DEB.2.22.394.2606111720190.368315@ubuntu-linux-20-04-desktop>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
 <6c22c43668b995a71b0880bd146f09ae5f8956cc.1779916560.git.qemu_oss@crudebyte.com>
 <alpine.DEB.2.22.394.2606111720190.368315@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Friday, 12 June 2026 02:23:08 CEST Stefano Stabellini wrote:
> On Wed, 27 May 2026, Christian Schoenebeck wrote:
> > Constrain max_count in v9fs_readdir() to transport's current, real
> > response buffer size before calling v9fs_do_readdir() to prevent
> > excessive host memory allocation by bad clients.
> > 
> > Client may send a Treaddir request with a large 'count' parameter, and
> > while the negotiated 'msize' provides some limit, it accounts for guest
> > being somewhat faithful on the negotiated 'msize' value throughout the
> > session.
> > 
> > A bad guest client could have negotiated a large 'msize' but provide a
> > small reply buffer for Treaddir request, causing QEMU to allocate host
> > memory proportional to 'msize' before discovering the reply cannot fit.
> > 
> > Possible consequence was a potential DoS by a priviliged guest, causing
> > a disconnection of guest communication due to transport device being
> > marked as "broken", however QEMU process would have continued to run with
> > potentially giant host memory allocation, which might have negative
> > impact on other services running on host.
> > 
> > Fixes: CVE-2026-9238
> > Fixes: 2149675b195f ("9pfs: add new function v9fs_co_readdir_many()")
> > Reported-by: Feifan Qian <bea1e@proton.me>
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  hw/9pfs/9p.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
[...]
> >      /* Enough space for a R_readdir header: size[4] Rreaddir tag[2]
> >      count[4] */
> > 
> > -    if (max_count > s->msize - 11) {
> > -        max_count = s->msize - 11;
> > +    if (max_count > max_resp_sz - 11) {
> 
> max_resp_sz - 11 causes an underflow

Good catch!

I'll prepare a v2 with all your suggestions.

Thanks for your reviews, much appreciated!

/Christian



