Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E239CCA0FE7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 15:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqYmu-0004gE-GZ; Mon, 25 Aug 2025 11:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqYmf-0004cH-Qw; Mon, 25 Aug 2025 11:07:00 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqYma-0005gi-IJ; Mon, 25 Aug 2025 11:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756134413; x=1787670413;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YfHFUoGLkSa+n3i+MEKqkX80IQ8PaOC5AtIFmnvn1QQ=;
 b=QGd9StIH6wjPXp0lTUpcDBdw0D19zMW1WXqCcsqPOghoocFKdSsYFN7P
 Hp8Jq0UHLGVt1DfW7JCtnEAANIQY+8EZ9ezY1A1g3GxCvrzhmKUBT95LD
 dzpsvalpunh7vVPXjm6bwT8ULxHKSuZBROHOnP+w32eIIf8+FhBgupu3Y
 nO956yg6RE8fpIXDsSpH0BnKnm4FsexABcykR9KUYgboW5BPFV8axkHcm
 1+B/U4X5KmrK97t/4ZGPfKh9nYuwjx2xgv6nDYzQiwUqiWXJ4i8Bm3NDO
 elr6F0GI4nt27p0nxdsidK7K8uFDi/n5szgggFhF/n1b5HyoY8r+L/NyB g==;
X-CSE-ConnectionGUID: gY/bgMAsR4OCjtumLqnJlw==
X-CSE-MsgGUID: kF0cL4FhQRWamiaABIo4KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58292021"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58292021"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 08:06:46 -0700
X-CSE-ConnectionGUID: w/PZNiX4SZ+WYeXHSW5psg==
X-CSE-MsgGUID: 7RNmjk18QLunB0kcOk0VHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="169502108"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 25 Aug 2025 08:06:37 -0700
Date: Mon, 25 Aug 2025 23:28:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com,
 mst@redhat.com, mtosatti@redhat.com, richard.henderson@linaro.org,
 riku.voipio@iki.fi, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, david@redhat.com, jjherne@linux.ibm.com,
 shorne@gmail.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, peter.maydell@linaro.org,
 agraf@csgraf.de, mads@ynddal.dk, mrolnik@gmail.com, deller@gmx.de,
 dirty@apple.com, rbolshakov@ddn.com, phil@philjordan.eu,
 reinoud@netbsd.org, sunilmut@microsoft.com, gaosong@loongson.cn,
 laurent@vivier.eu, edgar.iglesias@gmail.com, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, chenhuacai@kernel.org,
 npiggin@gmail.com, rathc@linux.ibm.com, harshpb@linux.ibm.com,
 yoshinori.sato@nifty.com, iii@linux.ibm.com,
 mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
Message-ID: <aKyBFlCtnxnP9kt/@intel.com>
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821155603.2422553-1-imammedo@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

Hi Igor,
 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5eaf41a566..1dee9d4c76 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -942,6 +942,31 @@ CPUState *cpu_by_arch_id(int64_t id);
>  
>  void cpu_interrupt(CPUState *cpu, int mask);
>  
> +/**
> + * cpu_test_interrupt:
> + * @cpu: The CPU to check interrupt(s) on.
> + * @mask: The interrupts to check.
> + *
> + * Checks if any of interrupts in @mask are pending on @cpu.
> + */
> +static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
> +{
> +    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
> +}
> +
> +/**
> + * cpu_set_interrupt:
> + * @cpu: The CPU to set pending interrupt(s) on.
> + * @mask: The interrupts to set.
> + *
> + * Sets interrupts in @mask as pending on @cpu.
> + */
> +static inline void cpu_set_interrupt(CPUState *cpu, int mask)
> +{
> +    qatomic_store_release(&cpu->interrupt_request,
> +        cpu->interrupt_request | mask);

It seems the read access of cpu->interrupt_request is not atomic, should
we also protect it by qatomic_read(cpu->interrupt_request)? like

qatomic_store_release(&cpu->interrupt_request,
                      qatomic_read(cpu->interrupt_request) | mask)

or futher,

qatomic_fetch_or(&cpu->interrupt_request, mask)

> +}
> +

Thanks,
Zhao


