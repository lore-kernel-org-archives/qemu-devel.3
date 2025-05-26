Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9947C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 03:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJODT-0003vN-EW; Sun, 25 May 2025 23:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uJODR-0003ul-9x
 for qemu-devel@nongnu.org; Sun, 25 May 2025 23:09:29 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uJODO-0001LK-9G
 for qemu-devel@nongnu.org; Sun, 25 May 2025 23:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748228966; x=1779764966;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GNYUYChJQ3Bf0DnmPH2uUL5SAbO4mvyjoAHW5/27eTg=;
 b=MFI3/1EPU+aDXAJEjym6e3MqysErn9Ai8dtk7RWxZTa0oAFPsrRuCnTU
 FrsRGgpMivrShn8EbCs8tYoy8t5aIgNn+F4EOCKsuYlZXeWqvavzdPmII
 CR4UCGllLuYMyfbvdQdFYp4eHJm9wLnhf74BRQv8KsCSj/mE3VIq6geM3
 HnNj5zWYIJIgsz3X9aJWGsAB0DrmwytT9bwQXcBF8//gL1UFHqh+dGKt+
 Nv3DIGQYHhU5wL8B5Yd2SoZB11FnJixnEjhmuFIQhQ6R65vsH/T+nSjzQ
 bumVooZc6YgAldOP+O+HJ3MtuvAAEExuucch1iM9Tw/gR9X7l1hJfXjxi Q==;
X-CSE-ConnectionGUID: OVh6z99NQg2xgnKcHrlFYQ==
X-CSE-MsgGUID: E1kO/ru9TlSfjH8TO6FeUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="75587690"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="75587690"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2025 20:09:18 -0700
X-CSE-ConnectionGUID: 08ps3TOGR5aXFR0YUOn1OA==
X-CSE-MsgGUID: EhMiBlXRScio3yA7m6jzFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="173085434"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2025 20:09:15 -0700
Message-ID: <0ab6350b-d8d7-4bf3-96ab-868ccbeba2ae@intel.com>
Date: Mon, 26 May 2025 11:09:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] target/i386: Remove FRED dependency on WRMSRNS
To: "Xin Li (Intel)" <xin@zytor.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xin3.li@intel.com
References: <20250103084827.1820007-1-xin@zytor.com>
 <20250103084827.1820007-2-xin@zytor.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250103084827.1820007-2-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 1/3/2025 4:48 PM, Xin Li (Intel) wrote:
> WRMSRNS doesn't become a required feature for FERD, and Linux has
> removed the dependency, as such remove it from Qemu.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0b639848cd..8a1223acb3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1771,10 +1771,6 @@ static FeatureDep feature_dependencies[] = {
>           .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
>           .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
>       },
> -    {
> -        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
> -        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
> -    },
>       {
>           .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
>           .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_SGX_LC },


