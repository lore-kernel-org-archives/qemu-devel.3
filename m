Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF080D12D42
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 15:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA9bY-0006hr-1g; Sun, 10 Nov 2024 10:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tA9bW-0006hf-GH
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:11:54 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tA9bT-0001qc-KC
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731251511; x=1762787511;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=USl1nY3YjGmLI1eF88k5ItXmHiKnBx4f1MQDRmVEU6Y=;
 b=ds31CxIrabR6A9TmJd0NeCwDTJYvUVybWLD61rJVTa034bxr/zsxeyQw
 nthWEjUGx0pcEwEA2BPLKPdYdl1weGSpxg+tVDSOuLIpCZYU3TuHyL3OU
 OVnJ83ct/eff+5IUhrjZbMUIWM07f7pzDlNz1pTAbHdxiRUogdo4e7e5t
 AfMCalWAshRBTmVVNnGNPty9PnWnfQPmV2I+GtH9pYTM1DVQ4bPKXSDUe
 C2T3Ppn2KDzv3cf1O7n0xNIKQtM8XtJg1yoABrN7ZQRsaDrsCxCXj7Us6
 0WYwZxA1ZdyuGVOGSnfNb6ltv3aYSgUA1TdTANveIu0wj2UPUJCvJZTWG A==;
X-CSE-ConnectionGUID: C1hQVoClSCWqAPF8vswojQ==
X-CSE-MsgGUID: +s3pvs5kR0e4NHFRwQknXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="42455146"
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; d="scan'208";a="42455146"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2024 07:11:47 -0800
X-CSE-ConnectionGUID: Zq6s1SMsTH2DN0QsWMsSMA==
X-CSE-MsgGUID: N/+1CAqGQFG9Nk32wDYC0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; d="scan'208";a="86820275"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 10 Nov 2024 07:11:43 -0800
Date: Sun, 10 Nov 2024 23:29:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, lyan@digitalocean.com,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, joe.jin@oracle.com, davydov-max@yandex-team.ru
Subject: Re: [PATCH 3/7] target/i386/kvm: init PMU information only once
Message-ID: <ZzDRZcy7EdK40PO1@intel.com>
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-4-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104094119.4131-4-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

Hi Dongli,

>  int kvm_arch_init_vcpu(CPUState *cs)
>  {
>      struct {
> @@ -2237,6 +2247,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
>      cpuid_data.cpuid.nent = cpuid_i;
>  
> +    /*
> +     * Initialize PMU information only once for the first vCPU.
> +     */
> +    if (cs == first_cpu) {
> +        kvm_init_pmu_info(env);
> +    }
> +

Thank you for the optimization. However, I think it¡¯s not necessary
because:

* This is not a hot path and not a performance bottleneck.
* Many CPUID leaves are consistent across CPUs, and 0xA is just one of them.
* And encoding them all in kvm_x86_build_cpuid() is a common pattern.
  Separating out 0xa disrupts code readability and fragments the CPUID encoding.

Therefore, code maintainability and correctness might be more important here,
than performance concern.

>      if (((env->cpuid_version >> 8)&0xF) >= 6
>          && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
>             (CPUID_MCE | CPUID_MCA)) {
> -- 
> 2.39.3
> 

