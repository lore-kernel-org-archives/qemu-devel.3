Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B5AC2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 19:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsPoE-0002Zj-66; Fri, 07 Aug 2026 15:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wsPoB-0002ZS-UA; Fri, 07 Aug 2026 15:00:43 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wsPoA-0003TD-2c; Fri, 07 Aug 2026 15:00:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 795F443469;
 Fri,  7 Aug 2026 19:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259D61F000E9;
 Fri,  7 Aug 2026 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786129238;
 bh=qXnfeMYvOMbK3ZL4dbqWt01ABNPAKEmIaRvtBmgmbcc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=AT3k4Q+LIimK77RJQMRyqTCN17H6nqp4zelEBgeyo8uI27rLWNaCEsT9fm10RlY5r
 qjDInP5eu55FMJbjKadPtEqiCQQ93txbADixSnE+m0AdlmT7Zh4f03IeEXRqT40uUE
 7+F44KgqLfLuAv/Wpz/xETJM1cVQB3yR1EtQXYEl/4GKkRdYlbXJP+ZYIBNMIBJYQb
 pVrFLf429II+Y0xVXk+itMVI6g4qv1CfZuaU6FrXFzz5eT3vMxgLClXtegMU9aDbsS
 2rpRund/LGuz/0u1ju4vZ186fr4D5Pbf+KLpcgyQ4uYNT6oT0rh/uaWv+9pBtXwgr9
 iPJF4HcBvWAXw==
Message-ID: <088c58f4-943e-42a0-8f8a-cfdb53c1b1ed@kernel.org>
Date: Fri, 7 Aug 2026 12:00:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] file-posix: fix zone write granularity assignment for
 zoned block devices
To: Niklas Cassel <cassel@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20260807180257.813627-1-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260807180257.813627-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=dlemoal@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
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

On 2026/08/07 11:02, Niklas Cassel wrote:
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
> this away by providing, so let's make use of it.

s/by providing// ? Seems like the sentence is not complete otherwise...

> 
> Currently, it is theoretically possible that QEMU presents an inflated
> write granularity for NVMe devices where the physical block size is larger
> than the logical block size.
> 
> Fixes: a3c41f06d5a8 ("file-posix: add tracking of the zone write pointers")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Other than that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

