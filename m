Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A47EC531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 20:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtAS4-0007J2-3C; Thu, 19 Feb 2026 15:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vtARx-0007F5-RF
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 15:16:37 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vtARw-0007d2-FQ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 15:16:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5073760054;
 Thu, 19 Feb 2026 20:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02DEC4CEF7;
 Thu, 19 Feb 2026 20:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771532187;
 bh=aGXywUkhPv6dWGknN/jo7VvJN57hLEzAZ/NK/Ba2oGM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hdQ+9ju/objvcjbPxiNxDQn9lyNz2EQUmsnQtPhQigabfdFA0vxhypnT7IYaRO4Ug
 9w9rU5DyI54En1gRwaPzReoXXG2eVfZL+apWD2Z+Uzg0Nm9RhadmqX36c/7kZ3xZmI
 4r2DJWU9eKUA8GbXlWXiPl7jPrfDd3v56I2pbmtwtCPYyAnn6igWnMIUYzO86Kf0EQ
 ecjti6ld1oDtR7peMFuyylIYv25BodLH84SgIXBKk0gbe+ARWfvpWKVoCujmKuNfrn
 K7Xt6ITytJf3FOLMd22Cj/d2KXG84FjX6xrfYWoVhJkSECfptR55ZvYQMpl4wwwXOb
 y7WMI+/j5Fz9w==
Date: Thu, 19 Feb 2026 20:16:25 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH 03/10] accel/mshv: use mshv_create_partition_v2 payload
Message-ID: <20260219201625.GA2899407@liuwe-devbox-debian-v2.local>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-4-magnuskulke@linux.microsoft.com>
 <aY3WZg1JedxHtze2@anirudh-surface.localdomain>
 <20260218062358.GA2236050@liuwe-devbox-debian-v2.local>
 <aZbnCCXdRrmrYRg-@anirudh-surface.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZbnCCXdRrmrYRg-@anirudh-surface.localdomain>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
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

On Thu, Feb 19, 2026 at 10:33:44AM +0000, Anirudh Rayabharam wrote:
[...]
> > > 
> > > Instead of enabling all features by default, we could query which
> > > features are supported by the hypervisor on this host and enable only
> > > those.
> > > 
> > > To query supported features get the HvPartitionPropertyProcessorFeatures
> > > property via HvCallGetPartitionProperty (with HV_PARTITION_ID_SELF).
> > > 
> > > I think this would be more robust. This is what Cloud Hypervisor (well,
> > > technically, the mshv crate) does.
> > > 
> > 
> > While I think querying the hypervisor is the correct action, are we
> > sure this gives all the supported features on the host?
> 
> Yes, I confirmed this with the hypervisor team when implementing it in
> the mshv crate.
> 
> > 
> > Is there a case that the Linux root partition  has a reduced set of
> > properties?
> 
> It is my understanding that the processor features we expose to a guest
> must always be a subset of the processor features of the root/parent
> partition. So, if some proc feature is not available for root, we cannot
> make it available for any guest partitions either.

One thing comes to mind is the confidential VM support. In our CVM
implementation, the guest can see a different set of features than the
root partition, mostly around SEV-SNP support. I cannot say 100% for
sure that if this matters.

Wei

> 
> Thanks,
> Anirudh.
> 
> > 
> > Wei
> > 

