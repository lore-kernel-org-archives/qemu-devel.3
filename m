Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05FFC79F82
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2eKW-00014p-Hf; Fri, 04 Sep 2026 20:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1x2eKU-00013u-3O; Fri, 04 Sep 2026 20:32:22 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1x2eKS-0007fn-L5; Fri, 04 Sep 2026 20:32:21 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D86E43504;
 Sat,  5 Sep 2026 00:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06B31F00A3D;
 Sat,  5 Sep 2026 00:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788568337;
 bh=iJdTZb6NmQP8dOjnYc9VBB2oov7lTswGsq4gSXlBNmc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OEI0BcSpgUyzoPzgYBc9rfAINRVoFVnFiDZ0cr65KXIvxR1CXI2bIws+AJp/alpF+
 D+WN6kcSp1R+7TfQbBV2t2fs/joLb+r1zGGU4NWKIdAbHh/f1vsxGub0OiFt3vfHXL
 78tg6sPm6xC4xDJf0YB4M3XVnurz09xvgLFb0YqGOxXBVcnD541yqvXulR86D/F0/0
 DwH+Dc0aWL3BhLEySdCcTCnmdWpOdKtEtA514prZP3rWTPFCLraloozlBQOAWL/pKt
 vb+WWz/NMt9u0iBdDiMrmPWYmJD+8is+UNoS5yXn7Tix8kdC86aDtZWrOeOqSves+N
 MYto5TU5/SHQA==
Message-ID: <9b7b887c-5701-4c04-8ee0-e5377535a0fa@kernel.org>
Date: Sat, 5 Sep 2026 09:32:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] block: add a helper for the index of the zone an
 offset falls in
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260904161801.1568841-1-cassel@kernel.org>
 <20260904161801.1568841-4-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260904161801.1568841-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=dlemoal@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 9/5/26 01:17, Niklas Cassel wrote:
> Deriving the zone that an offset belongs to is open coded in five places,
> in two files, as a division of the offset by BlockLimits.zone_size. The
> zone size of a zoned device is always a power of two, which Linux requires
> of every device it accepts, so the division is a shift.
> 
> Add bdrv_zone_index() and use it. No functional change; the count of zones
> that a management operation spans stays a division, since it is a length
> rather than an offset.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Nice cleanup! One comment below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset)
> +{
> +    IO_CODE();
> +
> +    return offset >> ctz64(bs->bl.zone_size);
> +}

Should we save ctz64(bs->bl.zone_size) as bs->bl.zone_size_shift to avoid these
repeated ctz64() calls? Given how frequently this helper is used, that may be
worthwhile.

-- 
Damien Le Moal
Western Digital Research

