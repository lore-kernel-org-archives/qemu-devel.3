Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0168C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGeb-0002Q4-EF; Tue, 21 Jan 2025 10:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGeZ-0002Kv-IC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:58:59 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGeW-0002OB-QF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:58:59 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f13acbe29bso10626439a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737475135; x=1738079935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yteJLDrX8z9NwzKuY0oEKuSDaISpzfgmtAaJccmDPHA=;
 b=lantP6kdaMjvcEm5pgofCn4+Mtn+FXbyqX8Z/DrZTK/XLngIZMC4X3DzHEDPSTIgNT
 sGpw519b40qlszupeVpFWDR+8LM7RdfC8A8Wlwv5T87z94gSkSKfOBb0CsM2+26Rxf2Y
 yNRMWUVXdee3NisXALRG/GSaUbh0OpLH04Kr/NcygyfE3l+O/o30Hk44yslR6jWBUVpS
 eT70zZm5i1opeVNTv6SiOmApqf0V7pSrxp3Qkdw/ohvk2yNk/uNHfQtuH6uY0sjBH+qZ
 +D7CSltlCzGyCZhCtY8R9UebLYb2CM+cV4qDSXFq91yKNKc61xsFfQj9AcKc4t/+odsm
 Wksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737475135; x=1738079935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yteJLDrX8z9NwzKuY0oEKuSDaISpzfgmtAaJccmDPHA=;
 b=Fv7Akrkqlp2dcv+sSLQE8nUdUezaEBIZqrG1JfwcJoZfvunHxVqy7fNlN/V7DTurb5
 Ke5+Ii2RlqO8CykMHChVNfmvH1wDmfqJOLx+wAhejCOq5onlXkvlly5z+EX38tgWdNqO
 w5DyHZyBakYUwNQg4ryAeGrybnEd97nb+08d/BQyKOlI50sqkZhbuSDall2F0xaupRkg
 k2THVhD7r33Wwh+ANrC27Kdh7Boqz1Q+OT0Zc3iTymAv06t/96g7R3CAFmfnDbncq6qj
 n0MN158FM1NjZdFk2aU7att6RNGP+FXzNxt3d4wTY9ROV+az0BshUZLJiLaWkYlHJpNo
 OmiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSIUq3QI1vL9IUMaCwORliryIDy+wYoGwThPt08XJ5uxIKgs16dMEfnPBloepcEIQa4SLNp55G8eCf@nongnu.org
X-Gm-Message-State: AOJu0YxU5QvUdvmG98Zkzuoa2SSYjs2fzory7zU4b6ufoCMqB1ewhTYM
 f9yFETmarXdwSMGQnSOFwiTbgM/GeTHS4Qm1XwSelLOyAVSu7XJ4EMRbCbFSl90=
X-Gm-Gg: ASbGncuaBbb8aVGl+VjoHnRJXfNtKtAfAlp9a8cXfIGx9D2Hh4wCvMq4yWiuQXsK1wb
 qg4yCiOAqUNj9rlc2kmrnmyBGa+7ghfYY7FzkRHsSvpS42JJfowjXwdwl3oiL+IAOHkHvoPOHsv
 SJ6Pqd7rmBpaXZUWsFQtsrXPk0YHyXlwOoNIOS6LKxE6LiHj4PcVJJQ55M6uD7ZpGNAtb3mN6i+
 F9YNnmi8xTxfDfSMQM429xxdRSTaMkRN1UKW9vT6bSFUerehM1dza+g4gmWqLhtIk94L4VYqNNy
 5lCG9gbinhfz+TsnU+yEf3hlxadFVbxJgBcj
X-Google-Smtp-Source: AGHT+IEgkZegK0SjTi3xJ/QmVsXTX0CJDEJNjPOImNSs5PJyZnSDQ7Baf1VP8jj+SH+D5dtqce3KmA==
X-Received: by 2002:a17:90b:1a81:b0:2ef:7be8:e987 with SMTP id
 98e67ed59e1d1-2f728e4841cmr38388767a91.12.1737475135233; 
 Tue, 21 Jan 2025 07:58:55 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c2bb2cdsm13277304a91.34.2025.01.21.07.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:58:54 -0800 (PST)
Message-ID: <b28eb9b2-750d-4297-80f3-36fda01ba94d@linaro.org>
Date: Tue, 21 Jan 2025 07:58:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] hw/acpi: Prefer cached CpuClass over
 CPU_GET_CLASS() macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121114056.53949-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 1/21/25 03:40, Philippe Mathieu-Daudé wrote:
> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/acpi/cpu.c         | 4 ++--
>   hw/acpi/cpu_hotplug.c | 3 +--
>   2 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index f70a2c045e1..6f1ae79edbf 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -235,8 +235,8 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>   
>   static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
>   {
> -    CPUClass *k = CPU_GET_CLASS(dev);
> -    uint64_t cpu_arch_id = k->get_arch_id(CPU(dev));
> +    CPUState *cpu = CPU(dev);
> +    uint64_t cpu_arch_id = cpu->cc->get_arch_id(cpu);
>       int i;
>   
>       for (i = 0; i < cpu_st->dev_count; i++) {
> diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
> index 83b8bc5deb8..aa0e1e3efa5 100644
> --- a/hw/acpi/cpu_hotplug.c
> +++ b/hw/acpi/cpu_hotplug.c
> @@ -62,10 +62,9 @@ static const MemoryRegionOps AcpiCpuHotplug_ops = {
>   static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
>                                        bool *swtchd_to_modern)
>   {
> -    CPUClass *k = CPU_GET_CLASS(cpu);
>       int64_t cpu_id;
>   
> -    cpu_id = k->get_arch_id(cpu);
> +    cpu_id = cpu->cc->get_arch_id(cpu);
>       if ((cpu_id / 8) >= ACPI_GPE_PROC_LEN) {
>           object_property_set_bool(g->device, "cpu-hotplug-legacy", false,
>                                    &error_abort);


