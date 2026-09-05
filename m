Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B60DC624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2eLN-0001Ir-1v; Fri, 04 Sep 2026 20:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1x2eLL-0001I1-8T; Fri, 04 Sep 2026 20:33:15 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1x2eLJ-0007lT-Q1; Fri, 04 Sep 2026 20:33:15 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 120A960229;
 Sat,  5 Sep 2026 00:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9134D1F00ACA;
 Sat,  5 Sep 2026 00:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788568391;
 bh=EtiYYfM/EcQ2KnZhH1p8cbS/3nsIqanKx2W1nS5i9nc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=DHyLc6sjRIOUGuqAa7rboFxmMibhiyYIqxQBIq+8jw219NChgL6dn4fEEXyUkSWAq
 cpFVkTjIfTNjYVLWkV9P1FPE1NGX86yuam9UTgX2kuV+JT+sw/O0EoDKNL0f8SYOg/
 tEp5odXKX12yv4Ts1sZs/kvpLwSsSOEGYwWkGx7EGEhTuV8dEHjD3L0KCZqYj0RIdf
 MA8WLp6GmCm5HECamyMPPnVLEdO2ag7tQ5muAYfrQqYNQDEUWWLZl4oWsnSJKXc4jz
 2M2hTOn5fj01l4EXAM7JjHAK616Do73NZe1Dr14isXan9K7dAITysoC00bNMtGEITy
 yY5H/MXb8yY7w==
Message-ID: <822c1bcd-17c7-47d0-95df-4db9307916ef@kernel.org>
Date: Sat, 5 Sep 2026 09:33:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] virtio-blk: check the write granularity of
 writes to sequential zones
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260904161801.1568841-1-cassel@kernel.org>
 <20260904161801.1568841-6-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260904161801.1568841-6-cassel@kernel.org>
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

On 9/5/26 01:17, Niklas Cassel wrote:
> All VIRTIO_BLK_T_OUT requests issued to sequential zones and all
> VIRTIO_BLK_T_ZONE_APPEND requests must have an offset and a data size
> that are multiples of the write granularity reported by the device
> (virtio 1.4, 5.2.6.1), and a violation is reported as
> VIRTIO_BLK_S_ZONE_UNALIGNED_WP (virtio 1.4, 5.2.6).
> 
> Neither request type was fully checked. Zone appends validated only the
> offset, while writes were not checked at all.
> 
> Check the size of the appended data, and both the offset and the size of
> a write, against blkconf_zone_write_granularity(), so that every request the
> device accepts is one that the guest driver was told is valid. Writes to
> conventional zones keep no alignment constraint beyond the logical block
> size. The write path performs the check after virtio_blk_sect_range_ok()
> so that the zone index derived from the guest supplied sector is known to
> be in range.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

