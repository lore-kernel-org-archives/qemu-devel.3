Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCADD5B87C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 08:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVPzo-00066X-K6; Tue, 16 Dec 2025 03:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vVPzl-000660-7Q
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 03:01:21 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vVPze-0007ub-Ht
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 03:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765872074; x=1797408074;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ly+Ud2bhZKSB8OQ2caS0r8J18OBDXNWaCjHdBlKKK5g=;
 b=QrNPyqT9ONw/YXDOX866DfLhyMb/pXXHncRvWcwK4slmzutFqwgH8+0D
 6dMvwXvn5eZKfcKUQwaiudytmdZq/oQ1Elo56bzxMQGx7MCUngHyVFCCD
 61s8EcVKwEJJWBcGSeN/w8A1npD50wkH9l7XH6Dk3i4tsiSwPqOZc/OFB
 a/ym81mzscs7YK2Mlz3ALcvQwkVIZ8bkY9IVFo1Ol32gUaU4jpAg2iu08
 QNa5vtIaEiZ57CChcd0EMknRRepSR/7X6tLV1EkyIc0qbEDZX1cahecpR
 NVr4LdJZ/oSJjtVY99Xff+uKfc4UsM4aRaqNDM4XHnes2vnjHdNgp+NoA g==;
X-CSE-ConnectionGUID: N1lUQYbDSwOq7uUy/5MyoA==
X-CSE-MsgGUID: RaZkSwSoQXaNiaLx8aPyLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="71413798"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="71413798"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 00:01:08 -0800
X-CSE-ConnectionGUID: hyFoc6uNT9qO7FWsvZGdyQ==
X-CSE-MsgGUID: 6oF8idddSeyPf7qt61RKHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="197845265"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 16 Dec 2025 00:01:04 -0800
Date: Tue, 16 Dec 2025 16:25:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com
Subject: Re: [PATCH v7 0/9] target/i386/kvm/pmu: PMU Enhancement, Bugfix and
 Cleanup
Message-ID: <aUEXkDDOba+oZ4v+@intel.com>
References: <20251111061532.36702-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111061532.36702-1-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 10, 2025 at 10:14:49PM -0800, Dongli Zhang wrote:
> Date: Mon, 10 Nov 2025 22:14:49 -0800
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v7 0/9] target/i386/kvm/pmu: PMU Enhancement, Bugfix and
>  Cleanup
> X-Mailer: git-send-email 2.43.5
> 
> This patchset addresses four bugs related to AMD PMU virtualization.
> 
> 1. The PerfMonV2 is still available if PERCORE if disabled via
> "-cpu host,-perfctr-core".
> 
> 2. The VM 'cpuid' command still returns PERFCORE although "-pmu" is
> configured.
> 
> 3. The third issue is that using "-cpu host,-pmu" does not disable AMD PMU
> virtualization. When using "-cpu EPYC" or "-cpu host,-pmu", AMD PMU
> virtualization remains enabled. On the VM's Linux side, you might still
> see:
> 
> [    0.510611] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
> 
> instead of:
> 
> [    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
> [    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled
> 
> To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
> when "-pmu" is configured.
> 
> 4. The fourth issue is that unreclaimed performance events (after a QEMU
> system_reset) in KVM may cause random, unwanted, or unknown NMIs to be
> injected into the VM.
> 
> The AMD PMU registers are not reset during QEMU system_reset.
> 
> (1) If the VM is reset (e.g., via QEMU system_reset or VM kdump/kexec) while
> running "perf top", the PMU registers are not disabled properly.
> 
> (2) Despite x86_cpu_reset() resetting many registers to zero, kvm_put_msrs()
> does not handle AMD PMU registers, causing some PMU events to remain
> enabled in KVM.
> 
> (3) The KVM kvm_pmc_speculative_in_use() function consistently returns true,
> preventing the reclamation of these events. Consequently, the
> kvm_pmc->perf_event remains active.
> 
> (4) After a reboot, the VM kernel may report the following error:
> 
> [    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
> [    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)
> 
> (5) In the worst case, the active kvm_pmc->perf_event may inject unknown
> NMIs randomly into the VM kernel:
> 
> [...] Uhhuh. NMI received for unknown reason 30 on CPU 0.
> 
> To resolve these issues, we propose resetting AMD PMU registers during the
> VM reset process
 
Hi Dongli,

Except for Patch 1 & 2 which need compatibility options (if you think
it's okay, I could help take these 2 and fix them when v11.0's compat
array is ready).

The other patches still LGTM. Maybe it's better to have a v8 excluding
patch 1 & 2?

Regards,
Zhao


