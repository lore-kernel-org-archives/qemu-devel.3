Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7E6EB596C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 06:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq4Bk-00019p-6k; Wed, 11 Feb 2026 01:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq4Bi-00017M-Va
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:59:02 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq4Bh-0000D4-Fz
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770793142; x=1802329142;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tlz+1zgySuPgMimYSKYg3YFEnS/iOtF8w9H5+BS3EMg=;
 b=SLNtYBimEOsd2jpHwuybdYVw9M2FjseSMy8CEaQSxGcEOag7qOJGSf7M
 434EvXTaILzdoC78JI9q28UwONDiBQENItvEH6oV20WY1SpQScQITmdcY
 FUydn8tEIagQlibvi45FBQ67BQ72JGQRZT5rWIVDmuZEEcG7JbX06vTer
 hSDcYv9+yaEi0T83xHtPC+PT4RwMe2wxoiymIGf1ZFaAI1EXjYaWInkey
 1wP9cOHULYaQgN0DraKIk6Tnfb8y4PsLIJli8BNniHgydVQMnELnbqI2B
 zzPCbJtcYeIYAlvCy5WlI4So+G1lbkESQW1DdaAz+UeTrKtdNl3gbbCKH A==;
X-CSE-ConnectionGUID: hGwF+y7dSvCoFsc4DETyVw==
X-CSE-MsgGUID: Zkp53z0VTA2B7E7IQakOZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89521564"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89521564"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:59:00 -0800
X-CSE-ConnectionGUID: d0foFVtuQ5mOPfe2VJz7pQ==
X-CSE-MsgGUID: MPc/pdQTRnyiE7cxM3YY8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212189112"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 10 Feb 2026 22:58:56 -0800
Date: Wed, 11 Feb 2026 15:24:53 +0800
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
Message-ID: <aYwuxfPyExb3Hv8y@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com> <aYtOh9guoiQocdjk@intel.com>
 <0193cb6f-7b73-43c1-ac89-93b426d3983e@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0193cb6f-7b73-43c1-ac89-93b426d3983e@eik.bme.hu>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

> So another way could be to not use properties for internal settings but add
> another set of internal properties for those. These could be set the same
> way but stored in a different hash table and not get mixed with
> introspectable and user changable properties. But maybe that would be too
> much refactoring.

Yes, it may require adding interfaces similar to object_property_add/get/
set, which would need significant changes.

Thanks,
Zhao


