Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E69CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn7n-0002z4-Rj; Tue, 26 May 2026 04:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRn7m-0002t0-8t
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:26:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRn7k-0002jS-Ec
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:26:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490686877a1so11493555e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779784010; x=1780388810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ULtot8w9qIOk7PPpVeeabGIm/pUcPWaxDf+W3s9hr+o=;
 b=x6pKuN4kvQEOO1aiUnSXnBKgMz85QrKlcckRphnorTXx7ieeQzHiJoavD2XU4AYgDv
 +q2eoejhUiFDz5/LIbo/9d8T/l7hW1QgLkYaCpfRbjbkH06SqfXH9lS8x59Ku9UJENWc
 ShvLl+a8/ZG85WmyiUIFrD0qpoH1HbmRMraigk5IVUWdThpCtmyC5eSk4lN3A2RoecP8
 Lm43ARpnLOntOaKwDcuxilccte92IjT7OaWw2btEIjedGZObUBH0D7N9ezVFNorinh6+
 QB6pcbUOL2Dmxtud5wtSWJPTeTH9o2jfoOta6cD8aQ3nTlc3F0pGL8Z6CyrWgiOy2l0f
 Oiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779784010; x=1780388810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ULtot8w9qIOk7PPpVeeabGIm/pUcPWaxDf+W3s9hr+o=;
 b=lH0WVLnlgZ+iOx9Y35iG/gnoh8AwVF2lFO3PAyhUAToU3rDwtrXzHXXMcs1E6I5wgl
 a4znOkZn10l8ozqHhf6HAODYE7n1DFbJRyqsL6YdyRE4gIWzng03WdiDGibVlrsQjjoy
 AF58rEIrVZAqnk4WwErTpeIVU8H2tfmQsUkduTKRbO4JONioROaFZEuQzN35a3GszQAT
 gPGOeroIiqYWK8L2Am9724UxmbTJzqoVyjzecOIntZfOzZVYYl7lvymFuA5sM7TAjAhD
 v1tajUaCRsjkE0xu/2VArHfsSnDjB3dptI2GAYsd2r9ioTQBGM3DOPvtflKgSyJql/Ir
 2hAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XYj5ceARxKkyXKb5vR/PmtNm1ymMI4Nb8jxABoCaloqoP5TpONq9hO7S9Lb32zNCrZh0chtHk9j/V@nongnu.org
X-Gm-Message-State: AOJu0YzthrDQkBK6kb5P9hAFEI80R9QRtrjMUBGF3U55vK5N82hWP869
 1ps54V3YRCaUV1VCoG1cr3Hj0HhRmKGtMwew5lGrylV447RUvMbETw+G1cGUkDOBHaskxaRmBFd
 lthWu4nUbwg==
X-Gm-Gg: Acq92OHJPCJM9qT9Lz8EQafmMsO0v7jSsCYeTZ0mnl9dRN1XTEP05LfEPHtOgZhGVGI
 Afr/oxVx1Vg1ZoCuW3Lzl9MgTPmXfHeLndPX2CC2epjtBnkOmqzFsYDRKbrz6157Xow8U9wy006
 uK+OV+/yTiEGBVOFhwGDVEgDfofDlGdj4NE40DDeKSGI8l3XbSbjCfiMIJoVhvFzbGyENoJDWmF
 rPd8Q9v54G/1AkMe6NpPiyXeJqx4UMQtcyULBa7jcl9/EOFMPqCuYwJYcL4C5HUboFG2M04QeBv
 8Hx/Y4blpBXDcWFm3GhOJoPqjTX4P9+awqYAF2EdcJUGE3Hexj78cuREgnzIBWb3bJLiEYgOZnE
 NfmodiP/z2MFSHMtQuVNQDpqaF/fiiJuSZ8ys+TMnMdtGtu/3x+9x5zkKzU1y6bXJz14JKeijG/
 rFg/URO0+R+7rsEAZp/OjWT2hSoJHNQPqTYL3nRZHSDQK4cmBSrur+D+RTYNfwMu2+EELr1dE=
X-Received: by 2002:a05:600c:4746:b0:490:3d48:6cb9 with SMTP id
 5b1f17b1804b1-4904225f7efmr270273675e9.3.1779784010380; 
 Tue, 26 May 2026 01:26:50 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490424b5b80sm146973805e9.6.2026.05.26.01.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 01:26:49 -0700 (PDT)
