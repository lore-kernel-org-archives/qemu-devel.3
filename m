Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95AED21257
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 08:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1MAH-0000jT-Vo; Thu, 17 Oct 2024 04:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1MAE-0000ik-TF; Thu, 17 Oct 2024 04:47:22 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1MAC-0001ih-I2; Thu, 17 Oct 2024 04:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729154840; x=1760690840;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HsLEW4HgVoUz0dFhMj/EOIE9JpIpYLwKlGcb+fRpufY=;
 b=RrP6pHhnZvi/WLnzP6Ck9kddWJHoUsN9eUx8Y+18Pp7KDkyHVq/gXLhd
 zBJWsLWiYqmVqzlS1UnR/YKzZpvAsDh2aCG/icvuCSAgag/p4fj/rhqb3
 dQ1NElxMjx9F2XFdfcUgRrp/4MNzIj220Ogjr25P/awLPYCkALWGBj/Ns
 y4WZTfeW/2GFxhIV+ET2GstholeSkVEW34b10JLBhKy7wPY5NDwLUrj2d
 fHlJspUQMt3mF/uZEhzhZW+DaF8pCh3sqsodb9WaaqgNHtfD49rUHU63J
 CozvbO7+jreMiyyyFQR2R1lJn0W19DO3bxjK+Iua4GpO7VAvOcxihOqaP g==;
X-CSE-ConnectionGUID: dzFFabxUT4apUS44itsDow==
X-CSE-MsgGUID: SeNuohEPQVWymotFAskEKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="32558614"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; d="scan'208";a="32558614"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 01:47:16 -0700
X-CSE-ConnectionGUID: rqL9S5NFSX+oGbTS8PYSGg==
X-CSE-MsgGUID: Jv0QMZpEQGiTQItHO8gPjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; d="scan'208";a="79303678"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 17 Oct 2024 01:47:13 -0700
Date: Thu, 17 Oct 2024 17:03:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, pbonzini@redhat.com,
 imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <ZxDS4L8vSr3HfFIh@intel.com>
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <cc83fc31-7a77-4e32-a861-3c1dc8592a04@intel.com>
 <2f6b952d-4c21-4db5-9a8a-84a0c10feca8@bytedance.com>
 <a48fcd78-d1c4-4359-bc18-d04147a93f50@intel.com>
 <ZwyRsq4EIooifRvb@intel.com>
 <bbcfcbbd-1666-4e97-ae18-f47202d89009@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbcfcbbd-1666-4e97-ae18-f47202d89009@intel.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
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

