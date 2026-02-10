Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B945EA3F09
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphlx-0006DX-Hm; Tue, 10 Feb 2026 02:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vphlw-00065h-1M
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:02:56 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vphlu-0004s5-EE
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770706974; x=1802242974;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7yD8/EM5IxH+Bdj4cjFGOQKe6NgtEHQJ7XLVrHwBR2o=;
 b=JdpFKYvAE0G3yyH9VOiA/Knc4XCJdtKSHyOXaSiK/HfludMY+itbuE4/
 XXqY2NhZV/HcKViZ9Fc1Z6NvcCmeaftPIUXAnBhYGvyl37W5ANxY3Mh0Z
 H1rg2L9yi4SVHp8jIb4yqoMgyGe6ac+qg8lPzHjdLpJ3Kdz9nMr3aDzVS
 owSB8KgD8QcvxeloB1JJXrAR2tu0QN/VJeyJhvDUJBw8gMkQdulXofjBV
 EcABQ5SYo+ocUTMXOJtUH+yyo++Fv4D3Caf/CGsrozo1VsXT1efd+gZTi
 v+uKChfHRRrQEsUcN3jzgHHtzKBle2Mc46nlaqqsXToqRqXrTZcsth3ma w==;
X-CSE-ConnectionGUID: g7LtTU5fQeegjPc5+EtqXQ==
X-CSE-MsgGUID: c/I0RiqwREGmTL/iP1fQcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="83199334"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83199334"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:02:52 -0800
X-CSE-ConnectionGUID: sAPpXRqLQky9YaL3s5hiiQ==
X-CSE-MsgGUID: qdw0VuQwTE+LijKhAV91sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211366527"
Received: from qianm-mobl2.ccr.corp.intel.com (HELO [10.238.1.184])
 ([10.238.1.184])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:02:50 -0800
Message-ID: <5e0b0f99-2692-4316-85bc-6d83e83e353d@linux.intel.com>
Date: Tue, 10 Feb 2026 15:02:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 07/11] target/i386: Make some PEBS features user-visible
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
 <20260128231003.268981-8-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260128231003.268981-8-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10;
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
> Populate selected PEBS feature names in FEAT_PERF_CAPABILITIES to make
> the corresponding bits user-visible CPU feature knobs, allowing them to
> be explicitly enabled or disabled via -cpu +/-<feature>.
>
> Once named, these bits become part of the guest CPU configuration
> contract.  If a VM is configured with such a feature enabled, migration
> to a destination that does not support the feature may fail, as the
> destination cannot honor the guest-visible CPU model.
>
> The PEBS_FMT bits are not exposed, as target/i386 currently does not
> support multi-bit CPU properties.
>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - Add the missing comma after "pebs-arch-reg".
> - Simplify the PEBS_FMT description in the commit message.
>
>  target/i386/cpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d3e9d3c40b0a..f2c83b4f259c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1618,10 +1618,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .type = MSR_FEATURE_WORD,
>          .feat_names = {
>              NULL, NULL, NULL, NULL,
> +            NULL, NULL, "pebs-trap", "pebs-arch-reg",
>              NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, "full-width-write", NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            NULL, "full-width-write", "pebs-baseline", NULL,
> +            NULL, "pebs-timing-info", NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



