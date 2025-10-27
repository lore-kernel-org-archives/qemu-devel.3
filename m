Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4967CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDI4w-0000a6-Po; Mon, 27 Oct 2025 03:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDI4u-0000Zq-Uq
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:55:44 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDI4r-00035b-FC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761551742; x=1793087742;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+DmA6Q7WFPzw9l5wvDnH1+6RV6lxoIKWZ+xLgKgY3Lk=;
 b=IYq5hAWvaTT5nZjkL6CQ14SyVLrv4O122Jo+H3cQc41x8VvNg154QiUd
 ujFZTOoaoOfFgAXi8wyKLVlEnx6BNWRnIFdNs8G8AZ4RB5gUZGV7ybQpl
 ehp/yibjSWvVL6rRlCpBmWUyiK6d/AYSgVpfgragl3DSVwKLxbD/JiqqS
 QkidVGD3HbPUdnymvy+b5t8Y657gz0fY7GhO8Bx3AHotwxNRyzyIx712/
 33QqQIZslJut8SJO4C45UXVUT5/cdoYN0dj+XxDmzdBUv8sEMfW5FtfqH
 L94/qcmN/08o6OfeMHzaGQawclmbb9+W3ufBffneoh8cUGpfPGTxwYFGv A==;
X-CSE-ConnectionGUID: VEV8q6yUT5+fRKtpzWqk6g==
X-CSE-MsgGUID: jhzKagh7Rm+0d4hijpiRaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74300767"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="74300767"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 00:55:39 -0700
X-CSE-ConnectionGUID: ddJKyeCHRxy8nq5AQvFdmw==
X-CSE-MsgGUID: L6Go9rnpTFCKeoqysnorHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184594393"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 00:55:35 -0700
Message-ID: <5d501d23-74d3-45aa-a51e-52ef59002e1a@intel.com>
Date: Mon, 27 Oct 2025 15:55:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/20] i386/cpu: Fix supervisor xstate initialization
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-10-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-10-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.57, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/2025 2:56 PM, Zhao Liu wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> Arch lbr is a supervisor xstate, but its area is not covered in
> x86_cpu_init_xsave().
> 
> Fix it by checking supported xss bitmap.
> 
> In addition, drop the (uint64_t) type casts for supported_xcr0 since
> x86_cpu_get_supported_feature_word() returns uint64_t so that the cast
> is not needed. Then ensure line length is within 90 characters.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/cpu.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5cd335bb5574..1917376dbea9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9707,20 +9707,23 @@ static void x86_cpu_post_initfn(Object *obj)
>   static void x86_cpu_init_xsave(void)
>   {
>       static bool first = true;
> -    uint64_t supported_xcr0;
> +    uint64_t supported_xcr0, supported_xss;
>       int i;
>   
>       if (first) {
>           first = false;
>   
>           supported_xcr0 =
> -            ((uint64_t) x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32) |
> +            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) |

missing the "<< 32" here,

with it fixed,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

>               x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_LO);
> +        supported_xss =
> +            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XSS_HI) << 32 |
> +            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XSS_LO);
>   
>           for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
>               ExtSaveArea *esa = &x86_ext_save_areas[i];
>   
> -            if (!(supported_xcr0 & (1 << i))) {
> +            if (!((supported_xcr0 | supported_xss) & (1 << i))) {
>                   esa->size = 0;
>               }
>           }


