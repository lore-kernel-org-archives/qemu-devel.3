Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D0CC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4dpu-0006bj-5r; Tue, 15 Apr 2025 06:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4dpn-0006ax-Sj
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:48:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4dpl-0003uk-Ew
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:48:07 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so3442519f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744714082; x=1745318882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uHT98M7a4Y2ioWHmCy5qXsLMMburf4pv5iHUxS6+xlE=;
 b=LYxVQx255aun/k5I4DT3jXulJTjgx5/Ep4Onz6E2ULfCAaPxRLolqAM77pP0B8qxft
 uvhGtQKJgyFjsvztZ05yXGb/bf5cwT6yI7TzaY7errUY/92+ll1UkRdUYZflNST6JEGp
 lkm2HIrG3UMeN5kBdTESZvmQhz1ihSJZQIkyYv2Y0eNnlCRfrX07IlaVTsSpuAOPGti1
 KlVYxYbVS9YRTmKHeihqavwRAYsbfvUp+oKVrZKMfxXcjPKKhnkmEfqsr0PIRJW5qhIN
 V5f+2sVIYCJ4HNGO+1rSlQyMKX+71vGFRit1CKVbWWbkpmSTPFqGQRsNCebriqaws/tl
 rWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744714082; x=1745318882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uHT98M7a4Y2ioWHmCy5qXsLMMburf4pv5iHUxS6+xlE=;
 b=jGaGI1WckSFxBugO0pKlcTpI+xCuZDF7U6zh3YUI8fUvw4ViDddacUMTrg8xivKvNI
 YhhkSB7ydgA6arKp3hZ56jIsCqz8ymQogLBsJXIWahQEsEE8nbnJJWCx/DIkW8CtdcWL
 NcQAR4qvrC9SLZ7HbkMPj/uE2tJACActyXbs3c1OlASqDK+OcMEOXYJvaj8zKTDrzwUj
 aTOoMAgVSS02Eow634l3kYPzk3EouwVPY+iFqxWGx/XGeRMjGVyW42RkkWjl6HAcvFTX
 ps1h5oBAZ7NuwpPumxlF0DOwdLXTWr1ykD3DsByKnHAbfuHsLAIsGGxpy9pcmST57ELK
 SNnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDQw929hIq2XlPV4iCqoPzE3i3HcEFqfzjE6ECyYWDwJ7djWF0uzhKLmnJ21zfZTmxk7DX1Diti0H9@nongnu.org
X-Gm-Message-State: AOJu0YwuIe2NS2+sDjmIKGdmDBgZOowszjKXNQxV01f4Zv1Wr7s48KZs
 3yFWCl5ROSfSBunmVhK8eR2itI86OniBL+XJyzpFjlNmq1TOBidtYXvVUYS46qc=
X-Gm-Gg: ASbGncsAshYy4iecdDIjr9ywH1bOsOT72ovvC/ttAUBVxS+JZGXj6UzXdR4UHHShiYv
 zjJb87XOzsFxOZ4umKXXhOzXEYOd1AnpW/QFnapm4tiOus8Ta51DW6MhuRJ1Pxc0KqDiqTMtA+a
 Bf1Jf2ndIZxsrcUeQDh4JRaDN8zDwNLI/g54bh7T4FQD5+P36xjGfgHTvYdcczRMJKdi+zQn2Wc
 H8tpZpjk2M9xhVAOsePSGkZbZagcmnzbWESu2AO92eYDAwCIhwjuUa0gLn2/1RLHLCgoOGF46dS
 M6rz10JWn2NjlzmijS+8pRjlU5QScrKHh/+5sNJAsjl1bQo1m2hctKCSqQZZUWKstG1KOQkvuG7
 N5M5hkLwx
X-Google-Smtp-Source: AGHT+IFnI/RG2zL9JzyIIcTWTbBUy3RnH1yqOuGxg0AjzZC6ZI2SQIlXPS2JGESgwD908xVfpZsmgw==
X-Received: by 2002:a05:6000:4023:b0:397:8ef9:a143 with SMTP id
 ffacd0b85a97d-39ea5212322mr12625601f8f.23.1744714082589; 
 Tue, 15 Apr 2025 03:48:02 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43ce3bsm14112818f8f.66.2025.04.15.03.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 03:48:02 -0700 (PDT)
Message-ID: <7feba2b2-ba40-4575-9846-6e09f9e9542a@linaro.org>
Date: Tue, 15 Apr 2025 12:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hw/riscv: fix PLIC hart topology configuration
 string when not getting CPUState correctly
