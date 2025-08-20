Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AD9CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 09:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uofWY-0002nw-MQ; Wed, 20 Aug 2025 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uofWX-0002nh-FZ
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:54:29 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uofWT-00051F-MA
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755683666; x=1787219666;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wJQmnOq2D2pcZJWZwWK0W5P28bHEmZQwHSq6N8mGZ8w=;
 b=DWD38SEnx7KCBihK7LGBXbXQyzBahGpv2jt7q5mWwRG4mMSxw2qHfUlF
 LviKw9b7d4f77HeQkLsW0MmCjMCfeweHr9mR97vwJsp+DCBODpyx63m2+
 LOFAlDRb9k+tYzN5/hnNWrE1r28A8qPA7YpdigF87hONziqQTnNCAIKdJ
 qLiixYdUZjj2ZJB9o7qP5iS1P9MyTBIewTkGgBs/TsMJW7NhWWcKbJasz
 1NwuwVTzBn4YapxNDzwuIP6ObcnTlx2AP5ugt2G920mm45Laq7mEFuT+o
 xZlN/Y5lCAH2h3qAc5uuovHmf+TKvCWytHs9AGjk8eAxa3UMuii/dpSEh w==;
X-CSE-ConnectionGUID: 8Xn98B1lRXKYB5dCwAojKQ==
X-CSE-MsgGUID: tlRgYK8TTEW7wWc5WUDN+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="80539210"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="80539210"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 02:54:23 -0700
X-CSE-ConnectionGUID: LkGHCPLKRaSQB4PteMt8LA==
X-CSE-MsgGUID: 1pYh0kqtQtG2no3Ul1q74g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="191776249"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 20 Aug 2025 02:54:21 -0700
Date: Wed, 20 Aug 2025 18:16:05 +0800
From: "zhao1.liu@intel.com" <zhao1.liu@intel.com>
To: "Wangxin (Alexander)" <wangxinxin.wang@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Wang Xin via <qemu-devel@nongnu.org>,
 "Huangweidong (C)" <weidong.huang@huawei.com>, xietuo <xietuo@huawei.com>
Subject: Re: [PATCH] target/i386: Add support save/load exception error_code
Message-ID: <aKWgZRwKpAx+3o3h@intel.com>
References: <20250819145834.3998-1-wangxinxin.wang@huawei.com>
 <20250819152817.789959-2-pbonzini@redhat.com>
 <e4018c7b70ef4d81bafcc7395551e735@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4018c7b70ef4d81bafcc7395551e735@huawei.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 20, 2025 at 02:18:21AM +0000, Wangxin (Alexander) wrote:
> Date: Wed, 20 Aug 2025 02:18:21 +0000
> From: "Wangxin (Alexander)" <wangxinxin.wang@huawei.com>
> Subject: RE: [PATCH] target/i386: Add support save/load exception error_code
> 
> > 
> > Queued, thanks.  But please let me know what's the correct signed off by chain;
> > either Tuo created the patch, and then you should have "--author" for him and
> > his SoB first; or you did, and then Tuo's SoB is unnecessary.
> > 
> > Paolo
> > 
> 
> The author is me,

But if Tuo co-worked with you, his SoB is also necessary to keep:

"git commits will usually be expected to have a ``Signed-off-by``
 line for each contributor involved in creation of the patch."

In this case, ¡°Co-developed-by¡± is not necessary for now.

I think the reason of confusion is, as the person sending the patch,
you'd have put your SoB on the last line.

Thanks,
Zhao


