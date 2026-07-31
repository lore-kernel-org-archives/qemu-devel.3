Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635BCC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphKS-00046W-Pf; Fri, 31 Jul 2026 03:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wphKP-00045I-Qu
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:06:45 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wphKO-00053y-Bb
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785481604; x=1817017604;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZPmdXFnnpW1uYPCavwrjqrpVSftazrir+BDPF72Y+g4=;
 b=Eu2l671Jy+vafR9xT/ZCv9lIzMHUta521dTpqrvdJkApGJWtDQNd45Vg
 yPU9csGhnXZBSwGY4RoJpL7D8rWbZKF4SourMd2pGa+5jxp/17RqIkI7I
 pCuoTNOt3HuLmONxpToYuVJ9tBSnR+/k5l0Uolr2yKnGQ+EWrma1i1OGJ
 IDTlwfCBv9vc4XMjG/NasWIQlq9cNwV8d7A4+WO09eGprNWDabqj3hkJy
 VnbQxH0iNBKccOo2fq1cUQjwgwXbihBfKgcO+10UDGVwZy66fvjWgkL0c
 nSAt+x2yVQniMUHxCLXbLaR6TTZWCbGBAxpI3990J3gGaHOaxFur5p/aq g==;
X-CSE-ConnectionGUID: 1PbyzB3EToeHPMrZ0pVMRw==
X-CSE-MsgGUID: 0vdA5pF6S1WQ3YVcL64l3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97480593"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="97480593"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 00:06:42 -0700
X-CSE-ConnectionGUID: Qoj14TtJRr653khBEo1d8w==
X-CSE-MsgGUID: 4tUYOQ7WTqSHaqFU5VSDow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="290460436"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa002.jf.intel.com with ESMTP; 31 Jul 2026 00:06:41 -0700
Date: Fri, 31 Jul 2026 15:06:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v1 4/9] target/i386/kvm: Use AMD MCE status encoding for
 Hygon
Message-ID: <amxJf2elltpmBHFD@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-5-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706055530.1752094-5-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> +/*
> + * Use AMD-style MCE status records for QEMU-injected memory failures on
> + * AMD and Hygon CPUs.
> + */
> +static bool kvm_mce_inject_uses_amd_status(const CPUX86State *env)
> +{
> +    return IS_AMD_CPU(env) || IS_HYGON_CPU(env);
> +}
> +
>  static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>  {
>      CPUState *cs = CPU(cpu);
> @@ -707,7 +716,7 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>      uint64_t mcg_status = MCG_STATUS_MCIP | MCG_STATUS_RIPV;
>      int flags = 0;
>  
> -    if (!IS_AMD_CPU(env)) {
> +    if (!kvm_mce_inject_uses_amd_status(env)) {

Maybe we can check hygon directly here?


Regards,
Zhao

>          status |= MCI_STATUS_S | MCI_STATUS_UC;
>          if (code == BUS_MCEERR_AR) {
>              status |= MCI_STATUS_AR | 0x134;
> -- 
> 2.43.7
> 
> 

