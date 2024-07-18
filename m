Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13151C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYPQ-0000Cw-6J; Thu, 18 Jul 2024 17:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYPA-0007nM-PW
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:11:14 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYP7-0007lr-0q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721337069; x=1752873069;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xeyJ40gAKiB98Av8NBuU+/x/EOrQ3yZJ21r0nLLcn6M=;
 b=jxtj5Wzbnt/cDTtKvTbkd6/jQuKAiG7wNSQ/QiaBrRKu2V5y/o9elGcO
 VCMjHF5aU6ZBrsUA3T2DPKsFCeS9B+1KquVH3U7J8NKACqtFYK4uVPLh6
 Q3ulK0pIsXwLY8MUX+3BZtKEx4mxzmWdFZ0/FPeS2qSZqBgdI9DxIGfNJ
 f+di9epK3CaxByjq/Gyj60oa0PkSn+8vJHoQGihlU/d1nIU2rvkcgwvRs
 nR73uR2w1mD1cq13nkEkKBPqpwG+1Ntacr0pkjgdCz30Q7JhozxbHtjXZ
 FfcynkfLAV5ObPcLbJ79pL72r540F+GbWaGdppCKKXqaq1RzaQyYBGoaa A==;
X-CSE-ConnectionGUID: ydgOqEFRQlqxn+5BXGtNIw==
X-CSE-MsgGUID: 4ERHCZaxQ4+ujR7zc8l0dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="36370753"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="36370753"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:11:08 -0700
X-CSE-ConnectionGUID: SsQP3A+yRKecmMS6ETqHpw==
X-CSE-MsgGUID: 4VrL3/CcR4iJOTyYGxEuaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="81935100"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.107]) ([10.24.10.107])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:11:05 -0700
Message-ID: <66b00937-60a8-40b1-95fa-8b680febfce1@intel.com>
Date: Thu, 18 Jul 2024 14:11:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] target/i386/kvm: Replace ARRAY_SIZE(msr_handlers)
 with KVM_MSR_FILTER_MAX_RANGES
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716161015.263031-1-zhao1.liu@intel.com>
 <20240716161015.263031-10-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240716161015.263031-10-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 7/16/2024 9:10 AM, Zhao Liu wrote:
> kvm_install_msr_filters() uses KVM_MSR_FILTER_MAX_RANGES as the bound
> when traversing msr_handlers[], while other places still compute the
> size by ARRAY_SIZE(msr_handlers).
> 
> In fact, msr_handlers[] is an array with the fixed size
> KVM_MSR_FILTER_MAX_RANGES, so there is no difference between the two
> ways.
> 
> For the code consistency and to avoid additional computational overhead,
> use KVM_MSR_FILTER_MAX_RANGES instead of ARRAY_SIZE(msr_handlers).
> 
> Suggested-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Zide Chen <zide.chen@intel.com>


> ---
> v4: new commit.
> ---
>  target/i386/kvm/kvm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index d47476e96813..43b2ea63d584 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5314,7 +5314,7 @@ int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
>  {
>      int i, ret;
>  
> -    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
> +    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
>          if (!msr_handlers[i].msr) {
>              msr_handlers[i] = (KVMMSRHandlers) {
>                  .msr = msr,
> @@ -5340,7 +5340,7 @@ static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
>      int i;
>      bool r;
>  
> -    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
> +    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
>          KVMMSRHandlers *handler = &msr_handlers[i];
>          if (run->msr.index == handler->msr) {
>              if (handler->rdmsr) {
> @@ -5360,7 +5360,7 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
>      int i;
>      bool r;
>  
> -    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
> +    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
>          KVMMSRHandlers *handler = &msr_handlers[i];
>          if (run->msr.index == handler->msr) {
>              if (handler->wrmsr) {

