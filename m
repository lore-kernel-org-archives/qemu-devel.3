Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34989C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpq4-0003PU-Nc; Fri, 28 Aug 2026 02:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzppt-00030X-FK; Fri, 28 Aug 2026 02:13:11 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzppr-0001k7-SM; Fri, 28 Aug 2026 02:13:09 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20476436AC;
 Fri, 28 Aug 2026 06:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F278B1F000E9;
 Fri, 28 Aug 2026 06:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787897585;
 bh=yjSTGJr8Jz1TKN2cvhCq5H3QQXb3Hyh0H4SY9T12jwg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lb5QTZnpF7M8DZJP8JKNGPUA0//M6ARfQNIZPR3y2jtmIPAqD98tauz8rx7wzaHcC
 eJ1iOJ065If5EL5Hr+JHjmEaPKbXDG9sewKz5HwZzEIISBKCqwkNrXlI3tFtMwBZEJ
 eKPxdBGY/aRkcN1ozOomDl6RUdZ/Nb58srC7h6pbyWOG7ZiiNZPVSmxgLziqbgFmy9
 ymSALTnk/WVqJkxKBJw/Pz1gDjOqfWmO1EsKSSzgLtqek8KwsMQDBCY2IOHlhF8QLj
 6wSIwmoyNvy0WgqEc9WILGag9x+r6RmR7RwTpYqHCuNWiR39mMw9ruCUZldd2Qod6s
 kAOR7HgdM+dng==
Message-ID: <acf8c773-5c3a-45ae-8675-5402340761a8@kernel.org>
Date: Fri, 28 Aug 2026 15:13:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] block: reject zone appends that are not a multiple
 of the sector size
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-8-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=dlemoal@kernel.org; helo=sea.source.kernel.org
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

On 8/26/26 05:57, Niklas Cassel wrote:
> Zone write pointers are tracked and reported in units of
> BDRV_SECTOR_SIZE, so an append whose data size is not a multiple of it
> would leave a write pointer that cannot be represented, neither in a
> BlockZoneDescriptor nor in the virtio and NVMe zone reports derived from
> one.
> 
> Nothing states that invariant. file-posix, the only driver that carries
> out an append itself, does enforce it, but only as a side effect of
> checking each iovec against BlockLimits.write_granularity, which is never
> smaller than the sector size. That conflates two constraints: the sector
> granularity holds for every driver, whereas write_granularity describes a
> coarser requirement of the medium below a driver, and only a driver that
> has such a medium should express it.
> 
> Check the invariant once in bdrv_co_zone_append(), so that it no longer
> rests on a driver that happens to have a granularity of its own to
> report.
> 
> This is a lower bound, not the alignment that a guest has to observe. The
> block layer cannot know that one, because it also depends on the logical
> block size the device is configured with, which is a property of the
> frontend. The alignment that applies to a guest is the larger of the two,
> and it is the frontend that reports it, that validates requests against
> it, and that has to refuse a device whose write pointers do not satisfy
> it.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

