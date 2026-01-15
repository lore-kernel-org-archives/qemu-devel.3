Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD16D3CC8C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 01:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgBr1-0000KK-A0; Wed, 14 Jan 2026 20:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vgBqy-0000Jf-NO
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 20:08:48 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vgBqx-0004ov-4s
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 20:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768439328; x=1799975328;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=o5PtTJSEvpJXGgpc3pmgatc+2Pd70u0mxVJPqcWDYg0=;
 b=lwPDuZTuKtjF7ESymQJEdUqUBxrQRrSAKOKMN/Lpw78z77W11A0Ar+bQ
 mpeoi346NmbDCAvpXfAG54uKskUoa1i2PbF4RafCjVn6U10jiPCgimt7/
 pHqDjG5gSvqSgjJ9HwyngsehVgc/WD52Q1ns4/oQ6wyiuzckvz84ZEzKB
 5p8GyZ8rp0lTmNn/aEpeOuWjEtV/DXO0Agzi4BlhbqsJ/VDcAtPsYKybz
 /9fGOAmm74uwHQD93ePi29OPpgJmm70ublNld05gUMGKLyklNZypG9g6f
 Uhtc4Pgm9IzzIoMJno1djufvp2+yYptM8bF7uzf2+ZHnr8uui3CvQcv// w==;
X-CSE-ConnectionGUID: pKBpuVYpRMyWQoN537qb6A==
X-CSE-MsgGUID: JTORvDEwRvWzzhDd1kJ2RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69481499"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; d="scan'208";a="69481499"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 17:08:46 -0800
X-CSE-ConnectionGUID: DN03NiI6SR2irFYJoMqVTA==
X-CSE-MsgGUID: ROvRXqaKQb2PITBLC98dGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; d="scan'208";a="204614704"
Received: from fhuang-mobl1.amr.corp.intel.com (HELO [10.125.38.93])
 ([10.125.38.93])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 17:08:45 -0800
Message-ID: <c952b8d7-d1f9-44cc-812d-1a6600b26709@intel.com>
Date: Wed, 14 Jan 2026 17:08:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] target/i386/kvm: extract unrelated code out of
 kvm_x86_build_cpuid()
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
 <20260109075508.113097-3-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260109075508.113097-3-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zide.chen@intel.com;
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
> The initialization of 'has_architectural_pmu_version',
> 'num_architectural_pmu_gp_counters', and
> 'num_architectural_pmu_fixed_counters' is unrelated to the process of
> building the CPUID.
> 
> Extract them out of kvm_x86_build_cpuid().
> 
> In addition, use cpuid_find_entry() instead of cpu_x86_cpuid(), because
> CPUID has already been filled at this stage.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---

LGTM.
Reviewed-by: Zide Chen <zide.chen@intel.com>



