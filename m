Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06797C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKIh-0005Zw-II; Fri, 24 Jan 2025 09:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi1.lai@linux.intel.com>)
 id 1tbEcB-0000iT-TB; Fri, 24 Jan 2025 03:00:31 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi1.lai@linux.intel.com>)
 id 1tbEc8-0007V1-Va; Fri, 24 Jan 2025 03:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737705629; x=1769241629;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vraGi2N1692lrsWeJJ0uu42/dKCVO3ev6i4xeRW/SPE=;
 b=PCLp/PvFupwYbjMclsYRPIiVi5TAYDxtTi4K+zVgUix7/4IYKdL/mt8n
 Du9EEPjvqb6T4j4QBZJ6Vs3eyso9IjpjYvlc8gjTSwVQvmnGYJa845FNP
 YRDQ0PTDK6OD2jPdGgULxGkdhHJIwQFt2a9K6Pe5mb+SqIxCgQT3BSmMJ
 caRxgYTejHLAzvyHhGLpuswPC4ETiTc302+FLxc+xAqbC8h0FcX0NzEzs
 sKIpL1lUOfZjUzI7AQb5NyMPXlKFK5mAaNwy9oFnrJxfkm7rZolzdzsZl
 Lz/Ir6+Y7d9GZOXp/VHhzd3lRTb5pKNZ/E/H+gzK6T9Qi5sjXPeogd/6I A==;
X-CSE-ConnectionGUID: ywV6k4jZSxuMAPpxteM61Q==
X-CSE-MsgGUID: 7taFpxRgS3uWGkTBljcuGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="55777003"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="55777003"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 00:00:23 -0800
X-CSE-ConnectionGUID: bE10kcECQN2Wk7Meqpyilw==
X-CSE-MsgGUID: 6kwZ9b72RjmqMF9SAtVmrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="108589618"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation)
 ([10.239.161.23])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 00:00:19 -0800
Date: Fri, 24 Jan 2025 16:00:13 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 0/5] accel/kvm: Support KVM PMU filter
Message-ID: <Z5NIjXYCvNtYohc+@ly-workstation>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122090517.294083-1-zhao1.liu@intel.com>
Received-SPF: none client-ip=192.198.163.8;
 envelope-from=yi1.lai@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jan 2025 09:04:46 -0500
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

On Wed, Jan 22, 2025 at 05:05:12PM +0800, Zhao Liu wrote:
> Hi folks,
> 
> Sorry for the long wait, but RFC v2 is here at last.
> 
> Compared with v1 [1], v2 mianly makes `action` as a global parameter,
> and all events (and fixed counters) are based on a unified action.
> 
> Learned from the discussion with Shaoqin in v1, current pmu-filter QOM
> design could meet the requirements from the ARM KVM side.
> 
>

Tested the v2 patches series with v6.13 kernel.

The 3 supported event formats work correctly with both action "allow" and
"deny". The x86-fixed-counter support also works as expected.

Regards,
Yi Lai

