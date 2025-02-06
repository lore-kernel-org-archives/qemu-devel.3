Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4F6C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 14:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg31N-00023Q-3w; Thu, 06 Feb 2025 09:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tg31I-0001z3-Ef; Thu, 06 Feb 2025 09:38:21 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tg31G-0003yN-6r; Thu, 06 Feb 2025 09:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738852698; x=1770388698;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jfGStSSlY2W8EaMKPfKJE3V47I6s68bEGdj7zqDZJXU=;
 b=HygE2dyndj3Jcwx8ILtFVhchqrK1+CEJfmGTG14lW2sWn9H1Wlgx5WPv
 vCx+q/8SRzRlFJMqL/49xtmB2bN24Y2Ndt42dCkgd7rwXy+4GqjtUka2W
 qXJSPOwFjDJUARxNi7vsdcfCsLsA6e4AVm8rKSch6rMGB9jMiq2iXdMe9
 gW4rbI8ScRXowXIeqzFhzeE3BuO00P5wI4yGXmjXp0Zcqzr56eXohi9zt
 jZklzXGrCCN/tUa0Jejb0Uek+3L0P/z1vVcsVHZfF2oMHW10rMTf4B4Cj
 6AUTCR8zOrY4J2k83itVApzK1Shvni2WUWkewT/4xiq7EzUIOCFTXcbX1 w==;
X-CSE-ConnectionGUID: OFohIQEEQyyMlIxVtv1epA==
X-CSE-MsgGUID: SC6L8JsHRwSlJ9icx+WxSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43213755"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="43213755"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 06:38:14 -0800
X-CSE-ConnectionGUID: dP1RgmONRgiX4KjojGxDhA==
X-CSE-MsgGUID: eLEb1rSlTJu9e1GKfNwPKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111079245"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 06 Feb 2025 06:35:13 -0800
Date: Thu, 6 Feb 2025 22:54:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ++/vQ==?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
Message-ID: <Z6TNMZbonWmsnyM7@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-4-zhao1.liu@intel.com>
 <87zfj01z8x.fsf@pond.sub.org> <Z6SG2NLxxhz4adlV@intel.com>
 <Z6SEIqhJEWrMWTU1@redhat.com> <878qqjqskm.fsf@pond.sub.org>
 <Z6TFr49Cnhe1s4/5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6TFr49Cnhe1s4/5@intel.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

> > Do users need to know how to compute the raw event value from @select
> > and @umask?
> 
> Yes, because it's also a unified calculation. AMD and Intel have
> differences in bits for supported select field, but this calculation
> (which follows from the KVM code) makes both compatible.
> 
> > If yes, is C code the best way?

Sorry, I missed this line. In this patch, there's macro:

+#define X86_PMU_RAW_EVENT(eventsel, umask) (((eventsel & 0xf00UL) << 24) | \
+                                            ((eventsel) & 0xff) | \
+                                            ((umask) & 0xff) << 8)

So could I said something like the following?

+##
+# @KVMPMUX86SelectUmaskEvent:
+#
+# x86 PMU event encoding with select and umask.  Using the X86_PMU_RAW_EVENT
+# macro, the select and umask fields will be encoded into raw foramt and
+# delivered to KVM.
+#
+# @select: x86 PMU event select field, which is a 12-bit unsigned
+#     number.
+#
+# @umask: x86 PMU event umask field.
+#
+# Since 10.0
+##
+{ 'struct': 'KVMPMUX86DefalutEvent',
+  'data': { 'select': 'uint16',
+            'umask': 'uint8' } }
+

Thanks very much!

> > Here's another way:
> > 
> >     bits  0..7 : bits 0..7 of @select
> >     bits  8..15: @umask
> >     bits 24..27: bits 8..11 of @select
> >     all other bits: zero
> >
> 
> Thank you! This is what I want.
> 
> 
> 

