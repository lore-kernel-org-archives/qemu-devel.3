Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF2CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW8CU-0003BE-Vv; Tue, 23 Jul 2024 01:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1sW8CL-00038h-Cm; Tue, 23 Jul 2024 01:36:29 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1sW8CJ-0003Vw-7M; Tue, 23 Jul 2024 01:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721712987; x=1753248987;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Yv7QWl5KiOQ2ytrvPTyxY+6rm8poKp2aySleLBGCXC0=;
 b=n3IW9TVeuQlk5tYhAkIy1kk+CkWGl/EYq2nDuSLGcYchPjuyo8DwfZZn
 dn5e1X4XTRSzaHS21MC2yII4VXn2u5WrpbUItZfe3aryj1e7028vzJ45a
 2/zt+n5HlJu9ABYQQl/nOT86v4vHlnA2zLa0BMComicbylyQek6gtpiie
 G49TmYxllWmmG9ZVJJ5PYB0W92xJz2O73E6xm13vjYJ48r09bDS3Y40Y1
 xuEOQvvfGGB0MgN/nF/h3oz9e5iPEfyw6JNpveP8J6b8sGkMp/KLTEYGW
 geletmGTaRmZlvI4bVcsIxSWrsSmZkGw24XXdiy7kUf7nOXaoa8WYv3L1 w==;
X-CSE-ConnectionGUID: Mz1kCR6CQlyc+VuBeeCuIg==
X-CSE-MsgGUID: nMrY3KtYT8Gt4NWbyGugyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30738597"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="30738597"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 22:36:23 -0700
X-CSE-ConnectionGUID: x5bM7NWzTXelasgvt55Ckg==
X-CSE-MsgGUID: dK+RGnoiQFKQycIih7GbgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="89575997"
Received: from unknown (HELO [10.238.3.39]) ([10.238.3.39])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 22:36:17 -0700
Message-ID: <38231df8-81d7-4dd6-9ef9-a72fda228176@linux.intel.com>
Date: Tue, 23 Jul 2024 13:36:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/5] i386/kvm: Support event with select&umask format in KVM
 PMU filter
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yuan Yao <yuan.yao@intel.com>, Xiong Zhang <xiong.y.zhang@intel.com>,
 Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
References: <20240710045117.3164577-1-zhao1.liu@intel.com>
 <20240710045117.3164577-4-zhao1.liu@intel.com>
 <f18ab76c-abbe-4599-9631-603853bcfa0b@linux.intel.com>
 <Zpomm3hLhSM5O6em@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <Zpomm3hLhSM5O6em@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 7/19/2024 4:40 PM, Zhao Liu wrote:
> Hi Dapeng,
>
> On Thu, Jul 18, 2024 at 01:28:25PM +0800, Mi, Dapeng wrote:
>
> [snip]
>
>>> +        case KVM_PMU_EVENT_FMT_X86_DEFAULT: {
>>> +            uint64_t select, umask;
>>> +
>>> +            ret = qemu_strtou64(str_event->u.x86_default.select, NULL,
>>> +                                0, &select);
>>> +            if (ret < 0) {
>>> +                error_setg(errp,
>>> +                           "Invalid %s PMU event (select: %s): %s. "
>>> +                           "The select must be a "
>>> +                           "12-bit unsigned number string.",
>>> +                           KVMPMUEventEncodeFmt_str(str_event->format),
>>> +                           str_event->u.x86_default.select,
>>> +                           strerror(-ret));
>>> +                g_free(event);
>>> +                goto fail;
>>> +            }
>>> +            if (select > UINT12_MAX) {
>>> +                error_setg(errp,
>>> +                           "Invalid %s PMU event (select: %s): "
>>> +                           "Numerical result out of range. "
>>> +                           "The select must be a "
>>> +                           "12-bit unsigned number string.",
>>> +                           KVMPMUEventEncodeFmt_str(str_event->format),
>>> +                           str_event->u.x86_default.select);
>>> +                g_free(event);
>>> +                goto fail;
>>> +            }
>>> +            event->u.x86_default.select = select;
>>> +
>>> +            ret = qemu_strtou64(str_event->u.x86_default.umask, NULL,
>>> +                                0, &umask);
>>> +            if (ret < 0) {
>>> +                error_setg(errp,
>>> +                           "Invalid %s PMU event (umask: %s): %s. "
>>> +                           "The umask must be a uint8 string.",
>>> +                           KVMPMUEventEncodeFmt_str(str_event->format),
>>> +                           str_event->u.x86_default.umask,
>>> +                           strerror(-ret));
>>> +                g_free(event);
>>> +                goto fail;
>>> +            }
>>> +            if (umask > UINT8_MAX) {
>> umask is extended to 16 bits from Perfmon v6+. Please notice we need to
>> upgrade this to 16 bits in the future. More details can be found here.
>> [PATCH V3 00/13] Support Lunar Lake and Arrow Lake core PMU - kan.liang
>> (kernel.org)
>> <https://lore.kernel.org/all/20240626143545.480761-1-kan.liang@linux.intel.com/>
> It's tricky...now I referred the RAW_EVENT format in tools/testing/
> selftests/kvm/include/x86_64/pmu.h, which is used in KVM PMU and is
> compatible with AMD and Intel.
>
> The current KVM PMU filter for raw code doesn't define the layout in
> the standard API like masked entries (KVM_PMU_ENCODE_MASKED_ENTRY), but
> actually uses the RAW_EVENT format. So I even plan to move RAW_EVENT
> macro into arch/x86/include/uapi/asm/kvm.h...
For the raw event format, I suppose user should know the event layout and
would directly input the raw event code, qemu may not concern this.


>
> For the changes you mentioned, I think it would be better for the raw
> code layout design not to break RAW_EVENT, so that AMD and Intel can
> equally use the same macro to encode. Is it possible for a unified
> layout macro?
>
> What about extending RAW_EVENT as the following example? I understand
> the umask2 is at bit 40-47.
>
> #define X86_PMU_RAW_EVENT(eventsel, umask) (((eventsel & 0xf00UL) << 24) | \
>                                             ((eventsel) & 0xff) | \
>                                             ((umask) & 0xff) << 8) | \
> 					    ((umask & 0xff00UL << 32)

It's always good if Intel and AMD can share same event layout, the extended
umask field occupies bits [40:47]. So I think we'd better follow this for
the RAW_EVENT as well.


>
> Thanks,
> Zhao
>

