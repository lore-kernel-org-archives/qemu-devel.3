Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2344D35E5D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zk8-0008G5-CL; Thu, 07 Nov 2024 05:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zk7-0008Fk-1B
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:27:59 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zk5-00031N-5y
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:27:58 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cefa22e9d5so861777a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 02:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730975275; x=1731580075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wX89TnjD0GpGlaLexSSa5ZtdHMZ3CG5OaqI44rLpj68=;
 b=B3WSYVbDWJqg4k5J1ESIviAE75+z4hnGrL39vN1OuDjjBbV/ke1LS6CGyYdQLgbzcL
 RxxcEy+bjjWNBC7yCPZQDVPOfH4btjv8eJVXvJEZFk7gXJ38HDBQC8NxPprt27R7zxCd
 O2pXhXd2oqQPqc0/VwwDM0Pc95rvk6mI3jP06trTLOmUsZPEpqkNp4EwPidkINVYgQV3
 YOs6IL4VIh5SJ323Jf/kw/Oj9q34J4/oqhJ8FR7qbKpDEArUrmkZE2dwCjmG//bSilRR
 3OXX7/o4krGujOxAaagLi2nQGSnQM7kYTlTmztsjxASmv2bljT8aH1jGpRpfbgl8L4AJ
 3yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730975275; x=1731580075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wX89TnjD0GpGlaLexSSa5ZtdHMZ3CG5OaqI44rLpj68=;
 b=vAYC+PkQuq8Ui8DNTRPFw5hAC3hPlYS2lPQ3Le1+4SxtOc6Sagv4Y5G/nOaOzjx7Dn
 LJjQrCrtvH19M3KK+5oWxRLa1lMdfmuz7sCUFd+5Hz+Rgi3Qbw/W+RTLOPt119okSkr6
 1qDM6L+n3tZeIQEuPxFaHhSxUQ8+erDGyq5zkfFH19PbE2C/n7UJ6Qspn2IP6u80VyhJ
 AmZewLc0Tf45HoNsm6RyMO+81gnQ1MvRSJv22pU9KBlFDeEcihmzcxsO4pqR0XGBe+JZ
 PWNomPI3V9BcQyJ5XR+BraiZj+NVTnPKlenIcqzgnoh6a53Otw4HP4vmyV8gPwOEdBkj
 ST3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU36/d0DDYDTOGZho2eHcJI0bFI4GWIhgXQCmmb7rMy9gJhJWpJjXC8Nv13o3RXcDy6r0+YV2JLCkd1@nongnu.org
X-Gm-Message-State: AOJu0YyYMa+fw2A8VOpyItIc7BxFReBj5honEQK72q03ETtiUpTB2FPv
 DPDMvCtOfhjoIByF0DlXr21sdIo8i+2udcMpYl/SOcidvoAdggVkdWgIYeBy4qk=
X-Google-Smtp-Source: AGHT+IGphrqkXkWHTyHuNwAPyV6arluOUpEoEGVjQ2zhmTT5qa3TBFyONb2yrfl4zAcwMb5V78kkLw==
X-Received: by 2002:a05:6402:3202:b0:5c4:14fe:971e with SMTP id
 4fb4d7f45d1cf-5cbbf920567mr30670560a12.23.1730975275173; 
 Thu, 07 Nov 2024 02:27:55 -0800 (PST)
Received: from [172.16.23.118] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c7d957sm609806a12.87.2024.11.07.02.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 02:27:54 -0800 (PST)
Message-ID: <fe69adc2-0ebb-4be0-93a2-9a45d87c36d3@linaro.org>
Date: Thu, 7 Nov 2024 10:27:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] hw/char/xilinx_uartlite: Make device endianness
 configurable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
 <20241107012223.94337-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241107012223.94337-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x530.google.com
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

On 11/7/24 01:22, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> Add the "little-endian" property to select the device
> endianness, defaulting to little endian.
> Set the proper endianness on the single machine using the
> device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/xilinx_uartlite.c                | 44 ++++++++++++++++--------
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>   2 files changed, 31 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static const MemoryRegionOps uart_ops[2] = {
> +    {
> +        .read = uart_read,
> +        .write = uart_write,
> +        .endianness = DEVICE_BIG_ENDIAN,
> +        .impl = {
> +            .min_access_size = 4,
> +            .max_access_size = 4,
> +        },
> +        .valid = {
> +            .min_access_size = 1,
> +            .max_access_size = 4,
> +        },
> +    }, {
> +        .read = uart_read,
> +        .write = uart_write,
> +        .endianness = DEVICE_LITTLE_ENDIAN,
> +        .impl = {
> +            .min_access_size = 4,
> +            .max_access_size = 4,
> +        },
> +        .valid = {
> +            .min_access_size = 1,
> +            .max_access_size = 4,
> +        },
>       }
>   };

Having looked at several of these now, it occurs to me that you can avoid repetition:

static const MemoryRegionOps uart_ops[2] = {
     [0 ... 1] = {
         .read = uart_read,
         etc,
     },
     [0].endianness = DEVICE_BIG_ENDIAN,
     [1].endianness = DEVICE_LITTLE_ENDIAN,
};


r~

