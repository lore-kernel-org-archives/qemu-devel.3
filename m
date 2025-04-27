Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D09C369D5
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 07:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8wED-00049m-F9; Sun, 27 Apr 2025 03:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8wEB-00049W-EY; Sun, 27 Apr 2025 03:15:03 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8wE8-0006pM-Qr; Sun, 27 Apr 2025 03:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745738101; x=1777274101;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aLKBRMi982qUAHpHdxX4Pn/tcuPuoLKos+FcQs/PFQ8=;
 b=Hc3qcgoIu6Zx5Nb/4ltYK4Veh6Cr92YMR3qUdfsZoL5Se/7ZcR1LbAcV
 PKvv1bzwNX2TwPO5l8gNuI+Oh+88B2HFSu3Rl5e4gsu+saUpcENA696tF
 HS8eMRGTXx0sNWn77CCyiGkQ8jcbB631NA7p94bGEg9qzUx3wOJXNlF2V
 iDOX58mIDhRL6OFKVFu7fwYwiYs+RBXuS+gfRPK9vf5JLS2Z0JYWiv7we
 MuxRBnXoYFAJ2IGc6A4GxZC42stEJCnbEFn8sATFaTTWftzeLyl4gJ/GE
 ycu9bHlPFJfEerepIFMgevVMBJ/W9GFgt79b3JbU7OGA7gMfelXAj7zJ/ Q==;
X-CSE-ConnectionGUID: 4Ry/3JVJRrCleWaSh0w+8Q==
X-CSE-MsgGUID: R9LuVs54Qjy7HbUdfzPvxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="47255935"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="47255935"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2025 00:14:57 -0700
X-CSE-ConnectionGUID: yiYQh6xbR5mx5fsKnfCVjg==
X-CSE-MsgGUID: +JKhKX8pQWayxyAvjVHFBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="156477006"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 27 Apr 2025 00:14:53 -0700
Date: Sun, 27 Apr 2025 15:35:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
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
Subject: Re: [PATCH 5/5] i386/kvm: Support fixed counter in KVM PMU filter
Message-ID: <aA3eVdwujSmqKAKu@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-6-zhao1.liu@intel.com>
 <6a93fa6b-d38d-48ac-9cde-488765238247@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a93fa6b-d38d-48ac-9cde-488765238247@linaro.org>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.738,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> >   static void kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
> >   {
> >       object_class_property_add_enum(oc, "action", "KvmPmuFilterAction",
> > @@ -116,6 +139,14 @@ static void kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
> >                                 NULL, NULL);
> >       object_class_property_set_description(oc, "events",
> >                                             "KVM PMU event list");
> > +
> > +    object_class_property_add(oc, "x86-fixed-counter", "uint32_t",
> > +                              kvm_pmu_filter_get_fixed_counter,
> > +                              kvm_pmu_filter_set_fixed_counter,
> > +                              NULL, NULL);
> > +    object_class_property_set_description(oc, "x86-fixed-counter",
> > +                                          "Enablement bitmap of "
> > +                                          "x86 PMU fixed counter");
> 
> Adding that x86-specific field to all architectures is a bit dubious.

Similarly, do you think that it would be a good idea to wrap x86 related
codes in "#if defined(TARGET_I386)"? Like I said in this reply:

https://lore.kernel.org/qemu-devel/aA3TeaYG9mNMdEiW@intel.com/


