Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D591BF513F0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyLpB-0000nZ-9H; Thu, 05 Mar 2026 22:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyLp8-0000nO-Eg
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:25:58 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyLp6-0003Qr-N1
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772767556; x=1804303556;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Yc6hFHwiTmrxSF+/qL9x+vyoSiqgmClUy+bV4BuDjAM=;
 b=LNsbP5/2/KlV1pFzm+L48K2HT8qOnjCv9fP+lxzdyljdWiptwTF9ZlmD
 PZDleacX18kmFGN8F9V02pc0H+VOBTbdR2+CGpMXBzvVW6wlRlIjFKEVQ
 eUGnVYdsPud1RecJhgdFVD6rNDE55MgZyvVWkEmEzZFjD+MwwShJiqxyw
 CU3EviH7Njz0I2aKDKRJvZdac5BrHhz4ZLnjm63If44e6VbGTT+eZa3Kc
 K5tsY/S88ytSPB4rwHH5+t9uuDicVxHkh+C01TQHJqR1AXuelQvlHsRk0
 2x8Mw3SBYs1UxlpxD/DNYsgKHkyAgK9wU5pzWJybLEDtXGkYGVr4KRaLA g==;
X-CSE-ConnectionGUID: gcQxP/thQHmHU+vackLwng==
X-CSE-MsgGUID: UnM9Ai0sSYKFfTHrZxB6Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="74060585"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="74060585"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:25:54 -0800
X-CSE-ConnectionGUID: meFLeV7VTEq4D2v560TKhQ==
X-CSE-MsgGUID: TBINicLMQL6nvWWjrW4UEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="216053631"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147])
 ([10.124.241.147])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:25:51 -0800
Message-ID: <f1fb6e47-b115-45a0-b212-0542b00c33ec@linux.intel.com>
Date: Fri, 6 Mar 2026 11:25:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/13] target/i386: Make some PEBS features user-visible
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-9-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260304180713.360471-9-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 3/5/2026 2:07 AM, Zide Chen wrote:
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
> ---
>  target/i386/cpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a69c3108f64b..89691fba45e1 100644
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

