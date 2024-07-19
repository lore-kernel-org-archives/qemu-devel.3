Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36510C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUiNn-0000yN-09; Fri, 19 Jul 2024 03:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sUiNj-0000t1-Pc; Fri, 19 Jul 2024 03:50:23 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sUiNf-0006lZ-Hb; Fri, 19 Jul 2024 03:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721375420; x=1752911420;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3/vbqqtnyoZjZHVhP0NSLivHQVdRUyM0SUlkoxVrgT4=;
 b=PZWjqoptronebAtTEfe0bZeRsqKfyq5dlcE0/wJVxx8jxVFxymWVQInw
 kC9MrHN3oJf8oPjxJTXOP5RoYaZ+R5e8h3Yj9xVCQ5yx7ozqzIr6ngdUx
 xac1hDvx/yvfWaWPTCreTaRFEeSlbn6eCUQURx2R95wISSYtYBOXCWBFX
 0PsfI66UM61AXkKKJkXqImdXPhA6IhNEccVQv/dtH7FoRpeIy3MTMTTeQ
 MmuwMMKEFTh+wGLdRVMfxbl6QYEx6iB6aLL3mX8iGSvmtgODeVGw7vYaX
 ceL5b4E5gu2ICDhbilHlHS62cTqy4fBjvreNkWwTPZ9nH99ijFLTKtGnJ A==;
X-CSE-ConnectionGUID: AquPCg1GTzatWY7BhJkV2g==
X-CSE-MsgGUID: noPJQ961QgyArgO873P8qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="36411622"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; d="scan'208";a="36411622"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 00:50:13 -0700
X-CSE-ConnectionGUID: a9Pt3gQlTYCuAXzoAN+kdg==
X-CSE-MsgGUID: TI4hGxCyRC63/xeKPE3m2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; d="scan'208";a="51632627"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2024 00:50:07 -0700
Date: Fri, 19 Jul 2024 16:05:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yuan Yao <yuan.yao@intel.com>,
 Xiong Zhang <xiong.y.zhang@intel.com>, Mingwei Zhang <mizhang@google.com>,
 Jim Mattson <jmattson@google.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 0/5] accel/kvm: Support KVM PMU filter
Message-ID: <ZpoeXq+p+m7TMnw7@intel.com>
References: <20240710045117.3164577-1-zhao1.liu@intel.com>
 <738c5474-a568-4a48-8c8e-b0f11b17a187@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <738c5474-a568-4a48-8c8e-b0f11b17a187@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Also ping Shaoqin and Eric,

Hopefully I can get your input on interface design to align with the
Arm requirements together!


On Thu, Jul 18, 2024 at 01:27:48PM +0800, Mi, Dapeng wrote:
> Date: Thu, 18 Jul 2024 13:27:48 +0800
> From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
> Subject: Re: [RFC 0/5] accel/kvm: Support KVM PMU filter
> 
> 
> On 7/10/2024 12:51 PM, Zhao Liu wrote:
> > Hi QEMU maintainers, arm and PMU folks,
> >
> > I picked up Shaoqing's previous work [1] on the KVM PMU filter for arm,
> > and now is trying to support this feature for x86 with a JSON-compatible
> > API.
> >
> > While arm and x86 use different KVM ioctls to configure the PMU filter,
> > considering they all have similar inputs (PMU event + action), it is
> > still possible to abstract a generic, cross-architecture kvm-pmu-filter
> > object and provide users with a sufficiently generic or near-consistent
> > QAPI interface.
> >
> > That's what I did in this series, a new kvm-pmu-filter object, with the
> > API like:
> >
> > -object '{"qom-type":"kvm-pmu-filter","id":"f0","events":[{"action":"allow","format":"raw","code":"0xc4"}]}'
> 
> I'm not sure why the action is defined to event scope instead of the entire
> filter scope. At least for x86 arch, the action is defined to filter scope
> in KVM. Do other archs support event scope's action? If the action can be
> defined to filter scope, the code could be simplified much.

Yeah, that's fine for x86.

@Shaoqin, hi Shaoqin, if I use a global action for all events, is this
Okay for Arm?

I suppose this should work, since the interface here needs to enumerate
events one by one, and doesn't support a continuous enumeration format
(0x0-0x3) like the previous implementation. Right?

