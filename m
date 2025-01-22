Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894A6C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 12:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZco-000679-0Z; Wed, 22 Jan 2025 07:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taZcj-00062W-8n; Wed, 22 Jan 2025 07:14:21 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taZcg-0000fb-7a; Wed, 22 Jan 2025 07:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737548058; x=1769084058;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=p/MEDBHQJ56AH0MsVuiWC0F2edG1GENGkpR5CUKIRac=;
 b=DC0YeActwjr6CGkNoQdEXEoO2IMWExC0fhBWm0z0y8n3jA7IOEQNsokI
 r3xX1ExNRIaSO61XrM/vP93lNZFbyC9G1tfTwPWR+gH2eRZVENLRbpmHq
 bp1vZ2e6ufRiDlDd1AvcerA6Dnom1fMBx2T7tPujdmKw19IprnvxuZC+q
 4y0zhuL97PceW0+n0XeGpJBM/lvjLQ3S51Tvab2IfnAKzH4UEGARqBSuy
 1AuCagf9HePk7cDn0uBkoGeOC5OVMFGmihS65nHsUvxzLfKaw0Y2UaE/F
 VKFZSrPZ1Tw9OnIw32auM+OSraCd8OkhICjjNUywNP1Zj04w/1iTbUdkO g==;
X-CSE-ConnectionGUID: RuEei4hKROykgR0itjku1w==
X-CSE-MsgGUID: COY3TeQYSB2on8sEAgROxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37211821"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="37211821"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 04:14:14 -0800
X-CSE-ConnectionGUID: spvVcfSYTlGtK4JbZ2Hoow==
X-CSE-MsgGUID: xrUxPDnySvq67xNPURIq/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111764691"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 22 Jan 2025 04:14:12 -0800
Date: Wed, 22 Jan 2025 20:33:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 05/10] rust: vmstate: implement VMState for scalar types
Message-ID: <Z5DlngFjERVqmxca@intel.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
 <20250117090046.1045010-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117090046.1045010-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Jan 17, 2025 at 10:00:41AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:00:41 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/10] rust: vmstate: implement VMState for scalar types
> X-Mailer: git-send-email 2.47.1
> 
> Scalar types are those that have their own VMStateInfo.  This poses
> a problem in that references to VMStateInfo can only be included in
> associated consts starting with Rust 1.83.0, when the const_refs_static
> was stabilized.  Removing the requirement is done by placing a limited
> list of VMStateInfos in an enum, and going from enum to &VMStateInfo
> only when building the VMStateField.
> 
> The same thing cannot be done with VMS_STRUCT because the set of
> VMStateDescriptions extends to structs defined by the devices.
> Therefore, structs and cells cannot yet use vmstate_of!.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 128 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 2 deletions(-)


>  /// Internal utility function to retrieve a type's `VMStateField`;
>  /// used by [`vmstate_of!`](crate::vmstate_of).
>  pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
> @@ -99,6 +178,15 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateField
>  /// Return the `VMStateField` for a field of a struct.  The field must be
>  /// visible in the current scope.
>  ///
> +/// Only a limited set of types is supported out of the box:
> +/// * scalar types (integer and `bool`)
> +/// * the C struct `QEMUTimer`
> +/// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
> +///   [`BqlCell`](crate::cell::BqlCell), [`BqlRefCell`](crate::cell::BqlRefCell)
> +/// * a raw pointer to any of the above
> +/// * a `NonNull` pointer to any of the above, possibly wrapped with `Option`

I just found your rust-next has already updated and removed `Option` :-)

> +/// * an array of any of the above
> +///
>  /// In order to support other types, the trait `VMState` must be implemented
>  /// for them.
>  #[macro_export]
> @@ -109,8 +197,14 @@ macro_rules! vmstate_of {
>                  .as_bytes()
>                  .as_ptr() as *const ::std::os::raw::c_char,
>              offset: $crate::offset_of!($struct_name, $field_name),
> -            // Compute most of the VMStateField from the type of the field.

Rebase mistake? This comment seems no need to be deleted.

>              $(.num_offset: $crate::offset_of!($struct_name, $num),)?
> +            // The calls to `call_func_with_field!` are the magic that
> +            // computes most of the VMStateField from the type of the field.
> +            info: $crate::info_enum_to_ref!($crate::call_func_with_field!(
> +                $crate::vmstate::vmstate_scalar_type,
> +                $struct_name,
> +                $field_name
> +            )),
>

Only a nit above,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


