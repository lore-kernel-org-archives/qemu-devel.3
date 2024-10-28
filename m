Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CACD33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RT2-0007DT-2L; Mon, 28 Oct 2024 11:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1t5RSj-0007Bx-Sw; Mon, 28 Oct 2024 11:15:30 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1t5RSe-0000GN-Ei; Mon, 28 Oct 2024 11:15:21 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id AF212A41B35;
 Mon, 28 Oct 2024 15:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DA9C4CEE4;
 Mon, 28 Oct 2024 15:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730128504;
 bh=QmWGYU2daB4tD4ov/XQ+T7OzNVZKHVKtnGblLCJe+MU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ckcHBgEdViOSryPHJcmO5DAhI3b9Ee5YkGA6xFH/KvV2+s5EFC6TcX+kO9cP/9fTG
 vAhRBUdzsajPN0U1X3K/QsmlgZdrTt0+5urzDGVP2NGDhYB3p6IsKE/Sv0uIA5zHCg
 rVKj5FNg4T+QpA8/dWU+YhZXSbA8TWkn4FxBYFxm6grexfKl04+YI7X67mtTWCtBbe
 Ryh8NoAl2eugJvkj5s0RFrMRZSdJRcar/GqEbajG5430xkY0mqj61CYoPqlo9GUAzd
 5I9XaOrnzaCpb30KjkF2DYlHl9aLpFbRsqcI3YBLvjY1efmZvyAtVz2OU5VNGdJ+hq
 bbfEZaHhTUgCw==
Date: Mon, 28 Oct 2024 09:15:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Waldemar Kozaczuk <jwkozaczuk@gmail.com>
Subject: Re: [PATCH] hw/nvme: fix handling of over-committed queues
Message-ID: <Zx-qdQqRZZlczmf5@kbusch-mbp>
References: <20241025-issue-2388-v1-1-16707e0d3342@samsung.com>
 <ZxvLQ5rSQtDAfE-H@kbusch-mbp.dhcp.thefacebook.com>
 <Zx9S_tOkgB9MoY7J@AALNPWKJENSEN.aal.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx9S_tOkgB9MoY7J@AALNPWKJENSEN.aal.scsc.local>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=kbusch@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 28, 2024 at 10:01:50AM +0100, Klaus Jensen wrote:
> On Oct 25 10:45, Keith Busch wrote:
> > On Fri, Oct 25, 2024 at 12:50:45PM +0200, Klaus Jensen wrote:
> > > @@ -1520,9 +1520,16 @@ static void nvme_post_cqes(void *opaque)
> > >          nvme_inc_cq_tail(cq);
> > >          nvme_sg_unmap(&req->sg);
> > > +
> > > +        if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
> > > +            qemu_bh_schedule(sq->bh);
> > > +        }
> > > +
> > >          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
> > >      }
> > 
> > Shouldn't we schedule the bottom half after the req has been added to
> > the list? I think everything the callback needs to be written prior to
> > calling qemu_bh_schedule().
> > 
> 
> Not as far as I know. It is only queued up; it won't be executed
> immediately. It might run next (ASAP) if we are already in a bottom
> half, but not before whatever context we are in returns.

Okay. I was trying to come up with an explanation for why Waldek was
still able to reproduce the problem, and that was all I have so far.

