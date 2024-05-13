Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E2C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PK8-0007uA-GY; Mon, 13 May 2024 02:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s6PK6-0007tk-Cv; Mon, 13 May 2024 02:38:10 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s6PK3-0005LC-Fg; Mon, 13 May 2024 02:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715582288; x=1747118288;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zNTZwvBDmX+sT3qmwN7yy8aF9Vt4yfZqmuSijXDvB14=;
 b=Pvqac4UeM+QG86uY9yOJ4VWyVb1yYh7noYKDjoDJjLHLsjE+Xs/+Vqju
 IVh/alMg1Ksu5lBPFOuMdmuE+cdjdUAkcp2i8/0FOuKPugJPm1xpilERP
 iw0t2+VF7G4ADw2cNHLBcGrEC9+jpRxv1z8mUI3Vci81PDDvnSFQgGleO
 GzB9Yz0xyqNF3MSdmq3tJuP6o5iAzF5ZY2Qz1o8NoaNrs+aHUN8lBE0kv
 Jt7xxsZvgDfPPqv8/cLwF9f6M+vx+4tF6WilCmz0/kBQuPqAK9iWgXnW0
 aDJcLXG5fhSHuCZKDGCZTdNe4TeE35a46u0/0MWPCi73KCFpJ0aEn0fac w==;
X-CSE-ConnectionGUID: fWk09ZRhQ1OwWTnjASbW5Q==
X-CSE-MsgGUID: fFFAUQ54SQ25iWexnaZpIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11625817"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; d="scan'208";a="11625817"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2024 23:38:03 -0700
X-CSE-ConnectionGUID: LHlwyNm/SG6aO/vBA/VsJA==
X-CSE-MsgGUID: hNjwTF5uRYeX7W54AvK6cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; d="scan'208";a="30269659"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 12 May 2024 23:37:59 -0700
Date: Mon, 13 May 2024 14:52:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH v9] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Message-ID: <ZkG4nlwRnvz9oUXX@intel.com>
References: <20240409024940.180107-1-shahuang@redhat.com>
 <Zh1j9b92UGPzr1-a@redhat.com> <Zjyb43JqMZA+bO4r@intel.com>
 <ZjyZ1ZV7BGME_bY9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjyZ1ZV7BGME_bY9@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

Hi Daniel,

> Please describe it in terms of a QAPI definition, as that's what we're
> striving for with all QEMU public interfaces. Once the QAPI design is
> agreed, then the -object mapping is trivial, as -object's JSON format
> supports arbitrary QAPI structures.

Thank you for your guidance!

I rethought and and modified my previous proposal:

Let me show the command examples firstly:
  * Add a single event:
    (x86) -object kvm-pmu-event,id=e0,action=allow,format=x86-default,\
                  select=0x3c,umask=0x00
    (arm or general) -object kvm-pmu-event,id=e1,action=deny,\
                             format=raw,code=0x01
 
  * Add a counter bitmap:
    (x86) -object kvm-pmu-counter,id=cnt,action=allow,type=x86-fixed,\
                  bitmap=0xffff0000
 
  * Add an event list (must use Json syntax format):
   (x86) -object '{"qom-type":"kvm-pmu-event-list","id"="filter0","action"="allow","format"="x86-default","events=[{"select"=0x3c,"umask"=0x00},{"select"=0x2e,"umask"=0x4f}]'
   (arm) -object '{"qom-type":"kvm-pmu-event-list","id"="filter1","action"="allow","format"="raw","events"=[{"code"=0x01},{"code"=0x02}]'


The specific JSON definitions are as follows (IIUC, this is "in terms of
a QAPI definition", right? ;-)): 
* Define PMU event and counter bitmap with JSON format:
  - basic filter action:

  { 'enum': 'KVMPMUFilterAction',
    'prefix': 'KVM_PMU_FILTER_ACTION',
    'data': ['deny', 'allow' ] }

  - PMU counter:

  { 'enum': 'KVMPMUCounterType',
    'prefix': 'KVM_PMU_COUNTER_TYPE',
    'data': [ 'x86-fixed' ] }

  { 'struct': 'KVMPMUX86FixedCounter',
    'data': { 'bitmap': 'uint32' } }

  - PMU events (total 3 formats):

  # 3 encoding formats: "raw" is compatible with shaoqin's ARM format as
  # well as the x86 raw format, and could support other architectures in
  # the future.
  { 'enum': 'KVMPMUEventEncodeFmt',
    'prefix': 'KVM_PMU_EVENT_ENCODE_FMT',
    'data': ['raw', 'x86-default', 'x86-masked-entry' ] }

  # A general format.
  { 'struct': 'KVMPMURawEvent',
    'data': { 'code': 'uint64' } }

  # x86-specific
  { 'struct': 'KVMPMUX86DefalutEvent',
    'data': { 'select': 'uint16',
              'umask': 'uint16' } }

  # another x86 specific
  { 'struct': 'KVMPMUX86MaskedEntry',
    'data': { 'select': 'uint16',
              'match': 'uint8',
              'mask': 'uint8',
              'exclude': 'bool' } }

  # And their list wrappers:
  { 'struct': 'KVMPMURawEventList',
    'data': { 'events': ['KVMPMURawEvent'] } }

  { 'struct': 'KVMPMUX86DefalutEventList',
    'data': { 'events': ['KVMPMUX86DefalutEvent'] } }

  { 'struct': 'KVMPMUX86MaskedEntryList',
    'data': { 'events': ['KVMPMUX86MaskedEntryList'] } }


Based on the above basic structs, we could provide 3 new more qom-types:
  - 'kvm-pmu-counter': 'KVMPMUFilterCounter'

  # This is a single object option to configure PMU counter
  # bitmap filter.
  { 'union': 'KVMPMUFilterCounter',
    'base': { 'action': 'KVMPMUFilterAction',
              'type': 'KVMPMUCounterType' },
    'discriminator': 'type',
    'data': { 'x86-fixed': 'KVMPMUX86FixedCounter' } }


  - 'kvm-pmu-counter': 'KVMPMUFilterCounter'

  # This option is used to configure a single PMU event for
  # PMU filter.
  { 'union': 'KVMPMUFilterEvent',
    'base': { 'action': 'KVMPMUFilterAction',
              'format': 'KVMPMUEventEncodeFmt' },
    'discriminator': 'format',
    'data': { 'raw': 'KVMPMURawEvent',
              'x86-default': 'KVMPMUX86DefalutEvent',
              'x86-masked-entry': 'KVMPMUX86MaskedEntry' } }


  - 'kvm-pmu-event-list': 'KVMPMUFilterEventList'

  # Used to configure multiple events.
  { 'union': 'KVMPMUFilterEventList',
    'base': { 'action': 'KVMPMUFilterAction',
              'format': 'KVMPMUEventEncodeFmt' },
    'discriminator': 'format',
    'data': { 'raw': 'KVMPMURawEventList',
              'x86-default': 'KVMPMUX86DefalutEventList',
              'x86-masked-entry': 'KVMPMUX86MaskedEntryList' } }


Compared to Shaoqin's original format, kvm-pmu-event-list is not able to
enumerate events continuously (similar to 0x00-0x30 before), and now
user must enumerate events one by one individually.

What do you think about the above 3 new commands?

Thanks and Best Regards,
Zhao


