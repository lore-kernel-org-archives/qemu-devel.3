Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC7DE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2EY-0001Sa-RP; Tue, 10 Dec 2024 10:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2EC-0001KE-FM; Tue, 10 Dec 2024 10:32:50 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2EA-0000rI-C9; Tue, 10 Dec 2024 10:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733844766; x=1765380766;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lDfSvcdtU5wg9X7Z6lt3evGywYSTE29GME0kFIPv9v8=;
 b=IJVuJ98YpjlqLs79VS/o1JWwKkibpmXO3+TfaGZsZGPZjgxdx2mSdvC6
 FB62hSjg+rqy0CfvDhQAbrrdu80MhFLKP6K8rxM8Koe7yMyZR2nr5GzvT
 gZE8eawz6sag8GfrlW/GGI0bkkyVsz8sm8tFJxovlLaPy2PKzuJ+yDM2y
 rECOTs7O7cufhTKynqiQRzIcrkkuTmG0mCIfLNv/JBAfWmxazUfZ7oXQa
 EtrcVvmK0F0gGOfGcVYyQC0hacOzFjNOQNkYArXAvpGHtFmyc+2/sCwf8
 tLAXyuJhmsI44FDnZyyliqizns8AHEPq3iRwafo+mswyEeVbcYJrmCX9e Q==;
X-CSE-ConnectionGUID: 3isgrvsqQwWQ+9L7yAdc0g==
X-CSE-MsgGUID: KMxF2RlRQpKJpzw+dpumaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34247348"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="34247348"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 07:32:42 -0800
X-CSE-ConnectionGUID: gLeKG73aQMKYjrEL3JSG9Q==
X-CSE-MsgGUID: 0DfeerprRKuKemSgybFTfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="95147471"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 10 Dec 2024 07:32:41 -0800
Date: Tue, 10 Dec 2024 23:50:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 14/26] rust: qom: move bridge for TypeInfo functions out
 of pl011
Message-ID: <Z1hjX+5Yyi46N+sX@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-15-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Mon, Dec 09, 2024 at 01:37:05PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:05 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 14/26] rust: qom: move bridge for TypeInfo functions out of
>  pl011
> X-Mailer: git-send-email 2.47.1
> 
> Allow the ObjectImpl trait to expose Rust functions that avoid raw
> pointers (though INSTANCE_INIT for example is still unsafe).
> ObjectImpl::TYPE_INFO adds thunks around the functions in
> ObjectImpl.
> 
> While at it, document `TypeInfo`.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 40 +++++++--------------
>  rust/qemu-api/src/definitions.rs | 61 +++++++++++++++++++++++++++++---
>  2 files changed, 69 insertions(+), 32 deletions(-)
> 
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 56403c36609..b9f8fb134b5 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -110,7 +110,7 @@ impl ObjectImpl for PL011State {
>      type Class = PL011Class;
>      const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
>      const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
> -    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
> +    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);

No need to keep `unsafe` here?

> +///
> +/// - the struct must be `#[repr(C)]`
> +///
> +/// - `Class` and `TYPE` must match the data in the `TypeInfo` (this is
> +///   automatic if the class is defined via `ObjectImpl`).
> +///
> +/// - the first field of the struct must be of the instance struct corresponding
> +///   to the superclass declared as `PARENT_TYPE_NAME`
>  pub trait ObjectImpl: ClassInitImpl + Sized {
> +    /// The QOM class object corresponding to this struct.  Not used yet.
>      type Class;
> +
> +    /// The name of the type, which can be passed to `object_new()` to
> +    /// generate an instance of this type.
>      const TYPE_NAME: &'static CStr;
> +
> +    /// The parent of the type.  This should match the first field of
> +    /// the struct that implements `ObjectImpl`:
>      const PARENT_TYPE_NAME: Option<&'static CStr>;
> +
> +    /// Whether the object can be instantiated
>      const ABSTRACT: bool = false;
> -    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
> -    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
> +
> +    /// Function that is called to initialize an object.  The parent class will
> +    /// have already been initialized so the type is only responsible for
> +    /// initializing its own members.
> +    ///
> +    /// FIXME: The argument is not really a valid reference. `&mut
> +    /// MaybeUninit<Self>` would be a better description.
> +    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = None;

And here.

> +    /// Function that is called to finish initialization of an object, once
> +    /// `INSTANCE_INIT` functions have been called.
> +    const INSTANCE_POST_INIT: Option<fn(&mut Self)> = None;
>  

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


