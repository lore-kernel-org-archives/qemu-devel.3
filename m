Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2E6C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tppfT-0005Yv-Jx; Wed, 05 Mar 2025 09:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tppfR-0005Yh-IL
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:24:13 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tppfP-0005uE-7j
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741184652; x=1772720652;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=x05EX333NKXOFTqc+uZagDz/CRKZvPUFB+nBn2iqWig=;
 b=iolKRjzVOunZpxmlowCqoqm8qr9FAhKH6b0vgcRG4Oz7vjxhi0yY2VvS
 9UW2yly8JIAlNKO9AqEn2HQNhlAdwCV6Da+InjvvMSYV6TQ+Xh4k5pic0
 t4PN317xwlrxI4FM4jbE57sW0Qg22ukb1N3SOtAxEx8H3Kqo0Vv3rcYhh
 dkGfhcsJsr/c1DUw6jp1D476jy6ZGfURTVh4dIC001+4CdaG87TCHHDS7
 JA55AdpKTcCYEpfqpLKzTWiOpqYfMPb8hIF8zbPsK+7c8RhuNEZUWGYiG
 9YD1cHzp6jmFwPsuPAwFdHyP8o8VgVycWDu3+4LY4oW6PIhSNn1YEm5qF w==;
X-CSE-ConnectionGUID: O9tMZGtkTzCf0WaAvluVzA==
X-CSE-MsgGUID: Kgezz1ooQ/mhS+eeyG6W7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42012952"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="42012952"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 06:24:07 -0800
X-CSE-ConnectionGUID: oJrAzU2STQK/lNbn55v2gQ==
X-CSE-MsgGUID: 80ywhNNrQOCT2LwTfPLMPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="123740616"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 05 Mar 2025 06:24:03 -0800
Date: Wed, 5 Mar 2025 22:44:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 04/10] target/i386/kvm: set KVM_PMU_CAP_DISABLE if
 "-pmu" is configured
Message-ID: <Z8hjOgFURpgApBX5@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-5-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302220112.17653-5-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

On Sun, Mar 02, 2025 at 02:00:12PM -0800, Dongli Zhang wrote:
> Date: Sun,  2 Mar 2025 14:00:12 -0800
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v2 04/10] target/i386/kvm: set KVM_PMU_CAP_DISABLE if
>  "-pmu" is configured
> X-Mailer: git-send-email 2.43.5
> 
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
> ---
> Changed since v1:
>   - Switch back to the initial implementation with "-pmu".
> https://lore.kernel.org/all/20221119122901.2469-3-dongli.zhang@oracle.com
>   - Mention that "KVM_PMU_CAP_DISABLE doesn't change the PMU behavior on
>     Intel platform because current "pmu" property works as expected."
> 
>  target/i386/kvm/kvm.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Overall LGTM. And with Xiaoyao's comment fixed :-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks,
Zhao


