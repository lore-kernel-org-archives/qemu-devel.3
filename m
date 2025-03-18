Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5265C28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWNf-0007oN-Bb; Tue, 18 Mar 2025 08:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWLe-0003ON-MZ; Tue, 18 Mar 2025 08:47:15 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWLb-0003e8-Rt; Tue, 18 Mar 2025 08:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742302028; x=1773838028;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0FgR/Vp3UYan5AdfRXukE+t2i1xm+NIn8NwYnqUDtzo=;
 b=Ma/A3mZl6GUrSLkIoC2524f1xk+7W1sFmvZVYbzTwfmPYtsYgE4gKvK+
 yP1eDlkyl4B9PNGA6/0qhS7nRc4VRS0iAfFFDSpzn1Jvag+ZXMDHNFjoL
 0nZYQ0CvGFzaNwpRY1NOyO4Hwd7UdfDDwhq/KmwdZS4aDpoUAMgyvSmSu
 cwki18IPmAjumP/F4cOdj5YhR4J7z5FF2WIjjkfCKM1y123/zFWBTy2ZL
 vPXMh/yZtCPTsJ3+5BAC0SeYX2X0hWsIbNu8Z7g0J7TPikHxByIfbaeWR
 b6Vs+vT8D2JEAU5/djujl2Q/Dj/DA1jU7iHMMubu243Dc/R10R5FTEq32 A==;
X-CSE-ConnectionGUID: WLgK/50PSBKi3OydpJKK3g==
X-CSE-MsgGUID: DvibxuerSC2AWHRwfSak1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54825031"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54825031"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:46:59 -0700
X-CSE-ConnectionGUID: hmbep/OJQ8KLOXnOGbav4A==
X-CSE-MsgGUID: +hevjObvTMS3T9UHa7pRWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="123188662"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 18 Mar 2025 05:46:57 -0700
Date: Tue, 18 Mar 2025 21:07:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 10/14] rust/vmstate: Support vmstate_validate
Message-ID: <Z9lv/5mj9mp7M9Lx@intel.com>
References: <20250318083248.1402990-1-zhao1.liu@intel.com>
 <20250318083248.1402990-11-zhao1.liu@intel.com>
 <9e8743b8-99b2-4aab-84de-7630edcc7e10@redhat.com>
 <Z9llqtHLLTJIju/j@intel.com>
 <CABgObfY1x1s_NOmjeNUjNCz5WggARCH_AUzxC81d+smq=jBf=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfY1x1s_NOmjeNUjNCz5WggARCH_AUzxC81d+smq=jBf=g@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Tue, Mar 18, 2025 at 01:32:03PM +0100, Paolo Bonzini wrote:
> Date: Tue, 18 Mar 2025 13:32:03 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v2 10/14] rust/vmstate: Support vmstate_validate
> 
> Il mar 18 mar 2025, 13:03 Zhao Liu <zhao1.liu@intel.com> ha scritto:
> 
> > >  /// This macro can be used (by just passing it a type) to forward the
> > `VMState`
> > > @@ -572,9 +548,9 @@ const fn phantom__<T>(_: &T) ->
> > ::core::marker::PhantomData<T> {
> > >                  }
> > >                  Some(test_cb_builder__::<$struct_name,
> > _>(phantom__(&$test_fn)))
> > >              },
> >
> > I want to keep the comment here as C version did, because there's an array
> > flag
> >
> 
> Ok, let's add it. No need to send v3 since it's just a single patch and
> with no changes further down.
> 

Thanks and sorry, I missed your notification because I didn't actively
pull my mutt just now... but, v3 might also be worthwhile.

While setting flags for vmstate_validate, I also took the opportunity to
do a little cleanup on vmstate_clock. I hope it didn't cause any extra
burden. :-)

Regards,
Zhao


