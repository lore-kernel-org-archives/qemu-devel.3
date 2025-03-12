Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6304C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsIxv-0002nh-Gp; Wed, 12 Mar 2025 06:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsIxt-0002kR-Vz
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:05:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsIxr-0005Mw-Nc
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:05:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394a823036so55429685e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741773924; x=1742378724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2C9dFStudi1AMR9evBY4Uacxl6jBaeGLRjAK+2tJq0M=;
 b=hgGw4+m5xuPVkqGbTXgjOd3ahUlrFilyprwYzjXeS4PKnoYGU0mAAI5EDoJ/3kLBMS
 kEqHuqRmlSvGhyk7DmER1rMf+xbrLNo0QYeK4bKGcMgG4KrnV/F4HlmSQtm3/8fXP6ci
 lyPg1ked+F9KCaRZt9pXouu4Tz4gEGjD474zWSO+o4eCVzF6Om+IK5ffbtfJzk8GMDB5
 b4WFRzSZponUBGkxSnycVeoHgx+MgK1uJ1YTqXylxpqcWtO3S3PoOBh2kqTxW/6BXWB5
 gWYpLeSg6rwRYz0MC4maV2H4tXSKovhbxmOcK7Wrw1jhYHbVqVWMj5D6Lc/PNCKAcKi4
 7+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741773924; x=1742378724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2C9dFStudi1AMR9evBY4Uacxl6jBaeGLRjAK+2tJq0M=;
 b=HUqVXaUG9QmwBayEKyid5dY7sH5Gg1J3NEV1BcE+8U6DA3AkcCje+O/QSKVqDluPtN
 hN16D3aoO5dA3nsAZIiiuwPLmc+Oj6uwGPwdZJG5C/60y/xQF34F8/cwkWi7HXblhFEd
 aw75vpvnPDN9rCiIclKkSB2RltWMP8c/KhoeuNiASRUe6WZFmsTpntjsIgo196zQ/oba
 tH84JfMUZwle389W3yDJk+oq6MbE9v2M/XOl2CdO9l+yICb3151yC2Se2hhWYEx4AlrA
 R3TCvd8kFzbyFFjf0dkpMxrJSOkk8FTlyXnwSpqaYmKWdBRN5FLb9kYfky3hNPcCwihp
 u0yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO/rXzxTBMubR2ornLIU0his+w31pQB5Qz0FfZbesjDOaTk7cKBjhFpsibrH+vrOgUNZD92kIQjLdo@nongnu.org
X-Gm-Message-State: AOJu0YyObMOJXcmG7VY88cViQ5g7B5lcgXtoJ2fOf6DPEvF5WF+OFEZU
 d30GLNWxYgOKnPptB+jjRa/YemULlF5K14H6Gv9H97gljD1e7SGrypBi7KUAWrI=
X-Gm-Gg: ASbGnct00ATDiU3zezR+rn3se9c8liTQI8KxeqKmq2rLS7ZK1e8KzCA8ng4LKE9eCe4
 UO6RQxv/AeXXn8UXGvdwng9uS6k5tC7XuMg42S+aaVzGHqxyGejcUU7SWY15ITYVGnKTBMaOMe7
 pelz+9bZnxjyWoH58lKoP6ExZLKv1cC44U6P1JK0LQMVfEWQIucb7pspA5L4ZuWjvmtr79mUNth
 K0leya5LhoJdKaeyJnOiez4qoeaO1seIR28IMryT52MNCiC7AEbrSK5fidLI3IhPSJ236f6NF0r
 vtzKkw5zPZ8TvRbJ15SyAQhWS2qavae4EKb2Jw+lJbZ4hgPvI0LrMYOcdh3yDcaB8mFrkcaEYtA
 NfOREHg==
X-Google-Smtp-Source: AGHT+IESRHyCP8MJ29SKLiEeGtZTeB2WnF4eTOuiJHXtUoMjCBPOZS3D8kFRKB85HAPsCjOcdEiOhQ==
X-Received: by 2002:a05:600c:45d3:b0:43c:f78d:82eb with SMTP id
 5b1f17b1804b1-43d01be665amr78800425e9.15.1741773924251; 
 Wed, 12 Mar 2025 03:05:24 -0700 (PDT)
Received: from [10.223.46.213] (99.167.185.81.rev.sfr.net. [81.185.167.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfdfdsm21124317f8f.34.2025.03.12.03.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 03:05:23 -0700 (PDT)
Message-ID: <a0b57214-ff88-4443-b3ec-fbf5ef8d4384@linaro.org>
Date: Wed, 12 Mar 2025 11:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 31/43] hw/arm: Add i.MX 8M Plus EVK board
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
 <20250225180510.1318207-32-peter.maydell@linaro.org>
 <1cdb6643-8fcc-4bd8-93fc-fcc93589c9a3@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1cdb6643-8fcc-4bd8-93fc-fcc93589c9a3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/3/25 10:40, Thomas Huth wrote:
> On 25/02/2025 19.04, Peter Maydell wrote:
>> From: Bernhard Beschow <shentey@gmail.com>
>>
>> As a first step, implement the bare minimum: CPUs, RAM, interrupt 
>> controller,
>> serial. All other devices of the A53 memory map are represented as
>> TYPE_UNIMPLEMENTED_DEVICE, i.e. the whole memory map is provided. This 
>> allows
>> for running Linux without it crashing due to invalid memory accesses.
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>> Message-id: 20250223114708.1780-5-shentey@gmail.com
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> [PMM: drop 'static const' from serial_table[] definition to avoid
>>   compile failure on GCC 7.5]
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
> ...
>> +static const TypeInfo fsl_imx8mp_types[] = {
>> +    {
>> +        .name = TYPE_FSL_IMX8MP,
>> +        .parent = TYPE_DEVICE,
>> +        .instance_size = sizeof(FslImx8mpState),
>> +        .instance_init = fsl_imx8mp_init,
>> +        .class_init = fsl_imx8mp_class_init,
>> +    },
>> +};
>> +
>> +DEFINE_TYPES(fsl_imx8mp_types)
> 
>   Hi Bernhard, hi Peter,
> 
> this device can be used to crash QEMU quite easily:
> 
> $ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
> **
> ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion 
> failed: (n < tcg_max_ctxs)
> Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: 
> assertion failed: (n < tcg_max_ctxs)
> Aborted (core dumped)
> 
> Should it maybe be marked with "user_creatable = false" to avoid this?

Correct, along with a comment to justify:

   /* Reason: SoC can only be instantiated from a board */


