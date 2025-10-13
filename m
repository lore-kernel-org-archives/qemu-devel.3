Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0451ECCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 07:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8CXy-0001eh-Fk; Mon, 13 Oct 2025 03:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8CXw-0001eF-DW; Mon, 13 Oct 2025 03:00:40 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8CXr-0002QK-JA; Mon, 13 Oct 2025 03:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760338836; x=1791874836;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TwRmDYCfqedlrRkRKtNhpPjaMyBXRJ69Lq00zKHhL+M=;
 b=L3QW0sWjlYF/rzLOgBwWjpXEQgea550RfQDnAb6NBdiqVUHk2VnKW8QP
 OTQFfvii+Z0CBg/poQ00VYxLObNNZ1tjNnu5Y+Re4sevAmgB9dlrkqNhN
 9By4HtKjRm2eOqzKwmwpD7O215esjg/hs3x9zXBxqv7SRL1uvjbVXvkxp
 PTDmMnZWR8KP1jhRzpjQfN94ZZWrS5GeBNX+jKDJytZGuA1wMb8y2GIJQ
 TkhwmuEho5q08hw9TNRccKKWoVYVabBq11dvrCC2NejqcdrNM5k6Onstv
 VbdfV8TmoRNckVXPTt2manlkQxuc+JEzddv2LluF6MEEdOc6Aoo2oQrCU Q==;
X-CSE-ConnectionGUID: UQUBpumBSoOtPPPj2ZFQeg==
X-CSE-MsgGUID: xe3UmPBSR96Do0u5fIug8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73817725"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="73817725"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 00:00:29 -0700
X-CSE-ConnectionGUID: hnpqhbFORkeJV2lCcLSGnw==
X-CSE-MsgGUID: 76LzoSzYR5SndkQOCSuo7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="181960118"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 13 Oct 2025 00:00:27 -0700
Date: Mon, 13 Oct 2025 15:22:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 hector.cao@canonical.com, lk@c--e.de, berrange@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [RFT PATCH v2 0/2] Fix cross migration issue with missing
 features: pdcm, arch-capabilities
Message-ID: <aOyouIh//WY+EkKb@intel.com>
References: <20250923104136.133875-1-pbonzini@redhat.com>
 <aNVrAkx+ahn7ZRns@intel.com>
 <8a754d6c-1d8c-43d7-b3f8-a4b3e194d30e@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a754d6c-1d8c-43d7-b3f8-a4b3e194d30e@tls.msk.ru>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Oct 10, 2025 at 08:40:56PM +0300, Michael Tokarev wrote:
> Date: Fri, 10 Oct 2025 20:40:56 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: Re: [RFT PATCH v2 0/2] Fix cross migration issue with missing
>  features: pdcm, arch-capabilities
> 
> On 9/25/25 19:17, Zhao Liu wrote:
> > On Tue, Sep 23, 2025 at 12:41:34PM +0200, Paolo Bonzini wrote:
> > > Date: Tue, 23 Sep 2025 12:41:34 +0200
> > > From: Paolo Bonzini <pbonzini@redhat.com>
> > > Subject: [RFT PATCH v2 0/2] Fix cross migration issue with missing
> > >   features: pdcm, arch-capabilities
> > > X-Mailer: git-send-email 2.51.0
> > > 
> > > Add two compatibility properties to restore legacy behavior of machine types
> > > prior to QEMU 10.1.  Each of them addresses the two changes to CPUID:
> > > 
> > > - ARCH_CAPABILITIES should not be autoenabled when the CPU model specifies AMD
> > >    as the vendor
> > > 
> > > - specifying PDCM without PMU now causes an error, instead of being silently
> > >    dropped in cpu_x86_cpuid.
> > > 
> > > Note, I only tested this lightly.
> > 
> > Sorry for late.
> > 
> > I found the previous 2 fixes were merged into stable 10.0:
> > 
> > 24778b1c7ee7aca9721ed4757b0e0df0c16390f7
> > 3d26cb65c27190e57637644ecf6c96b8c3d246a3
> > 
> > Should stable 10.0 revert these 2 fixes, to ensure migration
> > compatibility?

Sorry for late...just return from vacation.

> Now when I think about it.
> 
> There were at least 2 point releases of 10.0.x (10.0.4 & 10.0.5)
> with these 2 patches already.

EMM, it seems 10.0.x (x < 4) can't migrate to 10.0.y (4 <= y <= 5),
right? If so, could we treat this behavior as a regression?

> Reverting them in 10.0 will make
> 10.0 to be non-migratable with itself (10.0.5 can't be migrated
> to 10.0.6 if we'll release 10.0.6 with these 2 patches reverted).
> 
> Also, as far as I can see (and I asked about this some 5 times
> already, with no one answering - is it that difficult?) - we
> should pick this series (pdcm, arch-capabilities) to 10.1.x stable
> series too, since we can't migrate from previous versions to 10.1
> which has the two changes mentioned above.

I think so. in this series, Paolo added compat options in pc_compat_10_0
so it should be picked to stable v10.1.

> It looks to me - since the breakage is already done, and both 10.0
> and 10.1 is broken, we should declare the current situation as a
> status quo, and do the following:
> 
> 1. keep the above mentioned 24778b1c7ee7a and 3d26cb65c27190e5 in
>    10.0.x (instead of reverting them);
> 
> 2. pick up this 2 patches (fix cross migration issue with missing
>    pdcm, arch-capabilities) to 10.1.x (it should be done either way,
>    I think);

IIUC, if we picked current compat options to stable v10.1, then stable
v10.1 requires previous v10.0 sets the pdcm & arch-cap bits (i.e., do
not apply the fixes or revert the previous fix).

So it seems the reverts are unavoidable on v10.0?

(Let's see what Paolo and the other maintainers think.)

> 3. on top of these 2 "missing features: pdcm, arch-capabilities",
>    make the crossing line for before-10.0, not for before-10.1 series, -
>    ie, consider 10.0 *also* has these properties, but 9.2 and before
>    are not.
> 
> This too will make 10.0.5 => 10.0.6 non-migrateable, just like if
> I'll revert 24778b1c7ee7a and 3d26cb65c27190e5 in 10.0.  But this way
> we will also have these bugs fixed in 10.0.  And all subsequent
> versions of 10.0 and 10.1 will be migratable again.
> 
> Please, don't be quiet this time, - I need your comments for this
> matter, because I don't understand well enough how migration works.
> 
> Cc'ing Peter too, because I'm stuck here and no my questions are
> getting answered.. maybe he can help to at least clear some questions.

This issue is indeed quite tricky. Sometimes people (including myself)
assume that backporting fixes to the stable branch can avoid adding a
compat option. Now it seems the compat option is the better choice, as
users need to ensure migration rather than downtime before upgrading to
the stable version :-(.

Thanks,
Zhao


