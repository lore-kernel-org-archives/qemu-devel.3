Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB25DC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUxS-0007uX-6M; Mon, 10 Feb 2025 09:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUxQ-0007qB-98
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:40:20 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUxM-0001ag-NU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:40:19 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38de17a5fc9so426990f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739198415; x=1739803215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l8CuMdc5W0Wmyh9T41fkhSTJL4bl2f0Za6jxEBbk2MA=;
 b=f6ouQAfH+SFve0u+546FMPj2cgxKaQS8LALzEtuoAr7g2x73meGj77Ycbt0QKyt5k4
 J7TjxxeP2woVuDEv88mNm7pbSS6TutJaY8qC1g+ac42L6M2R/rNvG9uOD4mjShIPRcZP
 2YN9a8Hvwt6aVyr1D3UZEBtkvZh48HIJHIDUhCKQHrNLO8Jpso+RDOEJvO92YpNgo70e
 GlezR1htyFybpNlP8eOvLWDxtJfl+hjaZyqVQzbupDiGLS4vGa23dlEQnuFJLS3pTsMh
 QcpXZvDB3T1NNeZTmlGwFdhKGdkEcg9KiBf8gih15Erm0vYZyY2N7Yr50KatKqp62fbO
 UeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739198415; x=1739803215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l8CuMdc5W0Wmyh9T41fkhSTJL4bl2f0Za6jxEBbk2MA=;
 b=GT4qP2dd3DJu4SRC8Qj/dUvYbagvplNXDZBkIG8dlmYaOKKSPrBoOL/S7zVZOR6is/
 v6Jm4uzESUcfR7oiKmG2MVVlL1JWxqQSAgIzUQx5HmSvyiHEScFfdO78xvVQYoGDCwwr
 Ka5TXshBFESlcgBCJTmURRjFKxqRSUY4zonzcH6m/2j61G2kFeVFsWpsVPfNCFH95sl8
 4uyubZ6YAHJITJPYOLmC1qBr/LD1H7ReXsBKkTFbBky45QYjd4FKwqD/h5LKslWPQ/sy
 0y+zdt6Eqq0aMz97UaeR3WOe1PM/uM9xS0Zvqgjuy9lLtfwlvy3YysSutmS1yr39gCNf
 TEuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5A+KIexCg6M8RC9hZO5LGIBVfThH/95SOuVqkyojgAqDl+7jQao2LKkjOcgegIS86GG3qxfjCinUN@nongnu.org
X-Gm-Message-State: AOJu0Yw4K3i/X/iotbXBlNu0fFSstMstPF9VTphuPTSK+e8AENFBMexh
 OkeaHh21x5QiE9sEm+2+RiZ/aO61gCORIxkb3G+5GGp1u9fH1mVPoVg3Q6IJD2AVEEJPJeGT/95
 HPA0=
X-Gm-Gg: ASbGncvETL9wdVbEPIt7fmtwb4JKAvtdr4aAhLbyS5/BMeR8sLLD/vD8X9biR+uMGmh
 VjEdHihTS83HVissdbM5/cakDLFBKoFbzmBDt87tRSKe0QUx7RNqtBH73/aVuTP8OOR/Iodunnf
 MsT4ganl7RSzpROxRTOxn5ud35V6FUilHlUa9l+EgVWvLOCQnAQVNB/Wqi0e4+i5HJ5fg0uFz7g
 ZWCArrSJxBeV4QnYylVyg+HsjjqGcQQ+ou1giivoVrZugiJeg7gneJvlyYZW3JSOHlHurYSUYwW
 YvjpxGZS0zbtJCfe/00AEmf7ZHi1hCnHqnbj9uTgDmiRCsqWtKPUhSdZydg=
X-Google-Smtp-Source: AGHT+IFaNvUkyNw9D00gUdvidgseMkdhCuMNtYGejBZt5UP/DzgvCXI5Ex6bEDV+hWJ0OfqS/w3KRQ==
X-Received: by 2002:a5d:6d0e:0:b0:38d:b34a:679 with SMTP id
 ffacd0b85a97d-38dc9373577mr9289707f8f.37.1739198414639; 
 Mon, 10 Feb 2025 06:40:14 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd4d826c6sm6963579f8f.69.2025.02.10.06.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:40:14 -0800 (PST)
Message-ID: <0a148b5c-23e9-4c4b-84fc-70f04d5adf29@linaro.org>
Date: Mon, 10 Feb 2025 15:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] cpu: Introduce cpu_get_phys_bits()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-8-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250130134346.1754143-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Cédric,