To: Chao Liu <lc00631@tecorigin.com>, alistair23@gmail.com, palmer@dabbelt.com
Cc: zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, zqz00548@tecorigin.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <cover.1744709888.git.lc00631@tecorigin.com>
 <07a97219e3f7e342c668d6772acc4c0a8eb4d4f3.1744709888.git.lc00631@tecorigin.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <07a97219e3f7e342c668d6772acc4c0a8eb4d4f3.1744709888.git.lc00631@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 15/4/25 12:05, Chao Liu wrote:
> riscv_plic_hart_config_string() when getting CPUState via qemu_get_cpu()
> should be consistent with keeping sifive_plic_realize() by
> hartid_base + cpu_index.
> 
> For non-numa or single-cluster machines, hartid_base should be 0.
> 
> Also, to ensure that CPUState->cpu_index is set correctly, we need to
> update it with the value of mhartid during riscv_hart_realize().
> 
> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> Reviewed-by: zhaoqingze <zqz00548@tecorigin.com>
> ---
>   hw/riscv/boot.c            | 4 ++--
>   hw/riscv/microchip_pfsoc.c | 2 +-
>   hw/riscv/riscv_hart.c      | 1 +
>   hw/riscv/sifive_u.c        | 5 +++--
>   hw/riscv/virt.c            | 2 +-
>   include/hw/riscv/boot.h    | 2 +-
>   6 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 765b9e2b1a..d4c06e7530 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -44,13 +44,13 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
>    * Return the per-socket PLIC hart topology configuration string
>    * (caller must free with g_free())
>    */
> -char *riscv_plic_hart_config_string(int hart_count)
> +char *riscv_plic_hart_config_string(int hart_base, int hart_count)
>   {
>       g_autofree const char **vals = g_new(const char *, hart_count + 1);
>       int i;
>   
>       for (i = 0; i < hart_count; i++) {
> -        CPUState *cs = qemu_get_cpu(i);
> +        CPUState *cs = qemu_get_cpu(hart_base + i);
>           CPURISCVState *env = &RISCV_CPU(cs)->env;
>   
>           if (kvm_enabled()) {
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 9c846f9b5b..5269336346 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -275,7 +275,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>                                   l2lim_mem);
>   
>       /* create PLIC hart topology configuration string */
> -    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
> +    plic_hart_config = riscv_plic_hart_config_string(0, ms->smp.cpus);
>   
>       /* PLIC */
>       s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index a55d156668..522e795033 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -138,6 +138,7 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
>       }
>   
>       s->harts[idx].env.mhartid = s->hartid_base + idx;
> +    CPU(&s->harts[idx])->cpu_index = s->harts[idx].env.mhartid;

Why do we need this particular change? CPUState::cpu_index isn't related
to RISC-V HART index, it is meant for the accelerators (KVM, TCG, ...),
and shouldn't be used by hw/ code.

Otherwise the rest LGTM.

Regards,

Phil.

>       qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
>       return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
>   }
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 679f2024bc..516912c4f4 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -790,10 +790,11 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>       MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>       MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
>       char *plic_hart_config;
> +    int hartid_base = 1;
>       int i, j;
>   
>       qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
> -    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
> +    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", hartid_base);
>       qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", s->cpu_type);
>       qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
>   
> @@ -829,7 +830,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>                                   l2lim_mem);
>   
>       /* create PLIC hart topology configuration string */
> -    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
> +    plic_hart_config = riscv_plic_hart_config_string(hartid_base, ms->smp.cpus);
>   
>       /* MMIO */
>       s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index e517002fdf..41fdfd2bc8 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1280,7 +1280,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
>       g_autofree char *plic_hart_config = NULL;
>   
>       /* Per-socket PLIC hart topology configuration string */
> -    plic_hart_config = riscv_plic_hart_config_string(hart_count);
> +    plic_hart_config = riscv_plic_hart_config_string(base_hartid, hart_count);
>   
>       /* Per-socket PLIC */
>       ret = sifive_plic_create(
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 7d59b2e6c6..5937298646 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -40,7 +40,7 @@ typedef struct RISCVBootInfo {
>   
>   bool riscv_is_32bit(RISCVHartArrayState *harts);
>   
> -char *riscv_plic_hart_config_string(int hart_count);
> +char *riscv_plic_hart_config_string(int hart_base, int hart_count);
>   
>   void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
>   target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,


