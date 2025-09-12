Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC02CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 05:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwwo1-0001Fm-Uv; Fri, 12 Sep 2025 01:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwnr-00018K-Eq
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:58:36 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwnp-0003rb-SQ
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757656714; x=1789192714;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hAp5E8q3JRPpm/pbTjfnejaXZNpz/9zFv79frd5g7xI=;
 b=W2kWjvrRFDvcw5Vs2wNMGyc8o8BNsnu1iP9RASsWJdsX2CeaK0xr1gQT
 vCb3t8sRc0YkK+pVxRF7Y0sCVRF5Oc9qjYOAy+Aj6uFlW7uS/OebZ8phv
 yosd4j3HsTK/72Ldbaok1wcVijbU0FEQv9+babQapVn1pDNjPGgRK6Oby
 ggYi7WHPcIiV3pl6xm6cNAMfaqAZUHpUeS8KPadkvwdTLeaM1eWPG5gyw
 84OLzKeD38ZtY6+ozGprumv9E/9GSd6GBpA/Iy70tedP4MpBMJ72HvmPK
 8F4TJQoBUWj508FQXT1trmsiHUodUmq7pdNtiP7xP/eRk3+kaXsmRbR3n A==;
X-CSE-ConnectionGUID: 4s54m22lSu+9bF3d4rVMxA==
X-CSE-MsgGUID: Twqnz8b9T7OtoL76+c/sJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59695283"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="59695283"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:58:32 -0700
X-CSE-ConnectionGUID: 2YTS9IaTT2C1UyDwCK3TVA==
X-CSE-MsgGUID: wzvbxMJrSpO6nG6fwjyO9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="174272820"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:58:31 -0700
Message-ID: <d86395e0-4456-4bd0-b320-bbfc49f0e780@intel.com>
Date: Fri, 12 Sep 2025 13:58:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/loader: Rectify the address of setup_data
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250814141406.2371767-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250814141406.2371767-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 8/14/2025 10:14 PM, Xiaoyao Li wrote:
> Commit 214191f6b574 ("x86/loader: read complete kernel") changed the
> semantics of kernel_size from the piggyback kernel to the whole kernel
> file, which leads to the setup_data_offset contains setup_size and leads
> to wrong address of setup_data being written in header[0x250].
> 
> Fix it by minusing setup_size.

Gentle ping.

> Fixes: 214191f6b574 ("x86/loader: read complete kernel")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   hw/i386/x86-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 7512be64d67b..127b85eb02cc 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -935,7 +935,7 @@ void x86_load_linux(X86MachineState *x86ms,
>           kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
>           kernel = g_realloc(kernel, kernel_size);
>   
> -        stq_le_p(header + 0x250, prot_addr + setup_data_offset);
> +        stq_le_p(header + 0x250, prot_addr + setup_data_offset - setup_size);
>   
>           setup_data = (struct setup_data *)(kernel + setup_data_offset);
>           setup_data->next = 0;


