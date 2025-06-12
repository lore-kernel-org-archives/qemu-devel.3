Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52CAC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 09:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPe8b-0007s6-U8; Thu, 12 Jun 2025 05:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPe7B-0007Et-DX; Thu, 12 Jun 2025 05:21:25 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPe75-0004oq-IM; Thu, 12 Jun 2025 05:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749720048; x=1781256048;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=+a3YUpdp7BYCX4nn8bMckAZORE+ZM3CNCghwwusOxvo=;
 b=O2lsE4n8Ow26czjtjlVU/TqVM44eoi0X1qchVM476kdlxAksdL4B5GWL
 gyThRz0F26y6FAFfSfb8uOrTu1MBUJkfGmKTBuCSVuMOUKSCHfIAyT+P/
 zMl7xlqJYy0XMHh38uFoCPLXCdnFOFQXtUDR1mtegfS5ADRO/4ruPwsTq
 lMx42QZuF1KgHPhioeE78oKJXAdSKx/xkzt6WDpyeZVz296xs514+ZuHZ
 3s3PNKz+DJTvhFnKFW7FHNn7HSkDlks5GgiEHFLN6ROQasdVXjRxkCVQn
 +SGyY5z2n15GKokMyv/H1rJIDPFSwZmbEnutwBi+GsZroPTK8L/bEUr6p g==;
X-CSE-ConnectionGUID: t4IGMQDMTRC8A7ExbMATAw==
X-CSE-MsgGUID: cerdrT5eRH+wY0ayBDk9zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51974152"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="51974152"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 02:20:43 -0700
X-CSE-ConnectionGUID: vtdjdNUfT7WHiv+E/ERgVQ==
X-CSE-MsgGUID: dJ1v64K8Qy6TVSXUfdnsXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="148362129"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 12 Jun 2025 02:20:41 -0700
Date: Thu, 12 Jun 2025 17:41:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 4/5] rust: qom: make ParentInit lifetime-invariant
Message-ID: <aEqg5j9LFgszQzAv@intel.com>
References: <20250609154423.706056-1-pbonzini@redhat.com>
 <20250609154423.706056-5-pbonzini@redhat.com>
 <aEqcGiGmZiMoIhY5@intel.com>
 <CABgObfb8CWy5zthqHRJrKqjP4xmBC=Zh3FrDjcK2Z6wsZJu-ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfb8CWy5zthqHRJrKqjP4xmBC=Zh3FrDjcK2Z6wsZJu-ew@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jun 12, 2025 at 11:07:51AM +0200, Paolo Bonzini wrote:
> Date: Thu, 12 Jun 2025 11:07:51 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 4/5] rust: qom: make ParentInit lifetime-invariant
> 
> On Thu, Jun 12, 2025 at 11:00 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> > > +/// It's impossible to escape the `Jail`; `token1` cannot be moved out of the
> > > +/// closure:
> > > +///
> > > +/// ```ignore
> > > +/// let x = 42;
> > > +/// let escape = Jail::with(&x, |token1| {
> > > +///     println!("{}", token1.get());
> > > +///     token1
> >
> > This line will fail to compile (the below comment "// fails to compile" seems
> > to indicate that println! will fail):
> >
> > error: lifetime may not live long enough
> >   --> src/main.rs:22:9
> >    |
> > 20 |     let escape = Jail::with(x, |token1| {
> >    |                                 ------- return type of closure is Jail<'2, i32>
> >    |                                 |
> >    |                                 has type `Jail<'1, i32>`
> > 21 |         println!("{}", token1.get());
> > 22 |         token1
> >    |         ^^^^^^ returning this value requires that `'1` must outlive `'2`
> 
> Right, I put it there because '2 lives until the second println!. The
> problem is not so much that it's returning token1, it's that the
> println uses it.

Even after I comment out the last intln line, the compiler still
complains about returning token1. It seems the compiler's checking is
stricter.

I tried at there:

https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=1a9232532250b4a275638b926d7e65e5

Thanks,
Zhao

> I can see that it's confusing, maybe:
> 
>     // Because "escape" is used after the closure has returned, the
>     // compiler cannot find a type for the "let escape" assignment.
> 
> Paolo
> 

