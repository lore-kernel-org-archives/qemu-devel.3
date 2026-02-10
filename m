Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7C1EA3F0D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 06:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphI6-0008BR-9W; Tue, 10 Feb 2026 01:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vphI4-0008Ay-7h
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 01:32:04 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vphI1-0007VZ-Fl
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 01:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770705122; x=1802241122;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Zdx+/cvtrP/lsP9PDOItO6z4pH8kkzotkx+YEp9BAc8=;
 b=awd/SM+XbVHUaGMjdb4KzoXrD6/0F+yWFSoykomhg0zOQlbNbzH85Hc4
 h24OV3nmzUKwdIiJwuElH1OKirf26lQN3nq+3OYlTxhkbXI14ylK4y5Ey
 +89FIhX1ZOQv0LqYwdEVF80hJQYKn81whSDW4LKoSihTg4Ty3YvSj0gF7
 VglM8C8MFTymvbCkTyagHjM28dUe89YOTQPCMNuR8h7yKx1y+H6Vq1kTy
 NLEhhCQPGW7Db5h/eK6jX44BkSKkATsjRv2ocqJwkSn9f/xzGasQ4gpNQ
 VgGv6eXBQLj0BE7zGS0fxaR2MhMLB+8pxTPigpFLVTfhHiuKoc5lUp0Ft g==;
X-CSE-ConnectionGUID: u5Jpx1WuQ4yXuQxEuSjUXA==
X-CSE-MsgGUID: 1QDDMRyZTTqncJchKZrsxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71036203"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71036203"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 22:31:55 -0800
X-CSE-ConnectionGUID: WNZHrJrqQqq8+Hi7D3vshg==
X-CSE-MsgGUID: nn3Rj5dJR2iZSURgDcGRng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211031516"
Received: from qianm-mobl2.ccr.corp.intel.com (HELO [10.238.1.184])
 ([10.238.1.184])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 22:31:53 -0800
Message-ID: <e255735f-cadf-4611-8811-1444436d777a@linux.intel.com>
Date: Tue, 10 Feb 2026 14:31:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] target/i386: Disable unsupported BTS for guest
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
 <20260128231003.268981-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260128231003.268981-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 1/29/2026 7:09 AM, Zide Chen wrote:
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
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - Address Dapeng's comments.
> - Remove mention of VMState version_id from the commit message.
>
>  target/i386/cpu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 2bbc977d9088..f02812bfd19f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -474,8 +474,11 @@ typedef enum X86Seg {
>  
>  #define MSR_IA32_MISC_ENABLE            0x1a0
>  /* Indicates good rep/movs microcode on some processors: */
> -#define MSR_IA32_MISC_ENABLE_DEFAULT    1
> +#define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)
> +#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
>  #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
> +#define MSR_IA32_MISC_ENABLE_DEFAULT    (MSR_IA32_MISC_ENABLE_FASTSTRING     |\
> +                                         MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
>  
>  #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
>  #define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



