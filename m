Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F38D4A5EB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 05:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhhVP-0007X6-W2; Mon, 19 Jan 2026 00:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vhhVC-0007WD-2n
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 00:08:36 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vhhV8-0000SS-Pe
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 00:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768799311; x=1800335311;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nLwTrY9kl6J1cUA3P/OV/Bk7pXQW0CRc9S0pVw4lGtM=;
 b=EifIwAcwBkuUN1VgdhLEbFTsGRi2L9xf6d1UJwH+44HidPzrfwFUNchs
 MgdzdSSpbRMp89QljtxnoSUB/ULkzLjJTuqEQIe95Qg/jJO9qb+ulbMZS
 buHrL8HXFICYmO+sNEfpzFV9cIODi7gTR5B1TNJhBRqVYKFwy7n5RJjOM
 ZT1Cw7DGBdkQuUNRwNZaRWAIFXDhr6C2BzOWlg2zb5yVfNJiMacFvgTfL
 EvgOTZwUelz998iFcUGcFcPRo1LPVXYsrQdsOEfJi+Gk1jnDZnJOU7RrW
 UrWXGHGRw6vt31r5OaG/fGcUpN3Dbs9RovR7F7Hbud6goVOynJvP07mgV g==;
X-CSE-ConnectionGUID: 3h4NOJWDTQOrk901z7RnXg==
X-CSE-MsgGUID: UjDrDJ3GSV6BJLJQv4vy0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69207414"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="69207414"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2026 21:08:26 -0800
X-CSE-ConnectionGUID: B7cEtOlzSgWNWOXkrxB2ww==
X-CSE-MsgGUID: lr3SEjnqTiGBV+MDr9H41w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="228704859"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 18 Jan 2026 21:08:21 -0800
Date: Mon, 19 Jan 2026 13:33:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com, zide.chen@intel.com
Subject: Re: [PATCH v9 4/5] target/i386/kvm: reset AMD PMU registers during
 VM reset
Message-ID: <aW3CQIHgv5nP85gd@intel.com>
References: <20260109075508.113097-1-dongli.zhang@oracle.com>
 <20260109075508.113097-5-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109075508.113097-5-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
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

On Thu, Jan 08, 2026 at 11:53:59PM -0800, Dongli Zhang wrote:
> Date: Thu,  8 Jan 2026 23:53:59 -0800
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v9 4/5] target/i386/kvm: reset AMD PMU registers during VM
>  reset
> X-Mailer: git-send-email 2.43.5
> 
> QEMU uses the kvm_get_msrs() function to save Intel PMU registers from KVM
> and kvm_put_msrs() to restore them to KVM. However, there is no support for
> AMD PMU registers. Currently, pmu_version and num_pmu_gp_counters are
> initialized based on cpuid(0xa), which does not apply to AMD processors.
> For AMD CPUs, prior to PerfMonV2, the number of general-purpose registers
> is determined based on the CPU version.
> 
> To address this issue, we need to add support for AMD PMU registers.
> Without this support, the following problems can arise:
> 
> 1. If the VM is reset (e.g., via QEMU system_reset or VM kdump/kexec) while
> running "perf top", the PMU registers are not disabled properly.
> 
> 2. Despite x86_cpu_reset() resetting many registers to zero, kvm_put_msrs()
> does not handle AMD PMU registers, causing some PMU events to remain
> enabled in KVM.
> 
> 3. The KVM kvm_pmc_speculative_in_use() function consistently returns true,
> preventing the reclamation of these events. Consequently, the
> kvm_pmc->perf_event remains active.
> 
> 4. After a reboot, the VM kernel may report the following error:
> 
> [    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
> [    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)
> 
> 5. In the worst case, the active kvm_pmc->perf_event may inject unknown
> NMIs randomly into the VM kernel:
> 
> [...] Uhhuh. NMI received for unknown reason 30 on CPU 0.
> 
> To resolve these issues, we propose resetting AMD PMU registers during the
> VM reset process.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>   - Modify "MSR_K7_EVNTSEL0 + 3" and "MSR_K7_PERFCTR0 + 3" by using
>     AMD64_NUM_COUNTERS (suggested by Sandipan Das).
>   - Use "AMD64_NUM_COUNTERS_CORE * 2 - 1", not "MSR_F15H_PERF_CTL0 + 0xb".
>     (suggested by Sandipan Das).
>   - Switch back to "-pmu" instead of using a global "pmu-cap-disabled".
>   - Don't initialize PMU info if kvm.enable_pmu=N.
> Changed since v2:
>   - Remove 'static' from host_cpuid_vendorX.
>   - Change has_pmu_version to pmu_version.
>   - Use object_property_get_int() to get CPU family.
>   - Use cpuid_find_entry() instead of cpu_x86_cpuid().
>   - Send error log when host and guest are from different vendors.
>   - Move "if (!cpu->enable_pmu)" to begin of function. Add comments to
>     reminder developers.
>   - Add support to Zhaoxin. Change is_same_vendor() to
>     is_host_compat_vendor().
>   - Didn't add Reviewed-by from Sandipan because the change isn't minor.
> Changed since v3:
>   - Use host_cpu_vendor_fms() from Zhao's patch.
>   - Check AMD directly makes the "compat" rule clear.
>   - Add comment to MAX_GP_COUNTERS.
>   - Skip PMU info initialization if !kvm_pmu_disabled.
> Changed since v4:
>   - Add Reviewed-by from Zhao and Sandipan.
> Changed since v6:
>   - Add Reviewed-by from Dapeng Mi.
> Changed since v8:
>   - Remove the usage of 'kvm_pmu_disabled' as sussged by Zide Chen.
>   - Remove Reviewed-by from Zhao Liu, Sandipan Das and Dapeng Mi, as the
>     usage of 'kvm_pmu_disabled' is removed.
> 
>  target/i386/cpu.h     |  12 +++
>  target/i386/kvm/kvm.c | 168 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 176 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


