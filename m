Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C21BD3CC8C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 01:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgBpR-0007zG-QM; Wed, 14 Jan 2026 20:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vgBpP-0007yG-SN
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 20:07:11 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vgBpN-0004io-L5
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 20:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768439230; x=1799975230;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WiznaQNyKTEee+KonRMn9LZpkSjZNvxzn8/0C5dd21s=;
 b=g2jhGtw8zNXgiREXWSCF+0ZV3pZaRnFFIbgnzpovXsKg6pcId1HRRfcm
 1N3BY1CNjiA16KJWXq2IssL3F6GNfmoVnNhScuugFQQMtYBHQnkBh24D8
 c/ALlLg+sA/qKFylaibQpLywo4bQipnN6Ko/eG1q2l339GAeoJXyg2hpN
 xc5cKYgQyveN34NGerhA2Tuc3UQ1RJmHnZTYvL2ucnlGVqB4pAlARx80a
 NKvKaFPbVkKZ1xP/QZCBvG1jESTTjPwRMksIDRf0hgdmgjIJPqNKNz356
 KB3U89A9CyAqAlbJjnL/jJacqONHgqdYeJH36SCZlz7q0SqTZIZX6ziAM g==;
X-CSE-ConnectionGUID: 5fzpsUIcRRCaL61Zf5v5fQ==
X-CSE-MsgGUID: WMBsxFnBRDqP5smTtNxOhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69723713"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; d="scan'208";a="69723713"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 17:07:05 -0800
X-CSE-ConnectionGUID: vlh9H0UkTtOO1ZhUT1gGXw==
X-CSE-MsgGUID: fc0feO5oQRevSrpIW+1Wpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; d="scan'208";a="235544403"
Received: from fhuang-mobl1.amr.corp.intel.com (HELO [10.125.38.93])
 ([10.125.38.93])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 17:07:05 -0800
Message-ID: <ca48a26d-251d-437d-9d5b-b29dd38a4ab1@intel.com>
Date: Wed, 14 Jan 2026 17:07:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/5] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
References: <20260109075508.113097-1-dongli.zhang@oracle.com>
 <20260109075508.113097-2-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260109075508.113097-2-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/8/2026 11:53 PM, Dongli Zhang wrote:
> Although AMD PERFCORE and PerfMonV2 are removed when "-pmu" is configured,
> there is no way to fully disable KVM AMD PMU virtualization. Neither
> "-cpu host,-pmu" nor "-cpu EPYC" achieves this.
> 
> As a result, the following message still appears in the VM dmesg:
> 
> [    0.263615] Performance Events: AMD PMU driver.
> 
> However, the expected output should be:
> 
> [    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
> [    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled
> 
> This occurs because AMD does not use any CPUID bit to indicate PMU
> availability.
> 
> To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
> when "-pmu" is configured.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---

LGTM.
Reviewed-by: Zide Chen <zide.chen@intel.com>

