Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92581D2446B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 04:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6v8-0006UH-BD; Fri, 11 Oct 2024 00:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sz6v6-0006Tp-Qj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 00:06:29 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sz6v4-0007Dg-GV
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 00:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728619586; x=1760155586;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pmhUn37a+zGP9NJwDxKGimua04LfrRf1ZOIV6NgRpkE=;
 b=ZpInKaXBDeU++8e47x4HvQIfS0pe5HxP+pmXUbcdsQcXF+O5m9Fd1NFF
 9bIbXc7rZpkj/Y7mF8Vn2nzXGMV4PUBJSPEtoRVHKvTRrpWLdP4yW+QpB
 ePR2Hr1z+Yn9V7FAFNcihyiCknAJtYRTM+7i54tkRUa+bY7kxEOnaovPQ
 l8io6PP240C1dON6EtkvD/vP9OmAtcc8j0bL/PceN9inzw0wGiiVu27D+
 6vukf9uPaazvjjD6ZebZNETuBqvaF1TEfqJlFB0nvWyKyZur4t+Zsw93h
 4ukK9lHu/hPsJFy2uidxO1hzyLmYzkXNu6bAwaiKQyC+daMbFHUEMCOYr A==;
X-CSE-ConnectionGUID: e0IGQYQiR5mVMOY8nXpRRg==
X-CSE-MsgGUID: L0AIVsHNTrCIJvzEinrFkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="38593368"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; d="scan'208";a="38593368"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2024 21:06:22 -0700
X-CSE-ConnectionGUID: MORqKw7cRBO6Ir+v3w0r2A==
X-CSE-MsgGUID: VFbReQmPQJSoaRl58OGDpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; d="scan'208";a="76999513"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 10 Oct 2024 21:06:20 -0700
Date: Fri, 11 Oct 2024 12:22:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chao Gao <chao.gao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jmattson@google.com,
 pawan.kumar.gupta@linux.intel.com, jon@nutanix.com,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] target/i386: Add more features enumerated by CPUID.7.2.EDX
Message-ID: <ZwioCPNusih5f8zS@intel.com>
References: <20240919051011.118309-1-chao.gao@intel.com>
 <ZwY1AeJPlrniISB1@intel.com> <ZwY69phzk3GpGvsh@intel.com>
 <9bd5659c-6066-46f9-a096-10f585f8561e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd5659c-6066-46f9-a096-10f585f8561e@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
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

On Thu, Oct 10, 2024 at 03:17:16PM +0200, Paolo Bonzini wrote:
> Date: Thu, 10 Oct 2024 15:17:16 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH] target/i386: Add more features enumerated by
>  CPUID.7.2.EDX
> 
> On 10/9/24 10:12, Chao Gao wrote:
> > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > index 85ef7452c0..18ba958f46 100644
> > > > --- a/target/i386/cpu.c
> > > > +++ b/target/i386/cpu.c
> > > > @@ -1148,8 +1148,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> > > >       [FEAT_7_2_EDX] = {
> > > >           .type = CPUID_FEATURE_WORD,
> > > >           .feat_names = {
> > > > -            NULL, NULL, NULL, NULL,
> > > > -            NULL, "mcdt-no", NULL, NULL,
> > > > +            "intel-psfd", "ipred-ctrl", "rrsba-ctrl", "ddpd-u",
> > > > +            "bhi-ctrl", "mcdt-no", NULL, NULL,
> > > 
> > > IIUC, these bits depend on "spec-ctrl", which indicates the presence of
> > > IA32_SPEC_CTRL.
> > > 
> > > Then I think we'd better add dependencies in feature_dependencies[].
> > 
> > (+ kvm mailing list)
> > 
> > Thanks for pointing that out. It seems that any of these bits imply the
> > presence of IA32_SPEC_CTRL. According to SDM vol4, chapter 2, table 2.2,
> > the 'Comment' column for the IA32_SPEC_CTRL MSR states:
> > 
> >    If any one of the enumeration conditions for defined bit field positions holds.
> > 
> > So, it might be more appropriate to fix KVM's handling of the
> > IA32_SPEC_CTRL MSR (i.e., guest_has_spec_ctrl_msr()).
> > 
> > what do you think?
> 
> You're right, the spec-ctrl CPUID feature covers the IBRS bit of
> MSR_IA32_SPEC_CTRL and also the IBPB feature of MSR_IA32_PRED_CMD.  It does
> not specify the existence of MSR_IA32_SPEC_CTRL.
> 
> In practice it's probably not a good idea to omit spec-ctrl when passing
> other features to the guest that cover that MSR; but the specification says
> it's fine.

I think these features are also worth updating in the CPU models, as
well as in this document: 'cpu-models-x86.rst.inc' - section 'Important
CPU features for Intel x86 hosts' (maybe in the followup patches :))

Thanks,
Zhao


