Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A937C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 08:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUivl-0001SQ-2g; Fri, 19 Jul 2024 04:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sUivi-0001OA-A6; Fri, 19 Jul 2024 04:25:30 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sUivf-0005L2-7q; Fri, 19 Jul 2024 04:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721377527; x=1752913527;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Cbq1XzEG/Z5bPHmoZpGA9EqItTHH1azGryyZCO1RmSk=;
 b=KR0Lh/ebrmxNsvE+kPOeX/zm5Uxpd4V+GTohKJAdnXQgG6oN7skhfRaY
 wjmAFXbtOLNl4956dONxRK94/vfaxxZXyPusSNjKQ3VJlE9skZBb4RpNW
 Fm8fZt72hwF7fw6IF5EcW2L/4kTogWGNc29AdgVOtJyggV8vgQJpXYE4S
 HXt3f7uAEoTG7BW3PvBzAN8OHKdFATWrw1lpDNg+FkeC+EleSDDzi/wJi
 8pjfysjW8aj0/kZGM9ke/EnvG5WXraFo+4dzEA/cIq7hMysg3CeVQ5A/X
 M+rp5uk68R46lVIGYgUor3EDKlWNNl/htPOZ89cQtNmQXVnimzAaZ41WU g==;
X-CSE-ConnectionGUID: hp6U6GPWS3W/FoAjDusF5Q==
X-CSE-MsgGUID: Rvm21ovETTubbxgfm1mwMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="19114661"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; d="scan'208";a="19114661"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 01:25:23 -0700
X-CSE-ConnectionGUID: FEQBshkLRX6+VaqwSaN65w==
X-CSE-MsgGUID: c8dJjs78SHitlazWSzRUWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; d="scan'208";a="50784003"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 19 Jul 2024 01:25:16 -0700
Date: Fri, 19 Jul 2024 16:40:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yuan Yao <yuan.yao@intel.com>,
 Xiong Zhang <xiong.y.zhang@intel.com>, Mingwei Zhang <mizhang@google.com>,
 Jim Mattson <jmattson@google.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 3/5] i386/kvm: Support event with select&umask format in
 KVM PMU filter
Message-ID: <Zpomm3hLhSM5O6em@intel.com>
References: <20240710045117.3164577-1-zhao1.liu@intel.com>
 <20240710045117.3164577-4-zhao1.liu@intel.com>
 <f18ab76c-abbe-4599-9631-603853bcfa0b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18ab76c-abbe-4599-9631-603853bcfa0b@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

Hi Dapeng,

On Thu, Jul 18, 2024 at 01:28:25PM +0800, Mi, Dapeng wrote:

[snip]

> > +        case KVM_PMU_EVENT_FMT_X86_DEFAULT: {
> > +            uint64_t select, umask;
> > +
> > +            ret = qemu_strtou64(str_event->u.x86_default.select, NULL,
> > +                                0, &select);
> > +            if (ret < 0) {
> > +                error_setg(errp,
> > +                           "Invalid %s PMU event (select: %s): %s. "
> > +                           "The select must be a "
> > +                           "12-bit unsigned number string.",
> > +                           KVMPMUEventEncodeFmt_str(str_event->format),
> > +                           str_event->u.x86_default.select,
> > +                           strerror(-ret));
> > +                g_free(event);
> > +                goto fail;
> > +            }
> > +            if (select > UINT12_MAX) {
> > +                error_setg(errp,
> > +                           "Invalid %s PMU event (select: %s): "
> > +                           "Numerical result out of range. "
> > +                           "The select must be a "
> > +                           "12-bit unsigned number string.",
> > +                           KVMPMUEventEncodeFmt_str(str_event->format),
> > +                           str_event->u.x86_default.select);
> > +                g_free(event);
> > +                goto fail;
> > +            }
> > +            event->u.x86_default.select = select;
> > +
> > +            ret = qemu_strtou64(str_event->u.x86_default.umask, NULL,
> > +                                0, &umask);
> > +            if (ret < 0) {
> > +                error_setg(errp,
> > +                           "Invalid %s PMU event (umask: %s): %s. "
> > +                           "The umask must be a uint8 string.",
> > +                           KVMPMUEventEncodeFmt_str(str_event->format),
> > +                           str_event->u.x86_default.umask,
> > +                           strerror(-ret));
> > +                g_free(event);
> > +                goto fail;
> > +            }
> > +            if (umask > UINT8_MAX) {
> 
> umask is extended to 16 bits from Perfmon v6+. Please notice we need to
> upgrade this to 16 bits in the future. More details can be found here.
> [PATCH V3 00/13] Support Lunar Lake and Arrow Lake core PMU - kan.liang
> (kernel.org)
> <https://lore.kernel.org/all/20240626143545.480761-1-kan.liang@linux.intel.com/>

It's tricky...now I referred the RAW_EVENT format in tools/testing/
selftests/kvm/include/x86_64/pmu.h, which is used in KVM PMU and is
compatible with AMD and Intel.

The current KVM PMU filter for raw code doesn't define the layout in
the standard API like masked entries (KVM_PMU_ENCODE_MASKED_ENTRY), but
actually uses the RAW_EVENT format. So I even plan to move RAW_EVENT
macro into arch/x86/include/uapi/asm/kvm.h...

For the changes you mentioned, I think it would be better for the raw
code layout design not to break RAW_EVENT, so that AMD and Intel can
equally use the same macro to encode. Is it possible for a unified
layout macro?

What about extending RAW_EVENT as the following example? I understand
the umask2 is at bit 40-47.

#define X86_PMU_RAW_EVENT(eventsel, umask) (((eventsel & 0xf00UL) << 24) | \
                                            ((eventsel) & 0xff) | \
                                            ((umask) & 0xff) << 8) | \
					    ((umask & 0xff00UL << 32)

Thanks,
Zhao


