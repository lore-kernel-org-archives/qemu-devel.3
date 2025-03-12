Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4C0C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJJ7-0007XB-LV; Wed, 12 Mar 2025 06:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJJ6-0007Wo-LN
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:27:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJJ2-00014m-C7
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:27:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso38943995e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741775237; x=1742380037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aZQLc0CCKOsJ1SOkOAKV41SXUFHDx3yVzWR0VtoIHr8=;
 b=C34e177zc5+OQYr1xuezLUTxZEPKslE3sUkTnlBW4T51TdcXzWZeeetGG6LaN3fFN/
 RCYQQ27ZmBBYbpYgYNHL+SRcGnIZqOfqeU0vEO65gpr++mpYFPNWmLnbHhOVXEYZMLb1
 MmCTdb6iW+gKBM66rTvSUScNvLTihVOuI/s2N43qRsWpG+v+dpvpFui1V/wt80H87yN5
 DX2EMAsMyZwCH/SmxjAVHsfyvjBASBufVVP4DrwFIzejjNHBIqa3ziaiMqLl+1So0BgS
 VYnskj4MNYiH4MGyfdrvRgHR0zvHlaJMVTjXjl9kp/yGlKaX9aMNiai3VqBUlonMnA76
 rfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741775237; x=1742380037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aZQLc0CCKOsJ1SOkOAKV41SXUFHDx3yVzWR0VtoIHr8=;
 b=HYOhiLCYEcPpd+42jtH/f8pCgD/Gkhqx0gZAjejmaKaWnH+xRBiai7hrWtzPhbYSIA
 zWhsOnSNxYGDq7gtQ1q5iu9bOSNBFk/es8SofVNtAz74JhK9mInlhnx9nj4POZx9xQDD
 48/lz8kkI+bJfqtvimvt1yy0R5Uir63fqQt/bi0TWrgoIYM3+PByMMlkO7Vf9lMaijpK
 rph3o3EZn8A9fH9f6Nu0Mkc9VbcuFGkbL45JkqkzAPUg9RAqic8qp5B6QGgzDkV+zOdC
 oK5+fEkGcA2CxE+hWyiwNEQtY+cYOyyhJJCQWXD6HQXZSG42GJBkEDcWCeibLn6+NunN
 wU6g==
X-Gm-Message-State: AOJu0Yw3ZN+SEXl8e/NyCZRjPa44an1oR5JQJgqUYkce5VudSY4OCoUT
 JI+CmnYIBQu7O4+MuxNaFDy5EHRVhGR7/BMvEeRXp5QubziQy3ZvnrICethDHiA=
X-Gm-Gg: ASbGncvtHzJhmh3qaUhVxLKe5XTBAxZitam+bHfHE0uzenmTsMzTnpYtA6DGsaSkCPU
 tipcEx5etnCOUlUAKEOKJH2f1PFkzqksdLoKCt1hED2ECFr5FDgPzZoNLJYibI4Pwt8CZRlPxfJ
 OX5JQXdFM0vs7yw5B3As3iWiCZakOWPvfAtwLZ6UKcHLJVczboacXNHsHVf9Cebq1eJuUYhy1zc
 zzm1aXWpn5nyBMc5387ztuTPqca4dUszs+TEOegOivu4+fhlcuHfMJAK++tFAqhsjdm2Jgc4e1h
 uz4wZlPRrBlxPEPbt3uMmDSESa6JTudhCv96RsijeT9gomGGHr3vM4IXjBxA/LVP41qkwoNTTYv
 haxZrxg==
X-Google-Smtp-Source: AGHT+IFU7o9oewKWb7Yy/8/oNqJNMeDLRtTUt8sAsCfJ6WQN/ofV3/UeV4+bKa53gw80S5aiTnAc3Q==
X-Received: by 2002:a05:600c:470c:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43cf051022dmr137327815e9.11.1741775237266; 
 Wed, 12 Mar 2025 03:27:17 -0700 (PDT)
Received: from [10.223.46.213] (99.167.185.81.rev.sfr.net. [81.185.167.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a74d339sm16582165e9.14.2025.03.12.03.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 03:27:16 -0700 (PDT)
Message-ID: <e7640bea-5bb7-4f4b-8614-ed8d521dd7a5@linaro.org>
Date: Wed, 12 Mar 2025 11:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 31/43] hw/arm: Add i.MX 8M Plus EVK board
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
 <20250225180510.1318207-32-peter.maydell@linaro.org>
 <1cdb6643-8fcc-4bd8-93fc-fcc93589c9a3@redhat.com>
 <CAFEAcA-JgjX2U3wQ47X5JQ2SU1yMpx=0rWkctbj40w0Xjufpmg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-JgjX2U3wQ47X5JQ2SU1yMpx=0rWkctbj40w0Xjufpmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

+ Cédric for Aspeed

On 12/3/25 11:20, Peter Maydell wrote:
> On Wed, 12 Mar 2025 at 09:40, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 25/02/2025 19.04, Peter Maydell wrote:
>>> From: Bernhard Beschow <shentey@gmail.com>
>>>
>>> As a first step, implement the bare minimum: CPUs, RAM, interrupt controller,
>>> serial. All other devices of the A53 memory map are represented as
>>> TYPE_UNIMPLEMENTED_DEVICE, i.e. the whole memory map is provided. This allows
>>> for running Linux without it crashing due to invalid memory accesses.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> Message-id: 20250223114708.1780-5-shentey@gmail.com
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> [PMM: drop 'static const' from serial_table[] definition to avoid
>>>    compile failure on GCC 7.5]
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>> ...
>>> +static const TypeInfo fsl_imx8mp_types[] = {
>>> +    {
>>> +        .name = TYPE_FSL_IMX8MP,
>>> +        .parent = TYPE_DEVICE,
>>> +        .instance_size = sizeof(FslImx8mpState),
>>> +        .instance_init = fsl_imx8mp_init,
>>> +        .class_init = fsl_imx8mp_class_init,
>>> +    },
>>> +};
>>> +
>>> +DEFINE_TYPES(fsl_imx8mp_types)
>>
>>    Hi Bernhard, hi Peter,
>>
>> this device can be used to crash QEMU quite easily:
>>
>> $ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
>> **
>> ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion failed:
>> (n < tcg_max_ctxs)
>> Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread:
>> assertion failed: (n < tcg_max_ctxs)
>> Aborted (core dumped)
>>
>> Should it maybe be marked with "user_creatable = false" to avoid this?
> 
> The bug is that this is directly inheriting from TYPE_DEVICE,
> not from TYPE_SYSBUS_DEVICE. Doing the former is almost always
> wrong, because it means the device is never reset.
> 
> (It looks like we do this wrong for other fsl SoCs too,
> but they're marked user_creatable = false.)

IIRC it is deliberately that way for the Aspeed SoCs, because
otherwise there were issue when building the multi-SoC fby35 machines
due to peripherals ending mapped in the same (sys)bus, so developers
took a lot of care to not base anything on sysbus. But maybe I'm
mis-remembering correctly, the peripherals parent could be sysbus
as long as we don't use any sysbus API to map memory regions.

