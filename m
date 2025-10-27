Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DBBCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJtX-00075j-5U; Mon, 27 Oct 2025 05:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDJtR-00075O-SQ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:52:01 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDJtO-0001LW-2u
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761558718; x=1793094718;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pOktcS9kwkPjEXa37/dQ2r0t6/Ys/P8rTUy3GS729DY=;
 b=h0TE609Nv/de7XTYNDdqdDaD9HYI1GfIltrfl3AXF8y4xKH33viDs7Nc
 //nGpTuL5IfvgTj9tf10RsZcfnZvh1gwVmMFD+3XkuNLBaXib+F4ttL0D
 gNoPS0RLt/JQAaM+KQvpJeM8vyk19Zud6L/Muw9eN2NbndHmyTl6jjx16
 1LrTSeb//0pDpXt7JQ5I579CX+ZUjGGTW/zpa08RHU0peSi1MYqaM8Qsz
 IX6Sftz1/DZJMu7Ub9N/4r532joDcw5xje2gYRZNxc20LTlJJ5FfvsMou
 dYfqnbE3X3ZOUVxPiTBQu33irwcjFZpthKTkhW/HKnnPMM7Q/ggV6XGGS Q==;
X-CSE-ConnectionGUID: lghZXlHYS7SEatyLdL515w==
X-CSE-MsgGUID: vifE+hOdTpGMsQyefytWmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66248327"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="66248327"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 02:51:52 -0700
X-CSE-ConnectionGUID: hhfk4mV1TS25CUZXzNCQ3Q==
X-CSE-MsgGUID: DmQaWATJSeqDO7CLnF366Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="222213035"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 27 Oct 2025 02:51:49 -0700
Date: Mon, 27 Oct 2025 18:13:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 09/20] i386/cpu: Fix supervisor xstate initialization
Message-ID: <aP9F5wpOh3zOF1rr@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-10-zhao1.liu@intel.com>
 <5d501d23-74d3-45aa-a51e-52ef59002e1a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d501d23-74d3-45aa-a51e-52ef59002e1a@intel.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Mon, Oct 27, 2025 at 03:55:30PM +0800, Xiaoyao Li wrote:
> Date: Mon, 27 Oct 2025 15:55:30 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v3 09/20] i386/cpu: Fix supervisor xstate initialization
> 
> On 10/24/2025 2:56 PM, Zhao Liu wrote:
> > From: Chao Gao <chao.gao@intel.com>
> > 
> > Arch lbr is a supervisor xstate, but its area is not covered in
> > x86_cpu_init_xsave().
> > 
> > Fix it by checking supported xss bitmap.
> > 
> > In addition, drop the (uint64_t) type casts for supported_xcr0 since
> > x86_cpu_get_supported_feature_word() returns uint64_t so that the cast
> > is not needed. Then ensure line length is within 90 characters.
> > 
> > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > Signed-off-by: Chao Gao <chao.gao@intel.com>
> > Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   target/i386/cpu.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 5cd335bb5574..1917376dbea9 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -9707,20 +9707,23 @@ static void x86_cpu_post_initfn(Object *obj)
> >   static void x86_cpu_init_xsave(void)
> >   {
> >       static bool first = true;
> > -    uint64_t supported_xcr0;
> > +    uint64_t supported_xcr0, supported_xss;
> >       int i;
> >       if (first) {
> >           first = false;
> >           supported_xcr0 =
> > -            ((uint64_t) x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32) |
> > +            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) |
> 
> missing the "<< 32" here,

Yes, good catch.


