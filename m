Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0135CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDfAN-0007SE-4F; Tue, 28 Oct 2025 04:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDfAF-0007Ov-K3
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:34:49 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDfA9-0004xh-20
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761640481; x=1793176481;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xL96dJ4I/mlgu1R+jfkDTz13nvLRhE07my2zJy3mP5w=;
 b=YUtznaB7NN+EDXDbeffEDHFfxNIFNxXdK1Cr1LMAu8RvWmUeKGBeL4YS
 186lcO48GSYrdDipzRzEzroVCGhrJEQmCIuYIBQw/cUty5pEjsfTG7hAV
 ajCNGYgyiqWgp5HtOXBbdsL5kvbR3C6BXuv115bVzvsv2rYFxc+HRa+M5
 hn1N0I3BErcNDsB+WRa9hBjIj9ZEcf85XSejyIAMZynEGe+/dKpcXqg7u
 KBKC5/qHLT9IzgjlXzNRfIzGzjXGYBVvboPxJRc/AUDolhIXGme/uRwFr
 idZzhAdrF/cWnIBTtFLfjzl3hGlCTZ5m0+P3lwFWojVsjQ7IvLJG4N9nh Q==;
X-CSE-ConnectionGUID: 6n20bY5IQKq7QDMKG8tKyw==
X-CSE-MsgGUID: xVHZ8hqpTvGkTXREvmQFBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74408008"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="74408008"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:34:36 -0700
X-CSE-ConnectionGUID: o+PgGZf3Rgaub7iOs990hA==
X-CSE-MsgGUID: /BoTglJbR4OS9bEvTgp36A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189341872"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:34:32 -0700
Message-ID: <449e5c7e-8df4-4925-ae38-cb7e144b0572@intel.com>
Date: Tue, 28 Oct 2025 16:34:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/20] i386/cpu: Enable cet-ss & cet-ibt for supported
 CPU models
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-19-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-19-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.574, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/24/2025 2:56 PM, Zhao Liu wrote:
> Add new versioned CPU models for Sapphire Rapids, Sierra Forest, Granite
> Rapids and Clearwater Forest, to enable shadow stack and indirect branch
> tracking.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9a1001c47891..73026d5bce91 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5161,6 +5161,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                       { /* end of list */ },
>                   }
>               },
> +            {
> +                .version = 5,
> +                .note = "with cet-ss and cet-ibt",
> +                .props = (PropValue[]) {
> +                    { "cet-ss", "on" },
> +                    { "cet-ibt", "on" },
> +                    { "vmx-exit-save-cet", "on" },
> +                    { "vmx-entry-load-cet", "on" },
> +                    { /* end of list */ },
> +                }
> +            },
>               { /* end of list */ }
>           }
>       },
> @@ -5323,6 +5334,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                       { /* end of list */ },
>                   }
>               },
> +            {
> +                .version = 4,
> +                .note = "with cet-ss and cet-ibt",
> +                .props = (PropValue[]) {
> +                    { "cet-ss", "on" },
> +                    { "cet-ibt", "on" },
> +                    { "vmx-exit-save-cet", "on" },
> +                    { "vmx-entry-load-cet", "on" },
> +                    { /* end of list */ },
> +                }
> +            },
>               { /* end of list */ },
>           },
>       },
> @@ -5477,6 +5499,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                       { /* end of list */ },
>                   }
>               },
> +            {
> +                .version = 4,
> +                .note = "with cet-ss and cet-ibt",
> +                .props = (PropValue[]) {
> +                    { "cet-ss", "on" },
> +                    { "cet-ibt", "on" },
> +                    { "vmx-exit-save-cet", "on" },
> +                    { "vmx-entry-load-cet", "on" },
> +                    { /* end of list */ },
> +                }
> +            },
>               { /* end of list */ },
>           },
>       },
> @@ -5612,6 +5645,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>           .model_id = "Intel Xeon Processor (ClearwaterForest)",
>           .versions = (X86CPUVersionDefinition[]) {
>               { .version = 1 },
> +            {
> +                .version = 2,
> +                .note = "with cet-ss and cet-ibt",
> +                .props = (PropValue[]) {
> +                    { "cet-ss", "on" },
> +                    { "cet-ibt", "on" },
> +                    { "vmx-exit-save-cet", "on" },
> +                    { "vmx-entry-load-cet", "on" },
> +                    { /* end of list */ },
> +                }
> +            },
>               { /* end of list */ },
>           },
>       },


