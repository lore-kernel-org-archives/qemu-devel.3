Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5E9C369AA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 08:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stNSd-0005QL-Tx; Wed, 25 Sep 2024 04:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1stNSc-0005PR-BO; Wed, 25 Sep 2024 04:33:22 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1stNSZ-0008Os-9Z; Wed, 25 Sep 2024 04:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727253199; x=1758789199;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UTcln1KFBK7MFrcaJYe3yuRWnXHRMJdd+GUaX7PtpJk=;
 b=bVbGfu9GK4LYbzpitLsu7sSGz7KfdaljRMl/qeViIiu6ZCg8OP8P2M88
 Hg2b4rQf/oW4z/+ACoOzgUxpVwCsqLMqWPLffzTIJIyTzdBalY6YIgwRF
 nVANIcizCAPhtlUT4Zrp9KzoNqlX09z4YoH3/Sk09MSL7+XKGcNSwg94i
 egj1nV5CC5OA7HR09FEMRTp9mVmzPbmSQkDSeiqoSyfGGwN7mep1K+i49
 TkjR8MmMeM32kIZfavXBCDBFLpzthNpASQKpCktg+W78ZvBLuvVFExDaj
 FHugtFfQD6zTECfLW7Cl/ySiBitQd92J64WuInZ77np+FH62L+hjVmHhE A==;
X-CSE-ConnectionGUID: i6/seoBkTa+B3Ekg16Qw0g==
X-CSE-MsgGUID: vtFPWxY0S3+9kkIZt5G9og==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="29173398"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; d="scan'208";a="29173398"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2024 01:33:14 -0700
X-CSE-ConnectionGUID: okhitTIxSxSw0rJzj+QotQ==
X-CSE-MsgGUID: xu4++olyRHaOEUIFJvEFfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; d="scan'208";a="71341526"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 25 Sep 2024 01:33:12 -0700
Date: Wed, 25 Sep 2024 16:49:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <ZvPOj82NvTbGlxsV@intel.com>
References: <20240918131815.8543-1-xuchuangxclwt@bytedance.com>
 <ZuxtmjZBGGwNaVwl@intel.com>
 <20240920130827.751ccfb1@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920130827.751ccfb1@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
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

On Fri, Sep 20, 2024 at 01:08:27PM +0200, Igor Mammedov wrote:
> Date: Fri, 20 Sep 2024 13:08:27 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v3] i386/cpu: fixup number of addressable IDs for
>  logical processors in the physical package
> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
> 
> On Fri, 20 Sep 2024 02:29:46 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Hi Chuang and Igor,
> > 
> > Sorry for late reply,
> > 
> > On Wed, Sep 18, 2024 at 09:18:15PM +0800, Chuang Xu wrote:
> > > Date: Wed, 18 Sep 2024 21:18:15 +0800
> > > From: Chuang Xu <xuchuangxclwt@bytedance.com>
> > > Subject: [PATCH v3] i386/cpu: fixup number of addressable IDs for logical
> > >  processors in the physical package
> > > X-Mailer: git-send-email 2.24.3 (Apple Git-128)
> > > 
> > > When QEMU is started with:
> > > -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> > > -smp 180,sockets=2,dies=1,cores=45,threads=2
> > > 
> > > Try to execute "cpuid -1 -l 1 -r" in guest, we'll obtain a value of 90 for
> > > CPUID.01H.EBX[23:16], while the expected value is 128. And Try to
> > > execute "cpuid -1 -l 4 -r" in guest, we'll obtain a value of 63 for
> > > CPUID.04H.EAX[31:26] as expected.
> > > 
> > > As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
> > > we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> > > integer too. Otherwise we may encounter unexpected results in guest.
> > > 
> > > For example, when QEMU is started with CLI above and xtopology is disabled,
> > > guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> > > calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> > > as the result, even though theads-per-core should actually be 2.
> > > 
> > > So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> > > to solve the unexpected result.
> > > 
> > > Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> > > Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> > > Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> > > ---
> > >  target/i386/cpu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 4c2e6f3a71..3710ae5283 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -6417,7 +6417,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> > >          }
> > >          *edx = env->features[FEAT_1_EDX];
> > >          if (threads_per_pkg > 1) {
> > > -            *ebx |= threads_per_pkg << 16;
> > > +            *ebx |= pow2ceil(threads_per_pkg) << 16;  
> > 
> > Yes, the fix is right.
> > 
> > About the "Maximum number of addressable IDs", the commit 88dd4ca06c83
> > ("i386/cpu: Use APIC ID info to encode cache topo in CPUID[4]")
> > introduced the new way to calculate.
> > 
> > The pow2ceil() works for current SMP topology, but may be wrong on
> > hybrid topology, as the reason I listed in the commit message:
> > 
> > > The nearest power-of-2 integer can be calculated by pow2ceil() or by
> > > using APIC ID offset/width (like L3 topology using 1 << die_offset [3]).  
> > 
> > > But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
> > > are associated with APIC ID. For example, in linux kernel, the field
> > > "num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID. And for
> > > another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
> > > matched with actual core numbers and it's calculated by:
> > > "(1 << (pkg_offset - core_offset)) - 1".  
> > 
> > Using APIC ID offset to calculate is the hardware's approach, so I tried
> > to use APIC ID instead of pow2ceil() and replaced all pow2ceil() case.
> 
> Well, hybrid case needs some more explanation then.
> 
> 'pow2ceil(threads_per_pkg) << 16' - does exactly what SDM says for CPUID.01H.EBX[23:16]
> 
> Can you point to a spec that confirms that above is wrong and
> explain in more details how hybrid case is supposed to work
> and where it's documented?
>  

This is mainly about the meaning of "addressable ID". There's a spec
"Intel 64 Architecture Processor Topology Enumeration" [1].

In the section 1.5.3, it mentions the "addressable ID" of CPUID.01H.
EBX[23:16] indicates the "initial APIC ID". And for CPUID.04H:EAX[bits
31:26], that field is "core_id", which is the part of initial APIC ID.

Therefore, "maximum number of addressable IDs" indicates the maximum
number of IDs that each subfield of the APIC ID (we create based on the
smp topology) can hold, which is related to width.

For example, if the width of the APIC sub ID for the thread level is 2,
then it will hold a maximum of 4 sub IDs. For the smp system, the
sub-topology fields of the APIC IDs are filled, so pow2ceil() is always
valid.

For hybrid, there will be holes in the sub fields, for example, 4 E
cores form a module and a P core is exclusive to a module, for the core
field of the E core's APIC ID, the width of the core field is at least 2
to accommodate the IDs of the 4 cores, while the P core, though only 1
bit width is needed, still uses the same width as the E core in order to
align with the E core. In this case, pow2ceil() fails.

And the example I mentioned before ("on Alder Lake P, the CPUID.04H:EAX[
bits 31:26] is not matched with actual core numbers and it's calculated
by: '(1 << (pkg_offset - core_offset)) - 1'."), has the same reason,
that's because the APIC ID layout has the holes, and the possible APIC
IDs are more than actual cores.

[1]: https://cdrdv2-public.intel.com/759067/intel-64-architecture-processor-topology-enumeration.pdfi

Regards,
Zhao


