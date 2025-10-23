Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDB1CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBowS-0003Eq-Ka; Thu, 23 Oct 2025 02:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBowF-0003Dy-Im
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:36:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBowD-0001or-Jf
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:36:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47112a73785so2454345e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 23:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761201400; x=1761806200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R6Q5MFwvDjOS0xKVwhua3gGzWVEz1/VyJNvNPp1Ufu8=;
 b=jFCsjo6byRTQNCegc03P2m06rONry3fC414rsy5lBHzeKnfuy4Vu8rhjGbCbnu1uxB
 CEWU8WGdIYvyvp7GXfIsvHdxXG23F2Uoaq1CKaTfifLLca85OP6S0BS/WqiaxDVzhKft
 GZvYnGWgxDgdwhGXXop6lqrjAAf+hzrii7IciMGYQiUK0UKa1gOUvcbe2PoL3bfhwpu4
 jk852Whpio27kuUSmMmTh8ja2skEgSmEFt/3Lz9E9/naT39CKFesQXdum7tiR0PAZOL8
 wIcSeHiPjtp9a4EXpD0zNJhIq3s+nY5pEzPjXmdHt95kWsRytrGx8k6hu0fNZw4CRP99
 IseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761201400; x=1761806200;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R6Q5MFwvDjOS0xKVwhua3gGzWVEz1/VyJNvNPp1Ufu8=;
 b=F7i6kAZf0jU2+KOcPcDUvY16r/xK/DGNa94jBCxrs3O60HpQ1XVMwGl6EL/HL1lc2V
 geBRCg0P/FQNysR0o11HNdsmn91AqR4EF55q6A7ND6mTqCugAQBLTz/RnLZdEsSmMV+E
 cvRAmKwwUvqEmSdB5aUS6fkeWHRZphmyeba7Fmyvf6Euajq52GpEjklWgUr50aQfHeaN
 rKmAwyAoRSnJi7qxJt3Nh1GzgztT2p1DC9Arj30FIMD+P2Ft+fUQZePT0c8w4NikMYwK
 8/dnGlpJVy2szP7P7Q6/VmBQemWyzVaiZTTi3pB8v55XieQ25/jzSkBryvJw6wdKwxu4
 4tFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhdDOVszvpshc7eJ1D2VLBQrOnNoghtHzdA9VmzWZc7a6JgUg5UyFlEcZkMPxYVSq11ixSVhqmr5j1@nongnu.org
X-Gm-Message-State: AOJu0YwW/BHZ4nAJAXfFq5Z1J9Zo7ngwJlC0JA3QYDod2t3U7i1HRQ+j
 tz1jfUXkTZKBiIMq0X92pDHcYT/KM+bp2NBn5ZbH6R5R9tqpkOkrAv7cU2i/qvpCGmw=
X-Gm-Gg: ASbGnctkdfQshmFt8Td2I86hnr7etR/LMs1fvB4IL4dl72uATN1XxQIwMsuOzM/bezR
 dXmNPxdQtG0/SBaCdpqCbTA/sOEJLDWc94mSBr5EfSQbAkVXAV3CjgUCaKy3tVWXVup/pMRn87G
 F6i5svKyVO2dpTpYBsl/oJvHdL4t/hotlxTpi87iCbURrO14Kc4+9gnTB5L2vH6A6sl4aJ9ml2q
 +PPPu9HqxWx2bI+8Uw/DjA8ZvK0fSDESSIdRV2LZlXsMS3pFD+lpcDfCwa4ON/VRLNxdtDz2CO8
 6xnROzOtmLs7z/Ek++yR75xUHQdDfnOL/19709OlMiPRMtXnE5CFWP+z5vVMngIsOW3akpolFxr
 R6hTPl3ZaRoqUCd+Goeu/e7Ms2Cc2LrUlz9VfRKZo2qmxzlZoeiOTENLpSmXVQX+1FTEG5ZD97F
 wWhDyHv8UKrxgAaBjXK6hfI2GqGeHPJm9ifZNiM0FutFo=
X-Google-Smtp-Source: AGHT+IEwQoA2tuUGMKIYhQed9a96ixjcbsCK1G2qnaW537BZkPpKE5pp68U7r0RX90ZnTcYoQCGtjA==
X-Received: by 2002:a05:600c:3494:b0:471:76f:80ed with SMTP id
 5b1f17b1804b1-47117934827mr167283665e9.41.1761201399803; 
 Wed, 22 Oct 2025 23:36:39 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cad4c81dsm20609215e9.0.2025.10.22.23.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 23:36:39 -0700 (PDT)
Message-ID: <73ea10fd-fbee-4c77-95ba-5520becdb910@linaro.org>
Date: Thu, 23 Oct 2025 08:36:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] hw/ppc/pegasos2: Add bus frequency to machine
 state
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <b69e21e353b7d7f22a34db5f13443f60f51c7238.1761176219.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b69e21e353b7d7f22a34db5f13443f60f51c7238.1761176219.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 23/10/25 02:06, BALATON Zoltan wrote:
> Store the bus frequency in the machine state and set it from instance
> init method.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index f5b56c0e94..7eaefcf9a0 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -55,8 +55,6 @@
>   #define H_PRIVILEGE  -3  /* Caller not privileged */
>   #define H_PARAMETER  -4  /* Parameter invalid, out-of-range or conflicting */
>   
> -#define BUS_FREQ_HZ 133333333


> -static void pegasos2_init(MachineState *machine)
> +static void pegasos_init(MachineState *machine)
>   {
>       PegasosMachineState *pm = PEGASOS_MACHINE(machine);
>       CPUPPCState *env;
> @@ -158,7 +157,7 @@ static void pegasos2_init(MachineState *machine)
>       }
>   
>       /* Set time-base frequency */
> -    cpu_ppc_tb_init(env, BUS_FREQ_HZ / 4);
> +    cpu_ppc_tb_init(env, pm->bus_freq_hz / 4);

As a future cleanup patch on top, please replace the magic '4' value ...
> -static void add_cpu_info(void *fdt, PowerPCCPU *cpu)
> +static void add_cpu_info(void *fdt, PowerPCCPU *cpu, int bus_freq)
>   {
>       uint32_t cells[2];
>   
> @@ -824,8 +831,8 @@ static void add_cpu_info(void *fdt, PowerPCCPU *cpu)
>       qemu_fdt_setprop_cell(fdt, cp, "reservation-granule-size", 4);
>       qemu_fdt_setprop_cell(fdt, cp, "timebase-frequency",
>                             cpu->env.tb_env->tb_freq);
> -    qemu_fdt_setprop_cell(fdt, cp, "bus-frequency", BUS_FREQ_HZ);
> -    qemu_fdt_setprop_cell(fdt, cp, "clock-frequency", BUS_FREQ_HZ * 7.5);
> +    qemu_fdt_setprop_cell(fdt, cp, "bus-frequency", bus_freq);
> +    qemu_fdt_setprop_cell(fdt, cp, "clock-frequency", bus_freq * 7.5);
... and this '7.5' one by descriptive definitions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


