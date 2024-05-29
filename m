Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFA9C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCK5h-0003k1-OZ; Wed, 29 May 2024 10:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCK5f-0003hl-B3
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:15:43 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCK5a-0007CQ-BL
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716992138; x=1748528138;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rq7qUQw+6YPbN653UzNcnJO+2pudvt9/l/MkBb7BKP4=;
 b=QL6VzaaB6AZZjMYYxuaS5TEWDlD0IVDh+pSLV5pOIB2WUsgh/EPs0bw1
 GqkKmrUzmZNgr8ViLFGWy5MYbHBwjGr1bkRm3UzbRAsOlQxaRnoyK1S0o
 EkMN4GLGXzwLGOAU5/m/aW1pfY7UPYWvNjNmVz8vTS2FaP6J3YNgLp1ed
 ZQnzCQieZKdoWC231mIoQVpd1bqEbGCVmy5yEESu8ljVag6qJbmqcoq1Y
 xaQPwRb4+W3F3RnMmCZNXiOVw4FsB2t/RSqMlBaXAnbbiwwI38Fn+yUSt
 ipbSOhHagCbQblMc/65hkhz4u8TurNrqdn6cbEUpUXG11KxKDKeuZ/IHp A==;
X-CSE-ConnectionGUID: Zt37hfBpQ5qHG52Q6QPkXw==
X-CSE-MsgGUID: USlJQ586Qwq7HiZV0wepaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13628214"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; d="scan'208";a="13628214"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2024 07:14:54 -0700
X-CSE-ConnectionGUID: r3JnROW/RvSs96xiGowwww==
X-CSE-MsgGUID: rRQELzb1RLmdq8Ximav1UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; d="scan'208";a="66316099"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 29 May 2024 07:14:49 -0700
Date: Wed, 29 May 2024 22:30:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 1/6] scripts/simpletrace-rust: Add the basic cargo framework
Message-ID: <Zlc79ZhJavATdvSs@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-2-zhao1.liu@intel.com>
 <20240527200504.GB913874@fedora.redhat.com>
 <ZlWNk46MF5uNa+ZC@intel.com>
 <20240528141401.GB993828@fedora.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528141401.GB993828@fedora.redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Stefan,

On Tue, May 28, 2024 at 10:14:01AM -0400, Stefan Hajnoczi wrote:
> Date: Tue, 28 May 2024 10:14:01 -0400
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Subject: Re: [RFC 1/6] scripts/simpletrace-rust: Add the basic cargo
>  framework
> 
> On Tue, May 28, 2024 at 03:53:55PM +0800, Zhao Liu wrote:
> > Hi Stefan,
> > 
> > [snip]
> > 
> > > > diff --git a/scripts/simpletrace-rust/.rustfmt.toml b/scripts/simpletrace-rust/.rustfmt.toml
> > > > new file mode 100644
> > > > index 000000000000..97a97c24ebfb
> > > > --- /dev/null
> > > > +++ b/scripts/simpletrace-rust/.rustfmt.toml
> > > > @@ -0,0 +1,9 @@
> > > > +brace_style = "AlwaysNextLine"
> > > > +comment_width = 80
> > > > +edition = "2021"
> > > > +group_imports = "StdExternalCrate"
> > > > +imports_granularity = "item"
> > > > +max_width = 80
> > > > +use_field_init_shorthand = true
> > > > +use_try_shorthand = true
> > > > +wrap_comments = true
> > > 
> > > There should be QEMU-wide policy. That said, why is it necessary to customize rustfmt?
> > 
> > Indeed, but QEMU's style for Rust is currently undefined, so I'm trying
> > to add this to make it easier to check the style...I will separate it
> > out as a style policy proposal.
> 
> Why is a config file necessary? QEMU should use the default Rust style.
> 

There are some that may be overdone, but I think some basic may still
be necessary, like "comment_width = 80", "max_width = 80",
"wrap_comments". Is it necessary to specify the width? As C.

And, "group_imports" and "imports_granularity" (refered from crosvm),
can also be used to standardize including styles and improve
readability, since importing can be done in many different styles.

This fmt config is something like ./script/check_patch.pl for QEMU/linux.
Different programs have different practices, so I feel like that's an
open too!

This certainly also depends on the maintainer's/your preferences, ;-)
in what way looks more comfortable/convenient that is the best,
completely according to the default is also good.


