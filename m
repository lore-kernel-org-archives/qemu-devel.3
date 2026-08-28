Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A50C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzprJ-0006gQ-V5; Fri, 28 Aug 2026 02:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzprI-0006fk-Et; Fri, 28 Aug 2026 02:14:36 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzprH-0001u0-0o; Fri, 28 Aug 2026 02:14:36 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2AE4602D4;
 Fri, 28 Aug 2026 06:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40311F000E9;
 Fri, 28 Aug 2026 06:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787897669;
 bh=LQ0KqQUobaxbdlTLVbnyuLDrv2eVjNQ6GGf55CH3bhk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FqK0g5XCGhbg881/A007kIH9m/Yc3IBZHcaWhZnS6Y9rBIeeVZg0gFHEp5jSRKV+c
 hqKdHxzqxLLHN8YDItoBD1sMw2kLhv9tYIIh3TnUBmVw8IJZ7rk0sHmoSk+JW3z4id
 Slefjdr89sXDauD6s5ehsYPoQ/DRJ50eIymH5UP9WuA2ihIeuFq5zSvMd9eoPwd3KO
 GC1Y/4Li1BqzonyqfaPRAG6tVipClGYPkoJijcmyxXwL8uA6uauPvCm4f7C2EZSX9n
 HQXhrwVhPtMNPdisvc4dXGcKue9NfTqNHDd0YoTCs+7W8R5a1HohXVEBZWWN9Vvzdc
 GEaYB8+ozKSGw==
Message-ID: <6700fd4b-16e0-43bc-8780-0a4704f90f4b@kernel.org>
Date: Fri, 28 Aug 2026 15:14:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] file-posix: remove the zone append write
 granularity check
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-9-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-9-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=dlemoal@kernel.org;
 helo=tor.source.kernel.org
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
> The check rejects a zone append whose individual iovec lengths are not
> multiples of the zone write granularity. That is stricter than the
> constraint it is meant to enforce, which applies to the size of the
> request as a whole. A request whose total is properly aligned but which
> is split across, say, a 512 byte and a 3584 byte iovec is refused here,
> even though the iovec boundaries do not survive into the scatter gather
> list that reaches the device.
> 
> Nor is the driver the right place to enforce it. The kernel and the
> device validate writes to a sequential zone themselves, which is why the
> same function already passes the request length down without comparing it
> against BlockLimits.max_append_sectors. The sector granularity that holds
> for every backend is now checked once in bdrv_co_zone_append(), and a
> frontend enforces the granularity it advertises to its guest.
> 
> Drop the check. BlockLimits.write_granularity is now set in one place, by
> this driver from the zone_write_granularity queue attribute, and read in
> one place, by the frontend that reports it.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

