Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B7CC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 11:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZpfy-0000fQ-7j; Thu, 10 Jul 2025 07:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZpfw-0008Vu-1A
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:42:52 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZpfp-0001D1-PT
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752147766; x=1783683766;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Sk1j57J69q0IvFrp7DYKBFZlqnAujqiuteNjVbjxTZ8=;
 b=AdWdbr76xCfKrA5+c3xCtctZ8s/lPm4FBUh4joxeId38q4K/86TbwsvA
 b0d51RvSmzPdwiZLFIQ/t8PXRw3jrIYWsr2HEseidPtISCsxCCbzuxI17
 d0nSMpp6R4PUa48JrogZ+i1yK5WcwPec+97f7EfpA01tpDt0tAy73oiyq
 HuHH+XqlYUu0ZSVRDoTWcQHXRhjgDjITPYQzCLFdN9jcsTGhDSxQEhB/9
 N3NHUyAoCvVtvaU3ZHN6uYSmX/dbF23LGlC6OQdwTlMXomyz79lFFD/vH
 IJ/WW5/5C3xvr0Pqzu7ZT4QzJlRYKVVyxihoQWZZe4WIZQRUyl5jr7cU8 A==;
X-CSE-ConnectionGUID: pR2kH3iJTtyqt8HMWj3VFQ==
X-CSE-MsgGUID: Enl2M9d9QMaNH7iK5tFDWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58231293"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="58231293"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 04:40:31 -0700
X-CSE-ConnectionGUID: Fku8nW1PReiXivgZwnasJQ==
X-CSE-MsgGUID: 7wiPrg/6RNyC08RmI1tXzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="161719679"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 04:40:28 -0700
Message-ID: <3b6c0344-0694-4a56-99dd-c7d437e43428@intel.com>
Date: Thu, 10 Jul 2025 19:40:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/tdx: Fix the report of gpa in QAPI
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, chao.p.peng@intel.com
References: <20250710035538.303136-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250710035538.303136-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
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

On 7/10/2025 11:55 AM, Zhenzhong Duan wrote:
> Gpa is defined in QAPI but never reported to monitor because has_gpa is
> never set to ture.
> 
> Fix it by setting has_gpa to ture when TDX_REPORT_FATAL_ERROR_GPA_VALID
> is set in error_code.

Hi Zhenzhong,

I would like to understand what the problem is without 
panic_info->u.tdx.has_gpa being set?

> Fixes: 6e250463b08b ("i386/tdx: Wire TDX_REPORT_FATAL_ERROR with GuestPanic facility")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   target/i386/kvm/tdx.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index e809e4b2df..370a9b6e65 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -1269,7 +1269,8 @@ void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
>   }
>   
>   static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
> -                                        char *message, uint64_t gpa)
> +                                        char *message, bool has_gpa,
> +                                        uint64_t gpa)
>   {
>       GuestPanicInformation *panic_info;
>   
> @@ -1278,6 +1279,7 @@ static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
>       panic_info->u.tdx.error_code = (uint32_t) error_code;
>       panic_info->u.tdx.message = message;
>       panic_info->u.tdx.gpa = gpa;
> +    panic_info->u.tdx.has_gpa = has_gpa;
>   
>       qemu_system_guest_panicked(panic_info);
>   }
> @@ -1297,6 +1299,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
>       char *message = NULL;
>       uint64_t *tmp;
>       uint64_t gpa = -1ull;
> +    bool has_gpa = false;
>   
>       if (error_code & 0xffff) {
>           error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%"PRIx64,
> @@ -1329,9 +1332,10 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
>   
>       if (error_code & TDX_REPORT_FATAL_ERROR_GPA_VALID) {
>           gpa = run->system_event.data[R_R13];
> +        has_gpa = true;
>       }
>   
> -    tdx_panicked_on_fatal_error(cpu, error_code, message, gpa);
> +    tdx_panicked_on_fatal_error(cpu, error_code, message, has_gpa, gpa);
>   
>       return -1;
>   }