> Background
> ==========
> 
> I picked up Shaoqing's previous work [2] on the KVM PMU filter for arm,
> and now is trying to support this feature for x86 with a JSON-compatible
> API.
> 
> While arm and x86 use different KVM ioctls to configure the PMU filter,
> considering they all have similar inputs (PMU event + action), it is
> still possible to abstract a generic, cross-architecture kvm-pmu-filter
> object and provide users with a sufficiently generic or near-consistent
> QAPI interface.
> 
> That's what I did in this series, a new kvm-pmu-filter object, with the
> API like:
> 
> -object '{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"raw","code":"0xc4"}]}'
> 
> For i386, this object is inserted into kvm accelerator and is extended
> to support fixed-counter and more formats ("x86-default" and
> "x86-masked-entry"):
> 
> -accel kvm,pmu-filter=f0 \
> -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","x86-fixed-counter":{"bitmap":"0x0"},"events":[{"format":"x86-masked-entry","select":"0xc4","mask":"0xff","match":"0","exclude":true},{"format":"x86-masked-entry","select":"0xc5","mask":"0xff","match":"0","exclude":true}]}'
> 
> This object can still be added as the property to the arch CPU if it is
> desired as a per CPU feature (as Shaoqin did for arm before).
> 
> 
> Introduction
> ============
> 
> 
> Formats supported in kvm-pmu-filter
> -----------------------------------
> 
> This series supports 3 formats:
> 
> * raw format (general format).
> 
>   This format indicates the code that has been encoded to be able to
>   index the PMU events, and which can be delivered directly to the KVM
>   ioctl. For arm, this means the event code, and for i386, this means
>   the raw event with the layout like:
> 
>       select high bit | umask | select low bits
> 
> * x86-default format (i386 specific)
> 
>   x86 commonly uses select&umask to identify PMU events, and this format
>   is used to support the select&umask. Then QEMU will encode select and
>   umask into a raw format code.
> 
> * x86-masked-entry (i386 specific)
> 
>   This is a special format that x86's KVM_SET_PMU_EVENT_FILTER supports.
> 
> 
> Hexadecimal value string
> ------------------------
> 
> In practice, the values associated with PMU events (code for arm, select&
> umask for x86) are often expressed in hexadecimal. Further, from linux
> perf related information (tools/perf/pmu-events/arch/*/*/*.json), x86/
> arm64/riscv/nds32/powerpc all prefer the hexadecimal numbers and only
> s390 uses decimal value.
> 
> Therefore, it is necessary to support hexadecimal in order to honor PMU
> conventions.
> 
> However, unfortunately, standard JSON (RFC 8259) does not support
> hexadecimal numbers. So I can only consider using the numeric string in
> the QAPI and then parsing it to a number.
> 
> To achieve this, I defined two versions of PMU-related structures in
> kvm.json:
>  * a native version that accepts numeric values, which is used for
>    QEMU's internal code processing,
> 
>  * and a variant version that accepts numeric string, which is used to
>    receive user input.
> 
> kvm-pmu-filter object will take care of converting the string version
> of the event/counter information into the numeric version.
> 
> The related implementation can be found in patch 1.
> 
> 
> CPU property v.s. KVM property
> ------------------------------
> 
> In Shaoqin's previous implementation [2], KVM PMU filter is made as a
> arm CPU property. This is because arm uses a per CPU ioctl
> (KVM_SET_DEVICE_ATTR) to configure KVM PMU filter.
> 
> However, for x86, the dependent ioctl (KVM_SET_PMU_EVENT_FILTER) is per
> VM. In the meantime, considering that for hybrid architecture, maybe in
> the future there will be a new per vCPU ioctl, or there will be
> practices to support filter fixed counter by configuring CPUIDs.
> 
> Based on the above thoughts, for x86, it is not appropriate to make the
> current per-VM ioctl-based PMU filter a CPU property. Instead, I make it
> a kvm property and configure it via "-accel kvm,pmu-filter=obj_id".
> 
> So in summary, it is feasible to use the KVM PMU filter as either a CPU
> or a KVM property, depending on whether it is used as a CPU feature or a
> VM feature.
> 
> The kvm-pmu-filter object, as an abstraction, is general enough to
> support filter configurations for different scopes (per-CPU or per-VM).
> 
> [1]: https://lore.kernel.org/qemu-devel/20240710045117.3164577-1-zhao1.liu@intel.com/
> [2]: https://lore.kernel.org/qemu-devel/20240409024940.180107-1-shahuang@redhat.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (5):
>   qapi/qom: Introduce kvm-pmu-filter object
>   i386/kvm: Support basic KVM PMU filter
>   i386/kvm: Support event with select & umask format in KVM PMU filter
>   i386/kvm: Support event with masked entry format in KVM PMU filter
>   i386/kvm: Support fixed counter in KVM PMU filter
> 
>  MAINTAINERS              |   1 +
>  accel/kvm/kvm-pmu.c      | 386 +++++++++++++++++++++++++++++++++++++++
>  accel/kvm/meson.build    |   1 +
>  include/system/kvm-pmu.h |  44 +++++
>  include/system/kvm_int.h |   2 +
>  qapi/kvm.json            | 246 +++++++++++++++++++++++++
>  qapi/meson.build         |   1 +
>  qapi/qapi-schema.json    |   1 +
>  qapi/qom.json            |   3 +
>  target/i386/kvm/kvm.c    | 176 ++++++++++++++++++
>  10 files changed, 861 insertions(+)
>  create mode 100644 accel/kvm/kvm-pmu.c
>  create mode 100644 include/system/kvm-pmu.h
>  create mode 100644 qapi/kvm.json
> 
> -- 
> 2.34.1
> 