> >
> > For i386, this object is inserted into kvm accelerator and is extended
> > to support fixed-counter and more formats ("x86-default" and
> > "x86-masked-entry"):
> >
> > -accel kvm,pmu-filter=f0 \
> > -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","x86-fixed-counter":{"action":"allow","bitmap":"0x0"},"events":[{"action":"allow","format":"x86-masked-entry","select":"0xc4","mask":"0xff","match":"0","exclude":true},{"action":"allow","format":"x86-masked-entry","select":"0xc5","mask":"0xff","match":"0","exclude":true}]}'
> >
> > This object can still be added as the property to the arch CPU if it is
> > desired as a per CPU feature (as Shaoqin did for arm before).
> >
> > Welcome your feedback and comments!
> >
> >
> > Introduction
> > ============
> >
> >
> > Formats supported in kvm-pmu-filter
> > -----------------------------------
> >
> > This series supports 3 formats:
> >
> > * raw format (general format).
> >
> >   This format indicates the code that has been encoded to be able to
> >   index the PMU events, and which can be delivered directly to the KVM
> >   ioctl. For arm, this means the event code, and for i386, this means
> >   the raw event with the layout like:
> >
> >       select high bit | umask | select low bits
> >
> > * x86-default format (i386 specific)
> >
> >   x86 commonly uses select&umask to identify PMU events, and this format
> >   is used to support the select&umask. Then QEMU will encode select and
> >   umask into a raw format code.
> >
> > * x86-masked-entry (i386 specific)
> >
> >   This is a special format that x86's KVM_SET_PMU_EVENT_FILTER supports.
> >
> >
> > Hexadecimal value string
> > ------------------------
> >
> > In practice, the values associated with PMU events (code for arm, select&
> > umask for x86) are often expressed in hexadecimal. Further, from linux
> > perf related information (tools/perf/pmu-events/arch/*/*/*.json), x86/
> > arm64/riscv/nds32/powerpc all prefer the hexadecimal numbers and only
> > s390 uses decimal value.
> >
> > Therefore, it is necessary to support hexadecimal in order to honor PMU
> > conventions.
> >
> > However, unfortunately, standard JSON (RFC 8259) does not support
> > hexadecimal numbers. So I can only consider using the numeric string in
> > the QAPI and then parsing it to a number.
> >
> > To achieve this, I defined two versions of PMU-related structures in
> > kvm.json:
> >  * a native version that accepts numeric values, which is used for
> >    QEMU's internal code processing,
> >
> >  * and a variant version that accepts numeric string, which is used to
> >    receive user input.
> >
> > kvm-pmu-filter object will take care of converting the string version
> > of the event/counter information into the numeric version.
> >
> > The related implementation can be found in patch 1.
> >
> >
> > CPU property v.s. KVM property
> > ------------------------------
> >
> > In Shaoqin's previous implementation [1], KVM PMU filter is made as a
> > arm CPU property. This is because arm uses a per CPU ioctl
> > (KVM_SET_DEVICE_ATTR) to configure KVM PMU filter.
> >
> > However, for x86, the dependent ioctl (KVM_SET_PMU_EVENT_FILTER) is per
> > VM. In the meantime, considering that for hybrid architecture, maybe in
> > the future there will be a new per vCPU ioctl, or there will be
> > practices to support filter fixed counter by configuring CPUIDs.
> >
> > Based on the above thoughts, for x86, it is not appropriate to make the
> > current per-VM ioctl-based PMU filter a CPU property. Instead, I make it
> > a kvm property and configure it via "-accel kvm,pmu-filter=obj_id".
> >
> > So in summary, it is feasible to use the KVM PMU filter as either a CPU
> > or a KVM property, depending on whether it is used as a CPU feature or a
> > VM feature.
> >
> > The kvm-pmu-filter object, as an abstraction, is general enough to
> > support filter configurations for different scopes (per-CPU or per-VM).
> 
> Per my understanding, the cpus sharing same uarch should share same perf
> events filter. Not sure if there is real requirement to support different
> filters on the CPUs with same arch.
 
The main consideration here is also to align with the underlying ioctl
of the PMU filter, Arm's ioctl is per vCPU and I'm not sure if there
will be a difference between CPUs in the feature.

But this I think could be an arch-specific implementation, x86 needs per
VM then use ¡°-accel kvm,pmu-filter=obj_id¡±, Arm if it does need per vCPU
then it can be set for Arm CPUs via ¡°-cpu host,pmu-filter=obj_id¡±. So
the generic part is this kvm-pmu-filter object itself, where exactly it
should be placed/inserted can be decided by the architecture itself.

Hi @Eric and @Shaoqin, do you agree?


Best Regards,
Zhao


