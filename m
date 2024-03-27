Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECFDC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 03:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJWY-000885-FS; Tue, 26 Mar 2024 23:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rpJWW-00087t-V5
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:00:20 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rpJWN-0003Sn-Pa
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711508412; x=1743044412;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bXOkOaCz0LH/bXI9OPwp1c9HZTjsOlpKNvcjeqazYlI=;
 b=fqNpk/EV4wTfoqYyz6s9gXtNeg/Y41L6HN6D2BUxVd9grgqDOxIYMgFD
 OO41/f5IA0doNs+iBLKNM5pr01Q28oOZqG+/hJwebqghAHqfzeLck8hSR
 W2IWUWAQW66y/KtDG0pYF/5SxQEs93u9EUydl8YXjROrjoEOc4BmKELOb
 YhlN9GAiR6oV/uGBH2xMKwup2kO3UgU4zVxkhwOYqOHGVBlvrVh7J4l3o
 2/OXCqMQyO65qMZfg+j/AYCLdNeNvjnsLVGY/VyggCaqmJqj7ZZxHidEv
 IMmlbYFNQu1jOTN+AM4VvI9cJa5YbxaCfoztwkSkA6QbjgJnqL7rQXZ80 A==;
X-CSE-ConnectionGUID: V+GjgsHFS6SNxMuhnLnIvg==
X-CSE-MsgGUID: KTku8p8lTkirkN8pDWd2DA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="18021930"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; d="scan'208";a="18021930"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 20:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; d="scan'208";a="16592310"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7])
 ([10.124.224.7])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 20:00:02 -0700
Message-ID: <2dc199e4-9917-4e5d-ace6-506e084e7736@intel.com>
Date: Wed, 27 Mar 2024 11:00:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v5 2/3] target/i386: add guest-phys-bits cpu
 property
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20240325141422.1380087-1-pbonzini@redhat.com>
 <20240325141422.1380087-3-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240325141422.1380087-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/25/2024 10:14 PM, Paolo Bonzini wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
> 
> Allows to set guest-phys-bits (cpuid leaf 80000008, eax[23:16])
> via -cpu $model,guest-phys-bits=$nr.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-ID: <20240318155336.156197-3-kraxel@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> v4->v5:
> - move here all non-KVM parts
> - add compat property and support for special value "-1" (accelerator
>    defines value)
> 
>   target/i386/cpu.h |  1 +
>   hw/i386/pc.c      |  4 +++-
>   target/i386/cpu.c | 22 ++++++++++++++++++++++
>   3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 6b057380791..83e47358451 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2026,6 +2026,7 @@ struct ArchCPU {
>   
>       /* Number of physical address bits supported */
>       uint32_t phys_bits;
> +    uint32_t guest_phys_bits;
>   
>       /* in order to simplify APIC support, we leave this pointer to the
>          user */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 461fcaa1b48..9c4b3969cc8 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -78,7 +78,9 @@
>       { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
>       { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
>   
> -GlobalProperty pc_compat_9_0[] = {};
> +GlobalProperty pc_compat_9_0[] = {
> +    { TYPE_X86_CPU, "guest-phys-bits", "0" },
> +};
>   const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
>   
>   GlobalProperty pc_compat_8_2[] = {};
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 33760a2ee16..eef3d08473e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>               /* 64 bit processor */
>                *eax |= (cpu_x86_virtual_addr_width(env) << 8);
> +             *eax |= (cpu->guest_phys_bits << 16);
>           }
>           *ebx = env->features[FEAT_8000_0008_EBX];
>           if (cs->nr_cores * cs->nr_threads > 1) {
> @@ -7329,6 +7330,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>           goto out;
>       }
>   
> +    if (cpu->guest_phys_bits == -1) {
> +        /*
> +         * If it was not set by the user, or by the accelerator via
> +         * cpu_exec_realizefn, clear.
> +         */
> +        cpu->guest_phys_bits = 0;
> +    }
> +
>       if (cpu->ucode_rev == 0) {
>           /*
>            * The default is the same as KVM's. Note that this check
> @@ -7379,6 +7388,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>           if (cpu->phys_bits == 0) {
>               cpu->phys_bits = TCG_PHYS_ADDR_BITS;
>           }
> +        if (cpu->guest_phys_bits &&
> +            (cpu->guest_phys_bits > cpu->phys_bits ||
> +            cpu->guest_phys_bits < 32)) {
> +            error_setg(errp, "guest-phys-bits should be between 32 and %u "
> +                             " (but is %u)",
> +                             cpu->phys_bits, cpu->guest_phys_bits);
> +            return;
> +        }
>       } else {
>           /* For 32 bit systems don't use the user set value, but keep
>            * phys_bits consistent with what we tell the guest.
> @@ -7387,6 +7404,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>               error_setg(errp, "phys-bits is not user-configurable in 32 bit");
>               return;
>           }
> +        if (cpu->guest_phys_bits != 0) {
> +            error_setg(errp, "guest-phys-bits is not user-configurable in 32 bit");
> +            return;
> +        }
>   
>           if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
>               cpu->phys_bits = 36;
> @@ -7887,6 +7908,7 @@ static Property x86_cpu_properties[] = {
>       DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
>       DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
>       DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
> +    DEFINE_PROP_UINT32("guest-phys-bits", X86CPU, guest_phys_bits, -1),
>       DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
>       DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_limit, 0),
>       DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),


