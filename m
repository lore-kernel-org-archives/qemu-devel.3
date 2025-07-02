Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2329CC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 05:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWqBF-0002GA-S1; Wed, 02 Jul 2025 01:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWqBD-0002Fh-JV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 01:38:47 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWqB6-0007ac-Og
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 01:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751434721; x=1782970721;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9zgnB3BBaGKVhPYkrZq3To/yKcDwTfEjj3iZ5HAcZzc=;
 b=LjZ9arOJCMqncsqXPcJGfN9kidSaTqBJDHTnigkl2ppgf5ggCewKegQa
 u1xn2qOyrbSOmg3QlyhZevo6NuPrNhnrIF/KdZ7pMQEWAmHG0TRXcq5p+
 /V3Erh7t/xGnhsdc1xkdrWtRBL4nTTGGG5vwTzBdD6yvgV2q+ZlFZ62eC
 YLaXRXHWokYnEZ9adaMjsQzrg6jZtrNnPvdDkC++Hw+YvdsMUZGwKK9jy
 0GzFMeYepgNJMK4kuouzdTdpSOHVvNfrWNj0MgVsHhoLfm+bbhTI0nXuZ
 idzUeLX55ZPgtPdsbhTtq9/+IrFIZkiLifGOISqWuHziKhYAkmJtzGeLI g==;
X-CSE-ConnectionGUID: B+3iVWQdTtChjffmtGLOJQ==
X-CSE-MsgGUID: +HC5qA8GTmGZPn/ywq30Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53581976"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="53581976"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 22:38:26 -0700
X-CSE-ConnectionGUID: tUtOJQrzSdqA1qJsSylh1g==
X-CSE-MsgGUID: nld65XTKROSvjfpOi6Ydew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="158351488"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 22:38:21 -0700
Message-ID: <0057388f-ccaa-4b39-a9ba-1d3b820d12da@linux.intel.com>
Date: Wed, 2 Jul 2025 13:38:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] target/i386/kvm: reset AMD PMU registers during VM
 reset
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com, joe.jin@oracle.com,
 ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com
References: <20250624074421.40429-1-dongli.zhang@oracle.com>
 <20250624074421.40429-8-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250624074421.40429-8-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 6/24/2025 3:43 PM, Dongli Zhang wrote:
> + uint32_t sel_base = MSR_K7_EVNTSEL0;
> + uint32_t ctr_base = MSR_K7_PERFCTR0;
> + /*
> + * The address of the next selector or counter register is
> + * obtained by incrementing the address of the current selector
> + * or counter register by one.
> + */
> + uint32_t step = 1;
> +
> + /*
> + * When PERFCORE is enabled, AMD PMU uses a separate set of
> + * addresses for the selector and counter registers.
> + * Additionally, the address of the next selector or counter
> + * register is determined by incrementing the address of the
> + * current register by two.
> + */
> + if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE) {
> + sel_base = MSR_F15H_PERF_CTL0;
> + ctr_base = MSR_F15H_PERF_CTR0;
> + step = 2;
> + }

This part of code is duplicate with previous code in kvm_put_msrs(), we'd
better add a new helper to get PMU counter MSRs base and index for all
vendors. (This can be done as an independent patch if no new version for
this patchset).

All others look good to me.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



