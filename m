Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE3606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PKkk/ohA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVL0q-0006dg-5C; Sun, 22 Nov 2026 22:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVL0n-0006d3-28; Sun, 22 Nov 2026 22:46:37 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVL0l-000499-5y; Sun, 22 Nov 2026 22:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795405595; x=1826941595;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MxhI9XGoDjKEUrdSw53qjylUm8rilkDJEiY6OyiadrY=;
 b=PKkk/ohAh3szWeoIRO7fIo088XdgW5v7h/bbw1tcqVPdWPaIgx6oSqMI
 L1y/E9ofkzbtFPKUhktYx3aMFnuorwtXlgL8CyebScQSfrF64AH9SN4Tu
 WIIaW3NsZ2FyxKBsYnRBIk1E7yNnR5sq9cZaqoLxSs/W3opqDGXXJdSoP
 pDs6lnFSUxEoWmkQjm34GkvrZQJ5pbY09XhAsODipTs+CRI/L0Fslf2cx
 If9xH4rRAPpnnuziQ6vjZ3X7yyYVWltGjW6PTQtd8EKjGHPLltt0CLvCk
 jMBHSIf83SUWcJ5ZigCZ2nKugQKuJ4nx4U6zq2auDyo9W76FMUe4ndDdx Q==;
X-CSE-ConnectionGUID: 0MfxQd1vROeC9uXthbCv6w==
X-CSE-MsgGUID: p9ZVcImXT5KZxw0QqjeHjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4303757"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4303757"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 19:46:29 -0800
X-CSE-ConnectionGUID: yD7WmAhNTqiKfK/P1b/xjA==
X-CSE-MsgGUID: mSqLIcKIQrCCsQywvZIMcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11557433"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa009.fm.intel.com with ESMTP; 22 Nov 2026 19:46:28 -0800
Date: Mon, 23 Nov 2026 11:46:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH for-12.0 5/6] rust: Replace vmstate_validate with post_load
Message-ID: <awO3EjQI/8QJsyZ9@intel.com>
References: <20261120124923.1656220-1-peterx@redhat.com>
 <20261120124923.1656220-6-peterx@redhat.com>
 <awBYUwFhba1AYpZb@intel.com>
 <awBqoiy3zjHiXXEG@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awBqoiy3zjHiXXEG@zhexu-thinkpadt14gen5.rmtcaon.csb>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > And I find C side (in patch 3) handles this differently via using the local
> > "num_timers".
> > 
> > In this case, I think we still have the option to keep the logic
> > consistent between C and Rust :). We can add VMSTATE_STRUCT_VARRAY_TEST
> > for C side:
> > 
> > #define VMSTATE_STRUCT_VARRAY_TEST(_field, _state, _field_num, _test,\
> >                                    _version, _vmsd, _type) {\
> >     .name         = (stringify(_field)),\
> >     .num_indirect = vmstate_field_offset(_state, _field_num),\
> >     .version_id   = (_version),\
> >     .field_exists = (_test),\
> >     .vmsd         = &(_vmsd),\
> >     .size         = sizeof(_type),\
> >     .flags        = VMS_STRUCT | VMS_VARRAY,\
> >     .offset       = vmstate_offset_varray(_state, _field, _type),\
> > }
> > 
> > and make C hpet use this:
> > 
> >         VMSTATE_STRUCT_VARRAY_TEST(timer, HPETState, num_timers_save,
> >                                    hpet_validate_num_timers, 0,
> >                                    vmstate_hpet_timer, HPETTimer),
> 
> One thing to mention is, here the test() function is not for validation,
> but for checking if the field exists.
> 
> It means, assuming dest QEMU has num_timers=8, source QEMU has
> num_timers=4, when migration happens with your VARRAY_TEST(), it won't
> sanity check it, but since it saw 4!=8 it will assume the whole VARRAY
> doesn't exist.
> 
> That's one reason why I want to get rid of VALIDATE(), because it's abusing
> field_exist() IMO, and we don't necessarily need such abuse when we have
> post_load.

I see, this makes sense.

> > 
> > Alternatively, we can also have Rust use num_timers (as u8) for timers
> > array VMState, but this will bring back the conversion issue between u8
> > and usize, which is the commit b3bf86b8936d & 6e85cfe44c0e want to fix...
> 
> Ohhh, I decided to not dig into this part. May I make a request instead? :)

Happy to help :-)

> Could you help me to come up with a Rust patch that does what's needed for
> this series to drop VALIDATE and VMS_MUST_EXIST and replace this one (drop
> my Author), meanwhile matches the best you'd like to?  It'll be much easier
> to me then because my Rust is rust (this is not strict; it never shined),
> so I can just pick it up when repost.

I find it's possible to use num_timers directly without going back to
u8 type. Since the commit 1f0b40dccfe5 ("migration: Remove redundant
flags"), C side has already dropped VMS_VARRAY_UINT8/16/32, so Rust
side can use usize as the array length type (without migrating it), like:

unsafe impl VMState for usize {
    const BASE: VMStateField = {
    	panic!("usize cannot be migrated, use a fixed-size integer type");
    };
    const VARRAY_FLAG: VMStateFlags = VMStateFlags::VMS_VARRAY;
}

I'll think more/cook a patch based on this approach.

Thanks,
Zhao


