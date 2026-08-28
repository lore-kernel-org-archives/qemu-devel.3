Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8D1C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpvG-00026H-Qi; Fri, 28 Aug 2026 02:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpvE-00020s-OG; Fri, 28 Aug 2026 02:18:40 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpvD-0002Qo-2f; Fri, 28 Aug 2026 02:18:40 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9268F43A22;
 Fri, 28 Aug 2026 06:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950FF1F000E9;
 Fri, 28 Aug 2026 06:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787897917;
 bh=5j9neVhs+JPKC+M98wf88AjkfeRl6bE6n7tzeYq0bcw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Ne4+ro4/zZclhczrJjAHQCtwBuGqfZe7+jQmfYGdy0qw0iex8kR4icLVqByBanV5M
 T8EViEfEQ1muAJuFYLr/N7/FitVwezcnsPf7boz1RblR2WaTW+NEUijfxdGhzN8+Pt
 u/mDFymdrHf+OrUoLg82mAif4dbZ9PXqqaPTwwSPkCeqNpCB4XwQYEJArda/9lLV8p
 rO2bZmjXXIweqyFC/5ve++O4KFinn/y+ejleqSIBeQ/Pb3gzL6Rrrp4Xx173qI1fV3
 7jM6W9iTLvIzXS5srkIHWz1cQ+LRVGgJVnogvo5ygZ1vF3qt2N940VLshKNZ/LEY2O
 JQ/uejJRQPLug==
Message-ID: <6408b297-24bc-484c-a8cf-5ab4dce6a1ce@kernel.org>
Date: Fri, 28 Aug 2026 15:18:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] file-posix: reject a zone append past the device
 capacity
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-12-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-12-cassel@kernel.org>
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
> raw_co_zone_append() checks that the offset it is given is aligned to the
> zone size, but not that it names a zone of the device. raw_co_prw() then
> derives a zone index from it and reads that entry of the write pointer
> array, so an offset past the end of the device reads past the end of the
> array.
> 
> bdrv_co_zone_append() does not catch it either: bdrv_check_qiov_request()
> bounds the request against BDRV_MAX_LENGTH, which has nothing to do with
> the size of this device. A guest cannot reach it, because
> check_zoned_request() in virtio-blk rejects an out of range offset first,
> but qemu-io and any other caller of blk_co_zone_append() can:
> 
>   $ qemu-io --image-opts -n driver=host_device,filename=/dev/nullb0 \
>         -c "zap -p 0x100000000000 0x1000"
>   Segmentation fault
> 
> On a null_blk device with 1000 zones of 256 MiB, that offset yields zone
> index 65536 and reads 512 KiB beyond an 8000 byte allocation.
> 
> Reject an offset that lies outside the device. That also bounds the
> zone index that raw_co_prw() derives from it, so its write pointer
> lookup stays inside the array.
> 
> Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

