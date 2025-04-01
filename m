Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BCCC36008
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 07:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzW83-00016S-4q; Tue, 01 Apr 2025 03:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tzW7y-000151-PH; Tue, 01 Apr 2025 03:33:42 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tzW7w-0001Y1-W1; Tue, 01 Apr 2025 03:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743492821; x=1775028821;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sS4rHhY6syIz0P638wU0Dc52eTVGG8/lD+UZkHM565c=;
 b=TS20kYspruriRoEB2p9wHoQCbPAW1e/6swRjLE2DxNLM7McN1lM20KwT
 yexkmmSSA2GIlWpaHn1JBA00XEK0GPTnxqwoOBIzFBZYJjLN79RdAuTSi
 nx0p3CDZh2QzD//LGEKEStpxChtwNIxo8R8/MLbU+9aFUP+v8Ke7GG50+
 QF5sHz3qWJuBih5WV7w3cUdSFZNruduYUfuSBSmpdmPjjDi+gcApkcy4x
 Y5o7ZzvDUHSOiptXMMBJsvNoNaQevlLHe1XPEbL5dKwwUy0oII+IkVZ/m
 0zJBKmNK4tKwfifn3XiEXu+L4NgNp9a2Lop405yKb05vSS6ozD3o4ufhK A==;
X-CSE-ConnectionGUID: 8mEVWn/LTeqakPMLOGfpyw==
X-CSE-MsgGUID: NIpeR8lsSUy/1SdfRoKIbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44928857"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; d="scan'208";a="44928857"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 00:33:37 -0700
X-CSE-ConnectionGUID: AR3XhP4ATMWtzCG8fT0big==
X-CSE-MsgGUID: 8DDo80f7Tx+XNRe1i+nFEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; d="scan'208";a="131023314"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 01 Apr 2025 00:33:33 -0700
Date: Tue, 1 Apr 2025 15:53:53 +0800
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
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
Message-ID: <Z+ubkUrUMgvo2y/h@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-4-zhao1.liu@intel.com>
 <87zfj01z8x.fsf@pond.sub.org> <Z6SG2NLxxhz4adlV@intel.com>
 <Z6SEIqhJEWrMWTU1@redhat.com> <878qqjqskm.fsf@pond.sub.org>
 <Z6TFr49Cnhe1s4/5@intel.com> <Z6TNMZbonWmsnyM7@intel.com>
 <87o6zdhpk7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6zdhpk7.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
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

> > +##
> > +# @KVMPMUX86SelectUmaskEvent:
> > +#
> > +# x86 PMU event encoding with select and umask.  Using the X86_PMU_RAW_EVENT
> > +# macro, the select and umask fields will be encoded into raw foramt and
> > +# delivered to KVM.
> 
> Doc comments are for the QMP reference manual, i.e. for users of QMP.
> Explaining the QMP interface in terms of its implementation in QEMU is
> not nice.

Thank you! I could add doc comments in kvm-pmu.h and delete redundant
comments from QMP reference manual.

Regards,
Zhao


