Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4987EC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 04:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmQzo-00062H-Sx; Tue, 19 Mar 2024 00:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmQzU-00061P-Qn
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 00:22:21 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmQzT-00072i-2L
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 00:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710822139; x=1742358139;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cIXFLbeUXg84zWcADxnHqFIGy0wacBqVhK/gTq9rImE=;
 b=CJys+ReyHVrdYBdRfj4iHX/zKJaqhzDZXlQga/T86AJXRJTKcGN6Qxud
 A25MngJ+EOi6G36V0aJMAWSbNLnjtUPWRx/1IxtZUf59JUXC24V83N7ms
 yK+DCZ9VJF44HZskL17KW612l3lrRRcSP6SXGRy1l+hnCDW2xbKaww1Ow
 VSrx3NlzGFUINaUT6eXI8ufJwmNWOdIgYmGa8hjhWFtd6FLe0yxnH95j1
 16+fIOGxiiLn+ZzkIsOcwNpciKpAViiYdQ3zHmEFxHhndEpu2ma8e9CJo
 F94MEIfx9/gbadYvMmRBLQacrvEYPDsnUOwF5VQQSCRGFh1lqVw0F619S Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="9437055"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="9437055"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 21:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="13649831"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 21:22:11 -0700
Message-ID: <7de64137-d11f-4029-b296-3b8a8be35178@intel.com>
Date: Tue, 19 Mar 2024 12:22:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Export RFDS bit to guests
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chao Gao <chao.gao@intel.com>,
 antonio.gomez.iglesias@linux.intel.com,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
References: <9a38877857392b5c2deae7e7db1b170d15510314.1710341348.git.pawan.kumar.gupta@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <9a38877857392b5c2deae7e7db1b170d15510314.1710341348.git.pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/13/2024 10:53 PM, Pawan Gupta wrote:
> Register File Data Sampling (RFDS) is a CPU side-channel vulnerability
> that may expose stale register value. CPUs that set RFDS_NO bit in MSR
> IA32_ARCH_CAPABILITIES indicate that they are not vulnerable to RFDS.
> Similarly, RFDS_CLEAR indicates that CPU is affected by RFDS, and has
> the microcode to help mitigate RFDS.
> 
> Make RFDS_CLEAR and RFDS_NO bits available to guests.

What's the status of KVM part?

> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>   target/i386/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9a210d8d9290..693a5e0fb2ce 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1158,8 +1158,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
>               NULL, "fb-clear", NULL, NULL,
>               NULL, NULL, NULL, NULL,
> -            "pbrsb-no", NULL, "gds-no", NULL,
> -            NULL, NULL, NULL, NULL,
> +            "pbrsb-no", NULL, "gds-no", "rfds-no",
> +            "rfds-clear", NULL, NULL, NULL,
>           },
>           .msr = {
>               .index = MSR_IA32_ARCH_CAPABILITIES,
> 
> base-commit: a1932d7cd6507d4d9db2044a54731fff3e749bac


