Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF7CD13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 09:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5M79-0000kg-IF; Mon, 28 Oct 2024 05:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5M76-0000kC-HX
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 05:32:40 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5M73-0008Qx-TW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 05:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730107958; x=1761643958;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6glx1IQAWXfJMCLLoObF1HTPHIwF0MFfykDO9trMQsQ=;
 b=Ckpzm4v9oVdv4DpXartoO8+iIRfa7TRY+/h1MfvoV+YS4ipoMPbLZVtq
 eEtBmbUifpxGj0cwkDd2wwx9P8gWaKq2Srwy2RLLicFz/gX1GB6ntXb3V
 EUMKSQ4IfdNXoQL5MtoeldykNKQlJdHfMiw6gRRPhBiIeZ0Sr/aYMIAUJ
 eqJ0Ic1LBnEbDt/Y3I4Ph/HIw+7FRgWECLzcwYs5LeSgX/KQLg9JPhOex
 TprYmrzndiDQOcMPTHaX1DZBldf8ZCC60od9dP1yTevvR75VpoBHCm7ei
 Adrk+l8sodpmVJXGRwAUh37icMwkVKmwkR4dxoq095wG4qkJgRNypH46E w==;
X-CSE-ConnectionGUID: Twos2KP0QNSSM+8Qi8mI8w==
X-CSE-MsgGUID: srWba/wjRxOssu7w2/2RVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29471368"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29471368"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 02:32:34 -0700
X-CSE-ConnectionGUID: /5VMM0b8QKqPI3wk05Yxew==
X-CSE-MsgGUID: XxZAJP4kQ0qR1xlcCpoAbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="86702344"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 02:31:01 -0700
Date: Mon, 28 Oct 2024 17:25:53 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com
Subject: Re: [PATCH 1/6] target/i386: Add AVX512 state when AVX10 is supported
Message-ID: <Zx9Yof/RWnub4Lmi@linux.bj.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-2-tao1.su@linux.intel.com>
 <3adc6dab-25c2-4303-b382-153e843123bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3adc6dab-25c2-4303-b382-153e843123bf@redhat.com>
Received-SPF: none client-ip=198.175.65.20;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 28, 2024 at 09:41:14AM +0100, Paolo Bonzini wrote:
> On 10/28/24 03:45, Tao Su wrote:
> > AVX10 state enumeration in CPUID leaf D and enabling in XCR0 register
> > are identical to AVX512 state regardless of the supported vector lengths.
> > 
> > Given that some E-cores will support AVX10 but not support AVX512, add
> > AVX512 state components to guest when AVX10 is enabled.
> > 
> > Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > ---
> >   target/i386/cpu.c | 14 ++++++++++++++
> >   target/i386/cpu.h |  2 ++
> >   2 files changed, 16 insertions(+)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 1ff1af032e..d845ff5e4e 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -7177,6 +7177,13 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
> >           }
> >           if (env->features[esa->feature] & esa->bits) {
> >               xcr0 |= 1ull << i;
> > +            continue;
> > +        }
> > +        if (i == XSTATE_OPMASK_BIT || i == XSTATE_ZMM_Hi256_BIT ||
> > +            i == XSTATE_Hi16_ZMM_BIT) {
> 
> Can you confirm that XSTATE_ZMM_Hi256_BIT depends on AVX10 and not
> AVX10-512?
> 

Sorry, I should attach AVX10.2 spec [*].

In 3.1.3, spec said Intel AVX10 state enumeration in CPUID leaf 0xD and
enabling in XCR0 register are identical to Intel AVX-512 regardless of the
maximum vector length supported.

So XSTATE_ZMM_Hi256_BIT doesn't depend on AVX10-512.

[*] https://cdrdv2.intel.com/v1/dl/getContent/828965


