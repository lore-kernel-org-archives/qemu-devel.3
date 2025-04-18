Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DBFC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 09:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5hxf-0000Tx-8J; Fri, 18 Apr 2025 05:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u5hxb-0000TW-PY
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:24:36 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u5hxY-0007IR-Kw
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744968272; x=1776504272;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qYJAyc56RRNcyVqCRpCLPzF9Uu8IzObtsWkaZLt/Zso=;
 b=bihTdfDaAsR5sbzQTmHxhOjZctmJLf4+7/T8yrVE0KAYNGaIiRVmQNvA
 0oqR86tIZdq5VUP8tA/o00ue2SKCneYwcT5c5Hl7k7w7tOq/9ZluxUN+i
 vpBWIaJFZJLDeIDj13bOvY+ilguVHXdxIoRLjfS4psKZWl9ZvUEhbHOyB
 U60CmCqe8DRl8u6DvWCXGzf8U6LavdYG4KN1S9ZQPudSt69QwWuJwvxUE
 wFwhY2ZrowtrjvZRbS8UaP8WKatXq+xf8VTKsM2/GJVf4TIWHmj1ZHzWi
 HOd9fyHg259hkFcCMRX2fdB65q4xSHS/87FS8MWerJKjgBkl5SVZjQqJK Q==;
X-CSE-ConnectionGUID: 4qs5ELy9S7GiMXudW6UZ5A==
X-CSE-MsgGUID: CbT+bNZrRBGOTYe7n5gZkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46693673"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="46693673"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 02:24:29 -0700
X-CSE-ConnectionGUID: gP5e/aX9T/axou0jNsxzog==
X-CSE-MsgGUID: zIaGsJglSIifSCu2tAQ2lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="130937851"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 18 Apr 2025 02:24:26 -0700
Date: Fri, 18 Apr 2025 17:45:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 06/55] i386/tdx: Introduce is_tdx_vm() helper and
 cache tdx_guest object
Message-ID: <aAIfL0jS0lWSpvZE@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-7-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-7-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:16AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:16 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 06/55] i386/tdx: Introduce is_tdx_vm() helper and cache
>  tdx_guest object
> X-Mailer: git-send-email 2.34.1
> 
> It will need special handling for TDX VMs all around the QEMU.
> Introduce is_tdx_vm() helper to query if it's a TDX VM.
> 
> Cache tdx_guest object thus no need to cast from ms->cgs every time.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
> changes in v3:
> - replace object_dynamic_cast with TDX_GUEST();
> ---
>  target/i386/kvm/tdx.c | 15 ++++++++++++++-
>  target/i386/kvm/tdx.h | 10 ++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index c67be5e618e2..16f67e18ae78 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -18,8 +18,16 @@
>  #include "kvm_i386.h"
>  #include "tdx.h"
>  
> +static TdxGuest *tdx_guest;
> +
>  static struct kvm_tdx_capabilities *tdx_caps;
>  
> +/* Valid after kvm_arch_init()->confidential_guest_kvm_init()->tdx_kvm_init() */
> +bool is_tdx_vm(void)
> +{
> +    return !!tdx_guest;
> +}
> +
>  enum tdx_ioctl_level {
>      TDX_VM_IOCTL,
>      TDX_VCPU_IOCTL,
> @@ -117,15 +125,20 @@ static int get_tdx_capabilities(Error **errp)
>  
>  static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>  {
> +    TdxGuest *tdx = TDX_GUEST(cgs);
>      int r = 0;
>  
>      kvm_mark_guest_state_protected();
>  
>      if (!tdx_caps) {
>          r = get_tdx_capabilities(errp);
> +        if (r) {
> +            return r;
> +        }
>      }
>  
> -    return r;
> +    tdx_guest = tdx;
> +    return 0;
>  }
>  
>  static int tdx_kvm_type(X86ConfidentialGuest *cg)
> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> index f3b725336161..de8ae9196163 100644
> --- a/target/i386/kvm/tdx.h
> +++ b/target/i386/kvm/tdx.h
> @@ -3,6 +3,10 @@
>  #ifndef QEMU_I386_TDX_H
>  #define QEMU_I386_TDX_H
>  
> +#ifndef CONFIG_USER_ONLY
> +#include CONFIG_DEVICES /* CONFIG_TDX */
> +#endif
> +
>  #include "confidential-guest.h"
>  
>  #define TYPE_TDX_GUEST "tdx-guest"
> @@ -18,4 +22,10 @@ typedef struct TdxGuest {
>      uint64_t attributes;    /* TD attributes */
>  } TdxGuest;
>  
> +#ifdef CONFIG_TDX
> +bool is_tdx_vm(void);
> +#else
> +#define is_tdx_vm() 0
> +#endif /* CONFIG_TDX */
> +
 
a little nit: could we rename it as "tdx_enabled"?

Then the cases like these would be neater?

if (sev_enabled() || is_tdx_vm()) {
    ...
}


if (sev_enabled()) {
    ...
} else if (is_tdx_vm()) {
    ...
}

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks,
Zhao



