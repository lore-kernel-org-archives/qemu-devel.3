Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15652CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gmh-00028e-Bn; Tue, 14 Oct 2025 11:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8gme-000287-KK; Tue, 14 Oct 2025 11:17:52 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8gma-0006U2-BN; Tue, 14 Oct 2025 11:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760455068; x=1791991068;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+QtHRQ6oWS3RVcVguLBinTUwEH/gTU7AL+1AOC8GzA4=;
 b=lRsNGGELeMSGe45UzHAvm8ou9pjjALSfozzL0Q2aMd4G7NdIt36L2zxE
 7MNYWwHpA7vzCKgpnuj1NtTFSX82q8V873ZQ2nAhu9u7CT4OfHNCn6+1O
 pNvGizcurawxnF4Eep1fKK5OtfpXr/i5WbEkvmX5T8A97gIZAR4RFos40
 PKkev5nRyWOtVlqlQskTvHZ13wcbCLtXPfaiGgn3k1ByFLvaf0LC/eyjS
 3JWbSGftWFDPkUgehajMrZjcpwzr5xI4weuLodOshfwljKrXdt/BHD0pc
 E99ctmO3hwRJwDvCBSZ+eExiz3wxye6EI1Fsr5PKg9Kg3e6box5N5P1Cm Q==;
X-CSE-ConnectionGUID: FzXsZD+1TgyepNe5XbiHAQ==
X-CSE-MsgGUID: F3pY7HgnRlyOLRBurfINSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66444690"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="66444690"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 08:17:40 -0700
X-CSE-ConnectionGUID: z61vCBn7Q3KC5vEH5QTWAQ==
X-CSE-MsgGUID: nDHMKyi1ThKQlYbgXtLpKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="187213910"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 14 Oct 2025 08:17:38 -0700
Date: Tue, 14 Oct 2025 23:39:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust/qemu-macros: Convert bit value to u8 within
 #[property]
Message-ID: <aO5uwJnKqSJAlioY@intel.com>
References: <20251014150251.2473680-1-zhao1.liu@intel.com>
 <0d7741c3-2ffb-4076-8baa-864a83197805@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7741c3-2ffb-4076-8baa-864a83197805@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

On Tue, Oct 14, 2025 at 05:09:34PM +0200, Paolo Bonzini wrote:
> Date: Tue, 14 Oct 2025 17:09:34 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH] rust/qemu-macros: Convert bit value to u8 within
>  #[property]
> 
> On 10/14/25 17:02, Zhao Liu wrote:
> > diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
> > index 3e21b67b4719..2a7454da2416 100644
> > --- a/rust/qemu-macros/src/lib.rs
> > +++ b/rust/qemu-macros/src/lib.rs
> > @@ -271,7 +271,10 @@ macro_rules! str_to_c_str {
> >                   name: ::std::ffi::CStr::as_ptr(#prop_name),
> >                   info: #qdev_prop,
> >                   offset: ::core::mem::offset_of!(#name, #field_name) as isize,
> > -                bitnr: #bitnr,
> > +                bitnr: {
> > +                    const { assert!(#bitnr >= 0 && #bitnr <= u8::MAX as _, "bit exceeds u8 range"); }
> 
> The check for the upper limit must be "#bitnr < $field_ty::BITS as _", for
> example rejecting 32 for an u32 field.

Yes, good point, MAX is not enough.

> Also, the tests need to be updated.

Will do.

Regards,
Zhao