On 30/1/25 14:43, Cédric Le Goater wrote:
> The Intel CPU has a complex history regarding setting of the physical
> address space width on KVM. A 'phys_bits' field and a "phys-bits"
> property were added by commit af45907a1328 ("target-i386: Allow
> physical address bits to be set") to tune this value.
> 
> In certain circumstances, it is interesting to know this value to
> check that all the conditions are met for optimal operation. For
> instance, when the system has a 39-bit IOMMU address space width and a
> larger CPU physical address space, we expect issues when mapping the
> MMIO regions of passthrough devices and it would good to report to the
> user. These hybrid HW configs can be found on some consumer grade
> processors or when using a vIOMMU device with default settings.
> 
> For this purpose, add an helper routine and a CPUClass callback to
> return the physical address space width of a CPU.
> 
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/core/cpu.h            |  9 +++++++++
>   include/hw/core/sysemu-cpu-ops.h |  6 ++++++
>   cpu-target.c                     |  5 +++++
>   hw/core/cpu-system.c             | 11 +++++++++++
>   target/i386/cpu.c                |  6 ++++++
>   5 files changed, 37 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index fb397cdfc53d12d40d3e4e7f86251fc31c48b9f6..1b3eead102ce62fcee55ab0ed5e0dff327fa2fc5 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -748,6 +748,14 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
>    */
>   bool cpu_virtio_is_big_endian(CPUState *cpu);
>   
> +/**
> + * cpu_get_phys_bits:
> + * @cpu: CPU
> + *
> + * Return the physical address space width of the CPU @cpu.
> + */
> +uint32_t cpu_get_phys_bits(const CPUState *cpu);
> +
>   #endif /* CONFIG_USER_ONLY */
>   
>   /**
> @@ -1168,6 +1176,7 @@ void cpu_exec_unrealizefn(CPUState *cpu);
>   void cpu_exec_reset_hold(CPUState *cpu);
>   
>   const char *target_name(void);
> +uint32_t target_phys_bits(void);
>   
>   #ifdef COMPILING_PER_TARGET
>   
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index 0df5b058f50073e47d2a6b8286be5204776520d2..210b3ed57985525795b81559e41e0085969210d5 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -81,6 +81,12 @@ typedef struct SysemuCPUOps {
>        */
>       bool (*virtio_is_big_endian)(CPUState *cpu);
>   
> +    /**
> +     * @get_phys_bits: Callback to return the physical address space
> +     * width of a CPU.
> +     */
> +    uint32_t (*get_phys_bits)(const CPUState *cpu);

Using 32-bit isn't really relevant IMHO, I'd return an unsigned type.

> +
>       /**
>        * @legacy_vmsd: Legacy state for migration.
>        *               Do not use in new targets, use #DeviceClass::vmsd instead.
> diff --git a/cpu-target.c b/cpu-target.c
> index 667688332c929aa53782c94343def34571272d5f..88158272c06cc42424d435b9701e33735f080239 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -472,3 +472,8 @@ const char *target_name(void)
>   {
>       return TARGET_NAME;
>   }
> +
> +uint32_t target_phys_bits(void)
> +{
> +    return TARGET_PHYS_ADDR_SPACE_BITS;
> +}
> diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
> index 6aae28a349a7a377d010ff9dcab5ebc29e1126ca..05067d84f4258facf4252216f17729e390d38eae 100644
> --- a/hw/core/cpu-system.c
> +++ b/hw/core/cpu-system.c
> @@ -60,6 +60,17 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>       return cc->sysemu_ops->get_phys_page_debug(cpu, addr);
>   }
>   
> +uint32_t cpu_get_phys_bits(const CPUState *cpu)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(cpu);
> +
> +    if (cc->sysemu_ops->get_phys_bits) {
> +        return cc->sysemu_ops->get_phys_bits(cpu);
> +    }
> +
> +    return target_phys_bits();

With heterogeneous emulation in mind, I'd rather this to be a mandatory
CPUClass handler.

> +}
> +
>   hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
>   {
>       MemTxAttrs attrs = {};
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b5dd60d2812e0c3d13c1743fd485a9068ab29c4f..01cf9a44963710a415c755c17582730f75233143 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8393,6 +8393,11 @@ static bool x86_cpu_get_paging_enabled(const CPUState *cs)
>   
>       return cpu->env.cr[0] & CR0_PG_MASK;
>   }
> +
> +static uint32_t x86_cpu_get_phys_bits(const CPUState *cs)
> +{
> +    return X86_CPU(cs)->phys_bits;
> +}
>   #endif /* !CONFIG_USER_ONLY */
>   
>   static void x86_cpu_set_pc(CPUState *cs, vaddr value)
> @@ -8701,6 +8706,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
>       .get_memory_mapping = x86_cpu_get_memory_mapping,
>       .get_paging_enabled = x86_cpu_get_paging_enabled,
>       .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
> +    .get_phys_bits = x86_cpu_get_phys_bits,
>       .asidx_from_attrs = x86_asidx_from_attrs,
>       .get_crash_info = x86_cpu_get_crash_info,
>       .write_elf32_note = x86_cpu_write_elf32_note,


