Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6749D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 07:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhQ8-0004tK-IQ; Wed, 03 Dec 2025 02:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQhQ7-0004sy-Eb
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:37:03 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQhQ5-0002Mn-O8
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764747422; x=1796283422;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gam9OfGxugucsnHmzv6jS28VQx00K5Zo85K0AfjR5kM=;
 b=RAeXZFnH3aut7pJ4RL4pbLZv0QIAJBzGxC5UHTWt+2g9DNiI4pcHa4BQ
 gSJ6Sv1rfzE819u1qCPbW15+hjAdnivwFvLoUGPoHx1Gd0YlbIcKzGh5d
 NnDt0KZGbARZTuF1UtTYO8xjY+EHlgx3LGLWaEmoTq26eBMrfuZf2XIri
 OHQ2caMCxPpIgJYowRDQtCiJvyceWEOtPj9KSaJwgrkgnGhokGUPXZ/kp
 I/ZtWkY6/ksxSJQ9IqRyDshn4DYoCU6/L0d8YgGS9xHCuls8iPcX/bLa7
 c0z7ah25OQvVdtHJMibpuSecOJLEKz5K0LjAEb3/nPp98oqzppzRYxs8V g==;
X-CSE-ConnectionGUID: Ya69IZXqQq6lENNDh3JV7A==
X-CSE-MsgGUID: bLTrKPkcRFaRnuYKL3kIEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70589660"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="70589660"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 23:36:59 -0800
X-CSE-ConnectionGUID: bwdHCBTDQXGYqXfwRTZ5Kw==
X-CSE-MsgGUID: IdPsXWdTSl6gGmFHnAy9fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="225277840"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 02 Dec 2025 23:36:54 -0800
Date: Wed, 3 Dec 2025 16:01:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 17/23] i386/cpu: Migrate MSR_IA32_PL0_SSP for FRED and
 CET-SHSTK
Message-ID: <aS/uYR8n7j4OjK/p@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
 <20251118034231.704240-18-zhao1.liu@intel.com>
 <3103289d-e86c-486d-a3c0-95d7615099c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3103289d-e86c-486d-a3c0-95d7615099c6@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

On Mon, Dec 01, 2025 at 06:01:48PM +0100, Paolo Bonzini wrote:
> Date: Mon, 1 Dec 2025 18:01:48 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v4 17/23] i386/cpu: Migrate MSR_IA32_PL0_SSP for FRED
>  and CET-SHSTK
> 
> On 11/18/25 04:42, Zhao Liu wrote:
> > From: "Xin Li (Intel)" <xin@zytor.com>
> > 
> > Both FRED and CET-SHSTK need MSR_IA32_PL0_SSP, so add the vmstate for
> > this MSR.
> > 
> > When CET-SHSTK is not supported, MSR_IA32_PL0_SSP keeps accessible, but
> > its value doesn't take effect. Therefore, treat this vmstate as a
> > subsection rather than a fix for the previous FRED vmstate.
> > 
> > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> > Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes Since v3:
> >   - New commit.
> > ---
> >   target/i386/machine.c | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> > 
> > diff --git a/target/i386/machine.c b/target/i386/machine.c
> > index 45b7cea80aa7..0a756573b6cd 100644
> > --- a/target/i386/machine.c
> > +++ b/target/i386/machine.c
> > @@ -1668,6 +1668,31 @@ static const VMStateDescription vmstate_triple_fault = {
> >       }
> >   };
> > +static bool pl0_ssp_needed(void *opaque)
> > +{
> > +    X86CPU *cpu = opaque;
> > +    CPUX86State *env = &cpu->env;
> > +
> > +#ifdef TARGET_X86_64
> > +    if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
> > +        return true;
> > +    }
> > +#endif
> > +
> > +    return !!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK);
> 
> Can you just make it return "!!(env->pl0_ssp)"?  If all of these bits are
> zero the MSR will not be settable, and this way you can migrate VMs as long
> as they don't use PL0_SSP.

Yes, it's a good idea.

Thanks,
Zhao



