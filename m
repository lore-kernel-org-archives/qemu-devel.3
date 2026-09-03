Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3232C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 00:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1vhS-0006AK-O0; Wed, 02 Sep 2026 20:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1x1vhR-0006A8-7H; Wed, 02 Sep 2026 20:53:05 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1x1vhP-0003tr-L5; Wed, 02 Sep 2026 20:53:04 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE1F0409BD;
 Thu,  3 Sep 2026 00:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257D41F000E9;
 Thu,  3 Sep 2026 00:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788396781;
 bh=6Zbe8x+G+CBuXixiRsXg9CUAvPTMHCrymPHeZbMnPOw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Jh3wJTaBZPcHC34eiOnqew0zV4P6unGsrVNNUDDyi/k5BXyq5DgV2qjevt5Cr2vR+
 mOzAcmt7xqZDEyHOPB0agBXCvPAtyaeCb4700ovIKRvQ8U15CtkEaQTxL4Foj8KrPv
 edEp7eMVjX4lJ4J9Uioj8DULKci5x0mPwBsawhBhuzwrYQ2o/45FVbEPOW6tqcwxHg
 zN43Hs5g2S7HmoB26LbGpNTYA1UqRCP4L2sjyk14SSkYcYQSBVOlDeCNZaaZiGUen+
 e+bfAIErrpJpQmLouOtttRNQsSEKVHP6QXYngo2wkHcyty6eVgasyHQiiaMftVgeC+
 3Q4bCohqlL6kQ==
Message-ID: <ad3a7be3-7ac6-40a4-8c3a-19f0893016ea@kernel.org>
Date: Thu, 3 Sep 2026 09:52:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] hw/block: reject a zoned device whose write
 pointers are unaddressable
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260902194423.759355-1-cassel@kernel.org>
 <20260902194423.759355-6-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260902194423.759355-6-cassel@kernel.org>
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

On 9/3/26 04:44, Niklas Cassel wrote:
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

Looks good to me, but I think a better name for the helper should be
blkconf_check_zoned_geometry(), to make it clear what that function does.
With that fixed, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

