Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F41C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 05:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuPu5-0005lW-Mf; Tue, 18 Mar 2025 01:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuPu3-0005l7-Eo; Tue, 18 Mar 2025 01:54:15 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuPu1-00044I-3H; Tue, 18 Mar 2025 01:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742277253; x=1773813253;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3FUKmWqPadsvW1DWS0qkDnePuwSiF6jWsMrSqBHhyPI=;
 b=iOkbRmpnrf0OWINnB4uv4t7LwSXdGc7noPF7HQshusyWmoCA7Ao+T3B0
 tuwVyJ2+jFMmZIfFyA1G7ddHhDR/vmxt2Y+uLpYcxYv2t1Uh3o6mVVtwV
 h6PFg6XMCtnizt1dq+iX4z43wb7LrWekl4Ais4CHrN4Agj9fCX3mB4eqO
 dvBDDLaXO+UIscAKZZKDo8E2kRUCZqx/0mhpAoMIVdxUc5NdRVdiwfyYs
 EaOZxi1zMdKSndTNlZAgm1W9ks4l74D2QvE/0RlKe8MGtTQqNRK6f97ya
 vHl2KHJ0oD1FRHgeTgIcL+ZYPW9xLFLUAQTgAv1ygEk1gLv9QZAho73XW A==;
X-CSE-ConnectionGUID: bo//OZeOQ1yQ37oGSLuu6g==
X-CSE-MsgGUID: 9YG/PDclSRiMvQCvgQi+Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="42646553"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="42646553"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 22:54:10 -0700
X-CSE-ConnectionGUID: 502+ZFhOSE64cR7ZL9UF7Q==
X-CSE-MsgGUID: Blk3jvdzQ8WkA6WHDGQYZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121985675"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 17 Mar 2025 22:54:08 -0700
Date: Tue, 18 Mar 2025 14:14:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/17] rust/vmstate: Use ident instead of expr to parse
 vmsd in vmstate_struct macro
Message-ID: <Z9kPPiJ0EEW+C3uR@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-5-zhao1.liu@intel.com>
 <CABgObfbroGQS+Kcay_4m6Bd-Ka_84La_7JBjyyp-HZfp+rpN-A@mail.gmail.com>
 <Z9ject7Ip7Iaqhhe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9ject7Ip7Iaqhhe@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
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

On Tue, Mar 18, 2025 at 10:46:10AM +0800, Zhao Liu wrote:
> Date: Tue, 18 Mar 2025 10:46:10 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH 04/17] rust/vmstate: Use ident instead of expr to parse
>  vmsd in vmstate_struct macro
> 
> On Mon, Mar 17, 2025 at 06:17:07PM +0100, Paolo Bonzini wrote:
> > Date: Mon, 17 Mar 2025 18:17:07 +0100
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: Re: [PATCH 04/17] rust/vmstate: Use ident instead of expr to parse
> >  vmsd in vmstate_struct macro
> > 
> > On Mon, Mar 17, 2025 at 3:52 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > >
> > > When specify an array field in vmstate_struct macro, there will be an
> > > error:
> > >
> > > > local ambiguity when calling macro `vmstate_struct`: multiple parsing
> > > > options: built-in NTs expr ('vmsd') or 1 other option.
> > >
> > > This is because "expr" can't recognize the "vmsd" field correctly, so
> > > that it gets confused with the previous array field.
> > >
> > > To fix the above issue, use "ident" for "vmsd" field, and explicitly
> > > refer to it in the macro.
> > 
> > I think this is not needed if the varray case is left as is, and other
> > cases use .with_...() instead of arguments?
> > 
> 
> Yes! With a[0..num], the `vmsd` could be parsed correctly. I'll drop this
> patch as well and refresh unit tests.
> 

Additionally, at present, IMO it is not suitable to replace the vmsd argument
with .with_vmsd() method because VMS_STRUCT requires a vmsd field, and
.with_vmsd() is optional.

There is no way to ensure that vmsd is not omitted... unless VMS_STRUCT is
also set within .with_vmsd(). This would be akin to merging vmstate_struct
and vmstate_of, but I suppose that would be a long way as for now.

So I prefer vmsd argument at the moment :-)

Thanks,
Zhao



