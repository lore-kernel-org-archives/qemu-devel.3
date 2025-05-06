Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943DBC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCEhb-000188-1j; Tue, 06 May 2025 05:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCEhZ-00016o-8v; Tue, 06 May 2025 05:35:01 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCEhW-0004rz-PU; Tue, 06 May 2025 05:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746524099; x=1778060099;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5ogIJnNXRjWYW7z9hrcuT7Gtw6KPvfSnpHJBesyG/bg=;
 b=l/d7FCUJ0mAB4JFiN+K9bI6gjSP3oU7hUDNXwaD5lzLoY8B3KntNxv9j
 tbTIEB8FPJXHffyq5wwNbYFzN1xEnUiWr6c+Ceb3MnG0DxmDXLnUO2Fjb
 dhQk7X8ReURlmIosmhD0VtrDHMieUmlcGfYwm0oEs5UTOHtljemdQXJb4
 GRkGyXpGSXgklgHvzZ44R3SDXVb4lh3VOp/bV97ivc8XyxRr6xny6hy2f
 mn2r44CCGXOXQb1xh0WbdNr3FBsxT40MDMVl58slzR7RtvC8c7L/A12t7
 w6WzqfqMJp1UozO9RfAOFaBiyROT5gvoQdibWzQMoJGOJ1FTXtZGZegpm A==;
X-CSE-ConnectionGUID: vdHKrbuvRX2KuCIovMTprg==
X-CSE-MsgGUID: URkg05BVQ7az9L99NijUUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="52000273"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="52000273"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 02:34:55 -0700
X-CSE-ConnectionGUID: YMiDovw7SV+1NCTompHTvg==
X-CSE-MsgGUID: MtV5JdgLQqW7ujIBYgZexw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="136541118"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 06 May 2025 02:34:56 -0700
Date: Tue, 6 May 2025 17:55:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 3/5] rust: vmstate: convert to use builder pattern
Message-ID: <aBncq8KFTgzcT3jv@intel.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <20250505100854.73936-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505100854.73936-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

> +unsafe extern "C" fn vmstate_pre_load_cb<
> +    T,
> +    F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>,
> +>(
> +    opaque: *mut c_void,
> +) -> c_int {
> +    // SAFETY: assumes vmstate_struct! is used correctly
> +    let result = F::call((unsafe { &*(opaque.cast::<T>()) },));
> +    into_neg_errno(result)

Thanks! Now I see why you used io::ErrorKind.

> +}

...

> +    #[must_use]
> +    pub const fn pre_load<F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>>(
> +        mut self,
> +        _f: &F,
> +    ) -> Self {

Do we need to assert F is not ()?

const { assert!(F::IS_SOME) };

And I think all the other callbacks need to be checked as well.

> +        self.0.pre_load = Some(vmstate_pre_load_cb::<T, F>);
> +        self
> +    }

Thank you :-) ! And though it's a preview,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


