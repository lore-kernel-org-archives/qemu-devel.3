Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36935C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 15:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbio1-0008NP-9V; Wed, 07 Aug 2024 11:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbinz-0008MH-UG
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 11:42:27 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbinx-0006LS-EH
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 11:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723045346; x=1754581346;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2aM/slguSRMwGszet3nTWb/0Y1FfqZhdNtxD8GIXmQU=;
 b=bPKZp0+ZP9BFCYuzqeqYqFzi+L1eqId9BHA7EPyiACOjKF3vt20by2nC
 sXgmxPiyHkWkCJdpi71pUB1CGMPNpYTLYWGU8ne2KhySISsMsH7hznMqK
 ug3TtffPmivNvKKtAzpWLdNyzVtd9LQWQB6BIGShrDXaUBqBpIBQqAIvP
 TjQHbSTzRswYnZF4VQzx/cyasIGDPy5TyUYhzaksz8SEkdpDDAQfVxWQC
 L+yfUC61h/AgdDlWLomV6g/2vpJ3OrWEoJn4Ei6OqTozm2ZjgxKRds3cX
 wgtT7YoagGYCo7pE6qGvX6YqZgFpymFGQEPVxnIHXUzrHf9tYHKfZyx+N g==;
X-CSE-ConnectionGUID: GHlFt0ajTlS1tfGsXr34IQ==
X-CSE-MsgGUID: Krn6Df1LRuyqaS9EtdTBPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="24886751"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="24886751"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 08:42:22 -0700
X-CSE-ConnectionGUID: sMxdWnHzSaOes+GjrVMtAg==
X-CSE-MsgGUID: EQRO3zeUTEyNM2T71mTXOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="57592138"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 07 Aug 2024 08:42:20 -0700
Date: Wed, 7 Aug 2024 23:58:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 lei4.wang@intel.com, xin3.li@intel.com
Subject: Re: [PATCH v1 2/3] target/i386: Add VMX control bits for nested FRED
 support
Message-ID: <ZrOZkYuSKhYH0ymi@intel.com>
References: <20240807081813.735158-1-xin@zytor.com>
 <20240807081813.735158-3-xin@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807081813.735158-3-xin@zytor.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Xin,

On Wed, Aug 07, 2024 at 01:18:11AM -0700, Xin Li (Intel) wrote:
> Date: Wed,  7 Aug 2024 01:18:11 -0700
> From: "Xin Li (Intel)" <xin@zytor.com>
> Subject: [PATCH v1 2/3] target/i386: Add VMX control bits for nested FRED
>  support
> X-Mailer: git-send-email 2.45.2
> 
> Add definitions of
>   1) VM-exit activate secondary controls bit
>   2) VM-entry load FRED bit
> which are required to enable nested FRED.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 85ef7452c0..31f287cae0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1435,7 +1435,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "vmx-exit-save-efer", "vmx-exit-load-efer",
>                  "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
>              NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
> -            NULL, "vmx-exit-load-pkrs", NULL, NULL,
> +            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",

Oh, the order of my reviews is mixed up.
It's better to move VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS into this patch.

>          },
>          .msr = {
>              .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
> @@ -1450,7 +1450,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, "vmx-entry-ia32e-mode", NULL, NULL,
>              NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
>              "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
> -            NULL, NULL, "vmx-entry-load-pkrs", NULL,
> +            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",

Should we also define VMX_VM_ENTRY_LOAD_FRED? "vmx-entry-load-rtit-ctl"
and "vmx-entry-load-pkrs" have their corresponding bit definitions, even
if they are not used.

Regards,
Zhao

>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>          },
> -- 
> 2.45.2
> 

