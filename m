Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DC9C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 07:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd3J4-0006lJ-I8; Thu, 22 Feb 2024 02:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rd3J2-0006kY-O5; Thu, 22 Feb 2024 02:15:44 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rd3J0-0006ZD-5E; Thu, 22 Feb 2024 02:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708586142; x=1740122142;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iAtPZcPDPQdHRcdaRyXRYOc5/6MG+WumigWKJ0gbMLU=;
 b=kB5/fX1BjV52laECzMa292faoXhqjqJoKoU450sYZuSeH8gGVVJtZ/pd
 byUQSYQwD6k4guBJE8Hz4cVfYIl0scy01D3TqqSJJMRhgs02TuEnMWiKV
 2hxgrj4zcE1OfnfwjCrdWqnKLV7RKVoGy9W5+DAjLqv/dacH8bNcQjDVY
 6t0gaVcIGynFPquKRFpWf+69sH6LDSytAxrj90JezWPS9RzksiNhqjnj+
 GCR0OQSD5TNPMjyn+B4JWy7f44xfplKf/XXHp4NAjjQJvRIqRvu9l6bMP
 5HmZZGj597nCR0byQj5pdkuGPQo/ARnYREb8XHpMrSj9hVSTW9PmnOUyI w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="5742774"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5742774"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2024 23:15:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; d="scan'208";a="10077039"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 21 Feb 2024 23:15:35 -0800
Date: Thu, 22 Feb 2024 15:29:15 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/6] [PATCH 0/6] Fix missing ERRP_GUARD() when
 dereference @errp
Message-ID: <Zdb3yxXbiHt9h46u@intel.com>
References: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
 <34f501b4-94d3-4cb1-96b8-1d2a77013817@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f501b4-94d3-4cb1-96b8-1d2a77013817@tls.msk.ru>
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 22, 2024 at 09:04:14AM +0300, Michael Tokarev wrote:
> Date: Thu, 22 Feb 2024 09:04:14 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: Re: [PATCH 0/6] [PATCH 0/6] Fix missing ERRP_GUARD() when
>  dereference @errp
> 
> 21.02.2024 12:43, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi all,
> > 
> > Thanks to Markus's explanation about ERRP_GUARD() on my previsou
> > patch [1],
> > 
> > I realize that perhaps more @errp dereference cases need to be
> > double-checked to ensure that ERRP_GUARD() is being used correctly.
> > 
> > Therefore, there're the patches to add more missing ERRP_GUARD().
> > 
> > [1]: https://lore.kernel.org/qemu-devel/875xz0ojg7.fsf@pond.sub.org/
> 
> Hi!
> 
> Since you're going to respin (it looks like), please include the initial
> patch (hw/intc one) into the series as well, so it's all in one go.
> 
> I'm not sure this should come via trivial-patches tree though.  Looks
> trivial enough :)
> 

Hi Michael,

Sure, I'll add that one into this series.
I understand that such small fixes across multiple parts are suited for
trivial-tree.

Thanks,
Zhao


