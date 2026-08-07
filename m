Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF531C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 18:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsOxm-0000ZN-QN; Fri, 07 Aug 2026 14:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wsOxa-0000YH-82; Fri, 07 Aug 2026 14:06:23 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wsOxX-00018x-2j; Fri, 07 Aug 2026 14:06:21 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 24FAD60A69;
 Fri,  7 Aug 2026 18:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB2F1F000E9;
 Fri,  7 Aug 2026 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786125977;
 bh=yzMMpBnWR18D0n1h1icQAa+i7bkO/EV+DhdfsxUQTtU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IC5JzjbzxVGZYUa7gTZ8U996OGPlSTxD1TaUSnuhvVU2Vq+ZRL1Gxlf/2Zym1/31x
 EqLVjbbsBJGkVW7/ILioXLSjb6BwMLADkPBN9/Lc+OHdr9qHZFblhVAKmUK5pk3Pz8
 cOi+O6gT3fGNFPV9duJaAe8Q3Cdyuf0OB1Xhr9GotqFie0kjkqZvz+dSRCQdzJj84B
 mxQZw+LVWScd4rXqSsa0C1RwWfuGe+6a1JGe1yqAutSZh/ZOXmyN4tBkZ+xNMxnzAP
 WxiAzy02vE1zDOcKwn0b2vzCcAOMSRqVy5jU7gxiZJcj6oIenyZ8wZ5qm/SpibYMvx
 EdKTZwBPsd78w==
Date: Fri, 7 Aug 2026 20:06:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] file-posix: fix zone write granularity assignment for
 zoned block devices
Message-ID: <anYelpnMAJeFbs7h@ryzen>
References: <20260807180257.813627-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807180257.813627-1-cassel@kernel.org>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
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

On Fri, Aug 07, 2026 at 08:02:57PM +0200, Niklas Cassel wrote:
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

nit:
this away, so let's make use of it.

