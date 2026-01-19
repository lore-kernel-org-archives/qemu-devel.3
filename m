Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE38C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 01:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vheN0-0006dk-Pd; Sun, 18 Jan 2026 20:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vheMx-0006a8-4o
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:47:51 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vheMu-0007fn-Cp
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768787268; x=1800323268;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5sXjbnnMJ6gQVd2D/+RSqklYdAvGFuLASzaMCw7XAjs=;
 b=gcS6Fbt791HgeI+pm4RtybdsBCJxbmeGc76WTlZo5QEuILYWE8hi+mTU
 zO5Y0U5yhvrNPe1cZL5UxbY9kQaArrONHTVOrO+VogbqaPGoHLKjjmrSR
 oWWx+z9yrN57UhOuCrmTA+EB2yAgKvu0HApWaN8QNqlO3N54LJ7UziSyi
 AF3oqo+RqtYnGaklWksBWUY5HhfTo5rekmRyCjUMYUbyv7q+XDusbpifB
 PlXiOckAM+u5lFTm6SBNsfnTUugJs4lTu3BNf3044bDGvyLE81rnyx0Jd
 DwuYXm0fJ2Rrt+b8lGECB0sRisQjDq1ou1XXKJM8j2G3cGQOUF8prHlOb Q==;
X-CSE-ConnectionGUID: fqOIzyxOTdmGuHRo3NOY3g==
X-CSE-MsgGUID: dB203acgRBmtD/58wycDuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="80719571"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="80719571"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2026 17:47:44 -0800
X-CSE-ConnectionGUID: W3OTvNw+R5OYEIx5fhQh7Q==
X-CSE-MsgGUID: bZCKTQSMSWKLe2i1c/5Nww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="205798066"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14])
 ([10.124.240.14])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2026 17:47:41 -0800
Message-ID: <d3be3cd0-5dce-4410-b2f8-e137562a678c@linux.intel.com>
Date: Mon, 19 Jan 2026 09:47:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] target/i386: Disable unsupported BTS for guest
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: xiaoyao.li@intel.com, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260117011053.80723-1-zide.chen@intel.com>
 <20260117011053.80723-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260117011053.80723-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 1/17/2026 9:10 AM, Zide Chen wrote:
> BTS (Branch Trace Store), enumerated by IA32_MISC_ENABLE.BTS_UNAVAILABLE
> (bit 11), is deprecated and has been superseded by LBR and Intel PT.
>
> KVM yields control of the above mentioned bit to userspace since KVM
> commit 9fc222967a39 ("KVM: x86: Give host userspace full control of
> MSR_IA32_MISC_ENABLES").
>
> However, QEMU does not set this bit, which allows guests to write the
> BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
> this may lead to unexpected MSR access errors.
>
> Setting this bit does not introduce migration compatibility issues, so
> the VMState version_id is not bumped.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  target/i386/cpu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 2bbc977d9088..f2b79a8bf1dc 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -474,7 +474,10 @@ typedef enum X86Seg {
>  
>  #define MSR_IA32_MISC_ENABLE            0x1a0
>  /* Indicates good rep/movs microcode on some processors: */
> -#define MSR_IA32_MISC_ENABLE_DEFAULT    1
> +#define MSR_IA32_MISC_ENABLE_FASTSTRING    1

To keep the same code style and make users clearly know the macro is a
bitmask, better define MSR_IA32_MISC_ENABLE_FASTSTRING like below.

#define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)


> +#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
> +#define MSR_IA32_MISC_ENABLE_DEFAULT       (MSR_IA32_MISC_ENABLE_FASTSTRING     |\
> +                                            MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)

Better move the macro "MSR_IA32_MISC_ENABLE_DEFAULT" after
"MSR_IA32_MISC_ENABLE_MWAIT".


>  #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
>  
>  #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))