Message-ID: <f99bbe2d-07d6-4cd5-a309-78d521f9127d@linaro.org>
Date: Tue, 26 May 2026 10:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 37/48] target/riscv: do not set defaults in cpu prop
 callback
Content-Language: en-US
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
 <20260522000324.23255-38-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260522000324.23255-38-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/5/26 02:03, alistair23@gmail.com wrote:
> From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> Do not rely on riscv_cpu_* arrays to set rv32/rv64 CPU defaults - add
> them to the CPU definition like we do with all other CPUs (aside from
> 'max').

Hmm this change is unfortunate, I was about to replace the 3 machine
uses of TYPE_RISCV_CPU_BASE by "max" (they were semantically identical).

Why do we need these "base" CPU types and can't use "max" instead?
Because they are "fake but stable" why "max" doesn't aim to be?

> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20260512032926.1978818-13-daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c         | 40 ++++++++++++++++++++++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c | 14 -------------
>   2 files changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 64e3fa4ef0..5d3383f335 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3076,6 +3076,26 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
>           .cfg.max_satp_mode = VM_1_10_SV32,
>           .misa_mxl_max = MXL_RV32,
> +
> +        /*  Default extensions as of QEMU 11.1.  */
> +        .cfg.ext_zicbom = true,
> +        .cfg.ext_zicbop = true,
> +        .cfg.ext_zicboz = true,
> +        .cfg.ext_zicntr = true,
> +        .cfg.ext_zicsr = true,
> +        .cfg.ext_zifencei = true,
> +        .cfg.ext_zihintntl = true,
> +        .cfg.ext_zihintpause = true,
> +        .cfg.ext_zihpm = true,
> +        .cfg.ext_zawrs = true,
> +        .cfg.ext_zfa = true,
> +        .cfg.ext_zba = true,
> +        .cfg.ext_zbb = true,
> +        .cfg.ext_zbc = true,
> +        .cfg.ext_zbs = true,
> +        .cfg.ext_sstc = true,
> +        .cfg.ext_svadu = true,
> +        .cfg.ext_svvptc = true,
>       ),
>   
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
> @@ -3128,6 +3148,26 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
>           .cfg.max_satp_mode = VM_1_10_SV57,
>           .misa_mxl_max = MXL_RV64,
> +
> +        /*  Default extensions as of QEMU 11.1.  */
> +        .cfg.ext_zicbom = true,
> +        .cfg.ext_zicbop = true,
> +        .cfg.ext_zicboz = true,
> +        .cfg.ext_zicntr = true,
> +        .cfg.ext_zicsr = true,
> +        .cfg.ext_zifencei = true,
> +        .cfg.ext_zihintntl = true,
> +        .cfg.ext_zihintpause = true,
> +        .cfg.ext_zihpm = true,
> +        .cfg.ext_zawrs = true,
> +        .cfg.ext_zfa = true,
> +        .cfg.ext_zba = true,
> +        .cfg.ext_zbb = true,
> +        .cfg.ext_zbc = true,
> +        .cfg.ext_zbs = true,
> +        .cfg.ext_sstc = true,
> +        .cfg.ext_svadu = true,
> +        .cfg.ext_svvptc = true,
>       ),
>   
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 50d9218a75..7575884d7e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1553,24 +1553,10 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
>   static void cpu_add_multi_ext_prop(Object *cpu_obj,
>                                      const RISCVCPUMultiExtConfig *multi_cfg)
>   {
> -    bool generic_cpu = riscv_cpu_is_generic(cpu_obj);
> -
>       object_property_add(cpu_obj, multi_cfg->name, "bool",
>                           cpu_get_multi_ext_cfg,
>                           cpu_set_multi_ext_cfg,
>                           NULL, (void *)&multi_cfg->offset);
> -
> -    if (!generic_cpu) {
> -        return;
> -    }
> -
> -    /*
> -     * Set def val directly instead of using
> -     * object_property_set_bool() to save the set()
> -     * callback hash for user inputs.
> -     */
> -    isa_ext_update_enabled(RISCV_CPU(cpu_obj), multi_cfg->offset,
> -                           multi_cfg->enabled);
>   }
>   
>   static void riscv_cpu_add_multiext_prop_array(Object *obj,


