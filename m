Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D3DC7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 17:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRwuB-0006B1-PA; Wed, 18 Jun 2025 13:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uRwu5-0006A5-8i
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 13:48:54 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uRwu3-00063v-IW
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 13:48:53 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-747ef5996edso5900123b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 10:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750268929; x=1750873729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ER7cL/Ji+e4Tgn5et+alXLevY8MiKr5wuLeetHtLrs=;
 b=J5pNZeyHHXsR9bPwy3Ny2HRmTy3mo/Dgb7ITIdlYTVFxXeQLqceDT4xOE0DTRAzY5v
 45J2lg07BMh5azXTVUpTbHKpzttMYMDgOXFYYW7nCuuTSkZfyzSERvuqFN+69q7Imb4f
 RpUjSMa0QA8Wu88ivPjjU0/snFHnRr0pDwRUlyAExRa1lX+lx4PL29RTSQLu2lg5Fo6b
 bt064NAVTZywHLanT7KiRgDzsBWjV+ugJ4oapAJIsOzw+eQvje8WEEoccWwhrcFfYL0t
 MMZC4fSX/Nj5esK+lG7WC2NakGh6XYGyIPk7k+oaj1jfLaIwX9TtTd8keKUN1BemN/rv
 YPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750268929; x=1750873729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ER7cL/Ji+e4Tgn5et+alXLevY8MiKr5wuLeetHtLrs=;
 b=qsF4+ipYAwiCJzPP8eoYxEO7auhYTBSbKdAkRmySFlx84PohDEgbVoqKsY3vbRtozS
 bhmQXDE+CpdlEFLzV3mXLRWTrcDPYuw3CGlClB8zG32wWjAfmEV+Zg9wDtmFB8Nk/SJr
 u6qMmftWZpEtD2fZxUHakIUVvCDklqwgum07xZBdQcf98ogz9j9KLSFmps33BzkmDxYI
 Xj9PauX3xtg5Fe9qxwTMXFLv28KzkSOjd/otR7WoPamr8N2u3sxsWY5keRWW4VfM4yAy
 GpaIyeEUKuMNqBBwJw8rZ7DaB3ZlZdysdNKFt8Nw8dWeYAFWKtlAQ1MBCkYTz5vhbwFG
 574Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFU26TAkITnP5+ubdwCLiS3QhGGcR8D6k829EU1j3gqZEzazsM49DParHQ2fwE/DR3F2k85xYdgwBV@nongnu.org
X-Gm-Message-State: AOJu0YxEeeGw0pOXQoSNG2ulEIMVWQRe15hRxZ84aAKvm3jbvDa+rFE3
 GoU9axqC3AjShBbcsKIv5WxjW3yF5ZDe99cQA+S+1Q9uzYamUjXf6INinvi4WjQEUVo=
X-Gm-Gg: ASbGncvVdl6Ea0FgMw5lZVVMkI0z5DFQFBCh8ncCsp3tDvBQ/6A4owe0m0QXb1VdEy/
 TziFW0QbR6KSJmQex7iE1UuwwablTX29NovDQnxeqE2xwPwmbQeKsMe/UE7+sqjB65ZV7m7QcPQ
 CiqJtE6NgkiBUEb09Pa6aR0PaUBnv1n887TJBeklmv7p/8zMyZHfzImp8csrkhbu0yWDdqFvQxh
 NtaZoIeIog+H4yN59ELAcsZ6h0cV46Vj3NeaCcRD2Om8LiPPq64yQHX1LaGNUr/TfDE4hprUrg5
 1feW0zH0hnkm8aWj1Ij7H5142ALCVV2HMK29NPWRIslBbIu+XbnpLgf43REyoYfk9/RAzD6zUi8
 j
X-Google-Smtp-Source: AGHT+IFBTfpll7frkJ/bZvQuTmXtEWoX9z4QvwImFPW4AB719dwf6yd9A0trbzwn9w4Gveb1KaH2DQ==
X-Received: by 2002:a05:6a00:21c3:b0:748:68dd:ecc8 with SMTP id
 d2e1a72fcca58-7489cfea237mr21971000b3a.22.1750268929307; 
 Wed, 18 Jun 2025 10:48:49 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.152])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748f5dcb0e3sm431018b3a.55.2025.06.18.10.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 10:48:48 -0700 (PDT)
Message-ID: <8685b828-9fd9-45ae-acdc-632d448ab736@ventanamicro.com>
Date: Wed, 18 Jun 2025 14:48:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] hw/intc: Allow gaps in hartids for aclint and
 aplic
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>
References: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
 <20250618122715.1929966-2-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250618122715.1929966-2-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
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



