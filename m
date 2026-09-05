Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148D1C79F82
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2eMO-00027J-HF; Fri, 04 Sep 2026 20:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1x2eMM-00026N-7T; Fri, 04 Sep 2026 20:34:18 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1x2eMK-0007sO-OA; Fri, 04 Sep 2026 20:34:17 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7016242E78;
 Sat,  5 Sep 2026 00:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A491F00A3D;
 Sat,  5 Sep 2026 00:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788568455;
 bh=kWPyQIPT8n/OhyIiTYG454zuQPoPbaEq+jZ7dxy7hgk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RQdtLATRB0DkA3v8CciZkTW3b+HWdjbGrcuO7uhmdcgJa4rhwItmPP7QCzVSE4rdq
 nEEimtU/mbk8r27uZgjWSF9tFon3/BZbhwc468Zzrt1J8bquUvnRI/6jxOMyaUxbyL
 zs+WYvoJIGcTh1v8wca1U92A2n+M3wxiWYokkm+GlAG9F8oCofChM3jed2fpytgHsX
 NhahdYfwl4vpt02jqbj6rGBfZQEjAJPNZk2tWISgDRkxkNPMzxiEfao9XlrcH5w2Y1
 D7cK7EOIk/iSC8BVBYzoJF5MffLVDvBwmy8GOP0MoRmOF4yeksBn6Wpm8JTcjUcXEY
 8GTnAQL7MszCA==
Message-ID: <d27d262a-6504-4e18-8c7b-4a1bdd882e3d@kernel.org>
Date: Sat, 5 Sep 2026 09:34:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] hw/block: reject a zoned device whose write
 pointers are unaddressable
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260904161801.1568841-1-cassel@kernel.org>
 <20260904161801.1568841-7-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260904161801.1568841-7-cassel@kernel.org>
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
> The write pointers of a zoned device outlive any particular use of it,
> whether the device keeps them itself or a backend records them, while the
> logical block size is a property of the frontend and is chosen afresh
> every time the device is attached. Nothing ties the two together. A zone
> written while the device was configured with logical_block_size=512
> leaves a write pointer that is a multiple of 512, and attaching the same
> device with logical_block_size=4096 makes that pointer unaddressable.
> 
> Such a pointer is not merely misaligned. The guest addresses the device
> in logical blocks, and a zone report expresses the write pointer in 512
> byte sectors, so the guest is told about a position that does not fall on
> a logical block boundary. It can neither read nor write there, and the
> zone can only be recovered by resetting it. The reverse direction is
> harmless: a pointer laid down with a larger logical block size is still a
> multiple of a smaller one.
> 
> On a zoned null_blk device with a logical block size of 512, a 512 byte
> append to a sequential zone leaves the write pointer half a logical block
> into it:
> 
>   $ qemu-io --image-opts -n driver=host_device,filename=/dev/nullb0 \
>         -c "zap -p 0x20000000 0x200" -c "zrp 0x20000000 1"
>   start: 0x100000, len 0x80000, cap 0x80000, wptr 0x100001, zcond:2
> 
> Attaching that disk with logical_block_size=4096 handed the guest a zone
> it could not write to.
> 
> Check at realize time that the zone size and every write pointer of a
> sequential zone are multiples of the write granularity that the device is
> about to report, and refuse to start otherwise. The write pointers are
> already held in memory by the driver, so this costs no I/O.
> 
> The check uses blkconf_zone_write_granularity(), the same value that a
> frontend reports to its guest and validates requests against, so the
> three cannot disagree.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

