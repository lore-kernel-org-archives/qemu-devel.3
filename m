Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D76D2AB0A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 09:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5icv-00025B-66; Tue, 29 Oct 2024 05:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5icr-00024X-FP
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:34:57 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5ico-0005Ac-AF
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730194495; x=1761730495;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iyF6A1sgRes/+ZiuBNspbvQj3dBjXzgUb+GiLIIG9RE=;
 b=dSKHabZiu15Ju4C/kWIzM0edtD3YvKu61euWeKXHb2K4M/vqCH5IDsyL
 +2sdeaZyMnyLmSRlu3ozYjxNEcgxbJblbSbMMMi768uWSBnCE6hCwGJ4n
 cUab1YDeymABwizrKXDaS1WCE/EwKgGbg4q3BCNri3ciy3H+JADb36B38
 mPMDv/kaEa0WM5So3Cayi4231c/scgcjWLNpze6J1iUbtx3Ra3kqEqO52
 R2j/ItJFmk4GS5V84R0xJr6ejiGQN8Ceb3RaUuLJhkcDraj3F0YVQlQ57
 vP51ffORp0hJ+O+HrU13i4B/8flbDuKVM3bNZCBuLdvkaWKPW3xo8htuT A==;
X-CSE-ConnectionGUID: Z/5AxfqAQqiX4hNdLvn2Cw==
X-CSE-MsgGUID: HuTA0il+QNmiNHW+zjWbOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40359856"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="40359856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 02:34:52 -0700
X-CSE-ConnectionGUID: 2gnySOCTTZGbZHfF/vnpAw==
X-CSE-MsgGUID: FEzgbkhFRGycjiKJKaAf+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="112710455"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 02:34:50 -0700
Date: Tue, 29 Oct 2024 17:29:44 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com
Subject: Re: [PATCH 1/6] target/i386: Add AVX512 state when AVX10 is supported
Message-ID: <ZyCrCEmNbzjWVFHp@linux.bj.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-2-tao1.su@linux.intel.com>
 <3adc6dab-25c2-4303-b382-153e843123bf@redhat.com>
 <Zx9Yof/RWnub4Lmi@linux.bj.intel.com>
 <f31b8bd3-07f1-4661-ae11-fc7fd2d6a90d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f31b8bd3-07f1-4661-ae11-fc7fd2d6a90d@redhat.com>
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 29, 2024 at 09:49:39AM +0100, Paolo Bonzini wrote:
> On 10/28/24 10:25, Tao Su wrote:
> > On Mon, Oct 28, 2024 at 09:41:14AM +0100, Paolo Bonzini wrote:
> > > On 10/28/24 03:45, Tao Su wrote:
> > > > AVX10 state enumeration in CPUID leaf D and enabling in XCR0 register
> > > > are identical to AVX512 state regardless of the supported vector lengths.
> > > > 
> > > > Given that some E-cores will support AVX10 but not support AVX512, add
> > > > AVX512 state components to guest when AVX10 is enabled.
> > > > 
> > > > Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> > > > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > > > ---
> > > >    target/i386/cpu.c | 14 ++++++++++++++
> > > >    target/i386/cpu.h |  2 ++
> > > >    2 files changed, 16 insertions(+)
> > > > 
> > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > index 1ff1af032e..d845ff5e4e 100644
> > > > --- a/target/i386/cpu.c
> > > > +++ b/target/i386/cpu.c
> > > > @@ -7177,6 +7177,13 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
> > > >            }
> > > >            if (env->features[esa->feature] & esa->bits) {
> > > >                xcr0 |= 1ull << i;
> > > > +            continue;
> > > > +        }
> > > > +        if (i == XSTATE_OPMASK_BIT || i == XSTATE_ZMM_Hi256_BIT ||
> > > > +            i == XSTATE_Hi16_ZMM_BIT) {
> > > 
> > > Can you confirm that XSTATE_ZMM_Hi256_BIT depends on AVX10 and not
> > > AVX10-512?
> > > 
> > 
> > Sorry, I should attach AVX10.2 spec [*].
> > 
> > In 3.1.3, spec said Intel AVX10 state enumeration in CPUID leaf 0xD and
> > enabling in XCR0 register are identical to Intel AVX-512 regardless of the
> > maximum vector length supported.
> > 
> > So XSTATE_ZMM_Hi256_BIT doesn't depend on AVX10-512.
> > 
> > [*] https://cdrdv2.intel.com/v1/dl/getContent/828965
> 
> Ok, thanks.
> 
> Another related issue is that kvm_cpu_xsave_init() is using esa->feature and
> esa->bits, which misses these three features.

Yes, it has issue if AVX512F is not reported but AVX10 is reported, thanks for
pointing out!

> 
> I think we need to change the code to not look at esa->feature at all. I'll
> send a v2 of your series.
> 

Yes, ExtSaveArea can't set more feature bits, which makes the code a bit ugly.
Looking forward to the better implementation :-)


