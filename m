Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EE7C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 02:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuMee-0003zI-38; Mon, 17 Mar 2025 22:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuMea-0003yt-0C; Mon, 17 Mar 2025 22:26:05 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuMeX-0005me-Jb; Mon, 17 Mar 2025 22:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742264762; x=1773800762;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=2Wd/2hrWh3vnYRtsYf8Pwd0CZeiHi4Cqqy05wKFP2lQ=;
 b=K7IBXnmc6UPthDH1N/7WY/Xu+ogDneOh3vQxFF2UlmMX2WwXAcw/lSIQ
 SAa1+JggPUgb8cfFVoU5Y4AJ75RFSSUqyHWZB1po9F+v6DtNUV1LGcHwc
 hluuABu7sgG/SrSPwNtCb9tAvCBlQvGZpvgQS4dwI9R40kmsZ5RlTUOAT
 QW/V6SMHWaVVARdKDCE/1sawkF+blZYLgigmJKLAbe30umQEK+75BqS0j
 LpMgF8Kh+pRQtrCwidBe7YNXrmkuqC0AR3JW99P0V525XRrnp9sWAsddQ
 hL/vzdGqVWoKD7h6M4wBNZ5957uAMGnu+6L9zBpkgRylpHQFMVFHwU6Rv Q==;
X-CSE-ConnectionGUID: M9pf9CeJRc283apPmhVZIA==
X-CSE-MsgGUID: wk2Zt/MVSgO54/wFow79/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="68739913"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; d="scan'208";a="68739913"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 19:25:58 -0700
X-CSE-ConnectionGUID: 0j0X6ZmLTa+WONrqrRJNQg==
X-CSE-MsgGUID: EQS5y3zSSrCd4/KPGW45hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; d="scan'208";a="127289532"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 17 Mar 2025 19:25:57 -0700
Date: Tue, 18 Mar 2025 10:46:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/17] rust/vmstate: Use ident instead of expr to parse
 vmsd in vmstate_struct macro
Message-ID: <Z9ject7Ip7Iaqhhe@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-5-zhao1.liu@intel.com>
 <CABgObfbroGQS+Kcay_4m6Bd-Ka_84La_7JBjyyp-HZfp+rpN-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbroGQS+Kcay_4m6Bd-Ka_84La_7JBjyyp-HZfp+rpN-A@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

On Mon, Mar 17, 2025 at 06:17:07PM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Mar 2025 18:17:07 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 04/17] rust/vmstate: Use ident instead of expr to parse
>  vmsd in vmstate_struct macro
> 
> On Mon, Mar 17, 2025 at 3:52 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > When specify an array field in vmstate_struct macro, there will be an
> > error:
> >
> > > local ambiguity when calling macro `vmstate_struct`: multiple parsing
> > > options: built-in NTs expr ('vmsd') or 1 other option.
> >
> > This is because "expr" can't recognize the "vmsd" field correctly, so
> > that it gets confused with the previous array field.
> >
> > To fix the above issue, use "ident" for "vmsd" field, and explicitly
> > refer to it in the macro.
> 
> I think this is not needed if the varray case is left as is, and other
> cases use .with_...() instead of arguments?
> 

Yes! With a[0..num], the `vmsd` could be parsed correctly. I'll drop this
patch as well and refresh unit tests.

Thanks,
Zhao


