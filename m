Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDBAE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 22:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLrVS-0003nS-OJ; Thu, 12 Dec 2024 17:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLrVP-0003n5-Pd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:18:00 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLrVO-0000VZ-2F
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734041878; x=1765577878;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+hke1jTpTPORrYTONurCc0B9Riuzl04wqPrCFnU+0vM=;
 b=kI5PngMyE7FJIRY+OSG0WaF1WPv5VnAZ7wFc+LvNK4Px6iwK7MUYFs/u
 Z6JwnzE2yXU7dEv7obRVBE2afF2e3XHTzn7F5rkgm3QiYxH3FEHLJOMRu
 xxXu6yNG4YKITO0RQ6s1kadmkfmJCSAXu9/qE66tFxP4byhR4k7YXx+Rc
 T0X7O6+O3urBiDDqiz0Ace0waUnOOCqUthcWntf64z0y/AlLDfiWcezzi
 oDmGpjIAzBlx6TyIc477T7amWEuuvblCTgF9Zq0Ja9q0ye1VJifshHQaV
 BKCj/a+FQDOLtqvzL+rdUJ6uhGfNkYuwMD3b0FTJytYqk2C4IaK141uqw w==;
X-CSE-ConnectionGUID: zrXzAQASRTWJEPB+/qQ+Fg==
X-CSE-MsgGUID: EsWyvtYtS3WuiyAIjBdOtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34400115"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; d="scan'208";a="34400115"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 14:17:56 -0800
X-CSE-ConnectionGUID: CCR3J1XKRlCFf6Bcr96NOQ==
X-CSE-MsgGUID: xJNdr9q+Qg+WsINy+GQKVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119604793"
Received: from puneetse-mobl.amr.corp.intel.com (HELO localhost)
 ([10.125.110.112])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 14:17:54 -0800
Date: Thu, 12 Dec 2024 16:17:53 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 36/60] i386/tdx: Force exposing CPUID 0x1f
Message-ID: <Z1thEdonGTThi7MX@iweiny-mobl>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-37-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-37-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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

On Tue, Nov 05, 2024 at 01:23:44AM -0500, Xiaoyao Li wrote:
> TDX uses CPUID 0x1f to configure TD guest's CPU topology. So set
> enable_cpuid_0x1f for TDs.

If you squashed this into patch 35 I think it might make more sense overall
after some commit message clean ups.

Ira

> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/tdx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 289722a129ce..19ce90df4143 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -388,7 +388,11 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
>  
>  static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
>  {
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +
>      object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
> +
> +    x86cpu->enable_cpuid_0x1f = true;
>  }
>  
>  static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
> -- 
> 2.34.1
> 

