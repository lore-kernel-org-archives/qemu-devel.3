Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B19C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 13:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYeV-00053u-NF; Thu, 15 May 2025 09:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFYeP-000511-Cj; Thu, 15 May 2025 09:29:29 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFYeJ-0004eZ-LF; Thu, 15 May 2025 09:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747315764; x=1778851764;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nD4jIMzPEL9GlBRMVD8jm1YlOuSAxd1LZIi/qkLyWyA=;
 b=Fvki2vRJyNjhad6+Qy58SR22nQs5CQQxJa0Cx9BKzB3JNPIDnSy55ykH
 tn+En0eIX4WCUl/vO12QWt8V5yb34oCFqFCYyF90Y8XSlmGmr1O6fJSGE
 PLteH2/0yAxC8QuVi3SHGkqZ7nGzGUK+ZMrxARVx5EgABRSnQVXBpeSIp
 rhVigrm0VnI2RA2pZ5JvRDxj7q79k0vlHmgDJqVnAR2IPiNVukjuWGFDL
 KxUS6qrFQEwmakrdZ0gFJiMprjRDaEjrJeZIrkeHbyEQ1jzueweQonflO
 jqMoZFtcGGNjYPJrPp97ubUUM/94XHqQ98/obgYqzuE13OCCGFcPLNBtk Q==;
X-CSE-ConnectionGUID: NbWoZR5+Sfi047jRu5WFLQ==
X-CSE-MsgGUID: I1ZWHCMeQcmR4zLMMd+kmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="66658082"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="66658082"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 06:29:19 -0700
X-CSE-ConnectionGUID: M8NdgvHtQnKdJ4IAlWQcfw==
X-CSE-MsgGUID: McE69DKsTyyJ1kCYn0ABkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="142386727"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 15 May 2025 06:29:16 -0700
Date: Thu, 15 May 2025 21:50:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Message-ID: <aCXxHEVZb8+ZCW/m@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-9-zhao1.liu@intel.com>
 <e0146386-ccf4-44ba-b58f-0bb4d3317f89@redhat.com>
 <aCS8aHsF+VAuj01D@intel.com>
 <7dec9c8e-93d6-81f0-b075-e29b8ede44a2@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dec9c8e-93d6-81f0-b075-e29b8ede44a2@eik.bme.hu>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Wed, May 14, 2025 at 06:24:03PM +0200, BALATON Zoltan wrote:
> Date: Wed, 14 May 2025 18:24:03 +0200
> From: BALATON Zoltan <balaton@eik.bme.hu>
> Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
>  OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
> 
> On Wed, 14 May 2025, Zhao Liu wrote:
> > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest,
> > > > +                                          s390_pv_guest,
> > > > +                                          S390_PV_GUEST,
> > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > +                                          { TYPE_USER_CREATABLE },
> > > > +                                          { NULL })
> > > 
> > > I'll note that existing callers of OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
> > > happily ignore the line limit and put it into a single line.
> > > 
> > > (which ends up looking better IMHO)
> > 
> > Ok, I'll onor the existing conventions (which I'll apply to other
> > patches as well).
> 
> There are two line limits. If something is clearer on one line you could
> exceed the normal 80 chars and put up to 90 chars on one line for which
> checkpatch will issue a warning that can be ignored for these cases. Over 90
> lines checkpatch will give an error and I think you should not ignore that.

Thank you. This makes sense!

> Maybe try to put as much on one line as possible instead of new line after
> each argument but without exceeding the 80 chars or if the whole line fits
> in 90 chars then use that. Or maybe do not indent second line under ( but
> with 4 spaces then you can fit it in two lines but lines over 90 chars are
> undesirable.

HMM, I understand you mean:

OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest, s390_pv_guest,
    S390_PV_GUEST, CONFIDENTIAL_GUEST_SUPPORT, { TYPE_USER_CREATABLE }, { NULL })

The second line is 82 chars and now I think this version is better.

Thanks,
Zhao


