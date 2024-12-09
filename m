Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F26E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 07:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKYMe-0007VW-Jn; Mon, 09 Dec 2024 02:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKYMd-0007VD-4U; Mon, 09 Dec 2024 02:39:31 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKYMa-0000bx-Ea; Mon, 09 Dec 2024 02:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733729969; x=1765265969;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Xcl5bTr6izAci+yS4xpUaTgLFdqlVs6cTGr26Yt35ps=;
 b=gw63iGFpD/rjlyAdaHMmaD2MWRKrQ3xxeZEg7LrfNL5eeAQLUe1XWIeb
 F+WGNfnuoswjudlErtS9qmMfWwdVoGNElx7lqcRIZ8LDYRQQlTXtRUHXP
 PoxuX0LBImAvJqFsUaDZQOlcRCKdYvXzcsQ7QsSjeMJBHNd2keR7Q3ze7
 RcwueuFXs6vc3+gJJb2S7ZDNUbN0X2u3LrNpA1vctQHgcsWr6Fe13BVif
 q9mt9sklkFExr7o1aSQgrv0scTC3dQZWIWYQ/Q+9NbW5SA2nJP9XikFAC
 7KY3tEQrFICrbsO8or/kJxNqghu6WM8Rw8nTRieAPfQKwogaDwqQsoh97 w==;
X-CSE-ConnectionGUID: QOtivaKGRlajFO9L0bHSyw==
X-CSE-MsgGUID: 6yLOCMGJRM+kw9BaWHweHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34071889"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; d="scan'208";a="34071889"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2024 23:39:22 -0800
X-CSE-ConnectionGUID: yttqO0KxQIKHo82pNE1bjQ==
X-CSE-MsgGUID: VBgxGpwnSS6Zd4HoFTxm9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; d="scan'208";a="99812754"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 08 Dec 2024 23:39:19 -0800
Date: Mon, 9 Dec 2024 15:57:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 00/13] rust: Reinvent the wheel for HPET timer in Rust
Message-ID: <Z1ai7PbmpDff8zxp@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <2f42c553-5673-4826-bc2f-14ec1306e8c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f42c553-5673-4826-bc2f-14ec1306e8c0@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
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

On Thu, Dec 05, 2024 at 05:28:45PM +0100, Paolo Bonzini wrote:
> Date: Thu, 5 Dec 2024 17:28:45 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 00/13] rust: Reinvent the wheel for HPET timer in Rust
> 
> On 12/5/24 07:07, Zhao Liu wrote:
> > * Proper bindings for MemoryRegionOps, which needs to wrap the ram
> >    read/write callbacks.
> >    - I think it shouldn't be complicated because qom/qdev already
> >      provides good examples.
> 
> Sounds good, I have some initial work on PL011.

Great! Sorry for the slow response, I just saw this comment. I'm looking
forward to your work on this!

> > Based on this, I am also considering how the opaque parameter in certain
> > callbacks should interact with BQL cells. In the timer binding (patch
> > 7), I think the opaque parameter accepted by the timer callback should
> > be placed in a BQL cell. However, considering generality, I did not make
> > further changes and only passed BqlRefCell<HPETTimer> as the opaque
> > parameter in the HPET code.
> 
> That sounds good.
> 
> I'll review your timer bindings and post the infrastructure that I have for
> callbacks.

Thank you!

> > Furthermore, is it possible in the future to wrap the entire state
> > within a BQL cell? This could save the effort of wrapping many state
> > members individually when state becomes very huge and complex.
> 
> I think it's better if we keep a split between the mutable and immutable
> parts.  For example properties are immutable.

I like this idea. Clear splitting helps to standardize the usage of
BqlCell, preventing both underuse and overuse.

> > QDEV Property
> > -------------
> > 
> > To support bit type property, I added another macro variant (in patch 8)
> > to allow bitnr parameter. However, I think this lacks scalability.
> > 
> > In qdev-properties.h, it is clear that the PropertyInfo of a property is
> > bound to its type. Previously, Junjie and I attempted to do the same in
> > Rust by binding PropertyInfo to the type, thereby avoiding the need to
> > specify too many parameters in the macro definitions:
> > 
> > https://lore.kernel.org/qemu-devel/20241017143245.1248589-1-zhao1.liu@intel.com/
> 
> Oops, sorry.  I have applied patch 1, but patch 2 is a bit problematic
> because I think it's not const-friendly.  Maybe it was applied to older
> code?

Yes, it was based on old code base...and it seems outdated.

> I haven't looked closely at whether it's possible to use trait { ... const
> TYPE: &Property = ... }, maybe only in newer Rust?  But as you point out
> there is an issue with multiple PropertyInfos that can apply to the same
> type, therefore I think the way to go here is to use a procedural macro and
> a #[property] attribute.  That also makes bit properties easy:
> 
>     #[property(bit=0, name="foo")
>     #[property(bit=1, name="bar")
>     features: u32,

Thank you, it looks better and overcomes the drawback of the original
proposal.

> > MEMTXATTRS_UNSPECIFIED
> > ----------------------
> > 
> > MEMTXATTRS_UNSPECIFIED is another global variable. Since it is
> > immutable, BQL cell is not needed.
> > 
> > But MemTxAttrs is a structure with bitfields, and the bindings generated
> > by bindgen can only be modified through methods. Therefore, it is
> > necessary to introduce lazy to initialize MEMTXATTRS_UNSPECIFIED in a
> > const context (patch 6).
> 
> Ugh, that's a pity.  Maybe instead of introducing a new dependency we can
> use an always-inlined function?

Based your and Richard's suggestion, modifying memattrs avoids
introducing additional library. :-)

> In an ideal world, bindgen would produce const functions.  A hackish but
> easy possibility is to modify the generated bindgen code (with sed? :)) to
> apply const to the bitfield functions.

I think it could work, and this time it won't be needed, based on your
newer suggestion. :-)

> > Then, I chose NonNull to address this issue, as recommended by the
> > author of NonNull and the standard collections [3].
> 
> NonNull is okay for now.  Later on we will handle it with pinned_init.
> 
> However, do not get a &mut HPETState, everything should go through
> &HPETState and cells.

Sure. I see.

> > Therefore, I believe that in Rust devices, QOM members should also be
> > kept private or at most `pub(crate)`. This is also why I tried to avoid
> > using direct `pub` in HPET.
> 
> Yes, I agree.  I should look at unnecessarily pub things in pl011.

Thank you!

Regards,
Zhao


