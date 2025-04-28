Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C0EC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 14:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9PeZ-0007Fz-Ke; Mon, 28 Apr 2025 10:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9PeX-0007Ac-TH
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:40:13 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9PeT-0002Tw-Tl
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745851210; x=1777387210;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DeslzjFj4oUZfNk/9jJ9RVucP7go/HD+Uahnw/nw6MU=;
 b=STh42BAc+qDvfRNPcoJVw/zegFuvJKFlE0v2nahF4D1vNtFqN6+hT0KC
 3uiOjnk032fXvlYShFwb5w2tlKF03lbRnndkYdteryYjpo2/l5Zg808NJ
 OiDjceEJ8usRGGdCc/f3PLS4oC2bEK9ged+aB3qRIrFRfl8ijwQsLbeul
 WiUxzAcPaN6wtFgeBS4kTcUKBqTRKztPQOxtebFt9zSUPrVb9vGV84KoJ
 Y+h1aB5bVejnsg/4YxvUIPl3tCL+3vcmYdtj1pMX+uR5LHYYhcSaVt4Rc
 oSVXLXA9RsK2yTiPTXibcxPa4fI8oXXis8lTV8B5wUoNpzlfBol+EjhPH Q==;
X-CSE-ConnectionGUID: 8jLbnoYHRVSR/p/Ix91PJw==
X-CSE-MsgGUID: E1+mgYXKSSSkJADGDY3JJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47150848"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="47150848"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 07:40:02 -0700
X-CSE-ConnectionGUID: cGnTPm0pS3WOSP0NMz2Tyg==
X-CSE-MsgGUID: zBjOIq7fTKCNrEe32wrSjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="137586296"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 28 Apr 2025 07:39:58 -0700
Date: Mon, 28 Apr 2025 23:00:56 +0800
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
Subject: Re: [PATCH v8 28/55] i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
Message-ID: <aA+YKOdDq+62U2dR@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-29-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-29-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Tue, Apr 01, 2025 at 09:01:38AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:38 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 28/55] i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
> X-Mailer: git-send-email 2.34.1
> 
> TD guest can use TDG.VP.VMCALL<REPORT_FATAL_ERROR> to request
> termination. KVM translates such request into KVM_EXIT_SYSTEM_EVENT with
> type of KVM_SYSTEM_EVENT_TDX_FATAL.
> 
> Add hanlder for such exit. Parse and print the error message, and
> terminate the TD guest in the handler.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v8:
>  - update to the new data ABI of KVM_SYSTEM_EVENT_TDX_FATAL;
> 
> Changes in v6:
>  - replace the patch " i386/tdx: Handle TDG.VP.VMCALL<REPORT_FATAL_ERROR>"
>    in v5;
> ---
>  target/i386/kvm/kvm.c      | 10 +++++++++
>  target/i386/kvm/tdx-stub.c |  5 +++++
>  target/i386/kvm/tdx.c      | 45 ++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.h      |  2 ++
>  4 files changed, 62 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 7de5014051eb..a76f34537908 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -6128,6 +6128,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>      case KVM_EXIT_HYPERCALL:
>          ret = kvm_handle_hypercall(run);
>          break;
> +    case KVM_EXIT_SYSTEM_EVENT:
> +        switch (run->system_event.type) {
> +        case KVM_SYSTEM_EVENT_TDX_FATAL:
> +            ret = tdx_handle_report_fatal_error(cpu, run);
> +            break;
> +        default:
> +            ret = -1;
> +            break;
> +        }
> +        break;
>      default:
>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
>          ret = -1;
> diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
> index 7748b6d0a446..720a4ff046ee 100644
> --- a/target/i386/kvm/tdx-stub.c
> +++ b/target/i386/kvm/tdx-stub.c
> @@ -13,3 +13,8 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
>  {
>      return -EINVAL;
>  }
> +
> +int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
> +{
> +    return -EINVAL;
> +}
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index f8953f598584..74b7e3ac85fe 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -607,6 +607,51 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
>      return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
>  }
>  
> +int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
> +{
> +    uint64_t error_code = run->system_event.data[R_R12];
> +    uint64_t reg_mask = run->system_event.data[R_ECX];
> +    char *message = NULL;
> +    uint64_t *tmp;
> +
> +    if (error_code & 0xffff) {
> +        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%lx",
> +                     error_code);
> +        return -1;
> +    }
> +
> +/*
> + * Only 8 registers can contain valid ASCII byte stream to form the fatal
> + * message, and their sequence is: R14, R15, RBX, RDI, RSI, R8, R9, RDX
> + */
> +#define TDX_FATAL_MESSAGE_MAX        64

At least, for this macro, and TDX_REPORT_FATAL_ERROR_GPA_VALID in later
patch, could we move these simple macro definitions out of the function?

This could improve the readability for this one function.

> +    if (reg_mask) {
> +        message = g_malloc0(TDX_FATAL_MESSAGE_MAX + 1);
> +        tmp = (uint64_t *)message;
> +
> +#define COPY_REG(REG)                               \
> +    do {                                            \
> +        if (reg_mask & BIT_ULL(REG)) {              \
> +            *(tmp++) = run->system_event.data[REG]; \
> +        }                                           \
> +    } while (0)
> +
> +        COPY_REG(R_R14);
> +        COPY_REG(R_R15);
> +        COPY_REG(R_EBX);
> +        COPY_REG(R_EDI);
> +        COPY_REG(R_ESI);
> +        COPY_REG(R_R8);
> +        COPY_REG(R_R9);
> +        COPY_REG(R_EDX);
> +        *((char *)tmp) = '\0';
> +    }
> +#undef COPY_REG
> +
> +    error_report("TD guest reports fatal error. %s", message ? : "");
> +    return -1;
> +}
> +

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


