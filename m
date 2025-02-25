Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636B9C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmqIV-0001FP-IV; Tue, 25 Feb 2025 03:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqIR-0001Ei-Lm; Tue, 25 Feb 2025 03:28:07 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqIP-0005Ej-BC; Tue, 25 Feb 2025 03:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740472086; x=1772008086;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ypBnyjHK5BmToensLWhz1lncWac+k22jlQMcx1/9y9o=;
 b=mCQIdNTprzjAYoHzzoD6EMCLcZFtexWKp74SpK9bfK6XdfN6BDvFKAji
 WP1ApgRaUQHyBJsnfHVdRk8Wxt/JdgYFb3tIrm84GqSdYLPY8T3eQW6PS
 8DHImP4okFcN8gcVYiioAnsT0+kstzGYCwg4L4ynRUIl2jjButjiIlGON
 4njgxcIzpTl6vQk6AAn0E6KCarEplc1O4E/6k/l616nRaiQFUaN2yIe7K
 E6HkhxzQV8y3Zw7AwEu4UgLc/9aIrHD/6a9j9ndiNZoJikizcj1YnyfRP
 w47/7UY89X13amvgJo/ojr+vMVFEY1RISuwqgI3G7b/lyL3KmOMBC2qu0 g==;
X-CSE-ConnectionGUID: +Dv2DDKxT4qmJfdXehiVJw==
X-CSE-MsgGUID: InEr1FPsRwOvEQ/Jz41W4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40451904"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208,217";a="40451904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 00:28:00 -0800
X-CSE-ConnectionGUID: uKjO1oniRt2Cr46t0kZE/Q==
X-CSE-MsgGUID: sISh+4hlRK2rRfyLdpZEQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
 d="scan'208,217";a="121262009"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 25 Feb 2025 00:27:58 -0800
Date: Tue, 25 Feb 2025 16:47:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/15] rust: qom: wrap Object with Opaque<>
Message-ID: <Z72Dp8BJdmZrgcXK@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

> @@ -621,7 +629,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
>  /// We expect the FFI user of this function to pass a valid pointer that
>  /// can be downcasted to type `T`. We also expect the device is
>  /// readable/writeable from one thread at any time.
> -unsafe extern "C" fn rust_unparent_fn<T: ObjectImpl>(dev: *mut Object) {
> +unsafe extern "C" fn rust_unparent_fn<T: ObjectImpl>(dev: *mut bindings::Object) {
>      let state = NonNull::new(dev).unwrap().cast::<T>();
>      T::UNPARENT.unwrap()(unsafe { state.as_ref() });
>  }
> @@ -796,8 +804,9 @@ fn new() -> Owned<Self> {
>          // SAFETY: the object created by object_new is allocated on
>          // the heap and has a reference count of 1
>          unsafe {
> -            let obj = &*object_new(Self::TYPE_NAME.as_ptr());
> -            Owned::from_raw(obj.unsafe_cast::<Self>())
> +            let obj = object_new(Self::TYPE_NAME.as_ptr());

Having the same name is always not ideal, so let's name the first one raw_obj.

> +            let obj = Object::from_raw(obj).unsafe_cast::<Self>();
> +            Owned::from_raw(obj)
>          }
>      }
>  }

Others look good to me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 

