Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3AACA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 07:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyWc-0006Gp-HF; Mon, 01 Sep 2025 03:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyWO-0006FS-3f
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyWG-0005aT-LK
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756709998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KeMuCz6YyKISymk04l81G500PwYputxGtMgFctuEw+4=;
 b=bEwPcN3BD7oSJyui4SsK9S7dmIHcOQgrZWdA0155mY1Ed/YSGjCBbrhZvOptkQEgK36GeH
 FJGrv4lO0atnz6JBAZkH8NupRsGsUp7X28TJ6Pij6XFaTpvVLgpiRQ5bA/5JhfeFddd9PX
 ff6mLXvxScU1KZDm3ZtFu26gUsDAXoU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Wzu9kGsJMJyWD3mFXvm2og-1; Mon, 01 Sep 2025 02:59:56 -0400
X-MC-Unique: Wzu9kGsJMJyWD3mFXvm2og-1
X-Mimecast-MFC-AGG-ID: Wzu9kGsJMJyWD3mFXvm2og_1756709996
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b8ffb5c5eso430765e9.2
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709996; x=1757314796;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KeMuCz6YyKISymk04l81G500PwYputxGtMgFctuEw+4=;
 b=VeiYwTn9ldTePClsz1B5bE7Z6MwFoyl3/DrTd2M9iqeU8R7WBp6UJs1bjmMLc+KrK4
 gGcv4POSc65046Zjwysqo0phRNVVWsGaBdPREbwK3CpSfNiozhrUqRSCk+C1bjkdGu+f
 T5/ZG9sSpbbCFtX0jDLCfHUv7nt/82MY+ul6zd92W+cib3n8coyi3rO/FK8ICS7MsnwB
 3tggj3583UF02ICjotBXY0vU/cKQGr5T3bJFsmHMdD1Li9O6lZNcoAtQT8ZrRFhms6ch
 kL6FQS/u/mJ0OjOHOPJdhOGz2tBD1MPATaF/5O+C+kecu2i8viGfCYL2PEcUZ75N/RnF
 NRqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsurHdVehg9i8TZBA2BCezahg5G+xweLespt2wyMdF/jw0MyKuW7YMeo4AMOaGwRtITKZTGGrxZPaa@nongnu.org
X-Gm-Message-State: AOJu0Yw5MGmYWzdAJCkxRRlKhQuUoUy4yEaCsmNFRH5zi1DNf0peNV83
 ilQS0nvlKLyV/peVYFFfo7PC1eQ958sg9vDTUKq1sBIIpMH/uFzWD7NBaOm7x9EOt/WI866xwHW
 ObidFfY7j6j3POjN3Fu95Z89AqAz6R1gZ/UNYlD7DidT4SukMSP0tdxMi
X-Gm-Gg: ASbGncuFfVkaf3Vte6hyiuXI9/4D36rFwGHBrhAQ+Z/b+nqq6bmUCBzRhNdJTEJdUE/
 iVHen35iEWxVwy4CV3pX1lKjDRgTMWjjKgVQqBtqIzSHKaaQOY028dS3F+3OYTlk60O2/FFvBSj
 dOqq5kjZ9MDhVbBlsRl7Rj65n7AkZgEhzMhbWOsrrSPqjiC2nUZgne+G1M3i1XHMT0aB0uBwByZ
 Mdy5y1q1HtoS6MQKHfY8qpwfsSOnyypWEn6QwlWCbszBk/QutQn/fhnrFCCcGJsKxBbBw5A6Wd1
 WO+pXi3BFbZJqyBv9NA6zz6zw7vQ77Cwt4tQSIVCnzuWcnxzv2cjI5j586SgKaA5XHtCvGDNeAp
 b+Vk=
X-Received: by 2002:a5d:5f50:0:b0:3ce:1750:311 with SMTP id
 ffacd0b85a97d-3d1df34c669mr4735857f8f.55.1756709995481; 
 Sun, 31 Aug 2025 23:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Gl68Pc7QYpxEBpiHe6YHzm8kVvhACwFBHrAlOWnKLOishDai2T15qO7IOxmsx5NykB7xyQ==
X-Received: by 2002:a5d:5f50:0:b0:3ce:1750:311 with SMTP id
 ffacd0b85a97d-3d1df34c669mr4735837f8f.55.1756709994952; 
 Sun, 31 Aug 2025 23:59:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d85f80d8casm519459f8f.54.2025.08.31.23.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 23:59:54 -0700 (PDT)
