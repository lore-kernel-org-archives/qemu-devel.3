Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC50C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 10:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUjv-000475-7e; Mon, 26 May 2025 06:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUjt-00046P-1m
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:07:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUjo-0000R8-Qm
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:07:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso26189175e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748254039; x=1748858839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UeWDwAIij9m4P5yCgviVByHQv/VRO+qlqUjNrp5s81Y=;
 b=keyOla8TBUjjebCptlITw65RiD4rf3p9KQU0N3hWSb6UeYigCd9U41aCA0qbUO5U5l
 hghq31V+Oo0GS0vZfE+bS95RNANPZ2/Sq2AzcxJ+aj9+nRU6g++qV2U/M3ibZIogXimv
 +Giu8zM3UMEFnDIwgJU3LX4lNHjOz+LtqYSzPztcX1vizjtMEu5Ur2P7GDMExPGVJ0i4
 alWupVWvhTiVDFlPllE5mSJ4YOO/KwxZW81CUxwq5eRlcz0EJthqAjN68SbuSGczMuFy
 TF1qMA/rkMDn6E5ENY2Zd2PPZ82O1dYV1X3NCrri1z3rHgHuCmR4KHJjanOyjRVy5rSW
 xvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254039; x=1748858839;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UeWDwAIij9m4P5yCgviVByHQv/VRO+qlqUjNrp5s81Y=;
 b=UB2S7F+vJmTzMdL9KqABTZ8d/mQne5Y4S53Ozkztc0QE1c1oqcL4k2mChU6MdVhhp+
 G7oeDbFKbD6YCQz4OEr9tQCgUfpUe9KZOgjYBY3/KgqiEWsczY354L8S/jAYGbfNWhmz
 txXy1AUD6Pdc4HepddtgnRbP8qsgLqEQhM7jyqWK50hu6a65aJi2FmprXTBxBxHpKG21
 xQAR6V7L5zhT5zddQ6CEhRtHIs+dtYlBQ5qlmjmF11s+i89mk3Pv0O9cTXdFQiF9Rmma
 kLaKmjl9IoTTGK3N0Er0ZklVNjJITlYQaMtoKSLzc4N7M4X8oh+d1ghZDxvC8ipyu7R+
 NeWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNwthZhy0MSFRVaJw1+v7yl9opBro2rd5WVEejWK7RyDMmCIe3N6DRUvrZQ+UJYa3se5Tckbz8Cq93@nongnu.org
X-Gm-Message-State: AOJu0YwrVPa9YY0VERxptESr6c9YUTr195ncc45on+AZXzWVH/7yW86Q
 5BN8QZZs1dJsyROe0cMM5N45+4Wc9XlAVnB8m3FOaKakleBNNQg1BH6in31QE9wPd9c=
X-Gm-Gg: ASbGncsMgQ/0ltIFrvNsKR0Q0N/bwEevVld4JTBkgPWiNuZAcy/m01yCVZd8FpzxzOe
 5cZuMZaiHQmSU/KDevQ73jK5QVtPCF+9Rp56It/8gecEemgnU46+GQMzitdy0G84qaAJEdRWbSx
 YpZC0N7rs72vbvVySAAOYzRxReSVtyFBlHSREUxIJIyoe1Ldxw4dim1wayfKbpnDewSrCAIJheJ
 GY+bCBGNkofvW48viNtNM0U2DCAybzRJh0s02vU1jaaJl0PWNzfwFBA6BYIZv8jPk+xb7BEzr3n
 9IzjDDziGeBZHTHReYxgyFVpizTjdw5EzohFQG02730ypIEDP+/UUopp4juMhopWDtFr1KTfrHX
 NDoeUjJbHkfVJbmupHFyf7SBW
X-Google-Smtp-Source: AGHT+IE6xJlSgvyBMrkFwk/bvUzspZwflqpVzWji54kK0D9NZKfwYWo23bk+AA61wcCDcpmfSMliuw==
X-Received: by 2002:a05:600c:4684:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-44c955dc476mr70458015e9.21.1748254038651; 
 Mon, 26 May 2025 03:07:18 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f18251adsm239618765e9.2.2025.05.26.03.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 03:07:17 -0700 (PDT)
Message-ID: <be8c1d4d-b68e-42b1-9466-3698ded1be10@linaro.org>
Date: Mon, 26 May 2025 12:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/4] acpi: Add machine option to disable SPCR table
To: Li Chen <me@linux.beauty>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
References: <87msberqzi.wl-me@linux.beauty> <87ldqyrqqo.wl-me@linux.beauty>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ldqyrqqo.wl-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Li,

On 15/5/25 14:41, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> The ACPI SPCR (Serial Port Console Redirection) table allows firmware
> to specify a preferred serial console device to the operating system.
> On ARM64 systems, Linux by default respects this table: even if the
> kernel command line does not include a hardware serial console (e.g.,
> "console=ttyAMA0"), the kernel still register the serial device
> referenced by SPCR as a printk console.
> 
> While this behavior is standard-compliant, it can lead to situations
> where guest console behavior is influenced by platform firmware rather
> than user-specified configuration. To make guest console behavior more
> predictable and under user control, this patch introduces a machine
> option to explicitly disable SPCR table exposure:
> 
>      -machine spcr=off
> 
> By default, the option is enabled (spcr=on), preserving existing
> behavior. When disabled, QEMU will omit the SPCR table from the guest's
> ACPI namespace, ensuring that only consoles explicitly declared in the
> kernel command line are registered.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> ---


> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 765dc8dd35..089104d54b 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -444,6 +444,7 @@ struct MachineState {
>       SmpCache smp_cache;
>       struct NVDIMMState *nvdimms_state;
>       struct NumaState *numa_state;
> +    bool enable_spcr;

This structure is used by all machines. Can we be more
descriptive, maybe naming as "acpi_spcr_enabled"?

Thanks,

Phil.