On Thu, Oct 17, 2024 at 04:18:06PM +0800, Xiaoyao Li wrote:
> Date: Thu, 17 Oct 2024 16:18:06 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for
>  logical processors in the physical package
> 
> On 10/14/2024 11:36 AM, Zhao Liu wrote:
> > > > > On 10/9/2024 11:56 AM, Chuang Xu wrote:
> > > > > > When QEMU is started with:
> > > > > > -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> > > > > > -smp 180,sockets=2,dies=1,cores=45,threads=2
> > > > > > 
> > > > > > On Intel platform:
> > > > > > CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
> > > > > > logical processors in the physical package".
> > > > > > 
> > > > > > When executing "cpuid -1 -l 1 -r" in the guest, we obtain a
> > > > > > value of 90 for
> > > > > > CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
> > > > > > executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
> > > > > > CPUID.04H.EAX[31:26], which matches the expected result.
> > > > > > 
> > > > > > As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
> > > > > > we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> > > > > > integer too. Otherwise we may encounter unexpected results in guest.
> > > > > > 
> > > > > > For example, when QEMU is started with CLI above and xtopology
> > > > > > is disabled,
> > > > > > guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/
> > > > > > (1+CPUID.04H.EAX[31:26]) to
> > > > > > calculate threads-per-core in detect_ht(). Then guest will get
> > > > > > "90/ (1+63)=1"
> > > > > > as the result, even though threads-per-core should actually be 2.
> > > > > 
> > > > > It's kernel's bug instead.
> > > > > 
> > > > > In 1.5.3 "Sub ID Extraction Parameters for initial APIC ID" of
> > > > > "Intel 64 Architecture Processor Topology Enumeration" [1], it is
> > > > > 
> > > > >    - SMT_Mask_Width = Log2(RoundToNearestPof2(CPUID.1:EBX[23:16])/
> > > > > (CPUID.(EAX=4,ECX=0):EAX[31:26]) + 1))
> > > > > 
> > > > > The value of CPUID.1:EBX[23:16] needs to be *rounded* to the
> > > > > neartest power-of-two integer instead of itself being the
> > > > > power-of-two.
> > > > > 
> > > > > This also is consistency with the SDM, where the comment for bit
> > > > > 23-16 of CPUID.1:EBX is:
> > > > > 
> > > > >    The nearest power-of-2 integer that is not smaller than EBX[23:16] is
> > > > >    the number of unique initial APIC IDs reserved for addressing
> > > > >    different logical processors in a physical package.
> > > > > 
> > > > > What I read from this is, the nearest power-of-2 integer that is not
> > > > > smaller than EBX[23:16] is a different thing than EBX[23:16]. i.e.,
> > > > 
> > > > Yes, when I read sdm, I also thought it was a kernel bug. But on my
> > > > 192ht spr host, the value of CPUID.1:EBX[23:16] was indeed rounded up
> > > > 
> > > > to the nearest power of 2 by the hardware. After communicating with
> > > > Intel technical support staff, we thought that perhaps the description
> > > > in sdm
> > > > 
> > > > is not so accurate, and rounding up CPUID.1:EBX[23:16] to the power of 2
> > > > in qemu may be more in line with the hardware behavior.
> > > 
> > > I think above justification is important. We need to justify our changes
> > > with the fact and correct reason.
> > > 
> > > I somehow agree to set EBX[23:16] to a value of power-of-2, because the
> > > 1.5.3 "Sub ID Extraction Parameters for initial APIC ID" of "Intel 64
> > > Architecture Processor Topology Enumeration" spec says
> > > 
> > >      CPUID.1:EBX[23:16] represents the maximum number of addressable IDs
> > >      (initial APIC ID) that can be assigned to logical processors in a
> > >      physical package. The value may not be the same as the number of
> > >      logical processors that are present in the hardware of a physical
> > >      package.
> > > 
> > > It uses the word "may not".
> > 
> > IMO, I don't quite understand your confusion regarding this. I've already
> > explained the meaning of addressable ID, and the spec you referenced also
> > clarifies its significance. The reason for this modification is not
> > because of the two words "may not".
> > 
> > Whether it is "be" or "not be" the same as the number of logical
> > processors, the essence is that due to topology, the actual number of
> > initial IDs that can be accommodated in the APIC ID may exceed the number
> > of logical processors.
> 
> I have the confusion because no matter from SDM:
> 
>   Bit 23-16: Maximum number of addressable IDs for logical processors in
>              this physical package*
> 
>   * The nearest power-of-2 integer that is not smaller than EBX[23:16]
>     is the number of unique initial APIC IDs reserved for addressing
>     different logical processors in a physical package.
> 
> or from "Intel 64 Architecture Processor Topology Enumeration" spec，(Jan
> 2018, revision 1.1), 1.5.3 "sub ID Extraction Parameters for Inital APIC ID"
> 
>   RoundToNearestPof2(CPUID.1:EBX[23:16])
> 
> or from "Intel 64 Architecture Processor Topology Enumeration" spec，(April
> 2023, revision 2.0), 1.6.1 Legacy Extraction Algorithm
> 
> https://cdrdv2-public.intel.com/775917/intel-64-architecture-processor-topology-enumeration.pdf
> 
>   "MaximumLogicalProcessorIDsPerPackage" is calculated by rounding
>    CPUID.01H.EBX[23:16] to nearest power of 2.
> 
> what I read from them is that EBX[23:16] is a different thing than
> pow2ceil(EBX[23:16]) and EBX[23:16] doesn't need to be power-of-2, but the
> patch are trying to make it power-of-2.

Yes, no one requires it must be power-of-2. But power-of-2 is just
the result, not the reason.

The core point is not power-of-2, but is the meaning of EBX[23:16].

Sorry, I have to re-emphasize:

Pls remember it's not real number of logical processors per package,
and it's "addressable ID", which is the initial APIC ID. The maximum
capacity of addressable ID is calculated by the APIC layout, and the
final value is “power-of-2”. The calculation by APIC ID or pow2ceil()
are mathematically equivalent. That's the way to get addressable IDs.

The spec is expressed in such a way to help software understands this
value, while the QEMU is designed to emulate hardware behavior.

> Then I consult it with Intel internal architect. I was told that EBX[23:16]
> used to be that software was to round to the next power of 2. However,
> software had issues a long time ago because applications could then compute
> the wrong power of 2 based on APIC ID holes or some applications would use
> it directly (without round it up to power-of-2).
> So intel became to report exact power-of-2 and this behavior is not
> documented.

Again, I suggest you think in terms of the meaning of number of
addressable IDs, it's not a matter of how power-of-2 is calculated, you
can choose to calculate number of addressable IDs in other ways, but
the final value is still a power of 2.

-Zhao


