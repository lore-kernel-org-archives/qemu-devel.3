Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C15C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpwJ-0003By-TP; Fri, 28 Aug 2026 02:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpwI-0003BP-Ph; Fri, 28 Aug 2026 02:19:46 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpwH-0002Yg-6d; Fri, 28 Aug 2026 02:19:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F64B6053A;
 Fri, 28 Aug 2026 06:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B711F000E9;
 Fri, 28 Aug 2026 06:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787897983;
 bh=yyjsk/7GjdpgwVo2+CpajifmTEEsKjFVZ93weYKxESY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Tp1VJZ0FohS0HzREs+0AMHErM57vulpXAwGb9oJxnMV/axyWDXwYyr2/ea3aXknzH
 SQXXLiBnrfrExMLscnswNAOnG7TCZx4D0FMW+Vdh7Zcts59pv7sTr3eSh60Gy2rQzy
 BqH1V4oz5N6h+uONdGFtAHxYKPTrVzMNbjEBD81cnfqTVOG2pfAkSKlFJTUpkVHUmt
 aCdpXMqJkYUel32uYa3UHmkHkta3zHgHQ43eLxbro3FBm58lH6Qav3FU8lN/nMdjAz
 nkf/4xVEncKK7hpGc/OUebM5kGZJCykLiv3hMTVhad12vZUhPRQNnKcByQD+fcN5PQ
 BsLXAM+fghemg==
Message-ID: <ab64dc5d-52d6-49bb-ac94-571218f92bdb@kernel.org>
Date: Fri, 28 Aug 2026 15:19:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] file-posix: reject a zone append to a full or
 conventional zone
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-13-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-13-cassel@kernel.org>
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
> raw_co_prw() replaces the offset of a zone append with the write pointer
> of the addressed zone, which assumes that the stored value names a
> position inside that zone. It does not in two cases.
> 
> A full zone has its write pointer recorded at the end of the zone, since
> get_zones_wp() stores start + len for BLK_ZONE_COND_FULL. That is the
> first sector of the following zone, so the append is submitted there. The
> kernel accepts it whenever that zone is empty, because it is a legal
> write at its write pointer, and the completion path advances the wrong
> zone because it recomputes the zone index from the replaced offset. The
> data is written to a zone that was never addressed and success is
> returned:
> 
>   zone 2 finished, then a 4 KiB append to zone 2:
>   After zap done, the append sector is 0x180000     <- zone 3
>   zone 2: wptr 0x180000, zcond:14 (full)
>   zone 3: wptr 0x180008                             <- advanced
> 
> A conventional zone has no write pointer at all, and its array entry
> carries only the type marker in the top bit, so the offset becomes
> negative and the write fails with EINVAL. That is harmless but it reports
> nothing about the actual mistake.
> 
> Reject both while the write pointer lock is held, since the state has to
> be read and acted on atomically. check_zoned_request() in virtio-blk
> refuses an append to a conventional zone, so that case needs a caller
> that goes to the driver directly, but nothing there examines whether a
> zone is full, so a guest can reach the misdirected write.
> 
> Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

It would be nice to have a helper to test if a zone is full...
Nevertheless,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