On 6/18/25 9:27 AM, Djordje Todorovic wrote:
> This is needed for riscv based CPUs by MIPS since those may have
> sparse hart-ID layouts. ACLINT and APLIC still assume a dense
> range, and if a hart is missing, this causes NULL derefs.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   hw/intc/riscv_aclint.c | 27 +++++++++++++++++++++++++--
>   hw/intc/riscv_aplic.c  | 10 +++++++---
>   2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index b0139f03f5..ef1fc57610 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -233,6 +233,9 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
>           /* Check if timer interrupt is triggered for each hart. */
>           for (i = 0; i < mtimer->num_harts; i++) {
>               CPUState *cpu = cpu_by_arch_id(mtimer->hartid_base + i);
> +            if (cpu == NULL) {
> +                continue;
> +            }
>               CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
>               if (!env) {
>                   continue;
> @@ -292,7 +295,11 @@ static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
>       s->timecmp = g_new0(uint64_t, s->num_harts);
>       /* Claim timer interrupt bits */
>       for (i = 0; i < s->num_harts; i++) {
> -        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
> +        CPUState *temp = cpu_by_arch_id(s->hartid_base + i);
> +        if (temp == NULL) {
> +            continue;
> +        }
> +        RISCVCPU *cpu = RISCV_CPU(temp);
>           if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
>               error_report("MTIP already claimed");
>               exit(1);
> @@ -373,6 +380,9 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
>   
>       for (i = 0; i < num_harts; i++) {
>           CPUState *cpu = cpu_by_arch_id(hartid_base + i);
> +        if (cpu == NULL) {
> +            continue;
> +        }
>           RISCVCPU *rvcpu = RISCV_CPU(cpu);
>           CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
>           riscv_aclint_mtimer_callback *cb =
> @@ -408,6 +418,9 @@ static uint64_t riscv_aclint_swi_read(void *opaque, hwaddr addr,
>       if (addr < (swi->num_harts << 2)) {
>           size_t hartid = swi->hartid_base + (addr >> 2);
>           CPUState *cpu = cpu_by_arch_id(hartid);
> +        if (cpu == NULL) {
> +            return 0;
> +        }

I don't think we need this change, and the one below in riscv_aclint_swi_write(). The
existing code is handling the case where cpu == NULL:

         size_t hartid = swi->hartid_base + (addr >> 2);
         CPUState *cpu = cpu_by_arch_id(hartid);
         CPURISCVState *env = cpu ? cpu_env(cpu) : NULL; <-------------
         if (!env) { <-----------------
             qemu_log_mask(LOG_GUEST_ERROR,
                           "aclint-swi: invalid hartid: %zu", hartid);
         } else if {...}


In fact what we have is better: we do a qemu_log() informing about the invalid hart-id
instead of silently returning.


Thanks,

Daniel


>           CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
>           if (!env) {
>               qemu_log_mask(LOG_GUEST_ERROR,
> @@ -431,6 +444,9 @@ static void riscv_aclint_swi_write(void *opaque, hwaddr addr, uint64_t value,
>       if (addr < (swi->num_harts << 2)) {
>           size_t hartid = swi->hartid_base + (addr >> 2);
>           CPUState *cpu = cpu_by_arch_id(hartid);
> +        if (cpu == NULL) {
> +            return;
> +        }
>           CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
>           if (!env) {
>               qemu_log_mask(LOG_GUEST_ERROR,
> @@ -481,7 +497,11 @@ static void riscv_aclint_swi_realize(DeviceState *dev, Error **errp)
>   
>       /* Claim software interrupt bits */
>       for (i = 0; i < swi->num_harts; i++) {
> -        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
> +        CPUState *temp = cpu_by_arch_id(swi->hartid_base + i);
> +        if (temp == NULL) {
> +            continue;
> +        }
> +        RISCVCPU *cpu = RISCV_CPU(temp);
>           /* We don't claim mip.SSIP because it is writable by software */
>           if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0) {
>               error_report("MSIP already claimed");
> @@ -545,6 +565,9 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
>   
>       for (i = 0; i < num_harts; i++) {
>           CPUState *cpu = cpu_by_arch_id(hartid_base + i);
> +        if (cpu == NULL) {
> +            continue;
> +        }
>           RISCVCPU *rvcpu = RISCV_CPU(cpu);
>   
>           qdev_connect_gpio_out(dev, i,
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 8bcd9f4697..360a3dc117 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -899,9 +899,11 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           if (!aplic->msimode) {
>               /* Claim the CPU interrupt to be triggered by this APLIC */
>               for (i = 0; i < aplic->num_harts; i++) {
> -                RISCVCPU *cpu;
> -
> -                cpu = RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
> +                CPUState *temp = cpu_by_arch_id(aplic->hartid_base + i);
> +                if (temp == NULL) {
> +                    continue;
> +                }
> +                RISCVCPU *cpu = RISCV_CPU(temp);
>                   if (riscv_cpu_claim_interrupts(cpu,
>                       (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
>                       error_report("%s already claimed",
> @@ -1076,6 +1078,8 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
>           if (!msimode) {
>               for (i = 0; i < num_harts; i++) {
>                   CPUState *cpu = cpu_by_arch_id(hartid_base + i);
> +                if (cpu == NULL)
> +                    continue;
>   
>                   qdev_connect_gpio_out_named(dev, NULL, i,
>                                               qdev_get_gpio_in(DEVICE(cpu),


