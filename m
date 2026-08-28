Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7763C61DCD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpup-0001fz-N6; Fri, 28 Aug 2026 02:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpuk-0001eG-SZ; Fri, 28 Aug 2026 02:18:11 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpuj-0002Nb-6A; Fri, 28 Aug 2026 02:18:10 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E34541AE1;
 Fri, 28 Aug 2026 06:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F183B1F000E9;
 Fri, 28 Aug 2026 06:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787897887;
 bh=4K8W4a+RJBMTgCN/TwMLp1StPh/EMBKedJmlzjmIW1A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oLAbenML3HnCdGxlGY/tGbvW1aZq0m7rPGcyVin//C25sqN6zNNppU0mRZ88ytWcc
 LfLrpZNwFXK9M7yQLraYwcdH3r4px9rin87NJLHPsNbqM+ru9AQt4h0mV3xjCpD0dT
 CHIAOqaR3cndh/6zRkJ+P4iX6CM9nSlIUewSDy79UD0S4GUq4Ps/X9HMAhUXux+nSF
 ZzUVmd47irIitd0Pycv8viCSwnB1Jcz5lQUfsYT1d2z0Sm96wZspuyIgN4GEqt4CQy
 n7z+EubWxsXlmi6F43JCuL32XnGJxnPXimKcjLDFRmfFGH6oyVR4HwfM/PlA/1zOpr
 tQc3Dx1c8zdAw==
Message-ID: <7c8f1d20-43bc-423e-a7fb-2ea36e526e0b@kernel.org>
Date: Fri, 28 Aug 2026 15:18:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] virtio-blk: derive the maximum zone append size
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-11-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-11-cassel@kernel.org>
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
> The max_append_sectors field of virtio_blk_zoned_characteristics must be
> set by the device to the largest zone append request that can be issued
> to it, and a value of zero tells the guest driver that zone append is not
> supported at all (virtio 1.4, 5.2.5.2). Linux refuses to attach a zoned
> device that reports zero.
> 
> We pass BlockLimits.max_append_sectors straight through, which makes that
> field mean "zone append unsupported" when it is unset, rather than "this
> backend imposes no limit of its own". Only a backend that has a limit of
> its own has anything to put there.
> 
> Derive the value instead. A backend limit is honoured when there is one,
> and otherwise the request is bounded by the zone size, since an append
> cannot cross a zone boundary, and by the largest request the block layer
> can carry. The result cannot be zero.
> 
> A backend that carries out an append itself, rather than passing it to a
> device that has a limit of its own, is the one that knows how large a
> request its implementation can take, so it reports that in
> BlockLimits.max_append_sectors and this does not have to guess at it.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

