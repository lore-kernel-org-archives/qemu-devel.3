Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE63EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYFq-0006jH-3i; Thu, 12 Feb 2026 10:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vqYFn-0006iQ-OA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:05:15 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vqYFj-0003Ee-IJ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770908712; x=1802444712;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cGAwdYrhuQktNwpBT6q0pMkeS4Oz1e+uocParwxThc8=;
 b=KiUV4dbKcSZ9rhZkzQY2cetTy3cxRZtVJdtITybJyZRaYh8iEHhfdmW5
 1uDZFQxv6HEBsfvP2aHlHijXrXQrSGHm1SGz7rz+ynI3fCs4oIszEJP9k
 VGYdLHLrp8ANthxMIjCrvYeloRAjV0o4HLZxRFW7QVyK9kZGvwnLcJLGH
 itOqXW7oT5wlwFdOTbonG27M0U75Oqw34Qk1r4NpkTbPcca0K2MSyLZZB
 BDOY5A1nMdEGkAKUUT7umhBFLkeNX1JIJg5BskZabvGklmb+yRz0DyLRt
 YmH3cOkhlkpSvDqqXEkrQrQJ9M7Zq0aV/biGVw2DHu4ozq6zSMUSAXBV4 g==;
X-CSE-ConnectionGUID: iEjUsTaPTNa8bH+c2sXF8Q==
X-CSE-MsgGUID: 7pm957/LQc+GC40hmBXDaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82406837"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="82406837"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 07:05:06 -0800
X-CSE-ConnectionGUID: EjryL0kIS4mH4EQVS49J8g==
X-CSE-MsgGUID: cj3RS5tFTryY7K6NbxGq3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="212655165"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 12 Feb 2026 07:05:02 -0800
Date: Thu, 12 Feb 2026 23:31:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ++/vQ==?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
Message-ID: <aY3yNPRh2qw0tt3q@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com> <aYtOh9guoiQocdjk@intel.com>
 <0193cb6f-7b73-43c1-ac89-93b426d3983e@eik.bme.hu>
 <aYwuxfPyExb3Hv8y@intel.com>
 <cefd333c-9893-47b7-9c1b-1ebd218b734d@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cefd333c-9893-47b7-9c1b-1ebd218b734d@eik.bme.hu>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Feb 11, 2026 at 12:28:13PM +0100, BALATON Zoltan wrote:
> Date: Wed, 11 Feb 2026 12:28:13 +0100
> From: BALATON Zoltan <balaton@eik.bme.hu>
> Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track
>  external user input
> 
> On Wed, 11 Feb 2026, Zhao Liu wrote:
> > > So another way could be to not use properties for internal settings but add
> > > another set of internal properties for those. These could be set the same
> > > way but stored in a different hash table and not get mixed with
> > > introspectable and user changable properties. But maybe that would be too
> > > much refactoring.
> > 
> > Yes, it may require adding interfaces similar to object_property_add/get/
> > set, which would need significant changes.
> 
> Maybe not that part needs significant changes as you could still use a flag
> the same way adding a parameter to object_property_add/get/set to tell it
> should put the propery in the internal hash but then you need to add the
> other hash and maybe related changes. I don't know how much would those be
> but no new interface is needed just extending existing one as you did
> already.

Yes, you're right, the flag-related interfaces in this series provide
enough support. But I haven't quite figured out what the advantages of
using an independent hash table would be, or what problems it could
address... I feel like I need to think about it more :).

Thanks,
Zhao


