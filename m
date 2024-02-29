Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93072C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiXk-0005ef-Dx; Thu, 29 Feb 2024 10:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfiXj-0005eN-Dp; Thu, 29 Feb 2024 10:41:55 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfiXh-00012y-RX; Thu, 29 Feb 2024 10:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709221314; x=1740757314;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Sq+FwXcAIeSa1JYuCfxjSFB02ZVo2r/rJq/L59N+K6I=;
 b=YbBitEeS6jhq/TVTqRIff39MJFidIN0XU7qWb9cJl3EPPG23gZj4YfOt
 CTdNgVl9+U0Kenz/CQAJ0Px4EMh4WMEsiVVYmjy8pqItye3cZXoEJT8XQ
 TRE0wpVazGHQWu5C6RzNCvQTXDY3iqPIuLjmPT4vVx1ZEQ6D2wi54+qPu
 TK8um5ZNHCq08pSdjGRRIW0X13Tbii9Mdhho92TnJ1woY/9ZHtQ9QYb5r
 Txb08xgkjT3GRw5GPcsoLM56LKqywbCk1Ct6DI2fZ2OHgvzC9PYijNvzi
 LMiDv9gb1tJXoyUS0wJUEtIhUdcnqSc/bLgX7XCW7kTKdHJlv+xkEbSiR w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3813175"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3813175"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 07:41:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8212549"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 29 Feb 2024 07:41:49 -0800
Date: Thu, 29 Feb 2024 23:55:32 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 16/16] hw/core/qdev-properties-system: Fix missing
 ERRP_GUARD() for error_prepend()
Message-ID: <ZeCo9A82Uqi3TKBM@intel.com>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-17-zhao1.liu@linux.intel.com>
 <87frxbuy05.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frxbuy05.fsf@pond.sub.org>
Received-SPF: none client-ip=198.175.65.16;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Markus,

> > ERRP_GUARD() could avoid the case when @errp is the pointer of
> > error_fatal, the user can't see this additional information, because
> 
> Suggest "when @errp is &error_fatal"

Sure! It's clearer.

> > exit() happens in error_setg earlier than information is added [1].
> >
> > The set_chr() passes @errp to error_prepend() without ERRP_GUARD().
> >
> > As a PropertyInfo.set method, the @errp passed to set_chr() is so widely
> > sourced that it is necessary to protect it with ERRP_GUARD().
> 
> "sourced"?  Do you mean "used"?
> 
> Are you trying to say something like "there are too many possible
> callers for me to check the impact of this defect; it may or may not be
> harmless."

Yes! Very well expressed. Thanks for your words.

> > To avoid the issue like [1] said, add missing ERRP_GUARD() at the
> > beginning of this function.
> >

[snip]

> Commit message could use a bit of polish.  Regardless
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks!

-Zhao

