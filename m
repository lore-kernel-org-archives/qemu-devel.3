Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A53DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 06:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuQRp-0000YV-3D; Tue, 18 Mar 2025 02:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuQRl-0000Xc-TW; Tue, 18 Mar 2025 02:29:07 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuQRj-0001SN-3T; Tue, 18 Mar 2025 02:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742279343; x=1773815343;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=yDjX7iO/tHyzUkk9I5iUG24ELhwDMQkqlnkovU0PyFE=;
 b=OahvoG4sIgvAsTJ3jDShwh4BfHYRTpnJyGSR2JTq93dPb6LV6Waj+S1S
 2Rvja1erff/Un56EPF5qjvUpuIG+PdM7OJmCrU+FcFnj1UY+pc9y9Xug3
 QnPC3temqkEH7z69Sl5I6N8SceCtXr9CRVACaiaeFlxFo86RUUNpqpcMK
 Zy3hQBWYdIps0hkNntCKA0aCUNYiACkXpedAvBjXVKhNPmMw+Ncwa4Pgo
 SRvp5DmfrY1bhyz0mmXpsIqjSqhA79rxNgimumtHkknvjQOGlDlkO391e
 O8zY7PbDoTGnAL9OyDEGQ9KWdOhg0ykBh9kE++JXxINvppQhtrPpv8HNa g==;
X-CSE-ConnectionGUID: RS0RYRM7RfqlndzyFZONUA==
X-CSE-MsgGUID: JEzzLNF/Q/WmjaBXDimUhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="42649905"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="42649905"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 23:29:01 -0700
X-CSE-ConnectionGUID: +oqpOGPaRTuKKRcmy2xxzQ==
X-CSE-MsgGUID: FM4KggcnT6WfpbuDXeq/2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="126819541"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 17 Mar 2025 23:29:00 -0700
Date: Tue, 18 Mar 2025 14:49:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 00/17] rust/vmstate: Clean up, fix, enhance & test
Message-ID: <Z9kXaefNpG6XYNyl@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <CABgObfZaGU9C47BemJQubhmwaOiDDPaWVBC=ebAxGvU_NiRU-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZaGU9C47BemJQubhmwaOiDDPaWVBC=ebAxGvU_NiRU-w@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

On Mon, Mar 17, 2025 at 06:20:15PM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Mar 2025 18:20:15 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 00/17] rust/vmstate: Clean up, fix, enhance & test
> 
> On Mon, Mar 17, 2025 at 3:52 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > Hi,
> >
> > This series is in preparation for HPET migration support (in particular,
> > to support varray and vmstate_validate), and it also cleans up and fixes
> > the current vmstate! However, there is still the gap from being a ‘stable’
> > vmstate.
> 
> Already a great improvement!
> 
> I quickly went through things that I was planning to do in a slightly
> different way, but overall this is great work.  Give me a day or two
> to finish reviewing and testing, most of it can already be applied to
> qemu-rust or even to 10.0.

Thanks for your quick feedback! I think the main open now is about the
best way to implement `field_exists`... pls see my patch 13 reply.

I can quickly refresh v2 to help you apply!

Regards,
Zhao


