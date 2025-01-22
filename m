Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12994C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 01:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taPn2-0002x8-PK; Tue, 21 Jan 2025 20:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1taPmz-0002wt-La
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 20:44:17 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1taPmx-0005JY-Ox
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 20:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737510256; x=1769046256;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0B1jo/nuu9obrXXfNYQ7NtKVwrBLumjP4MCm7eZdql0=;
 b=gIfujk1pwRf/N+irt9DK/oQvSkGQXBIYJSFrSaSO/EsFVdUYKd3mmRq1
 qJksMwLykz+Sydvef3bKqFiDQmqfPz41AZ04QFgeePILKwohcL9e0ApBx
 j6SiILoHnLOC/ulJHrjRrdfcQsZJi/Lf6xsVFcrKKJ+Rgo2EvAmXBPbwW
 PeR9GagVKLZuR/nBo8yE/+xTNouL2DGvWwVcozEk3Ue6tUM/AU+R3ev2k
 kSfj8ASjyH8yFvCRzEhiSG5Gy9urcQlBtEIP6UC7Xqmr21f3rp4ngJcsZ
 o12GW2PUCHblRMw4HXksYwK+a3FljkkUKCUlA7wRYkM9nFKrbu4+hXcZ1 w==;
X-CSE-ConnectionGUID: X7oRLnxeSEy8MVtRm/X2jw==
X-CSE-MsgGUID: jeGvtXjtQwigTlu4v/qzcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38203925"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="38203925"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 17:44:12 -0800
X-CSE-ConnectionGUID: s1BcAjG+TN+z2GsJnBsN3g==
X-CSE-MsgGUID: DfIsWDbVQkWRD+PbjKmTeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="107590215"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 17:44:09 -0800
Message-ID: <c507cc1d-a858-4a2d-a45a-bd860a961b8f@intel.com>
Date: Wed, 22 Jan 2025 09:44:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/i386: Introduce SierraForest-v2 model
To: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, zhao1.liu@linux.intel.com,
 xuelian.guo@intel.com
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-2-tao1.su@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250121020650.1899618-2-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/21/2025 10:06 AM, Tao Su wrote:
> Update SierraForest CPU model to add LAM, 4 bits indicating certain bits
> of IA32_SPEC_CTR are supported(intel-psfd, ipred-ctrl, rrsba-ctrl,
> bhi-ctrl) and the missing features(ss, tsc-adjust, cldemote, movdiri,
> movdir64b)
> 
> Also add GDS-NO and RFDS-NO to indicate the related vulnerabilities are
> mitigated in stepping 3.
> 
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1b9c11022c..6db8d6c9ba 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4549,6 +4549,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>           .model_id = "Intel Xeon Processor (SierraForest)",
>           .versions = (X86CPUVersionDefinition[]) {
>               { .version = 1 },
> +            {
> +                .version = 2,
> +                .props = (PropValue[]) {
> +                    { "ss", "on" },
> +                    { "tsc-adjust", "on" },
> +                    { "cldemote", "on" },
> +                    { "movdiri", "on" },
> +                    { "movdir64b", "on" },
> +                    { "gds-no", "on" },
> +                    { "rfds-no", "on" },
> +                    { "lam", "on" },
> +                    { "intel-psfd", "on"},
> +                    { "ipred-ctrl", "on"},
> +                    { "rrsba-ctrl", "on"},
> +                    { "bhi-ctrl", "on"},
> +                    { "stepping", "3" },
> +                    { /* end of list */ }
> +                }
> +            },
>               { /* end of list */ },
>           },
>       },


