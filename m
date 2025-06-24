Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB94EC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 08:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTzGY-0007xX-Up; Tue, 24 Jun 2025 04:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uTzGW-0007wj-K6; Tue, 24 Jun 2025 04:44:28 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uTzGR-0000C4-17; Tue, 24 Jun 2025 04:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750754663; x=1782290663;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=54wPzwcU/d63mPvQQx2hn5D56Z6ahGjNKMh0mdv8/KI=;
 b=c7k9sxg2u6HjnzCGOYxyMOeBuEA0/o+sk+dlytxxI4kpT4VzQIW2H+i4
 pcOXGy36HKX5tIxROrtJgWlpEy6Gjw09G+rOcz3R7PLTZqonXx1kPXzb2
 whyAm7RNbhObxVWWQZqQlvxOTuqXYxc0fsAR07uPwpyXWClYXps/rgBD+
 gr132OhOlgjhI5r7XYNsS+0QbMsIdGW+kdPJu7H4imeHxWk/yChxQ8MvU
 9g91bVgNNJi/7QIZTBNz8OgBS9UxA6tvHzWG39y4ls9/+8xv674l31xAe
 QfFFXySr8hWDG0xihH/7s/RKqbUCxjarw4cSqYPmbhj/73s4cSK4nbU5l g==;
X-CSE-ConnectionGUID: 1fmy0blgRXiMEZ8Tpd2amA==
X-CSE-MsgGUID: /IdbaYnOR2m7AbTLGpTQkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="64415668"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="64415668"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 01:44:17 -0700
X-CSE-ConnectionGUID: eisIKi4cS1yi/BBYlFvTaA==
X-CSE-MsgGUID: 8gQhIpaXRBWTM3cwBSvHwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="157358580"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2025 01:44:16 -0700
Date: Tue, 24 Jun 2025 17:05:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, shentey@gmail.com
Subject: Re: [PATCH] rust: log: implement io::Write
Message-ID: <aFpqYTBLaf8GEd0v@intel.com>
References: <20250617081213.115329-1-pbonzini@redhat.com>
 <aFpR7+RMBlgt5DTD@intel.com>
 <CAAjaMXZvi7FxdOgC8xpw5O1sQD3ncZSpRQpNEetNDMR3MdfhvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjaMXZvi7FxdOgC8xpw5O1sQD3ncZSpRQpNEetNDMR3MdfhvA@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> > @@ -136,8 +137,7 @@ macro_rules! log_mask_ln {
> >          if unsafe {
> >              (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
> >          } {
> > -            #[allow(unused_must_use)]
> > -            ::qemu_api::log::LogGuard::log_fmt(
> > +            let _ = ::qemu_api::log::LogGuard::log_fmt(
> >                  format_args!("{}\n", format_args!($fmt $($args)*)));
> >          }
> >      }};
> 
> 
> Just `_ = ::qemu_api::log::LogGuard::log_fmt(...);` is sufficient, no
> `let` needed.

Good catch! Thank you Manos.

Regards,
Zhao


