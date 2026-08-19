Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFB4C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwjrP-0006Wu-O9; Wed, 19 Aug 2026 13:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wwjrO-0006Wh-7E; Wed, 19 Aug 2026 13:13:54 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wwjrM-0005xX-E9; Wed, 19 Aug 2026 13:13:53 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B60F2433FE;
 Wed, 19 Aug 2026 17:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78231F000E9;
 Wed, 19 Aug 2026 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787159627;
 bh=XhiPlUh5Vmh+H+SBneeL3l1jhF6qOQBWzwn0LQUP2e4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SSQK+Cb6nqJYft6BzOTq3HmAIwrVDSFe8GodUC/Wt7s5NiOFTj/WOuNsurruUcHAn
 mwziyYkNGvKUNnS9LHO7B61uxfbFHw91o90L45GGjDwOq3zRBv55Hg3FPw/WWg95SD
 alxRfiqV4wBQ0+pDSXCUeFT0ABev8fTSnuMl04CSmvKOAcmyGvG9Ej6ijw3++ur8qG
 3LrzPHTekOIcHKVvV+H/i0SZEfHCVh85fYugUlKSeul9a5gvTDwfnKe/nU9P2zV7Ol
 oU8fmWU/hqd/X25zNe4DtWkISQrgdSs5vhZuZyuna+8g3gEiJr72XkONAduButQSm9
 8OSTmsXxJbywA==
Date: Wed, 19 Aug 2026 19:13:42 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2] file-posix: fix zone write granularity assignment for
 zoned block devices
Message-ID: <aoXkRgCp-EArgj26@ryzen>
References: <20260811133236.1290092-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811133236.1290092-1-cassel@kernel.org>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 11, 2026 at 03:32:36PM +0200, Niklas Cassel wrote:
> In the ZBC and ZAC specifications, the requirement is that the write
> granularity matches the physical block size.
> 
> However, in the ZNS specification, the requirement is simply that the
> write granularity matches the logical block size.
> 
> See:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a805a4fa4fa376bbc145762bb8b09caa2fa8af48
> 
> In Linux, there is a zone_write_granularity sysfs property which abstracts
> this away, so let's make use of it.
> 
> Currently, it is theoretically possible that QEMU presents an inflated
> write granularity for NVMe devices where the physical block size is larger
> than the logical block size.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Fixes: a3c41f06d5a8 ("file-posix: add tracking of the zone write pointers")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Stefan,

Since you already have another zoned storage fix for file-posix.c queued:
https://gitlab.com/stefanha/qemu/-/commits/block-next

Could you perhaps queue this one as well?


Kind regards,
Niklas

