Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9312E7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 15:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTje2-0006S6-4Q; Fri, 03 Jan 2025 10:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tTjdz-0006RZ-Hj
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:31:23 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tTjdw-0003Pb-BR
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735918281; x=1767454281;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UxzyePBqFZ2gnpbI9K6VX5Sh4Z2rlQhso6W0tOBdMno=;
 b=ZmfIPtph16enWLBQMBLRbPWwRg8thFo1q35V4nlMWf4WqWtovjTvLoI5
 9Ahe6ZEynoYzMzgMkxwV7H4kEc7Bdad6DMLrR1oV5JQDDcwlpPKqBUwX3
 QwgW/UD7e62dwLLtqN0W5s3N+/S8kFLt+uQ3LwVP4kilnEFIJmHp5Hunv
 31OMt7cnO2tgu9hD/AV6QBr/uuymTBqfS0xUmcqL7/4zrj4FkPqlqOr98
 +zcU1kOTj8KJaF/Sgu3ss/TzRvLXubwTOTd3bFvSczDyToIP2y64F1U6z
 YcGDdhkTCGs9w9C/nVK6mDeByjFKsH9gHau3R7ohSBcrYSc2k/5eGUBEt g==;
X-CSE-ConnectionGUID: mmbOQcxOTv6HUdlsnhsnMw==
X-CSE-MsgGUID: bxiyqF5zRZW7mGSUnukcVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="39847831"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; d="scan'208";a="39847831"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2025 07:31:17 -0800
X-CSE-ConnectionGUID: duyNQYX0Sv6TDimdUERQGA==
X-CSE-MsgGUID: JRXouV0sStKa4cn3i3YZDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; d="scan'208";a="132668761"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 03 Jan 2025 07:31:13 -0800
Date: Fri, 3 Jan 2025 23:50:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: Rob Herring <robh@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrang" <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daud <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v6 0/4] i386: Support SMP Cache Topology
Message-ID: <Z3gHKEalN6sLv8Mf@intel.com>
References: <20241219083237.265419-1-zhao1.liu@intel.com>
 <44212226-3692-488b-8694-935bd5c3a333@redhat.com>
 <Z2t2DuMBYb2mioB0@intel.com> <20250102145708.0000354f@huawei.com>
 <CAL_JsqKeA4dSwO40VgARVAiVM=w1PU8Go8GJYv4v8Wri64UFbw@mail.gmail.com>
 <20250102180141.00000647@huawei.com> <Z3efFsigJ6SxhqMf@intel.com>
 <20250103140457.00004c4b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103140457.00004c4b@huawei.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
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

> > > > You asked me for the opposite though, and I described how you can
> > > > share the cache. If you want a cache per thread, then you probably
> > > > want a node per thread.
> > > > 
> > > > Rob
> > > >   
> > > 
> > > Hi Rob,
> > > 
> > > That's right, I made the mistake in my prior message, and you
> > > recalled correctly. I wanted shared caches between two threads,
> > > though I have missed your answer before, just found it.
> > >   
> > 
> > Thank you all!
> > 
> > Alireza, do you know how to configure arm node through QEMU options?
> 
> Hi Zhao, do you mean the -smp param?
>

I mean do you know how to configure something like "a node per thread"
by QEMU option? :-) I'm curious about the relationship between "node"
and the SMP topology on the ARM side in the current QEMU. I'm not sure
if this "node" refers to the NUMA node.

Thanks,
Zhao


