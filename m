Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EA8D5C0E1
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9QZA-0000po-AW; Fri, 08 Nov 2024 10:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9QZ5-0000m6-Ik
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:06:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9QZ2-0008JM-Vi
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:06:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so19700355e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731078379; x=1731683179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FG9TMhU6vicNJDI9tfofWm0arHe+KcmjOwTjp3PPNxA=;
 b=mGOG0YPr+CKW3BpdeQVoSUclVsUwXZZBSryNvQVfkhk035/qBsxZby65rps83MjkC1
 bs+vIbxIrCUT9poDjRUATpkSXmaP+7W23v3hw02V4LAIjEkdhkU0/4DQQFHcqpYBBfoQ
 BBMp3SkhWLOTgTyuqQhAbDe1WXf5OJDeXBuD14+hcLZf6rdZPdHmnxXzx6MvCGYWV3m1
 fRy+r2rBPmJiTGyZdfiTJLpttE4bS30U4u7DOaRda/KNvoZJZOhDHAPtFFoA5XH61B8h
 C1nPJIctQceIwab7TNV2HDeSXxvxspvU0zVwUyO/9X1D3zM9OBoEQ3DhgKTZWEJoyoBc
 j15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731078379; x=1731683179;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FG9TMhU6vicNJDI9tfofWm0arHe+KcmjOwTjp3PPNxA=;
 b=rYBPDKCK9NcIlbo1GfVNMb+kUykOHD3Y0da7Fcf5s4IsQovHmUw6DP+hw5tGb/bLxr
 KGkYSBrD0WExFMVYxGdB1yKxfCMqBMwFIdRlvFJrsO7b91GMtiN3GGlCa/HxVQnkdZt0
 sjK3MxkL7w0r+V4p6vES9V9wM/MW3BFCrIydJ540zr6g1QcmiIaa4JwDX+PtCKX+VDq4
 pJWkeJWy5VktI0XW8sVWq/MOlPaD5OOZUgpJeE0BZRoYNN5tzbQPVXgfqoB8PDAe0in+
 v556k3A9BFznGb8iZ29/09HaUrdkJTN0XO8ckURXSLX7JazEgc9o1yuqkUJEbVVmxLDs
 wNHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW394M4MsnJCup6lhMiWNapNoPhwSMtEPi3yblAlL5pQDTLD/0qITefA7192vTnvUtfZ1raqKIBCP2d@nongnu.org
X-Gm-Message-State: AOJu0YyQ+1CsfqY8OW387Q2gDAY/ggcaL8DICahzP9ePxeUudzstvWWC
 VC0omdpJqlPtW9txy5LYGUnbW1TkJOBbQLvSNvNqfVjmN77JyT9ZScOygHB9m+o=
X-Google-Smtp-Source: AGHT+IGO0a9cEfI2j4dEYh+bJyscxS+29KDOpBYYybo+2JVwHXTyLYzWkK1n7CE6WYf0vBvJJMTUAg==
X-Received: by 2002:a05:600c:46c8:b0:432:7c08:d11e with SMTP id
 5b1f17b1804b1-432b74fedc8mr26804375e9.1.1731078378934; 
 Fri, 08 Nov 2024 07:06:18 -0800 (PST)
Received: from [172.16.22.241] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381edc1104asm5204268f8f.88.2024.11.08.07.06.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 07:06:18 -0800 (PST)
Message-ID: <7aca01f1-ba87-49be-82bf-54979d22db60@linaro.org>
Date: Fri, 8 Nov 2024 15:06:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] hw/char/xilinx_uartlite: Make device endianness
 configurable
To: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
 <20241107012223.94337-8-philmd@linaro.org>
 <fe69adc2-0ebb-4be0-93a2-9a45d87c36d3@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fe69adc2-0ebb-4be0-93a2-9a45d87c36d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 7/11/24 10:27, Richard Henderson wrote:
> On 11/7/24 01:22, Philippe Mathieu-Daudé wrote:
>> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
>> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
>> Add the "little-endian" property to select the device
>> endianness, defaulting to little endian.
>> Set the proper endianness on the single machine using the
>> device.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/char/xilinx_uartlite.c                | 44 ++++++++++++++++--------
>>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>>   2 files changed, 31 insertions(+), 14 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +static const MemoryRegionOps uart_ops[2] = {
>> +    {
>> +        .read = uart_read,
>> +        .write = uart_write,
>> +        .endianness = DEVICE_BIG_ENDIAN,
>> +        .impl = {
>> +            .min_access_size = 4,
>> +            .max_access_size = 4,
>> +        },
>> +        .valid = {
>> +            .min_access_size = 1,
>> +            .max_access_size = 4,
>> +        },
>> +    }, {
>> +        .read = uart_read,
>> +        .write = uart_write,
>> +        .endianness = DEVICE_LITTLE_ENDIAN,
>> +        .impl = {
>> +            .min_access_size = 4,
>> +            .max_access_size = 4,
>> +        },
>> +        .valid = {
>> +            .min_access_size = 1,
>> +            .max_access_size = 4,
>> +        },
>>       }
>>   };
> 
> Having looked at several of these now, it occurs to me that you can 
> avoid repetition:
> 
> static const MemoryRegionOps uart_ops[2] = {
>      [0 ... 1] = {
>          .read = uart_read,
>          etc,
>      },
>      [0].endianness = DEVICE_BIG_ENDIAN,
>      [1].endianness = DEVICE_LITTLE_ENDIAN,
> };

Thank you :) I had the idea it was possible then forgot about it.


