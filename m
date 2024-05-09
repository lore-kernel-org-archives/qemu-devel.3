Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939F8C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 09:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s50AM-0007xS-WF; Thu, 09 May 2024 05:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s50AL-0007wq-88; Thu, 09 May 2024 05:34:17 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s50AI-0003X0-GU; Thu, 09 May 2024 05:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715247255; x=1746783255;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CFpl8Em0ezawD7OPr4h8KLp86UgnW759Zooxx+57uns=;
 b=kYSJdkAmuCOqSZn8NlDXv/qkDl8ehCBQRhsil+0KhsEIptQhZHqOBS52
 9FWWWXR1fgbyFXn17w9+OvkmdfITG3spbPjlvfLKgh1SP/CMJL063+l1N
 T4nwDUy6nmsxkDbExI8BFGgmZiGgEf+4getHKl1rLrCVRuMnR5/RAF6AQ
 rbmya6+Tw53FW7G+QemaMQaUH0/P9+2og3NUIBpHs6Qocg7uEYtbumCEw
 L6ytgYq5hayO8RD8pOZKnAplcdI+bS9cQnP7ukJktvIc1gcSQEgzGeU4o
 Tjg40MJwtDbdT+xefG06QiFYb8U7SVaE+NdB9q91Vbl9dmUuoHqvcUEGR Q==;
X-CSE-ConnectionGUID: +vywL5x4QoiS5J1dxixTWA==
X-CSE-MsgGUID: CvADCq0qRnK6XxEt0J8sMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11285815"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; d="scan'208";a="11285815"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2024 02:34:09 -0700
X-CSE-ConnectionGUID: 8fXg2g47S42AeS/M0WWZuA==
X-CSE-MsgGUID: 84H4yguURAKvB8A4Rf6kBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; d="scan'208";a="33652836"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 09 May 2024 02:34:06 -0700
Date: Thu, 9 May 2024 17:48:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH v9] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Message-ID: <Zjyb43JqMZA+bO4r@intel.com>
References: <20240409024940.180107-1-shahuang@redhat.com>
 <Zh1j9b92UGPzr1-a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh1j9b92UGPzr1-a@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
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

Hi Daniel & Shaoqin,

Since x86 also needs to implement PMU filter feature, though it uses
the different KVM ioctl, we can still make the QEMU API as general as
possible.

To move forward with both ARM and x86, I'd like to discuss my API
thinking with you. ;-)

On Mon, Apr 15, 2024 at 06:29:25PM +0100, Daniel P. Berrangé wrote:
> Date: Mon, 15 Apr 2024 18:29:25 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH v9] arm/kvm: Enable support for
>  KVM_ARM_VCPU_PMU_V3_FILTER
> 
> On Mon, Apr 08, 2024 at 10:49:40PM -0400, Shaoqin Huang wrote:
> > The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
> > which PMU events are provided to the guest. Add a new option
> > `kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
> > Without the filter, all PMU events are exposed from host to guest by
> > default. The usage of the new sub-option can be found from the updated
> > document (docs/system/arm/cpu-features.rst).
> > 
> > Here is an example which shows how to use the PMU Event Filtering, when
> > we launch a guest by use kvm, add such command line:
> > 
> >   # qemu-system-aarch64 \
> >         -accel kvm \
> >         -cpu host,kvm-pmu-filter="D:0x11-0x11"
> 
> I'm still against implementing this one-off custom parsed syntax
> for kvm-pmu-filter values. Once this syntax exists, we're locked
> into back-compatibility for multiple releases, and it will make
> a conversion to QAPI/JSON harder.

Daniel, I understand you mean the new specific string format makes
external API support more complicated, right?

What about the following options:

1. Firstly, add a feature flag option in "-cpu" to enable kvm_filter
feature for CPU:

-cpu host,kvm-pmu-filter

2. Then use "-object kvm-pmu-event" to configure PMU event properties.
Since x86's PMU filter has very complex encoding rules, we need the
following three variants (one for general case, the other two are x86
specific):

- General format:
  -object kvm-pmu-event,action=[allowed|denied],events=[event-list]

  e.g, as Shaoqin's example,
  -object kvm-pmu-event,action=allowed,events=0x11-0x11,0x23-0x23
  -object kvm-pmu-event,action=denied,events=0x23-0x3a

- x86 raw_event encoding format (for single raw format event encoding):
  -object kvm-pmu-event,action=[allowed|denied],mode=0,select="0x01",
          umask="0x3c",fixed-bitmap="0xffffffff"

- x86 masked_event encoding format (for mutiple masked event encoding):
  -object kvm-pmu-event,action=[allowed|denied],mode=masked,select="0x01",
          mask="0x3c",match="0x11",exclude=true|false

The whole API architecture looks more complex, but has the advantage of
being as general as possible and avoiding the introduction of new string
format parsing.

What do you think? Because the most important thing about this feature
is the API design, welcome your comments!

Regards,
Zhao