Message-ID: <238387ee-055e-40c2-a889-66cb320e26c8@redhat.com>
Date: Mon, 1 Sep 2025 08:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: Fix build error with CONFIG_POWERNV disabled
To: Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20250820122516.949766-2-adityag@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250820122516.949766-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/20/25 14:25, Aditya Gupta wrote:
> Currently when CONFIG_POWERNV is not enabled, the build fails, such as
> with --without-default-devices:
> 
>      $ ./configure --without-default-devices
>      $ make
> 
>      [281/283] Linking target qemu-system-ppc64
>      FAILED: qemu-system-ppc64
>      cc -m64 @qemu-system-ppc64.rsp
>      /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_load_sprd':
>      .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined reference to `pnv_chip_find_core'
>      /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_store_sprd':
>      .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined reference to `pnv_chip_find_core'
>      collect2: error: ld returned 1 exit status
>      ...
> 
> This is since target/ppc/misc_helper.c references PowerNV specific
> 'pnv_chip_find_core' call.
> 
> Split the PowerNV specific SPRD code out of the generic PowerPC code, by
> moving the SPRD code to pnv.c
> 
> Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>


Acked-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
> Note that while moving the code, the 'target_ulong' type for sprc has been
> modified to 'uint64_t'.
> 
> Based on the discussion happened on [1].
> Requires patch 1 and patch 2 of [1] to be applied, to fix the build.
> 
> [1]: https://lore.kernel.org/qemu-devel/20250526112346.48744-1-philmd@linaro.org/
> ---
> ---
>   hw/ppc/pnv.c             | 86 ++++++++++++++++++++++++++++++++++++++++
>   target/ppc/cpu.h         |  4 ++
>   target/ppc/misc_helper.c | 59 +++------------------------
>   3 files changed, 96 insertions(+), 53 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d84c9067edb3..9c74f46091a7 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -21,6 +21,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/datadir.h"
> +#include "qemu/log.h"
>   #include "qemu/units.h"
>   #include "qemu/cutils.h"
>   #include "qapi/error.h"
> @@ -1794,12 +1795,83 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
>       }
>   }
>   
> +static uint64_t pnv_handle_sprd_load(CPUPPCState *env)
> +{
> +    PowerPCCPU *cpu = env_archcpu(env);
> +    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
> +    uint64_t sprc = env->spr[SPR_POWER_SPRC];
> +
> +    if (pc->big_core) {
> +        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
> +    }
> +
> +    switch (sprc & 0x3e0) {
> +    case 0: /* SCRATCH0-3 */
> +    case 1: /* SCRATCH4-7 */
> +        return pc->scratch[(sprc >> 3) & 0x7];
> +
> +    case 0x1e0: /* core thread state */
> +        if (env->excp_model == POWERPC_EXCP_POWER9) {
> +            /*
> +             * Only implement for POWER9 because skiboot uses it to check
> +             * big-core mode. Other bits are unimplemented so we would
> +             * prefer to get unimplemented message on POWER10 if it were
> +             * used anywhere.
> +             */
> +            if (pc->big_core) {
> +                return PPC_BIT(63);
> +            } else {
> +                return 0;
> +            }
> +        }
> +        /* fallthru */
> +
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
> +                                  TARGET_FMT_lx"\n", sprc);
> +        break;
> +    }
> +    return 0;
> +}
> +
> +static void pnv_handle_sprd_store(CPUPPCState *env, uint64_t val)
> +{
> +    PowerPCCPU *cpu = env_archcpu(env);
> +    uint64_t sprc = env->spr[SPR_POWER_SPRC];
> +    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
> +    int nr;
> +
> +    if (pc->big_core) {
> +        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
> +    }
> +
> +    switch (sprc & 0x3e0) {
> +    case 0: /* SCRATCH0-3 */
> +    case 1: /* SCRATCH4-7 */
> +        /*
> +         * Log stores to SCRATCH, because some firmware uses these for
> +         * debugging and logging, but they would normally be read by the BMC,
> +         * which is not implemented in QEMU yet. This gives a way to get at the
> +         * information. Could also dump these upon checkstop.
> +         */
> +        nr = (sprc >> 3) & 0x7;
> +        pc->scratch[nr] = val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
> +                                  TARGET_FMT_lx"\n", sprc);
> +        break;
> +    }
> +}
> +
>   static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>   {
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
>       Pnv9Chip *chip9 = PNV9_CHIP(dev);
>       PnvChip *chip = PNV_CHIP(dev);
>       Pnv9Psi *psi9 = &chip9->psi;
> +    PowerPCCPU *cpu;
> +    PowerPCCPUClass *cpu_class;
>       Error *local_err = NULL;
>       int i;
>   
> @@ -1827,6 +1899,12 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    /* Set handlers for Special registers, such as SPRD */
> +    cpu = chip->cores[0]->threads[0];
> +    cpu_class = POWERPC_CPU_GET_CLASS(cpu);
> +    cpu_class->load_sprd = pnv_handle_sprd_load;
> +    cpu_class->store_sprd = pnv_handle_sprd_store;
> +
>       /* XIVE interrupt controller (POWER9) */
>       object_property_set_int(OBJECT(&chip9->xive), "ic-bar",
>                               PNV9_XIVE_IC_BASE(chip), &error_fatal);
> @@ -2078,6 +2156,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
>       PnvChip *chip = PNV_CHIP(dev);
>       Pnv10Chip *chip10 = PNV10_CHIP(dev);
> +    PowerPCCPU *cpu;
> +    PowerPCCPUClass *cpu_class;
>       Error *local_err = NULL;
>       int i;
>   
> @@ -2105,6 +2185,12 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    /* Set handlers for Special registers, such as SPRD */
> +    cpu = chip->cores[0]->threads[0];
> +    cpu_class = POWERPC_CPU_GET_CLASS(cpu);
> +    cpu_class->load_sprd = pnv_handle_sprd_load;
> +    cpu_class->store_sprd = pnv_handle_sprd_store;
> +
>       /* XIVE2 interrupt controller (POWER10) */
>       object_property_set_int(OBJECT(&chip10->xive), "ic-bar",
>                               PNV10_XIVE2_IC_BASE(chip), &error_fatal);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 6b90543811f0..0e26e4343de7 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1522,6 +1522,10 @@ struct PowerPCCPUClass {
>       void (*init_proc)(CPUPPCState *env);
>       int  (*check_pow)(CPUPPCState *env);
>       int  (*check_attn)(CPUPPCState *env);
> +
> +    /* Handlers to be set by the machine initialising the chips */
> +    uint64_t (*load_sprd)(CPUPPCState *env);
> +    void (*store_sprd)(CPUPPCState *env, uint64_t val);
>   };
>   
>   static inline bool ppc_cpu_core_single_threaded(CPUState *cs)
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index e7d94625185c..0e625cbb704d 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -328,69 +328,22 @@ target_ulong helper_load_sprd(CPUPPCState *env)
>        * accessed by powernv machines.
>        */
>       PowerPCCPU *cpu = env_archcpu(env);
> -    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
> -    target_ulong sprc = env->spr[SPR_POWER_SPRC];
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>   
> -    if (pc->big_core) {
> -        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
> +    if (pcc->load_sprd) {
> +        return pcc->load_sprd(env);
>       }
>   
> -    switch (sprc & 0x3e0) {
> -    case 0: /* SCRATCH0-3 */
> -    case 1: /* SCRATCH4-7 */
> -        return pc->scratch[(sprc >> 3) & 0x7];
> -
> -    case 0x1e0: /* core thread state */
> -        if (env->excp_model == POWERPC_EXCP_POWER9) {
> -            /*
> -             * Only implement for POWER9 because skiboot uses it to check
> -             * big-core mode. Other bits are unimplemented so we would
> -             * prefer to get unimplemented message on POWER10 if it were
> -             * used anywhere.
> -             */
> -            if (pc->big_core) {
> -                return PPC_BIT(63);
> -            } else {
> -                return 0;
> -            }
> -        }
> -        /* fallthru */
> -
> -    default:
> -        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
> -                                  TARGET_FMT_lx"\n", sprc);
> -        break;
> -    }
>       return 0;
>   }
>   
>   void helper_store_sprd(CPUPPCState *env, target_ulong val)
>   {
> -    target_ulong sprc = env->spr[SPR_POWER_SPRC];
>       PowerPCCPU *cpu = env_archcpu(env);
> -    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
> -    int nr;
> -
> -    if (pc->big_core) {
> -        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
> -    }
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>   
> -    switch (sprc & 0x3e0) {
> -    case 0: /* SCRATCH0-3 */
> -    case 1: /* SCRATCH4-7 */
> -        /*
> -         * Log stores to SCRATCH, because some firmware uses these for
> -         * debugging and logging, but they would normally be read by the BMC,
> -         * which is not implemented in QEMU yet. This gives a way to get at the
> -         * information. Could also dump these upon checkstop.
> -         */
> -        nr = (sprc >> 3) & 0x7;
> -        pc->scratch[nr] = val;
> -        break;
> -    default:
> -        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
> -                                  TARGET_FMT_lx"\n", sprc);
> -        break;
> +    if (pcc->store_sprd) {
> +        return pcc->store_sprd(env, val);
>       }
>   }
>   


